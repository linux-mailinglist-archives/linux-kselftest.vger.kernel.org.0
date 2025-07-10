Return-Path: <linux-kselftest+bounces-36987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D3B006DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7E03B5EE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525C0275B18;
	Thu, 10 Jul 2025 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAjcqi3/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B951275AEE;
	Thu, 10 Jul 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161499; cv=none; b=D4CbWCtJVqfIZeJ6nxJ6t23yU8G7X9yGz9Wgg8WW34jXpcsBd2t74YlhPMBvwjzeRLpWN9+9QKJGvlqhyWatLstyd91PclfFiCQJX7ou9+oFSCS0eFxjUNPpVbJEl2fY2hxIhDQcoLGSKGKS4+QzbdzISV5+3LrWyWQVGkpIXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161499; c=relaxed/simple;
	bh=SMbg/QZQA19CCgHGmkrUm3ENNSdod+XX5AR8EKjC0Ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rm/cF2mIenSIWW7P9eCvtdmjM3TVK+ijCEZ5LxStA9uhW0ZEUFiCy9LTd528ZXEbxTfeoEz0WaVACrKG012cJ8GZGKdL1GHg1NArqD2m42741jvqSAWjlioOm8ecJAmkhWbTGrKp/t6rqLX+Ms8VGH17HG6h9DrZpygwpM5tgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAjcqi3/; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40b54ee16ddso694289b6e.1;
        Thu, 10 Jul 2025 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161495; x=1752766295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Thg/YcRGWCxcUDbNpBIJmKFEPbrVlfqS0d2bmRRNzHg=;
        b=cAjcqi3/ex4LDjLCWrs1EbX8uGuR+peHKsuj4tmoh5VRsw9xVU5lnXZNHK/H9xyKcW
         0w1iAySZmxfZAqC4CBHolXhLb2Tl7QNPPs3LYSd3YiBLB+PBE9u7uuCSay0gSYPSWZLj
         EU4KS+oPAl145IFK208Cf8ErApA3zLCRkF7OwQWqP4NM1IKa8fRc7HUBUY2F7mK0ZtHJ
         v977APnyZKhkn4svVhM7Tz4Uz76IfpyI0llZw3AfNne+opUOIwIb3XZNYESHb3VY/ce1
         NbVlqIjDOVaUihab7oAdrnpdmFeEfH4O50nkJlLfJ5HIIiHiypuGQdyC7O/yr/XQFlP2
         9ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161495; x=1752766295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Thg/YcRGWCxcUDbNpBIJmKFEPbrVlfqS0d2bmRRNzHg=;
        b=MGLTQS3bL28bpSrwasBH3WvhkjFvpHrCdd3HdLdSq1w3vntwGsjzRkwfVYREpbbF41
         9258jY3GfiM09vTOIhTWiWNHIUuFlR65p9snfPJOizTl6tsMttWr8B9JQlSlbz0wz9n5
         m9YR5OQQP2yLnumEFU5a/78SOFN9Q+TkunGGT1OFB+TqrpzQ4Z809E84Hd5lu6OKpuUa
         gh02HYbrNLAn5QHQVBx+3BKxA78bakveHMXJ/gcMKT07pqxXXfx4Ai7v9F73PD984vat
         LPS2S7orDukSmCVB8HwuTBwu87ANSeZXguTblrLxy0FG5bKJUrFmdCE5nZms+M1wHu/P
         QiiA==
X-Forwarded-Encrypted: i=1; AJvYcCUXSL4d3dmyXPKTt1HcwKDFlEXT9DTKHAO50h9kWR+sZxbmzaahCzx3HMR+NJ0pQWuiksr6dMoOZSz4@vger.kernel.org, AJvYcCUqsKxPkRUpEajexkkNs1n7ODwMsDkV3EQv8khURI/7WPVAeRggFh634mcBpmL/HOPiwpr8QBPW@vger.kernel.org, AJvYcCV69gVEXfIOPiWrOBtamIgMl/VIA4BWGLfj4cI3MrjkNcu3XYn2JftvHEdLm2GC6l6+2Fpwyp4xo3lZfP6rG6/9@vger.kernel.org, AJvYcCVHvpzhTE9ZuEnBT0/QXK41ZcKMP5xprqk8vMXTHMy7SCglxRaXPmpTMk1K79Qv5UsVwX41uYoyhebaY8y4EqY=@vger.kernel.org, AJvYcCW4hpdm1vDJL4iDQa7Yt8YJYaQbRQ9BqGiZ4Si8Tk4sT3OoMoPakWXDdmLrBAkgsDtjpOnYGHSu6Q36pw==@vger.kernel.org, AJvYcCWN2jljhnZEIp0OKSDSKMiG2GKyWX5tHE0KUoUaareabeGCwdTSAu7DqTWEFP3zMhULa9yXHujjcda3@vger.kernel.org, AJvYcCXp7STKLrHTUU+SKu8BaHKqAASMoAI0folcTQrz0HNVHoOjp0l0+JEwypLlCJHpk0+qDyc18JxJ9j9Ql/2J@vger.kernel.org
X-Gm-Message-State: AOJu0YxrU8XBrDUJUeFwutexqmt1I4gcXf8nFUizdjOYtt/Msb87XDwx
	gs8AvAGdI08d7Cl7y3XpL9sTIAwSghNQgMv+2HGVozlY5dcT4v9TUCHJ
