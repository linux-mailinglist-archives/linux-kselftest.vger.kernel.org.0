Return-Path: <linux-kselftest+bounces-32234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2DAAA7BA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16ED44A8789
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 21:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9893219E93;
	Fri,  2 May 2025 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3H9e7yl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52AC20E33F;
	Fri,  2 May 2025 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222731; cv=none; b=OxvXhVeF3H7XFmg3kjoNzxl8t+vsazNbsUq6HipsD8Vzig5klgyDyjz9BN2LILiGjv1UU8kc6SiYdLPopXx3/2aDsy3RRYs7OQAb6isAjDCg6Lqb9VPNrRI+ZksuJJbagHUszKUze2bMjK0liyYhrJ3vmWJwEahfKgU/7KClxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222731; c=relaxed/simple;
	bh=b2XaTBmaYpfpczAKBytuofI8i3ymM1pZ7PB4JPzi6y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgvhHIqMQLYG0sYdB2YLfY5tMFoTQ+Adch4n9O5F9ufq2MSUqlxJqnf5IH/umSzKed7eZHJhpnoPwIJDLR8Mv9mds9zPW3MQhv7AWDXW6+E3sQ9YKpb5swhNORdxoC0IRGanarpb+ApplQrR3vFy3NK29kakCxb5PoG2kGLLx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3H9e7yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA26C4CEEB;
	Fri,  2 May 2025 21:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746222731;
	bh=b2XaTBmaYpfpczAKBytuofI8i3ymM1pZ7PB4JPzi6y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3H9e7yljJdkJlrpu610A2i0b6Cmo6kr5pX+4jo7PMHvK55VgTWMqOKZZ8zPF8ndN
	 HcTWv+sffu3Nj2wUllw0aXWkzElys/btzNQvIvHKEx0wp2bxbEsIKzN5s3IgogqMLc
	 CvQ2oGFYVx+fLRAlxD8PM4FpAoM5DxcZaUkl44IsAZr8pD3nhA8o3BhBEmifcJ3Dqp
	 YqY/PvCCGrC32Wd09ItABmAaCvkp7gZDmS97b4eHUHGDsg5xxEfWKg0K7HDcSJMQqt
	 eRZE4eWn83XQj/0MB38svPKr5XzvB2bhi8hztRbECO/EqJk/0yQ6rSZaVeYwCtpsO6
	 wNQEKBOLYQN/g==
From: Miguel Ojeda <ojeda@kernel.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 5/7] rust: str: take advantage of the `-> Result` support in KUnit `#[test]`'s
Date: Fri,  2 May 2025 23:51:30 +0200
Message-ID: <20250502215133.1923676-6-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-1-ojeda@kernel.org>
References: <20250502215133.1923676-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since now we have support for returning `-> Result`s, we can convert some
of these tests to use the feature, and serve as a first user for it too.

Thus convert them.

This, in turn, simplifies them a fair bit.

