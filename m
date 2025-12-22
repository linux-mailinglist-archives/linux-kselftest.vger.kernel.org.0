Return-Path: <linux-kselftest+bounces-47842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03414CD5FAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 13:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B102A30038D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE723A9BD;
	Mon, 22 Dec 2025 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4tw116O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53B1C84A2;
	Mon, 22 Dec 2025 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766406515; cv=none; b=bmcicKEYuDWt7TTg9SrrGKfJLQGxuEADr44SKOXB+euZM5isUTtIp/tAv0low5ydhAouXUiYttsxRSyWOvwPR6rfqddXREJpU800NNFd9HQS046KoM/6LpEcopmx80RCqa27LjeqdPnLkMG4EKa9wEiuBdmRh1+chDghwuVTwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766406515; c=relaxed/simple;
	bh=jOwV7nUJ5dOaWvUO6114YDd2fspA3/2foFpNPnjb0x4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FqrKmVRzsZvPoIbuQef3U6U69pxcNdZQkfzNUJy1LYJ7GvbTuE9AiGnRjI8Cx2T/HyN++SiUtC6VLNyk1eUAnvkmoql2m0UFMRic20tO08eFUmX9SYbYdaWqxRRLkgVL0sWlHJH6kMAl5Dpxw3N/+wxvT7IHHE9gcZ0yG7diDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4tw116O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8E4C113D0;
	Mon, 22 Dec 2025 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766406515;
	bh=jOwV7nUJ5dOaWvUO6114YDd2fspA3/2foFpNPnjb0x4=;
	h=From:Date:Subject:To:Cc:From;
	b=F4tw116OuitRQxfvc/ZKQIX5IB/+wFDkqQBm6H9rdU/jUU0fhk29Z7r7YfOGjdW0T
	 V+ea/cd+Tv71m2EuTyN0cmqo/IXf5rSdaeUShCbewpwmmMwYDvnduaLlDPh/MQwEL+
	 LX+0WcovE5Dj8HAvHduBgPnyefid66SEA265TeSHzh3mayhXj2+LPDEQ9E+W8ufPQf
	 vjkZTey0/QiZWt9L+GZInXF06kq2wZfZTYVWwb4S2nvGfE7EOay2roVljsOtoo+Ust
	 4qRzwe5wRC+yYKtnTg0uJ0FUccVgRH9C2m7tYQ0Sp0+YYFfMJBWjDp99QhaVEiOwv+
	 LyyRUHBh8D86w==
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 22 Dec 2025 13:28:27 +0100
Subject: [PATCH] rust: kunit: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-cstr-kunit-v1-1-39d999672f35@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDVhkoq4ilhoOxiSkk6JRNxds
 XyL/y8QCkwCTXZBoIOFV59Q5hnYqfcjKXbJgAXqEhGVlRjUsnuOylBVO1fbwTgNKdgCDXx+s7b
 7LbuZycb3APf9ABtIlkJuAAAA
X-Change-ID: 20251222-cstr-kunit-be68dd8cfbd5
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1766406510; l=5424;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=pwc3vGXHK+ibZCWjh3w0zYv5qhibNAV50Z6yzjPg+KU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPHR7xsCCwONVpfA7DwG98VZ4PJ6knRY06MAhx0lsZjwcogcRr81hLQJQl62oeN9LPaVvD5Dv9R
 k8fM1IjR1ag4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/kunit.rs        | 11 ++++-------
 rust/macros/kunit.rs        | 10 +++++-----
 scripts/rustdoc_test_gen.rs |  4 ++--
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 79436509dd73..21aef6c97325 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -9,9 +9,6 @@
 use crate::fmt;
 use crate::prelude::*;
 
-#[cfg(CONFIG_PRINTK)]
-use crate::c_str;
-
 /// Prints a KUnit error-level message.
 ///
 /// Public but hidden since it should only be used from KUnit generated code.
