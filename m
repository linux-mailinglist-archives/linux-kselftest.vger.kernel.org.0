Return-Path: <linux-kselftest+bounces-35368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C1AE09F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 17:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3493A92FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D1628C5B1;
	Thu, 19 Jun 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1+30PPt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DA28C01D;
	Thu, 19 Jun 2025 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345603; cv=none; b=YEy9km4wT6xYgB8Mlti3WX8cBMVO6fVZAhQmCR5jqjxSJNID183PdlUajUeDZWd5cXOKCkL8oxv8F0PQOpYAnLAynyk7bOA1aAQal6aGT3qX2ZHJSZM+yrxbegE1oMdFLrra6AjK6Y8jdLuKobclpF//4Br8bwWIJ6qSyoARJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345603; c=relaxed/simple;
	bh=JSSKdlCXzZv3cvg62Oobqe6RiMskRcD0eglqPYTXxx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqtNDDLH7UIRpDXCqYXw6GHhEoj0aBVpLhWXChcUxK4+JKNTxID3h92ZqtcMM/3uT8ruh0YFA0O3cp4AW/nFHM45JhP5SlulYxCP5j7/Fa8WilLg3aRTzFrgVZTXLeF2sClXRWluJUNXsCu2LSKYy4/3/ILwvuiRd6IJpcMzftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1+30PPt; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a6f3f88613so7717411cf.1;
        Thu, 19 Jun 2025 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750345599; x=1750950399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYHSVmC06nyRCheM53AzBOMn98GjS34GcRl0Ij8d9FM=;
        b=G1+30PPtB/B+q+vHHfhcfbhHZCAxU9ln2JQ59sopT1IHTAKi4hLvvOXemp2VSPsaoE
         kttXnrdiSAXggqEf7lGri+hLVK6Wh0vmt9WWNFaTCchYMCR6h7JYPKn+O6nzHpx42LIF
         hSX7DTlIlw4dVTixh3sYQREVqCtVPVEzvAsFLwm15fpVHe0Ga2ARdzTR9ODb6ac2wOT7
         esDtdazH9u5FT/jxbjyO4UTbGzTyU5PpWwNGryhkgFUdur/0HFI/AAaFBxcpt/PI7gxG
         6neL9pDJtsF+ssHZDgpINEeknBRC1QNdvzRToDYHjAf1J4nOSpv7uuU6uetGAO/DhWAE
         wMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750345599; x=1750950399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYHSVmC06nyRCheM53AzBOMn98GjS34GcRl0Ij8d9FM=;
        b=KAUoKPJRwJXNRbESBWVsLdHbyYdy6pTNHvykuuad0hL7wqj+qQDcrj1MftyCMpB+lI
         aTtj3xL8Dj2bRFffVnc8Cd9a6ZXtl+fFPezSe/cYh/9oKq3m3ouF7JUARfNfZaVxRAb2
         OQ4K8bYgsnTM9hVvGRZUnbwMEGexyHmEvXHgMzYeU9cVi9193VEUI+CZDKfJ2pt2bbrS
         yml4Ke4VSrivKLPAanZZBz0uU//rtKyTe/NtZh8mP+kCFKpIq2vOj7ilVYuVEkncGaTS
         +VDmw3sSGJt9/FNLUXZMcEZX95HYCREapx2y21n9pkrvpLeCJ55hlyxqpkow7Pql0DxZ
         aPGA==
