Return-Path: <linux-kselftest+bounces-34675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A541BAD51AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEC53A83A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F78269CE0;
	Wed, 11 Jun 2025 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/IAEhNi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B3269818;
	Wed, 11 Jun 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637428; cv=none; b=hYx2gq1/vTvRxz0ZI5x672ndS8hMRYv1mCW0QICbSw8M2TV1wuiSUaIacL0jQPAPDUmOZIwMLerFeYvb3AjT5E4hkBnVMOz3wNfMdXobPbpnMiHqPEKuvJIx1rnqsC2J1A8cJg06gy79OSumdVqX/dMGg4kmBKrCVWeSQ+MJZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637428; c=relaxed/simple;
	bh=yg4n93C/NcLVnyCNYAyOa3gVfJ7ax8Oxoy2vIug88RM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWtHKU8QugGYCCsgjB3kE8yi/OtwouJbDAls6un+J/8iGtFh+j+Da294WOL9Z9sqNlooMncvVTvsWZ7GPznD26P/ahYCBIwvKAdqT5x5AU61gGyOkUF04re1BrI/K9GOPCTL+bbFKlWSyjD8k52AILw1AmgM3hHNdsOu1cc2blU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/IAEhNi; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d21cecc11fso1025943985a.3;
        Wed, 11 Jun 2025 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749637425; x=1750242225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fr3i50efmTTUye4giWnOXoWKuuW3PYZZNhP4YMB6XXY=;
        b=W/IAEhNiDxk9TW6W0N0uyy+4T3HBVcnTAeI7PTguZPVDpnQJzMTN6Hozat7gtYQgay
         fFwxhOZQOhXAMZDjWBkg4CekuzmfyoPL9GcFny5BMCHZvb32sXaJ5BR1IBjRPPIcqGVz
         kVVckATmivH2nj6efgoMgKLbR4RFZscH9cXpNO3xhOshRi6bfJ4QweUQIKxMQFmmTN4Y
         J+8ysmOG+BD8eUeW2dvqGh41atzCDKG4Cob8PcqGLufJEO9mOI//iwQXwVEk9oMJ5mwi
         lrRkVN/Stwyj4CfUs+1VG/k8EsEz7f+LUB0iBR92HpsUbzCOaQQNZ0R2EU/2p2r1OBLp
         MOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749637425; x=1750242225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fr3i50efmTTUye4giWnOXoWKuuW3PYZZNhP4YMB6XXY=;
        b=xRxstNDxMDvYfnnjwN9yC8/zsduVU95WmFB6DX2mj84xh8ydeuA0DojNl9MGEpZnKh
         B9LjlELBnkO6TTEv6/MspfTdZ5EWXJkNYOM0P2elFN4bpnSiLB5bXHedDqSS07cW4M60
         dd8Def3n+yugFKmcoBnQo3iDH54cdoxtrrnwkCFPgoi9VC6fy4jT0fgQ2cWD7CkRhql7
         iWu9M+8hC7QUGf2kDMYBUIqQnKGEZUhaydtcpJY08l19nUK9YbGMjHiKyVSuKDhQm9ny
         FBG42O3cG4XCso6bsiFRf91EFi46iGW4fZYpPla8PhhN+vRZHSswFOUgFH3CGiq4kENo
         Je0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/PRXuc2Bs033mFj2tEdoIK1HyjtzQIvl4LF40qm/kSIi7vbG3S0PBsDmf1C/lZIFD+8TXdx6a1+ho@vger.kernel.org, AJvYcCU5dgb7Yp1RRpAqA+2RZMhQXPZJ39yu2T1byZu/LVzhwiNQzKdDj2ZIMCd+OAk3o9TbzSVhdjWJn5Xg76nBMGqZ@vger.kernel.org, AJvYcCU9UHkvSn2vFkeWNHe/knVFDksuN7BYb10g+ry0OD30OrAgeoEHmTIxqBCmOEK/yssSHhnmD3O2@vger.kernel.org, AJvYcCUFMHkFugL+TapxLRzuDRQYkHNSegI0wGleutzfHD1Sw0nPTyYM+Sa6aG+z3KW14t95Ykk+A00vNZvN0Vs=@vger.kernel.org, AJvYcCV7DdB9mSTUUQXyfSS0y8Z4fKZO9wgNGEjuHEXM99acN8Wi57/4q+Pc7Js5mnkgHEEIMm2o/hHEmrobCF1iFcw=@vger.kernel.org, AJvYcCXNqnJ9e63frQ2vSU98e3ObIP/jFqbkud8TubfGjr8EzzfdFluukU2LXmQF4S76DhvVipOCSLHvXZS2D8kp@vger.kernel.org, AJvYcCXubDrxXRn9aRZKIT8P36x69LUYUHUXtFM0/Ph0vmyKR9rc/oWO9NcfmTo8RBA4pi77/sgfTuX82Wvx@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJJufZnEGiFZ/+q/6E8NiK9vVjCKYa2ZNH6lUQvOpA4pGsQDb
	Nv1cJOTsmBndDuFQi57jqEoo4gNG3PesQI1avVt6MMESv4Agv4tHcWHZ
