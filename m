Return-Path: <linux-kselftest+bounces-31136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECB6A939E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6B41B66AED
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC53521C9F4;
	Fri, 18 Apr 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmuGMUuF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B021C195;
	Fri, 18 Apr 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990660; cv=none; b=souBQkGBCcC/g9klOEPVUKxb/Etlt3R9UGSic5V5gzh2JRiXcrWDuCq5g9Oeya+gm0XMUdpEFIuPbqDRrkDM24LF21iS/UYIBQAq9LhZMNhssy5ja/RjWDq+yViDkqiUCfw4e95u+3AIXlVjIn0uZLOEf3Ijda65sfs8MqlSSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990660; c=relaxed/simple;
	bh=eIURL2AYb8L+wdwnY5KekUFI1cWHm1PC7DhcpJHkmYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tMcrL8FEb3HmWPbDEewinnBkoAr5e5P7CRqI1dphTQ5XXp413Yk3jxd+uoDxWdvSPkzcl0kjyiKwrxWozMCZXLfAiS1aBc41FpJgf3lbEnE6dgf7gzPlfSEhE8vCWTmwGSKQLXI7GyoCixGa0MMFO4G9fSaeMeqY2DOo3DdrJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmuGMUuF; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f2b05f87bcso19284746d6.3;
        Fri, 18 Apr 2025 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744990657; x=1745595457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5hiiUh/P67/GQqlTcZ6AkOFOmj5iMZ3jMe2SBwJf9k=;
        b=CmuGMUuFXeSsXp97bwDOZfWIGsiPAmoAi4RJzECzDVt2xCZnCFlbioLa/xYIqog9ZX
         2EImODolW80MDUUx5F83KI5qeZpgN0DkKyuQ8XRyRhSh7PH7GH2tqfASTzwz7QesLlr1
         ykesOIE/xE+I9J3Wy/wt3XM7dfudB5CnRlUBDkBRBIovNhJgk+/vg4M9NzmNEnh26m/+
         V4pBgVbgqZ6tUBlLjyUJh5nkcq2yggIqYtfGBhdtieIaVanuqjR1RUlAj5KgTXMMHJMr
         0g5Z1RQtUh4IyI6VCZutXTL0O+BtZmhQRHzR9TTB6nI8f9w0R1D54epSDWnMiFYVukPu
         +LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744990657; x=1745595457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5hiiUh/P67/GQqlTcZ6AkOFOmj5iMZ3jMe2SBwJf9k=;
        b=iTEcEpsoZAQr/4zQVBviloDNfUqHStcXDz1ym0PI28v59kTNfjcv+F7PcgrfeGKNzF
         ULULnVrDMmjoOoQxYrP9gBRNF1Jhxpq7RCJlg/+Tbph9gxfJMvCLv54QPrlRVrqFgfJ4
         1iEXXnzVvNih0lt30Wv/K0kOP79P4j5rwhlYRyJK257+MNQ+HvCDuwqPnrtcUSuWy+Bc
         WTFig1TfdMf9xXS8RyrJUQHMf9p4+BeAgvBq8CYuFeKoghZQfBbj9VFnEf+H01+NjYki
         OxP1FmHViH16jZU+xniDJzdB6aHIoKoqawlsIcG+7ObAWwB+6ztUKtzrneeiUBq3H517
         JGsw==
X-Forwarded-Encrypted: i=1; AJvYcCU0860C6482POdFvsbWhqCaic8tL8sZ4G++SUqDk/nIX+MU8cFVktHAGpNrSmgfzyuI+ATJI/bPvujURm4l@vger.kernel.org, AJvYcCU0Wzr9byEQ9Tw8xjbWOx0MK8euywx2wMpRAvM+gLzrQpuwYt548smIyMc173f7N2zKTb4KQD7FH5oo4+GIX+io@vger.kernel.org, AJvYcCUFi7Phvf+DFWWUGjx2G1WArjpFjAfNnWC4MpKaQVCsIHiE1ybjAZzhuk7baLT29QKT65In0QUz0nmp@vger.kernel.org, AJvYcCVOQ4yCrsqrMfHRSoQ1wv0XxlvY8nVc9KvmsuddpVfnyh+t1h8Y7eIhS1kgF/jiOSOP/vH1fA6c2coVnAQ=@vger.kernel.org, AJvYcCVY2UeVET7nxJlf3kR7af6LtqnQw8wj1720lDIm15vBy33ex3bSz+bose4gNPxVShNCknHKIaX//EcI@vger.kernel.org, AJvYcCVqJBc8F5AlikBaQHZTLBUUAH9s7iXyTEcsLOLMRvBmEKUWwHqqyzIUZF+yTrjJZxpdaLGzPIE43u+IpLMstiU=@vger.kernel.org, AJvYcCWzGWFUFEetWW5PvzqJX0t/qxxkLsjy45tf6VhTP5vKdSYKUj6SmI9rU6zBwadvdtYzGkjUxfSe@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFZnEPMijKcUvGd3zBQiS7FyM5XUcQXb9xnr0ifHfKY6YwITS
	XIxU1jRoMJfGDuixuboVT5nSPQ07MwmbSu+ZMBvLaJ1bJH2yMMUO5Vyd1tRC
X-Gm-Gg: ASbGnctN5ozcMF+ImXugEbzit2iNkuiglrJClwB+m6na9XzxpUd7K6vlluhG0IOgF12
	QM1ESwbJBS7G7lgl5fHngfspNFgWuHprUZwIjzRoKGckyRwKizNDYXIYE0lKtWodfBXinNdzXPt
	ur/hQmrjo0Lnk+GrDN1ONWtpVDtLTbXgEXXO7LiX2yPx54EIKnaF/8KQX6e3JgUo5EFfdA1UFqr
	qx2U3WKzMYf9S8q/5QLl0jEmYD2QLU8mTevKqMJgYQMJnYSQBsFjC7sSsv1GSl/JX/XyMw21p3I
	iPBE06nHdEthQnY+0ha2L2AFHbjKYWaymxMs5uI4GWKmaDpmWbfA50AQYRCr859fAxVMpn5z8yV
	HHpZO
X-Google-Smtp-Source: AGHT+IE6q7vZay+OEaNaFKC2yY4Mgb23CsaphyC2no0B8NXz2XdFGwpfQ02v9LdUIlLAeT+YHdFGgQ==
X-Received: by 2002:a05:6214:1d0c:b0:6e8:86d3:be78 with SMTP id 6a1803df08f44-6f2c46b88b4mr48009246d6.37.1744990656672;
        Fri, 18 Apr 2025 08:37:36 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:7988:e5e5:1f4c:be78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21d9bsm11623096d6.96.2025.04.18.08.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 08:37:36 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 18 Apr 2025 11:37:22 -0400
Subject: [PATCH v10 6/6] rust: enable `clippy::ref_as_ptr` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-ptr-as-ptr-v10-6-3d63d27907aa@gmail.com>
References: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
In-Reply-To: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
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
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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


