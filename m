Return-Path: <linux-kselftest+bounces-29226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBEDA65340
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D529189BB4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C82459D7;
	Mon, 17 Mar 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAhYlstJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED465242915;
	Mon, 17 Mar 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221441; cv=none; b=lzhEMTPhQEcutufR2laVmXyMoTYsFS+dUFnirlvIhHqv7v1/0ieeoC5sE3zozs3TVwER+BwIubKn4ESw1WNKVFLXLJwI3QZs70XVmxNoLSGkrGw3OELgG/yGsE/l0gk3QC1OBBFMWn7zgvoDORFRuSiOVcP2kWaatshF4SJJsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221441; c=relaxed/simple;
	bh=bLj1lCQhwechJ/KYJ981kIYuutyn+Ax5IBNtHzsp3As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvMepV3LgpRU0q9c+wda8g3Ddn3W2EhxsF7XyqcghSmm4+NMY4kgAtbjdffOn8onZ53EtYn4bGSMTWtHbhHHrMvlYp+mXEG7RYCWcSaAK1Kmo/oRh13jX2CPs3Nz+DdonR8SbHDDCVBfp0MiVGdFbh/dH58nyzOXyVbpsBBBAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAhYlstJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c554d7dc2aso741734485a.3;
        Mon, 17 Mar 2025 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742221438; x=1742826238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B41I45ZtntWIGMfCDbZ2RGkAC7sZEShqmrbzHTGpLoI=;
        b=GAhYlstJq9n00dyBmzpxyNVPPi6GeHb760naKUu+E+Fnx1M87T3jZYdR+j4V2OPNCR
         rPkGAXPB1/jGkNsvQ2urQSdHWTYYIs8DRwFGqLN3q49o8WepADXnB09s+aMvpS8uoWBa
         ZlMBrL+ZSWyFAuq8xPObTxggOIov8jlbIL5Tb9gKB0JeorPFNGE+DT8WwgEgkfesxlv5
         inA9iuntfFja1acbpBdXaDb/khx7wUKX3O5imcWf0u7xs5+ioes77zE+0dwPb0eRYHNn
         T+QOqUEdVr+wqVXoJFbY/C3ej7kmWCAvI90tOnCseWWHdqIPk0JdkEXfKttkdv8P4o99
         gM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742221438; x=1742826238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B41I45ZtntWIGMfCDbZ2RGkAC7sZEShqmrbzHTGpLoI=;
        b=c+DLQubetTh7eN4Ur5nljFGzgWutOqQbWApcoLIO6BWq5Sv3hsAeOQuoeOkgv4Uw+Z
         o3yb29tGFY0n2/YdWOkhQ3JKAFRPiHYDm+Z/A9bbQc7BhCX8IPpukzenmtlcMI6otemo
         ywGXd9z+wapeNSJr5AiBGQrGx9lG82l/c6OorZjYyA/A9uVy2ITz6vXSSsqLRHq+2J+t
         Iq8VyhhXp6W2nK44+kwVzLe5Ife1QStxkaJZlXpGPDfG/umqLkXfZe7PE3ueP/8fNOVs
         9NZ5bUHJgAaC7dtposOyMvC7NlBLraqXvWdviEUBLZSq+xkxEu0l98U42++KP8tJzprt
         wb0g==
X-Forwarded-Encrypted: i=1; AJvYcCUEqqlXzcdlQshSkJLhqKIjp8bdhbXpJ/S9y+TcYA74NNWgaI43YHMFvlgE/ZT1FvGogzeOxtFRF0RMix4=@vger.kernel.org, AJvYcCVJezi0k9EjM3nRq2F6hEklJ5RQy9uPCp2wXkIkIk66MLGt3lP0iVgYll3RglFfcNTJ6f2cW4Kzz0Lz@vger.kernel.org, AJvYcCVgJHP9owVPjnVqYhtRu02tqx0o7Dtzh5olS0um63yQAYRtqe2knxN5TgX7BmDrGLvSGxNSOUmY++sVtSo6rc0=@vger.kernel.org, AJvYcCVp/3msOfoPipa9rKXVUwU4rfcvBqPbmZCVjVnKd8DvKjM1Qq/R59+wBqtFSB19AX726W2qnuT7Aqykxalvdf4F@vger.kernel.org, AJvYcCW0mKqYT6MCyn5nFpiUR0yiN+0V4Hzlra4ydTssXdYSNq+Spoxmi2TSakRQ2YnNZp2WrjTZCdh6OhgUrp3I@vger.kernel.org, AJvYcCXi4YH963+5pIpDWM1jPopwpE+Oj1hdWj1E3e3PjW29tdNWU6jYy16LeQFVHnBGQn9n/6KyC0Jl2w/k@vger.kernel.org
X-Gm-Message-State: AOJu0YwwujABmeh5VIfWoVSr8Y9G8U/d3Uksjgm8FiWz+QzWlWpA5/g4
	y7XOGVQPaadbzFyTnOMyA8TmmnzMOLH0l8Y/Xg8BGeTlssSBD4C1
