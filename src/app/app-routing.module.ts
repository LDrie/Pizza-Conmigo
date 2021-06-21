import { NgModule, Component } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './componentes/home/home.component';
import { ImagenesComponent } from './componentes/imagenes/imagenes.component';
import { ContactoComponent } from './componentes/contacto/contacto.component';
import { MenupizzaComponent } from './componentes/menupizza/menupizza.component'

const routes: Routes = [
  {path: 'home', component: HomeComponent},
  {path: 'imagenes', component: ImagenesComponent},
  {path: 'contacto', component: ContactoComponent},
  {path: 'menupizza', component: MenupizzaComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
