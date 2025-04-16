Return-Path: <linux-kselftest+bounces-30970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06438A90A39
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 19:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAD219058EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 17:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB21223320;
	Wed, 16 Apr 2025 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax1DPGIf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C92222B4;
	Wed, 16 Apr 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824996; cv=none; b=SuIgGaoz+xD6sifHu8mKSQuS7lgKqHmrzjEEoRCEkK3SIq+Kin7LEMIeHb0VGPCzsVud4DclPQJ7iF7M33p7q2EnQS4MLTw3CjhKcVL2T6qu4USVokTpfLkgWw1yW8O9JQmavlb18TbDIpCqDOgNF7Cl76I2TEEAd82r3KSxSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824996; c=relaxed/simple;
	bh=ZH+gJvR96pmCzXAlh2JcvTx8DVnyLHw0hcOEVuzlq8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DRSBW6hVFCmTj11mQS9b39fxiqOQLChYPnzXbr+n/9PF/0ieNss5GoRtSdEOryd77PAcCwu+ZlHQoNS9DVvgln56Lf0PfYqSdImaPUPyXy+AnydTdO+F30E7m2rFEwyt+Frz9gvgzyTmZW8js85cu182p7lCt8rhOaZznQoj/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax1DPGIf; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f6970326so66739896d6.0;
        Wed, 16 Apr 2025 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824993; x=1745429793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70V/ZNK+rmYoFvMHiW/74+os3nIm0NWF0rbd6T5wy5s=;
        b=Ax1DPGIfIQdnoLU0j75qLc4Id8+HmwqNHsDWHLIigxPVmceAQC7f9S+ALiV/4KKdP/
         kxtWN/WZ3J37g1y5DGh9dCbPaqwe7agiMWJjvaDOYepE5NTfOW9ppugDCiVbyeJ8Tbwb
         8dyvLBXfe54SCRBZfp/WD3EM+hOJ0HCprSNSUbo/XryF5gFYJ8qV/V7SRkkb7Ul4ZiHU
         c7SkoNIy2u9Q24yNKZ0Zi4Gc+QysVFlAYwMTKjS/AqGS+dXxewsphln6mVCQswf3T+Wl
         +P82/fwLbDf3Ch+q9eyB17qqvl6oYPhu5P/hdCJdN+jh9p/VW9xL0Kj98jRtXX1muRnd
         Frsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824993; x=1745429793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70V/ZNK+rmYoFvMHiW/74+os3nIm0NWF0rbd6T5wy5s=;
        b=T98Cjj/N2md0nsG2V59uccekdzDU7ddPCAIq15i+wAWSy7lnDlfuos1zKSH/VlB1g+
         rZh0+2zkiOyjS31/9bE9OfwRpFymau6/XBicKIjek3lVUeFLS2+tGy8rZX7hHz+xR5qq
         5BQiG8YDdfXWD9VQaPP+v5vA3FpGkH9gDLNw274/fjmMhaU5aI73jM0LkwjBESXaSNwO
         NW7mNoBrV/reJEgtsxpecbbIAxixC5o/wqBA+rX+VxEvhe7a+fU1VvBZ8JsIJBR7uf3W
         a2fayrHwuE0frY4CNi5C1zXQ6NSMIyQgQ3SCXf+XTzzJkK9PNbsVEvLoK5CpNL4WLX4q
         yUSA==
X-Forwarded-Encrypted: i=1; AJvYcCUDYrnm7umEmNs0uuGOmfh7Nsy2nZ/dGYnehEvjLujeBmRVNgiOrsavCZ4ufr6P8+bIHWeke/6tcF27NJFNfZ8=@vger.kernel.org, AJvYcCV89yW+KcRkwNwqYu9Ge7zr8jFzSaFAQf7WKrvg1EBAaNCYE4Y2pNil4nXLdaGGb1iwsSXDIfFiNR5q@vger.kernel.org, AJvYcCVP68yHc1FVB/wj1z40zKgh4/B1DipGgxEOEFY61g9EIuQgCA1Bpnttm9DBOagaYMlaTJAJEaNtC56Q5vWbY7pr@vger.kernel.org, AJvYcCVsVhGyBx3oQ3Szy7Y+IKcqs3A2kA2/J4A9tvXB4IlGJ6E7xD6VrBH/nq/TbQM2ZbwLB/wWj0PMFP8C@vger.kernel.org, AJvYcCWBGoyVeZ4WSY7pOyjFzL8aRF+KKArnlzhzG1Es984GIL/0LTpBKnJ6aR1AVEgpAYviGjqX78CU@vger.kernel.org, AJvYcCWhyX5XqhYqslnFv8JhyYPrvqrGKiTLABv+4GDZMecF9p+LQyQiNZf/MqDpbySnGjsOnB7KPs8ruMui1lvr@vger.kernel.org, AJvYcCXPbefFQ+OO5sIrsvepf9pPfoS8Ies4qy9fgXimEUFkYJuBvSvqkLZJxsTIojVzVvIIDcHVJqt8YKlQv3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/KBYl7Du75xhS+ciPG6D27jGrkagOWjghwnnMOgjSsOqVWQQ
	ZkmZV5sSZ01GaXVjvQQ+FdzRSUejGMXuzOL/wt6vzNpOhpeWig3Z