X-Forwarded-Encrypted: i=1; AJvYcCU67vEFv0jYO58xHkNeSI6z7lAepOdat6lx7MOdsdNYU0/XAjx2BLVXaEkfiqLbML/t2vbjx4qG3qWWYhNS6Owx@vger.kernel.org, AJvYcCUGCo8XzvBl4nVPNs6nrBxSe68YcAOCnYT0BjzddzsLf/UCWB5THE5eRdVGDvba6EkZ2PIRAQOCFfIyVs15@vger.kernel.org, AJvYcCUHBIRaXk08DRH3TPYGwptqX7mPrazrbPc92zGhH7ydQR8/lbj/u5sG2nHZ3/xuRUsXbPK3liaCJdZE@vger.kernel.org, AJvYcCUhpKVavv0wh1lYeP9ibFyU4IW3ukOmfcEg591zq4PlS/jg0AVnGcEUIAsC5qbLV8eyG03+RQEH@vger.kernel.org, AJvYcCWD3r0Xe1BFN/HBs9c7fLXcnoWUdDh0dDdXzVjGwI2E5tW0qTUa3AB4K1zheeNoKsGLMmPEXE3dcEXP@vger.kernel.org, AJvYcCWdftdnTTATkt9RZa8TO7MvE+dDoFPjnCHUe3ljsAvcflwAb9AHXY+OLMrnLi5p00hIsa5TVDJ39MjqHas=@vger.kernel.org, AJvYcCXJUWxquZg0NtC0JvcDf2Kw01ghWDsydMlNnjwlSI1Pgo1eIicnQ9DhdzVmfdczBXmB0vpjH5+2EUA=@vger.kernel.org, AJvYcCXnVcDdweRREt2xNVyIoxn5J3HMSLFYZfZoZLH6dYsyvyIHkweN5lIiZezQTlsW51jYCkXpoFmj6zZL@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaJYL9pbTFo3Zsk5VaotkAbOl0nifSYFgXwe6AxBcSRjkYSJ7
	3cYWMEkdo9OWZZhuJuab+0Klx6n47Xuq/pcP4K6f15ntnxAZ6gMZVjTc
X-Gm-Gg: ASbGnctdmyC7ZOqoVp7gAlu3OG1m3xEHDykBprAEx1GSfq9+4qSc26viCOeMpOKq502
	+jp8PpPB+Et73jQoGnd0BjMsh0xB5TeM/CUeHj+7nXFjx3NJT2+Pf0bNxg6x2AmQtsfyUT+X5k7
	ckwdIv89F1smf/Z8LNzNq+kCL6DY7in+MXk3FTJoZ3/0unEMt4wKDzxNrd6AFNLZtE3LF0a8VRo
	M+Who6gCKtrYKhc/OqH6O+bi48OqYHD5fa2EnX4/BerV3M/WTBg0SnhxBIMPEPVvPATm2X5ylnJ
	jkxxfGXndg6ojTcRsuAqO6nrlMcRkyEElbxQGkN3eS9TAqpuixhXgGZU0uFtoztNRT+z/SJ9Njo
	=
X-Google-Smtp-Source: AGHT+IHZKbPZ+GPvljvQmRPIS2BreCgsnlsz6cX3R/UILnkIOhMPXvwGP5rSblFyvYpWJ6yTIhisdA==
X-Received: by 2002:a05:622a:91:b0:4a4:2cb0:2b29 with SMTP id d75a77b69052e-4a73c618998mr341014161cf.35.1750345598854;
        Thu, 19 Jun 2025 08:06:38 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:5c8a:fc6a:b57c:e57f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7785aaacdsm250531cf.39.2025.06.19.08.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 08:06:38 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 19 Jun 2025 11:06:27 -0400
Subject: [PATCH v12 3/5] rust: replace `CStr` with `core::ffi::CStr`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250619-cstr-core-v12-3-80c9c7b45900@gmail.com>
References: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com>
In-Reply-To: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com>
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
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

