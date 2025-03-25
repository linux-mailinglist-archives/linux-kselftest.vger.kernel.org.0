Return-Path: <linux-kselftest+bounces-29784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310ABA70B56
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 21:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BB97A8395
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 20:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B604269D0A;
	Tue, 25 Mar 2025 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSJRB5C1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ACC2698BF;
	Tue, 25 Mar 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933284; cv=none; b=hWJT5vcjq9edpf0JNxXPgDeShgpSQCZaXNxO9EBTh70Lm5vQEvkLohDic1M2DNKzJ456CgkfZ7mtFb/y6KzHflkd+QeU+cUomWyY58DKa3+l//b7zHiXpehadh1duMm6qjeOI0wRqvjY/aBX9p0I7ydk7sAT9DnbMLHpdOYm23s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933284; c=relaxed/simple;
	bh=yBKqzzQdtoM713Hx6YAh/9BRAMg/fNmYA6aigYaIn0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7uOj4dCcz5pIly7Gl0jJIAY8S1MuIpjYjDkAayIaD7ilDUSnyn8bGmcY17qaU8RYAHS25tENA3uGQ6ITld02+pb4bCItD9LPZL8I9LFqUimbOCwpDXCbw/2F+IHeyqKUvuk8oDsOaDF+NFiPMpWDFj68HAf+grFYhaci0uwFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSJRB5C1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so2107016d6.0;
        Tue, 25 Mar 2025 13:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933281; x=1743538081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7qMAKZkfn3qZ7sMOOmPjuPsXs8aZ5zQxKqzh4XVWmo=;
        b=dSJRB5C1CJrbQn3hnycGwhGMpNLlqaB/c2riiOc5A6RZ/2o+tNpnWssJURPxpjkjTX
         6KFl7v8ua/NF+pUpl3LDMegXZkztwqpePSb0z/WnG+CEjK5kRIOxZhcD2hfSVs3Fgp3R
         chQICJB51wmRSPjAWUL3r7D95cHOJuqpO/ClkETWAtrQlrIGKHkCviHkvBHxMlPs1SUt
         xO8qCtlnanB2QRX6G4yGT4S26kzyI2+ILusI+eRSBU+XBURaMNjY7OdvCUXd3ALI3qA7
         +KICzWZxlBAGdzPsDRKb0NAygMMYL0LmnFfNt2SIsVuypLVl96EttSL8brRIaf1vc0sK
         /k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933281; x=1743538081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7qMAKZkfn3qZ7sMOOmPjuPsXs8aZ5zQxKqzh4XVWmo=;
        b=EG/gm//zcMemgkbW7gHmOcj8v3fjzPEVST98yX3gtVvL+Vmw3BRxP87fyAo7P9+XA6
         y/Hoj1uteNoDR8vohz5RNZ9QAwvEBSV2lNN5XPwQ6oJeDkzNHZCvkOJZxXBIMyNxgHlh
         Z3RpECiKoQNE06EYW2rabpB9j7Dw5sE+hrQ175rruGgZT4F81wQMs6YiCgwHkIxIMY2m
         DzIDR7rK1lRo/9UD+Xcn5bgxwjuC58u9ohyFs5eWm7CwLyLYe2iC6PNqA1SpyV8s/kci
         u1FJ37puPb6wV/ujB0VahhSiJu49nWRuBXBWK71Um+POSLoma6bkfe5V/S14ioTKcSh7
         gKzw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Zd5AGsDS/tgbkc2jE05O81iEZdx1R8aNORl+ZGdLqwPSh3THE7/ESFg9DJY06s7huXX3JLJzm4xOBtof@vger.kernel.org, AJvYcCVqPhMcUcHbPJWPjUCzIuRI9mDFrLyWdob4Sf4WcV9DnybvsSCdbRRGlVtq7huNSMwO2PZvjB2GQVBGDvUKTSk=@vger.kernel.org, AJvYcCVqkRDvEXIlIyphaw2lyDA5Se+s/hO6QCcw41jTR5qw5eBnh/uOReW87pNHMHYralhJXUFhkv50UOq5/JRRHq6H@vger.kernel.org, AJvYcCW9F/978SXMgonDZWwHXOyQl5mcxGzDpU1mOBz1zpdPaWtjPllYynVzVJ7mgHrgrBoW9ayCssmeT7Am@vger.kernel.org, AJvYcCWHINeJ5VMqnco69REo9bW/bZfFwbW2YsmoJRhY3Bz2gg2fD0fob5UdhfDaBQHtRPDJOzUaT6itZ4B7n0g=@vger.kernel.org, AJvYcCWtp6NwJ1zLmBXmNu5UaJevYtfZiYWROUooVPoUVtR5IwcK8Ow4lsdh2FB+d++Ct2jOahvP8grxp7nc@vger.kernel.org, AJvYcCX2P/yC4L/2u71AnKfOkj2TWByDdMULLtjfMat29C4Udovl6IZfgVARwh3IEs6/URdl9qtuNx/y@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYRSiCTk9H8ZwoKuGhtv6Z6+L1B2MYGLvD1lZL/6l/eQ/zXc4
	gZm2alapGVe3VYvZPv0wc6pbwTExJwfgEWyC1Ll5XwoGGIJata46TlVRJWcvVsU=
