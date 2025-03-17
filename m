Return-Path: <linux-kselftest+bounces-29237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09549A655B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 16:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6796D7A7E4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5150324BD02;
	Mon, 17 Mar 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY06gWRp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090B724BBF2;
	Mon, 17 Mar 2025 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225425; cv=none; b=aNwma7A+lPuqIv9CUG0jzslIs0WBqTXd266XbQlvbx76mq7UhOto5maNfN0mwn8WANqjs+PbQXQIOCy3qw5UNAC9b12mo1bOjJRcJ1xZAxH3s7UKcdL/c7gQFcy2KoUWe7tYh+9OR65CYEgA4nlR7gqNrTkgTUGFtvdem1gpHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225425; c=relaxed/simple;
	bh=LwEg/qXS79xZ2DfCTlSj6DOddkHANYAxjhUxFUZt/HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbstKF5TTrx1TqNM5MWCjZ5yk+izCivQcPVO/6JK+xJRRJlG7Sxnc6lmfbcpBv41sfbALrGO4//d7W94Xa4J3KcL5QIQu8D3JEilwVa/aLX24MbjdCv9meUyBtDsjuXQCdQqGDElWEMooi+sPL383UJhl0YcebrV4Gk1eSQkKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY06gWRp; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c54f67db99so486678085a.1;
        Mon, 17 Mar 2025 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742225422; x=1742830222; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/+hgAgKrFtvgp9dnihutL5Y7eaYtGSxvU+aCTPahrk=;
        b=nY06gWRpa72IpoFB4TrFNS6nF7W6xPegMj9QdmJvv8jDN5dCf2I+iiEvAQFqTOHaFj
         JUrQoYEqPQbm/6lNdzA5qTWWkQUdl3p33LdD7iy8H8lJSCvFX/PtbFPm1GOhzRZC8P2U
         wsZgvTkF8Bdh2W5spYikBMGGu81fjwz7/Zijvg3nDhw8QuOKxCnsTaTkjfL/eVipAX41
         Mb7/3T5psAhhThkFbagR34L6UPITqA2+i8dRv7+/sLuFBCRayC6L8FmBVjeO5UauEpv1
         nbN/FJ/xF2ZLyNRYVEFfHvTv7qnv0AWz0U2onS6kbM3H8IlI2EMeMwX6yAsf//pfmvmZ
         s0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742225422; x=1742830222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/+hgAgKrFtvgp9dnihutL5Y7eaYtGSxvU+aCTPahrk=;
        b=CtG1Ivv0aFJ+PPQZkDwA78vosTJUshj+iYBDlUknskt9ucDExjO8+y/n8OLWnlP+1w
         d0Z6FIq8boNl0rhdW++2xzHcrD4N3b91fSMfzELIoX9QGI0qCOmKiiLUnweo27nNQWHS
         5UFckPNrcE8lUW0a6F3kx42YseLFS09j0gNPqjI6M7jdQYY6ekbf63MyWE1elSECJMD7
         bT202zUv87wStTWDdOwNYxMCzJHF8V09qslj9fDei2fiZGzuwvsQOGvyoh3WUrXhqG0G
         0R7LyHvgywTUPX0dnMzCRrJ1meTMe+O1W3NfTLfIzsscr9500ECnUI7K5xu7uPdQ4ZW6
         EP3w==
