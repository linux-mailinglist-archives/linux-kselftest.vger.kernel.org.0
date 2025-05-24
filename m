Return-Path: <linux-kselftest+bounces-33741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F15FAC3146
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 22:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B859C189D3A3
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720D827FB2C;
	Sat, 24 May 2025 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgQiPX31"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902DC27F724;
	Sat, 24 May 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748118812; cv=none; b=eQ+SVy/YApBB5NA3ODWzuum+n1wbYiLlW5kJx3mMzi3hJAuhIaFd6pAv6grDfVdqj0MqZGI6iIb920j0KS7XI+0u80zffhMdiTs+SZkm9AyZ26GjOl1W255lfKFOljtOT51QtFqxIH12XLQxC/GazOW5wpS1f1yJEyqfYpuNMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748118812; c=relaxed/simple;
	bh=F5VmGQP73qr/LlEXpvQIaPp2QG/Df8MxJTrA4eP4pdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKAOoZ+H109A5aY6y/FS0wLiLayncy8rzozgf89Xe7yg7ZGNJpyh2oakLnObdzza2Voqk5xA7WRiZwbXd3Nat3ahu1bxF6kGpxhsHKiaeWMSZtPiJWkXzghue5Ag4aQyEgLWCVwtz4zWDVyC4X6Wjz/i30YUrmPvdifRdqYlmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgQiPX31; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c58974ed57so88920885a.2;
        Sat, 24 May 2025 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748118808; x=1748723608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mcw9qiZ7QEuufOafEbGfX9hczgDaUuvzSu49Nz+/dWs=;
        b=DgQiPX31zwB5E20G+qAVTOjAK6rYBqverMHbS81+IpJZX2zFy29velDPFOq+Di68h+
         0I9mn/7oFwrQ7aDMJe/sFSKqpUOoUv+UwfM+asI6Mu+QBBHwjgRhmY7wF3VQHN+q5Web
         kKNFRq11tSRUu10YHOAr6fvUh0Nwy+SxJY3N68OMHQVlEr2BAGbRYXwdmk/a6Znzpm+P
         xBrt4PBsdbynrXTp1v31aBX3ZxMfCgoVOO/PXr2WIFb42tctT5uPpXrWzw+iSQi+Q/Sz
         PoeMBUWqA2mey27R/Ya7iQhEJ9jZR/bLRsRm/d2mcUT0yNPBEpvM0nRssNuUwdYsR/Ri
         bDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748118808; x=1748723608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mcw9qiZ7QEuufOafEbGfX9hczgDaUuvzSu49Nz+/dWs=;
        b=b9PwUTd2eVe4GB04g347hasp+ETPPMsIX4euiiELf938cqJZFOa1rSI4uxZnV6ib/F
         9YKmz0YMXyi9nCmyIxVzcSvMgIw1NLSiDqLCMW81m6HhPeydMCFdxvgWxX/cihPtL11+
         ynthnSSG1gnaiOhrihkrg/qXea7Zcky6JixfeJ+RhFApdasjfkOmjdTXOcoRAOyUxWeM
         rwcSxolg6n+kgj2fAVPgwiWXSmitwiouzcbqff40T5XfaHD9QosLQlH0xHOdH++MO0/8
         2km2MRW2ikEn7WUUFv3o3DvBmFa6LW8ki+KBIP8UeZot+eZ9OG//9HkzKTn7a1E2bqA8
         TwGg==
X-Forwarded-Encrypted: i=1; AJvYcCUjd4dQRjGuqNNoczoS2BTDlZoP7wMDu1xCKoN0lRJ2YyRn5KA+epux5QGj5SW9gOm+HR2OGVBOqvvomc1f@vger.kernel.org, AJvYcCV5GTLsQHKGySy4NVIS5N1sv0yIafE6RfgyL8CNXwsq5UFsvwoBq3GRO8TTPPT/YpyxlPF1uiIaO6k75Z1O56Jh@vger.kernel.org, AJvYcCWSka5U9xE+xt3qUDin/ztxSGh7lS+RSRk/67UzVtZ6OtZPEZmAgyNryExjpvF0vxwDuj/i0Wnl3pPe@vger.kernel.org, AJvYcCWzaWlPx5Ba34FstHMKp9O5uPH6T9CHJOAe1WeqqDEn1p0ws3Isnq8OZIZgnKZASYNRYCgYVxdwEghy5p0=@vger.kernel.org, AJvYcCXFpZ/CKI6tMRyoNLbjUyq/3309/1l3HsyYTnZ0tinQJo3rpgMPp7Sw3fIuK3Vw64JA3RP71tvAp4R8@vger.kernel.org, AJvYcCXfMGqQQnCllUL7TQjvIWYQY9b8tE2DnAZDUUFhG6lOy0tjlUz16lYHY1qhKGn/Pm3tl80Nr4Fp@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2X/H1sRPkEkMFDp64oLeTs0Q32qRWH/Z4Q+cK3naCfGV4koG
	DwWPT9XtkgFHGhmgITl/D5VR+8htJqzWUfrU7UGts5jBoeETSOmMYv7C
