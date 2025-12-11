Return-Path: <linux-kselftest+bounces-47456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31895CB703C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 20:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C262C30577C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA6231CA42;
	Thu, 11 Dec 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tofkmiun"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434EE31B12D;
	Thu, 11 Dec 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765481424; cv=none; b=CYXVdn1HXJRqILs8kECRJKD6HeVViABigeEmt/GDY+H22BwGnjXjUrZIERmdz1N5bK0oUTSzi4l/rdep+t5wwGvZQkgLSkCvDOTm4zSz6OL9cmr92qPHeiueVh1Bfct8SVltK6fnz8LQog9Hgs+5xFebELwdplAqGTShNSwdKd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765481424; c=relaxed/simple;
	bh=gvcQWRbHO5oXNfaq+pIACHMiyAWHPnCzQ5sPRAzBkgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+3GfJvYWlkWcOxAY9nRzN4ULXpGMxzAOVrTApbTWAt8IaWHWz9x4PQAjNU3dem6gNTiaqCDlIF4bGxoAcSJxv2Ac6f3GGhxhotD/7eEsAIeAnfCw9Ietc2yhqMm6SSHBOY8nyn4rnWRQJxymGkbCC6koeRV8/wohA/+s5Q/Y5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tofkmiun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123F6C4CEF7;
	Thu, 11 Dec 2025 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765481423;
	bh=gvcQWRbHO5oXNfaq+pIACHMiyAWHPnCzQ5sPRAzBkgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=TofkmiunCzW6t0VV8Gu1+j2+aw2e0VvEy5+zfbExy1flkAojFNddAIFpjZBrHPdIt
	 CuFuF6JG8HCQw0wihbmZ1TwkBOfG02hlRI4jBbLhCpZu1WGPJwQnuLApMw25kKPybr
	 T+HoV/QozDPUOqudOXS99H1gA/sPQJTfg2QiSGybU7UF+kQK/NWV26BXbbTaZyakDz
	 4+MCEEX6tVNoQIkVlSHxzrs4yX3kkXVxqXeXStEP1/QNTjyALJjmI6R5PArBFzNKwj
	 zSUWgmNdyQBqfvWNypsRrpaZ5KUet8uE18tUdJP4HrOCaJy3PgGnWWpbfkckXJhVvW
	 atn1JGJsqfv7g==
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
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] rust: kunit: use `pin_init::zeroed` instead of custom null value
Date: Thu, 11 Dec 2025 18:56:51 +0000
Message-ID: <20251211185805.2835633-12-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251211185805.2835633-1-gary@kernel.org>
References: <20251211185805.2835633-1-gary@kernel.org>
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
index 516219f5b1356..fd2cfabfaef76 100644
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


