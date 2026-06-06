import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Weapon } from './weapons/weapon.entity';
import { User } from './users/user.entity'; // Import file User yang baru dibuat
import { WeaponsModule } from './weapons/weapons.module';
import { AuthModule } from './auth/auth.module'; // Otomatis dibuat oleh NestJS
import { UsersModule } from './users/users.module'; // Otomatis dibuat oleh NestJS

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: 'localhost',
      port: 3306,
      username: 'root',
      password: '',
      database: 'genshin_import',
      entities: [Weapon, User], // Tambahkan User di sini
      synchronize: false,
    }),
    WeaponsModule,
    AuthModule,
    UsersModule,
  ],
})
export class AppModule {}