X-Gm-Gg: ASbGnctJzUwFbQOnon1hMe6pzlDNNc7yYCNGFPMM5rP+QUV7dnRPvfXTWsdYhe65UpA
	sXAXA9czP+0GWoMQPSeL4dlTInv2uwc/0lLYQUBwU0SJflGfTweFI7rNnxp4RC9qJsCenH8zRL0
	uifMm4X16/be/25sPpEWhzzVGLo3uJeJj0tzshRB/T7eynu4I9Rvd37Q/7+/8fEv/GEfwWUwaT/
	BfR/RctT+8b6M3ViAQkJm+4/MaenIcMQEBeivLv7JlbxNmk/jZXZCiJjlU9zqi8FUCtmaT1ahMh
	g+52Ht1EehnYN93tOc9vGCh4CGdS18wmS9E0ydOzyBhc2Aqey27KZG619V1RlmQagGggIeldAkT
	Cc9Cdl/LCjIB9sbUJZf1zK5QfPnnTkf/qohgfk+9c6lfEhSTDZu3HjA==
X-Google-Smtp-Source: AGHT+IFcj7P2M43acjXCLPntAogjbFV68WayLoYS23bXlpmJcLC/E6TkncrczRInojNWt3+ooJGElA==
X-Received: by 2002:a05:6214:2528:b0:6e8:ec18:a1be with SMTP id 6a1803df08f44-6ed16c3e8cemr17403746d6.7.1742933280534;
        Tue, 25 Mar 2025 13:08:00 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef31810sm59790316d6.64.2025.03.25.13.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:08:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:07:47 -0400
Subject: [PATCH v7 7/7] rust: enable `clippy::ref_as_ptr` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-ptr-as-ptr-v7-7-87ab452147b9@gmail.com>
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
In-Reply-To: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
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

In Rust 1.78.0, Clippy introduced the `ref_as_ptr` lint [1]:

> Using `as` casts may result in silently changing mutability or type.

While this doesn't eliminate unchecked `as` conversions, it makes such
conversions easier to scrutinize.  It also has the slight benefit of
removing a degree of freedom on which to bikeshed. Thus apply the
changes and enable the lint -- no functional change intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#ref_as_ptr [1]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me/
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                 | 1 +
 rust/bindings/lib.rs     | 1 +
 rust/kernel/device_id.rs | 3 ++-
 rust/kernel/fs/file.rs   | 3 ++-
 rust/kernel/str.rs       | 4 ++--
 rust/kernel/uaccess.rs   | 5 +++--
 rust/uapi/lib.rs         | 1 +
 7 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 2e9eca8b7671..081b5fa2aa81 100644
--- a/Makefile
+++ b/Makefile
@@ -488,6 +488,7 @@ export rust_common_flags := --edition=2021 \
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
index 4063f09d76d9..37cc03d1df4c 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -136,7 +136,8 @@ impl<T: RawDeviceId, U, const N: usize> IdTable<T, U> for IdArray<T, U, N> {
     fn as_ptr(&self) -> *const T::RawType {
         // This cannot be `self.ids.as_ptr()`, as the return pointer must have correct provenance
         // to access the sentinel.
-        (self as *const Self).cast()
+        let this: *const Self = self;
+        this.cast()
     }
 
     fn id(&self, index: usize) -> &T::RawType {
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 9e2639aee61a..366e23dc0803 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -359,12 +359,13 @@ impl core::ops::Deref for File {
     type Target = LocalFile;
     #[inline]
     fn deref(&self) -> &LocalFile {
+        let this: *const Self = self;
         // SAFETY: The caller provides a `&File`, and since it is a reference, it must point at a
         // valid file for the desired duration.
         //
         // By the type invariants, there are no `fdget_pos` calls that did not take the
         // `f_pos_lock` mutex.
-        unsafe { LocalFile::from_raw_file((self as *const Self).cast()) }
+        unsafe { LocalFile::from_raw_file(this.cast()) }
     }
 }
 
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 40034f77fc2f..6233af50bab7 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -29,7 +29,7 @@ pub const fn is_empty(&self) -> bool {
     #[inline]
     pub const fn from_bytes(bytes: &[u8]) -> &Self {
         // SAFETY: `BStr` is transparent to `[u8]`.
-        unsafe { &*(bytes as *const [u8] as *const BStr) }
+        unsafe { &*(core::mem::transmute::<*const [u8], *const Self>(bytes)) }
     }
 
     /// Strip a prefix from `self`. Delegates to [`slice::strip_prefix`].
@@ -290,7 +290,7 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
     #[inline]
     pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
         // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
-        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
+        unsafe { &mut *(core::mem::transmute::<*mut [u8], *mut Self>(bytes)) }
     }
 
     /// Returns a C pointer to the string.
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 80a9782b1c6e..c042b1fe499e 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -242,7 +242,7 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
     pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
         // SAFETY: The types are compatible and `read_raw` doesn't write uninitialized bytes to
         // `out`.
-        let out = unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<u8>]) };
+        let out = unsafe { &mut *(core::mem::transmute::<*mut [u8], *mut [MaybeUninit<u8>]>(out)) };
         self.read_raw(out)
     }
 
@@ -348,6 +348,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         if len > self.length {
             return Err(EFAULT);
         }
+        let value: *const T = value;
         // SAFETY: The reference points to a value of type `T`, so it is valid for reading
         // `size_of::<T>()` bytes.
         //
@@ -357,7 +358,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         let res = unsafe {
             bindings::_copy_to_user(
                 self.ptr as *mut c_void,
-                (value as *const T).cast::<c_void>(),
+                value.cast::<c_void>(),
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