We keep the actual assertions we want to make as explicit ones with
`assert*!`s.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 68 ++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index cf2caa2db168..8dcfb11013f2 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -576,25 +576,9 @@ macro_rules! c_str {
 mod tests {
     use super::*;
 
-    struct String(CString);
-
-    impl String {
-        fn from_fmt(args: fmt::Arguments<'_>) -> Self {
-            String(CString::try_from_fmt(args).unwrap())
-        }
-    }
-
-    impl Deref for String {
-        type Target = str;
-
-        fn deref(&self) -> &str {
-            self.0.to_str().unwrap()
-        }
-    }
-
     macro_rules! format {
         ($($f:tt)*) => ({
-            &*String::from_fmt(kernel::fmt!($($f)*))
+            CString::try_from_fmt(kernel::fmt!($($f)*))?.to_str()?
         })
     }
 
@@ -613,66 +597,72 @@ macro_rules! format {
         \\xf0\\xf1\\xf2\\xf3\\xf4\\xf5\\xf6\\xf7\\xf8\\xf9\\xfa\\xfb\\xfc\\xfd\\xfe\\xff";
 
     #[test]
-    fn test_cstr_to_str() {
+    fn test_cstr_to_str() -> Result {
         let good_bytes = b"\xf0\x9f\xa6\x80\0";
-        let checked_cstr = CStr::from_bytes_with_nul(good_bytes).unwrap();
-        let checked_str = checked_cstr.to_str().unwrap();
+        let checked_cstr = CStr::from_bytes_with_nul(good_bytes)?;
+        let checked_str = checked_cstr.to_str()?;
         assert_eq!(checked_str, "🦀");
+        Ok(())
     }
 
     #[test]
-    fn test_cstr_to_str_invalid_utf8() {
+    fn test_cstr_to_str_invalid_utf8() -> Result {
         let bad_bytes = b"\xc3\x28\0";
-        let checked_cstr = CStr::from_bytes_with_nul(bad_bytes).unwrap();
+        let checked_cstr = CStr::from_bytes_with_nul(bad_bytes)?;
         assert!(checked_cstr.to_str().is_err());
+        Ok(())
     }
 
     #[test]
-    fn test_cstr_as_str_unchecked() {
+    fn test_cstr_as_str_unchecked() -> Result {
         let good_bytes = b"\xf0\x9f\x90\xA7\0";
-        let checked_cstr = CStr::from_bytes_with_nul(good_bytes).unwrap();
+        let checked_cstr = CStr::from_bytes_with_nul(good_bytes)?;
         // SAFETY: The contents come from a string literal which contains valid UTF-8.
         let unchecked_str = unsafe { checked_cstr.as_str_unchecked() };
         assert_eq!(unchecked_str, "🐧");
+        Ok(())
     }
 
     #[test]
-    fn test_cstr_display() {
-        let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
+    fn test_cstr_display() -> Result {
+        let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0")?;
         assert_eq!(format!("{}", hello_world), "hello, world!");
-        let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0").unwrap();
+        let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0")?;
         assert_eq!(format!("{}", non_printables), "\\x01\\x09\\x0a");
-        let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").unwrap();
+        let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?;
         assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
-        let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0").unwrap();
+        let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0")?;
         assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
+        Ok(())
     }
 
     #[test]
-    fn test_cstr_display_all_bytes() {
+    fn test_cstr_display_all_bytes() -> Result {
         let mut bytes: [u8; 256] = [0; 256];
         // fill `bytes` with [1..=255] + [0]
         for i in u8::MIN..=u8::MAX {
             bytes[i as usize] = i.wrapping_add(1);
         }
-        let cstr = CStr::from_bytes_with_nul(&bytes).unwrap();
+        let cstr = CStr::from_bytes_with_nul(&bytes)?;
         assert_eq!(format!("{}", cstr), ALL_ASCII_CHARS);
+        Ok(())
     }
 
     #[test]
-    fn test_cstr_debug() {
-        let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
+    fn test_cstr_debug() -> Result {
+        let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0")?;
         assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
-        let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0").unwrap();
+        let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0")?;
         assert_eq!(format!("{:?}", non_printables), "\"\\x01\\x09\\x0a\"");
-        let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").unwrap();
+        let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?;
         assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
-        let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0").unwrap();
+        let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0")?;
         assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\"");
+        Ok(())
     }
 
     #[test]
-    fn test_bstr_display() {
+    fn test_bstr_display() -> Result {
         let hello_world = BStr::from_bytes(b"hello, world!");
         assert_eq!(format!("{}", hello_world), "hello, world!");
         let escapes = BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
@@ -683,10 +673,11 @@ fn test_bstr_display() {
         assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
         let good_bytes = BStr::from_bytes(b"\xf0\x9f\xa6\x80");
         assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
+        Ok(())
     }
 
     #[test]
-    fn test_bstr_debug() {
+    fn test_bstr_debug() -> Result {
         let hello_world = BStr::from_bytes(b"hello, world!");
         assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
         let escapes = BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
@@ -697,6 +688,7 @@ fn test_bstr_debug() {
         assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
         let good_bytes = BStr::from_bytes(b"\xf0\x9f\xa6\x80");
         assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\"");
+        Ok(())
     }
 }
 
-- 
2.49.0


