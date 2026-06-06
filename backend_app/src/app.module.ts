import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Weapon } from './weapons/weapon.entity';
import { User } from './users/user.entity'; // Import file User yang baru dibuat
import { WeaponsModule } from './weapons/weapons.module';
import { AuthModule } from './auth/auth.module'; // Otomatis dibuat oleh NestJS
import { UsersModule } from './users/users.module'; // Otomatis dibuat oleh NestJS
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }), // Tambahkan ini paling atas
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: process.env.DB_HOST,
      port: Number(process.env.DB_PORT),
      username: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      entities: [Weapon, User],
      synchronize: false,
    }),
    // ... modul lainnya
  ],
})
export class AppModule {}