Return-Path: <linux-kselftest+bounces-30434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DDCA82911
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011E89A0CDD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA2B26A0F7;
	Wed,  9 Apr 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ9GBh0A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B32D269AF5;
	Wed,  9 Apr 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210056; cv=none; b=m10YCyPM3PEnhPpJzOYQ7SD0V+MchiEBAfIP/HKY4jFZBlAJ36b/i8fcKQwqEekapty5400szeQ0BevWrxyo9v6uQfMv3lnKAyoX2u7FUhLaNCRcDnd26X/W/D/QYS1vVaSZ5b7tvL6/rjpauaTw6Ofy2PbTIOmC1aiHKaib2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210056; c=relaxed/simple;
	bh=5UmLEVObapEnvipAfSyAuaBvNO6RN4ZH2PMv3QOMuP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IzmKN1RGJfbBxc9QBFtNaWqyPdSO7f/pN1gfuxuN6hRPrdPlOvfQaHdVz+tBRpuEtrcekb9Zpi7snhqinoH+zw2dxHvgtfembTY40VHY8wqO98kuicUk2dRehXONk2uIW7NEam8S59ylMevnT3xQ5l5WwCSOoJ0Iuuyyqx3rujU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ9GBh0A; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4768f90bf36so62469381cf.0;
        Wed, 09 Apr 2025 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210052; x=1744814852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4UPBdd5SJXFrhjmgY68FJk5v3e9Xn2t23RkFbhT7Aw=;
        b=hJ9GBh0Avn1v/pC9GQvftmumn5embPfOPZza/g7F1QOkSb9+j9A4VNvNg11IiHW8Ky
         JtckqErk4EkGSAUzqFgSh1gpSqByX2rmTV9eEIDXhMk46aHt5cEDdiFo/79MRv4bLWgy
         RAhRIBKiK2GtzF4oSfM6xGSsFOSomo0dX64GO2SkFD9Fsb45ur7IsdX3154mXXQZYZjv
         nN6x2lbQh+Z3VVFOLu6xeWN1LCVEh6jByPwOyGfyFybRkrELYR7YlKUSaLvmP9vpRNdg
         STbqiRV/Lcvy+tvAsE2+4fxmAKWIFEROFggvaXGVKdeyKdWwwTJq3qIogr6K82S47J7q
         /nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210052; x=1744814852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4UPBdd5SJXFrhjmgY68FJk5v3e9Xn2t23RkFbhT7Aw=;
        b=mgwaUvu4MDC17Wr65W1BzO1EugpM0aZgH5rfBReZNPjBQ2XMOkjFT2M/0DlE506eth
         d+4m4TE3cX5apttJbFEQQG1RxrQXPv4n6HWlOJpKsTfY9O8ckMNSdWVleF8CjmNAJCpK
         nIzXi85JD0GRTRCTZfgijvohrDQLnzvcLly9w2Iu0E/61MedIPM/Yhd6aMYyfNQPmcCw
         u67/fL9wUNedQofkMtsdgkNKHN3KC1VHqW4Q0Kp4L18gCZy7OI0FEKTQH5YLV9aPobTj
         d/bL3d1/m2Lmhg99XeESerwrOC+nuqYt08CBWMGKsm22A6FTNCNORRm9C18GKml7tId7
         YHuw==
