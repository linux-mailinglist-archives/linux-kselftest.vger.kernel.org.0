Return-Path: <linux-kselftest+bounces-34054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F34AC8DA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 14:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942CBA2483A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B342D22F768;
	Fri, 30 May 2025 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI7KLqy6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C2522E3E0;
	Fri, 30 May 2025 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608084; cv=none; b=ADGJHKt4hL+u4In4GCg4sQCWfJoOV835eS+q3WyiXxge5SufFu2XPe4tAVIKC51zHiVXMe8WEd5hwKQJhaErnkDvbz9t+kyJ9pnkETNvX37nDjLBcxKkfT98zDCE4Z62bt8GYwtv5Ipj1hrZKs3tf47IW5aLoUHV7o2LDzoYAzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608084; c=relaxed/simple;
	bh=WakuJQOnZgcMfeJvLyxbd1RbJBMui0HPPVXLR+Hbsdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GOjgyIbgPMOZsOPH7HBLckJG8QQrwJ6FRClLcF5F6LJzIAAlcB9DyQUIqet8Gco6sb6Xs5jNFeoduSdXSsBCBN4I9/0KH9hJqZqBNCLSLdgYRFiiexk96NHlduG++aVqgphnc7/YgW+s9xh++K481bbazpJqTu1xETlEgneG+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TI7KLqy6; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4769bbc21b0so20317041cf.2;
        Fri, 30 May 2025 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748608080; x=1749212880; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeM+z+DHkAQcdW3Yn2QwEqQNNlIJjISRwSMBuKcIOig=;
        b=TI7KLqy6WqjLqBshlO28SFHkwz/J9xF9NRhY+4xYS17vL7VXE58s302+oMuqGfb0/s
         F5TON2wTn1H2ephM+FrN2LgELuQmLfCVhpZP/W3CpBF/JidN7n6NarBNbk8jVoCT/dsR
         G8k0UjzGrpeVJ+pTU95uT7YbFjR5s3h7zaTv6Wt2xQs4M4EyOmrxI5WaRtMhwAKIZov1
         Yse/XSAY/dza3XBEv9wuE8+x5VtfN9V1ZD+K5KGVp3wcy9xXdXyVvr5KVhpraM84V/UZ
         6In1L7wsYKvYq9zFn2p3anZSU4mn/CU3l1JDl+wu2W63CffN9ZobbnwmuchaZmU/zeMz
         cmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748608080; x=1749212880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeM+z+DHkAQcdW3Yn2QwEqQNNlIJjISRwSMBuKcIOig=;
        b=TC7wereKALZTxkqMH3LJz1Bh5JyA8ftLCe6e0DXYELq3fi/XvtrDjI/L34NAR5iLKA
         nMz1YsZ6MFfpxjioK1QGdNUI2tmdcWZqrcNosLta/bnFTcrHlk2/mntI8e1dzGRpgfGF
         qC7L2Kxsc8Dcm/l9Cl/JNTuazhDNG7et/cnzA4u+67go3Hsk+hKXJPs0JpiS7TSql2Z9
         fQoYVjE1gcv4I7Wvmrz52l6udSdOHeMnEUrH7r/EFNXJcwxaImacCi2Yy7R3X58P+sTk
         Cyvc2GF82AVz/PGfkzCYqZv9wOVASZRAaz/pbUwWNIJh0Lk/HjJqXwIRPNrcp2DAGp+e
         pfWg==
X-Forwarded-Encrypted: i=1; AJvYcCUoopv+TwRrq9J7Cqy7YSVmIDNM6GI1vQFLHJfEyFkwebomX3wgX3tQuq86K0ne+c1E38Zf/WoaXNN7Xt20@vger.kernel.org, AJvYcCW/UY4w03z0wYMkdxWjOQJQFmIeiRwLRes4sUYkNascpLObs1YjamYChbnYRaxNMhR4L9cOPQzH//4n@vger.kernel.org, AJvYcCWCo38if4uPS7ivAFK6DFGlqPCCF84Xbsrov7zsm73bMy4VNs2tMlyrHOa2WJys918qK6xPVIu5lwzTqSU=@vger.kernel.org, AJvYcCWVpB706+H6pic6Vy0XqRtThhdAQKuuVCIHGzTnhCR+rjjGb0InkruRQJw3I9w4jZyfSLeVWjdin5GR@vger.kernel.org, AJvYcCWeSVTnrjmScosFrBCbISfAgC8QCw7Wctf49LjiQOrM0hriuCuLO1xGcKN8BiqbEvadq1yuJAJ14bOqC7bg1G1v@vger.kernel.org, AJvYcCXLL4/ZXPZhFWjOI84mPUVlPv/QlK5/GvisFAUjdZAvxkxgdZQdw1jQGq0uDE+3SmpLcIAmUuVc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xmlhHYGI53bsXdLGsZZTRO1YKL9lZHxNE9HbfHz7vCFY8nHO
	SIgFT19eMUvT14Cctvw9suNf9GrE8VTqaVIaikmuTkxDnQMlR2/BtfDd
