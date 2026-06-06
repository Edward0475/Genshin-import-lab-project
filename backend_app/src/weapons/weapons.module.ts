import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { WeaponsService } from './weapons.service';
import { WeaponsController } from './weapons.controller';
import { Weapon } from './weapon.entity';
import { UsersModule } from '../users/users.module'; // Tambahkan baris ini

@Module({
  imports: [
    TypeOrmModule.forFeature([Weapon]),
    UsersModule // Tambahkan ini agar AuthGuard bisa baca tabel users
  ], 
  providers: [WeaponsService],
  controllers: [WeaponsController],
})
export class WeaponsModule {}