X-Forwarded-Encrypted: i=1; AJvYcCUPfz4kgsJExc72SDfSy6WGPGWDi0SrBGqZS8UgFjbNTTGmIq5M63BtUQ4b4qIRGIjsKe9K37K+kD8y@vger.kernel.org, AJvYcCUhCjKTnjh2yVTk4wvQ7j05kM0z+166vAfPFrD82CikaGVh11EjHFRg0mBpvVXS9DsZi7kpctMQ@vger.kernel.org, AJvYcCV02gkBbFZjKTTdBgKJgRL/juCW7OaaOUKXdpQEg+NvEqR1moOEUIZ+dbXwzDWiOjJZy2W/veT7cBu03MddZrM=@vger.kernel.org, AJvYcCWLIbXgo3x/b9XRr3xq6dhlF+8/HXP+uGnWf5dYo/NgnY6ERgQaScO6kMezNIVMun1mBiL9r4M67CaD2sZU@vger.kernel.org, AJvYcCWVPR3OsZFKPjEQulXITsKmOxBMbX8WNwM6t7ZYGxEDYdHg1hWhHFqteBgVcrahsxEKQeTXX9be8VRf6Ig=@vger.kernel.org, AJvYcCWgclncYSasry8X9gxSIGJBo/x63H0J4fauolEYrr84M18C8RnWxUPVnfkr1Gu0Xdl4yIoXvh6DgqP8@vger.kernel.org, AJvYcCXtnxvsavRUoInc7BIT/H5rIGh28LB/rQS9pqsn1Zeo4rvr8sZEK6fDXdCaVvRuYX5fBYeNW6uQrV+qRhVnZ2MT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhdmc872eZPcYpVSDFmb5qEGFlJDqW47dAP9OHtBuYuwoJQ2L+
	vxX1QHab59YTUVo2nAtqXnFnz8w/cHv3ONzA2VbOkd1aZ8zVENzw
X-Gm-Gg: ASbGncvVDLix9QOQ2AN1ihy/WO3STSuhYtQgRzGHDEEe7ZedfacwUl2JKr6ee39VSuw
	AylfY/+SQEvWeA7yJb4RXy0HWOfW9dv+vGX6EoDSAj0Isp48ZzHAjaIGlheBJoKyQJ23rDdwfoS
	CP0OSaG7AUFStxXvDobflpaEOyXIzbp50mB5HhNo0g2aGytpgV1EUT3uIxtzCf4bDuXWJdyklzU
	7/g1tqka0VcvWeBB2I2UcZPCAET4CRfAUFUpWZFBmD7X7bmQcBzMw2EPIUyNCOfOKe6MsSibbus
	HVxujmeWiNyYwOprZ8oQDBN+o7R8T7dHYMnhx6fb9Q+ia6/jTTDqcSMMSKGuojZcnlexZfiKZoQ
	uVp1OLfc3S85BAr2M3QYJ1htfo1GWgSWKKgX7/NhwulrK
X-Google-Smtp-Source: AGHT+IHYKO7pvQNcSqmFLErafer3Zu2+iSrCqMO0EiGXQZCf4IjjwADj+gDflwMqdkbewLvTvuX/Yg==
X-Received: by 2002:ac8:7f42:0:b0:476:b73c:4ad2 with SMTP id d75a77b69052e-47960079dcbmr27062361cf.9.1744210052013;
        Wed, 09 Apr 2025 07:47:32 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:3298])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964eb9a8fsm8024461cf.49.2025.04.09.07.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:47:31 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Apr 2025 10:47:21 -0400
Subject: [PATCH v8 4/6] rust: enable `clippy::as_underscore` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-ptr-as-ptr-v8-4-3738061534ef@gmail.com>
References: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
In-Reply-To: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
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
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
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
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                           |  1 +
 rust/kernel/block/mq/operations.rs |  2 +-
 rust/kernel/block/mq/request.rs    |  2 +-
 rust/kernel/device_id.rs           |  2 +-
 rust/kernel/devres.rs              | 15 ++++++++-------
 rust/kernel/dma.rs                 |  2 +-
 rust/kernel/error.rs               |  2 +-
 rust/kernel/io.rs                  | 18 +++++++++---------
 rust/kernel/miscdevice.rs          |  2 +-
 rust/kernel/of.rs                  |  6 +++---
 rust/kernel/pci.rs                 |  9 ++++++---
 rust/kernel/str.rs                 |  8 ++++----
 rust/kernel/workqueue.rs           |  2 +-
 13 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/Makefile b/Makefile
index 04a5246171f9..57080a64913f 100644
--- a/Makefile
+++ b/Makefile
@@ -475,6 +475,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wunreachable_pub \
 			    -Wclippy::all \
 			    -Wclippy::as_ptr_cast_mut \
