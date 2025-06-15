Return-Path: <linux-kselftest+bounces-35035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F84FADA3EF
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 22:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453117A7817
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 20:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF0286D5D;
	Sun, 15 Jun 2025 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZHd83ZX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E7286884;
	Sun, 15 Jun 2025 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750020926; cv=none; b=PHY1EXA8PjzMI7rF0n5z2DjcwwVUZ2p9zTL5uoRTyIWbwjNJK5eckng7JqHhdCw4O2Pu2MZqbiwk3406+/lJ/1VsKY2OGIacSLEikpz84Jtf3jVAkgEULlZ9vWKkxs051z+x6pGOXS7tLBtPiSlbTDwS/KUbMZbPOhdYDDbXD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750020926; c=relaxed/simple;
	bh=xEbMMpgkxkgmkMt/8NQh9bFxGxL0e46Drbw7xu8Igyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5ToisV8Umn9rUjQebrFpjcyVNp9j2YjZA78jxjN496HqLzh9xF2dUAAcQEDicVEz1mogHWD58XInyN7/JbDY+DQRMFEz6D/TjFt+LJjMQ0wISWuOMtdY5hKc8B3LkPi8tybZqcxPVf1vVXlcKLSq9Adje5BmiJ1BNQAth6T3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZHd83ZX; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fac1c60e19so51741206d6.1;
        Sun, 15 Jun 2025 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750020924; x=1750625724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOVACA1eFI8MiX8ijFRfc0eSr1nhHyzNP288zOTRdlY=;
        b=fZHd83ZXcEtPMA6BzmTrUo6ajqwPzlOd5G7WV/twrAiXMmXcgIsyHl/zf5CKcRIi5E
         PnV+cA3N4RF4k3I2S3m8Z51F/DVG7DGQAattC3uZGA17ngL8caw26fjRn+Yg9SCW4gw6
         SCyHLxzPbbh24YuSpWklwizWOLb91VHNdIsn7/aBoe9m2eHl++9AcXdWmQwGnpSS+fQ2
         9AplYFiFaFZ+dOMTeLvktj8xsWiaHHbouuYSczyubz0gPoCASqflHgi6IzkkYJszogoI
         cpiHdKKL4dHHzo8VootMQCSu+V8eYqGatpAeQU18tv2rkap61oE3lI59LLmLfDfGXnUW
         7n+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750020924; x=1750625724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOVACA1eFI8MiX8ijFRfc0eSr1nhHyzNP288zOTRdlY=;
        b=oUA8bfHZTWbJ3+1K+WcMwegOFDinc41ybQ4qUK7l3VIqs0FDr7sM8QkTJKngjbuvdB
         fxdgoKk7QOYqeSnkwToBVNunxSFGZvOBsRNIQuEARV03TKrCtgMQs+ZBq1l10mNaYsvf
         hhPJ3Y1qUureDEdzcScc8lOxhD6r5X8in9SJh+VDBRLNyw90zjYOv/7u7NMnfNqv5vl+
         bJuy98xydlax4nHpVo8ch8X1mIXnLoCQqiRavL6VV30Y9VNclTeZo/q/9jL/GqyGEdjs
         nKCEoTAnkfjIFzVILWj4f2psiKoVbkhXgXKXdIHRlAvZ4968M3X+l6DxLX2p2Jiiu7oQ
         JAhg==
X-Forwarded-Encrypted: i=1; AJvYcCUcVm5DJZB2xWhIz5x4EEqpQxmtMvLwxzqkwyecGUQj6pLsu6vKJ0hmG7+2x75y3ri1fQhENxnB6f1vz1dN@vger.kernel.org, AJvYcCV5JNDs2p6aU6U7NRvyv7Pvv1iO20CVGxS28W2yHNdrXmlVMeXabdBpcNic953hRAyetbvGd83Gym/m@vger.kernel.org, AJvYcCVHW9x9wX50HV/aZJnki8XbstX0ZKjl+HJPg5HvMePPQCdxVaiHYObp1I05nY83/llR9De5wAO4Dv/e@vger.kernel.org, AJvYcCVeRJP727wKn+bKNZs+QRyfXnRlV8iHbHxsGUT4H4ZSwST5bU5wzf+/1by0KPytsM5dqJ66XnOG7/WiDqetSKWy@vger.kernel.org, AJvYcCVsXVIHwrof582xIQIG88bhFvyGqC5EEhk2niig89p6I0vih1a1fMke3QKvEytnG0T984vdee0JMLo=@vger.kernel.org, AJvYcCX0vm8PrTTtDHjmi/FXnSm2UXhwegzz7eCmKPh6G4inWZn+ZeeIsUneQ75JtkfIrMGhlyZpy3DC@vger.kernel.org, AJvYcCXDIv3NMtL61Z2BZW91+KYdZRzySZcqSSrg8hUM3Q3d3tYOOv4sGc12pY2FUCMxxWOC1oanEHoAWZ1kEKU=@vger.kernel.org, AJvYcCXXN+2qg8AUiKlrVOMo8Tt1bawXgrP/MOKzXSDNlIbWN7/yWdGgWTVV0B1DZCjU4ZxLONtYCk8jYVBxJdiOTYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQ2q03W0ufnjIZUJdreJpBSTLuN75zRvHtzW9oSZbmwyUlvqr
	BYuKkay9e+ETN8R3LO2DRwMPY99DSnrSExUYaYqNqQvxWKhjfB1EQSqB
