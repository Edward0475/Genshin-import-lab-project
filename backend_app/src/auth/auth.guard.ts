import { Injectable, CanActivate, ExecutionContext, UnauthorizedException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../users/user.entity';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const authHeader = request.headers.authorization;

    // 1. Cek apakah ada header "Authorization: Bearer <token>"
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      throw new UnauthorizedException('Kamu tidak punya akses! Sertakan Bearer Token.');
    }

    // 2. Ambil token-nya saja (buang kata "Bearer ")
    const token = authHeader.split(' ')[1];

    // 3. Cocokkan token dengan database
    const user = await this.userRepository.findOne({ where: { bearer_token: token } });
    if (!user) {
      throw new UnauthorizedException('Token tidak valid atau sudah kadaluarsa!');
    }

    return true; // Jika cocok, izinkan lewat
  }
}