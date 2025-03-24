Return-Path: <linux-kselftest+bounces-29716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AEBA6E654
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8E53B82DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA12E1F4193;
	Mon, 24 Mar 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG1NQeeH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988DC1EDA33;
	Mon, 24 Mar 2025 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853716; cv=none; b=qiJQmZimCqSeLC7vBD1bh9MqopfOLobqrv6kLbiBex57TBeEgUK1FAOrq9sw0AWrYlNe0JJ9Z4hoQlbH9TqYlyZWoWSnObfxcwoDfAuu/BPWXDRgEE24FBnYn1a7NICIJvbiAuxRZwxG8x4rygJs0jAhGZfdATA1PFUyNKwZYTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853716; c=relaxed/simple;
	bh=vaB+g5yKu2Mlnf772JK5VkB679nHOhi2QuEegk9Z1pA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FtLJZjzkoQz31V9Dfc2G3DCMxqIT3UfFq26isW1kxozKK/xS6gWUl+QNRr8G1ASt039d38KyCJqfjXXsiuIqibzhumRoHAZc2dyPGvAWiEjS7Vlq2WanYJ6JJPRO81+dRdR/5ohhbULj4xE4wENtGqKu1uBUIf7XUSFyJo0C6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RG1NQeeH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476f4e9cf92so33006381cf.3;
        Mon, 24 Mar 2025 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742853712; x=1743458512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3msj9yCtJiGy0EO2iHZnNA6wr/0BgpnHoxtNdRcAn/w=;
        b=RG1NQeeHT6Nf0y1HV8JSBQwdLUmTkAz9e0ascPHJ5X8E1lR95FrEvzTj3WnsXcaJhP
         kvn19PBLdlaBYWrWLHeyXI1zasXWXKVECP1ZHiXPzrAYRriG4J6IdePgYUhRFHrTrZds
         KMBYHiiy6qA8doFk+O67OkuMJOF3qi+VtbsACfpu1W0dzOYrlBggBSdVsfZOaJKs/i40
         1vwh9j6VQqpXODv9sYh1S9eBkvJDf7Ca6yjh3y3ZhyjT9rWqhaMvbEEzc+irycRcAAwQ
         sFjBBt9pw9H6Mq7K3tNrAYrkYwEsQwoNst4stKliF/zgpDDc6ZzVR9mbYGu+EtLfo7Cs
         3pIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853712; x=1743458512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3msj9yCtJiGy0EO2iHZnNA6wr/0BgpnHoxtNdRcAn/w=;
        b=ib/uP+6MtfsuAulL+Q2nhRlMQ7TeFFKi/t1vHxpqpU55oKVmDXRYTNgrJnRq78Jbdp
         9//+Rx3aiJst+l5jxYyC1x4ZvFfa728aZ7+BtbXDe6uD3MXu7hXfvIHpreJmUG2xwx23
         oj3XcpkCyirLX/Mi14JE5fDJpk5EqYyoGd6657sBFYGwI71pZMTaEi34WlUyq+VqPbEu
         kCPzfTrD0EBZZfTJlRlcqOxne8KORaDGkWuiq0SD9yhfx1hP7MBLZ/eZjDvtRFKly+PN
         qTUyy0/cZeAWmaaoYxRYvqAcim7ECrVy3b7DtDg6/r+xK+UFHfHxYvHtzj+oqLdlLiuu
         SBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMvlSMIUZ7OVgHzd3d+g4Q6E0oraMV3p9TkTyv1qmkRe23FkheOIVq2ZZbqTA4mtMQz4gPNA//@vger.kernel.org, AJvYcCUh/dE2z/dO3aRezUfOIP5/7XiW6W+zjCpWH/xeZVfWecsR9AZuK8AaKikYLwpZt0T2k4hai83N0ZTSXhhC@vger.kernel.org, AJvYcCW5MRWekYfNaixORdo4NpBsFEnmhXh63BqpBRQlRbHjNEgcPE2EjUdthV0ua015lRyLbne6ki9AP41rHYw=@vger.kernel.org, AJvYcCWIvw4dTPV6/0ZjCGRCo4bVAHAbFxJNKOvJ1H1jgE62M/CI/ywZHmTfDLnp04jWy2lfpiB5L3VD3AGIP7qyJKg=@vger.kernel.org, AJvYcCWOxZJZR9hJ2y2CPQsHZLZhWyhqkOPaDzue2qy7HQ/wMwAFYIzlqIuo9FxsrA8BHKmw2d9NMxrlbF5x@vger.kernel.org, AJvYcCXdaAFWA7+2zaK/mbGyeRHkvsOh0lpYNJ5EPjL1r8FYZJBQ1q12KVUvvEIu+6oGtye/BHNTwhyNaLedmOXcRvna@vger.kernel.org, AJvYcCXe0et6llvhRUSok4YfwWGj5yLd/KiZQ2hkBAV4jm4ijOWUNr82sYVJ0r5j1UUDle7WFC+L/RMT0Hx7@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7Pc9z/7ewy+u4sxNRpT3q1hKM8FbttALv7mNeIBTY7qD+0EL
	dm1xF+s83zkSmot5kjbNL5UH3+evAMMpfU1BbamtNKlGWHW0i0sy
