Return-Path: <linux-kselftest+bounces-13759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0DA931CF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 00:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5EDB2099E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 22:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C2813CA93;
	Mon, 15 Jul 2024 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WszfR+Zu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790667A13A;
	Mon, 15 Jul 2024 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721081008; cv=none; b=IgW63Qp9wJWQ7/JBu0uNZ2hTyE/HrK2snmyAXkrUGBZOVf6+HucxnW+he/mhFBArHWurUliD6V/S24EmAxyKUTuDk2OGa6CGiZjGTTObUTy1fw1EKYQtL9Wmey3Jm7/KIENrgB1hrSKmZCd3emLXklmsjPidxIxrxsMPsLCwVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721081008; c=relaxed/simple;
	bh=/Dvy4oE+Y8WIl3MAp+SvReyubXBjxUrXhquUtvCJAKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LCWuCVn3fNjXEqFXvvxlY8rx9MZox19Fn7UVE84NFiLAl+XEzIES4eGUONl62N1TrlX6l8mBkCZLJ89Ts/UQ4bDluEdH9IEJYEknXQWVpN+89P/gxoX2Ukp/spwIBFetycYjFXC4nl9RUb6sIY5JgK+nwahO4mUXmLUU2AxbHp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WszfR+Zu; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-6b5e0d881a1so43764156d6.1;
        Mon, 15 Jul 2024 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721081004; x=1721685804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rA+i02ojNphWYTbFc4Klz4RzPhtEfgz33S5RLXVLUSo=;
        b=WszfR+ZuMAt2/MsKvXeGxNOkmu7jF7yOSOjdedmyyrRGijmCgzjSdJPGZB8Mpb0vht
         BpZ2R0Tz8B5XDwW0JmtfTe/yVfYu5FF+KTDEAd+kcs5CPoYbmrw3eDcTuDDMdi2mq3Ij
         7JJZssJGmG7kiG3QuBnly86H0BeEwnHJ7SAgMGQeH8u4VcfZFXkKk7uRBCK8CMkkwSrJ
         B2N58pDhoWpscPDbOhffQ/NrWmRo9ysFTVtAft8DbN41NUkcAWX0bEgq9dZiFKlPkiJ2
         YMlExYoB9TytMjBOvuzZDmBo4lQJAdg38Jf2FbNSaExs2Dffl6iO0YkkTNmDXCn6qWxL
         eolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721081004; x=1721685804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rA+i02ojNphWYTbFc4Klz4RzPhtEfgz33S5RLXVLUSo=;
        b=IJWckpu9tNEceW777Oe7qVotOMtxswU0LHB70lRnzvi91Yo9JJHBJbfOQS5qiYx0r7
         hd8isnIRKVtJSTV0HxFU032G6QWAZ2vI0WSkKGj5ClTegTvnvPJvBi4Gwhh2B63Yp3QH
         o656g2LX6wndeZa3dhE6DIBQ3ZdfUYSB4+d1gAO1Slqd5/Wx3hFwhDxV0fDfDEZug0pW
         QcZS2ikin+so0x1d1e6AKhVxN1ka9BJTGcvmiz1hS+fR7FaUfoXLfU6ZmpJux9VSw5jl
         3pe3buguvjdxH5xxk4nasb9SL9j3v+8Gc0mEcD5oDP4hBp1Cp9EO6i1WuGgBr++mZ1tf
         Wqcg==
X-Forwarded-Encrypted: i=1; AJvYcCUHco2Zqcxb/317lp99A/Wdp5USL6qX2I5ITibSWI4PeHZnR8zsRCpJtFvt8MJXDW/DvLkcXSsCpS/ceD0jRHJOD2QmfmKohxVU8lUZeBfhbZ/a4qk4lP3cGXPvJj3xj32WTThjshbzQRTek/X7WMOWlhzllAjA6VIKbf7U7UJSYQZlwk5GOI+7V7+hkoeE5n/RTEkwgVwc9/RBm5oc4krxXS56xj4=
X-Gm-Message-State: AOJu0Yz8vWGeyTtG0oO85zMNRFXWQK/4kbbqbZyeVPcAdci4xuCvIkvu
	ODsDkLBmWqTPnaykpvR1jKeHN46G71kJihygIVFtzj2Qu9jYsZfp
X-Google-Smtp-Source: AGHT+IHAZkKtbRV6xgYkSDBHXku4RNgtMO2gaznfHqz60WvcBvo+PqaP04VyWr43KrU4wKeTR2vSwA==
X-Received: by 2002:a05:6214:29c1:b0:6b4:f979:1e03 with SMTP id 6a1803df08f44-6b7800d1fcfmr4570596d6.25.1721081003971;
        Mon, 15 Jul 2024 15:03:23 -0700 (PDT)
