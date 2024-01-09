import { vec3, mix, sin, timerLocal } from "three/examples/jsm/nodes/Nodes";

export const MixNode = (shader: any) => {

    let vec: {a: number, b:number, c:number} = shader ? shader.color.color_one : {a:0, b:0, c:0}; 
    let color_one = vec3(vec.a/255, vec.b/255, vec.c/255 );
    vec = shader ? shader.color.color_two : {a:0, b:0, c:0};
    
    const time = timerLocal(0.5)

    let color_two = vec3(vec.a/255, vec.b/255, vec.c/255 );

    let color = mix(color_one, color_two, sin(time))
    return color;
}