`kernel::ffi::CStr` was introduced in commit d126d2380131 ("rust: str:
add `CStr` type") in November 2022 as an upstreaming of earlier work
that was done in May 2021[0]. That earlier work, having predated the
inclusion of `CStr` in `core`, largely duplicated the implementation of
`std::ffi::CStr`.

`std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64 in
September 2022. Hence replace `kernel::str::CStr` with `core::ffi::CStr`
to reduce our custom code footprint, and retain needed custom
functionality through an extension trait.

C-String literals were added in Rust 1.77, while our MSRV is 1.78. Thus
opportunistically replace instances of `kernel::c_str!` with C-String
literals where other code changes were already necessary or where
existing code triggered clippy lints; the rest will be done in a later
commit.

Link: https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f8e43f1d8d5c0860d98a23f [0]
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/gpu/drm/drm_panic_qr.rs |   2 +-
 rust/kernel/auxiliary.rs        |   4 +-
 rust/kernel/configfs.rs         |   4 +-
 rust/kernel/cpufreq.rs          |   2 +-
 rust/kernel/device.rs           |   4 +-
 rust/kernel/drm/device.rs       |   4 +-
 rust/kernel/error.rs            |   4 +-
 rust/kernel/firmware.rs         |  11 +-
 rust/kernel/kunit.rs            |   6 +-
 rust/kernel/miscdevice.rs       |   2 +-
 rust/kernel/net/phy.rs          |   2 +-
 rust/kernel/of.rs               |   2 +-
 rust/kernel/prelude.rs          |   5 +-
 rust/kernel/seq_file.rs         |   4 +-
 rust/kernel/str.rs              | 394 +++++++++++-----------------------------
 rust/kernel/sync/condvar.rs     |   2 +-
 rust/kernel/sync/lock.rs        |   2 +-
 rust/kernel/sync/lock/global.rs |   2 +-
 samples/rust/rust_configfs.rs   |   2 +-
 19 files changed, 140 insertions(+), 318 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index dd55b1cb764d..01e8ba9e6de1 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -948,7 +948,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
         // nul-terminated string.
         let url_cstr: &CStr = unsafe { CStr::from_char_ptr(url) };
         let segments = &[
-            &Segment::Binary(url_cstr.as_bytes()),
+            &Segment::Binary(url_cstr.to_bytes()),
             &Segment::Numeric(&data_slice[0..data_len]),
         ];
         match EncodedMsg::new(segments, tmp_slice) {
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index d2cfe1eeefb6..89d961407adb 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -111,8 +111,8 @@ macro_rules! module_auxiliary_driver {
 impl DeviceId {
     /// Create a new [`DeviceId`] from name.
     pub const fn new(modname: &'static CStr, name: &'static CStr) -> Self {
-        let name = name.as_bytes_with_nul();
-        let modname = modname.as_bytes_with_nul();
+        let name = name.to_bytes_with_nul();
+        let modname = modname.to_bytes_with_nul();
 
         // TODO: Replace with `bindings::auxiliary_device_id::default()` once stabilized for
         // `const`.
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 34d0bea4f9a5..ee83692fbb1e 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -263,7 +263,7 @@ pub fn new(
         try_pin_init!(Self {
             group <- pin_init::zeroed().chain(|v: &mut Opaque<bindings::config_group>| {
                 let place = v.get();
-                let name = name.as_bytes_with_nul().as_ptr();
+                let name = name.to_bytes_with_nul().as_ptr();
                 // SAFETY: It is safe to initialize a group once it has been zeroed.
                 unsafe {
                     bindings::config_group_init_type_name(place, name.cast(), item_type.as_ptr())
@@ -613,7 +613,7 @@ impl<const ID: u64, O, Data> Attribute<ID, O, Data>
     pub const fn new(name: &'static CStr) -> Self {
         Self {
             attribute: Opaque::new(bindings::configfs_attribute {
-                ca_name: name.as_char_ptr(),
+                ca_name: crate::str::as_char_ptr_in_const_context(name),
                 ca_owner: core::ptr::null_mut(),
                 ca_mode: 0o660,
                 show: Some(Self::show),
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 11b03e9d7e89..e98fa609cbea 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1018,7 +1018,7 @@ impl<T: Driver> Registration<T> {
     };
 
     const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
-        let src = name.as_bytes_with_nul();
+        let src = name.to_bytes_with_nul();
         let mut dst = [0; CPUFREQ_NAME_LEN];
 
         build_assert!(src.len() <= CPUFREQ_NAME_LEN);
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index cdc6c8161e24..d2b6c1ce02a5 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -12,7 +12,7 @@
 use core::{fmt, marker::PhantomData, ptr};
 
 #[cfg(CONFIG_PRINTK)]
-use crate::c_str;
+use crate::str::CStrExt as _;
 
 /// A reference-counted device.
 ///
@@ -197,7 +197,7 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             bindings::_dev_printk(
                 klevel as *const _ as *const crate::ffi::c_char,
                 self.as_raw(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 &msg as *const _ as *const crate::ffi::c_void,
             )
         };
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 624d7a4c83ea..ec1642c9b7b9 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -83,8 +83,8 @@ impl<T: drm::Driver> Device<T> {
         major: T::INFO.major,
         minor: T::INFO.minor,
         patchlevel: T::INFO.patchlevel,
-        name: T::INFO.name.as_char_ptr() as *mut _,
-        desc: T::INFO.desc.as_char_ptr() as *mut _,
+        name: crate::str::as_char_ptr_in_const_context(T::INFO.name) as *mut _,
+        desc: crate::str::as_char_ptr_in_const_context(T::INFO.desc) as *mut _,
 
         driver_features: drm::driver::FEAT_GEM,
         ioctls: T::IOCTLS.as_ptr(),
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
index 20ae65c2a18e..4927aa0b656e 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -99,12 +99,12 @@ unsafe impl Sync for Location {}
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
 
@@ -199,7 +199,7 @@ pub const fn kunit_case(
 ) -> kernel::bindings::kunit_case {
     kernel::bindings::kunit_case {
         run_case: Some(run_case),
-        name: name.as_char_ptr(),
+        name: kernel::str::as_char_ptr_in_const_context(name),
         attr: kernel::bindings::kunit_attributes {
             speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
         },
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 939278bc7b03..00e148d9ea97 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -35,7 +35,7 @@ pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
         // SAFETY: All zeros is valid for this C type.
         let mut result: bindings::miscdevice = unsafe { MaybeUninit::zeroed().assume_init() };
         result.minor = bindings::MISC_DYNAMIC_MINOR as _;
-        result.name = self.name.as_char_ptr();
+        result.name = crate::str::as_char_ptr_in_const_context(self.name);
         result.fops = MiscdeviceVTable::<T>::build();
         result
     }
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 32ea43ece646..34239106bd27 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -505,7 +505,7 @@ unsafe impl Sync for DriverVTable {}
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
index 41cebd906c4c..244b660fa835 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -40,7 +40,10 @@
 
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
index 3ef99ba2e93c..e884ec1ce5c8 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -4,7 +4,7 @@
 
 use crate::alloc::{flags::*, AllocError, KVec};
 use core::fmt::{self, Write};
-use core::ops::{self, Deref, DerefMut, Index};
+use core::ops::{Deref, DerefMut, Index};
 
 use crate::prelude::*;
 
@@ -57,11 +57,11 @@ impl crate::fmt::Display for BStr {
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
 
 impl crate::fmt::Display for CStr {
@@ -434,15 +272,15 @@ impl crate::fmt::Display for CStr {
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
-        for &c in self.as_bytes() {
+        for &c in self.to_bytes() {
             if (0x20..0x7f).contains(&c) {
                 // Printable character.
                 f.write_char(c as char)?;
@@ -454,98 +292,75 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
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
 
@@ -576,6 +391,13 @@ macro_rules! c_str {
 mod tests {
     use super::*;
 
+    impl From<core::ffi::FromBytesWithNulError> for Error {
+        #[inline]
+        fn from(_: core::ffi::FromBytesWithNulError) -> Error {
+            EINVAL
+        }
+    }
+
     macro_rules! format {
         ($($f:tt)*) => ({
             CString::try_from_fmt(crate::prelude::fmt!($($f)*))?.to_str()?
@@ -598,40 +420,28 @@ macro_rules! format {
 
     #[test]
     fn test_cstr_to_str() -> Result {
-        let good_bytes = b"\xf0\x9f\xa6\x80\0";
-        let checked_cstr = CStr::from_bytes_with_nul(good_bytes)?;
-        let checked_str = checked_cstr.to_str()?;
+        let cstr = c"\xf0\x9f\xa6\x80";
+        let checked_str = cstr.to_str()?;
         assert_eq!(checked_str, "🦀");
         Ok(())
     }
 
     #[test]
     fn test_cstr_to_str_invalid_utf8() -> Result {
-        let bad_bytes = b"\xc3\x28\0";
-        let checked_cstr = CStr::from_bytes_with_nul(bad_bytes)?;
-        assert!(checked_cstr.to_str().is_err());
-        Ok(())
-    }
-
-    #[test]
-    fn test_cstr_as_str_unchecked() -> Result {
-        let good_bytes = b"\xf0\x9f\x90\xA7\0";
-        let checked_cstr = CStr::from_bytes_with_nul(good_bytes)?;
-        // SAFETY: The contents come from a string literal which contains valid UTF-8.
-        let unchecked_str = unsafe { checked_cstr.as_str_unchecked() };
-        assert_eq!(unchecked_str, "🐧");
+        let cstr = c"\xc3\x28";
+        assert!(cstr.to_str().is_err());
         Ok(())
     }
 
     #[test]
     fn test_cstr_display() -> Result {
-        let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0")?;
+        let hello_world = c"hello, world!";
         assert_eq!(format!("{hello_world}"), "hello, world!");
-        let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0")?;
+        let non_printables = c"\x01\x09\x0a";
         assert_eq!(format!("{non_printables}"), "\\x01\\x09\\x0a");
-        let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?;
+        let non_ascii = c"d\xe9j\xe0 vu";
         assert_eq!(format!("{non_ascii}"), "d\\xe9j\\xe0 vu");
-        let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0")?;
+        let good_bytes = c"\xf0\x9f\xa6\x80";
         assert_eq!(format!("{good_bytes}"), "\\xf0\\x9f\\xa6\\x80");
         Ok(())
     }
@@ -650,13 +460,13 @@ fn test_cstr_display_all_bytes() -> Result {
 
     #[test]
     fn test_cstr_debug() -> Result {
-        let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0")?;
+        let hello_world = c"hello, world!";
         assert_eq!(format!("{hello_world:?}"), "\"hello, world!\"");
-        let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0")?;
-        assert_eq!(format!("{non_printables:?}"), "\"\\x01\\x09\\x0a\"");
-        let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?;
+        let non_printables = c"\x01\x09\x0a";
+        assert_eq!(format!("{non_printables:?}"), "\"\\x01\\t\\n\"");
+        let non_ascii = c"d\xe9j\xe0 vu";
         assert_eq!(format!("{non_ascii:?}"), "\"d\\xe9j\\xe0 vu\"");
-        let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0")?;
+        let good_bytes = c"\xf0\x9f\xa6\x80";
         assert_eq!(format!("{good_bytes:?}"), "\"\\xf0\\x9f\\xa6\\x80\"");
         Ok(())
     }
@@ -843,11 +653,11 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
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
@@ -917,7 +727,7 @@ impl<'a> TryFrom<&'a CStr> for CString {
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
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index 60ddbe62cda3..02641dc06f25 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -94,7 +94,7 @@ impl configfs::AttributeOperations<0> for Configuration {
 
     fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         pr_info!("Show message\n");
-        let data = container.message;
+        let data = container.message.to_bytes();
         page[0..data.len()].copy_from_slice(data);
         Ok(data.len())
     }

-- 
2.50.0