Received: from vadorovsky-macbookpro.fritz.box ([2607:fea8:fd50:8247::f272])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b76199f12asm25028446d6.62.2024.07.15.15.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 15:03:23 -0700 (PDT)
From: Michal Rostecki <vadorovsky@gmail.com>
To: 
Cc: Michal Rostecki <vadorovsky@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Finn Behrens <me@kloenk.dev>,
	Manmohan Shukla <manmshuk@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Asahi Lina <lina@asahilina.net>,
	Yutaro Ohno <yutaro.ono.418@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Tiago Lam <tiagolam@gmail.com>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	Ben Gooding <ben.gooding.dev@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roland Xu <mu001999@outlook.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] rust: str: Use `core::CStr`, remove the custom `CStr` implementation
Date: Mon, 15 Jul 2024 23:49:44 +0200
Message-ID: <20240715214956.401687-2-vadorovsky@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`CStr` became a part of `core` library in Rust 1.75. This change replaces
the custom `CStr` implementation with the one from `core`.
no need to keep the custom implementation.

`core::CStr` behaves generally the same as the removed implementation,
with the following differences:

- It does not implement `Display` (but implements `Debug`). Therefore,
  by switching to `core::CStr`, we lose the `Display` implementation.
  - Lack of `Display` implementation impacted only rust/kernel/kunit.rs.
    In this change, we use `Debug` format there. The only difference
    between the removed `Display` output and `Debug` output are quotation
    marks present in the latter (`foo` vs `"foo"`).
- It does not provide `from_bytes_with_nul_unchecked_mut` method.
  - It was used only in `DerefMut` implementation for `CString`. This
    change removes that implementation.
  - Otherwise, having such a method is not desirable. The rule in Rust
    std is that `str` is used only as an immutable reference (`&str`),
    while mutating strings is done with the owned `String` type.
    Similarly, we can introduce the rule that `CStr` should be used only
    as an immutable reference (`&CStr`), while mutating is done only with
    the owned `CString` type.
- It has `as_ptr()` method instead of `as_char_ptr()`, which also returns
  `*const c_char`.

Signed-off-by: Michal Rostecki <vadorovsky@gmail.com>
---
v1 -> v2:
- Do not remove `c_str` macro. While it's preferred to use C-string
  literals, there are two cases where `c_str` is helpful:
  - When working with macros, which already return a Rust string literal
    (e.g. `stringify!`).
  - When building macros, where we want to take a Rust string literal as an
    argument (for caller's convenience), but still use it as a C-string
    internally.
- Use Rust literals as arguments in macros (`new_mutex`, `new_condvar`,
  `new_mutex`). Use the `c_str` macro to convert these literals to C-string
  literals.
- Use `c_str` in kunit.rs for converting the output of `stringify!` to a
  `CStr`.
- Remove `DerefMut` implementation for `CString`.

 rust/kernel/error.rs        |   7 +-
 rust/kernel/kunit.rs        |  12 +-
 rust/kernel/net/phy.rs      |   2 +-
 rust/kernel/prelude.rs      |   4 +-
 rust/kernel/str.rs          | 486 ++----------------------------------
 rust/kernel/sync/condvar.rs |   5 +-
 rust/kernel/sync/lock.rs    |   6 +-
 rust/kernel/workqueue.rs    |   2 +-
 scripts/rustdoc_test_gen.rs |   4 +-
 9 files changed, 44 insertions(+), 484 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 55280ae9fe40..18808b29604d 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -4,10 +4,11 @@
 //!
 //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
 
-use crate::{alloc::AllocError, str::CStr};
+use crate::alloc::AllocError;
 
 use alloc::alloc::LayoutError;
 
+use core::ffi::CStr;
 use core::fmt;
 use core::num::TryFromIntError;
 use core::str::Utf8Error;
@@ -142,7 +143,7 @@ pub fn name(&self) -> Option<&'static CStr> {
             None
         } else {
             // SAFETY: The string returned by `errname` is static and `NUL`-terminated.
-            Some(unsafe { CStr::from_char_ptr(ptr) })
+            Some(unsafe { CStr::from_ptr(ptr) })
         }
     }
 
@@ -164,7 +165,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
             None => f.debug_tuple("Error").field(&-self.0).finish(),
             // SAFETY: These strings are ASCII-only.
             Some(name) => f
-                .debug_tuple(unsafe { core::str::from_utf8_unchecked(name) })
+                .debug_tuple(unsafe { core::str::from_utf8_unchecked(name.to_bytes()) })
                 .finish(),
         }
     }
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 0ba77276ae7e..c08f9dddaa6f 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -56,9 +56,9 @@ macro_rules! kunit_assert {
                 break 'out;
             }
 
