Return-Path: <linux-kselftest+bounces-30965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DECA90A18
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 19:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D3544546C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B60D21A45E;
	Wed, 16 Apr 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzcy9SA/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37FA2153C4;
	Wed, 16 Apr 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824987; cv=none; b=liu5TpTkmiIdDGUy53EWpdngZiXPLii/eos6hIiOcT+Ez+sBUiaNEdkCNG057VAhYTEPJxaMM6W8RSBvC+zbbk2DUsKb9W7+gmVKd3uYmWduDQjS/Je+bd2kZzqXAplHx0bXV/DrdMiO+18dGZP7QZR0mu8oHzkLl1pp3aiUSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824987; c=relaxed/simple;
	bh=I4x8fdtV2ymBXE+I+wmKa9DR7ZQmm5C+JWY3G1Fag1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eyhGY43TO4qwGk0JmToxG4tgLRXBraLJzIip30+e2snLhNe+fcPKSj+3RjUq1+4dFadx5638QP3TD5rL8eeFLG/VDHCQwTH3G+g1ZU4/WEngIyun7NsmxaFK2tbEgCge66dCK1W6Vn5Evnc3A5GzB3PxrCHtdCS0DNZ8iEB9s/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzcy9SA/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so10084966d6.0;
        Wed, 16 Apr 2025 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824984; x=1745429784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TOx7GWJKmmI/6FKx4LFn0YeTNpJgD9zOAUQsnEnoRk=;
        b=fzcy9SA/giXepxOUhDISzSZmMLHT0VTwwJJHl8TDnq155RXTh9CVsesIYTI8v5nWq+
         qn7IywC/ltGbMqQvFMzVK0JrTVDCkt8dWSjlxLCuW3L6BLy3n6tbe//XoY80w7dWDfzn
         VijkNrGkpABrKVvBKPjaM9yACi959GkuaJVsCIurHl31LbHeG1K8zZr5XoKHWwR9GKTb
         jorWldDSFOvdx0pm160yyK9X0D61MVSz3uUr4WVJlf4oIAL/cDx1k34eqXkh1CRnFxdV
         2VQbb/+fh0XkCMOsd5gYHBs4/CROhigK06WyvRRYCM/+/RqQiOFoVGZTSr52qA/dQ/aU
         AqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824984; x=1745429784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TOx7GWJKmmI/6FKx4LFn0YeTNpJgD9zOAUQsnEnoRk=;
        b=wJl/f4fD6nVr9oRXOg1UaaQh6X7qGGGUTapXfzFrmDb0I45rag6MYv0ij3qwVA9ich
         QyZ6wMTzcQWVurn3ToCyk4OIjVH+r23xskIcC8TYtbJ1UoUufZ9Xsghu9+EnPsgvmDys
         HEx0GM7573FXLoIclb1742p6sxM4+J97X2gLyeX0V4HBlhrgOXgAgZ+JfVn2XMe6It/h
         9uamVleIq/SIK2ij8cvZdLXku/icrG3ND/3CZIlAWUHADyqsjcU0Zg0ZkkNTtRqdSgyc
         tcL+vdjucwXdtS2sI7BAXN8mWvT/tstEcp43RwV03Rdzc7HgME7mU5fnjNtuw9Bhhe2t
         iMfg==
X-Forwarded-Encrypted: i=1; AJvYcCU77O1qjWhW53qnPu7t6e6aOIh9Rwk2hpc4mPv7PU7jczGiv24qKJFGgWXvdMCNFuHqB2EA4ex7f97F@vger.kernel.org, AJvYcCUiD0NumdRzygn8W29bl0V7cUnbABRuo0kvwB8+MgVcOp03sCcxAO47s0zY07mQ/D5KB4aUyT1URzOSDjdNF7YG@vger.kernel.org, AJvYcCUxhIMbFVAHii5aVsKWq8GqOOjrOFYd9z2mQLkZBN2IZlpQfLJ1W1Ek8lKw9JfSb990KnQoPyRVUblN@vger.kernel.org, AJvYcCVMb3Htlq9J4I7XENcfsdQp1fc+2mqxWhEF+zA6VY+Twfm+MqFW4vRwHrM7e/p0UuaowV6sanhlXvbeNk4=@vger.kernel.org, AJvYcCVirXVhwAe5GGMW5nwuIQpQh+ECMbd2JO2Dd+ERO242OfMASLq5Vbzyr+ZRHhf7JZsQg68RHFr5@vger.kernel.org, AJvYcCWWL47F285593qmmLHYhydgMDjgmt9WfEX56uJ1Tqkn0OSyFP2zS6uEZQl3T9PVVd6v18+rGfiK7XthEJCv@vger.kernel.org, AJvYcCXGFJFBfDSrNfvOuCXHDcI9cF3blV9Xqr2q3K05zrqn8zfI1KA2QYeCkwAU1bZtMz7ExF6DCzZYVLWeiFkJMak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeja7iCGIw2fnR7mXaRD5Pv4taxxfdCVYyezNSJXErVE4uM1Fq
	BJCi9DRAwsuu+FgEl9KJE526oCcWnEhu3HZaWEsFcAcNHPJeX4hA
