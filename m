Return-Path: <linux-kselftest+bounces-30436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D9BA828FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35684A476A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4626FA60;
	Wed,  9 Apr 2025 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSDS/mD1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5826AAAA;
	Wed,  9 Apr 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210059; cv=none; b=EBAcIsM5xLPoiBWheGAK7QzsANHtE2u+0eqO4PLm8m+KzCU+sueimEToQfI8kLFNqsadiN3xQL/XrvCGXb8ME8e9kEA7huslrLEFYLAY/M0leKYJoL2aopBQQ/v1VBQ/TuV8/tXp1SWGZRBec3qW3FcIuhY1ybd4+NfFJAlw1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210059; c=relaxed/simple;
	bh=QE1XMyiEfHKVDVPNBt1oL3c+f45lsJThYSxbdchE9vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBrJ5chdJrHchYPgfKTtI3/NUgZ3aXRGxbpuTrYBtdGPDzetym8wvpFLQ91Zi02MuSJKC4zkKX67yndaawm5N0gBytUHs47JjJVza+djasOZHIigTiOtqo8/R52YDvO6yaewbaP/RBqKQeDkOB8y7Ll0VMuD8EmRqs+bee3aUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSDS/mD1; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47692b9d059so34572601cf.3;
        Wed, 09 Apr 2025 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210057; x=1744814857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdDH+qr7UBoA/lgIB3GeZraE2OIbymXMH9TLc56aCLg=;
        b=HSDS/mD1UAWmMkEy56VKtH6IZlmEu3N1tpbANV1fMKomEa7hCa/k9RPxPc50f1sGp1
         rKtB+XqxN7yDZq+zAieJzce7Yils7OZXreBNm57obtFlOkW1c2vapeeM1ln0SIPMybkf
         kkwLeFucI2TTL9MHR0fVmFOeYsxPZVOeQtrFv/ir7f14y993mcRr2WfGXVuHlyPQmozK
         bLWPIveM7osq3XVSYM/+eyqxjtzhy8I4QfbFqudOH1rSrRW30pF26s+PLqvjhparreRX
         +bsQkqVVjQfAXKCPC1Eshx7n5uJ8XxqhKf7rZSrTTAcTcOumhn+/n4bZ0A7svPiRQTKa
         yZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210057; x=1744814857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdDH+qr7UBoA/lgIB3GeZraE2OIbymXMH9TLc56aCLg=;
        b=byfChugHBH+XCoMlWIe0sZRrct55p1iZh8z1ktn50iUS9dLUTMvkbOaBegz8CFXpSZ
         ZUlnebzOsvBFDkEARVwj20bd+RU+e0FyMB60oeXt73RStW1FfJhqKpjIK7e87/MG8o1n
         mw3I90yxDwCW0gNAI7qZgQWdYAz24ylGZui+pBM7xR3nVFtx44SPyscoAU3jQN7KATbt
         9rNVB6f8T+lYmLBHBWIjX7w+wOPT2180ZCVt9/XaO2KZooDv/jRXZmSG9LjYcicHODyF
         HKnF/7CZhaZRK+lOXg/7hhsnJAGQwG3BDs3CaGt2ygm3lOlh8cvnqc4+eADtAqZWSZRi
         QbuA==
X-Forwarded-Encrypted: i=1; AJvYcCUz1B/yAh79EZQKTxppzR1B4Jqje8NTdm1p0abRbLOyfOSKWDatrL/mIxvorGgjRz3Ej0AZQJUp@vger.kernel.org, AJvYcCV44OyIVay3X/EdS1xcNTw/fgOU6qerGZosN1Toxo4VyZ5GDyKh8yTkRAz2+bOjCP7jfPQDdb9ZG86UKJtPLvo=@vger.kernel.org, AJvYcCVgQo1JuazwgIT9BFRCaOAG6yd/ZXoBo9GxxCz1Hud1Zd1u8HYvoh3120DtYZextM2BqzfPyH9RoOWVTDz3@vger.kernel.org, AJvYcCVhLdEAijLfauEdht0YfXXbsIZ2IS9vu4Xc8S408aqqQ8vpzK/4Uw1z4mJVS8ttaA074hMP9Z9ntEhEo++/tIIT@vger.kernel.org, AJvYcCW15GNwYgkaBMjeOwVWXLmYgVHzZXxX0UG4806cAzXanUriT/ZzLmV+jzGAL9i4DTnnKCH49UA/Huq6@vger.kernel.org, AJvYcCWXRSCCFwdmLNjaJUuzvbL/yor5WyJJ6W8X2uFOqFpG20x5/JojI1X3hxnaBDeKFtL+4HAPoLotnkrU@vger.kernel.org, AJvYcCWrFe51eZBIRrR2QuDStsiOeDvc22IGEQDwXijI07BooNu0AqbzZTB+Lp7babMEA8q4Q+vDVOt5xDurnKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8l48HZqOkMe9PtVH6yJdQsMviuZY489GXfygrLs1G8c2NjKfy
	LIvUl+3ez6IeSpu480TZ+qsoJC8QnIJCZLbQF1Y8cHNeY272G0nc
