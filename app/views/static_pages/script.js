import * as THREE from "https://cdn.jsdelivr.net/npm/three@0.114/build/three.module.js"



  // Scene
  const scene = new THREE.Scene()
  
  // Red Cube
  const geometry = new THREE.BoxGeometry(1, 1, 1)
  const material = new THREE.MeshBasicMaterial({ color: 0xff0000 })
  const mesh = new THREE.Mesh(geometry, material)
  scene.add(mesh)
  
  // Sizes
  const sizes = {
    width: window.innerWidth-100,
    height: window.innerHeight
}
window.addEventListener('resize', () =>
{
    // Update sizes
    sizes.width = window.innerWidth
    sizes.height = window.innerHeight

    // Update camera
    camera.aspect = sizes.width / sizes.height
    camera.updateProjectionMatrix()

    // Update renderer
    renderer.setSize(sizes.width, sizes.height)
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
})
  
  // Camera
  const camera = new THREE.PerspectiveCamera(75, sizes.width / sizes.height)
  camera.position.z = 3
  scene.add(camera)
  
  // Renderer
  const canvas = document.querySelector('.webgl')
  const renderer = new THREE.WebGLRenderer({
      canvas: canvas
  })
  
  renderer.setSize(sizes.width, sizes.height)
  renderer.render(scene, camera)
  const tick = () =>
{
    const elapsedTime = clock.getElapsedTime()


    // Render
    renderer.render(scene, camera)

    // Call tick again on the next frame
    window.requestAnimationFrame(tick)
}

tick()