X-Gm-Gg: ASbGncsFdj2CaseCk0wk+GyIij8FeTbiHggsst/6uErgHjEDhtU0omceO+uq5xRmY7H
	P/XKs+dEpNAdgY6vNti8SqbG7m4UJ/L6s0PmClIfVCmmhzdsY7zLVZ+lVk2pTnQhbGdG1fhDDHP
	8cGFz7xN61/kJU/ouEumDzjSIsgllFoAnA7kseXQqrGu7re8dZULIbL3JhuNgOw1scYXOxAE2q9
	0L+6EQF0hS8RYmbNaKaebTC/DHK7Sq8frlvnUhTe+S8be1SCnrtmBhyHk0Yb9jF5FZQ/PHGwo4/
	rLlFPIbuzk4sJHowdlpAU66Wgpd3hrgM8e9FfJvolsOS0WYbMz094rPkBv+cPeXWxSTkQ6OECWl
	oWZXU3sFo/1KahmvpyiOhfAZ2kynXrCoY3AUupO7HZT6DimzCEed6c1Sa6R34gCzTDbn1Ljjol8
	oCid4=
X-Google-Smtp-Source: AGHT+IHk25PY1k2ZgXNEvWmxFrXKhKqSy6zzVr7t0ph2b59szGzbLRgZX6AHE+1Vyv3WlYPfZ4UJ3Q==
X-Received: by 2002:a05:620a:3184:b0:7cc:7704:bf87 with SMTP id af79cd13be357-7ceecc0b810mr479743785a.42.1748118807900;
        Sat, 24 May 2025 13:33:27 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:8563:e370:791f:7436])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467d7fd1sm1379590085a.29.2025.05.24.13.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 13:33:27 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 24 May 2025 16:33:03 -0400
Subject: [PATCH v10 3/5] rust: replace `CStr` with `core::ffi::CStr`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250524-cstr-core-v10-3-6412a94d9d75@gmail.com>
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