-            static FILE: &'static $crate::str::CStr = $crate::c_str!($file);
+            static FILE: &'static core::ffi::CStr = $file;
             static LINE: i32 = core::line!() as i32 - $diff;
-            static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
+            static CONDITION: &'static core::ffi::CStr = $crate::c_str!(stringify!($condition));
 
             // SAFETY: FFI call without safety requirements.
             let kunit_test = unsafe { $crate::bindings::kunit_get_current_test() };
@@ -71,11 +71,11 @@ macro_rules! kunit_assert {
                 //
                 // This mimics KUnit's failed assertion format.
                 $crate::kunit::err(format_args!(
-                    "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
+                    "    # {:?}: ASSERTION FAILED at {FILE:?}:{LINE:?}\n",
                     $name
                 ));
                 $crate::kunit::err(format_args!(
-                    "    Expected {CONDITION} to be true, but is false\n"
+                    "    Expected {CONDITION:?} to be true, but is false\n"
                 ));
                 $crate::kunit::err(format_args!(
                     "    Failure not reported to KUnit since this is a non-KUnit task\n"
@@ -98,12 +98,12 @@ unsafe impl Sync for Location {}
             unsafe impl Sync for UnaryAssert {}
 
             static LOCATION: Location = Location($crate::bindings::kunit_loc {
-                file: FILE.as_char_ptr(),
+                file: FILE.as_ptr(),
                 line: LINE,
             });
             static ASSERTION: UnaryAssert = UnaryAssert($crate::bindings::kunit_unary_assert {
                 assert: $crate::bindings::kunit_assert {},
-                condition: CONDITION.as_char_ptr(),
+                condition: CONDITION.as_ptr(),
                 expected_true: true,
             });
 
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index fd40b703d224..19f45922ec42 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -502,7 +502,7 @@ unsafe impl Sync for DriverVTable {}
 pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
     // INVARIANT: All the fields of `struct phy_driver` are initialized properly.
     DriverVTable(Opaque::new(bindings::phy_driver {
-        name: T::NAME.as_char_ptr().cast_mut(),
+        name: T::NAME.as_ptr().cast_mut(),
         flags: T::FLAGS,
         phy_id: T::PHY_DEVICE_ID.id,
         phy_id_mask: T::PHY_DEVICE_ID.mask_as_int(),
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index b37a0b3180fb..5efabfaa5804 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -12,7 +12,7 @@
 //! ```
 
 #[doc(no_inline)]
-pub use core::pin::Pin;
+pub use core::{ffi::CStr, pin::Pin};
 
 pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt};
 
@@ -35,7 +35,7 @@
 
 pub use super::error::{code::*, Error, Result};
 
-pub use super::{str::CStr, ThisModule};
+pub use super::{ThisModule};
 
 pub use super::init::{InPlaceInit, Init, PinInit};
 
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index bb8d4f41475b..e491a9803187 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -4,8 +4,9 @@
 
 use crate::alloc::{flags::*, vec_ext::VecExt, AllocError};
 use alloc::vec::Vec;
+use core::ffi::CStr;
 use core::fmt::{self, Write};
-use core::ops::{self, Deref, DerefMut, Index};
+use core::ops::Deref;
 
 use crate::error::{code::*, Error};
 
@@ -41,11 +42,11 @@ impl fmt::Display for BStr {
     /// # use kernel::{fmt, b_str, str::{BStr, CString}};
     /// let ascii = b_str!("Hello, BStr!");
     /// let s = CString::try_from_fmt(fmt!("{}", ascii)).unwrap();
-    /// assert_eq!(s.as_bytes(), "Hello, BStr!".as_bytes());
+    /// assert_eq!(s.to_bytes(), "Hello, BStr!".as_bytes());
     ///
     /// let non_ascii = b_str!("🦀");
     /// let s = CString::try_from_fmt(fmt!("{}", non_ascii)).unwrap();
-    /// assert_eq!(s.as_bytes(), "\\xf0\\x9f\\xa6\\x80".as_bytes());
+    /// assert_eq!(s.to_bytes(), "\\xf0\\x9f\\xa6\\x80".as_bytes());
     /// ```
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         for &b in &self.0 {
@@ -72,11 +73,11 @@ impl fmt::Debug for BStr {
     /// // Embedded double quotes are escaped.
     /// let ascii = b_str!("Hello, \"BStr\"!");
     /// let s = CString::try_from_fmt(fmt!("{:?}", ascii)).unwrap();
-    /// assert_eq!(s.as_bytes(), "\"Hello, \\\"BStr\\\"!\"".as_bytes());
+    /// assert_eq!(s.to_bytes(), "\"Hello, \\\"BStr\\\"!\"".as_bytes());
     ///
     /// let non_ascii = b_str!("😺");
     /// let s = CString::try_from_fmt(fmt!("{:?}", non_ascii)).unwrap();
-    /// assert_eq!(s.as_bytes(), "\"\\xf0\\x9f\\x98\\xba\"".as_bytes());
+    /// assert_eq!(s.to_bytes(), "\"\\xf0\\x9f\\x98\\xba\"".as_bytes());
     /// ```
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         f.write_char('"')?;
@@ -128,392 +129,32 @@ macro_rules! b_str {
     }};
 }
 
-/// Possible errors when using conversion functions in [`CStr`].
-#[derive(Debug, Clone, Copy)]
-pub enum CStrConvertError {
-    /// Supplied bytes contain an interior `NUL`.
-    InteriorNul,
-
-    /// Supplied bytes are not terminated by `NUL`.
-    NotNulTerminated,
-}
-
-impl From<CStrConvertError> for Error {
-    #[inline]
-    fn from(_: CStrConvertError) -> Error {
-        EINVAL
-    }
-}
-
-/// A string that is guaranteed to have exactly one `NUL` byte, which is at the
-/// end.
-///
-/// Used for interoperability with kernel APIs that take C strings.
-#[repr(transparent)]
-pub struct CStr([u8]);
-
-impl CStr {
-    /// Returns the length of this string excluding `NUL`.
-    #[inline]
-    pub const fn len(&self) -> usize {
-        self.len_with_nul() - 1
-    }
-
-    /// Returns the length of this string with `NUL`.
-    #[inline]
-    pub const fn len_with_nul(&self) -> usize {
-        // SAFETY: This is one of the invariant of `CStr`.
-        // We add a `unreachable_unchecked` here to hint the optimizer that
-        // the value returned from this function is non-zero.
-        if self.0.is_empty() {
-            unsafe { core::hint::unreachable_unchecked() };
-        }
-        self.0.len()
-    }
-
-    /// Returns `true` if the string only includes `NUL`.
-    #[inline]
-    pub const fn is_empty(&self) -> bool {
-        self.len() == 0
-    }
-
-    /// Wraps a raw C string pointer.
-    ///
-    /// # Safety
-    ///
-    /// `ptr` must be a valid pointer to a `NUL`-terminated C string, and it must
-    /// last at least `'a`. When `CStr` is alive, the memory pointed by `ptr`
-    /// must not be mutated.
-    #[inline]
-    pub unsafe fn from_char_ptr<'a>(ptr: *const core::ffi::c_char) -> &'a Self {
-        // SAFETY: The safety precondition guarantees `ptr` is a valid pointer
-        // to a `NUL`-terminated C string.
-        let len = unsafe { bindings::strlen(ptr) } + 1;
-        // SAFETY: Lifetime guaranteed by the safety precondition.
-        let bytes = unsafe { core::slice::from_raw_parts(ptr as _, len as _) };
-        // SAFETY: As `len` is returned by `strlen`, `bytes` does not contain interior `NUL`.
-        // As we have added 1 to `len`, the last byte is known to be `NUL`.
-        unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
-    }
-
-    /// Creates a [`CStr`] from a `[u8]`.
-    ///
-    /// The provided slice must be `NUL`-terminated, does not contain any
-    /// interior `NUL` bytes.
-    pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError> {
-        if bytes.is_empty() {
-            return Err(CStrConvertError::NotNulTerminated);
-        }
-        if bytes[bytes.len() - 1] != 0 {
-            return Err(CStrConvertError::NotNulTerminated);
-        }
-        let mut i = 0;
-        // `i + 1 < bytes.len()` allows LLVM to optimize away bounds checking,
-        // while it couldn't optimize away bounds checks for `i < bytes.len() - 1`.
-        while i + 1 < bytes.len() {
-            if bytes[i] == 0 {
-                return Err(CStrConvertError::InteriorNul);
-            }
-            i += 1;
-        }
-        // SAFETY: We just checked that all properties hold.
-        Ok(unsafe { Self::from_bytes_with_nul_unchecked(bytes) })
-    }
-
-    /// Creates a [`CStr`] from a `[u8]` without performing any additional
-    /// checks.
-    ///
-    /// # Safety
-    ///
-    /// `bytes` *must* end with a `NUL` byte, and should only have a single
-    /// `NUL` byte (or the string will be truncated).
-    #[inline]
-    pub const unsafe fn from_bytes_with_nul_unchecked(bytes: &[u8]) -> &CStr {
-        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
-        unsafe { core::mem::transmute(bytes) }
-    }
-
-    /// Creates a mutable [`CStr`] from a `[u8]` without performing any
-    /// additional checks.
-    ///
-    /// # Safety
-    ///
-    /// `bytes` *must* end with a `NUL` byte, and should only have a single
-    /// `NUL` byte (or the string will be truncated).
-    #[inline]
-    pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
-        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
-        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
-    }
-
-    /// Returns a C pointer to the string.
-    #[inline]
-    pub const fn as_char_ptr(&self) -> *const core::ffi::c_char {
-        self.0.as_ptr() as _
-    }
-
-    /// Convert the string to a byte slice without the trailing `NUL` byte.
-    #[inline]
-    pub fn as_bytes(&self) -> &[u8] {
-        &self.0[..self.len()]
-    }
-
-    /// Convert the string to a byte slice containing the trailing `NUL` byte.
-    #[inline]
-    pub const fn as_bytes_with_nul(&self) -> &[u8] {
-        &self.0
-    }
-
-    /// Yields a [`&str`] slice if the [`CStr`] contains valid UTF-8.
-    ///
-    /// If the contents of the [`CStr`] are valid UTF-8 data, this
-    /// function will return the corresponding [`&str`] slice. Otherwise,
-    /// it will return an error with details of where UTF-8 validation failed.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// # use kernel::str::CStr;
-    /// let cstr = CStr::from_bytes_with_nul(b"foo\0").unwrap();
-    /// assert_eq!(cstr.to_str(), Ok("foo"));
-    /// ```
-    #[inline]
-    pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
-        core::str::from_utf8(self.as_bytes())
-    }
-
-    /// Unsafely convert this [`CStr`] into a [`&str`], without checking for
-    /// valid UTF-8.
-    ///
-    /// # Safety
-    ///
-    /// The contents must be valid UTF-8.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// # use kernel::c_str;
-    /// # use kernel::str::CStr;
-    /// let bar = c_str!("ツ");
-    /// // SAFETY: String literals are guaranteed to be valid UTF-8
-    /// // by the Rust compiler.
-    /// assert_eq!(unsafe { bar.as_str_unchecked() }, "ツ");
-    /// ```
-    #[inline]
-    pub unsafe fn as_str_unchecked(&self) -> &str {
-        unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
-    }
-
-    /// Convert this [`CStr`] into a [`CString`] by allocating memory and
-    /// copying over the string data.
-    pub fn to_cstring(&self) -> Result<CString, AllocError> {
-        CString::try_from(self)
-    }
-
-    /// Converts this [`CStr`] to its ASCII lower case equivalent in-place.
-    ///
-    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
-    /// but non-ASCII letters are unchanged.
-    ///
-    /// To return a new lowercased value without modifying the existing one, use
-    /// [`to_ascii_lowercase()`].
-    ///
-    /// [`to_ascii_lowercase()`]: #method.to_ascii_lowercase
-    pub fn make_ascii_lowercase(&mut self) {
-        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
-        // string.
-        self.0.make_ascii_lowercase();
-    }
-
-    /// Converts this [`CStr`] to its ASCII upper case equivalent in-place.
-    ///
-    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
-    /// but non-ASCII letters are unchanged.
-    ///
-    /// To return a new uppercased value without modifying the existing one, use
-    /// [`to_ascii_uppercase()`].
-    ///
-    /// [`to_ascii_uppercase()`]: #method.to_ascii_uppercase
-    pub fn make_ascii_uppercase(&mut self) {
-        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
-        // string.
-        self.0.make_ascii_uppercase();
-    }
-
-    /// Returns a copy of this [`CString`] where each character is mapped to its
-    /// ASCII lower case equivalent.
-    ///
-    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
-    /// but non-ASCII letters are unchanged.
-    ///
-    /// To lowercase the value in-place, use [`make_ascii_lowercase`].
-    ///
-    /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
-    pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
-        let mut s = self.to_cstring()?;
-
-        s.make_ascii_lowercase();
-
-        Ok(s)
-    }
-
-    /// Returns a copy of this [`CString`] where each character is mapped to its
-    /// ASCII upper case equivalent.
-    ///
-    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
-    /// but non-ASCII letters are unchanged.
-    ///
-    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
-    ///
-    /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
-    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
-        let mut s = self.to_cstring()?;
-
-        s.make_ascii_uppercase();
-
-        Ok(s)
-    }
-}
-
-impl fmt::Display for CStr {
-    /// Formats printable ASCII characters, escaping the rest.
-    ///
-    /// ```
-    /// # use kernel::c_str;
-    /// # use kernel::fmt;
-    /// # use kernel::str::CStr;
-    /// # use kernel::str::CString;
-    /// let penguin = c_str!("🐧");
-    /// let s = CString::try_from_fmt(fmt!("{}", penguin)).unwrap();
-    /// assert_eq!(s.as_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
-    ///
-    /// let ascii = c_str!("so \"cool\"");
-    /// let s = CString::try_from_fmt(fmt!("{}", ascii)).unwrap();
-    /// assert_eq!(s.as_bytes_with_nul(), "so \"cool\"\0".as_bytes());
-    /// ```
-    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        for &c in self.as_bytes() {
-            if (0x20..0x7f).contains(&c) {
-                // Printable character.
-                f.write_char(c as char)?;
-            } else {
-                write!(f, "\\x{:02x}", c)?;
-            }
-        }
-        Ok(())
-    }
-}
-
-impl fmt::Debug for CStr {
-    /// Formats printable ASCII characters with a double quote on either end, escaping the rest.
-    ///
-    /// ```
-    /// # use kernel::c_str;
-    /// # use kernel::fmt;
-    /// # use kernel::str::CStr;
-    /// # use kernel::str::CString;
-    /// let penguin = c_str!("🐧");
-    /// let s = CString::try_from_fmt(fmt!("{:?}", penguin)).unwrap();
-    /// assert_eq!(s.as_bytes_with_nul(), "\"\\xf0\\x9f\\x90\\xa7\"\0".as_bytes());
-    ///
-    /// // Embedded double quotes are escaped.
-    /// let ascii = c_str!("so \"cool\"");
-    /// let s = CString::try_from_fmt(fmt!("{:?}", ascii)).unwrap();
-    /// assert_eq!(s.as_bytes_with_nul(), "\"so \\\"cool\\\"\"\0".as_bytes());
-    /// ```
-    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        f.write_str("\"")?;
-        for &c in self.as_bytes() {
-            match c {
-                // Printable characters.
-                b'\"' => f.write_str("\\\"")?,
-                0x20..=0x7e => f.write_char(c as char)?,
-                _ => write!(f, "\\x{:02x}", c)?,
-            }
-        }
-        f.write_str("\"")
-    }
-}
-
-impl AsRef<BStr> for CStr {
-    #[inline]
-    fn as_ref(&self) -> &BStr {
-        BStr::from_bytes(self.as_bytes())
-    }
-}
-
-impl Deref for CStr {
-    type Target = BStr;
-
-    #[inline]
-    fn deref(&self) -> &Self::Target {
-        self.as_ref()
-    }
-}
-
-impl Index<ops::RangeFrom<usize>> for CStr {
-    type Output = CStr;
-
-    #[inline]
-    fn index(&self, index: ops::RangeFrom<usize>) -> &Self::Output {
-        // Delegate bounds checking to slice.
-        // Assign to _ to mute clippy's unnecessary operation warning.
-        let _ = &self.as_bytes()[index.start..];
-        // SAFETY: We just checked the bounds.
-        unsafe { Self::from_bytes_with_nul_unchecked(&self.0[index.start..]) }
-    }
-}
-
-impl Index<ops::RangeFull> for CStr {
-    type Output = CStr;
-
-    #[inline]
-    fn index(&self, _index: ops::RangeFull) -> &Self::Output {
-        self
-    }
-}
-
-mod private {
-    use core::ops;
-
-    // Marker trait for index types that can be forward to `BStr`.
-    pub trait CStrIndex {}
-
-    impl CStrIndex for usize {}
-    impl CStrIndex for ops::Range<usize> {}
-    impl CStrIndex for ops::RangeInclusive<usize> {}
-    impl CStrIndex for ops::RangeToInclusive<usize> {}
-}
-
-impl<Idx> Index<Idx> for CStr
-where
-    Idx: private::CStrIndex,
-    BStr: Index<Idx>,
-{
-    type Output = <BStr as Index<Idx>>::Output;
-
-    #[inline]
-    fn index(&self, index: Idx) -> &Self::Output {
-        &self.as_ref()[index]
-    }
-}
-
 /// Creates a new [`CStr`] from a string literal.
 ///
