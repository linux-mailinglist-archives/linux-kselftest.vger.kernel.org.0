Return-Path: <linux-kselftest+bounces-33744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF9EAC3156
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 22:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F778189CD68
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B236286D71;
	Sat, 24 May 2025 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIYGqqui"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9410284672;
	Sat, 24 May 2025 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748118819; cv=none; b=oaVYZ3T8AUanV4nvyk121SL195LeDnbZsS0N5X5SAT4O+IatFNOsslEeDG+MwJ0vY9Q69lGRRNGuXVV9vSMQLOpcAWC+NOYM7xIQIzaD7l9ws8bHtq7p4jKYJoNwvL7XkTU9Z+mfUKoxoY7wmgTcTeq7mrE1EkPcKelxFLzOsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748118819; c=relaxed/simple;
	bh=kG3kayql0Dgixj0oudGrSc24LiVQtIXol+JSnw1Cu4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fz7xBUTM1YAOLHySgbpwVO6RnkWNuF5+dppg90lQoPNILULz8h4QOsDdac6s+noNYU6/RPeUokZgIOfEt08I3cpSUSVIwyCS8XUIGpbBJSZDqjw+Ys/X47t8I84LHp9b64SAOvFjTSmU9z/eEHbhPKx8UjDjJfZqk+7RBB6//LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIYGqqui; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7caea4bc9e9so164599785a.1;
        Sat, 24 May 2025 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748118814; x=1748723614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiDLXiIEZDFy2THLzL+Zk1Qw/KsOCaFIvwT2meUVX0s=;
        b=EIYGqquid6pfzhvnm6mbr1TsjYxmR25h4PaejZSSfr7qjyeXEEVXj+2E9z8+kf4dUH
         c8UwTvNgB15puTvbO5O+hpsyPpeG6CSOuo64v4KPp3dU1cc4pIFTIZ+GPK2k+o/IHdNO
         kUKoO3iTtH+oR73lsKUX9pZXlUviEUWlA8mfCuPJOZrC+pZ1aemYY6HnE6a1LLsstJa3
         7VNt7mELDPoBJHTBAiDcK4yuzwdbHDKTA/HZdSi/nK7Fhl4EIgPRj7+2i6MngsAgm90q
         9esGUcxE4IC6HHXmZseVYoKj76Ug2zBarKd/yKj/bBInA97O7MPbz8G8h8p3F/CvrIlM
         Z4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748118814; x=1748723614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiDLXiIEZDFy2THLzL+Zk1Qw/KsOCaFIvwT2meUVX0s=;
        b=c5AT3jOTna1Gs14J4QhS/TzWIC3G1i4i0Gh++kzTuBH0mi4wgyttm/tDTYF/NDQRdx
         yfNoTyCTeKiQCAkCTHw6KLeRW+hYxFHcOEmQ1RBPi7apPkA2oyT/LMx0AhmPMg257RBv
         pwwurRZ2XoCCcB+Mny9ojgfrAkeTEFdZAvoqRXrlbFrVGJsr3ewAF4BIaeHp1+TO4oy0
         D4RLqgaRyq9ScHQK+MnNoiwTfihQxu4vLN5VtiLzGamaW1wixS+zCelkuCDwGtPelBPE
         bpkAr4VGwlcgKCt/ze9t9eiMCqvQ/HOeR+QIlcNStG56oRgw1M1Se+yYxzBeAeLLygsP
         GyuA==
X-Forwarded-Encrypted: i=1; AJvYcCUQHFNNhZ+/qg6ZCy1cffQc/557jtyRPTUNKCNvObCKB0ABa3CCLXmHwQCDXXCiC4USA1nyBoMLRTpD5zhr@vger.kernel.org, AJvYcCUgSWktEHldcJAsHscNGGl37YNq38fZIsvIPHKmv7RHMAZzP5k5i0hxFccGKUKPe0lOgL5ZtIZ9l2jwjKRA+oe9@vger.kernel.org, AJvYcCW3kGIAXX2dgspiBn1KEgY+NO01TVcVmS4fBLrolRxS35J/b+6y4CggZCvl6o3Xzq8QDEbyGAjJu1PnmiU=@vger.kernel.org, AJvYcCWwE9lmNI8m92873Dfvjn7rh4xE6UrL41m/i1rhQ5umIEQzQhtDLUOq8epF36Vu5oKcTtk/CuvM@vger.kernel.org, AJvYcCXUVYjdsreUgzoSTK8CvuBndF9jTpjfGXpDK8mc3qvyxdrRFqexWnaeSidW7wDPfhYAUJjE16Yg/db2@vger.kernel.org, AJvYcCXY/ugry9HaA8O0mvb8b4pQMQrgGNFd95sf65I0wakB3MzGWUcTD67CtbnWqsb7qPzbF/RtkrZ+K5Y1@vger.kernel.org
X-Gm-Message-State: AOJu0YxnlpQywVo8OKGvU0tdra+zxufcF7S9Wmtz2vNxyIX7nF8y2Yaz
	9j7YxYZIrNJMo+iKJylDc6++AykvfuhHzQTcL7caGTDweME985gGgXH3
