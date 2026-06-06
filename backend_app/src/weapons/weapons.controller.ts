import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards } from '@nestjs/common';
import { WeaponsService } from './weapons.service';
import { Weapon } from './weapon.entity';
import { AuthGuard } from '../auth/auth.guard'; // Import satpam kita

@Controller('weapons')
export class WeaponsController {
  constructor(private readonly weaponsService: WeaponsService) {}

  // GET: Bebas diakses siapa saja (tanpa gembok)
  @Get()
  findAll() {
    return this.weaponsService.findAll();
  }

  // GET: Bebas diakses siapa saja
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.weaponsService.findOne(+id);
  }

  // POST: DIKUNCI! Wajib pakai Token
  @UseGuards(AuthGuard)
  @Post()
  create(@Body() weaponData: Partial<Weapon>) {
    return this.weaponsService.create(weaponData);
  }

  // PUT: DIKUNCI! Wajib pakai Token
  @UseGuards(AuthGuard)
  @Put(':id')
  update(@Param('id') id: string, @Body() updateData: Partial<Weapon>) {
    return this.weaponsService.update(+id, updateData);
  }

  // DELETE: DIKUNCI! Wajib pakai Token
  @UseGuards(AuthGuard)
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.weaponsService.remove(+id);
  }
}