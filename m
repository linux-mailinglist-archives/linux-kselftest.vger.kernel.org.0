Return-Path: <linux-kselftest+bounces-29040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227E0A6113E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B418D1B61BA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E834201021;
	Fri, 14 Mar 2025 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jke1LHmb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89DC200119;
	Fri, 14 Mar 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955309; cv=none; b=NVxVAVxfDT/PPYNwi15TlaT1gymhtfwf14ctnTi4zhfN5WybtF70BZmsmATHKUEl8R89mMlyjYdNL4h1shQNFKB6t2AO7VDTTXQHQYFdDCTiJAkbHDDBLHHtdWkirVetClRUKAnhQgc4xzgWFvQxGOfp2RlN8VCqrR6T2ZWYB/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955309; c=relaxed/simple;
	bh=GjqcFhbKyP1Tfl/rwn6t+T5mE7qd4XTfOKmHw1ccQ2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CinTn0eMTfcYJ/d5kfZVcJMSw/ckDevqNwXPTdQ+sJHBXwWlabD1MePkAT9/03kvjCCci2ewEj4kH5qKpOvWswHziu1JpusGpnWLh7tBefqYoJQ5env9Zm3FcNRNnKnaoI5vBpmJPttgLnRFmnwHZIYX/oYq5fqLmHne2L7QnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jke1LHmb; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47691d82bfbso2179631cf.0;
        Fri, 14 Mar 2025 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741955305; x=1742560105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZifGGbZMblYnDdx8Dl/yyVQfGrkwr8ROndfS0+kz9yY=;
        b=Jke1LHmbhK92m+YpuBbpe/F/gxOnmTcwOa4HU7V1LILxNdw/voiPPPLdxDToHay23P
         kDCoXh1hEvpHtuHZCtbBtHn/GKtMpRCqLp2jVzgCkaQoVWwhzEoAoVS2yEfjATcYVGfn
         ooE1jtdKBRaiI9aqFKiLH7m1S/6YA1TJgHq1arKP9rpXyzZLHUMuAdipJc/Zy9VRDe/b
         2QlSgFYEcMRWR1JV4GPVZDh7ZoyDaZgLifI0VTQMVry1qg/3/FKE2a5zZN40rtsr5bS3
         vi4tNRqu/+LadNoeNn9wymb8XtrYl4IYyJ6yPcZyGwKJh1NP+lQnXYHOx0uGbqKuPwM7
         BaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955305; x=1742560105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZifGGbZMblYnDdx8Dl/yyVQfGrkwr8ROndfS0+kz9yY=;
        b=Sev+WaLUCpDp8fbrKWfFAYRdGyMQYsqx5ncM+lRBEbM+pG4GZpQI/eh4yqQLh9bXTQ
         c+SqgKLS/SkPmbh6N0UrSLyq7PHZIbZvEp6ZbXThXT1rmh3mGHUjWtsHIjbjs8/2oNJZ
         ssqTKs/5/2M6QRJo1ii/wC3Ni6OlDY7cI8FdNh9T82+AaqtJ0DpZecbOu6Z4/ZEL1GaL
         r00V5ph7cq9IwAzJvnR7uLbm7c25ZA7ba7cQlv+giOxXj5PRrz1pp8VUUMLOotZGTv9x
         lcm9lAqZL5xDORbyAiS8/tgOnn7SCwCPD7hqXrQ7s+zCdXQku4vxZPWz0F98puKBtoED
         qVbA==
