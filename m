Return-Path: <linux-kselftest+bounces-13711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86254930AAB
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jul 2024 18:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58D71F2139E
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jul 2024 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5C13A3E3;
	Sun, 14 Jul 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK9RIOBu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E332171BB;
	Sun, 14 Jul 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720972968; cv=none; b=DIqvfvqm6ACzUlicy5sabQ55sO9O1Fp4oeLZjZMphhX92knio7git5gIKkEi7Nk9q7IIQZGIb/WH+hLaHMYxkfBwu32tuHNUL7OSHOrfE2Qa56u504qNWqPAu9jGiwZ0JtfUUijKfuoRlEh+54loBtp+jZ3lrCXboWrEt34eJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720972968; c=relaxed/simple;
	bh=JK5CLW/aIZ84XUM/4CQx9DwLVq4SKC7xt14Rv+O7IY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UCJo3o6KwIWlNw/rKi3s+CB6YbWZSH0SYekKd6lTK+0Db4U5FOEiTb2EnV4zSbCeNULu5j/Cl+EjeJnn3qOsI/jy23d8p9Gx4qjC/Po0z/6uBCScTy7w2iaUnkEeJaUvNvDMYMOFoZBEVOpH9kdQ0TK+UWpvEtf/Z2m8fW8+WTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK9RIOBu; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3dab349467dso762794b6e.1;
        Sun, 14 Jul 2024 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720972965; x=1721577765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QC04o2Oc39KDZ+EJDTk3+OtuWSzsHOXwGAlbi4rw6ck=;
        b=iK9RIOBuhsFcoe1ftLsFjH3d8oGwzIMeWl8yz0d9in+k8whYQVUwAIik4Aq32bg9M6
         rcgoo/dg8jRWgN/Bl6qu8bdhtaGxsfXtRTB7oBOsbV28VrgzTHpc+7O2i8aJ1Q5Fp49Q
         6N/pDT0AzwlQ8jwOrC3SzpmSgrqlRJrsEQmaLRjdq7PKNc0YqyR2dpCbLAvAOGBKN2nk
         1FZHSjQkUhcJteT2FBmzXRo6L1cYPq/iBjs3bfRNKx60vH7mf2wvHcHHHhIR2JbEJyBn
         VMSjo6OVlXCBx/YWklUZtbkYOC1sanYozcW2BNgj24HP563OOhUSMVaCMTUAbv+pdw9/
         8rUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720972965; x=1721577765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QC04o2Oc39KDZ+EJDTk3+OtuWSzsHOXwGAlbi4rw6ck=;
        b=kx7/DOm6cGtXnOnE4tD3ATqEcEZKQ0fzf1Rw5+Dx7sBFOfrJKCYlsikPOIu3dOQzAi
         NwtFZTCNsUMZn/0WOZ7AtIuoS11H36hB716ptj3eWH80sIE/7VXR77ai76RojBGtGRLe
         P+2FuDDxmYYEYpv9ke5vTUXMXpF3Y6jTjsGKAplaLajPoo6RwdVGvMu5qGLjImt+dOXt
         ifAKH7MrHe8W+SGT9nPpKpkFUygFafXvHC5O+h/4HCxmDwMJxrbTQM4k06RGvRG0rHQ2
         dPkmNgheVs3vTnENjEVARwhC6pTXWCbjn85xY/2l1EWRp87BW6ndjyiRB3hkiozgEnFN
         Rt+g==
X-Forwarded-Encrypted: i=1; AJvYcCX4VCAMv3KC/Hsl/ktoYOBa6h+aZ+i/NOtQkb9pkmmMpH+ZUkVqiBnltrqUOOGZol6mhkOlzRtFHzHqFgwoDoTBNXeV30IEGLTtFyHxXcGoMdH9W1a44TZEyPUMYk86DoeSMYCHuuh7KixGsC8y+UTn/8R4ydonGrOdGLKcBiRtc9W0rwRrHOmW5luBZaXyqq4oS+FwrS2Zou+hlBKPUi9KPjnY3lo=
X-Gm-Message-State: AOJu0YyHkxcaPaHc1qeIRpnYO1U5+gYC1HSRFIvSAot32rE9T/nHeqp/
	U8AaX/2c5hgPJwkfC24gq8fMNL8HJOszN89alT1fmhcyiWq9GGe0
X-Google-Smtp-Source: AGHT+IHJs/7FdElGIO/Zgf0ElR99qNvty5EJddX01vOD2HNkiMp/pAeUblyMUM+sL6Xzrs51bo4ndA==
X-Received: by 2002:a05:6808:118c:b0:3d5:5d4c:d15a with SMTP id 5614622812f47-3d93c0bf841mr14989295b6e.55.1720972964277;
        Sun, 14 Jul 2024 09:02:44 -0700 (PDT)