X-Gm-Gg: ASbGncu5W5+M/Pi7zliDGBGNP2xSLXMThqzztS5t3OtXneqf/EvMKHeuJL9igRdeRoL
	VeX6PdrNranpN+KtJEJVolNKHmPJVgCQ9GASKGryNrnekv6U+ykA50eia4TNkaxZx5M7jtKFK8U
	D0yUKtWtdjM3dt4NsqQwQnzkQwrklSnldogi22heBFWTEF2T3cX/iqCJJFnyxLOpCY4T2Pe8gfn
	vEpz9mj3pBXle0CR0j/niSZC/39yg+THuwvxm5Ql7diylQsONIA0QL6vLkUbA8wEaS7+D8IiQ0W
	kcHdGm2ehY71Ub80IP1U+U3TeoCRjARy9MXygib4ALj7SU5pP3vkPTSvO7OrIOeGQgeTt4C7BGr
	ukmFnk8YnSqaNLY/aq5XbU2o99EignmqbfdqKCTBLznlBgl/0HiHQ3yPqdw==
X-Google-Smtp-Source: AGHT+IFCEP/L3bXBqs/Es3rdbPAg2su8LejciUhcU1gz4fMvPZB8zY7ZN8+0SGHQrEiHpdqhCeVpUg==
X-Received: by 2002:a05:6808:1689:b0:3f9:36ec:dab3 with SMTP id 5614622812f47-413ac356179mr2847725b6e.14.1752161495338;
        Thu, 10 Jul 2025 08:31:35 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:34 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:04 -0400
Subject: [PATCH 01/17] drivers: net: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-1-027420ea799e@gmail.com>
References: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
In-Reply-To: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161489; l=3319;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=SMbg/QZQA19CCgHGmkrUm3ENNSdod+XX5AR8EKjC0Ng=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN3w5ONsQPO4V7WoDPlzbqmPUAfhN5mJcoMl5G7WybG2qCB9U5TBgYrxU4+N1jE5/MMqUyoMUTi
 8t9YDb9Lcwws=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/net/phy/ax88796b_rust.rs | 7 +++----
 drivers/net/phy/qt2025.rs        | 5 ++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index bc73ebccc2aa..2d24628a4e58 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -5,7 +5,6 @@
 //!
 //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
 use kernel::{
-    c_str,
     net::phy::{self, reg::C22, DeviceId, Driver},
     prelude::*,
     uapi,
@@ -41,7 +40,7 @@ fn asix_soft_reset(dev: &mut phy::Device) -> Result {
 #[vtable]
 impl Driver for PhyAX88772A {
     const FLAGS: u32 = phy::flags::IS_INTERNAL;
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
+    const NAME: &'static CStr = c"Asix Electronics AX88772A";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_exact_mask(0x003b1861);
 
     // AX88772A is not working properly with some old switches (NETGEAR EN 108TP):
@@ -105,7 +104,7 @@ fn link_change_notify(dev: &mut phy::Device) {
 #[vtable]
 impl Driver for PhyAX88772C {
     const FLAGS: u32 = phy::flags::IS_INTERNAL;
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88772C");
+    const NAME: &'static CStr = c"Asix Electronics AX88772C";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_exact_mask(0x003b1881);
 
     fn suspend(dev: &mut phy::Device) -> Result {
@@ -125,7 +124,7 @@ fn soft_reset(dev: &mut phy::Device) -> Result {
 
 #[vtable]
 impl Driver for PhyAX88796B {
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88796B");
+    const NAME: &'static CStr = c"Asix Electronics AX88796B";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_model_mask(0x003b1841);
 
     fn soft_reset(dev: &mut phy::Device) -> Result {
diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 0b9400dcb4c1..9ccc75f70219 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -9,7 +9,6 @@
 //!
 //! The QT2025 PHY integrates an Intel 8051 micro-controller.
 
-use kernel::c_str;
 use kernel::error::code;
 use kernel::firmware::Firmware;
 use kernel::net::phy::{
@@ -36,7 +35,7 @@
 
 #[vtable]
 impl Driver for PhyQT2025 {
-    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
+    const NAME: &'static CStr = c"QT2025 10Gpbs SFP+";
     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043a400);
 
     fn probe(dev: &mut phy::Device) -> Result<()> {
@@ -69,7 +68,7 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
         // The micro-controller will start running from the boot ROM.
         dev.write(C45::new(Mmd::PCS, 0xe854), 0x00c0)?;
 
-        let fw = Firmware::request(c_str!("qt2025-2.0.3.3.fw"), dev.as_ref())?;
+        let fw = Firmware::request(c"qt2025-2.0.3.3.fw", dev.as_ref())?;
         if fw.data().len() > SZ_16K + SZ_8K {
             return Err(code::EFBIG);
         }

-- 
2.50.0