`std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64. Replace
`kernel::str::CStr` with `core::ffi::CStr` now that we can.

C-String literals were added in Rust 1.77. Opportunistically replace
instances of `kernel::c_str!` with C-String literals where other code
changes were already necessary; the rest will be done in a later commit.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/gpu/drm/drm_panic_qr.rs |   2 +-
 rust/kernel/device.rs           |   4 +-
 rust/kernel/error.rs            |   4 +-
 rust/kernel/firmware.rs         |  11 +-
 rust/kernel/kunit.rs            |   6 +-
 rust/kernel/miscdevice.rs       |   2 +-
 rust/kernel/net/phy.rs          |   2 +-
 rust/kernel/of.rs               |   2 +-
 rust/kernel/prelude.rs          |   5 +-
 rust/kernel/seq_file.rs         |   4 +-
 rust/kernel/str.rs              | 358 +++++++++-------------------------------
 rust/kernel/sync/condvar.rs     |   2 +-
 rust/kernel/sync/lock.rs        |   2 +-
 rust/kernel/sync/lock/global.rs |   2 +-
 14 files changed, 112 insertions(+), 294 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index f2a99681b998..d8192a9bef63 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -922,7 +922,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
         // nul-terminated string.
         let url_cstr: &CStr = unsafe { CStr::from_char_ptr(url) };
         let segments = &[
-            &Segment::Binary(url_cstr.as_bytes()),
+            &Segment::Binary(url_cstr.to_bytes()),
             &Segment::Numeric(&data_slice[0..data_len]),
         ];
         match EncodedMsg::new(segments, tmp_slice) {
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 99d99a76934c..9074322c79e8 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -12,7 +12,7 @@
 use core::{fmt, ptr};
 
 #[cfg(CONFIG_PRINTK)]
-use crate::c_str;
+use crate::str::CStrExt as _;
 
 /// A reference-counted device.
 ///
@@ -176,7 +176,7 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             bindings::_dev_printk(
                 klevel as *const _ as *const crate::ffi::c_char,
                 self.as_raw(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 &msg as *const _ as *const crate::ffi::c_void,
             )
         };
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 3dee3139fcd4..933c048c04f1 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -164,6 +164,8 @@ pub fn name(&self) -> Option<&'static CStr> {
         if ptr.is_null() {
             None
         } else {
+            use crate::str::CStrExt as _;
+
             // SAFETY: The string returned by `errname` is static and `NUL`-terminated.
             Some(unsafe { CStr::from_char_ptr(ptr) })
         }
@@ -188,7 +190,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
             Some(name) => f
                 .debug_tuple(
                     // SAFETY: These strings are ASCII-only.
-                    unsafe { core::str::from_utf8_unchecked(name) },
+                    unsafe { core::str::from_utf8_unchecked(name.to_bytes()) },
                 )
                 .finish(),
         }
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 2494c96e105f..582ab648b14c 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -4,7 +4,14 @@
 //!
 //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
 
-use crate::{bindings, device::Device, error::Error, error::Result, ffi, str::CStr};
+use crate::{
+    bindings,
+    device::Device,
+    error::Error,
+    error::Result,
+    ffi,
+    str::{CStr, CStrExt as _},
+};
 use core::ptr::NonNull;
 
 /// # Invariants
@@ -290,7 +297,7 @@ const fn push_module_name(self) -> Self {
         let module_name = this.module_name;
 
         if !this.module_name.is_empty() {
-            this = this.push_internal(module_name.as_bytes_with_nul());
+            this = this.push_internal(module_name.to_bytes_with_nul());
 
             if N != 0 {
                 // Re-use the space taken by the NULL terminator and swap it with the '.' separator.
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index c29e34192553..e5621d596ed3 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -100,12 +100,12 @@ unsafe impl Sync for Location {}
             unsafe impl Sync for UnaryAssert {}
 
             static LOCATION: Location = Location($crate::bindings::kunit_loc {
-                file: FILE.as_char_ptr(),
+                file: $crate::str::as_char_ptr_in_const_context(FILE),
                 line: LINE,
             });
             static ASSERTION: UnaryAssert = UnaryAssert($crate::bindings::kunit_unary_assert {
                 assert: $crate::bindings::kunit_assert {},
-                condition: CONDITION.as_char_ptr(),
+                condition: $crate::str::as_char_ptr_in_const_context(CONDITION),
                 expected_true: true,
             });
 
@@ -175,7 +175,7 @@ pub const fn kunit_case(
 ) -> kernel::bindings::kunit_case {
     kernel::bindings::kunit_case {
         run_case: Some(run_case),
-        name: name.as_char_ptr(),
+        name: kernel::str::as_char_ptr_in_const_context(name),
         attr: kernel::bindings::kunit_attributes {
             speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
         },
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index b4c5f74de23d..d684ec4ef4d0 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -34,7 +34,7 @@ pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
         // SAFETY: All zeros is valid for this C type.
         let mut result: bindings::miscdevice = unsafe { MaybeUninit::zeroed().assume_init() };
         result.minor = bindings::MISC_DYNAMIC_MINOR as _;
-        result.name = self.name.as_char_ptr();
+        result.name = crate::str::as_char_ptr_in_const_context(self.name);
         result.fops = MiscdeviceVTable::<T>::build();
         result
     }
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index a59469c785e3..652e060e47bd 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -504,7 +504,7 @@ unsafe impl Sync for DriverVTable {}
 pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
     // INVARIANT: All the fields of `struct phy_driver` are initialized properly.
     DriverVTable(Opaque::new(bindings::phy_driver {
-        name: T::NAME.as_char_ptr().cast_mut(),
+        name: crate::str::as_char_ptr_in_const_context(T::NAME).cast_mut(),
         flags: T::FLAGS,
         phy_id: T::PHY_DEVICE_ID.id,
         phy_id_mask: T::PHY_DEVICE_ID.mask_as_int(),
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 04f2d8ef29cb..12ea65df46de 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -29,7 +29,7 @@ fn index(&self) -> usize {
 impl DeviceId {
     /// Create a new device id from an OF 'compatible' string.
     pub const fn new(compatible: &'static CStr) -> Self {
-        let src = compatible.as_bytes_with_nul();
+        let src = compatible.to_bytes_with_nul();
         // Replace with `bindings::of_device_id::default()` once stabilized for `const`.
         // SAFETY: FFI type is valid to be zero-initialized.
         let mut of: bindings::of_device_id = unsafe { core::mem::zeroed() };
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ef1efcb9d945..97e8bcf73669 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -35,7 +35,10 @@
 
 pub use super::error::{code::*, Error, Result};
 
-pub use super::{str::CStr, ThisModule};
+pub use super::{
+    str::{CStr, CStrExt as _},
+    ThisModule,
+};
 
 pub use super::init::InPlaceInit;
 
diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 627bc2f7b3d2..1011743dd0ce 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -36,7 +36,7 @@ pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
         unsafe {
             bindings::seq_printf(
                 self.inner.get(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 &args as *const _ as *const crate::ffi::c_void,
             );
         }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 302423ca5eb0..586644912414 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -4,7 +4,7 @@
 
 use crate::alloc::{flags::*, AllocError, KVec};
 use core::fmt::{self, Write};
-use core::ops::{self, Deref, DerefMut, Index};
+use core::ops::{Deref, DerefMut, Index};
 
 use crate::error::{code::*, Error};
 
@@ -57,11 +57,11 @@ impl fmt::Display for BStr {
     /// # use kernel::{prelude::fmt, b_str, str::{BStr, CString}};
     /// let ascii = b_str!("Hello, BStr!");
     /// let s = CString::try_from_fmt(fmt!("{}", ascii))?;
-    /// assert_eq!(s.as_bytes(), "Hello, BStr!".as_bytes());
+    /// assert_eq!(s.to_bytes(), "Hello, BStr!".as_bytes());
     ///
     /// let non_ascii = b_str!("🦀");
     /// let s = CString::try_from_fmt(fmt!("{}", non_ascii))?;
-    /// assert_eq!(s.as_bytes(), "\\xf0\\x9f\\xa6\\x80".as_bytes());
+    /// assert_eq!(s.to_bytes(), "\\xf0\\x9f\\xa6\\x80".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
@@ -89,11 +89,11 @@ impl fmt::Debug for BStr {
     /// // Embedded double quotes are escaped.
     /// let ascii = b_str!("Hello, \"BStr\"!");
     /// let s = CString::try_from_fmt(fmt!("{:?}", ascii))?;
-    /// assert_eq!(s.as_bytes(), "\"Hello, \\\"BStr\\\"!\"".as_bytes());
+    /// assert_eq!(s.to_bytes(), "\"Hello, \\\"BStr\\\"!\"".as_bytes());
     ///
     /// let non_ascii = b_str!("😺");
     /// let s = CString::try_from_fmt(fmt!("{:?}", non_ascii))?;
-    /// assert_eq!(s.as_bytes(), "\"\\xf0\\x9f\\x98\\xba\"".as_bytes());
+    /// assert_eq!(s.to_bytes(), "\"\\xf0\\x9f\\x98\\xba\"".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
@@ -175,55 +175,19 @@ macro_rules! b_str {
     }};
 }
 
-/// Possible errors when using conversion functions in [`CStr`].
-#[derive(Debug, Clone, Copy)]
-pub enum CStrConvertError {
-    /// Supplied bytes contain an interior `NUL`.
-    InteriorNul,
+pub use core::ffi::CStr;
 
-    /// Supplied bytes are not terminated by `NUL`.
-    NotNulTerminated,
+/// Returns a C pointer to the string.
+// It is a free function rather than a method on an extension trait because:
+//
+// - error[E0379]: functions in trait impls cannot be declared const
+#[inline]
+pub const fn as_char_ptr_in_const_context(c_str: &CStr) -> *const crate::ffi::c_char {
+    c_str.as_ptr().cast()
 }
 
-impl From<CStrConvertError> for Error {
-    #[inline]
-    fn from(_: CStrConvertError) -> Error {
-        EINVAL
-    }
-}
-
-/// A string that is guaranteed to have exactly one `NUL` byte, which is at the
-/// end.
-///
-/// Used for interoperability with kernel APIs that take C strings.
-#[repr(transparent)]
-pub struct CStr([u8]);
-
-impl CStr {
-    /// Returns the length of this string excluding `NUL`.
-    #[inline]
-    pub const fn len(&self) -> usize {
-        self.len_with_nul() - 1
-    }
-
-    /// Returns the length of this string with `NUL`.
-    #[inline]
-    pub const fn len_with_nul(&self) -> usize {
-        if self.0.is_empty() {
-            // SAFETY: This is one of the invariant of `CStr`.
-            // We add a `unreachable_unchecked` here to hint the optimizer that
-            // the value returned from this function is non-zero.
-            unsafe { core::hint::unreachable_unchecked() };
-        }
-        self.0.len()
-    }
-
-    /// Returns `true` if the string only includes `NUL`.
-    #[inline]
-    pub const fn is_empty(&self) -> bool {
-        self.len() == 0
-    }
-
+/// Extensions to [`CStr`].
+pub trait CStrExt {
     /// Wraps a raw C string pointer.
     ///
     /// # Safety
@@ -231,54 +195,9 @@ pub const fn is_empty(&self) -> bool {
     /// `ptr` must be a valid pointer to a `NUL`-terminated C string, and it must
     /// last at least `'a`. When `CStr` is alive, the memory pointed by `ptr`
     /// must not be mutated.
