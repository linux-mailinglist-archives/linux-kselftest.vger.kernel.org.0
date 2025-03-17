Return-Path: <linux-kselftest+bounces-29235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9258A655A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 16:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C731897A13
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD1C24A04A;
	Mon, 17 Mar 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp/aNoCi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081A82459DB;
	Mon, 17 Mar 2025 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225420; cv=none; b=FlSPvyZji2lfjRj962dX69w+TX1W2HxA+fiWV3itEldgw9LwF2qN0xshlXFKcm0P5i17nHpZ610k0o7zKnb4Gh31Mv9OXU7Crw7W0nEOzaVqTUhvZfMr9nO9tSS8H5e9N3aTjpJOdEElE9BDtA90bbVNsGi5qaLm9s1a3sh7tzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225420; c=relaxed/simple;
	bh=1rkakKUwb36yHAuv3YCt5lG31RMltr4Nsg5Cun6at7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dt71GJf53Q6mIWfhJ3YF7JJ6/AkQ09HTf49xMF148OX4x7DY/z0qicIHAE24RfjcPKlHdFO1t2uvqNPa1DQ4eYQVeY1LrtMFYoKSMNJv2Ml05u9NOYwd2046fHRRm+HsIGRkoK1WqTzTKjH5lsBzYJGGYCMu9NMP7AmGOvnATJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp/aNoCi; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f6970326so40459546d6.0;
        Mon, 17 Mar 2025 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742225417; x=1742830217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhDi7jicB3Gv5oqI3TBvIGb8fiLoyX3gf2bLY34vPcA=;
        b=Bp/aNoCiZhrCxMhPN1mY6Ur7v87SYSL15uILvt12bfGkxvdymI2jJRwsTkv4xA3ogs
         xR711+++vA3L6CsIqkK3LhEVuyjuX3J/g2V7jwKLsoxmwmHA8XN5f4nOWkqwKywnlm1N
         Qnbyb+kR8TRydOzFlvCMkeUrUV5KpX+AJ3HJhs6YEtJvLd00yXpcMr2eicbpS6tAq9bj
         geFeCGk1gET5CXIKDI6d2QNlDobiGhos4cKkNVT7EdXxVx5DfVSMk5I8tb/vbhUksnbQ
         lmfVsPTJq/LQcKRU3yOuAbBhijnv7mkOdWKNWjkYtbrhdY/jEG80D637MLgXCvoioFmP
         YYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742225417; x=1742830217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhDi7jicB3Gv5oqI3TBvIGb8fiLoyX3gf2bLY34vPcA=;
        b=XoOMwoQ7ldLWkxN1Sok3JbFJVeL577MXjR4gSdO1p1Tfs/92ut3LKhtmZahTgv3dj9
         I3xu8w3IXa+piJMTeBzhYxa5A3YYO50WvqBQ0LE0w9jeoux8WKvKFimTPSXhBNmAUy59
         gY0EVQ8bEcAq28nZWRoPjtf80y0M09/02bWTuQ1hKURz+tZ23O7Kz7sCcUTPqqVbQNc1
         MfTVLKI+O4yCYnGHfFY8+CpXBcxk5XuHFSuA6tqD2S1qxg7sUsadk5bw03tpxCw1eXX8
         bNPV83dc/dM1ysA53C8Yk5VMRP9+Sd0HyklWPME+e88pf9Dal0frUD+MsTBFN26U8ZeI
         jBYg==
X-Forwarded-Encrypted: i=1; AJvYcCW870YBF9keU9lPnz/Lgm82qr40RenBvCxaPIXQvEsT793SjUhPx0FxPY9sqqEnWW40RbEYN2lf@vger.kernel.org, AJvYcCX4HiQ5vsw25rF4tefPkhEt9VZ2eP1BT+6j382G0SSllGnFdvWh5ofXZcX+E4lcBFbeNg00zq5tAsFT@vger.kernel.org, AJvYcCXJ8HBuQuf+3XjYwuRsXzq0pvp8yAI0hCjEkylFACAikJNheJLrA6XpJvCX2t2Cdj39whnBrahMgjZNw9+t@vger.kernel.org, AJvYcCXiTsTFvH3rBdjyKnO/osebT8ElDDCBV2Fqkbo4Zfpxn5tZf2PMu8pOZG+Hz7xla0PRGdsAzq1LL3IP@vger.kernel.org, AJvYcCXwVEckleyqbIJKkTpMlAn2JM08z1FD4rBMFCI21t+N/JC7jsFORQa4RkTlI4S0IG7FYTTVdqQGU4U3ehlshqjq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5HwCsfC7LlfWg8Eiyca+OTrzHBk9E9eahAUAlt6vVPxcZni5t
	wDVzN3/FWOB00ZQ9Ba0MBaOWcbeffBsaJg+v6kfmoOZei6L5a9u5
