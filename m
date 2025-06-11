Return-Path: <linux-kselftest+bounces-34672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA3AD5198
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF0217F21A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ADB263F49;
	Wed, 11 Jun 2025 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwpPNmXH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C921261575;
	Wed, 11 Jun 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637421; cv=none; b=VAGQW+NYGujplLFk6Namw6iw8NmM/gfyo0NGLs0s7bJwOoXq7dX/FeqO/1n/TsFP/D/5wXexxq91B0G276uWXa3eS3eSA75IDP1pmHW4Mip8RkqdMXa+ZKBgC4Jv1rpXf2f3Z+0V+NSHcFgEYsURCpZWoGuP2H/aTrAM0B4NAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637421; c=relaxed/simple;
	bh=OJYOsjrfAtnUZ6RRUjjQ47/8ulOY3IDENy/rKlhUTOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9RePRnHbkBeecxgYaVVHxvwIWL/6VGBX0VqhSDQgDHhZVPtJ8oiDNfUBe42unBRdjO4as5fOOkoSUs5BuxOtPYahZ5pyun6tg2uHweqv1UBDj2398OSPMbaBbTtXEiX0r8ZMO+TGfQgQMOZSDIN/lDuM+bde3yjFNEbIzezo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwpPNmXH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a4312b4849so78949381cf.1;
        Wed, 11 Jun 2025 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749637418; x=1750242218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOBQpqIx6F/1ZiBVhO4bL8OOA5fQnbUtGxiAE50g8ds=;
        b=LwpPNmXHBhdaVrvYUFINfriCmzUpdTYPi+BTb8Ye5r5j5aFItfHhKaBKhygwqYUWpf
         jd9pzVXjv5rXD7e9ohU4+N2rbxl/kSVvSJ8XuJV+3EQIgVPxAm59P9TlUj/Jq4Z94IXk
         CREyCX/sHNvbWggvcSUB9fgQsPeYwhewxLaAGVuYkDK0xC6vFpmonCD59Bl7SJD1XCH1
         +IJcan3WYH3tVqeORsf1M4H+pV3SX6YPYKN3lL9tbTWWweqwEKhX245LF+hqbzC9q7jZ
         shoG9Qsza6KTYlhr3aJffv4OP+KRV8tnJW2p/PEi4qbQWCYPGqNOcJGCoVizNZYYYho9
         YeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749637418; x=1750242218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOBQpqIx6F/1ZiBVhO4bL8OOA5fQnbUtGxiAE50g8ds=;
        b=DOp54AJWAX8isBaVWDETAWKiHNyu/4BKLOvRpHKtbum3POLgTSNB2X9uvl0cd3zleB
         L9py1anMjwtx3BS8q9W029wl2a/ssg4ycXY8/DFbpxqEQ4tks9e13m+EV5lz/jqFDlAw
         zDE5Vzc89lQvVE1E61d6Mcb/ESLTLP9tNKIovD1zL4M/q+xoVgJ22mTLkOpA0yaWRF8i
         CPi9Ffrn6ESXuRE6/H3yylhswsXnVgc3X64CTWJDio+jLXzvAwqIwyCgWmxU9dA6Gy7t
         Tqmj96e3Hz4EH83VfftleQLlICvag92gWxp+UXety4ZHsULVhTcXJtXA+giaXWWJBiOZ
         59/w==