X-Forwarded-Encrypted: i=1; AJvYcCUjfOE0kJp83k5YrVmwNrVi0AVbcpGQoyAavOXw+3tQAgGWhqcv/l/33WP8bHnGFiFBlFNyDtrhhSTV@vger.kernel.org, AJvYcCVLLCkLpCXv4isTUVZQ20+Eu496i0OeZXnlIM/70/inanQbVvAmqri+y62tZeKpCJ82tWO2cImdXamJqpPkmCUQ@vger.kernel.org, AJvYcCVbvFGQ8AvnffcJfP3r1Tok8Jt1JJwmro+VguH29InPu6W4dfCQxcFSf7yj5cwF5CVChYbWNhKvnw+kvFo=@vger.kernel.org, AJvYcCW9xQycze0teG8jGKqbpS0rEpgGicFfmCdAzSwjaSsJ0oPgtFHCAyccyiHIhcaj1E3rQPIbYynxIi5xBnXB@vger.kernel.org, AJvYcCX5NOzhrdZ+ahm86Rby9zfBrHn4tgkUtT3JYVFXuvaTa5ByymneXoUbtq2KCG6ZFiTDDvzIoaYWOWji@vger.kernel.org, AJvYcCXhZaOxA4kdosPxiBxRsVqOmPGv0oTYrXQAEGy0qjZhaNxiP3u5Sdt+9mbJwNayo9kGQBlvXjHaX75MKhecjYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0CRdK+ZvQjCo4qForLORdU7yrFGaYo1xaBnw/UzRquUyNjGW
	lBsUAi4Mbn/xAecrtLi+7clvFO2bI+MfjS93EGn32rRopZfhMyCS
X-Gm-Gg: ASbGnct5t+Lne7Xj4YpkUuzvh/pBqUcHm1x48GZIMgkSD3XtTDHZNLjXNQbFtaX6K47
	t2AZwJ/KJWSqCkg+NkAdEYf+L6teQseILkQYwM4ZmSePF0p1/ytDeLTGFmZ5+w16Fdw2LowEkJS
	JR1xe5ZD6V6umTpeRm91opGvhWqi9BUqGrrfC8rogYDIhbcRS8pfYcZgIOEmzv4AghT6nOrh+3K
	ppmFFuGjqlD1UQ63J1z8POWKQqi0IA78IP5wg5ichGdhZRyAw9TUzd4M7T+bFjfwFzFqMWt0g99
	qonC/bfgVRUAByAusNXeNSR2jNfhWOxzRVhUeCK6uGVFdF8icTSscTu/2qIVi4uBH0ZZ
X-Google-Smtp-Source: AGHT+IGj2Zt0STQFf6YXa3nQ/MKf2mEBHKJtlK3C/Nknu8k7+yQ/aPYig2Q3finXZLvFo7EdtckPMw==
X-Received: by 2002:a05:622a:249:b0:476:8f90:b5b5 with SMTP id d75a77b69052e-476c8152cc3mr32652811cf.27.1741955305440;
        Fri, 14 Mar 2025 05:28:25 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:cd19:6a0f:e1a6:e800])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63f3a4sm21905821cf.30.2025.03.14.05.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:28:24 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 08:28:09 -0400
Subject: [PATCH v3 5/6] rust: enable `clippy::as_underscore` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-ptr-as-ptr-v3-5-e7ba61048f4a@gmail.com>
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
In-Reply-To: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                           |  1 +
 rust/kernel/block/mq/operations.rs |  2 +-
 rust/kernel/block/mq/request.rs    |  2 +-
 rust/kernel/device_id.rs           |  2 +-
 rust/kernel/devres.rs              | 15 ++++++++-------
 rust/kernel/error.rs               |  2 +-
 rust/kernel/io.rs                  | 18 +++++++++---------
 rust/kernel/miscdevice.rs          |  2 +-
 rust/kernel/of.rs                  |  6 +++---
 rust/kernel/pci.rs                 |  9 ++++++---
 rust/kernel/str.rs                 |  8 ++++----
 rust/kernel/workqueue.rs           |  2 +-
 12 files changed, 37 insertions(+), 32 deletions(-)

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
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 8c62cff8742e..f4482c9a8d82 100644
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
index 51eb40d0abaa..954ab4d88f3d 100644
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