X-Forwarded-Encrypted: i=1; AJvYcCUOtuk9k9QUoUMfjNRTOOQdjgFB8fZKcNXwIY706ObTbxUDeY8wejFxCTJT86VN2/ne8p4G1caGmbx5mLOCFUyG@vger.kernel.org, AJvYcCVUH73tKiOoI7VXFUccLZmnwUYrKQFmTQT3orXAaKkMGRd7Y+AEE4ncz1raSIm2VDiDckaFpVT7@vger.kernel.org, AJvYcCVn9dyzp5hUjXH2J4GPJHgAoJeipdmUk1+O0Lrks/2JGsDsfYdy0IcsYRLEYd/zA3dD9fa8d7fdmuztDlda@vger.kernel.org, AJvYcCWKe8hUv/o2Uprwuj1EdQG/LF7VxTJ4VX9nEMQf7jrPCj6wfR8FnPViNe/EayWWW+AOL54eKbBat5lW@vger.kernel.org, AJvYcCWNvwU+MUGKAvF2PNPAlxbOss7r0ISbnRhiKpoLq0xr9HIQnlS7aAhNTNw64+sIZKdraNaYsHiGD9Eo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+tc86om8QLN/UkXidXZMryNPsXv1ZGN4MgZQlyHPrqgQdO7Tn
	2EZ2F921wTy3euiY0tEwj5rc/9ZpVZ+9PhOs+iavGXFLSQPojWjw
X-Gm-Gg: ASbGncuW+63RJGthBmHVqVwv1vpuYuEJUB49sSkS9S+s9A9gnXBehdl4eH3UaRtRbBl
	RgIKphG/FL4ctTS/0mgXAxLudIgtUPPxReywkVNcLcuHLcVlKQjmvGqM6kU80CyqQinBS5azV2H
	6JJdGWrja4CA4mA6eZN5XSLdUh9iAmWLYnBHlmDzUwm+kMq5OcNdavbrJAvDx0ZnfJ8PUWDfSQS
	lxDio7nm2LA1Otixi9WKHFdooEKGGCiqZyntwCYQyWbkcHSyxJRl0eJrcDLXO2DAD3QWm92HsR4
	GwRTk+wsRoUqboEzHm+9tM0rce7ARR1qtLGWD1oNMV4P3aghEpaitKUcxaDH84ddmUJ76uefpLI
	Zp7iR6+ztUWD+dHrM
X-Google-Smtp-Source: AGHT+IHKCLJhzaRz6vWcZqN4ET6OKjd151Da0KrksecWD1rMm7euzj3nlV70nWQ8UJEgIz5m5PJZHw==
X-Received: by 2002:a05:6214:319a:b0:6d9:ac3:e730 with SMTP id 6a1803df08f44-6eadded9779mr267368586d6.5.1742225421598;
        Mon, 17 Mar 2025 08:30:21 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2600:4041:5be7:7c00:6895:24c6:e898:e320])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade34c51fsm55736766d6.109.2025.03.17.08.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:30:21 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 11:30:05 -0400
Subject: [PATCH v9 3/4] rust: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250317-cstr-core-v9-3-51d6cc522f62@gmail.com>
References: <20250317-cstr-core-v9-0-51d6cc522f62@gmail.com>
In-Reply-To: <20250317-cstr-core-v9-0-51d6cc522f62@gmail.com>
To: Michal Rostecki <vadorovsky@protonmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
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
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible and rename
`kernel::c_str!` to `c_str_avoid_literals` to clarify its intended use.