X-Gm-Gg: ASbGncu1FOuyAYBaMkuYSGxuRmyGQE+ej5I81VdQFUfNXQpOtO+hDyP27R5CRedCbgv
	SUY/EXBK1+lJpAwDWKU+vgRfONHBkKAnoPVVF7KU+NgCrMr0bE+v7tJEHb8OxfjnfriO93ev+BL
	Wfik3IwWgZaeX9506QVlL82tXS5l2K8XLjmz5N6cKWArcABJ064ZUxYAhh1toowMz13DGfL7Xt/
	sTolHenUYrfM4B8nczV6bbTAR93RVMx8zDLqa9Z5dE9xlHPMEBaZOPMGlSlQryrWPnfSUfA3HGM
	GdlmATANuT7b6mF4mWmwYD85Uk4XI1M3B4kt/gW/7huZW0aXVyk8lQeOfsygO8ln/5Ek2A==
X-Google-Smtp-Source: AGHT+IF3hh4jupFwZOSWdFP81Ho1hBbetMpEgJhDQJSGwSq3vyb7VWe0EmAuiWSZP0mzNWtopZ28zA==
X-Received: by 2002:a05:6214:2264:b0:6fa:a428:8b1e with SMTP id 6a1803df08f44-6fb46e1a667mr121430216d6.22.1750020923745;
        Sun, 15 Jun 2025 13:55:23 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:b0c6:92db:d807:21a6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c84148sm43468176d6.109.2025.06.15.13.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 13:55:23 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 15 Jun 2025 16:55:10 -0400
Subject: [PATCH v12 6/6] rust: enable `clippy::ref_as_ptr` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250615-ptr-as-ptr-v12-6-f43b024581e8@gmail.com>
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

In Rust 1.78.0, Clippy introduced the `ref_as_ptr` lint [1]:

> Using `as` casts may result in silently changing mutability or type.

While this doesn't eliminate unchecked `as` conversions, it makes such
conversions easier to scrutinize.  It also has the slight benefit of
removing a degree of freedom on which to bikeshed. Thus apply the
changes and enable the lint -- no functional change intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#ref_as_ptr [1]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me/
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                 |  1 +
 rust/bindings/lib.rs     |  1 +
 rust/kernel/configfs.rs  | 20 ++++++--------------
 rust/kernel/device_id.rs |  2 +-
 rust/kernel/fs/file.rs   |  2 +-
 rust/kernel/str.rs       |  4 ++--
 rust/kernel/uaccess.rs   |  4 ++--
 rust/uapi/lib.rs         |  1 +
 8 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/Makefile b/Makefile
index 29cf39be14de..1a855f42a34a 100644
--- a/Makefile
+++ b/Makefile
@@ -489,6 +489,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::no_mangle_with_rust_abi \
 			    -Wclippy::ptr_as_ptr \
 			    -Wclippy::ptr_cast_constness \
+			    -Wclippy::ref_as_ptr \
 			    -Wclippy::undocumented_unsafe_blocks \
 			    -Wclippy::unnecessary_safety_comment \
 			    -Wclippy::unnecessary_safety_doc \
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 7631c9f6708d..474cc98c48a3 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -27,6 +27,7 @@
 #[allow(dead_code)]
 #[allow(clippy::cast_lossless)]
 #[allow(clippy::ptr_as_ptr)]
+#[allow(clippy::ref_as_ptr)]
 #[allow(clippy::undocumented_unsafe_blocks)]
 #[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
 mod bindings_raw {
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index bc8e15dcec18..1ddac786bd0d 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -426,7 +426,7 @@ impl<Parent, Child> GroupOperationsVTable<Parent, Child>
     };
 
     const fn vtable_ptr() -> *const bindings::configfs_group_operations {
-        &Self::VTABLE as *const bindings::configfs_group_operations
+        &Self::VTABLE
     }
 }
 