X-Gm-Gg: ASbGncsk1R3UXNhW6lhnUc2KbwLyX0YIe1Mp3EQj+cXE7mEV5hXyyNEsUFdCOjJQYuE
	asbC47svTJji0/HXfQ0lK7oc0y1pfp9g4kXHKDTCORDtZNKHiBTSalgH0SYXQybfCscBRu+WYRg
	Q2slACBj8luUCktV12u1xA6jYXqMfJIu8qj45SmoOhU0LcqOF7jIS8QnUULWQ0LM5QkEB2WlUxF
	7eTBzdImtYzLdY3n9k/6Ab+iwbSoHLKTgxRrzBz5KbLoYF5cX9DK3Q/4oXJW1HwArPY8hT1qczk
	QxMFh1ed450D0XL7jJvcTw76RZ7KbomUgvDyiDPRjVpWddL6f8zHqlwtJR2cjPoLPZ2i3p+4ELq
	ZVLkmW6BBpFB/73Rvpjf1CoH65Tyzs5sqOWO96F0AiazpkE7fsXcAtwHWVdMBMTuIZHF35u2QCT
	QRaXA=
X-Google-Smtp-Source: AGHT+IEMkpMqvA9WNOdlKWZQIKQWr5E+dkEd8TNERyCMUwX04el93uDr7qE0Ky3NEaktXvs2xOj0Pw==
X-Received: by 2002:a05:620a:244e:b0:7ce:d95e:8d9a with SMTP id af79cd13be357-7ceecbdc4a4mr561212585a.28.1748118814246;
        Sat, 24 May 2025 13:33:34 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:8563:e370:791f:7436])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467d7fd1sm1379590085a.29.2025.05.24.13.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 13:33:33 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 24 May 2025 16:33:05 -0400
Subject: [PATCH v10 5/5] rust: remove core::ffi::CStr reexport
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250524-cstr-core-v10-5-6412a94d9d75@gmail.com>
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
In-Reply-To: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Clean up references to `kernel::str::CStr`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/gpu/drm/drm_panic_qr.rs   |  3 ++-
 drivers/gpu/nova-core/firmware.rs |  2 +-
 drivers/net/phy/ax88796b_rust.rs  |  1 +
 drivers/net/phy/qt2025.rs         |  1 +
 rust/kernel/device.rs             |  3 +--
 rust/kernel/driver.rs             |  4 ++--
 rust/kernel/error.rs              |  6 ++----
 rust/kernel/faux.rs               |  5 ++++-
 rust/kernel/firmware.rs           | 15 ++++-----------
 rust/kernel/kunit.rs              |  6 +++---
 rust/kernel/lib.rs                |  2 +-
 rust/kernel/miscdevice.rs         |  3 +--
 rust/kernel/net/phy.rs            |  4 +++-
 rust/kernel/of.rs                 |  3 ++-
 rust/kernel/pci.rs                |  2 +-
 rust/kernel/platform.rs           |  2 +-
 rust/kernel/prelude.rs            |  5 +----
 rust/kernel/str.rs                | 22 ++++++++++------------
 rust/kernel/sync/condvar.rs       |  4 ++--
 rust/kernel/sync/lock.rs          |  4 ++--
 rust/kernel/sync/lock/global.rs   |  5 +++--
 rust/kernel/sync/poll.rs          |  1 +
 rust/kernel/workqueue.rs          |  1 +
 rust/macros/module.rs             |  2 +-
 24 files changed, 51 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index d8192a9bef63..ba63238d352f 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -27,7 +27,8 @@
 //! * <https://github.com/erwanvivien/fast_qr>
 //! * <https://github.com/bjguillot/qr>
 
-use kernel::{prelude::*, str::CStr};
+use core::ffi::CStr;
+use kernel::prelude::*;
 
 #[derive(Debug, Clone, Copy, PartialEq, Eq, Ord, PartialOrd)]
 struct Version(usize);
diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 6e6361c59ca1..0af1f0df2fa5 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -30,7 +30,7 @@ const fn make_entry_chipset(self, chipset: &str) -> Self {
     }
 
     pub(crate) const fn create(
-        module_name: &'static kernel::str::CStr,
+        module_name: &'static core::ffi::CStr,
     ) -> firmware::ModInfoBuilder<N> {
         let mut this = Self(firmware::ModInfoBuilder::new(module_name));
         let mut i = 0;
diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index 2d24628a4e58..68b8e30ae296 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -4,6 +4,7 @@
 //! Rust Asix PHYs driver
 //!
 //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
+use core::ffi::CStr;
 use kernel::{
     net::phy::{self, reg::C22, DeviceId, Driver},
     prelude::*,
diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 9ccc75f70219..78ce2866f2b6 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -9,6 +9,7 @@
 //!
 //! The QT2025 PHY integrates an Intel 8051 micro-controller.
 
+use core::ffi::CStr;
 use kernel::error::code;
 use kernel::firmware::Firmware;
 use kernel::net::phy::{
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 9074322c79e8..2cf5903f7dde 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,10 +6,9 @@
 
 use crate::{
     bindings,
-    str::CStr,
     types::{ARef, Opaque},
 };
-use core::{fmt, ptr};
+use core::{ffi::CStr, fmt, ptr};
 
 #[cfg(CONFIG_PRINTK)]
 use crate::str::CStrExt as _;
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index ec9166cedfa7..9926664d9ba2 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -6,8 +6,8 @@
 //! register using the [`Registration`] class.
 
 use crate::error::{Error, Result};
-use crate::{device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
-use core::pin::Pin;
+use crate::{device, of, try_pin_init, types::Opaque, ThisModule};
+use core::{ffi::CStr, pin::Pin};
 use pin_init::{pin_data, pinned_drop, PinInit};
 
 /// The [`RegistrationOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform,
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 933c048c04f1..b2b46d26f7b7 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -4,11 +4,9 @@
 //!
 //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
 
-use crate::{
-    alloc::{layout::LayoutError, AllocError},
-    str::CStr,
-};
+use crate::alloc::{layout::LayoutError, AllocError};
 
+use core::ffi::CStr;
 use core::fmt;
 use core::num::NonZeroI32;
 use core::num::TryFromIntError;
diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 8a50fcd4c9bb..d9e5cd265101 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -7,7 +7,10 @@
 //! C header: [`include/linux/device/faux.h`]
 
 use crate::{bindings, device, error::code::*, prelude::*};
-use core::ptr::{addr_of_mut, null, null_mut, NonNull};
+use core::{
+    ffi::CStr,
+    ptr::{addr_of_mut, null, null_mut, NonNull},
+};
 
 /// The registration of a faux device.
 ///
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 09fd3a27bcf0..4ba5e5589d7b 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -4,15 +4,8 @@
 //!
 //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
 
-use crate::{
-    bindings,
-    device::Device,
-    error::Error,
-    error::Result,
-    ffi,
-    str::{CStr, CStrExt as _},
-};
-use core::ptr::NonNull;
+use crate::{bindings, device::Device, error::Error, error::Result, ffi, str::CStrExt as _};
+use core::{ffi::CStr, ptr::NonNull};
 
 /// # Invariants
 ///
@@ -168,7 +161,7 @@ unsafe impl Sync for Firmware {}
 ///     const DIR: &'static str = "vendor/chip/";
 ///     const FILES: [&'static str; 3] = [ "foo", "bar", "baz" ];
 ///
-///     const fn create(module_name: &'static kernel::str::CStr) -> firmware::ModInfoBuilder<N> {
+///     const fn create(module_name: &'static core::ffi::CStr) -> firmware::ModInfoBuilder<N> {
 ///         let mut builder = firmware::ModInfoBuilder::new(module_name);
 ///
 ///         let mut i = 0;
@@ -202,7 +195,7 @@ macro_rules! module_firmware {
     // this macro. Hence, we can neither use `expr` nor `ty`.
     ($($builder:tt)*) => {
         const _: () = {
-            const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr = if cfg!(MODULE) {
+            const __MODULE_FIRMWARE_PREFIX: &'static ::core::ffi::CStr = if cfg!(MODULE) {
                 c""
             } else {
                 <LocalModule as $crate::ModuleMetadata>::NAME
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 09148e982f48..83b48e2f8379 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -58,9 +58,9 @@ macro_rules! kunit_assert {
                 break 'out;
             }
 
-            static FILE: &'static $crate::str::CStr = $crate::c_str_avoid_literals!($file);
+            static FILE: &'static core::ffi::CStr = $crate::c_str_avoid_literals!($file);
             static LINE: i32 = core::line!() as i32 - $diff;
-            static CONDITION: &'static $crate::str::CStr =
+            static CONDITION: &'static core::ffi::CStr =
                 $crate::c_str_avoid_literals!(stringify!($condition));
 
             // SAFETY: FFI call without safety requirements.
@@ -171,7 +171,7 @@ macro_rules! kunit_assert_eq {
 /// Use [`kunit_case_null`] to generate such a delimiter.
 #[doc(hidden)]
 pub const fn kunit_case(
-    name: &'static kernel::str::CStr,
+    name: &'static core::ffi::CStr,
     run_case: unsafe extern "C" fn(*mut kernel::bindings::kunit),
 ) -> kernel::bindings::kunit_case {
     kernel::bindings::kunit_case {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ec48c818d512..d36b123c518b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -152,7 +152,7 @@ fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Erro
 /// Metadata attached to a [`Module`] or [`InPlaceModule`].
 pub trait ModuleMetadata {
     /// The name of the module as specified in the `module!` macro.
-    const NAME: &'static crate::str::CStr;
+    const NAME: &'static core::ffi::CStr;
 }
 
 /// Equivalent to `THIS_MODULE` in the C API.
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index d684ec4ef4d0..47f718a9ceb5 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -16,10 +16,9 @@
     fs::File,
     prelude::*,
     seq_file::SeqFile,
-    str::CStr,
     types::{ForeignOwnable, Opaque},
 };
-use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin};
+use core::{ffi::CStr, marker::PhantomData, mem::MaybeUninit, pin::Pin};
 
 /// Options for creating a misc device.
 #[derive(Copy, Clone)]
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 8129419a3931..72635af8f20e 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -7,7 +7,7 @@
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
 use crate::{error::*, prelude::*, types::Opaque};
-use core::{marker::PhantomData, ptr::addr_of_mut};
+use core::{ffi::CStr, marker::PhantomData, ptr::addr_of_mut};
 
 pub mod reg;
 
@@ -780,6 +780,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// ```
 /// # mod module_phy_driver_sample {
+/// use core::ffi::CStr;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -807,6 +808,7 @@ const fn as_int(&self) -> u32 {
 /// This expands to the following code:
 ///
 /// ```ignore
+/// use core::ffi::CStr;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 12ea65df46de..087ac8e05551 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -2,7 +2,8 @@
 
 //! Device Tree / Open Firmware abstractions.
 
-use crate::{bindings, device_id::RawDeviceId, prelude::*};
+use crate::{bindings, device_id::RawDeviceId};
+use core::ffi::CStr;
 
 /// IdTable type for OF drivers.
 pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 3aeb1250c27f..b639e6a1f590 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -13,11 +13,11 @@
     error::{to_result, Result},
     io::Io,
     io::IoRaw,
-    str::CStr,
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
 };
 use core::{
+    ffi::CStr,
     marker::PhantomData,
     ops::Deref,
     ptr::{addr_of_mut, NonNull},
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 7163fc468b32..ba580a4e3416 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -9,12 +9,12 @@
     error::{to_result, Result},
     of,
     prelude::*,
-    str::CStr,
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
 };
 
 use core::{
+    ffi::CStr,
     marker::PhantomData,
     ops::Deref,
     ptr::{addr_of_mut, NonNull},
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 97e8bcf73669..5d55e274b41e 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -35,10 +35,7 @@
 
 pub use super::error::{code::*, Error, Result};
 
-pub use super::{
-    str::{CStr, CStrExt as _},
-    ThisModule,
-};
+pub use super::{str::CStrExt as _, ThisModule};
 
 pub use super::init::InPlaceInit;
 
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 0385d927fcd5..cf0402d1daac 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -3,6 +3,7 @@
 //! String representations.
 
 use crate::alloc::{flags::*, AllocError, KVec};
+use core::ffi::CStr;
 use core::fmt::{self, Write};
 use core::ops::{Deref, DerefMut, Index};
 
@@ -175,8 +176,6 @@ macro_rules! b_str {
     }};
 }
 
-pub use core::ffi::CStr;
-
 /// Returns a C pointer to the string.
 // It is a free function rather than a method on an extension trait because:
 //
@@ -267,7 +266,6 @@ impl fmt::Display for crate::fmt::Adapter<&CStr> {
     ///
     /// ```
     /// # use kernel::prelude::fmt;
-    /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
     /// let penguin = c"🐧";
     /// let s = CString::try_from_fmt(fmt!("{}", penguin))?;
@@ -377,8 +375,8 @@ fn as_ref(&self) -> &BStr {
 /// # Examples
 ///
 /// ```
+/// # use core::ffi::CStr;
 /// # use kernel::c_str_avoid_literals;
-/// # use kernel::str::CStr;
 /// const MY_CSTR: &CStr = c_str_avoid_literals!(concat!(file!(), ":", line!(), ": My CStr!"));
 /// ```
 #[macro_export]
@@ -388,14 +386,14 @@ macro_rules! c_str_avoid_literals {
     // too limiting to macro authors, so we rely on the name as a hint instead.
     ($str:expr) => {{
         const S: &'static str = concat!($str, "\0");
-        const C: &'static $crate::str::CStr =
-            match $crate::str::CStr::from_bytes_with_nul(S.as_bytes()) {
-                Ok(v) => v,
-                Err(err) => {
-                    let _: core::ffi::FromBytesWithNulError = err;
-                    panic!("string contains interior NUL")
-                }
-            };
+        const C: &'static core::ffi::CStr = match core::ffi::CStr::from_bytes_with_nul(S.as_bytes())
+        {
+            Ok(v) => v,
+            Err(err) => {
+                let _: core::ffi::FromBytesWithNulError = err;
+                panic!("string contains interior NUL")
+            }
+        };
         C
     }};
 }
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 0b6bc7f2878d..09bc35feb451 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -8,14 +8,14 @@
 use super::{lock::Backend, lock::Guard, LockClassKey};
 use crate::{
     ffi::{c_int, c_long},
-    str::{CStr, CStrExt as _},
+    str::CStrExt as _,
     task::{
         MAX_SCHEDULE_TIMEOUT, TASK_FREEZABLE, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE,
     },
     time::Jiffies,
     types::Opaque,
 };
-use core::{marker::PhantomPinned, pin::Pin, ptr};
+use core::{ffi::CStr, marker::PhantomPinned, pin::Pin, ptr};
 use pin_init::{pin_data, pin_init, PinInit};
 
 /// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index a777a22976e0..21deff0bb13b 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,10 +7,10 @@
 
 use super::LockClassKey;
 use crate::{
-    str::{CStr, CStrExt as _},
+    str::CStrExt as _,
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
-use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
+use core::{cell::UnsafeCell, ffi::CStr, marker::PhantomPinned, pin::Pin};
 use pin_init::{pin_data, pin_init, PinInit};
 
 pub mod mutex;
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index 0ca23b12427c..bfeaa21ab101 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -5,13 +5,14 @@
 //! Support for defining statics containing locks.
 
 use crate::{
-    str::{CStr, CStrExt as _},
+    str::CStrExt as _,
     sync::lock::{Backend, Guard, Lock},
     sync::{LockClassKey, LockedBy},
     types::Opaque,
 };
 use core::{
     cell::UnsafeCell,
+    ffi::CStr,
     marker::{PhantomData, PhantomPinned},
     pin::Pin,
 };
@@ -267,7 +268,7 @@ macro_rules! global_lock {
         $pub enum $name {}
 
         impl $crate::sync::lock::GlobalLockBackend for $name {
-            const NAME: &'static $crate::str::CStr =
+            const NAME: &'static core::ffi::CStr =
                 $crate::c_str_avoid_literals!(::core::stringify!($name));
             type Item = $valuety;
             type Backend = $crate::global_lock_inner!(backend $kind);
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index d7e6e59e124b..bf2fb24d04ea 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -11,6 +11,7 @@
     sync::{CondVar, LockClassKey},
     types::Opaque,
 };
+use core::ffi::CStr;
 use core::ops::Deref;
 
 /// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index f98bd02b838f..c64769ef5b90 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -135,6 +135,7 @@
 
 use crate::alloc::{AllocError, Flags};
 use crate::{prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
+use core::ffi::CStr;
 use core::marker::PhantomData;
 
 /// Creates a [`Work`] initialiser with the given name and a newly-created lock class.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 7b71d6d99d5c..5246fed82e63 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -232,7 +232,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             type LocalModule = {type_};
 
             impl kernel::ModuleMetadata for {type_} {{
-                const NAME: &'static kernel::str::CStr = c\"{name}\";
+                const NAME: &'static core::ffi::CStr = c\"{name}\";
             }}
 
             // Double nested modules, since then nobody can access the public items inside.

-- 
2.49.0