-    #[inline]
-    pub unsafe fn from_char_ptr<'a>(ptr: *const crate::ffi::c_char) -> &'a Self {
-        // SAFETY: The safety precondition guarantees `ptr` is a valid pointer
-        // to a `NUL`-terminated C string.
-        let len = unsafe { bindings::strlen(ptr) } + 1;
-        // SAFETY: Lifetime guaranteed by the safety precondition.
-        let bytes = unsafe { core::slice::from_raw_parts(ptr as _, len) };
-        // SAFETY: As `len` is returned by `strlen`, `bytes` does not contain interior `NUL`.
-        // As we have added 1 to `len`, the last byte is known to be `NUL`.
-        unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
-    }
-
-    /// Creates a [`CStr`] from a `[u8]`.
-    ///
-    /// The provided slice must be `NUL`-terminated, does not contain any
-    /// interior `NUL` bytes.
-    pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError> {
-        if bytes.is_empty() {
-            return Err(CStrConvertError::NotNulTerminated);
-        }
-        if bytes[bytes.len() - 1] != 0 {
-            return Err(CStrConvertError::NotNulTerminated);
-        }
-        let mut i = 0;
-        // `i + 1 < bytes.len()` allows LLVM to optimize away bounds checking,
-        // while it couldn't optimize away bounds checks for `i < bytes.len() - 1`.
-        while i + 1 < bytes.len() {
-            if bytes[i] == 0 {
-                return Err(CStrConvertError::InteriorNul);
-            }
-            i += 1;
-        }
-        // SAFETY: We just checked that all properties hold.
-        Ok(unsafe { Self::from_bytes_with_nul_unchecked(bytes) })
-    }
-
-    /// Creates a [`CStr`] from a `[u8]` without performing any additional
-    /// checks.
-    ///
-    /// # Safety
-    ///
-    /// `bytes` *must* end with a `NUL` byte, and should only have a single
-    /// `NUL` byte (or the string will be truncated).
-    #[inline]
-    pub const unsafe fn from_bytes_with_nul_unchecked(bytes: &[u8]) -> &CStr {
-        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
-        unsafe { core::mem::transmute(bytes) }
-    }
+    // This function exists to paper over the fact that `CStr::from_ptr` takes a `*const
+    // core::ffi::c_char` rather than a `*const crate::ffi::c_char`.
+    unsafe fn from_char_ptr<'a>(ptr: *const crate::ffi::c_char) -> &'a Self;
 
     /// Creates a mutable [`CStr`] from a `[u8]` without performing any
     /// additional checks.
