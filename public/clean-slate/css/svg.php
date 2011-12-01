<?php
header("Content-Type: image/svg+xml");
?>
<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="100%" height="100%">
        <defs>
                <linearGradient id="linear-gradient" x1="0%" y1="0%" x2="0%" y2="100%">
                        <stop offset="0%" stop-color="<?=isset($_GET["from"])? $_GET["from"] : "#FFF"?>" stop-opacity="1"/>
                        <stop offset="100%" stop-color="<?=isset($_GET["to"])? $_GET["to"] : "#FFF"?>" stop-opacity="1"/>
                </linearGradient>
        </defs>
        <rect width="100%" height="100%" fill="url(#linear-gradient)"/>
</svg>