X-Gm-Gg: ASbGnctSae7fqsrq0PNA447k9BGJBbQvXc3QJDw6XfpCnDBucB6XjYRRAA7xIZGa3XK
	qzF8RdUIWCoSqIaUGnQsG+/FUYJfF3oZNCVXG9FRxs4Njo7EaqFhuGGlzvqFoY9xa1p0Pt5qgqt
	Y6wQIz8ln8W6dq0Afx6EjdKqbvbf0aILfLmEjYwol7y/6oxZiHX+wn3p4YjIspff2vb0nWcPO3O
	KePqqrVQ3vxFM+e6qRQFsHGNWZGvcOwfoCuMWhm5DHKKQPDQF3X7n+k8fTAuczSJfHgzns2tdeL
	Mj856AKYPY4B0c0fqnJnje4UdCE91y54bN4ZnyIIw2HZ3GbkTzPK57kOOidQezrD1En1oBUFnA=
	=
X-Google-Smtp-Source: AGHT+IEoXsnrwxN2Xi8oaVHqyWOXYptgcezswkKcTzWLcM7lNNw1zTK/Y02tYLv9pB6wW5ntdpkMVQ==
X-Received: by 2002:a05:620a:4386:b0:7c3:d5a4:3df3 with SMTP id af79cd13be357-7c57c80f0fbmr1501704685a.34.1742221437530;
        Mon, 17 Mar 2025 07:23:57 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:6895:24c6:e898:e320])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb60b13esm54601011cf.6.2025.03.17.07.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:23:56 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 10:23:52 -0400
Subject: [PATCH v5 2/6] rust: enable `clippy::ptr_as_ptr` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-ptr-as-ptr-v5-2-5b5f21fa230a@gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
In-Reply-To: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
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

In Rust 1.51.0, Clippy introduced the `ptr_as_ptr` lint [1]:

> Though `as` casts between raw pointers are not terrible,
> `pointer::cast` is safer because it cannot accidentally change the
> pointer's mutability, nor cast the pointer to other types like `usize`.

There are a few classes of changes required:
- Modules generated by bindgen are marked
  `#[allow(clippy::ptr_as_ptr)]`.
- Inferred casts (` as _`) are replaced with `.cast()`.
- Ascribed casts (` as *... T`) are replaced with `.cast::<T>()`.
- Multistep casts from references (` as *const _ as *const T`) are
  replaced with `let x: *const _ = &x;` and `.cast()` or `.cast::<T>()`
  according to the previous rules. The intermediate `let` binding is
  required because `(x as *const _).cast::<T>()` results in inference
  failure.
