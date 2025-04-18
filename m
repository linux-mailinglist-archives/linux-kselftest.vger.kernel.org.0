Return-Path: <linux-kselftest+bounces-31118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3088A92F6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 03:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602701B65CF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280F21DF75D;
	Fri, 18 Apr 2025 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="tZHOk7Pz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F471DF277
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940538; cv=none; b=IIxMUkLRNBEVFdxK4wOzcRUNYDZCTG3craXfe5tksKBDIMprRPSqDbqSv18MM2k9FOX8E2k/y/1WCz8M/ZlxZS0MItjmOnhisBrlMCESiLWCfbiqD99yygarg01D30//1p5OK+4/cH6C62Q+T+TbdNrQ+nL0Z3RdslSmbLTHry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940538; c=relaxed/simple;
	bh=AsXerO6M3JJeGimaY8r23ZEYRge1XS9d6tD5VYo6WLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrnbsjCx/P/jwEyik3GGLe6hDBGA+c1TisT+Ub7dXKd6RAVi0PHOjLoEjTWBSk6waWc3UbHpzl1z+r3IPiQ9dJtBxnLynB9BH12IOUlxOuWl2ALSGjWNAhXuv74SzyjtxCIcj3GA6wcT/fnIQdltG+bqsBRBbzCfrG/XbQNsvVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=tZHOk7Pz; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6fee50bfea5so12382017b3.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 18:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1744940535; x=1745545335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KVr9YoaGaQgWb5xariEP7OGZvSaNc2U9G9atBahdE8=;
        b=tZHOk7PzZ5hFQbMPVsYyOaQUAZ3JAJ1orsikVgKRG9OEAyR4jScQ7Yr4ElW5hRnL21
         OmFOuol0VAqCdbX+Jh/8qGV1MR8S4q+xt5Bb46XcVYPolCbXYZEoXPr3vcyJzXci5ZKt
         XaYILBnoIimuWv1t21Cql7K6U6bLLLYpePG6ZIGqIPqaAE7KdCmTUs0aNWhyR+hGBD+h
         ibiSxKauIUoACs7eJ2BAOTUm+wvSY2mfS/pElIV6o2q7HOFO7QlrBy99M+4U4YvZODG9
         bhn/m5/jbQ+CPBlhcKGIg4lFz2j4Oz3ITZujljPXixUGDSnnZJ/d8tvBySuCI5rPzrhM
         3/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744940535; x=1745545335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KVr9YoaGaQgWb5xariEP7OGZvSaNc2U9G9atBahdE8=;
        b=Yu4p74Kdfd4A2C/ZMCPB7lqJwqISAsAPn9VAefrdPdvGzlU0WYeYT8+dGZTYUvXpd2
         74PgW9HXVKeX7qGedxLcQpOsKM7zcJWbsL8nhE0fcEZmJwBiBmXAeeRqdaOvyHOFPFAu
         nVus7g89wCN0qtFq0G8Wr4VhebSuj2My+XAxXvJkjkqR39dJqPRIMZOtoMOo6ow3b7N/
         UdsSB8kDzl9oeK113LC88QVQKoTpK/H/N8QRq+NbqZ/+Xk9nGqgLDWG6rYFs2yNK2nUX
         jeyJOH9Vz4meAUP1k8gd1iy+nzIC5WW4TJOj4mX+Pqp945dKIlFNEVv3N03AByWKM6mb
         LWRg==
X-Forwarded-Encrypted: i=1; AJvYcCWa/0Oh4EweWBt8JErGYpT2gnPUXIp+z97FwD6frHSQl9Zlt7ZmADNfGfVgzbYUrVr9/mDGKvExgzjKPKgml3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YynghK1oa3PANOJreDXjw9erX7m1ne8ouUcNwvR/zyz/JV+xCtl
	ZE1VVZxA45slf5pbSV1eZ3g0FpzxgDLLABMm191F+wrV0dWBdz8/119Q/rgaNww=
X-Gm-Gg: ASbGncuyXe80irTeMqOH8cl0i7zLWagcIajDo924by2Etr71h3NDCNV3eE8quVNPU9w
	NRAdpLTy6+UHn1FJ/yKuEPv8WoWKT9Uq+dEkcLDQTfFMOtAwx9ufHQF6a9thGZR5+tR9C4+XGyt
	/M07gydmPeQVXL14rL9gA3KYdW979UrqAoke0Lkq2hbcnzDFJeJMPXye8s+EpXVAXbmDR3eH+GJ
	tbjnhw1at/ZQhJSlRUSZBDZ64fchyjNG+0jTvEdG6Bnlui0viz3AO7kbj3tC5xAEhLGu2io5wST
	i5DUhXI/uk00ePkLChL8k/iV82XjPJMMXsFONVB+hMCWz3Y0tH42SkMPWt6UjbeKMWBN8xrAH11
	TXGPpt7P7pkTEUvmCQO/wEjWy69cCBHgqXfCr
X-Google-Smtp-Source: AGHT+IE/O6gWkQMozzU/sZ0vQ7iAMIJZ80Gw3gnlvoeuFzX09jFzx3stefvWq4XPYCQQb119QbF5Vg==
X-Received: by 2002:a05:690c:670b:b0:6fb:9c08:4980 with SMTP id 00721157ae682-706cce0e007mr15660347b3.27.1744940535286;
        Thu, 17 Apr 2025 18:42:15 -0700 (PDT)
Received: from Machine.localdomain (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca44fd13sm2804597b3.20.2025.04.17.18.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 18:42:14 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/18] rust: kunit: refactor to use `&raw [const|mut]`
Date: Thu, 17 Apr 2025 21:41:26 -0400
Message-ID: <20250418014143.888022-6-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418014143.888022-1-contact@antoniohickey.com>
References: <20250418014143.888022-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/kunit.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 1604fb6a5b1b..9f8165b15a37 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -130,9 +130,9 @@ unsafe impl Sync for UnaryAssert {}
             unsafe {
                 $crate::bindings::__kunit_do_failed_assertion(
                     kunit_test,
-                    core::ptr::addr_of!(LOCATION.0),
+                    &raw const LOCATION.0,
                     $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
-                    core::ptr::addr_of!(ASSERTION.0.assert),
+                    &raw const ASSERTION.0.assert,
                     Some($crate::bindings::kunit_unary_assert_format),
                     core::ptr::null(),
                 );
@@ -261,7 +261,7 @@ macro_rules! kunit_unsafe_test_suite {
                     // (as documented) must be valid for the lifetime of
                     // the suite (i.e., static).
                     test_cases: unsafe {
-                        ::core::ptr::addr_of_mut!($test_cases)
+                        (&raw mut $test_cases)
                             .cast::<::kernel::bindings::kunit_case>()
                     },
                     suite_init: None,
@@ -283,7 +283,7 @@ macro_rules! kunit_unsafe_test_suite {
             #[cfg_attr(not(target_os = "macos"), link_section = ".kunit_test_suites")]
             static mut KUNIT_TEST_SUITE_ENTRY: *const ::kernel::bindings::kunit_suite =
                 // SAFETY: `KUNIT_TEST_SUITE` is static.
-                unsafe { ::core::ptr::addr_of_mut!(KUNIT_TEST_SUITE) };
+                unsafe { &raw mut KUNIT_TEST_SUITE };
         };
     };
 }
-- 
2.48.1


