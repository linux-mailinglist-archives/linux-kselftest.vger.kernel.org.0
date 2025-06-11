Return-Path: <linux-kselftest+bounces-34676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8CCAD51B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3FF17F9D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174826A0AB;
	Wed, 11 Jun 2025 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeGV9yVk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F72609C6;
	Wed, 11 Jun 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637433; cv=none; b=VjZbOmky3DVXxlNWhzhX13gwG5R/3ecn3NCFqZc+6T/EMkVV4WYbGJuQtq3coJuMaUpc3JY7TaVCUV4oYyH+Jq5Sppw7HeWxNrgZ4Okzsmp+Vvo1hWYW+CJdmy8dVYvKR2NMCRZhnu2FMTD2KAY5/I+sw2TMeXRR31duEqujePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637433; c=relaxed/simple;
	bh=zE7akQ9I/itqlcJaWHyvSN6SxMbWvWntxwwUGa4zOrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RoBh4Xo/4k1n6vw/r5CfhyPAbU7K0pcLqCQhojTufR3nYp5BLA+5UI1pnxtDRCpkoRHfzl14lCCMScWtGo/Z2KQUuAd4m/oNUYTBVzTnUjJRosdRFG7F2jGPA8dIkiAruPVv1hC8wMuenGfajL7roPYG1VT5FJNlIw8BWv8eBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeGV9yVk; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a58b120bedso83445991cf.2;
        Wed, 11 Jun 2025 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749637430; x=1750242230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2miWcRt7MptMpkkpbvEAaiGbbGDGe5gQtbWu3GJa1w=;
        b=SeGV9yVkAA88uERIY5vSDKF6APT18YweXGNQa1DafSZuP4NcXWHB6XLVG96KNaNzVg
         +HwqWWFqW2wiEMAjtkbzi4ULIcrdyfTJxLHFlzAJCKDbQRpj4VTXNhdYjYW4I6sCUx9G
         GSWAQqf1RhlR0P9cmji3CrFEIVvCcm35WSx7fFqiTR9fwjYp534muQmlivXjaykQ3D/p
         N0BW2ZJLX3QdOgYYs0yrUvcc18FgUtnyJZUWad9+19seCP0ag26jbKrddhfzDSspes6f
         g8ejm8AS4/vuDs5f5DLpjgIfY49+rgk3WcoVMG0QFn4Cp0FNI79PR2FpJzBaa5mw6Pvw
         KBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749637430; x=1750242230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2miWcRt7MptMpkkpbvEAaiGbbGDGe5gQtbWu3GJa1w=;
        b=rAn4K/jsLiIGbX9kvtonoB6XgeBgY4FmZMpjM3cLhZzRH5dVnbHH0Xg13+uhIg7r4j
         bSMofUYNiLNz6a8cPr5zopi/Cmwbw8HSflsszHhcA2V1LzkIaI212KkjmemTaOdwXXhl
         oKAIKq+ABzc4yBtwBxA7CZXk30liKOzs+7L5CMRgErAIKWuqwYyD9riBCynxhqYNARMO
         YSuEf5fjAu9+IaDaykzLKJTrr50oeLV0KuUTjxc3nM4nkzNSNF5u2Uz64nn93/s94rlo
         J+xvxy3t3X/PuCiLDEMBnL5rlZQNVmKOrUteMVa2MWJTeQEIWC+YR8nWy2U1eS+Xk6u2
         yXEw==
X-Forwarded-Encrypted: i=1; AJvYcCV13042mt5Lrd+2+pYJALLDX1Z7byNCuJUZK7ZWwiWtCKBv5sbMFz1GIYbQsbP/wfic7E0UccDl0dE8kDqUMyc=@vger.kernel.org, AJvYcCV43LfHFiZ4kLHD+nqDt7qGfDAyWrfagmJy5mb7JE3DS4xJGN4RJjHlpIEhScPcA3yrothsGqQ0Buet@vger.kernel.org, AJvYcCVI07HhEfJCtill7FlX1W8cF97bAYYATW18f1qPIkP6Gi5YAEj6OrAX6D+FOkTaQKpHoNVCpBNM@vger.kernel.org, AJvYcCVjXZgMSYiE1XvJnz0Zy0dmOKAlaojAcPQk4VhH9g1VypYjuqKJxvbA+NqVK+mavLjuIxYF4ikWnCUA@vger.kernel.org, AJvYcCWPDNYEUywWB8nZxN5Q2upF7wOjZRGdYWIy4oQZUcGinLc95i4IVuQETHw3nGRUGeIsWgDkK7ephAR2XU22@vger.kernel.org, AJvYcCXZE4mf4YbZv06BSoTqp0N4h6GOS9MOqKWJxVYxzp+y7Xv3CAHnWd6lbh8JLZGkUgHBIGWWwSEteOHY57PwbEBt@vger.kernel.org, AJvYcCXzMyGmJAQ1vzMzQUD2fycMIWyruo7uY+huaZm6cdYvfJjEZZPEAat/0eklT0cPq7VOWopfwQTpeOmqEyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwjv1ioY57pXMQb5ebMpk/3bWhXr/0YpxWW7uEb2sawjo1JHMX
	thvyhog5dGPj1ComY0dP0pAlvIdQV4l0rmLT8ISayOlxACJSwVfxxH/o
X-Gm-Gg: ASbGncu8VxblY+gvenqS5onW2GLT/cVxDqX05zlxrDiktw6hq7hzcDhfC345s5glylw
	nHQniFLLdYXOVZU5Xvr4bRTXbUvZlWnSVn3B0dOCtpNqEoYHTYC9NjJhyr/vDmtIayHN5DdfK1V
	YlRDeehjsZ5ftVY/0GlnEhgcstYy/bN4eSFoRJWMEwPoZCyt6LrgOrr4kiczHj36Qa+RjomyIkb
	geCrHeUkleVlZCW+lbS94FbbSK1wa9Nqle6oZnRM0m9KZiKMLygMTBkmaUm4V2Rp+besnxYmVZr
	34cnMqG+UXJm63p2WIrSUlNl2tw+AAYsaFT6iSKUGcwAewdm0GwfQ10D49RtO6leO7Y=
X-Google-Smtp-Source: AGHT+IF1XN3p+FQVDqgsmvti47aZkI6r5GH+zjxKG5ndYXkmsax9t4EzbKDR8hTM8xrA7++NbyrCMw==
X-Received: by 2002:a05:622a:4288:b0:494:7e91:eb4d with SMTP id d75a77b69052e-4a713c65d30mr41371881cf.51.1749637430010;
        Wed, 11 Jun 2025 03:23:50 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([204.93.149.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61114ff18sm85664341cf.6.2025.06.11.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:23:49 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 11 Jun 2025 06:23:30 -0400
Subject: [PATCH v11 6/6] rust: enable `clippy::ref_as_ptr` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ptr-as-ptr-v11-6-ce5b41c6e9c6@gmail.com>
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