@@ -287,77 +206,16 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
     ///
     /// `bytes` *must* end with a `NUL` byte, and should only have a single
     /// `NUL` byte (or the string will be truncated).
-    #[inline]
-    pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
-        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
-        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
-    }
+    unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut Self;
 
     /// Returns a C pointer to the string.
-    #[inline]
-    pub const fn as_char_ptr(&self) -> *const crate::ffi::c_char {
-        self.0.as_ptr()
-    }
-
-    /// Convert the string to a byte slice without the trailing `NUL` byte.
-    #[inline]
-    pub fn as_bytes(&self) -> &[u8] {
-        &self.0[..self.len()]
-    }
-
-    /// Convert the string to a byte slice containing the trailing `NUL` byte.
-    #[inline]
-    pub const fn as_bytes_with_nul(&self) -> &[u8] {
-        &self.0
-    }
-
-    /// Yields a [`&str`] slice if the [`CStr`] contains valid UTF-8.
-    ///
-    /// If the contents of the [`CStr`] are valid UTF-8 data, this
-    /// function will return the corresponding [`&str`] slice. Otherwise,
-    /// it will return an error with details of where UTF-8 validation failed.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// # use kernel::str::CStr;
-    /// let cstr = CStr::from_bytes_with_nul(b"foo\0")?;
-    /// assert_eq!(cstr.to_str(), Ok("foo"));
-    /// # Ok::<(), kernel::error::Error>(())
-    /// ```
-    #[inline]
-    pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
-        core::str::from_utf8(self.as_bytes())
-    }
-
-    /// Unsafely convert this [`CStr`] into a [`&str`], without checking for
-    /// valid UTF-8.
-    ///
-    /// # Safety
-    ///
-    /// The contents must be valid UTF-8.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// # use kernel::c_str;
-    /// # use kernel::str::CStr;
-    /// let bar = c_str!("ツ");
-    /// // SAFETY: String literals are guaranteed to be valid UTF-8
-    /// // by the Rust compiler.
-    /// assert_eq!(unsafe { bar.as_str_unchecked() }, "ツ");
-    /// ```
-    #[inline]
-    pub unsafe fn as_str_unchecked(&self) -> &str {
-        // SAFETY: TODO.
-        unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
-    }
+    // This function exists to paper over the fact that `CStr::as_ptr` returns a `*const
+    // core::ffi::c_char` rather than a `*const crate::ffi::c_char`.
+    fn as_char_ptr(&self) -> *const crate::ffi::c_char;
 
     /// Convert this [`CStr`] into a [`CString`] by allocating memory and
     /// copying over the string data.