X-Gm-Gg: ASbGncsY0/i2CjHzXP3B0GL8xRoNNzKfKKSYU7ESohVv/GPhN/2Dp4lBo5Dr2sydGQK
	B1VZsR+As/5xmQxQEJNEbrWe/sm+mvKDQlLEWvduUdHCuMQuF7YuOScZpOki9TtZ+dpydaTC9Pz
	qwz5iJNTSZCt/a9K/3XFo8zUAuLdj3i1e0hXTmYHcN4qrz26Kkuq7ZsFDHmXLrAKkurxdkhkLx4
	sq+PXuXV3fNgy+OIdy8ObWP7DEQ/53TGUo5FyrFc6/nSoFqVUR96UKapNJSQRmdGQGU4a2bQM7w
	dGAy0F7qaaq7LMdnSerQ5NDtpqFJSEVzRW5agIINQ2pdFgKdS9pRydVTlddxrFCb1Mc=
X-Google-Smtp-Source: AGHT+IEKufG0rU5d1ir/pVOs5UUKkZrBCx8l5vMj0+HOOpWxeviY6dHXCb0Rs/HSAPGL/F8lgS/wlQ==
X-Received: by 2002:a05:620a:2b8a:b0:7d0:a1d2:436 with SMTP id af79cd13be357-7d3a95d9624mr328743485a.33.1749637424941;
        Wed, 11 Jun 2025 03:23:44 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([204.93.149.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61114ff18sm85664341cf.6.2025.06.11.03.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:23:44 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 11 Jun 2025 06:23:28 -0400
Subject: [PATCH v11 4/6] rust: enable `clippy::as_underscore` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ptr-as-ptr-v11-4-ce5b41c6e9c6@gmail.com>
References: <20250611-ptr-as-ptr-v11-0-ce5b41c6e9c6@gmail.com>
In-Reply-To: <20250611-ptr-as-ptr-v11-0-ce5b41c6e9c6@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
 Tamir Duberstein <tamird@gmail.com>, Benno Lossin <lossin@kernel.org>
X-Mailer: b4 0.15-dev

In Rust 1.63.0, Clippy introduced the `as_underscore` lint [1]:

> The conversion might include lossy conversion or a dangerous cast that
> might go undetected due to the type being inferred.
>
> The lint is allowed by default as using `_` is less wordy than always
> specifying the type.

Always specifying the type is especially helpful in function call
contexts where the inferred type may change at a distance. Specifying
the type also allows Clippy to spot more cases of `useless_conversion`.

The primary downside is the need to specify the type in trivial getters.
There are 4 such functions: 3 have become slightly less ergonomic, 1 was
revealed to be a `useless_conversion`.

While this doesn't eliminate unchecked `as` conversions, it makes such
conversions easier to scrutinize.  It also has the slight benefit of
removing a degree of freedom on which to bikeshed. Thus apply the
changes and enable the lint -- no functional change intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#as_underscore [1]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                           |  1 +
 rust/kernel/block/mq/operations.rs |  2 +-
 rust/kernel/block/mq/request.rs    |  7 ++++-
 rust/kernel/device_id.rs           |  2 +-
 rust/kernel/devres.rs              | 13 +++++-----
 rust/kernel/dma.rs                 |  2 +-
 rust/kernel/drm/device.rs          |  2 +-
 rust/kernel/error.rs               |  2 +-
 rust/kernel/io.rs                  | 18 ++++++-------
 rust/kernel/miscdevice.rs          |  2 +-
 rust/kernel/mm/virt.rs             | 52 +++++++++++++++++++-------------------
 rust/kernel/of.rs                  |  6 ++---
 rust/kernel/pci.rs                 |  9 ++++---
 rust/kernel/str.rs                 |  8 +++---
 rust/kernel/workqueue.rs           |  2 +-
 15 files changed, 69 insertions(+), 59 deletions(-)

diff --git a/Makefile b/Makefile
index bb33023f87c3..0ba22c361de8 100644
--- a/Makefile
+++ b/Makefile
@@ -480,6 +480,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wunreachable_pub \
 			    -Wclippy::all \
 			    -Wclippy::as_ptr_cast_mut \
+			    -Wclippy::as_underscore \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 864ff379dc91..c2b98f507bcb 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -101,7 +101,7 @@ impl<T: Operations> OperationsVTable<T> {
         if let Err(e) = ret {
             e.to_blk_status()
         } else {
-            bindings::BLK_STS_OK as _
+            bindings::BLK_STS_OK as bindings::blk_status_t
         }
     }
 
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index af5c9ac94f36..fefd394f064a 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -125,7 +125,12 @@ pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
         // success of the call to `try_set_end` guarantees that there are no
         // `ARef`s pointing to this request. Therefore it is safe to hand it
         // back to the block layer.
-        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BLK_STS_OK as _) };
+        unsafe {
+            bindings::blk_mq_end_request(
+                request_ptr,
+                bindings::BLK_STS_OK as bindings::blk_status_t,
+            )
+        };
 
         Ok(())
     }
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 0a4eb56d98f2..f9d55ac7b9e6 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -82,7 +82,7 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
             unsafe {
                 raw_ids[i]
                     .as_mut_ptr()
-                    .byte_offset(T::DRIVER_DATA_OFFSET as _)
+                    .byte_add(T::DRIVER_DATA_OFFSET)
                     .cast::<usize>()
                     .write(i);
             }
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 237182446db3..1e44d70687a8 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -59,19 +59,19 @@ struct DevresInner<T> {
 ///     unsafe fn new(paddr: usize) -> Result<Self>{
 ///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
 ///         // valid for `ioremap`.
-///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE as _) };
+///         let addr = unsafe { bindings::ioremap(paddr as bindings::phys_addr_t, SIZE) };
 ///         if addr.is_null() {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
+///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as _); };
+///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
 ///     }
 /// }
 ///
@@ -112,8 +112,9 @@ fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>
 
         // SAFETY: `devm_add_action` guarantees to call `Self::devres_callback` once `dev` is
         // detached.
-        let ret =
-            unsafe { bindings::devm_add_action(dev.as_raw(), Some(inner.callback), data as _) };
+        let ret = unsafe {
+            bindings::devm_add_action(dev.as_raw(), Some(inner.callback), data.cast_mut().cast())
+        };
 
         if ret != 0 {
             // SAFETY: We just created another reference to `inner` in order to pass it to
@@ -127,7 +128,7 @@ fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>
     }
 
     fn as_ptr(&self) -> *const Self {
-        self as _
+        self
     }
 
     fn remove_action(this: &Arc<Self>) {
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 666bf2d64f9a..8e317005decd 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -38,7 +38,7 @@
 impl Attrs {
     /// Get the raw representation of this attribute.
     pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
-        self.0 as _
+        self.0 as crate::ffi::c_ulong
     }
 
     /// Check whether `flags` is contained in `self`.
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index ef66deb7ce23..b7ee3c464a12 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -89,7 +89,7 @@ impl<T: drm::Driver> Device<T> {
         driver_features: drm::driver::FEAT_GEM,
         ioctls: T::IOCTLS.as_ptr(),
         num_ioctls: T::IOCTLS.len() as i32,
-        fops: &Self::GEM_FOPS as _,
+        fops: &Self::GEM_FOPS,
     };
 
     const GEM_FOPS: bindings::file_operations = drm::gem::create_fops();
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index afcb00cb6a75..fd7a8b759437 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -153,7 +153,7 @@ pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
     /// Returns the error encoded as a pointer.
     pub fn to_ptr<T>(self) -> *mut T {
         // SAFETY: `self.0` is a valid error due to its invariant.
-        unsafe { bindings::ERR_PTR(self.0.get() as _).cast() }
+        unsafe { bindings::ERR_PTR(self.0.get() as isize).cast() }
     }
 
     /// Returns a string representing the error, if one exists.
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 72d80a6f131e..c08de4121637 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
 use crate::error::{code::EINVAL, Result};
-use crate::{bindings, build_assert};
+use crate::{bindings, build_assert, ffi::c_void};
 
 /// Raw representation of an MMIO region.
 ///
@@ -56,7 +56,7 @@ pub fn maxsize(&self) -> usize {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, io::{Io, IoRaw}};
+/// # use kernel::{bindings, ffi::c_void, io::{Io, IoRaw}};
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
@@ -70,19 +70,19 @@ pub fn maxsize(&self) -> usize {
 ///     unsafe fn new(paddr: usize) -> Result<Self>{
 ///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
 ///         // valid for `ioremap`.
-///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE as _) };
+///         let addr = unsafe { bindings::ioremap(paddr as bindings::phys_addr_t, SIZE) };
 ///         if addr.is_null() {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
+///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as _); };
+///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
 ///     }
 /// }
 ///
@@ -119,7 +119,7 @@ pub fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(addr as _) }
+            unsafe { bindings::$c_fn(addr as *const c_void) }
         }
 
         /// Read IO data from a given offset.
@@ -131,7 +131,7 @@ pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$c_fn(addr as _) })
+            Ok(unsafe { bindings::$c_fn(addr as *const c_void) })
         }
     };
 }