-/// The string literal should not contain any `NUL` bytes.
+/// Usually, defining C-string literals directly should be preffered, but this
+/// macro is helpful in situations when C-string literals are hard or
+/// impossible to use, for example:
+///
+/// - When working with macros, which already return a Rust string literal
+///   (e.g. `stringify!`).
+/// - When building macros, where we want to take a Rust string literal as an
+///   argument (for caller's convenience), but still use it as a C-string
+///   internally.
+///
+/// The string should not contain any `NUL` bytes.
 ///
 /// # Examples
 ///
 /// ```
+/// # use core::ffi::CStr;
 /// # use kernel::c_str;
-/// # use kernel::str::CStr;
-/// const MY_CSTR: &CStr = c_str!("My awesome CStr!");
+/// const MY_CSTR: &CStr = c_str!(stringify!(5));
 /// ```
 #[macro_export]
 macro_rules! c_str {
     ($str:expr) => {{
         const S: &str = concat!($str, "\0");
-        const C: &$crate::str::CStr = match $crate::str::CStr::from_bytes_with_nul(S.as_bytes()) {
+        const C: &core::ffi::CStr = match core::ffi::CStr::from_bytes_with_nul(S.as_bytes()) {
             Ok(v) => v,
             Err(_) => panic!("string contains interior NUL"),
         };
@@ -526,79 +167,6 @@ mod tests {
     use super::*;
     use alloc::format;
 
-    const ALL_ASCII_CHARS: &'static str =
-        "\\x01\\x02\\x03\\x04\\x05\\x06\\x07\\x08\\x09\\x0a\\x0b\\x0c\\x0d\\x0e\\x0f\
-        \\x10\\x11\\x12\\x13\\x14\\x15\\x16\\x17\\x18\\x19\\x1a\\x1b\\x1c\\x1d\\x1e\\x1f \
-        !\"#$%&'()*+,-./0123456789:;<=>?@\
-        ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\\x7f\
-        \\x80\\x81\\x82\\x83\\x84\\x85\\x86\\x87\\x88\\x89\\x8a\\x8b\\x8c\\x8d\\x8e\\x8f\
-        \\x90\\x91\\x92\\x93\\x94\\x95\\x96\\x97\\x98\\x99\\x9a\\x9b\\x9c\\x9d\\x9e\\x9f\
-        \\xa0\\xa1\\xa2\\xa3\\xa4\\xa5\\xa6\\xa7\\xa8\\xa9\\xaa\\xab\\xac\\xad\\xae\\xaf\
-        \\xb0\\xb1\\xb2\\xb3\\xb4\\xb5\\xb6\\xb7\\xb8\\xb9\\xba\\xbb\\xbc\\xbd\\xbe\\xbf\
-        \\xc0\\xc1\\xc2\\xc3\\xc4\\xc5\\xc6\\xc7\\xc8\\xc9\\xca\\xcb\\xcc\\xcd\\xce\\xcf\
-        \\xd0\\xd1\\xd2\\xd3\\xd4\\xd5\\xd6\\xd7\\xd8\\xd9\\xda\\xdb\\xdc\\xdd\\xde\\xdf\
-        \\xe0\\xe1\\xe2\\xe3\\xe4\\xe5\\xe6\\xe7\\xe8\\xe9\\xea\\xeb\\xec\\xed\\xee\\xef\
-        \\xf0\\xf1\\xf2\\xf3\\xf4\\xf5\\xf6\\xf7\\xf8\\xf9\\xfa\\xfb\\xfc\\xfd\\xfe\\xff";
-
-    #[test]
-    fn test_cstr_to_str() {
-        let good_bytes = b"\xf0\x9f\xa6\x80\0";
-        let checked_cstr = CStr::from_bytes_with_nul(good_bytes).unwrap();
-        let checked_str = checked_cstr.to_str().unwrap();
-        assert_eq!(checked_str, "🦀");
-    }
-
-    #[test]
-    #[should_panic]
-    fn test_cstr_to_str_panic() {
-        let bad_bytes = b"\xc3\x28\0";
-        let checked_cstr = CStr::from_bytes_with_nul(bad_bytes).unwrap();
-        checked_cstr.to_str().unwrap();
-    }
-
-    #[test]
-    fn test_cstr_as_str_unchecked() {
-        let good_bytes = b"\xf0\x9f\x90\xA7\0";
-        let checked_cstr = CStr::from_bytes_with_nul(good_bytes).unwrap();
-        let unchecked_str = unsafe { checked_cstr.as_str_unchecked() };
-        assert_eq!(unchecked_str, "🐧");
-    }
-
-    #[test]
-    fn test_cstr_display() {
-        let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
-        assert_eq!(format!("{}", hello_world), "hello, world!");
-        let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0").unwrap();
-        assert_eq!(format!("{}", non_printables), "\\x01\\x09\\x0a");
-        let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").unwrap();
-        assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
-        let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0").unwrap();
-        assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
-    }
-
-    #[test]
-    fn test_cstr_display_all_bytes() {
-        let mut bytes: [u8; 256] = [0; 256];
-        // fill `bytes` with [1..=255] + [0]
-        for i in u8::MIN..=u8::MAX {
-            bytes[i as usize] = i.wrapping_add(1);
-        }
-        let cstr = CStr::from_bytes_with_nul(&bytes).unwrap();
-        assert_eq!(format!("{}", cstr), ALL_ASCII_CHARS);
-    }
-
-    #[test]
-    fn test_cstr_debug() {
-        let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
-        assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
-        let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0").unwrap();
-        assert_eq!(format!("{:?}", non_printables), "\"\\x01\\x09\\x0a\"");
-        let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").unwrap();
-        assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
-        let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0").unwrap();
-        assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\"");
-    }
-
     #[test]
     fn test_bstr_display() {
         let hello_world = BStr::from_bytes(b"hello, world!");
@@ -779,11 +347,11 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// use kernel::{str::CString, fmt};
 ///
 /// let s = CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20)).unwrap();
-/// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
+/// assert_eq!(s.to_bytes_with_nul(), "abc1020\0".as_bytes());
 ///
 /// let tmp = "testing";
 /// let s = CString::try_from_fmt(fmt!("{tmp}{}", 123)).unwrap();
-/// assert_eq!(s.as_bytes_with_nul(), "testing123\0".as_bytes());
+/// assert_eq!(s.to_bytes_with_nul(), "testing123\0".as_bytes());
 ///
 /// // This fails because it has an embedded `NUL` byte.
 /// let s = CString::try_from_fmt(fmt!("a\0b{}", 123));
@@ -838,21 +406,13 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl DerefMut for CString {
-    fn deref_mut(&mut self) -> &mut Self::Target {
-        // SAFETY: A `CString` is always NUL-terminated and contains no other
-        // NUL bytes.
-        unsafe { CStr::from_bytes_with_nul_unchecked_mut(self.buf.as_mut_slice()) }
-    }
-}
-
 impl<'a> TryFrom<&'a CStr> for CString {
     type Error = AllocError;
 
     fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
         let mut buf = Vec::new();
 
-        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)
+        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.to_bytes_with_nul(), GFP_KERNEL)
             .map_err(|_| AllocError)?;
 
         // INVARIANT: The `CStr` and `CString` types have the same invariants for
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 2b306afbe56d..16d1a1cb8d00 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -9,12 +9,11 @@
 use crate::{
     init::PinInit,
     pin_init,
-    str::CStr,
     task::{MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE},
     time::Jiffies,
     types::Opaque,
 };
-use core::ffi::{c_int, c_long};
+use core::ffi::{c_int, c_long, CStr};
 use core::marker::PhantomPinned;
 use core::ptr;
 use macros::pin_data;
@@ -108,7 +107,7 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
             // static lifetimes so they live indefinitely.
             wait_queue_head <- Opaque::ffi_init(|slot| unsafe {
-                bindings::__init_waitqueue_head(slot, name.as_char_ptr(), key.as_ptr())
+                bindings::__init_waitqueue_head(slot, name.as_ptr(), key.as_ptr())
             }),
         })
     }
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..318ecb5a5916 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,8 +6,8 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
 
 use super::LockClassKey;
-use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use crate::{init::PinInit, pin_init, types::Opaque, types::ScopeGuard};
+use core::{cell::UnsafeCell, ffi::CStr, marker::PhantomData, marker::PhantomPinned};
 use macros::pin_data;
 
 pub mod mutex;
@@ -113,7 +113,7 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
             // static lifetimes so they live indefinitely.
             state <- Opaque::ffi_init(|slot| unsafe {
-                B::init(slot, name.as_char_ptr(), key.as_ptr())
+                B::init(slot, name.as_ptr(), key.as_ptr())
             }),
         })
     }
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 553a5cba2adc..a6418873e82e 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -380,7 +380,7 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
                         slot,
                         Some(T::Pointer::run),
                         false,
-                        name.as_char_ptr(),
+                        name.as_ptr(),
                         key.as_ptr(),
                     )
                 }
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 5ebd42ae4a3f..339991ee6885 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -172,7 +172,7 @@ pub extern "C" fn {kunit_name}(__kunit_test: *mut kernel::bindings::kunit) {{
     #[allow(unused)]
     macro_rules! assert {{
         ($cond:expr $(,)?) => {{{{
-            kernel::kunit_assert!("{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $cond);
+            kernel::kunit_assert!(c"{kunit_name}", c"{real_path}", __DOCTEST_ANCHOR - {line}, $cond);
         }}}}
     }}
 
@@ -180,7 +180,7 @@ macro_rules! assert {{
     #[allow(unused)]
     macro_rules! assert_eq {{
         ($left:expr, $right:expr $(,)?) => {{{{
-            kernel::kunit_assert_eq!("{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right);
+            kernel::kunit_assert_eq!(c"{kunit_name}", c"{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right);
         }}}}
     }}
 
-- 
2.45.2