X-Gm-Gg: ASbGncuvPOVXR4KMZMY0YvihZktwfudwiCzLcU5YN1mZpOMkL9XsrFaRrnn6u1LZQgY
	Oo6XUKNH9gtGhE9VSBw0Vhhx5K/hC4jJVVEZkn9sw+XVVMdmOUydyVSPjWx/ojazNYa/Fw9Mag9
	X1sgDgZQMRb7hOWf3DU2eP/KIM7JULfiFG1/soH97HYcl0TjgZqMsdXk6cnNzNkaUTIbdtSalz+
	hmxC+KoJBFCHs4JuWS/EFM5WvFHOEIWm/7SHCYUc4EJAunIE8bGK4+mzxHS9Lv3LZAlkjJX17P4
	Y4luC8pKjdlOdlktymt2Ai84sqedVVziD8UQhl21PyBil8cP8z+TGceMtvcbyGeu4Aua28D63Hb
	a6YFPLA==
X-Google-Smtp-Source: AGHT+IF6QKQ27zO/djSgLkh3SLlbu4CCHZ6bVaY3V5bdQy4+E/A82ztgFL3TtEYWb5+dRwVxvOIv5Q==
X-Received: by 2002:a05:6214:c47:b0:6e6:5f08:e77d with SMTP id 6a1803df08f44-6eaeaa64726mr197312436d6.19.1742225416788;
        Mon, 17 Mar 2025 08:30:16 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2600:4041:5be7:7c00:6895:24c6:e898:e320])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade34c51fsm55736766d6.109.2025.03.17.08.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:30:16 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 11:30:03 -0400
Subject: [PATCH v9 1/4] rust: move `CStr`'s `Display` to helper struct
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250317-cstr-core-v9-1-51d6cc522f62@gmail.com>
References: <20250317-cstr-core-v9-0-51d6cc522f62@gmail.com>
In-Reply-To: <20250317-cstr-core-v9-0-51d6cc522f62@gmail.com>
To: Michal Rostecki <vadorovsky@protonmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Remove `impl Display for CStr` in preparation for replacing `CStr` with
`core::ffi::CStr` which doesn't impl `Display`. Add `CStr::display`
returning a helper struct to replace the lost functionality; this
matches the APIs exposed by `std::ffi::OSstr` and `std::path::Path` for
printing non-Unicode data.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/kunit.rs |  9 +++++---
 rust/kernel/str.rs   | 63 ++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 824da0e9738a..630b947c708c 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -56,6 +56,7 @@ macro_rules! kunit_assert {
                 break 'out;
             }
 
+            static NAME: &'static $crate::str::CStr = $crate::c_str!($name);
             static FILE: &'static $crate::str::CStr = $crate::c_str!($file);
             static LINE: i32 = core::line!() as i32 - $diff;
             static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
