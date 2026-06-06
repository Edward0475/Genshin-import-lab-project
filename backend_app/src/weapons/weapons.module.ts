import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { WeaponsService } from './weapons.service';
import { WeaponsController } from './weapons.controller';
import { Weapon } from './weapon.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Weapon])], // Menghubungkan ke tabel weapons
  providers: [WeaponsService],
  controllers: [WeaponsController],
})
export class WeaponsModule {}