Received: from vadorovsky-macbookpro.. ([207.35.255.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7619789aesm14010566d6.33.2024.07.14.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 09:02:43 -0700 (PDT)
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
	Laine Taffin Altman <alexanderaltman@me.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Yutaro Ohno <yutaro.ono.418@gmail.com>,
	Tiago Lam <tiagolam@gmail.com>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	Ben Gooding <ben.gooding.dev@gmail.com>,
	Roland Xu <mu001999@outlook.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] rust: str: Use `core::CStr`, remove the custom `CStr` implementation
Date: Sun, 14 Jul 2024 18:02:19 +0200
Message-ID: <20240714160238.238708-1-vadorovsky@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`CStr` became a part of `core` library in Rust 1.75, therefore there is
no need to keep the custom implementation.

`core::CStr` behaves generally the same as the removed implementation,
with the following differences:

- It does not implement `Display` (but implements `Debug`).
- It does not provide `from_bytes_with_nul_unchecked_mut` method.
  - It was used only in `DerefMut` implementation for `CString`. This
    change replaces it with a manual cast to `&mut CStr`.
  - Otherwise, having such a method is not really desirable. `CStr` is
    a reference type
    or `str` are usually not supposed to be modified.
- It has `as_ptr()` method instead of `as_char_ptr()`, which also returns
  `*const c_char`.

Rust also introduces C literals (`c""`), so the `c_str` macro is removed
here as well.

Signed-off-by: Michal Rostecki <vadorovsky@gmail.com>
---
 rust/kernel/error.rs        |   7 +-
 rust/kernel/init.rs         |   8 +-
 rust/kernel/kunit.rs        |  16 +-
 rust/kernel/net/phy.rs      |   2 +-
 rust/kernel/prelude.rs      |   4 +-
 rust/kernel/str.rs          | 490 +-----------------------------------
 rust/kernel/sync.rs         |  13 +-
 rust/kernel/sync/condvar.rs |   5 +-
 rust/kernel/sync/lock.rs    |   6 +-
 rust/kernel/workqueue.rs    |  10 +-
 scripts/rustdoc_test_gen.rs |   4 +-
 11 files changed, 57 insertions(+), 508 deletions(-)

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
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 68605b633e73..af0017e56c0e 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -46,7 +46,7 @@
 //! }
 //!
 //! let foo = pin_init!(Foo {
-//!     a <- new_mutex!(42, "Foo::a"),
+//!     a <- new_mutex!(42, c"Foo::a"),
 //!     b: 24,
 //! });
 //! ```
@@ -65,7 +65,7 @@
 //! #     b: u32,
 //! # }
 //! # let foo = pin_init!(Foo {
-//! #     a <- new_mutex!(42, "Foo::a"),
+//! #     a <- new_mutex!(42, c"Foo::a"),
 //! #     b: 24,
 //! # });
 //! let foo: Result<Pin<Box<Foo>>> = Box::pin_init(foo, GFP_KERNEL);
@@ -81,7 +81,7 @@
 //! ```rust
 //! # use kernel::sync::{new_mutex, Arc, Mutex};
 //! let mtx: Result<Arc<Mutex<usize>>> =
-//!     Arc::pin_init(new_mutex!(42, "example::mtx"), GFP_KERNEL);
+//!     Arc::pin_init(new_mutex!(42, c"example::mtx"), GFP_KERNEL);
 //! ```
 //!
 //! To declare an init macro/function you just return an [`impl PinInit<T, E>`]:
@@ -99,7 +99,7 @@
 //! impl DriverData {
 //!     fn new() -> impl PinInit<Self, Error> {
 //!         try_pin_init!(Self {
-//!             status <- new_mutex!(0, "DriverData::status"),
+//!             status <- new_mutex!(0, c"DriverData::status"),
 //!             buffer: Box::init(kernel::init::zeroed(), GFP_KERNEL)?,
 //!         })
 //!     }
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 0ba77276ae7e..6da0d5e237b6 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -56,9 +56,13 @@ macro_rules! kunit_assert {
                 break 'out;
             }
 
-            static FILE: &'static $crate::str::CStr = $crate::c_str!($file);
+            static FILE: &'static core::ffi::CStr = $file;
             static LINE: i32 = core::line!() as i32 - $diff;
-            static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
+            static CONDITION: &'static core::ffi::CStr = unsafe {
+                core::ffi::CStr::from_bytes_with_nul_unchecked(
+                    core::concat!(stringify!($condition), "\0").as_bytes()
+                )
+            };
 
             // SAFETY: FFI call without safety requirements.
             let kunit_test = unsafe { $crate::bindings::kunit_get_current_test() };
