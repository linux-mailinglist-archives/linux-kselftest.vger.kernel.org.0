Return-Path: <linux-kselftest+bounces-35030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B068BADA3CE
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 22:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A886D7A74CD
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990CC28150A;
	Sun, 15 Jun 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv794DGm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED6C280314;
	Sun, 15 Jun 2025 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750020916; cv=none; b=gU8Ha0F9Q8NYdzyIXPY8IcCLFA0HH1TLe3+CDtQ875gjn7Tf0JQp7wnUs1DHgalaLd1Jvw7bEKmLriYIuLq3IWJauenaDbfd2UDIUdzDct8IeeNJBmgBR3L4eqUUS7lSWbNlqzQroLHQnIwHv+fSe96s3od3tv1FpxpydEeWOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750020916; c=relaxed/simple;
	bh=Z1WZVxpuHmE1ZQSxt13n1t7H3AxNePD6nxUc36wIlfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ut/WwfQleI++Y6hoGl2xLhp6cp6OpoLW+HaRGEmZC+V9mVh+hQ3Dr/Gv55A42wpPWYh8TUzUApMSekDtZqxZmF4x7fR70jxc0fvoUEw61vrYvLcsTBfU9YstBFxc3lBiT5SbT8MihCfGzxa9cNwX0d93LHQO8Cf1aquOutQwBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv794DGm; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6faf66905adso20730616d6.2;
        Sun, 15 Jun 2025 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750020913; x=1750625713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezdiXk3y+/AEw6Ox96nDXZDiisIAangHTqyxnDuWGys=;
        b=Lv794DGmSL8DX6ykGNxWNhzs6fq/vSyFhdcbLQMOVuNvkRZUKTgCLHZ15FhYC7hAbE
         9WLZAJetsPmPRvJuq6y1+VfmZ/Qbz6qXFPtzS2WG98G9B51gQccpRHzff5IcD1CNhxZ7
         t4LTPGFgWdVTrIlQ1o/+PKkmecaIm0Iu6K3WB0274o1d0zSHf5dop6mDlagOvNbMV24y
         /Th7dMbvf4yvn748+dXWcvynWT2jToioO8n55sCgpE1ctsnPZJbdUy+22XlPQLtufNBb
         ASrFxXchdNclceWb8dpFd53Qk46UqtRCEdwRr7sfvSTUZDlwMyl8vGRmjTHedSfC1ofb
         bgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750020913; x=1750625713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezdiXk3y+/AEw6Ox96nDXZDiisIAangHTqyxnDuWGys=;
        b=UZHtFfsp7yi2iLlB6CRCdoCadpsaju9wcdSVpG/QK1+swOiKJ0HWILZwxRrMtlsyYP
         VXwM+CqYjTB8Yhl1+rUpOJiHEWeo7UYzYgX2dO6JBu2VlzaGAxRTOqC9CcNmMRjg6mUI
         PRuoWDLBh2zLNGqK6Rbe4P2oYYisSF1r4TIGLzktLYW7UsN2xwEGqZuWFj8V1QmG8v3Z
         P0RZODY4XxGYyR1zd2ykk6cNN5AQapdZc3lccpmVyJAPTpv2Sc7BNT6/01j76kWQugMO
         GWN7+8CGXAZH/+4RRaYosPuC/gvTzN7KR8UFFHqIW3ZEwWBc8istd5Gv2I2AaiZ9jXF2
         UuuA==