@@ -464,7 +464,7 @@ impl<Data> ItemOperationsVTable<Group<Data>, Data>
     };
 
     const fn vtable_ptr() -> *const bindings::configfs_item_operations {
-        &Self::VTABLE as *const bindings::configfs_item_operations
+        &Self::VTABLE
     }
 }
 
@@ -476,7 +476,7 @@ impl<Data> ItemOperationsVTable<Subsystem<Data>, Data> {
     };
 
     const fn vtable_ptr() -> *const bindings::configfs_item_operations {
-        &Self::VTABLE as *const bindings::configfs_item_operations
+        &Self::VTABLE
     }
 }
 
@@ -717,11 +717,7 @@ impl<const N: usize, Data> AttributeList<N, Data> {
 
         // SAFETY: By function safety requirements, we have exclusive access to
         // `self` and the reference created below will be exclusive.
-        unsafe {
-            (&mut *self.0.get())[I] = (attribute as *const Attribute<ID, O, Data>)
-                .cast_mut()
-                .cast()
-        };
+        unsafe { (&mut *self.0.get())[I] = core::ptr::from_ref(attribute).cast_mut().cast() };
     }
 }
 
@@ -761,9 +757,7 @@ pub const fn new_with_child_ctor<const N: usize, Child>(
                         ct_owner: owner.as_ptr(),
                         ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr().cast_mut(),
                         ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
-                        ct_attrs: (attributes as *const AttributeList<N, Data>)
-                            .cast_mut()
-                            .cast(),
+                        ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
                         ct_bin_attrs: core::ptr::null_mut(),
                     }),
                     _p: PhantomData,
@@ -780,9 +774,7 @@ pub const fn new<const N: usize>(
                         ct_owner: owner.as_ptr(),
                         ct_group_ops: core::ptr::null_mut(),
                         ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
-                        ct_attrs: (attributes as *const AttributeList<N, Data>)
-                            .cast_mut()
-                            .cast(),
+                        ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
                         ct_bin_attrs: core::ptr::null_mut(),
                     }),
                     _p: PhantomData,
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index f9d55ac7b9e6..3dc72ca8cfc2 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -136,7 +136,7 @@ impl<T: RawDeviceId, U, const N: usize> IdTable<T, U> for IdArray<T, U, N> {
     fn as_ptr(&self) -> *const T::RawType {
         // This cannot be `self.ids.as_ptr()`, as the return pointer must have correct provenance
         // to access the sentinel.
-        (self as *const Self).cast()
+        core::ptr::from_ref(self).cast()
     }
 
     fn id(&self, index: usize) -> &T::RawType {
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index e9bfbad00755..35fd5db35c46 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -366,7 +366,7 @@ fn deref(&self) -> &LocalFile {
         //
         // By the type invariants, there are no `fdget_pos` calls that did not take the
         // `f_pos_lock` mutex.
-        unsafe { LocalFile::from_raw_file((self as *const Self).cast()) }
+        unsafe { LocalFile::from_raw_file(core::ptr::from_ref(self).cast()) }
     }
 }
 
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 43597eb7c5c1..cbc8b459ed41 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -29,7 +29,7 @@ pub const fn is_empty(&self) -> bool {
     #[inline]
     pub const fn from_bytes(bytes: &[u8]) -> &Self {
         // SAFETY: `BStr` is transparent to `[u8]`.
-        unsafe { &*(bytes as *const [u8] as *const BStr) }
+        unsafe { &*(core::ptr::from_ref(bytes) as *const BStr) }
     }
 
     /// Strip a prefix from `self`. Delegates to [`slice::strip_prefix`].
@@ -290,7 +290,7 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
     #[inline]
     pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
         // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
-        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
+        unsafe { &mut *(core::ptr::from_mut(bytes) as *mut CStr) }
     }
 
     /// Returns a C pointer to the string.
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 6d70edd8086a..4ef13cf13a78 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -240,7 +240,7 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
     pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
         // SAFETY: The types are compatible and `read_raw` doesn't write uninitialized bytes to
         // `out`.
-        let out = unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<u8>]) };
+        let out = unsafe { &mut *(core::ptr::from_mut(out) as *mut [MaybeUninit<u8>]) };
         self.read_raw(out)
     }
 
@@ -355,7 +355,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         let res = unsafe {
             bindings::_copy_to_user(
                 self.ptr as *mut c_void,
-                (value as *const T).cast::<c_void>(),
+                core::ptr::from_ref(value).cast::<c_void>(),
                 len,
             )
         };
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 08e68ebef606..31c2f713313f 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -16,6 +16,7 @@
     clippy::all,
     clippy::cast_lossless,
     clippy::ptr_as_ptr,
+    clippy::ref_as_ptr,
     clippy::undocumented_unsafe_blocks,
     dead_code,
     missing_docs,

-- 
2.49.0