- Native literal C strings are replaced with `c_str!().as_char_ptr()`.
- `*mut *mut T as _` is replaced with `let *mut *const T = (*mut *mut
  T)`.cast();` since pointer to pointer can be confusing.

Apply these changes and enable the lint -- no functional change
intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_ptr [1]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                               |  1 +
 rust/bindings/lib.rs                   |  1 +
 rust/kernel/alloc/allocator_test.rs    |  2 +-
 rust/kernel/alloc/kvec.rs              |  4 ++--
 rust/kernel/device.rs                  |  5 +++--
 rust/kernel/devres.rs                  |  2 +-
 rust/kernel/error.rs                   |  2 +-
 rust/kernel/firmware.rs                |  3 ++-
 rust/kernel/fs/file.rs                 |  2 +-
 rust/kernel/kunit.rs                   | 15 +++++++--------
 rust/kernel/list/impl_list_item_mod.rs |  2 +-
 rust/kernel/pci.rs                     |  2 +-
 rust/kernel/platform.rs                |  4 +++-
 rust/kernel/print.rs                   | 11 +++++------
 rust/kernel/seq_file.rs                |  3 ++-
 rust/kernel/str.rs                     |  2 +-
 rust/kernel/sync/poll.rs               |  2 +-
 rust/kernel/workqueue.rs               | 10 +++++-----
 rust/uapi/lib.rs                       |  1 +
 19 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/Makefile b/Makefile
index 70bdbf2218fc..ec8efc8e23ba 100644
--- a/Makefile
+++ b/Makefile
@@ -483,6 +483,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::needless_continue \
 			    -Aclippy::needless_lifetimes \
 			    -Wclippy::no_mangle_with_rust_abi \
+			    -Wclippy::ptr_as_ptr \
 			    -Wclippy::undocumented_unsafe_blocks \
 			    -Wclippy::unnecessary_safety_comment \
 			    -Wclippy::unnecessary_safety_doc \
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 014af0d1fc70..0486a32ed314 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -25,6 +25,7 @@
 )]
 
 #[allow(dead_code)]
+#[allow(clippy::ptr_as_ptr)]
 #[allow(clippy::undocumented_unsafe_blocks)]
 mod bindings_raw {
     // Manual definition for blocklisted types.
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index c37d4c0c64e9..8017aa9d5213 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -82,7 +82,7 @@ unsafe fn realloc(
 
         // SAFETY: Returns either NULL or a pointer to a memory allocation that satisfies or
         // exceeds the given size and alignment requirements.
-        let dst = unsafe { libc_aligned_alloc(layout.align(), layout.size()) } as *mut u8;
+        let dst = unsafe { libc_aligned_alloc(layout.align(), layout.size()) }.cast::<u8>();
         let dst = NonNull::new(dst).ok_or(AllocError)?;
 
         if flags.contains(__GFP_ZERO) {
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ae9d072741ce..c12844764671 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -262,7 +262,7 @@ pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
         // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
         //   guaranteed to be part of the same allocated object.
         // - `self.len` can not overflow `isize`.
-        let ptr = unsafe { self.as_mut_ptr().add(self.len) } as *mut MaybeUninit<T>;
+        let ptr = unsafe { self.as_mut_ptr().add(self.len) }.cast::<MaybeUninit<T>>();
 
         // SAFETY: The memory between `self.len` and `self.capacity` is guaranteed to be allocated
         // and valid, but uninitialized.
@@ -554,7 +554,7 @@ fn drop(&mut self) {
         // - `ptr` points to memory with at least a size of `size_of::<T>() * len`,
         // - all elements within `b` are initialized values of `T`,
         // - `len` does not exceed `isize::MAX`.
-        unsafe { Vec::from_raw_parts(ptr as _, len, len) }
+        unsafe { Vec::from_raw_parts(ptr.cast(), len, len) }
     }
 }
 
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index db2d9658ba47..9e500498835d 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -168,16 +168,17 @@ pub fn pr_dbg(&self, args: fmt::Arguments<'_>) {
     /// `KERN_*`constants, for example, `KERN_CRIT`, `KERN_ALERT`, etc.
     #[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
     unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
+        let msg: *const _ = &msg;
         // SAFETY: `klevel` is null-terminated and one of the kernel constants. `self.as_raw`
         // is valid because `self` is valid. The "%pA" format string expects a pointer to
         // `fmt::Arguments`, which is what we're passing as the last argument.
         #[cfg(CONFIG_PRINTK)]
         unsafe {
             bindings::_dev_printk(
-                klevel as *const _ as *const crate::ffi::c_char,
+                klevel.as_ptr().cast::<crate::ffi::c_char>(),
                 self.as_raw(),
                 c_str!("%pA").as_char_ptr(),
-                &msg as *const _ as *const crate::ffi::c_void,
+                msg.cast::<crate::ffi::c_void>(),
             )
         };
     }
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 942376f6f3af..3a9d998ec371 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -157,7 +157,7 @@ fn remove_action(this: &Arc<Self>) {
 
     #[allow(clippy::missing_safety_doc)]
     unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
-        let ptr = ptr as *mut DevresInner<T>;
+        let ptr = ptr.cast::<DevresInner<T>>();
         // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
         // reference.
         // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 376f6a6ae5e3..8eca5be30f2c 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -152,7 +152,7 @@ pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
     /// Returns the error encoded as a pointer.
     pub fn to_ptr<T>(self) -> *mut T {
         // SAFETY: `self.0` is a valid error due to its invariant.
-        unsafe { bindings::ERR_PTR(self.0.get() as _) as *mut _ }
+        unsafe { bindings::ERR_PTR(self.0.get() as _).cast() }
     }
 
     /// Returns a string representing the error, if one exists.
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index c5162fdc95ff..74df815d2f4e 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -58,10 +58,11 @@ impl Firmware {
     fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
         let mut fw: *mut bindings::firmware = core::ptr::null_mut();
         let pfw: *mut *mut bindings::firmware = &mut fw;
+        let pfw: *mut *const bindings::firmware = pfw.cast();
 
         // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
         // `name` and `dev` are valid as by their type invariants.
-        let ret = unsafe { func.0(pfw as _, name.as_char_ptr(), dev.as_raw()) };
+        let ret = unsafe { func.0(pfw, name.as_char_ptr(), dev.as_raw()) };
         if ret != 0 {
             return Err(Error::from_errno(ret));
         }
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index ed57e0137cdb..9e2639aee61a 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -364,7 +364,7 @@ fn deref(&self) -> &LocalFile {
         //
         // By the type invariants, there are no `fdget_pos` calls that did not take the
         // `f_pos_lock` mutex.
-        unsafe { LocalFile::from_raw_file(self as *const File as *const bindings::file) }
+        unsafe { LocalFile::from_raw_file((self as *const Self).cast()) }
     }
 }
 
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 824da0e9738a..7ed2063c1af0 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -8,19 +8,20 @@
 
 use core::{ffi::c_void, fmt};
 
+#[cfg(CONFIG_PRINTK)]
+use crate::c_str;
+
 /// Prints a KUnit error-level message.
 ///
 /// Public but hidden since it should only be used from KUnit generated code.
 #[doc(hidden)]
 pub fn err(args: fmt::Arguments<'_>) {
+    let args: *const _ = &args;
     // SAFETY: The format string is null-terminated and the `%pA` specifier matches the argument we
     // are passing.
     #[cfg(CONFIG_PRINTK)]
     unsafe {
-        bindings::_printk(
-            c"\x013%pA".as_ptr() as _,
-            &args as *const _ as *const c_void,
-        );
+        bindings::_printk(c_str!("\x013%pA").as_char_ptr(), args.cast::<c_void>());
     }
 }
 
@@ -29,14 +30,12 @@ pub fn err(args: fmt::Arguments<'_>) {
 /// Public but hidden since it should only be used from KUnit generated code.
 #[doc(hidden)]
 pub fn info(args: fmt::Arguments<'_>) {
+    let args: *const _ = &args;
     // SAFETY: The format string is null-terminated and the `%pA` specifier matches the argument we
     // are passing.
     #[cfg(CONFIG_PRINTK)]
     unsafe {
-        bindings::_printk(
-            c"\x016%pA".as_ptr() as _,
-            &args as *const _ as *const c_void,
-        );
+        bindings::_printk(c_str!("\x016%pA").as_char_ptr(), args.cast::<c_void>());
     }
 }
 
diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index a0438537cee1..1f9498c1458f 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -34,7 +34,7 @@ pub unsafe trait HasListLinks<const ID: u64 = 0> {
     unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
         // SAFETY: The caller promises that the pointer is valid. The implementer promises that the
         // `OFFSET` constant is correct.
-        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut ListLinks<ID> }
+        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast() }
     }
 }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 271a7690a9a0..003c9aaafb24 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -75,7 +75,7 @@ extern "C" fn probe_callback(
                 // Let the `struct pci_dev` own a reference of the driver's private data.
                 // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
                 // `struct pci_dev`.
-                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
+                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign().cast()) };
             }
             Err(err) => return Error::to_errno(err),
         }
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 84a4ecc642a1..26b2502970ef 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -66,7 +66,9 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
                 // Let the `struct platform_device` own a reference of the driver's private data.
                 // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
                 // `struct platform_device`.
-                unsafe { bindings::platform_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
+                unsafe {
+                    bindings::platform_set_drvdata(pdev.as_raw(), data.into_foreign().cast())
+                };
             }
             Err(err) => return Error::to_errno(err),
         }
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index cf4714242e14..8ae57d2cd36c 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -25,7 +25,7 @@
     // SAFETY: The C contract guarantees that `buf` is valid if it's less than `end`.
     let mut w = unsafe { RawFormatter::from_ptrs(buf.cast(), end.cast()) };
     // SAFETY: TODO.
-    let _ = w.write_fmt(unsafe { *(ptr as *const fmt::Arguments<'_>) });
+    let _ = w.write_fmt(unsafe { *ptr.cast::<fmt::Arguments<'_>>() });
     w.pos().cast()
 }
 
@@ -102,6 +102,7 @@ pub unsafe fn call_printk(
     module_name: &[u8],
     args: fmt::Arguments<'_>,
 ) {
+    let args: *const _ = &args;
     // `_printk` does not seem to fail in any path.
     #[cfg(CONFIG_PRINTK)]
     // SAFETY: TODO.
@@ -109,7 +110,7 @@ pub unsafe fn call_printk(
         bindings::_printk(
             format_string.as_ptr(),
             module_name.as_ptr(),
-            &args as *const _ as *const c_void,
+            args.cast::<c_void>(),
         );
     }
 }
@@ -122,15 +123,13 @@ pub unsafe fn call_printk(
 #[doc(hidden)]
 #[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
 pub fn call_printk_cont(args: fmt::Arguments<'_>) {
+    let args: *const _ = &args;
     // `_printk` does not seem to fail in any path.
     //
     // SAFETY: The format string is fixed.
     #[cfg(CONFIG_PRINTK)]
     unsafe {
-        bindings::_printk(
-            format_strings::CONT.as_ptr(),
-            &args as *const _ as *const c_void,
-        );
+        bindings::_printk(format_strings::CONT.as_ptr(), args.cast::<c_void>());
     }
 }
 
diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 4c03881a9eba..d7a530d3eb07 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -31,12 +31,13 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_file) -> &'a SeqFile {
 
     /// Used by the [`seq_print`] macro.
     pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
+        let args: *const _ = &args;
         // SAFETY: Passing a void pointer to `Arguments` is valid for `%pA`.
         unsafe {
             bindings::seq_printf(
                 self.inner.get(),
                 c_str!("%pA").as_char_ptr(),
-                &args as *const _ as *const crate::ffi::c_void,
+                args.cast::<crate::ffi::c_void>(),
             );
         }
     }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 28e2201604d6..6a1a982b946d 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -191,7 +191,7 @@ pub unsafe fn from_char_ptr<'a>(ptr: *const crate::ffi::c_char) -> &'a Self {
         // to a `NUL`-terminated C string.
         let len = unsafe { bindings::strlen(ptr) } + 1;
         // SAFETY: Lifetime guaranteed by the safety precondition.
-        let bytes = unsafe { core::slice::from_raw_parts(ptr as _, len) };
+        let bytes = unsafe { core::slice::from_raw_parts(ptr.cast(), len) };
         // SAFETY: As `len` is returned by `strlen`, `bytes` does not contain interior `NUL`.
         // As we have added 1 to `len`, the last byte is known to be `NUL`.
         unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index e105477a3cb1..d04d90486b09 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -73,7 +73,7 @@ pub fn register_wait(&mut self, file: &File, cv: &PollCondVar) {
             // be destroyed, the destructor must run. That destructor first removes all waiters,
             // and then waits for an rcu grace period. Therefore, `cv.wait_queue_head` is valid for
             // long enough.
-            unsafe { qproc(file.as_ptr() as _, cv.wait_queue_head.get(), self.0.get()) };
+            unsafe { qproc(file.as_ptr().cast(), cv.wait_queue_head.get(), self.0.get()) };
         }
     }
 }
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 0cd100d2aefb..8ff54105be3f 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -170,7 +170,7 @@ impl Queue {
     pub unsafe fn from_raw<'a>(ptr: *const bindings::workqueue_struct) -> &'a Queue {
         // SAFETY: The `Queue` type is `#[repr(transparent)]`, so the pointer cast is valid. The
         // caller promises that the pointer is not dangling.
