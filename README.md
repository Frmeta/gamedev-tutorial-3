## Tutorial 3 Gamedev

Fitur tambahan yang saya kerjakan:
- Double Jump
  
  Membuat variable `jump_count` yang awalnya bernilai 0 kemudian pada method get_input() ditambahkan kode berikut
    ```gdscript
    if is_on_floor():
      jump_count = 1
    
    if Input.is_action_just_pressed("ui_up"):
      if is_on_floor():
        jump_count = 2
        
      if jump_count > 0:
        jump_count -= 1
        velocity.y = jump_speed
    ```
- Dashing & flip sprite ketika bergerak ke kanan/kiri

  Menambah kode berikut untuk melakukan dash ketika terdeteksi menekan tombol kiri atau kanan sebanyak dua kali dalam waktu cepat
  ```gdscript
  if Input.is_action_just_pressed('ui_right'):
    delay_left = 0
    $SpriteParent/Sprite.flip_h = false
    if (delay_right > 0):
      delay_right = 0
      velocity.x += speed * 10
    else:
      delay_right = delay_press_twice
				
  if Input.is_action_just_pressed('ui_left'):
    delay_right = 0
    $SpriteParent/Sprite.flip_h = true
    if (delay_left > 0):
      delay_left = 0
      velocity.x -= speed * 10
    else:
      delay_left = delay_press_twice
      
  if Input.is_action_pressed('ui_right'):
    velocity.x += speed
    
  if Input.is_action_pressed('ui_left'):
    velocity.x -= speed
  ```
- Crouching

  Mendeteksi input tombol panah bawah dan player harus berada pada ground
  ```gdscript
  if is_on_floor() and Input.is_action_pressed("ui_down"):
		$SpriteParent.scale.y = 0.9
		$SpriteParent/Sprite.play("crouch")
  ```
  
- Animation

  Mengganti node Sprite menjadi AnimatedSprite untuk mempermudah implementasi animasi dan memasukkan kode berikut
  ```gdscript
  if not is_on_floor():
    if velocity.y > 5:
      $SpriteParent/Sprite.play("fall")
    else:
      $SpriteParent/Sprite.play("jump")
  elif velocity.x == 0:
    $SpriteParent/Sprite.play("idle")
  else:
    $SpriteParent/Sprite.play("walk")
  ```

## Tutorial 5
Proses pengerjaan Tutorial 5:
- pertama saya membuat satu objek baru di dalam permainan berupa animasi enemy 'Skull'. Caranya mendownload spritesheet dari itch.io kemudian membuat `Animated Sprite` dan add frames from Spritesheet.
![Skull Idle Spritesheet](/Idle%201%20(52x54).png)
- Saya menambahkan suara baru: jump ketika meloncat, land ketika mendarat, dan explosion ketika mendorong enemy. Saya menggunakan AudioStreamPlayer untuk mengeluarkan SFX tersebut
- Selain itu saya juga menambahkan background music menggunakan AudioStreamPlayer
- Terakhir saya membuat radio yang terdengar suara apabila player mendekati radio tersebut menggunakan AudioStreamPlayer2D