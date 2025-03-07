Return-Path: <linux-kselftest+bounces-28500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE10AA56E1B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D31188BFB4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 16:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C7823E25A;
	Fri,  7 Mar 2025 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPdF1dIM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6623E259;
	Fri,  7 Mar 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365718; cv=none; b=Cf4opsWYPBhNtw7mZJyATZxGkUJyhe5LECiCBsIKCPjWjf3C1t1l+PmOb6aoNJH8fr8/+GCE58i3NZV++w2Ig5p0ow5LbRC7tkH7myk5nk5BQsFpA86a4Ib37ChKoJ2FeQXKLrwyJRPYucEvbm1Pw0E7LMZpg+/i1wwtZcMnfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365718; c=relaxed/simple;
	bh=9im5/n+OrbXfVBE0t3LiJ1l3Ce6h0lsgPltFDj7ilM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tuf3RqOVixSJEBAE8Y36SiJvxhkhv9HruwrkwQelSYpr2W6YhH0BlyImGKFejgLBi8Sr+gOfBngo0k97T7KFnMto15kIQc7THXEcch5+Mdi7lIOy82oCPfhMFdkHKGtj68oQU9aCsK4FmsFg7ryOH7ICobHjL59T15s576GMb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPdF1dIM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4750ca77db0so10976111cf.3;
        Fri, 07 Mar 2025 08:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365714; x=1741970514; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmUbLujqWWyOsET0Gy5mQBX992cjfrS81s4Kh5EH/xw=;
        b=hPdF1dIMAHWT67E0ogwpB1ieBzeTAGvAnLXQT7mAq991O4NAUF8cC+vUOlkDBmqGui
         3pj27C2oQqgMw1571VAIJUCRegdJskF2xrsTSMBCuN5oYOtPPlYRlFkFLl6N8qlJB55I
         GsnfZpx6cgCZlM8FlDstx5at5LHOHCMLrthMZxVIwLQBiHbesad9hm9DV7k8VQIo3Faz
         bxc2VznAk51QRgXn87vh18UHB6luLrbBcV0xe+AsAD+VALqDedmARjdMSfPdcoUGwGDb
         aUuFQnKjO36dd+zXjK1Ki0QAQ4Imt8oRohhAxKbx4IjvzqHeFmHtutULp34DzOZc68wr
         E0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365714; x=1741970514;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmUbLujqWWyOsET0Gy5mQBX992cjfrS81s4Kh5EH/xw=;
        b=TS5rYvsSXWQ9ImX5cBZZAZhzADdeUVtY0A/1GcAeUUrL40Ps86TtKqWeCPgv0WKab4
         69k4C6nqVmtoDmOBPRUXvOysEFFsTz+Sv0i8e2gbkWIxx9axhBv/PhIyUvl30/r9Hw/W
         Y79ylCDdBSJExKI+8AHUlpq2+oCcCdic9XZWA0nY44QOOkVLp5zcFqN5dFlIsoIWnKHc
         daT84iWlwYHREg8kmCXousiQgclCxDNopXJzPiuSZ3fgE9jrFD6jdygPGLON3ek6Plez
         D6m+zEv1/PQi52PT6NbVhjGtWZtyyydv3YN32intTUKslV+B7nr3xQMNWQZ8U9yTXjfj
         E5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCvSjgyWKR9jPb1kysw3QiW4qMIujTUGnjWenTuks9CXZMDFGvDLhtWA++lg4Y2ueRuJJMo1L0AGzObl4=@vger.kernel.org, AJvYcCWwpdfiag1lBhI0vUxFlT7zoLa4Qkjfg6QN/eLh3OgL2XJrjU5MmWXnB5lKcASRjGJjgCaP8skC9WJzqdL4sg8=@vger.kernel.org, AJvYcCXMu/IJtYpZhdDM+7Pa0v9kCQ+xme47U95jYG4nruQrrvf5Qzlm0r0ELWge9fBTyGTmnwfgNp4pgzla@vger.kernel.org, AJvYcCXqqQ/AaL7kZDZ0p5fYcNprn50DyGxST1vv5I8PEaXszlKCAIc/0nNVM62CH4ZAaE79Z/paTWys6Zc5diT1oPdj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3CCm41eyEHKzzEYmsE3ydI8+eJGbB3vaQZplA6qgKxfKgNsmD
	jrShlVhssr0hbbi9BQenhyuDy8wA5aaf9q10+00LjTLjjPLcgOohi2KG8LaXnWk=
