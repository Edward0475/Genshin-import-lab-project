import { Controller, Get, Post, Put, Delete, Body, Param } from '@nestjs/common';
import { WeaponsService } from './weapons.service';
import { Weapon } from './weapon.entity';

@Controller('weapons') // Ini yang membuat URL menjadi /weapons
export class WeaponsController {
  constructor(private readonly weaponsService: WeaponsService) {}

  @Get()
  findAll() {
    return this.weaponsService.findAll(); // Memanggil fungsi GET
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.weaponsService.findOne(+id);
  }

  @Post()
  create(@Body() weaponData: Partial<Weapon>) {
    return this.weaponsService.create(weaponData);
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() updateData: Partial<Weapon>) {
    return this.weaponsService.update(+id, updateData);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.weaponsService.remove(+id);
  }
}