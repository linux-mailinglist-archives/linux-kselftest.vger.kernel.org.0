Return-Path: <linux-kselftest+bounces-32233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B022AA7BA0
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0344A8733
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 21:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FB6225A29;
	Fri,  2 May 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSw+oRn5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B70219E93;
	Fri,  2 May 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222727; cv=none; b=HYHiD2ETPiTQTmPreIf2HyhmPWya/h213/8L7HXHbYRpQNfOyI44E6mt05/HRT++gv/dzJS3oF5lPLsdNSkTwsGJ6crr98kGcKQPXdDBxO2VHwe0JV4pjxOy3ZxOHu9h2BwZtJTxGThlNp2CTt78+VEHS4FjAvmiAkIyWuYiT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222727; c=relaxed/simple;
	bh=YG1y6vcd/mwrVWGLSsGMxcKcSqp12PyuG/HK1WrSQL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiuN2Gi53y1DW/LlMScHGUfs8QWzK1uHTdF6jj7A/mzknji8Ioau8sT6LThSOkCiNLiaStwYONCMFL5uU9v2YAP0142YAjGGDbP5/nc99UC3ugDKbi0h22TY3A1k5wYxbM/2/Gqf6z5b8f/wwk3Q8CEoSCseuoYAQySfXTVaUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSw+oRn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798E6C4CEE4;
	Fri,  2 May 2025 21:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746222726;
	bh=YG1y6vcd/mwrVWGLSsGMxcKcSqp12PyuG/HK1WrSQL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSw+oRn5Ywhz2iT8S9ASiK4VzgoAVpw+bnbGyLDaR7N2jRdI8iuMxfaQqOx3P1zj+
	 YCEiRO5LUv90Ccd4VyPknQEW8YC897iSA35Amv0Xgv2bqDzKx7rjg5u1GuBPXo2tW8
	 7GXRpncRHRme7HGbSGhw8aMQMwAn6j35FBqSuXdLLNo2xhrPdkr/Uv0SKHjNCeleU/
	 nN98wg6/+3PZuZ0UBAeBZfAhhzWurcfiGH24kuDMXFwjac2cBssVa+V+cthr4UHWeG
	 3fpxKm+RuQkhG4KbH8za53psCxPgK73vHqyxS3Urx6Uj8JNkvKMg5Is+iDB8pbwNeH
	 M5HeJXaHgPNTQ==
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
Subject: [PATCH 4/7] rust: str: convert `rusttest` tests into KUnit
Date: Fri,  2 May 2025 23:51:29 +0200
Message-ID: <20250502215133.1923676-5-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-1-ojeda@kernel.org>
References: <20250502215133.1923676-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general, we should aim to test as much as possible within the actual
kernel, and not in the build host.

Thus convert these `rusttest` tests into KUnit tests.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 878111cb77bc..cf2caa2db168 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -6,7 +6,7 @@
 use core::fmt::{self, Write};
 use core::ops::{self, Deref, DerefMut, Index};
 
-use crate::error::{code::*, Error};
+use crate::prelude::*;
 
 /// Byte string without UTF-8 validity guarantee.
 #[repr(transparent)]
@@ -572,8 +572,7 @@ macro_rules! c_str {
     }};
 }
 
-#[cfg(test)]
-#[expect(clippy::items_after_test_module)]
+#[kunit_tests(rust_kernel_str)]
 mod tests {
     use super::*;
 
@@ -622,11 +621,10 @@ fn test_cstr_to_str() {
     }
 
     #[test]
-    #[should_panic]
-    fn test_cstr_to_str_panic() {
+    fn test_cstr_to_str_invalid_utf8() {
         let bad_bytes = b"\xc3\x28\0";
         let checked_cstr = CStr::from_bytes_with_nul(bad_bytes).unwrap();
-        checked_cstr.to_str().unwrap();
+        assert!(checked_cstr.to_str().is_err());
     }
 
     #[test]
-- 
2.49.0