@@ -71,11 +72,13 @@ macro_rules! kunit_assert {
                 //
                 // This mimics KUnit's failed assertion format.
                 $crate::kunit::err(format_args!(
-                    "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
-                    $name
+                    "    # {NAME}: ASSERTION FAILED at {FILE}:{LINE}\n",
+                    NAME = NAME.display(),
+                    FILE = FILE.display(),
                 ));
                 $crate::kunit::err(format_args!(
-                    "    Expected {CONDITION} to be true, but is false\n"
+                    "    Expected {CONDITION} to be true, but is false\n",
+                    CONDITION = CONDITION.display(),
                 ));
                 $crate::kunit::err(format_args!(
                     "    Failure not reported to KUnit since this is a non-KUnit task\n"
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 28e2201604d6..50eb4266047a 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -376,27 +376,66 @@ pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
 
         Ok(s)
     }
-}
 
-impl fmt::Display for CStr {
-    /// Formats printable ASCII characters, escaping the rest.
+    /// Returns an object that implements [`Display`] for safely printing a [`CStr`] that may
+    /// contain non-Unicode data. If you would like an implementation which escapes the [`CStr`]
+    /// please use [`Debug`] instead.
+    ///
+    /// [`Display`]: fmt::Display
+    /// [`Debug`]: fmt::Debug
+    ///
+    /// # Examples
     ///
     /// ```
     /// # use kernel::c_str;
     /// # use kernel::fmt;
-    /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
     /// let penguin = c_str!("🐧");
-    /// let s = CString::try_from_fmt(fmt!("{}", penguin))?;
+    /// let s = CString::try_from_fmt(fmt!("{}", penguin.display()))?;
     /// assert_eq!(s.as_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
     ///
     /// let ascii = c_str!("so \"cool\"");
-    /// let s = CString::try_from_fmt(fmt!("{}", ascii))?;
+    /// let s = CString::try_from_fmt(fmt!("{}", ascii.display()))?;
     /// assert_eq!(s.as_bytes_with_nul(), "so \"cool\"\0".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
+    #[inline]
+    pub fn display(&self) -> Display<'_> {
+        Display { inner: self }
+    }
+}
+
+/// Helper struct for safely printing a [`CStr`] with [`fmt!`] and `{}`.
+///
+/// A [`CStr`] might contain non-Unicode data. This `struct` implements the [`Display`] trait in a
+/// way that mitigates that. It is created by the [`display`](CStr::display) method on [`CStr`].
+///
+/// If you would like an implementation which escapes the string please use [`Debug`] instead.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{fmt, c_str, str::CString};
+/// let ascii = c_str!("Hello, CStr!");
+/// let s = CString::try_from_fmt(fmt!("{}", ascii.display()))?;
+/// assert_eq!(s.as_bytes(), "Hello, CStr!".as_bytes());
+///
+/// let non_ascii = c_str!("🦀");
+/// let s = CString::try_from_fmt(fmt!("{}", non_ascii.display()))?;
+/// assert_eq!(s.as_bytes(), "\\xf0\\x9f\\xa6\\x80".as_bytes());
+/// # Ok::<(), kernel::error::Error>(())
+/// ```
+///
+/// [`fmt!`]: crate::fmt
+/// [`Debug`]: fmt::Debug
+/// [`Display`]: fmt::Display
+pub struct Display<'a> {
+    inner: &'a CStr,
+}
+
+impl fmt::Display for Display<'_> {
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        for &c in self.as_bytes() {
+        for &c in self.inner.as_bytes() {
             if (0x20..0x7f).contains(&c) {
                 // Printable character.
                 f.write_char(c as char)?;
@@ -595,13 +634,13 @@ fn test_cstr_as_str_unchecked() {
     #[test]
     fn test_cstr_display() {
         let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
-        assert_eq!(format!("{}", hello_world), "hello, world!");
+        assert_eq!(format!("{}", hello_world.display()), "hello, world!");
         let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0").unwrap();
-        assert_eq!(format!("{}", non_printables), "\\x01\\x09\\x0a");
+        assert_eq!(format!("{}", non_printables.display()), "\\x01\\x09\\x0a");
         let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").unwrap();
-        assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
+        assert_eq!(format!("{}", non_ascii.display()), "d\\xe9j\\xe0 vu");
         let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0").unwrap();
-        assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
+        assert_eq!(format!("{}", good_bytes.display()), "\\xf0\\x9f\\xa6\\x80");
     }
 
     #[test]
@@ -612,7 +651,7 @@ fn test_cstr_display_all_bytes() {
             bytes[i as usize] = i.wrapping_add(1);
         }
         let cstr = CStr::from_bytes_with_nul(&bytes).unwrap();
-        assert_eq!(format!("{}", cstr), ALL_ASCII_CHARS);
+        assert_eq!(format!("{}", cstr.display()), ALL_ASCII_CHARS);
     }
 
     #[test]

-- 
2.48.1


