Return-Path: <linux-kselftest+bounces-48417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2550ACFEF2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 17:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9159330019F4
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD89A38DFA3;
	Wed,  7 Jan 2026 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itnFRFb0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B738D4BC;
	Wed,  7 Jan 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803483; cv=none; b=eAxwZkddSi3QR0TWFdX4m8esnaB4TVN1vk/RboShzg6fsFyjn6lEXRlt4qydtd42Xi4Zn18QYS6tI1iCY/2H3RjRis1wUt1a8G61wK6lSpZjlfJeMz2MKB6i0vg7tSzTxGOTMsxTh0s/ma2oXSvaP1cMDRVdYvn0ceqBJm1zxTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803483; c=relaxed/simple;
	bh=r1YX77jE0pejVZ0kyjXbEyqGpgp4bO0aXl2ENX5Wl7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1rRvK2iOmIbf39laCLxANrHI+kaxA56sycb4tzKJRrD1u2abBVEO4tXmCHPqeEwkImHBukQNWCfCl0JvQKgxbLyEdvmwvAsykqOGmNtyOIWYdosVGUGe9JF/HsXHdPTKv3mkDPT1qJ6zXn0jxVz0L6fxitD21Q9QS3neYxFOgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itnFRFb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FC6C4CEF1;
	Wed,  7 Jan 2026 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767803479;
	bh=r1YX77jE0pejVZ0kyjXbEyqGpgp4bO0aXl2ENX5Wl7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=itnFRFb0LOdIByBElrcuGzDKX2+icgsvAibWUMMrlsMSasHZgscIEsA4cDqgB/OpF
	 D4fCMNtuEJnjoRLS3Mha+t1zZHotw+GK636Ifsn3wDeKa9T9evhbHUJsov/vcfinKU
	 PV69admgME4dE81FPRPFnKEiB8rEM+QuQ8kja7D9KYmZQc56mHvVQSHdPMfjaE0X/c
	 oevoTMQTTGF1I2CmKL1kVWqP0Vtjys3HqTOpmqvGVe7175ngvNFZp5Bo3XTBHFBik8
	 noxcLqm6JTBKj46RbhYHm8BwfAvcwb6At+OH9onfVKoaIsEs7/9b7Xttb51GrI5jsd
	 6qeKjUCzKCuLg==
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
Subject: [PATCH v2 11/11] rust: kunit: use `pin_init::zeroed` instead of custom null value
Date: Wed,  7 Jan 2026 16:15:50 +0000
Message-ID: <20260107161729.3855851-12-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107161729.3855851-1-gary@kernel.org>
References: <20260107161729.3855851-1-gary@kernel.org>
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