+			    -Wclippy::as_underscore \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 864ff379dc91..d18ef55490da 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -101,7 +101,7 @@ impl<T: Operations> OperationsVTable<T> {
         if let Err(e) = ret {
             e.to_blk_status()
         } else {
-            bindings::BLK_STS_OK as _
+            bindings::BLK_STS_OK as u8
         }
     }
 
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index c9f8046af65c..807a72de6455 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -125,7 +125,7 @@ pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
         // success of the call to `try_set_end` guarantees that there are no
         // `ARef`s pointing to this request. Therefore it is safe to hand it
         // back to the block layer.
-        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BLK_STS_OK as _) };
+        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BLK_STS_OK as u8) };
 
         Ok(())
     }
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index e5859217a579..4063f09d76d9 100644
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
index f7e8f5f53622..70d12014e476 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -45,7 +45,7 @@ struct DevresInner<T> {
 /// # Example
 ///
 /// ```no_run
-/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::{Io, IoRaw}};
+/// # use kernel::{bindings, c_str, device::Device, devres::Devres, ffi::c_void, io::{Io, IoRaw}};
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
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
@@ -115,8 +115,9 @@ fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
 
         // SAFETY: `devm_add_action` guarantees to call `Self::devres_callback` once `dev` is
         // detached.
-        let ret =
-            unsafe { bindings::devm_add_action(dev.as_raw(), Some(inner.callback), data as _) };
+        let ret = unsafe {
+            bindings::devm_add_action(dev.as_raw(), Some(inner.callback), data.cast_mut().cast())
+        };
 
         if ret != 0 {
             // SAFETY: We just created another reference to `inner` in order to pass it to
@@ -130,7 +131,7 @@ fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
     }
 
     fn as_ptr(&self) -> *const Self {
-        self as _
+        self
     }
 
     fn remove_action(this: &Arc<Self>) {
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 43ecf3c2e860..851a6339aa90 100644
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
index fa9ecc42602a..6f9a7f97b7e5 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -33,7 +33,7 @@ impl MiscDeviceOptions {
     pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
         // SAFETY: All zeros is valid for this C type.
         let mut result: bindings::miscdevice = unsafe { MaybeUninit::zeroed().assume_init() };
-        result.minor = bindings::MISC_DYNAMIC_MINOR as _;
+        result.minor = bindings::MISC_DYNAMIC_MINOR as i32;
         result.name = self.name.as_char_ptr();
         result.fops = MiscdeviceVTable::<T>::build();
         result
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
index 391b4f070b1c..7efbbe5f8f59 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -169,7 +169,7 @@ unsafe impl RawDeviceId for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::pci_device_id, driver_data);
 
     fn index(&self) -> usize {
-        self.0.driver_data as _
+        self.0.driver_data
     }
 }
 
@@ -204,7 +204,10 @@ macro_rules! pci_device_table {
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
@@ -327,7 +330,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
         // `ioptr` is valid by the safety requirements.
         // `num` is valid by the safety requirements.
         unsafe {
-            bindings::pci_iounmap(pdev.as_raw(), ioptr as _);
+            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut kernel::ffi::c_void);
             bindings::pci_release_region(pdev.as_raw(), num);
         }
     }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 02863c40c21b..40034f77fc2f 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -738,9 +738,9 @@ fn new() -> Self {
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
 
@@ -765,7 +765,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
     ///
     /// N.B. It may point to invalid memory.
     pub(crate) fn pos(&self) -> *mut u8 {
-        self.pos as _
+        self.pos as *mut u8
     }
 
     /// Returns the number of bytes written to the formatter.
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 223fe5e8ed82..7d3a6e586a1d 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -198,7 +198,7 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
         unsafe {
             w.__enqueue(move |work_ptr| {
                 bindings::queue_work_on(
-                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as _,
+                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as i32,
                     queue_ptr,
                     work_ptr,
                 )

-- 
2.49.0


