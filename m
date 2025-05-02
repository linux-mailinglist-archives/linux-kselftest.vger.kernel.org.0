Return-Path: <linux-kselftest+bounces-32231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0450AA7B99
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1684A84C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 21:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AD121FF21;
	Fri,  2 May 2025 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1GsZP1X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C15210198;
	Fri,  2 May 2025 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222718; cv=none; b=Mj0fv7Ql6PlVOXnOvvHcbad2TsAZ2dAjMr+XFdzUZk23esTBkuMUIi+5o/hT3Wl16RShkYEbgiUrrhiRGJdH8XHCdc/cMkg7Yk/hkdobzMOIQf4vABIO44WQYo1nn7k03O2oyJYvK6COKuVL6iS53KjeB+GBDIVwez9vP4caGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222718; c=relaxed/simple;
	bh=vvQNN9akNzYWDVQbfCy9pnQxfwa6gSBIzDY7UkgvpC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuZoKAEaAgDxEk00M+sZODwMj/Hvaj2GEfiDE4dAkXzO/ShWfGBT/vUpF9fJATv454iOPZeknxv2c6nU/+h+7UIEKJDwTvK0FVsq16Y2rdFOMR9D1U6DDzLP+XIIKym1Mzy8LvZ/IME/dYclKocp1A13aNzoTO17oHpk3C9xgb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1GsZP1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B504C4CEE4;
	Fri,  2 May 2025 21:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746222717;
	bh=vvQNN9akNzYWDVQbfCy9pnQxfwa6gSBIzDY7UkgvpC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1GsZP1XDahePAMHJmlzCYgiV/CEt9OkY7hQCb51O3Cktn0WXN4oYqAzYERFILW1/
	 Z5bQjtiwRxEAIhg/KsLtbMK2E3fmtDsrOrQW6bNARl7ouksHPUklV+qBx0wv+SOJYI
	 uDq4pMTICw5bfGkWYs8UfYQo6m8DUSnVqfUyNNwuAtDQ7YhKK8fhPrYGkMEhM2NL47
	 SIgZEMrkM9VjGbocsgrO06C72vJEWbsFUZHvOPBUYNjJ9Kg9fv7yU7pYtrs7nr22qN
	 LzNRDiANge7gegfSuhGHhxZeX5Qau2+sce1rXrnyY1NSq5vx+ywkQ25HRqCmtWB2FJ
	 zR0OQRn0yRIpQ==
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
Subject: [PATCH 2/7] rust: kunit: support checked `-> Result`s in KUnit `#[test]`s
Date: Fri,  2 May 2025 23:51:27 +0200
Message-ID: <20250502215133.1923676-3-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-1-ojeda@kernel.org>
References: <20250502215133.1923676-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, return values of KUnit `#[test]` functions are ignored.

Thus introduce support for `-> Result` functions by checking their
returned values.

At the same time, require that test functions return `()` or `Result<T,
E>`, which should avoid mistakes, especially with non-`#[must_use]`
types. Other types can be supported in the future if needed.

With this, a failing test like:

    #[test]
    fn my_test() -> Result {
        f()?;
        Ok(())
    }

will output:

    [    3.744214]     KTAP version 1
    [    3.744287]     # Subtest: my_test_suite
    [    3.744378]     # speed: normal
    [    3.744399]     1..1
    [    3.745817]     # my_test: ASSERTION FAILED at rust/kernel/lib.rs:321
    [    3.745817]     Expected is_test_result_ok(my_test()) to be true, but is false
    [    3.747152]     # my_test.speed: normal
    [    3.747199]     not ok 1 my_test
    [    3.747345] not ok 4 my_test_suite

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/kunit.rs | 25 +++++++++++++++++++++++++
 rust/macros/kunit.rs |  3 ++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 2659895d4c5d..f43e3ed460c2 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -164,6 +164,31 @@ macro_rules! kunit_assert_eq {
     }};
 }
 
+trait TestResult {
+    fn is_test_result_ok(&self) -> bool;
+}
+
+impl TestResult for () {
+    fn is_test_result_ok(&self) -> bool {
+        true
+    }
+}
+
+impl<T, E> TestResult for Result<T, E> {
+    fn is_test_result_ok(&self) -> bool {
+        self.is_ok()
+    }
+}
+
+/// Returns whether a test result is to be considered OK.
+///
+/// This will be `assert!`ed from the generated tests.
+#[doc(hidden)]
+#[expect(private_bounds)]
+pub fn is_test_result_ok(t: impl TestResult) -> bool {
+    t.is_test_result_ok()
+}
+
 /// Represents an individual test case.
 ///
 /// The [`kunit_unsafe_test_suite!`] macro expects a NULL-terminated list of valid test cases.
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index eb4f2afdbe43..9681775d160a 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -105,8 +105,9 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     let path = crate::helpers::file();
     for test in &tests {
         let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{}", test);
+        // An extra `use` is used here to reduce the length of the message.
         let kunit_wrapper = format!(
-            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kunit) {{ {}(); }}",
+            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kunit) {{ use kernel::kunit::is_test_result_ok; assert!(is_test_result_ok({}())); }}",
             kunit_wrapper_fn_name, test
         );
         writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
-- 
2.49.0