@@ -71,11 +75,11 @@ macro_rules! kunit_assert {
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
@@ -98,12 +102,12 @@ unsafe impl Sync for Location {}
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
index bb8d4f41475b..d1e6335a02a3 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -4,8 +4,9 @@
 
 use crate::alloc::{flags::*, vec_ext::VecExt, AllocError};
 use alloc::vec::Vec;
+use core::ffi::CStr;
 use core::fmt::{self, Write};
-use core::ops::{self, Deref, DerefMut, Index};
+use core::ops::{Deref, DerefMut};
 
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
@@ -128,477 +129,11 @@ macro_rules! b_str {
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
-/// Creates a new [`CStr`] from a string literal.
-///
-/// The string literal should not contain any `NUL` bytes.
-///
-/// # Examples
-///
-/// ```
-/// # use kernel::c_str;
-/// # use kernel::str::CStr;
-/// const MY_CSTR: &CStr = c_str!("My awesome CStr!");
-/// ```
-#[macro_export]
-macro_rules! c_str {
-    ($str:expr) => {{
-        const S: &str = concat!($str, "\0");
-        const C: &$crate::str::CStr = match $crate::str::CStr::from_bytes_with_nul(S.as_bytes()) {
-            Ok(v) => v,
-            Err(_) => panic!("string contains interior NUL"),
-        };
-        C
-    }};
-}
-
 #[cfg(test)]
 mod tests {
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
@@ -779,11 +314,11 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
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
@@ -840,9 +375,10 @@ fn deref(&self) -> &Self::Target {
 
 impl DerefMut for CString {
     fn deref_mut(&mut self) -> &mut Self::Target {
-        // SAFETY: A `CString` is always NUL-terminated and contains no other
-        // NUL bytes.
-        unsafe { CStr::from_bytes_with_nul_unchecked_mut(self.buf.as_mut_slice()) }
+        debug_assert!(!self.buf.is_empty() && self.buf[self.buf.len() - 1] == 0);
+        // SAFETY: Casting to CStr is safe because its internal representation
+        // is a [u8] too.
+        unsafe { &mut *(self.buf.as_mut_slice() as *mut [u8] as *mut CStr) }
     }
 }
 
@@ -852,7 +388,7 @@ impl<'a> TryFrom<&'a CStr> for CString {
     fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
         let mut buf = Vec::new();
 
-        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)
+        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.to_bytes_with_nul(), GFP_KERNEL)
             .map_err(|_| AllocError)?;
 
         // INVARIANT: The `CStr` and `CString` types have the same invariants for
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..f909e7bb2070 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -59,9 +59,18 @@ macro_rules! static_lock_class {
 #[macro_export]
 macro_rules! optional_name {
     () => {
-        $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::line!()))
+        unsafe {
+            CStr::from_bytes_with_nul_unchecked(
+                ::core::concat!(
+                    ::core::file!(),
+                    ":",
+                    ::core::line!(),
+                    "\0"
+                ).as_bytes()
+            )
+        }
     };
     ($name:literal) => {
-        $crate::c_str!($name)
+        $name
     };
 }
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
index 553a5cba2adc..b1f5c4b5840c 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -51,7 +51,7 @@
 //!     fn new(value: i32) -> Result<Arc<Self>> {
 //!         Arc::pin_init(pin_init!(MyStruct {
 //!             value,
-//!             work <- new_work!("MyStruct::work"),
+//!             work <- new_work!(c"MyStruct::work"),
 //!         }), GFP_KERNEL)
 //!     }
 //! }
@@ -97,8 +97,8 @@
 //!         Arc::pin_init(pin_init!(MyStruct {
 //!             value_1,
 //!             value_2,
-//!             work_1 <- new_work!("MyStruct::work_1"),
-//!             work_2 <- new_work!("MyStruct::work_2"),
+//!             work_1 <- new_work!(c"MyStruct::work_1"),
+//!             work_2 <- new_work!(c"MyStruct::work_2"),
 //!         }), GFP_KERNEL)
 //!     }
 //! }
@@ -212,7 +212,7 @@ pub fn try_spawn<T: 'static + Send + FnOnce()>(
         func: T,
     ) -> Result<(), AllocError> {
         let init = pin_init!(ClosureWork {
-            work <- new_work!("Queue::try_spawn"),
+            work <- new_work!(c"Queue::try_spawn"),
             func: Some(func),
         });
 
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