X-Gm-Gg: ASbGncunDrqbmgH6k8OkoLbmJihVmgCuJ0SMuf/H6R7hGbvcpIHd8wpvXULjJfISfuh
	CKzKDGe7QTIa2U7wF7axfwXoFyR9Ri4Jm+Cpj1Vcpuu5rk7wwGbowZA3zDpObVLq/zsIeg0NTyG
	WO8Bjsb2wkrys+18fQMLrKCH7bEHq8GGJzTvUlCqiDDflfbA8GKC/kiMmRY4zs0eXeQUocbjL2q
	ZJcwrQHpvt/F6znrOrRincldMGrQLGNiiq0wdASF5Lh5bpiQM9ZLwGgW9go250cImdb78M7P8Ky
	MvqJYweJHnBTVGrBJqNDAuwe6IJSYCbkFz69/20g31IunFJGd+xqyM6G9CohRgCmapZRcosSg6o
	fxZhv926MHsZfnXi0KrEXJj+fiUiRFgpQFYsx6Zj5zcKU
X-Google-Smtp-Source: AGHT+IHJzzNylGQPDvJbjG/Mms3QfsnMlDYYat3HUnSiBNzr35o97CrKOaJrZdwL2GYrZeVBL4Wxyw==
X-Received: by 2002:a05:6214:1d0a:b0:6ea:eeb6:c82b with SMTP id 6a1803df08f44-6f2b9955501mr5949146d6.2.1744824983542;
        Wed, 16 Apr 2025 10:36:23 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:a61d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea07c50sm118289886d6.77.2025.04.16.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:36:23 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 16 Apr 2025 13:36:05 -0400
Subject: [PATCH v9 1/6] rust: enable `clippy::ptr_as_ptr` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-ptr-as-ptr-v9-1-18ec29b1b1f3@gmail.com>
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
In-Reply-To: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
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
  replaced with `core::ptr::from_ref(&x).cast()` with or without `::<T>`
  according to the previous rules. The `core::ptr::from_ref` call is
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
 rust/kernel/device.rs                  |  4 ++--
 rust/kernel/devres.rs                  |  2 +-
 rust/kernel/dma.rs                     |  4 ++--
 rust/kernel/error.rs                   |  2 +-
 rust/kernel/firmware.rs                |  3 ++-
 rust/kernel/fs/file.rs                 |  2 +-
 rust/kernel/kunit.rs                   | 11 +++++++----
 rust/kernel/list/impl_list_item_mod.rs |  2 +-
 rust/kernel/pci.rs                     |  2 +-
 rust/kernel/platform.rs                |  4 +++-
 rust/kernel/print.rs                   |  6 +++---
 rust/kernel/seq_file.rs                |  2 +-
 rust/kernel/str.rs                     |  2 +-
 rust/kernel/sync/poll.rs               |  2 +-
 rust/kernel/time/hrtimer/pin.rs        |  2 +-
 rust/kernel/time/hrtimer/pin_mut.rs    |  2 +-
 rust/kernel/workqueue.rs               | 10 +++++-----
 rust/uapi/lib.rs                       |  1 +
 22 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/Makefile b/Makefile
index 38689a0c3605..5d2931344490 100644
--- a/Makefile
+++ b/Makefile
@@ -480,6 +480,7 @@ export rust_common_flags := --edition=2021 \
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
index 21b343a1dc4d..9fd7da4865a8 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -174,10 +174,10 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
         #[cfg(CONFIG_PRINTK)]
         unsafe {
             bindings::_dev_printk(
-                klevel as *const _ as *const crate::ffi::c_char,
+                klevel.as_ptr().cast::<crate::ffi::c_char>(),
                 self.as_raw(),
                 c_str!("%pA").as_char_ptr(),
-                &msg as *const _ as *const crate::ffi::c_void,
+                core::ptr::from_ref(&msg).cast::<crate::ffi::c_void>(),
             )
         };
     }
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index ddb1ce4a78d9..9e649d70716a 100644
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
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 8cdc76043ee7..f395d1a6fe48 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -186,7 +186,7 @@ pub fn alloc_attrs(
             dev: dev.into(),
             dma_handle,
             count,
-            cpu_addr: ret as *mut T,
+            cpu_addr: ret.cast(),
             dma_attrs,
         })
     }