X-Gm-Gg: ASbGncuKyIoLdHozuuXwZrHDkHn/SBjw3co3tBOYZ0QcTmik1PfeMURkzTg09+kOAxb
	cuyCjUgn7PA6iX+J0h0rOaHRGPtfGFsh3OSNRaRdVrKagwFXnxN4RsPlmm5DgsFBRV+gj64jXjH
	QjB+xw0hKwTN6XawajTi6UVxrqrZx8PiW0CK3lT9FIep3EHmC5kRwEczYlNurGFfs68FWYunIwg
	3oBhtDvF5sS0Cd42ODdj6UjAgWgi3QwXJjrculXlZlIgHI7qmyVaOmyUEx2A8Bw5kwhjtT+yiy9
	bW72G7JYm/xKlZ9HslId+lECWHndBbUh0OFbvpHUe/s7XgO2/CRHgZfM59OQdFxJAqYUNMS+d1j
	AiftGWzmvbCdRoM+PmQPdQ4tSFKcLixeDhy/FMVpswLVGlD57ADFTmlQLiL0r
X-Google-Smtp-Source: AGHT+IFgnz6wQ1Z0Zt9nypbcaxCPKG1C/QLzpRFl1Jd4PIw3zkKTqlNyLnL/j32cR9DHzl+EGiXsKg==
X-Received: by 2002:a05:622a:4816:b0:490:8cc3:d111 with SMTP id d75a77b69052e-4a4400549c0mr61016841cf.27.1748608079313;
        Fri, 30 May 2025 05:27:59 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:fbe8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358ad334sm19700201cf.27.2025.05.30.05.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 05:27:57 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 30 May 2025 08:27:45 -0400
Subject: [PATCH v11 4/5] rust: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250530-cstr-core-v11-4-cd9c0cbcb902@gmail.com>
References: <20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com>
In-Reply-To: <20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com>
To: Michal Rostecki <vadorovsky@protonmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible and rename
`kernel::c_str!` to `str_to_cstr!` to clarify its intended use.

Closes: https://github.com/Rust-for-Linux/linux/issues/1075
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/block/rnull.rs               |  2 +-
 drivers/gpu/nova-core/driver.rs      |  2 +-
 drivers/net/phy/ax88796b_rust.rs     |  7 +++----
 drivers/net/phy/qt2025.rs            |  5 ++---
 rust/kernel/devres.rs                |  2 +-
 rust/kernel/firmware.rs              |  6 +++---
 rust/kernel/kunit.rs                 |  7 ++++---
 rust/kernel/net/phy.rs               |  6 ++----
 rust/kernel/platform.rs              |  4 ++--
 rust/kernel/str.rs                   | 24 ++++++++++++++++--------
 rust/kernel/sync.rs                  |  7 +++----
 rust/kernel/sync/lock/global.rs      |  3 ++-
 rust/kernel/workqueue.rs             |  8 ++++----
 rust/macros/kunit.rs                 | 10 +++++-----
 rust/macros/module.rs                |  2 +-
 samples/rust/rust_driver_faux.rs     |  4 ++--
 samples/rust/rust_driver_pci.rs      |  4 ++--
 samples/rust/rust_driver_platform.rs |  4 ++--
 samples/rust/rust_misc_device.rs     |  3 +--
 scripts/rustdoc_test_gen.rs          |  4 ++--
 20 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index 6366da12c5a5..9aa79b862b63 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -55,7 +55,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         })();
 
         try_pin_init!(Self {
-            _disk <- new_mutex!(disk?, "nullb:disk"),
+            _disk <- new_mutex!(disk?, c"nullb:disk"),
         })
     }
 }
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index a08fb6599267..776970049974 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -33,7 +33,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
         pdev.enable_device_mem()?;
         pdev.set_master();
 