X-Gm-Gg: ASbGncvY16zVEsMIG33AYp2eIJkHRj0qgtZK+SDfi1Gwb2ofCpS3CgdTWA2+tLe1i2K
	mWhtx53emtgsrxXMOnmT3FWqiwL2pw2QMRVDCt7NjynGTyj9tkcAyUxolJdWOTakiw9AXv+e/V+
	OUOCD48tH577HKRBd46dCVSC0qQln6m87cPhWx2ZO7xbn5p2sKGCkm6zmsJ94+QkNNUERMRUORg
	GEjTciDVr2aYQwOIhXpptO1wN9miIjh2+R9iy8k7DA8RRPb6r5QYM79FWIe5RbhLEdpsn/N0paX
	D/hPJY27VVyXQ62jQEdAjkyXfNaD0yfEClcWgsFtY7tozdIoawGxG88k5EvihUeDOmck
X-Google-Smtp-Source: AGHT+IG95zR2G/+knK4wr5uOQQzvO7VQHI52hTAVR04HDLeoitXXGxq4TW5u6XW2gpolfEC2lIKKLA==
X-Received: by 2002:a05:622a:1aa2:b0:471:9b3f:2464 with SMTP id d75a77b69052e-476109bb81fmr51026551cf.31.1741365714265;
        Fri, 07 Mar 2025 08:41:54 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d7540c6sm22167991cf.0.2025.03.07.08.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:41:53 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Mar 2025 11:41:50 -0500
Subject: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com>
X-B4-Tracking: v=1; b=H4sIAM0hy2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNz3YKSIt3EYjBlZJhkaGFmnpZskmKiBNRQUJSallkBNiw6trYWAHE
 GsqJcAAAA
X-Change-ID: 20250307-ptr-as-ptr-21b1867fc4d4
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
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

In Rust 1.51.0, Clippy introduced the `ignored_unit_patterns` lint [1]:

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

Apply these changes and enable the lint -- no functional change
intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_ptr [1]
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                               |  1 +
 rust/bindings/lib.rs                   |  1 +
 rust/kernel/alloc/allocator_test.rs    |  2 +-
 rust/kernel/alloc/kvec.rs              |  4 ++--
 rust/kernel/device.rs                  |  5 +++--
 rust/kernel/devres.rs                  |  2 +-
 rust/kernel/error.rs                   |  2 +-
 rust/kernel/fs/file.rs                 |  2 +-
 rust/kernel/kunit.rs                   | 15 +++++++--------
 rust/kernel/lib.rs                     |  4 ++--
 rust/kernel/list/impl_list_item_mod.rs |  2 +-
 rust/kernel/pci.rs                     |  2 +-
 rust/kernel/platform.rs                |  4 +++-
 rust/kernel/print.rs                   | 11 +++++------
 rust/kernel/seq_file.rs                |  3 ++-
 rust/kernel/str.rs                     |  2 +-
 rust/kernel/sync/poll.rs               |  2 +-
 rust/kernel/workqueue.rs               | 10 +++++-----
 rust/uapi/lib.rs                       |  1 +
 19 files changed, 40 insertions(+), 35 deletions(-)

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
index f6ecf09cb65f..8654d52b0bb9 100644
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
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index e03dbe14d62a..8936afc234a4 100644
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
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7697c60b2d1a..01264e459c92 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -196,9 +196,9 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
 #[macro_export]
 macro_rules! container_of {
     ($ptr:expr, $type:ty, $($f:tt)*) => {{
-        let ptr = $ptr as *const _ as *const u8;
+        let ptr: *const _ = $ptr;
         let offset: usize = ::core::mem::offset_of!($type, $($f)*);
-        ptr.sub(offset) as *const $type
+        ptr.cast::<u8>().sub(offset).cast::<$type>()
     }}
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
index 4c98b5b9aa1e..206f71d33ab2 100644
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
index 50e6b0421813..8f9e6b125faf 100644
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
index b19ee490be58..0245c145ea32 100644
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
index 04947c672979..90545d28e6b7 100644
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
index d5f17153b424..a151f54cde91 100644
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

---
base-commit: ff64846bee0e7e3e7bc9363ebad3bab42dd27e24
change-id: 20250307-ptr-as-ptr-21b1867fc4d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