-    pub fn to_cstring(&self) -> Result<CString, AllocError> {
-        CString::try_from(self)
-    }
+    fn to_cstring(&self) -> Result<CString, AllocError>;
 
     /// Converts this [`CStr`] to its ASCII lower case equivalent in-place.
     ///
@@ -368,11 +226,7 @@ pub fn to_cstring(&self) -> Result<CString, AllocError> {
     /// [`to_ascii_lowercase()`].
     ///
     /// [`to_ascii_lowercase()`]: #method.to_ascii_lowercase
-    pub fn make_ascii_lowercase(&mut self) {
-        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
-        // string.
-        self.0.make_ascii_lowercase();
-    }
+    fn make_ascii_lowercase(&mut self);
 
     /// Converts this [`CStr`] to its ASCII upper case equivalent in-place.
     ///
@@ -383,11 +237,7 @@ pub fn make_ascii_lowercase(&mut self) {
     /// [`to_ascii_uppercase()`].
     ///
     /// [`to_ascii_uppercase()`]: #method.to_ascii_uppercase
-    pub fn make_ascii_uppercase(&mut self) {
-        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
-        // string.
-        self.0.make_ascii_uppercase();
-    }
+    fn make_ascii_uppercase(&mut self);
 
     /// Returns a copy of this [`CString`] where each character is mapped to its
     /// ASCII lower case equivalent.
@@ -398,13 +248,7 @@ pub fn make_ascii_uppercase(&mut self) {
     /// To lowercase the value in-place, use [`make_ascii_lowercase`].
     ///
     /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
-    pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
-        let mut s = self.to_cstring()?;
-
-        s.make_ascii_lowercase();
-
-        Ok(s)
-    }
+    fn to_ascii_lowercase(&self) -> Result<CString, AllocError>;
 
     /// Returns a copy of this [`CString`] where each character is mapped to its
     /// ASCII upper case equivalent.
@@ -415,13 +259,7 @@ pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
     /// To uppercase the value in-place, use [`make_ascii_uppercase`].
     ///
     /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
-    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
-        let mut s = self.to_cstring()?;
-
-        s.make_ascii_uppercase();
-
-        Ok(s)
-    }
+    fn to_ascii_uppercase(&self) -> Result<CString, AllocError>;
 }
 
 impl fmt::Display for crate::fmt::Adapter<&CStr> {
@@ -434,16 +272,16 @@ impl fmt::Display for crate::fmt::Adapter<&CStr> {
     /// # use kernel::str::CString;
     /// let penguin = c_str!("🐧");
     /// let s = CString::try_from_fmt(fmt!("{}", penguin))?;
-    /// assert_eq!(s.as_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
+    /// assert_eq!(s.to_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
     ///
     /// let ascii = c_str!("so \"cool\"");
     /// let s = CString::try_from_fmt(fmt!("{}", ascii))?;
-    /// assert_eq!(s.as_bytes_with_nul(), "so \"cool\"\0".as_bytes());
+    /// assert_eq!(s.to_bytes_with_nul(), "so \"cool\"\0".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         let Self(cstr) = self;
-        for &c in cstr.as_bytes() {
+        for &c in cstr.to_bytes() {
             if (0x20..0x7f).contains(&c) {
                 // Printable character.
                 f.write_char(c as char)?;
@@ -455,98 +293,75 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     }
 }
 
-impl fmt::Debug for CStr {
-    /// Formats printable ASCII characters with a double quote on either end, escaping the rest.
-    ///
-    /// ```
-    /// # use kernel::c_str;
-    /// # use kernel::prelude::fmt;
-    /// # use kernel::str::CStr;
-    /// # use kernel::str::CString;
-    /// let penguin = c_str!("🐧");
-    /// let s = CString::try_from_fmt(fmt!("{:?}", penguin))?;
-    /// assert_eq!(s.as_bytes_with_nul(), "\"\\xf0\\x9f\\x90\\xa7\"\0".as_bytes());
-    ///
-    /// // Embedded double quotes are escaped.
-    /// let ascii = c_str!("so \"cool\"");
-    /// let s = CString::try_from_fmt(fmt!("{:?}", ascii))?;
-    /// assert_eq!(s.as_bytes_with_nul(), "\"so \\\"cool\\\"\"\0".as_bytes());
-    /// # Ok::<(), kernel::error::Error>(())
-    /// ```
-    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        f.write_str("\"")?;
-        for &c in self.as_bytes() {
-            match c {
-                // Printable characters.
-                b'\"' => f.write_str("\\\"")?,
-                0x20..=0x7e => f.write_char(c as char)?,
-                _ => write!(f, "\\x{c:02x}")?,
-            }
-        }
-        f.write_str("\"")
-    }
+/// Converts a mutable C string to a mutable byte slice.
+///
+/// # Safety
+///
+/// The caller must ensure that the slice ends in a NUL byte and contains no other NUL bytes before
+/// the borrow ends and the underlying [`CStr`] is used.
+unsafe fn to_bytes_mut(s: &mut CStr) -> &mut [u8] {
+    // SAFETY: the cast from `&CStr` to `&[u8]` is safe since `CStr` has the same layout as `&[u8]`
+    // (this is technically not guaranteed, but we rely on it here). The pointer dereference is
+    // safe since it comes from a mutable reference which is guaranteed to be valid for writes.
+    unsafe { &mut *(s as *mut CStr as *mut [u8]) }
 }
 
-impl AsRef<BStr> for CStr {
+impl CStrExt for CStr {
     #[inline]
-    fn as_ref(&self) -> &BStr {
-        BStr::from_bytes(self.as_bytes())
+    unsafe fn from_char_ptr<'a>(ptr: *const crate::ffi::c_char) -> &'a Self {
+        // SAFETY: The safety preconditions are the same as for `CStr::from_ptr`.
+        unsafe { CStr::from_ptr(ptr.cast()) }
     }
-}
 
-impl Deref for CStr {
-    type Target = BStr;
+    #[inline]
+    unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut Self {
+        // SAFETY: the cast from `&[u8]` to `&CStr` is safe since the properties of `bytes` are
+        // guaranteed by the safety precondition and `CStr` has the same layout as `&[u8]` (this is
+        // technically not guaranteed, but we rely on it here). The pointer dereference is safe
+        // since it comes from a mutable reference which is guaranteed to be valid for writes.
+        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
+    }
 
     #[inline]
-    fn deref(&self) -> &Self::Target {
-        self.as_ref()
+    fn as_char_ptr(&self) -> *const crate::ffi::c_char {
+        self.as_ptr().cast()
     }
-}
 
-impl Index<ops::RangeFrom<usize>> for CStr {
-    type Output = CStr;
+    fn to_cstring(&self) -> Result<CString, AllocError> {
+        CString::try_from(self)
+    }
 
-    #[inline]
-    fn index(&self, index: ops::RangeFrom<usize>) -> &Self::Output {
-        // Delegate bounds checking to slice.
-        // Assign to _ to mute clippy's unnecessary operation warning.
-        let _ = &self.as_bytes()[index.start..];
-        // SAFETY: We just checked the bounds.
-        unsafe { Self::from_bytes_with_nul_unchecked(&self.0[index.start..]) }
+    fn make_ascii_lowercase(&mut self) {
+        // SAFETY: This doesn't introduce or remove NUL bytes in the C string.
+        unsafe { to_bytes_mut(self) }.make_ascii_lowercase();
     }
-}
 
-impl Index<ops::RangeFull> for CStr {
-    type Output = CStr;
+    fn make_ascii_uppercase(&mut self) {
+        // SAFETY: This doesn't introduce or remove NUL bytes in the C string.
+        unsafe { to_bytes_mut(self) }.make_ascii_uppercase();
+    }
 
-    #[inline]
-    fn index(&self, _index: ops::RangeFull) -> &Self::Output {
-        self
+    fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
+        let mut s = self.to_cstring()?;
+
+        s.make_ascii_lowercase();
+
+        Ok(s)
     }
-}
 
-mod private {
-    use core::ops;
+    fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
+        let mut s = self.to_cstring()?;
 
-    // Marker trait for index types that can be forward to `BStr`.
-    pub trait CStrIndex {}
+        s.make_ascii_uppercase();
 
-    impl CStrIndex for usize {}
-    impl CStrIndex for ops::Range<usize> {}
-    impl CStrIndex for ops::RangeInclusive<usize> {}
-    impl CStrIndex for ops::RangeToInclusive<usize> {}
+        Ok(s)
+    }
 }
 
-impl<Idx> Index<Idx> for CStr
-where
-    Idx: private::CStrIndex,
-    BStr: Index<Idx>,
-{
-    type Output = <BStr as Index<Idx>>::Output;
-
+impl AsRef<BStr> for CStr {
     #[inline]
-    fn index(&self, index: Idx) -> &Self::Output {
-        &self.as_ref()[index]
+    fn as_ref(&self) -> &BStr {
+        BStr::from_bytes(self.to_bytes())
     }
 }
 
@@ -630,15 +445,6 @@ fn test_cstr_to_str_panic() {
         checked_cstr.to_str().unwrap();
     }
 
-    #[test]
-    fn test_cstr_as_str_unchecked() {
-        let good_bytes = b"\xf0\x9f\x90\xA7\0";
-        let checked_cstr = CStr::from_bytes_with_nul(good_bytes).unwrap();
-        // SAFETY: The contents come from a string literal which contains valid UTF-8.
-        let unchecked_str = unsafe { checked_cstr.as_str_unchecked() };
-        assert_eq!(unchecked_str, "🐧");
-    }
-
     #[test]
     fn test_cstr_display() {
         let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
@@ -854,11 +660,11 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// use kernel::{str::CString, prelude::fmt};
 ///
 /// let s = CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20))?;
-/// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
+/// assert_eq!(s.to_bytes_with_nul(), "abc1020\0".as_bytes());
 ///
 /// let tmp = "testing";
 /// let s = CString::try_from_fmt(fmt!("{tmp}{}", 123))?;
-/// assert_eq!(s.as_bytes_with_nul(), "testing123\0".as_bytes());
+/// assert_eq!(s.to_bytes_with_nul(), "testing123\0".as_bytes());
 ///
 /// // This fails because it has an embedded `NUL` byte.
 /// let s = CString::try_from_fmt(fmt!("a\0b{}", 123));
@@ -928,7 +734,7 @@ impl<'a> TryFrom<&'a CStr> for CString {
     fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
         let mut buf = KVec::new();
 
-        buf.extend_from_slice(cstr.as_bytes_with_nul(), GFP_KERNEL)?;
+        buf.extend_from_slice(cstr.to_bytes_with_nul(), GFP_KERNEL)?;
 
         // INVARIANT: The `CStr` and `CString` types have the same invariants for
         // the string data, and we copied it over without changes.
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index caebf03f553b..0b6bc7f2878d 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -8,7 +8,7 @@
 use super::{lock::Backend, lock::Guard, LockClassKey};
 use crate::{
     ffi::{c_int, c_long},
-    str::CStr,
+    str::{CStr, CStrExt as _},
     task::{
         MAX_SCHEDULE_TIMEOUT, TASK_FREEZABLE, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE,
     },
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index e82fa5be289c..a777a22976e0 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,7 +7,7 @@
 
 use super::LockClassKey;
 use crate::{
-    str::CStr,
+    str::{CStr, CStrExt as _},
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
 use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index d65f94b5caf2..79d0ef7fda86 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -5,7 +5,7 @@
 //! Support for defining statics containing locks.
 
 use crate::{
-    str::CStr,
+    str::{CStr, CStrExt as _},
     sync::lock::{Backend, Guard, Lock},
     sync::{LockClassKey, LockedBy},
     types::Opaque,

-- 
2.49.0