-        let bar = pdev.iomap_region_sized::<BAR0_SIZE>(0, c_str!("nova-core/bar0"))?;
+        let bar = pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?;
 
         let this = KBox::pin_init(
             try_pin_init!(Self {
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
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index ddb1ce4a78d9..8735b227f0d3 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -45,7 +45,7 @@ struct DevresInner<T> {
 /// # Example
 ///
 /// ```no_run
-/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::{Io, IoRaw}};
+/// # use kernel::{bindings, device::Device, devres::Devres, io::{Io, IoRaw}};
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 582ab648b14c..09fd3a27bcf0 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -51,13 +51,13 @@ fn request_nowarn() -> Self {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{c_str, device::Device, firmware::Firmware};
+/// # use kernel::{device::Device, firmware::Firmware};
 ///
 /// # fn no_run() -> Result<(), Error> {
 /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
 /// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
 ///
-/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
+/// let fw = Firmware::request(c"path/to/firmware.bin", &dev)?;
 /// let blob = fw.data();
 ///
 /// # Ok(())
@@ -203,7 +203,7 @@ macro_rules! module_firmware {
     ($($builder:tt)*) => {
         const _: () = {
             const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr = if cfg!(MODULE) {
-                $crate::c_str!("")
+                c""
             } else {
                 <LocalModule as $crate::ModuleMetadata>::NAME
             };
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 4927aa0b656e..2bab61910f1e 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -57,9 +57,10 @@ macro_rules! kunit_assert {
                 break 'out;
             }
 
-            static FILE: &'static $crate::str::CStr = $crate::c_str!($file);
+            static FILE: &'static $crate::str::CStr = $file;
             static LINE: i32 = ::core::line!() as i32 - $diff;
-            static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
+            static CONDITION: &'static $crate::str::CStr =
+                $crate::str_to_cstr!(stringify!($condition));
 
             // SAFETY: FFI call without safety requirements.
             let kunit_test = unsafe { $crate::bindings::kunit_get_current_test() };
@@ -246,7 +247,7 @@ pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
 /// }
 ///
 /// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] = [
-///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
+///     kernel::kunit::kunit_case(c"name", test_fn),
 ///     kernel::kunit::kunit_case_null(),
 /// ];
 /// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 652e060e47bd..8129419a3931 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -780,7 +780,6 @@ const fn as_int(&self) -> u32 {
 ///
 /// ```
 /// # mod module_phy_driver_sample {
-/// use kernel::c_str;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -799,7 +798,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// #[vtable]
 /// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c_str!("PhySample");
+///     const NAME: &'static CStr = c"PhySample";
 ///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
 /// }
 /// # }
@@ -808,7 +807,6 @@ const fn as_int(&self) -> u32 {
 /// This expands to the following code:
 ///
 /// ```ignore
-/// use kernel::c_str;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -828,7 +826,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// #[vtable]
 /// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c_str!("PhySample");
+///     const NAME: &'static CStr = c"PhySample";
 ///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
 /// }
 ///
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index a02ae5b25b74..65916b5936e6 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -124,7 +124,7 @@ macro_rules! module_platform_driver {
 /// # Example
 ///
 ///```
-/// # use kernel::{bindings, c_str, device::Core, of, platform};
+/// # use kernel::{bindings, device::Core, of, platform};
 ///
 /// struct MyDriver;
 ///
@@ -133,7 +133,7 @@ macro_rules! module_platform_driver {
 ///     MODULE_OF_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
 ///     [
-///         (of::DeviceId::new(c_str!("test,device")), ())
+///         (of::DeviceId::new(c"test,device"), ())
 ///     ]
 /// );
 ///
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index f8164fd23f61..ff5ae125be0d 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -266,15 +266,14 @@ impl fmt::Display for crate::fmt::Adapter<&CStr> {
     /// Formats printable ASCII characters, escaping the rest.
     ///
     /// ```
-    /// # use kernel::c_str;
     /// # use kernel::prelude::fmt;
     /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
-    /// let penguin = c_str!("🐧");
+    /// let penguin = c"🐧";
     /// let s = CString::try_from_fmt(fmt!("{}", penguin))?;
     /// assert_eq!(s.to_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
     ///
-    /// let ascii = c_str!("so \"cool\"");
+    /// let ascii = c"so \"cool\"";
     /// let s = CString::try_from_fmt(fmt!("{}", ascii))?;
     /// assert_eq!(s.to_bytes_with_nul(), "so \"cool\"\0".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
@@ -365,19 +364,28 @@ fn as_ref(&self) -> &BStr {
     }
 }
 
-/// Creates a new [`CStr`] from a string literal.
+/// Creates a static C string wrapper at compile time.
 ///
-/// The string literal should not contain any `NUL` bytes.
+/// Rust supports C string literals since Rust 1.77, and they should be used instead of this macro
+/// where possible. This macro exists to allow static *non-literal* C strings to be created at
+/// compile time. This is most often used in other macros.
+///
+/// # Panics
+///
+/// This macro panics if the operand contains an interior `NUL` byte.
 ///
 /// # Examples
 ///
 /// ```
-/// # use kernel::c_str;
+/// # use kernel::str_to_cstr;
 /// # use kernel::str::CStr;
-/// const MY_CSTR: &CStr = c_str!("My awesome CStr!");
+/// const MY_CSTR: &CStr = str_to_cstr!(concat!(file!(), ":", line!(), ": My CStr!"));
 /// ```
 #[macro_export]
-macro_rules! c_str {
+macro_rules! str_to_cstr {
+    // NB: we could write `($str:lit) => compile_error!("use a C string literal instead");` here but
+    // that would trigger when the literal is at the top of several macro expansions. That would be
+    // too limiting to macro authors, so we rely on the name as a hint instead.
     ($str:expr) => {{
         const S: &str = concat!($str, "\0");
         const C: &$crate::str::CStr = match $crate::str::CStr::from_bytes_with_nul(S.as_bytes()) {
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 36a719015583..e38629147f42 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -41,7 +41,6 @@ impl LockClassKey {
     ///
     /// # Example
     /// ```
-    /// # use kernel::c_str;
     /// # use kernel::alloc::KBox;
     /// # use kernel::types::ForeignOwnable;
     /// # use kernel::sync::{LockClassKey, SpinLock};
@@ -53,7 +52,7 @@ impl LockClassKey {
     /// {
     ///     stack_pin_init!(let num: SpinLock<u32> = SpinLock::new(
     ///         0,
-    ///         c_str!("my_spinlock"),
+    ///         c"my_spinlock",
     ///         // SAFETY: `key_ptr` is returned by the above `into_foreign()`, whose
     ///         // `from_foreign()` has not yet been called.
     ///         unsafe { <Pin<KBox<LockClassKey>> as ForeignOwnable>::borrow(key_ptr) }
@@ -106,9 +105,9 @@ macro_rules! static_lock_class {
 #[macro_export]
 macro_rules! optional_name {
     () => {
-        $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::line!()))
+        $crate::str_to_cstr!(::core::concat!(::core::file!(), ":", ::core::line!()))
     };
     ($name:literal) => {
-        $crate::c_str!($name)
+        $name
     };
 }
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index 79d0ef7fda86..9caa9b419f09 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -267,7 +267,8 @@ macro_rules! global_lock {
         $pub enum $name {}
 
         impl $crate::sync::lock::GlobalLockBackend for $name {
-            const NAME: &'static $crate::str::CStr = $crate::c_str!(::core::stringify!($name));
+            const NAME: &'static $crate::str::CStr =
+                $crate::str_to_cstr!(::core::stringify!($name));
             type Item = $valuety;
             type Backend = $crate::global_lock_inner!(backend $kind);
 
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index d092112d843f..dbec533fd31f 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -51,7 +51,7 @@
 //!     fn new(value: i32) -> Result<Arc<Self>> {
 //!         Arc::pin_init(pin_init!(MyStruct {
 //!             value,
-//!             work <- new_work!("MyStruct::work"),
+//!             work <- new_work!(c"MyStruct::work"),
 //!         }), GFP_KERNEL)
 //!     }
 //! }
@@ -98,8 +98,8 @@
 //!         Arc::pin_init(pin_init!(MyStruct {
 //!             value_1,
 //!             value_2,
-//!             work_1 <- new_work!("MyStruct::work_1"),
-//!             work_2 <- new_work!("MyStruct::work_2"),
+//!             work_1 <- new_work!(c"MyStruct::work_1"),
+//!             work_2 <- new_work!(c"MyStruct::work_2"),
 //!         }), GFP_KERNEL)
 //!     }
 //! }
@@ -215,7 +215,7 @@ pub fn try_spawn<T: 'static + Send + FnOnce()>(
         func: T,
     ) -> Result<(), AllocError> {
         let init = pin_init!(ClosureWork {
-            work <- new_work!("Queue::try_spawn"),
+            work <- new_work!(c"Queue::try_spawn"),
             func: Some(func),
         });
 
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index 81d18149a0cc..c64df1a01b9d 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -89,8 +89,8 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     // unsafe extern "C" fn kunit_rust_wrapper_bar(_test: *mut ::kernel::bindings::kunit) { bar(); }
     //
     // static mut TEST_CASES: [::kernel::bindings::kunit_case; 3] = [
-    //     ::kernel::kunit::kunit_case(::kernel::c_str!("foo"), kunit_rust_wrapper_foo),
-    //     ::kernel::kunit::kunit_case(::kernel::c_str!("bar"), kunit_rust_wrapper_bar),
+    //     ::kernel::kunit::kunit_case(c"foo", kunit_rust_wrapper_foo),
+    //     ::kernel::kunit::kunit_case(c"bar", kunit_rust_wrapper_bar),
     //     ::kernel::kunit::kunit_case_null(),
     // ];
     //
@@ -109,7 +109,7 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
         writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
         writeln!(
             test_cases,
-            "    ::kernel::kunit::kunit_case(::kernel::c_str!(\"{test}\"), {kunit_wrapper_fn_name}),"
+            "    ::kernel::kunit::kunit_case(c\"{test}\", {kunit_wrapper_fn_name}),"
         )
         .unwrap();
         writeln!(
@@ -119,7 +119,7 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
 #[allow(unused)]
 macro_rules! assert {{
     ($cond:expr $(,)?) => {{{{
-        kernel::kunit_assert!("{test}", "{path}", 0, $cond);
+        kernel::kunit_assert!("{test}", c"{path}", 0, $cond);
     }}}}
 }}
 
@@ -127,7 +127,7 @@ macro_rules! assert {{
 #[allow(unused)]
 macro_rules! assert_eq {{
     ($left:expr, $right:expr $(,)?) => {{{{
-        kernel::kunit_assert_eq!("{test}", "{path}", 0, $left, $right);
+        kernel::kunit_assert_eq!("{test}", c"{path}", 0, $left, $right);
     }}}}
 }}
         "#
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index de9304498a97..ef1906285a55 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -232,7 +232,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             type LocalModule = {type_};
 
             impl ::kernel::ModuleMetadata for {type_} {{
-                const NAME: &'static ::kernel::str::CStr = ::kernel::c_str!(\"{name}\");
+                const NAME: &'static ::kernel::str::CStr = c\"{name}\";
             }}
 
             // Double nested modules, since then nobody can access the public items inside.
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index ecc9fd378cbd..23add3160693 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -2,7 +2,7 @@
 
 //! Rust faux device sample.
 
-use kernel::{c_str, faux, prelude::*, Module};
+use kernel::{faux, prelude::*, Module};
 
 module! {
     type: SampleModule,
@@ -20,7 +20,7 @@ impl Module for SampleModule {
     fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Initialising Rust Faux Device Sample\n");
 
-        let reg = faux::Registration::new(c_str!("rust-faux-sample-device"), None)?;
+        let reg = faux::Registration::new(c"rust-faux-sample-device", None)?;
 
         dev_info!(reg.as_ref(), "Hello from faux device!\n");
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 2bb260aebc9e..8da48c1c3c2d 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{bindings, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -73,7 +73,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
         pdev.enable_device_mem()?;
         pdev.set_master();
 
-        let bar = pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci"))?;
+        let bar = pdev.iomap_region_sized::<{ Regs::END }>(0, c"rust_driver_pci")?;
 
         let drvdata = KBox::new(
             Self {
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 8b42b3cfb363..e6487a970a59 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,7 +2,7 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, device::Core, of, platform, prelude::*, types::ARef};
+use kernel::{device::Core, of, platform, prelude::*, types::ARef};
 
 struct SampleDriver {
     pdev: ARef<platform::Device>,
@@ -14,7 +14,7 @@ struct SampleDriver {
     OF_TABLE,
     MODULE_OF_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
-    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
+    [(of::DeviceId::new(c"test,rust-device"), Info(42))]
 );
 
 impl platform::Driver for SampleDriver {
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index c881fd6dbd08..12b64296e912 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -98,7 +98,6 @@
 use core::pin::Pin;
 
 use kernel::{
-    c_str,
     device::Device,
     fs::File,
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
@@ -133,7 +132,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         pr_info!("Initialising Rust Misc Device Sample\n");
 
         let options = MiscDeviceOptions {
-            name: c_str!("rust-misc-device"),
+            name: c"rust-misc-device",
         };
 
         try_pin_init!(Self {
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 507d36875196..0e86bdf1b5b1 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -173,7 +173,7 @@ pub extern "C" fn {kunit_name}(__kunit_test: *mut ::kernel::bindings::kunit) {{
     macro_rules! assert {{
         ($cond:expr $(,)?) => {{{{
             ::kernel::kunit_assert!(
-                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $cond
+                "{kunit_name}", c"{real_path}", __DOCTEST_ANCHOR - {line}, $cond
             );
         }}}}
     }}
@@ -183,7 +183,7 @@ macro_rules! assert {{
     macro_rules! assert_eq {{
         ($left:expr, $right:expr $(,)?) => {{{{
             ::kernel::kunit_assert_eq!(
-                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right
+                "{kunit_name}", c"{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right
             );
         }}}}
     }}

-- 
2.49.0


