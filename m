Return-Path: <linux-kselftest+bounces-48775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0273AD14539
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 18:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F27B30E7458
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 17:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F97378D71;
	Mon, 12 Jan 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R23PVJ9L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0B36CDE7;
	Mon, 12 Jan 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237926; cv=none; b=R/Wvz9yJ9nhBWPWyhO0HRaC6g93H5t7okVn2Yxty8gUk1erF//3OVn5+NEnDsTLq1M5qijH2lB2FyqIqECG0QpFCE/9azOCvpNg7Rpk9Yv0C2oq+4xMM1jQsYYN+lEfQV73lr/f7vzqTcVrsPtfv2MHrO/gTJqXiKWBJCMKhTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237926; c=relaxed/simple;
	bh=r1YX77jE0pejVZ0kyjXbEyqGpgp4bO0aXl2ENX5Wl7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9hjHWUX9W9vG9nUb1bQJTFIvhwvgMmKniK27mJZFNBb9THD04yZLNxXw4/tvqH8EXizRu135RySuEiaJeF1yv/36C0+fM9Ga5NXxtvHYLSivi8OMi1GzXEcs43Z5yPsA1u6ArxcDiuuW7crt7JOO4ceORpBdFVTE0NH9iXoGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R23PVJ9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BBFC116D0;
	Mon, 12 Jan 2026 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768237926;
	bh=r1YX77jE0pejVZ0kyjXbEyqGpgp4bO0aXl2ENX5Wl7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=R23PVJ9LDuMEDTOiywMlHiLQWCL69X3+wZ0OqXbVpvh330/frUKjzckHZWHUoyWrI
	 QuOF7KY8YG8pU2T7bXyf/yVzvEiAL4DaapwPKtSqEtl0/L55YW+5FjzUSimoiOgOlE
	 6NmxrN614KDnFVr9UIUFLO3agtJGr/yrWrqwfTfIsRxp3QjG2Nk348AY0j82PYWD46
	 aFlKS/LQ7aLqegsTQRsZjLJK2C5NLEAb+Z791gSBrJCVaOS4skMluHFLzHzT2G/d5X
	 Y3SeSVwI1cE8BmsgGbpY7vcBok3Dguf7KuXApa9YmrjzFrNC73rLyblcbb62wnv4l8
	 /vHKCaZWvJ5ww==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <raemoar63@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	Tamir Duberstein <tamird@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/12] rust: kunit: use `pin_init::zeroed` instead of custom null value
Date: Mon, 12 Jan 2026 17:07:22 +0000
Message-ID: <20260112170919.1888584-12-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260112170919.1888584-1-gary@kernel.org>
References: <20260112170919.1888584-1-gary@kernel.org>
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

The last null element can be created (constly) using `pin_init::zeroed`,
so prefer to use it instead of adding a custom way of building it.

Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/kunit.rs | 26 +-------------------------
 rust/macros/kunit.rs |  4 ++--
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 79436509dd73d..034158cdaf06b 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -192,9 +192,6 @@ pub fn is_test_result_ok(t: impl TestResult) -> bool {
 }
 
 /// Represents an individual test case.
-///
-/// The [`kunit_unsafe_test_suite!`] macro expects a NULL-terminated list of valid test cases.
-/// Use [`kunit_case_null`] to generate such a delimiter.
 #[doc(hidden)]
 pub const fn kunit_case(
     name: &'static kernel::str::CStr,
@@ -215,27 +212,6 @@ pub const fn kunit_case(
     }
 }
 
-/// Represents the NULL test case delimiter.
-///
-/// The [`kunit_unsafe_test_suite!`] macro expects a NULL-terminated list of test cases. This
-/// function returns such a delimiter.
-#[doc(hidden)]
-pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
-    kernel::bindings::kunit_case {
-        run_case: None,
-        name: core::ptr::null_mut(),
-        generate_params: None,
-        attr: kernel::bindings::kunit_attributes {
-            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
-        },
-        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
-        module_name: core::ptr::null_mut(),
-        log: core::ptr::null_mut(),
-        param_init: None,
-        param_exit: None,
-    }
-}
-
 /// Registers a KUnit test suite.
 ///
 /// # Safety
@@ -254,7 +230,7 @@ pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
 ///
 /// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] = [
 ///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
-///     kernel::kunit::kunit_case_null(),
+///     pin_init::zeroed(),
 /// ];
 /// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
 /// ```
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index afbc708cbdc50..cb29f350d5b2b 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -74,7 +74,7 @@ pub(crate) fn kunit_tests(test_suite: Ident, mut module: ItemMod) -> Result<Toke
     // static mut TEST_CASES: [::kernel::bindings::kunit_case; 3] = [
     //     ::kernel::kunit::kunit_case(::kernel::c_str!("foo"), kunit_rust_wrapper_foo),
     //     ::kernel::kunit::kunit_case(::kernel::c_str!("bar"), kunit_rust_wrapper_bar),
-    //     ::kernel::kunit::kunit_case_null(),
+    //     ::pin_init::zeroed(),
     // ];
     //
     // ::kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_CASES);
@@ -159,7 +159,7 @@ macro_rules! assert_eq {
     processed_items.push(parse_quote! {
         static mut TEST_CASES: [::kernel::bindings::kunit_case; #num_tests_plus_1] = [
             #(#test_cases,)*
-            ::kernel::kunit::kunit_case_null(),
+            ::pin_init::zeroed(),
         ];
     });
     processed_items.push(parse_quote! {
-- 
2.51.2


