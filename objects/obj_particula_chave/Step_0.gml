//deixando transparente e se destruindo.
image_alpha -= 0.01;

if(image_alpha < 0)
{
    instance_destroy();
}