X-Forwarded-Encrypted: i=1; AJvYcCUEwtNEex+tDZw5HVmUoVrtuWPY/xlzGrVOTKnLAleTeMZlZ+np1xEv+V+AuEcoOjEdwDk7c6ms2ynfIL0a@vger.kernel.org, AJvYcCUf5q4HDoexZ3UGrPNL0qTj2R+nOljOvs5dvwEpLwWaQGklXGKzirXLpk4bKXzNejAqy3o2kMF1KJhm@vger.kernel.org, AJvYcCV1xqWzNOqCEdDlqn/Gxg32DhUoUQgP+ZgDor6q28+XVaNG4/dmpIIECNpgLQ/GOzvQHrJJkofCt22dKEd3a0zG@vger.kernel.org, AJvYcCWz/8EtXF3vwkuu9fVSuhr84Le7CpaKtS9CU4YLa8wb6kIRbdSJQOG0l7K9mDJkSL0SQS8jWizf@vger.kernel.org, AJvYcCX8+OTt+tlHlgZJDSo8Z6r92M2Fdf1jOKR2iRQnTAQfB0LpY2Yvg7seq4GtwibfaN+KwmGHV+Bvu5w5zymsLCQ=@vger.kernel.org, AJvYcCXUT/MmSsw6JnjE1Uka9wutMzwyocpMXkZzpDL54DnjFOqMiN3akePfhYFZE+UNR5ocTUn+m3WE/6JV@vger.kernel.org, AJvYcCXh+5sEskd7aaNVhajH3UQCUw/xWu4DqeueY03NDufHoBfeXLrywZX8iE9mENUYNBLn4/hFdWjTPdYQNcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1bWWVn1UiVH3DCgZ6/MEEGRlxRYDx9cb+RqZH7AHANL+leFEv
	SvVG05cISFv5MPZepX9NbA0//D3ANyVRgeoX1vfASv305cYXBFpY5Cl9
X-Gm-Gg: ASbGncuew8ttkhoYszyUHe4brnIvSvGoehJEyDUtGGgZyIJA0mdPfN/yseBVmlb/S8a
	RwfhLnaalZhHdTpEP9FTIHV19/cwmvsreq3hQIS1kDp9gg2LhQJCxMkk7pa7Dtg4xsUO63isem5
	kAQr88hIlvs/gssi9gebia8wVTmbNYIP8I1NR1xxnlUBUY7UYqUnWJAIoVz84RS7B0tWBE4HYdF
	k93caY8+PslcKzKeXhdqbZJy6dSwkcRv9W2+jvoxSYCTCD731tfDFlBiLpH0UHPmz1KgYkGK5Me
	f2YtSdZbCxtkbzJdyqv92ZnocoNGFRKblzp2mOXJkgb8JHWujS/D6P0WL4HMM80AOJ8=
X-Google-Smtp-Source: AGHT+IFcse7lS2d06z+yGpc6PVUSpHw7r2X3k7qm6/B/EuSzPugzslgtGfYF4YSsXkq8xBoRXuFd5g==
X-Received: by 2002:ac8:6f06:0:b0:494:a235:fcbb with SMTP id d75a77b69052e-4a713c2e7c1mr46484781cf.29.1749637417946;
        Wed, 11 Jun 2025 03:23:37 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([204.93.149.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61114ff18sm85664341cf.6.2025.06.11.03.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:23:37 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 11 Jun 2025 06:23:25 -0400
Subject: [PATCH v11 1/6] rust: enable `clippy::ptr_as_ptr` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ptr-as-ptr-v11-1-ce5b41c6e9c6@gmail.com>
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
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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
 rust/kernel/workqueue.rs               |  6 +++---
 rust/uapi/lib.rs                       |  1 +
 22 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index 35e6e5240c61..21cc6e312ec9 100644
--- a/Makefile
+++ b/Makefile
@@ -484,6 +484,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::needless_bitwise_bool \
 			    -Aclippy::needless_lifetimes \
 			    -Wclippy::no_mangle_with_rust_abi \
+			    -Wclippy::ptr_as_ptr \
 			    -Wclippy::undocumented_unsafe_blocks \
 			    -Wclippy::unnecessary_safety_comment \
 			    -Wclippy::unnecessary_safety_doc \
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index a08eb5518cac..81b6c7aa4916 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -25,6 +25,7 @@
 )]
 
 #[allow(dead_code)]