@@ -148,7 +148,7 @@ pub fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as _, ) }
+            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
         }
 
         /// Write IO data from a given offset.
@@ -160,7 +160,7 @@ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as _) }
+            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
             Ok(())
         }
     };
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 939278bc7b03..288f40e79906 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -34,7 +34,7 @@ impl MiscDeviceOptions {
     pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
         // SAFETY: All zeros is valid for this C type.
         let mut result: bindings::miscdevice = unsafe { MaybeUninit::zeroed().assume_init() };
-        result.minor = bindings::MISC_DYNAMIC_MINOR as _;
+        result.minor = bindings::MISC_DYNAMIC_MINOR as ffi::c_int;
         result.name = self.name.as_char_ptr();
         result.fops = MiscdeviceVTable::<T>::build();
         result
diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index 31803674aecc..6086ca981b06 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -392,80 +392,80 @@ pub mod flags {
     use crate::bindings;
 
     /// No flags are set.
-    pub const NONE: vm_flags_t = bindings::VM_NONE as _;
+    pub const NONE: vm_flags_t = bindings::VM_NONE as vm_flags_t;
 
     /// Mapping allows reads.
-    pub const READ: vm_flags_t = bindings::VM_READ as _;
+    pub const READ: vm_flags_t = bindings::VM_READ as vm_flags_t;
 
     /// Mapping allows writes.
-    pub const WRITE: vm_flags_t = bindings::VM_WRITE as _;
+    pub const WRITE: vm_flags_t = bindings::VM_WRITE as vm_flags_t;
 
     /// Mapping allows execution.
-    pub const EXEC: vm_flags_t = bindings::VM_EXEC as _;
+    pub const EXEC: vm_flags_t = bindings::VM_EXEC as vm_flags_t;
 
     /// Mapping is shared.
-    pub const SHARED: vm_flags_t = bindings::VM_SHARED as _;
+    pub const SHARED: vm_flags_t = bindings::VM_SHARED as vm_flags_t;
 
     /// Mapping may be updated to allow reads.
-    pub const MAYREAD: vm_flags_t = bindings::VM_MAYREAD as _;
+    pub const MAYREAD: vm_flags_t = bindings::VM_MAYREAD as vm_flags_t;
 
     /// Mapping may be updated to allow writes.
-    pub const MAYWRITE: vm_flags_t = bindings::VM_MAYWRITE as _;
+    pub const MAYWRITE: vm_flags_t = bindings::VM_MAYWRITE as vm_flags_t;
 
     /// Mapping may be updated to allow execution.
-    pub const MAYEXEC: vm_flags_t = bindings::VM_MAYEXEC as _;
+    pub const MAYEXEC: vm_flags_t = bindings::VM_MAYEXEC as vm_flags_t;
 
     /// Mapping may be updated to be shared.
-    pub const MAYSHARE: vm_flags_t = bindings::VM_MAYSHARE as _;
+    pub const MAYSHARE: vm_flags_t = bindings::VM_MAYSHARE as vm_flags_t;
 
     /// Page-ranges managed without `struct page`, just pure PFN.
-    pub const PFNMAP: vm_flags_t = bindings::VM_PFNMAP as _;
+    pub const PFNMAP: vm_flags_t = bindings::VM_PFNMAP as vm_flags_t;
 
     /// Memory mapped I/O or similar.
-    pub const IO: vm_flags_t = bindings::VM_IO as _;
+    pub const IO: vm_flags_t = bindings::VM_IO as vm_flags_t;
 
     /// Do not copy this vma on fork.
-    pub const DONTCOPY: vm_flags_t = bindings::VM_DONTCOPY as _;
+    pub const DONTCOPY: vm_flags_t = bindings::VM_DONTCOPY as vm_flags_t;
 
     /// Cannot expand with mremap().
-    pub const DONTEXPAND: vm_flags_t = bindings::VM_DONTEXPAND as _;
+    pub const DONTEXPAND: vm_flags_t = bindings::VM_DONTEXPAND as vm_flags_t;
 
     /// Lock the pages covered when they are faulted in.
-    pub const LOCKONFAULT: vm_flags_t = bindings::VM_LOCKONFAULT as _;
+    pub const LOCKONFAULT: vm_flags_t = bindings::VM_LOCKONFAULT as vm_flags_t;
 
     /// Is a VM accounted object.
-    pub const ACCOUNT: vm_flags_t = bindings::VM_ACCOUNT as _;
+    pub const ACCOUNT: vm_flags_t = bindings::VM_ACCOUNT as vm_flags_t;
 
     /// Should the VM suppress accounting.
-    pub const NORESERVE: vm_flags_t = bindings::VM_NORESERVE as _;
+    pub const NORESERVE: vm_flags_t = bindings::VM_NORESERVE as vm_flags_t;
 
     /// Huge TLB Page VM.
-    pub const HUGETLB: vm_flags_t = bindings::VM_HUGETLB as _;
+    pub const HUGETLB: vm_flags_t = bindings::VM_HUGETLB as vm_flags_t;
 
     /// Synchronous page faults. (DAX-specific)
-    pub const SYNC: vm_flags_t = bindings::VM_SYNC as _;
+    pub const SYNC: vm_flags_t = bindings::VM_SYNC as vm_flags_t;
 
     /// Architecture-specific flag.
-    pub const ARCH_1: vm_flags_t = bindings::VM_ARCH_1 as _;
+    pub const ARCH_1: vm_flags_t = bindings::VM_ARCH_1 as vm_flags_t;
 
     /// Wipe VMA contents in child on fork.
-    pub const WIPEONFORK: vm_flags_t = bindings::VM_WIPEONFORK as _;
+    pub const WIPEONFORK: vm_flags_t = bindings::VM_WIPEONFORK as vm_flags_t;
 
     /// Do not include in the core dump.
-    pub const DONTDUMP: vm_flags_t = bindings::VM_DONTDUMP as _;
+    pub const DONTDUMP: vm_flags_t = bindings::VM_DONTDUMP as vm_flags_t;
 
     /// Not soft dirty clean area.
-    pub const SOFTDIRTY: vm_flags_t = bindings::VM_SOFTDIRTY as _;
+    pub const SOFTDIRTY: vm_flags_t = bindings::VM_SOFTDIRTY as vm_flags_t;
 
     /// Can contain `struct page` and pure PFN pages.
-    pub const MIXEDMAP: vm_flags_t = bindings::VM_MIXEDMAP as _;
+    pub const MIXEDMAP: vm_flags_t = bindings::VM_MIXEDMAP as vm_flags_t;
 
     /// MADV_HUGEPAGE marked this vma.
-    pub const HUGEPAGE: vm_flags_t = bindings::VM_HUGEPAGE as _;
+    pub const HUGEPAGE: vm_flags_t = bindings::VM_HUGEPAGE as vm_flags_t;
 
     /// MADV_NOHUGEPAGE marked this vma.
-    pub const NOHUGEPAGE: vm_flags_t = bindings::VM_NOHUGEPAGE as _;
+    pub const NOHUGEPAGE: vm_flags_t = bindings::VM_NOHUGEPAGE as vm_flags_t;
 
     /// KSM may merge identical pages.
-    pub const MERGEABLE: vm_flags_t = bindings::VM_MERGEABLE as _;
+    pub const MERGEABLE: vm_flags_t = bindings::VM_MERGEABLE as vm_flags_t;
 }
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 04f2d8ef29cb..40d1bd13682c 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
 
     fn index(&self) -> usize {
-        self.0.data as _
+        self.0.data as usize
     }
 }
 