X-Gm-Gg: ASbGnctK9kWguV3sj3vhVtTxmSiT/grLrh5uCi+FsPlpIXbHH9MJ7CEmkIieaUd8Wk6
	u0l1++Fp5n6Dx66bxomZo8gB3h4FM5DjdX9tovYB/dg0qk1CfhjeOXhDFDIrIUQ+TdXtsKFEq1I
	zA1corVD5wZPkV9xHOzcHAmguPxwiM1YyxvWLoIaAtX4zlWaat5whWmu5OmOvoEL/TT8q1gsclo
	HaMivfd7DT/QNaZkgeP7X0RyMSKzXHKoYaXkAQB/vHx2fbGzFSaoAceRV1s1dIUpOfeJp4/AmSu
	bgYbUarjCGZ2Eys5qocddkY0Kqgu66WFxFj4SC469Dvu7ixP9/IBu9Mcujz59VFgXhvyuYz1+uD
	1um5Lv0fmeZ8bM7g/tJHTjdPAgZudlHRbZDjjRB86oTbtBsDzY4klvw0=
X-Google-Smtp-Source: AGHT+IFr7umJxKzgzhGh/oy0Dih4g5haX41vEbYRI8F+ERkJbmGl9jimDDp7gEjubuafDokQiSZEmA==
X-Received: by 2002:ac8:7d4c:0:b0:476:8cad:72d7 with SMTP id d75a77b69052e-4796007888bmr32351221cf.8.1744210056456;
        Wed, 09 Apr 2025 07:47:36 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:3298])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964eb9a8fsm8024461cf.49.2025.04.09.07.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:47:35 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Apr 2025 10:47:23 -0400
Subject: [PATCH v8 6/6] rust: enable `clippy::ref_as_ptr` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-ptr-as-ptr-v8-6-3738061534ef@gmail.com>
References: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
In-Reply-To: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
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
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                 |  1 +
 rust/bindings/lib.rs     |  1 +
 rust/kernel/device_id.rs |  3 ++-
 rust/kernel/fs/file.rs   |  3 ++-
 rust/kernel/str.rs       |  6 ++++--
 rust/kernel/uaccess.rs   | 10 ++++------
 rust/uapi/lib.rs         |  1 +
 7 files changed, 15 insertions(+), 10 deletions(-)

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
index 791f493ada10..559a4bfa123f 100644
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
index 40034f77fc2f..75b4a18c67c4 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -28,8 +28,9 @@ pub const fn is_empty(&self) -> bool {
     /// Creates a [`BStr`] from a `[u8]`.
     #[inline]
     pub const fn from_bytes(bytes: &[u8]) -> &Self {
+        let bytes: *const [u8] = bytes;
         // SAFETY: `BStr` is transparent to `[u8]`.
-        unsafe { &*(bytes as *const [u8] as *const BStr) }
+        unsafe { &*(bytes as *const BStr) }
     }
 
     /// Strip a prefix from `self`. Delegates to [`slice::strip_prefix`].
@@ -289,8 +290,9 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
     /// `NUL` byte (or the string will be truncated).
     #[inline]
     pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
+        let bytes: *mut [u8] = bytes;
         // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
-        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
+        unsafe { &mut *(bytes as *mut CStr) }
     }
 
     /// Returns a C pointer to the string.
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 80a9782b1c6e..7a6fc78fc314 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -240,9 +240,10 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
     /// Fails with [`EFAULT`] if the read happens on a bad address, or if the read goes out of
     /// bounds of this [`UserSliceReader`]. This call may modify `out` even if it returns an error.
     pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
+        let out: *mut [u8] = out;
         // SAFETY: The types are compatible and `read_raw` doesn't write uninitialized bytes to
         // `out`.
-        let out = unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<u8>]) };
+        let out = unsafe { &mut *(out as *mut [MaybeUninit<u8>]) };
         self.read_raw(out)
     }
 
@@ -348,6 +349,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         if len > self.length {
             return Err(EFAULT);
         }
+        let value: *const T = value;
         // SAFETY: The reference points to a value of type `T`, so it is valid for reading
         // `size_of::<T>()` bytes.
         //
@@ -355,11 +357,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         // kernel pointer. This mirrors the logic on the C side that skips the check when the length
         // is a compile-time constant.
         let res = unsafe {
-            bindings::_copy_to_user(
-                self.ptr as *mut c_void,
-                (value as *const T).cast::<c_void>(),
-                len,
-            )
+            bindings::_copy_to_user(self.ptr as *mut c_void, value.cast::<c_void>(), len)
         };
         if res != 0 {
             return Err(EFAULT);
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