X-Gm-Gg: ASbGnctReSxwABnGeJfanHlwY7G0TCXii1prj/waHwilmh7plahZOeDQO2+4tcT9l5U
	ohhSwjONnd5nU/s2Ew5YIRz6eXhGzg8hNrJuwOS4QIesZ49ssaksB0sXtVc+TT/iOpobN3nYR42
	6OwpkSjJXXThhRaynolWUdAqq3UbBD9BJGuRqU53wZRsqYw9Kn4KeEyHoFmIUdfSGwP8nWCVh1g
	jcruO1cNJApJzi7AZ4qTPNb2LpNy1aNdzGSU2a+rRHPgjFQepyWPMlpBPJoTsLDwMZXGts8W10W
	g3yMWaJyP7VLygfYx61u7bIMHxg1h9rRTu3wqJsHFu4R8BCrjEbFcfmumjx8XJYrOTnLF4mKI0P
	knjj9DelwYa/GfUHUqA51x0Q9TC8RwtakSQolrGS+zz2DVBd8q0jhPRpP3UHVvYMr
X-Google-Smtp-Source: AGHT+IGy6TR0vEfH8SPazsfXhisCujtVWVyKHe6XCKSv4lKoF54XubMeM3jWpXfsqZ4o8KMulfUKQA==
X-Received: by 2002:a05:622a:4d0e:b0:477:114a:ba0c with SMTP id d75a77b69052e-4771dd61cb1mr222380531cf.6.1742853712003;
        Mon, 24 Mar 2025 15:01:52 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d0ad87esm52129541cf.0.2025.03.24.15.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:01:51 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 18:01:34 -0400
Subject: [PATCH v6 5/6] rust: enable `clippy::as_underscore` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-ptr-as-ptr-v6-5-49d1b7fd4290@gmail.com>
References: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
In-Reply-To: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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
 FUJITA Tomonori <fujita.tomonori@gmail.com>
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
index bb15b86182a3..2af40bfed9ce 100644
--- a/Makefile
+++ b/Makefile
@@ -478,6 +478,7 @@ export rust_common_flags := --edition=2021 \
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
index 598001157293..34571f992f0d 100644
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
index b0e3d1bc0449..cff84d427627 100644
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
index d4a73e52e3ee..9d2aadf40edf 100644
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
-            unsafe { bindings::$name(addr as _) }
+            unsafe { bindings::$name(addr as *const c_void) }
         }
 
         /// Read IO data from a given offset.
@@ -131,7 +131,7 @@ pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$name(addr as _) })
+            Ok(unsafe { bindings::$name(addr as *const c_void) })
         }
     };
 }
@@ -148,7 +148,7 @@ pub fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$name(value, addr as _, ) }
+            unsafe { bindings::$name(value, addr as *mut c_void) }
         }
 
         /// Write IO data from a given offset.
@@ -160,7 +160,7 @@ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$name(value, addr as _) }
+            unsafe { bindings::$name(value, addr as *mut c_void) }
             Ok(())
         }
     };
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index e14433b2ab9d..2c66e926bffb 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -33,7 +33,7 @@ impl MiscDeviceOptions {
     pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
         // SAFETY: All zeros is valid for this C type.
         let mut result: bindings::miscdevice = unsafe { MaybeUninit::zeroed().assume_init() };
-        result.minor = bindings::MISC_DYNAMIC_MINOR as _;
+        result.minor = bindings::MISC_DYNAMIC_MINOR as i32;
         result.name = self.name.as_char_ptr();
         result.fops = create_vtable::<T>();
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
index 003c9aaafb24..a26f154ae1b9 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -166,7 +166,7 @@ unsafe impl RawDeviceId for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::pci_device_id, driver_data);
 
     fn index(&self) -> usize {
-        self.0.driver_data as _
+        self.0.driver_data
     }
 }
 
@@ -201,7 +201,10 @@ macro_rules! pci_device_table {
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
@@ -317,7 +320,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
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
index 8ff54105be3f..d03f3440cb5a 100644
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
2.48.1


