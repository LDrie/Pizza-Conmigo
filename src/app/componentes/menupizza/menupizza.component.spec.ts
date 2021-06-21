import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MenupizzaComponent } from './menupizza.component';

describe('MenupizzaComponent', () => {
  let component: MenupizzaComponent;
  let fixture: ComponentFixture<MenupizzaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MenupizzaComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(MenupizzaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