+#[allow(clippy::ptr_as_ptr)]
 #[allow(clippy::undocumented_unsafe_blocks)]
 #[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
 mod bindings_raw {
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index d19c06ef0498..a3074480bd8d 100644
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
index 1a0dd852a468..0477041cbc03 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -288,7 +288,7 @@ pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
         // - `self.len` is smaller than `self.capacity` by the type invariant and hence, the
         //   resulting pointer is guaranteed to be part of the same allocated object.
         // - `self.len` can not overflow `isize`.
-        let ptr = unsafe { self.as_mut_ptr().add(self.len) } as *mut MaybeUninit<T>;
+        let ptr = unsafe { self.as_mut_ptr().add(self.len) }.cast::<MaybeUninit<T>>();
 
         // SAFETY: The memory between `self.len` and `self.capacity` is guaranteed to be allocated
         // and valid, but uninitialized.
@@ -847,7 +847,7 @@ fn drop(&mut self) {
         // - `ptr` points to memory with at least a size of `size_of::<T>() * len`,
         // - all elements within `b` are initialized values of `T`,
         // - `len` does not exceed `isize::MAX`.
-        unsafe { Vec::from_raw_parts(ptr as _, len, len) }
+        unsafe { Vec::from_raw_parts(ptr.cast(), len, len) }
     }
 }
 
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index dea06b79ecb5..5c946af3a4d5 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -195,10 +195,10 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
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
index 0f79a2ec9474..e5475ff62da3 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -154,7 +154,7 @@ fn remove_action(this: &Arc<Self>) {
 
     #[allow(clippy::missing_safety_doc)]
     unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
-        let ptr = ptr as *mut DevresInner<T>;
+        let ptr = ptr.cast::<DevresInner<T>>();
         // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
         // reference.
         // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index a33261c62e0c..666bf2d64f9a 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -186,7 +186,7 @@ pub fn alloc_attrs(
             dev: dev.into(),
             dma_handle,
             count,
-            cpu_addr: ret as *mut T,
+            cpu_addr: ret.cast::<T>(),
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
index 2494c96e105f..94fa1ea17ef0 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -62,10 +62,11 @@ impl Firmware {
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
index 72d84fb0e266..e9bfbad00755 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -366,7 +366,7 @@ fn deref(&self) -> &LocalFile {
         //
         // By the type invariants, there are no `fdget_pos` calls that did not take the
         // `f_pos_lock` mutex.
-        unsafe { LocalFile::from_raw_file(self as *const File as *const bindings::file) }
+        unsafe { LocalFile::from_raw_file((self as *const Self).cast()) }
     }
 }
 
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 4b8cdcb21e77..6930e86d98a9 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -9,6 +9,9 @@
 use crate::prelude::*;
 use core::{ffi::c_void, fmt};
 
+#[cfg(CONFIG_PRINTK)]
+use crate::c_str;
+
 /// Prints a KUnit error-level message.
 ///
 /// Public but hidden since it should only be used from KUnit generated code.
@@ -19,8 +22,8 @@ pub fn err(args: fmt::Arguments<'_>) {
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
@@ -35,8 +38,8 @@ pub fn info(args: fmt::Arguments<'_>) {
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
index 8435f8132e38..33ae0bdc433d 100644
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
index 5b21fa517e55..4b06f9fbc172 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -69,7 +69,9 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
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
index 9783d960a97a..ecdcee43e5a5 100644
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
index a927db8e079c..6a3cb607b332 100644
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
index 293ca9cf058c..2f29fd75d63a 100644
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
index 6033572d35ad..d05d68be55e9 100644
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
index d092112d843f..de61374e36bd 100644
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
@@ -522,7 +522,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
 {
     unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
         // The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
-        let ptr = ptr as *mut Work<T, ID>;
+        let ptr = ptr.cast::<Work<T, ID>>();
         // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
         let ptr = unsafe { T::work_container_of(ptr) };
         // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
@@ -575,7 +575,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<KBox<T>>
 {
     unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
         // The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
-        let ptr = ptr as *mut Work<T, ID>;
+        let ptr = ptr.cast::<Work<T, ID>>();
         // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
         let ptr = unsafe { T::work_container_of(ptr) };
         // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index c98d7a8cde77..e79a1f49f055 100644
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


