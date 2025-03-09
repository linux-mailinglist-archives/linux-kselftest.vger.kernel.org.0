Return-Path: <linux-kselftest+bounces-28570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B5A585AD
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 17:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0873AAECA
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 16:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E042F1F4C97;
	Sun,  9 Mar 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7z4I8F0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDCB1F09AE;
	Sun,  9 Mar 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536081; cv=none; b=NLVs0xjmQ7IBtXLvoouv1b+RP//CimAsYjZIWgvfYntaf1UbP7oB/kG5RzPeNCypARMPGkMoew2eLCvi2dTJvueDL55WtWurmyfDNmZCVj8cIkkU83YjK+HNyp6p7ab3zWjmcPeS21OOXP3ruIBjROYRjhZrw4bj8WUXTWhawv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536081; c=relaxed/simple;
	bh=fCDqTpg8R8LtqsDEh5p3KO6EZ7s18zb0MUJ5VQ0JpSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BnVzTS/R0U1+HQD0Z5/GhvEogSTPo6AX+meRAX4H3TBZQotKW4OVnJa2BDjayJ/IkDTlDaxDOPBHQzyLUJ3Xm0vRP3brnffjxT9TavRRZAGptvvmJV5ZKNrF7+E+oRdCyl0evdTgYduKw7tS8CxVSj7QisGHBS8dsRkflMDxHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7z4I8F0; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0a159ded2so383888385a.0;
        Sun, 09 Mar 2025 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741536078; x=1742140878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoHyfUob14DvKOfpuKH2+3sQlvl6ATsOpI2+e8gy5Ok=;
        b=k7z4I8F0qBQ2SXhIN3887Ju/YUoP3RPMHqqhH6J5kQ/pacH9yFFDvS6Pk1glKAKv5v
         d0V9kQkL07ymaUp7qhiX/TzsDjNMaIdiDQVD5pcOCusUIxEw+W5OboeEKzVQLJfg4XHR
         kUaOvMoINxIsg1SmdfdnxuVpT/XYFxz/G4ShSHZhVQEyOXJdK//LdHCUld0vOzjri1+U
         Ax51QEYueHmMTBC97itMnrBXQuBCxrZ6tEmy5AMRr8Z9ovbVYWeG1Hlxd08pesmVEESD
         TSpesZuRjjVFUnbnaTyaizkWi7EY00yunIfvcW/VOCAdvg28PyBZHjpMojmVgQnFoIW8
         eplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741536078; x=1742140878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoHyfUob14DvKOfpuKH2+3sQlvl6ATsOpI2+e8gy5Ok=;
        b=mjC8fyyCxAorBIeXeLvzrTjZexXqGAhInI1BL1fSStO7caVTgmySKMmFrtUhcZOaKi
         x35qiK0TvistWJRnXOq2984O3jEX1oeYhTEWTREW7bER6GjpxSOh2hH0xc4i1Mu0dml5
         XmYcRMsqTe8iXedRT3sPVFapIuQ4I1S9Nxp8U11jBsq2RCREnaABoXnE234Y5gq7Mc5Q
         hcSOdh6HL6spZiHNVY4NLGb9dMtoLHx6XE1CPmdN3HlZ0LSZSv4dGyhYMDP+7sVZUzUu
         2VUOUI5LxJT6Ot2Y1v/q5p0OV7+xuMi/rphindAjC8WxM+TF8du4yBEaJgUJ2hgTRll5
         yvyw==
X-Forwarded-Encrypted: i=1; AJvYcCUKt9Y0+K3zXRvg0okrOzjXrNXAFltd4Y6N4G7bPgpUfoih9QPNo9aELslQqhtHMC3ABWgS8rzUsJQW@vger.kernel.org, AJvYcCVeA2R07XbGTjrHEGqYoY9lR8FQvNk7m/0BE1Muw8+GJZQcB4ZhlFqXSo0f+j6u41WSMNQIkxcWM7UaTp0=@vger.kernel.org, AJvYcCW85QS50W447ETSs7KMGtgZlbbxOQSj82Obgfy4rV9EVqsMUQRD0dGVBKbQYh2ffXfkHtTNnrBu3vl7031o+ec7@vger.kernel.org, AJvYcCW8ULSXhQDmV18cR9c2MJppBJpWOt5KD3JNJ8aiXD7/xOwCQMXyll98lKXvDAf0HzwxcgJtkocbhVIO4xRlhMM=@vger.kernel.org, AJvYcCWtzzvXI8C2YBu3ygGXFl7XTqpyM0wOKeoA4g3+GKc1eH3XKu5Pp2uOU02JhO0M+K8Q4aGJl3WpT/BB@vger.kernel.org, AJvYcCXl6JNhjfGdAtymt1u3XxpnqO5+ADcypQ8DlKTj9Azv+hvhV5L5Cxai2fSERXxexl1d5mVSdX1g/jOoAzvi@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvF3P+yMsxDnEgGPFrwTcIujBannl1IKhNYUONVmKYzUsJorQ
	r9oWCt5KjG+6c5/ZRwUjZFWXukCkxIVnzK8yV0ci+ZtukLXBxZ8g