@@ -22,7 +19,7 @@ pub fn err(args: fmt::Arguments<'_>) {
     #[cfg(CONFIG_PRINTK)]
     unsafe {
         bindings::_printk(
-            c_str!("\x013%pA").as_char_ptr(),
+            c"\x013%pA".as_char_ptr(),
             core::ptr::from_ref(&args).cast::<c_void>(),
         );
     }
@@ -38,7 +35,7 @@ pub fn info(args: fmt::Arguments<'_>) {
     #[cfg(CONFIG_PRINTK)]
     unsafe {
         bindings::_printk(
-            c_str!("\x016%pA").as_char_ptr(),
+            c"\x016%pA".as_char_ptr(),
             core::ptr::from_ref(&args).cast::<c_void>(),
         );
     }
@@ -60,7 +57,7 @@ macro_rules! kunit_assert {
                 break 'out;
             }
 
-            static FILE: &'static $crate::str::CStr = $crate::c_str!($file);
+            static FILE: &'static $crate::str::CStr = $file;
             static LINE: i32 = ::core::line!() as i32 - $diff;
             static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
 
@@ -253,7 +250,7 @@ pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
 /// }
 ///
 /// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] = [
-///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
+///     kernel::kunit::kunit_case(c"name", test_fn),
 ///     kernel::kunit::kunit_case_null(),
 /// ];
 /// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index b395bb053695..3d7724b35c0f 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -102,8 +102,8 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     // unsafe extern "C" fn kunit_rust_wrapper_bar(_test: *mut ::kernel::bindings::kunit) { bar(); }
     //
     // static mut TEST_CASES: [::kernel::bindings::kunit_case; 3] = [
-    //     ::kernel::kunit::kunit_case(::kernel::c_str!("foo"), kunit_rust_wrapper_foo),
-    //     ::kernel::kunit::kunit_case(::kernel::c_str!("bar"), kunit_rust_wrapper_bar),
+    //     ::kernel::kunit::kunit_case(c"foo", kunit_rust_wrapper_foo),
+    //     ::kernel::kunit::kunit_case(c"bar", kunit_rust_wrapper_bar),
     //     ::kernel::kunit::kunit_case_null(),
     // ];
     //
@@ -133,7 +133,7 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
         writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
         writeln!(
             test_cases,
-            "    ::kernel::kunit::kunit_case(::kernel::c_str!(\"{test}\"), {kunit_wrapper_fn_name}),"
+            "    ::kernel::kunit::kunit_case(c\"{test}\", {kunit_wrapper_fn_name}),"
         )
         .unwrap();
         writeln!(
@@ -143,7 +143,7 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
 #[allow(unused)]
 macro_rules! assert {{
     ($cond:expr $(,)?) => {{{{
-        kernel::kunit_assert!("{test}", "{path}", 0, $cond);
+        kernel::kunit_assert!("{test}", c"{path}", 0, $cond);
     }}}}
 }}
 
@@ -151,7 +151,7 @@ macro_rules! assert {{
 #[allow(unused)]
 macro_rules! assert_eq {{
     ($left:expr, $right:expr $(,)?) => {{{{
-        kernel::kunit_assert_eq!("{test}", "{path}", 0, $left, $right);
+        kernel::kunit_assert_eq!("{test}", c"{path}", 0, $left, $right);
     }}}}
 }}
         "#
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index be0561049660..967064ebd391 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -174,7 +174,7 @@ pub extern "C" fn {kunit_name}(__kunit_test: *mut ::kernel::bindings::kunit) {{
     macro_rules! assert {{
         ($cond:expr $(,)?) => {{{{
             ::kernel::kunit_assert!(
-                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $cond
+                "{kunit_name}", c"{real_path}", __DOCTEST_ANCHOR - {line}, $cond
             );
         }}}}
     }}
@@ -184,7 +184,7 @@ macro_rules! assert {{
     macro_rules! assert_eq {{
         ($left:expr, $right:expr $(,)?) => {{{{
             ::kernel::kunit_assert_eq!(
-                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right
+                "{kunit_name}", c"{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right
             );
         }}}}
     }}

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-cstr-kunit-be68dd8cfbd5

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