Closes: https://github.com/Rust-for-Linux/linux/issues/1075
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/net/phy/ax88796b_rust.rs     |  7 +++---
 drivers/net/phy/qt2025.rs            |  5 ++---
 rust/kernel/devres.rs                |  2 +-
 rust/kernel/firmware.rs              |  4 ++--
 rust/kernel/kunit.rs                 |  7 +++---
 rust/kernel/net/phy.rs               |  6 ++---
 rust/kernel/platform.rs              |  4 ++--
 rust/kernel/str.rs                   | 43 ++++++++++++++++++++++--------------
 rust/kernel/sync.rs                  |  4 ++--
 rust/kernel/sync/lock/global.rs      |  3 ++-
 rust/macros/module.rs                |  2 +-
 samples/rust/rust_driver_faux.rs     |  4 ++--
 samples/rust/rust_driver_pci.rs      |  4 ++--
 samples/rust/rust_driver_platform.rs |  4 ++--
 samples/rust/rust_misc_device.rs     |  3 +--
 15 files changed, 55 insertions(+), 47 deletions(-)

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
index 520daeb42089..78f52efd13e3 100644
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
index 942376f6f3af..68af33ca2f25 100644
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
index c18b75fc672e..70449571aea6 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -46,13 +46,13 @@ fn request_nowarn() -> Self {
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
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index d858757aeace..527794dcc439 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -56,10 +56,11 @@ macro_rules! kunit_assert {
                 break 'out;
             }
 
-            static NAME: &'static $crate::str::CStr = $crate::c_str!($name);
-            static FILE: &'static $crate::str::CStr = $crate::c_str!($file);
+            static NAME: &'static $crate::str::CStr = $crate::c_str_avoid_literals!($name);
+            static FILE: &'static $crate::str::CStr = $crate::c_str_avoid_literals!($file);
             static LINE: i32 = core::line!() as i32 - $diff;
-            static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
+            static CONDITION: &'static $crate::str::CStr =
+                $crate::c_str_avoid_literals!(stringify!($condition));
 
             // SAFETY: FFI call without safety requirements.
             let kunit_test = unsafe { $crate::bindings::kunit_get_current_test() };
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
index 1297f5292ba9..474f8cb4587b 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -120,7 +120,7 @@ macro_rules! module_platform_driver {
 /// # Example
 ///
 ///```
-/// # use kernel::{bindings, c_str, of, platform};
+/// # use kernel::{bindings, of, platform};
 ///
 /// struct MyDriver;
 ///
@@ -129,7 +129,7 @@ macro_rules! module_platform_driver {
 ///     MODULE_OF_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
 ///     [
-///         (of::DeviceId::new(c_str!("test,device")), ())
+///         (of::DeviceId::new(c"test,device"), ())
 ///     ]
 /// );
 ///
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 53d1f2c26958..f1b35fa5823a 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -225,14 +225,13 @@ pub trait CStrExt {
     /// # Examples
     ///
     /// ```
-    /// # use kernel::c_str;
     /// # use kernel::fmt;
     /// # use kernel::str::CString;
-    /// let penguin = c_str!("🐧");
+    /// let penguin = c"🐧";
     /// let s = CString::try_from_fmt(fmt!("{}", penguin.display()))?;
     /// assert_eq!(s.to_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
     ///
-    /// let ascii = c_str!("so \"cool\"");
+    /// let ascii = c"so \"cool\"";
     /// let s = CString::try_from_fmt(fmt!("{}", ascii.display()))?;
     /// assert_eq!(s.to_bytes_with_nul(), "so \"cool\"\0".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
@@ -320,12 +319,12 @@ fn display(&self) -> Display<'_> {
 /// # Examples
 ///
 /// ```
-/// # use kernel::{fmt, c_str, str::CString};
-/// let ascii = c_str!("Hello, CStr!");
+/// # use kernel::{fmt, str::CString};
+/// let ascii = c"Hello, CStr!";
 /// let s = CString::try_from_fmt(fmt!("{}", ascii.display()))?;
 /// assert_eq!(s.to_bytes(), "Hello, CStr!".as_bytes());
 ///
-/// let non_ascii = c_str!("🦀");
+/// let non_ascii = c"🦀";
 /// let s = CString::try_from_fmt(fmt!("{}", non_ascii.display()))?;
 /// assert_eq!(s.to_bytes(), "\\xf0\\x9f\\xa6\\x80".as_bytes());
 /// # Ok::<(), kernel::error::Error>(())
@@ -359,25 +358,37 @@ fn as_ref(&self) -> &BStr {
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
+/// # use kernel::c_str_avoid_literals;
 /// # use kernel::str::CStr;
-/// const MY_CSTR: &CStr = c_str!("My awesome CStr!");
+/// const MY_CSTR: &CStr = c_str_avoid_literals!(concat!(file!(), ":", line!(), ": My CStr!"));
 /// ```
 #[macro_export]
-macro_rules! c_str {
+macro_rules! c_str_avoid_literals {
+    // NB: we could write `($str:lit) => compile_error!("use a C string literal instead");` here but
+    // that would trigger when the literal is at the top of several macro expansions. That would be
+    // too limiting to macro authors, so we rely on the name as a hint instead.
     ($str:expr) => {{
-        const S: &str = concat!($str, "\0");
-        const C: &$crate::str::CStr = match $crate::str::CStr::from_bytes_with_nul(S.as_bytes()) {
-            Ok(v) => v,
-            Err(_) => panic!("string contains interior NUL"),
-        };
+        const S: &'static str = concat!($str, "\0");
+        const C: &'static $crate::str::CStr =
+            match $crate::str::CStr::from_bytes_with_nul(S.as_bytes()) {
+                Ok(v) => v,
+                Err(core::ffi::FromBytesWithNulError { .. }) => {
+                    panic!("string contains interior NUL")
+                }
+            };
         C
     }};
 }
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 3498fb344dc9..f86d109b4b89 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -62,9 +62,9 @@ macro_rules! static_lock_class {
 #[macro_export]
 macro_rules! optional_name {
     () => {
-        $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::line!()))
+        $crate::c_str_avoid_literals!(::core::concat!(::core::file!(), ":", ::core::line!()))
     };
     ($name:literal) => {
-        $crate::c_str!($name)
+        $crate::c_str_avoid_literals!($name)
     };
 }
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index 6a28f5b60482..4a040c29faee 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -266,7 +266,8 @@ macro_rules! global_lock {
         $pub enum $name {}
 
         impl $crate::sync::lock::GlobalLockBackend for $name {
-            const NAME: &'static $crate::str::CStr = $crate::c_str!(::core::stringify!($name));
+            const NAME: &'static $crate::str::CStr =
+                $crate::c_str_avoid_literals!(::core::stringify!($name));
             type Item = $valuety;
             type Backend = $crate::global_lock_inner!(backend $kind);
 
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 46f20682a7a9..5467a0d539f7 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -237,7 +237,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             }};
 
             impl kernel::ModuleMetadata for {type_} {{
-                const NAME: &'static kernel::str::CStr = kernel::c_str!(\"{name}\");
+                const NAME: &'static kernel::str::CStr = c\"{name}\";
             }}
 
             // Double nested modules, since then nobody can access the public items inside.
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index 378bab4b587d..95f17603ad5e 100644
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
 
-        let reg = faux::Registration::new(c_str!("rust-faux-sample-device"))?;
+        let reg = faux::Registration::new(c"rust-faux-sample-device")?;
 
         dev_info!(reg.as_ref(), "Hello from faux device!\n");
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 364a0660a743..134845b076d4 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, devres::Devres, pci, prelude::*};
+use kernel::{bindings, devres::Devres, pci, prelude::*};
 
 struct Regs;
 
@@ -73,7 +73,7 @@ fn probe(pdev: &mut pci::Device, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>
         pdev.enable_device_mem()?;
         pdev.set_master();
 
-        let bar = pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci"))?;
+        let bar = pdev.iomap_region_sized::<{ Regs::END }>(0, c"rust_driver_pci")?;
 
         let drvdata = KBox::new(
             Self {
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index f7a0f1b29d1d..4dce0d89eb6f 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,7 +2,7 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, of, platform, prelude::*};
+use kernel::{of, platform, prelude::*};
 
 struct SampleDriver {
     pdev: platform::Device,
@@ -14,7 +14,7 @@ struct SampleDriver {
     OF_TABLE,
     MODULE_OF_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
-    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
+    [(of::DeviceId::new(c"test,rust-device"), Info(42))]
 );
 
 impl platform::Driver for SampleDriver {
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index d3785e7c0330..690b3544cf1a 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -97,7 +97,6 @@
 use core::pin::Pin;
 
 use kernel::{
-    c_str,
     device::Device,
     fs::File,
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
@@ -132,7 +131,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         pr_info!("Initialising Rust Misc Device Sample\n");
 
         let options = MiscDeviceOptions {
-            name: c_str!("rust-misc-device"),
+            name: c"rust-misc-device",
         };
 
         try_pin_init!(Self {

-- 
2.48.1