@@ -34,10 +34,10 @@ pub const fn new(compatible: &'static CStr) -> Self {
         // SAFETY: FFI type is valid to be zero-initialized.
         let mut of: bindings::of_device_id = unsafe { core::mem::zeroed() };
 
-        // TODO: Use `clone_from_slice` once the corresponding types do match.
+        // TODO: Use `copy_from_slice` once stabilized for `const`.
         let mut i = 0;
         while i < src.len() {
-            of.compatible[i] = src[i] as _;
+            of.compatible[i] = src[i];
             i += 1;
         }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 33ae0bdc433d..f6b19764ad17 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -171,7 +171,7 @@ unsafe impl RawDeviceId for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::pci_device_id, driver_data);
 
     fn index(&self) -> usize {
-        self.0.driver_data as _
+        self.0.driver_data
     }
 }
 
@@ -206,7 +206,10 @@ macro_rules! pci_device_table {
 ///     MODULE_PCI_TABLE,
 ///     <MyDriver as pci::Driver>::IdInfo,
 ///     [
-///         (pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as _), ())
+///         (
+///             pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as u32),
+///             (),
+///         )
 ///     ]
 /// );
 ///
@@ -330,7 +333,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
         // `ioptr` is valid by the safety requirements.
         // `num` is valid by the safety requirements.
         unsafe {
-            bindings::pci_iounmap(pdev.as_raw(), ioptr as _);
+            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut kernel::ffi::c_void);
             bindings::pci_release_region(pdev.as_raw(), num);
         }
     }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 6a3cb607b332..43597eb7c5c1 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -728,9 +728,9 @@ fn new() -> Self {
     pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
         // INVARIANT: The safety requirements guarantee the type invariants.
         Self {
-            beg: pos as _,
-            pos: pos as _,
-            end: end as _,
+            beg: pos as usize,
+            pos: pos as usize,
+            end: end as usize,
         }
     }
 
@@ -755,7 +755,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
     ///
     /// N.B. It may point to invalid memory.
     pub(crate) fn pos(&self) -> *mut u8 {
-        self.pos as _
+        self.pos as *mut u8
     }
 
     /// Returns the number of bytes written to the formatter.
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index de61374e36bd..89e5c2560eec 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -198,7 +198,7 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
         unsafe {
             w.__enqueue(move |work_ptr| {
                 bindings::queue_work_on(
-                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as _,
+                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as ffi::c_int,
                     queue_ptr,
                     work_ptr,
                 )

-- 
2.49.0