X-Forwarded-Encrypted: i=1; AJvYcCUNZsqqSOLhJBoCLpUphNYCpJMHnv8Q3DYEx/i2ndO2A6pECiq+hOCw+wILo9aOgsRbx7uLB1DRuMQtLQyNNqS6@vger.kernel.org, AJvYcCUREHItgp73FK/fjghPM3jFv4/cnN5t6oBsHWqBR90SE7gq2DRLPvn8+vnutSELjx6UMXa3Q7PDx8s=@vger.kernel.org, AJvYcCV3e1FIiXHofBU+lJ59/TknBDHo5qd/z2DRunAE4OebPf0AokyAyDn67wS9yhsw86wQV+ZP3M+UnX3lHcg=@vger.kernel.org, AJvYcCWQngbe+FyZF3PM9KlKW5J7t78yUbho5XyOIEVGuGfgX8pHldwtFmK9tZnCWQ5It7ociIfSVJFfSQvDSza+@vger.kernel.org, AJvYcCWdM1bCC8YyVXjHNPoNojpELfEMcNlwM/B/tc2bHV7S39n5YLfGMY8blrKAmIKIqzH6xOtKgplq/FUuy+CfNtc=@vger.kernel.org, AJvYcCWo0VXJbE7/C/t4pgK99dVKsJSK22fyp9yEV0BjOfddxLRPWjrVB7PVQq5725D3jy3e5A2dkTX7@vger.kernel.org, AJvYcCX9BDnRNFeY0QmIthFjWiHDV6DWHkma9JJyBkubJzxmKeS8WD9lybW/xeNf2kbEx5qKynymVq0npCkF@vger.kernel.org, AJvYcCXjVHwlGHWQIWDHtvsO0rYhOXyqKlpZSh83JrtQwVQg0Wn9sXPq/uZjsneS1adSnaFuXS4is6FasxzN@vger.kernel.org
X-Gm-Message-State: AOJu0YyQGAq7cthp89akY1MEWDiypc9Zucp2LiOPGHP84nQissuIZAEe
	qtm6a2+g/0RqU589vFsl4ct4FYAckIKr767eohAUSt/79o1ZdgrREKl0
X-Gm-Gg: ASbGncuSwTLzQX5+nmQ0td1Q4fIX0YQ1Yr1XnFzGF2bWGpm2q+jStP3QV2VyMTlmkKx
	po+70ttxKTh/AhZ5hrIecYhr+9KJ6Hj9Oo3WMq3Kffs3f+tahD815m4YPjP/E6/Njdp0j0o9sTf
	1wWfzFvAN1Q0vOWtwPYUBkbptQYNbI/JbjbfqTIRr211AUBjS5pL7geo4e4zQZgnquIoiWMl+UL
	u9DHqpzjC1wYu4B0V5lWQx8WeHblnewSGpNJp63l9mES0TyfHqqOs4ng4BRe9jmlz9CeCXy6oPv
	u7dF7FvUnim+0QjVgFOiOCjOVSH6MSaLRnITnqV9UCIPzQ4IbMcSE3vCGuluIM1dOTHg3Pgn53M
	5zSLV
X-Google-Smtp-Source: AGHT+IFJgdjmpAWaWHvOd/OzUar9HJMZOiE/PIXu+R/hLZI5MOC1WTPF1Tj/M8HijfTBs7H4eutxLQ==
X-Received: by 2002:a05:6214:3389:b0:6fa:ce87:230c with SMTP id 6a1803df08f44-6fb47770502mr109110916d6.25.1750020912752;
        Sun, 15 Jun 2025 13:55:12 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:b0c6:92db:d807:21a6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c84148sm43468176d6.109.2025.06.15.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 13:55:12 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 15 Jun 2025 16:55:05 -0400
Subject: [PATCH v12 1/6] rust: enable `clippy::ptr_as_ptr` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250615-ptr-as-ptr-v12-1-f43b024581e8@gmail.com>
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
In-Reply-To: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
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
 Breno Leitao <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
 linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org, 
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
 rust/kernel/configfs.rs                |  2 +-
 rust/kernel/cpufreq.rs                 |  2 +-
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
 24 files changed, 40 insertions(+), 31 deletions(-)

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
 
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 34d0bea4f9a5..bc8e15dcec18 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -561,7 +561,7 @@ impl<const ID: u64, O, Data> Attribute<ID, O, Data>
         let data: &Data = unsafe { get_group_data(c_group) };
 
         // SAFETY: By function safety requirements, `page` is writable for `PAGE_SIZE`.
-        let ret = O::show(data, unsafe { &mut *(page as *mut [u8; PAGE_SIZE]) });
+        let ret = O::show(data, unsafe { &mut *(page.cast::<[u8; PAGE_SIZE]>()) });
 
         match ret {
             Ok(size) => size as isize,
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index b0a9c6182aec..1cb1f29630e5 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -647,7 +647,7 @@ pub fn data<T: ForeignOwnable>(&mut self) -> Option<<T>::Borrowed<'_>> {
     fn set_data<T: ForeignOwnable>(&mut self, data: T) -> Result {
         if self.as_ref().driver_data.is_null() {
             // Transfer the ownership of the data to the foreign interface.
-            self.as_mut_ref().driver_data = <T as ForeignOwnable>::into_foreign(data) as _;
+            self.as_mut_ref().driver_data = <T as ForeignOwnable>::into_foreign(data).cast();
             Ok(())
         } else {
             Err(EBUSY)
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


