import { Injectable, UnauthorizedException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../users/user.entity';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
  ) {}

  // ALGORITMA TOKEN: Menghasilkan 20 karakter alfanumerik acak
  private generateBearerToken(): string {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    let token = '';
    for (let i = 0; i < 20; i++) {
      token += chars[Math.floor(Math.random() * chars.length)];
    }
    return token;
  }

  // FITUR REGISTER
  async register(userData: Partial<User>): Promise<any> {
    const existingUser = await this.userRepository.findOne({ where: { email: userData.email } });
    if (existingUser) {
      throw new BadRequestException('Email sudah terdaftar!');
    }

    // Mengacak/melindungi password sebelum masuk ke database XAMPP
    const hashedPassword = await bcrypt.hash(userData.password, 10);
    const newUser = this.userRepository.create({
      ...userData,
      password: hashedPassword,
    });
    
    await this.userRepository.save(newUser);
    return { message: 'Registrasi berhasil! Silakan login.' };
  }

  // FITUR LOGIN
  async login(email: string, pass: string): Promise<any> {
    const user = await this.userRepository.findOne({ where: { email } });
    if (!user) {
      throw new UnauthorizedException('Email atau password salah');
    }

    const isMatch = await bcrypt.compare(pass, user.password);
    if (!isMatch) {
      throw new UnauthorizedException('Email atau password salah');
    }

    // Jika sukses, buat token, simpan ke tabel users, lalu kirim ke HP
    const token = this.generateBearerToken();
    user.bearer_token = token;
    await this.userRepository.save(user);

    return {
      message: 'Login sukses',
      bearer_token: token,
      user_id: user.id
    };
  }
}