-        unsafe { &*(ptr as *const Queue) }
+        unsafe { &*ptr.cast::<Queue>() }
     }
 
     /// Enqueues a work item.
@@ -457,7 +457,7 @@ fn get_work_offset(&self) -> usize {
     #[inline]
     unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
         // SAFETY: The caller promises that the pointer is valid.
-        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T, ID> }
+        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast::<Work<T, ID>>() }
     }
 
     /// Returns a pointer to the struct containing the [`Work<T, ID>`] field.
@@ -472,7 +472,7 @@ unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
     {
         // SAFETY: The caller promises that the pointer points at a field of the right type in the
         // right kind of struct.
-        unsafe { (ptr as *mut u8).sub(Self::OFFSET) as *mut Self }
+        unsafe { ptr.cast::<u8>().sub(Self::OFFSET).cast::<Self>() }
     }
 }
 
@@ -538,7 +538,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
 {
     unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
         // The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
-        let ptr = ptr as *mut Work<T, ID>;
+        let ptr = ptr.cast::<Work<T, ID>>();
         // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
         let ptr = unsafe { T::work_container_of(ptr) };
         // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
@@ -591,7 +591,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<KBox<T>>
 {
     unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
         // The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
-        let ptr = ptr as *mut Work<T, ID>;
+        let ptr = ptr.cast::<Work<T, ID>>();
         // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
         let ptr = unsafe { T::work_container_of(ptr) };
         // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 13495910271f..fe9bf7b5a306 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -15,6 +15,7 @@
 #![allow(
     clippy::all,
     clippy::undocumented_unsafe_blocks,
+    clippy::ptr_as_ptr,
     dead_code,
     missing_docs,
     non_camel_case_types,

-- 
2.48.1