X-Gm-Gg: ASbGncty1dnLqt8woqC9qhaLBIz0AV/G8P5a9Em7aXYZRcIj8YwgTKm3jpp2NtWS8iE
	6hx9lhONSmkC5AErhUuGVk+l/m3/mA258MHTPEYGGe0u/MIjfS9wewV8Lfy4cF0scT4TXnAVhYm
	lCg9IoY7/e0DZrMr3WCnadGlb8GNl8zFdVTKFYQ4SgGKTBafQ/0IIqAMKBfn6HWtjewIbktwqyR
	pYcPR3AhVbV5dOWHy6xb9UpXfZERnJj5W916NMz0pCIx5LJ5nYwgAlvNaJ+exlis7m8c7Nhz8wT
	FM7LSQCxCjmaGmDObhEh41oGigIAu6q6UEbmCJ9wBlBAWFOMnlvPXgWjDyD5IeI15eZa10sVOef
	Kwg==
X-Google-Smtp-Source: AGHT+IEGIms/3vQ/gA6TWTl1LA1mEziWYzrUFTTavtJ4+yKo7aU9mNn3PmyPTfifXVtGJo5A5tDUKQ==
X-Received: by 2002:a05:620a:6190:b0:7c3:c1e0:4df8 with SMTP id af79cd13be357-7c4e619e37amr1556037185a.50.1741536078147;
        Sun, 09 Mar 2025 09:01:18 -0700 (PDT)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534d38dsm512531485a.44.2025.03.09.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 09:01:16 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 09 Mar 2025 12:00:44 -0400
Subject: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
In-Reply-To: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
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
 Saravana Kannan <saravanak@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
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
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                           |  1 +
 rust/kernel/block/mq/operations.rs |  2 +-
 rust/kernel/block/mq/request.rs    |  2 +-
 rust/kernel/device_id.rs           |  2 +-
 rust/kernel/devres.rs              | 15 ++++++++-------
 rust/kernel/error.rs               |  2 +-
 rust/kernel/firmware.rs            |  2 +-
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
index 10c6d69be7f3..bcf2b73d9189 100644
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
index 598001157293..20159b7c9293 100644
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
+///         let addr = unsafe { bindings::ioremap(paddr as u64, SIZE) };
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
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 8654d52b0bb9..eb8fa52f08ba 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -152,7 +152,7 @@ pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
     /// Returns the error encoded as a pointer.
     pub fn to_ptr<T>(self) -> *mut T {
         // SAFETY: `self.0` is a valid error due to its invariant.
-        unsafe { bindings::ERR_PTR(self.0.get() as _).cast() }
+        unsafe { bindings::ERR_PTR(self.0.get() as isize).cast() }
     }
 
     /// Returns a string representing the error, if one exists.
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index c5162fdc95ff..9a279330261c 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -61,7 +61,7 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
 
         // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
         // `name` and `dev` are valid as by their type invariants.
-        let ret = unsafe { func.0(pfw as _, name.as_char_ptr(), dev.as_raw()) };
+        let ret = unsafe { func.0(pfw, name.as_char_ptr(), dev.as_raw()) };
         if ret != 0 {
             return Err(Error::from_errno(ret));
         }
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d4a73e52e3ee..d375eed73dc8 100644
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
+///         let addr = unsafe { bindings::ioremap(paddr as u64, SIZE) };
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
index 63218abb7a25..a925732f6c7a 100644
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
index 6a1a982b946d..0b80a119d5f0 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -692,9 +692,9 @@ fn new() -> Self {
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
 
@@ -719,7 +719,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
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