X-Gm-Gg: ASbGncvqy7301Tisuh0FcH1yOwtd86n4lGpmieoAHcrErbm9Y0Vo84ss7bhUfm/GvkL
	1ekrpj5XgjGWoHNVRagJrhNA0UxV7nvv9Mr1lVNLBqUbcfcorps7dY/sJUTAtXI9PvBfqWDwoXy
	KyQ6qDHPdVe4puuZj7mOCZJSh1rIMYvicW0wsXmXn0hDuwlJoqcC7gtbHDC5ph439jZFjIjE9Ah
	2cZqgjU6G3GHxn9f42ve2yQaala9Nw6U458y7cJ/797erR8OiYSJUOSuUcuEvnkywF4o4lR3y//
	lTfQLiAe0/ACv4C3dM3KQ6f0iDm/M2Ss20f1b2VbAbtFf0HazYE0XA6/7nazS1LI0s8WXopA0OG
	3tmSR4rdyLcmWh7A8+fjjcJngcF2zXsRyQmyaNErPU1DX
X-Google-Smtp-Source: AGHT+IHoff5UaNKwwImuHNe3ew0+XBOuxETDH2IiJSCOUP4kTLnxRtQBJcnt2KWDVXSB29dyM1PQUA==
X-Received: by 2002:a05:6214:411b:b0:6f2:a457:19a with SMTP id 6a1803df08f44-6f2b2f8bf34mr40614196d6.25.1744824993112;
        Wed, 16 Apr 2025 10:36:33 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:a61d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea07c50sm118289886d6.77.2025.04.16.10.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:36:32 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 16 Apr 2025 13:36:10 -0400
Subject: [PATCH v9 6/6] rust: enable `clippy::ref_as_ptr` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-ptr-as-ptr-v9-6-18ec29b1b1f3@gmail.com>
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
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                 | 1 +
 rust/bindings/lib.rs     | 1 +
 rust/kernel/device_id.rs | 2 +-
 rust/kernel/fs/file.rs   | 2 +-
 rust/kernel/str.rs       | 4 ++--
 rust/kernel/uaccess.rs   | 4 ++--
 rust/uapi/lib.rs         | 1 +
 7 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index eb5a942241a2..2a16e02f26db 100644
--- a/Makefile
+++ b/Makefile
@@ -485,6 +485,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::no_mangle_with_rust_abi \
 			    -Wclippy::ptr_as_ptr \
 			    -Wclippy::ptr_cast_constness \
+			    -Wclippy::ref_as_ptr \
 			    -Wclippy::undocumented_unsafe_blocks \
 			    -Wclippy::unnecessary_safety_comment \
 			    -Wclippy::unnecessary_safety_doc \
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index b105a0d899cc..2b69016070c6 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -27,6 +27,7 @@
 #[allow(dead_code)]
 #[allow(clippy::cast_lossless)]
 #[allow(clippy::ptr_as_ptr)]
+#[allow(clippy::ref_as_ptr)]
 #[allow(clippy::undocumented_unsafe_blocks)]
 mod bindings_raw {
     // Manual definition for blocklisted types.
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 4063f09d76d9..74b5db81231f 100644
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
index 791f493ada10..c9a86beacb65 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -364,7 +364,7 @@ fn deref(&self) -> &LocalFile {
         //
         // By the type invariants, there are no `fdget_pos` calls that did not take the
         // `f_pos_lock` mutex.
-        unsafe { LocalFile::from_raw_file((self as *const Self).cast()) }
+        unsafe { LocalFile::from_raw_file(core::ptr::from_ref(self).cast()) }
     }
 }
 
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 40034f77fc2f..ca173ae3282d 100644
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
index 80a9782b1c6e..5f8e1e7babb3 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -242,7 +242,7 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
     pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
         // SAFETY: The types are compatible and `read_raw` doesn't write uninitialized bytes to
         // `out`.
-        let out = unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<u8>]) };
+        let out = unsafe { &mut *(core::ptr::from_mut(out) as *mut [MaybeUninit<u8>]) };
         self.read_raw(out)
     }
 
@@ -357,7 +357,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         let res = unsafe {
             bindings::_copy_to_user(
                 self.ptr as *mut c_void,
-                (value as *const T).cast::<c_void>(),
+                core::ptr::from_ref(value).cast::<c_void>(),
                 len,
             )
         };
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index d5dab4dfabec..6230ba48201d 100644
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