@@ -293,7 +293,7 @@ fn drop(&mut self) {
             bindings::dma_free_attrs(
                 self.dev.as_raw(),
                 size,
-                self.cpu_addr as _,
+                self.cpu_addr.cast(),
                 self.dma_handle,
                 self.dma_attrs.as_raw(),
             )
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 3dee3139fcd4..afcb00cb6a75 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -153,7 +153,7 @@ pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
     /// Returns the error encoded as a pointer.
     pub fn to_ptr<T>(self) -> *mut T {
         // SAFETY: `self.0` is a valid error due to its invariant.
-        unsafe { bindings::ERR_PTR(self.0.get() as _) as *mut _ }
+        unsafe { bindings::ERR_PTR(self.0.get() as _).cast() }
     }
 
     /// Returns a string representing the error, if one exists.
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index f04b058b09b2..d96b5724b4a3 100644
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
index 13a0e44cd1aa..791f493ada10 100644
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
index 1604fb6a5b1b..3afea8b96e04 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -8,6 +8,9 @@
 
 use core::{ffi::c_void, fmt};
 
+#[cfg(CONFIG_PRINTK)]
+use crate::c_str;
+
 /// Prints a KUnit error-level message.
 ///
 /// Public but hidden since it should only be used from KUnit generated code.
@@ -18,8 +21,8 @@ pub fn err(args: fmt::Arguments<'_>) {
     #[cfg(CONFIG_PRINTK)]
     unsafe {
         bindings::_printk(
-            c"\x013%pA".as_ptr() as _,
-            &args as *const _ as *const c_void,
+            c_str!("\x013%pA").as_char_ptr(),
+            core::ptr::from_ref(&args).cast::<c_void>(),
         );
     }
 }
@@ -34,8 +37,8 @@ pub fn info(args: fmt::Arguments<'_>) {
     #[cfg(CONFIG_PRINTK)]
     unsafe {
         bindings::_printk(
-            c"\x016%pA".as_ptr() as _,
-            &args as *const _ as *const c_void,
+            c_str!("\x016%pA").as_char_ptr(),
+            core::ptr::from_ref(&args).cast::<c_void>(),
         );
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
index c97d6d470b28..391b4f070b1c 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -78,7 +78,7 @@ extern "C" fn probe_callback(
                 // Let the `struct pci_dev` own a reference of the driver's private data.
                 // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
                 // `struct pci_dev`.
-                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
+                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign().cast()) };
             }
             Err(err) => return Error::to_errno(err),
         }
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 4917cb34e2fe..6c0bd343c61b 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -70,7 +70,9 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
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
index cf4714242e14..13a894abe146 100644
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
 
@@ -109,7 +109,7 @@ pub unsafe fn call_printk(
         bindings::_printk(
             format_string.as_ptr(),
             module_name.as_ptr(),
-            &args as *const _ as *const c_void,
+            core::ptr::from_ref(&args).cast::<c_void>(),
         );
     }
 }
@@ -129,7 +129,7 @@ pub fn call_printk_cont(args: fmt::Arguments<'_>) {
     unsafe {
         bindings::_printk(
             format_strings::CONT.as_ptr(),
-            &args as *const _ as *const c_void,
+            core::ptr::from_ref(&args).cast::<c_void>(),
         );
     }
 }
diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 7a9403eb6e5b..8f199b1a3bb1 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -37,7 +37,7 @@ pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
             bindings::seq_printf(
                 self.inner.get(),
                 c_str!("%pA").as_char_ptr(),
-                &args as *const _ as *const crate::ffi::c_void,
+                core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
             );
         }
     }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 878111cb77bc..02863c40c21b 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -237,7 +237,7 @@ pub unsafe fn from_char_ptr<'a>(ptr: *const crate::ffi::c_char) -> &'a Self {
         // to a `NUL`-terminated C string.
         let len = unsafe { bindings::strlen(ptr) } + 1;
         // SAFETY: Lifetime guaranteed by the safety precondition.
-        let bytes = unsafe { core::slice::from_raw_parts(ptr as _, len) };
+        let bytes = unsafe { core::slice::from_raw_parts(ptr.cast(), len) };
         // SAFETY: As `len` is returned by `strlen`, `bytes` does not contain interior `NUL`.
         // As we have added 1 to `len`, the last byte is known to be `NUL`.
         unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index d7e6e59e124b..339ab6097be7 100644
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
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
index f760db265c7b..47154f3bd422 100644
--- a/rust/kernel/time/hrtimer/pin.rs
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -79,7 +79,7 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a T>
 
     unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
         // `HrTimer` is `repr(C)`
-        let timer_ptr = ptr as *mut HrTimer<T>;
+        let timer_ptr = ptr.cast::<HrTimer<T>>();
 
         // SAFETY: By the safety requirement of this function, `timer_ptr`
         // points to a `HrTimer<T>` contained in an `T`.
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
index 90c0351d62e4..e29ff8837206 100644
--- a/rust/kernel/time/hrtimer/pin_mut.rs
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -83,7 +83,7 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
 
     unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
         // `HrTimer` is `repr(C)`
-        let timer_ptr = ptr as *mut HrTimer<T>;
+        let timer_ptr = ptr.cast::<HrTimer<T>>();
 
         // SAFETY: By the safety requirement of this function, `timer_ptr`
         // points to a `HrTimer<T>` contained in an `T`.
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index f98bd02b838f..223fe5e8ed82 100644
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
index 13495910271f..f03b7aead35a 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -14,6 +14,7 @@
 #![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
 #![allow(
     clippy::all,
+    clippy::ptr_as_ptr,
     clippy::undocumented_unsafe_blocks,
     dead_code,
     missing_docs,

-- 
2.49.0


