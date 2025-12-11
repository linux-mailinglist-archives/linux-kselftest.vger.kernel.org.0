Return-Path: <linux-kselftest+bounces-47450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA54CB6E48
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 19:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1F2D300AC71
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00F13191D8;
	Thu, 11 Dec 2025 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJhroV1Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B374F212FB9;
	Thu, 11 Dec 2025 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765477366; cv=none; b=pHc87jaiVVX+OdP4MyIQuzQ6g5WgZ+iqe0pMR7VAjEzZP0woNgNjJmj3+KgWnv3SjZpN7WNhG9pd7PiEtEPI5FN+wNyGDH+/W74V+HGYGhl2C1KXjlp4JrnrOYYE5auYgVohUftVee20xGeEvh6edz4KI1ylOUtVmgTr6Ffjd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765477366; c=relaxed/simple;
	bh=iBQjv3NyRtOjmLtefM8m6iGDiD1Mh1LPOFF6RcjDQW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uq9WbUvo+kTNww3sMoHdgj9IL8pfaKxRoP/5B7RinkC+raHt71smemygIVUsK38VpYz+f6rpyWYoDfka4q3+8FO5Qj/RyfyYydL8QCRa3M8v4qgMyr140kOarHnIiTNeX+EVLGqjDLdbPjFpV5+85ou/JUbLG12ThO2nmO9RkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJhroV1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5407BC4CEF7;
	Thu, 11 Dec 2025 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765477366;
	bh=iBQjv3NyRtOjmLtefM8m6iGDiD1Mh1LPOFF6RcjDQW8=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=ZJhroV1QaoQ2yInEmrI7Tqff7LFfOckTnWcyiahfVwo5bppagQpREI1PTHTx6Njvy
	 5XGU0b/2WAGwInMPljQVHDuMMTM6xlKWHqjKG7ecX2usJxDugxU3APbcgU4aXQO2Ny
	 x+clncd3fZehdb19Pq5vNqLLpu5PODx1BYqrVRzI+9PWJ2eCFX7jQuqWvxlHVPR21Q
	 NjuUNlify6sgCJkDBlhctMw6a8/RquLj+hGWCIrNIjvW18/LcWWpj031wW7Rms7Hdt
	 Z516tNgC8jPWyhe6WLSCOncqvfshei6jvN8sTXbeGIg1q0KxW3Tf3OzLUpg02DmPAR
	 3AhDMMl5URBYQ==
From: Gary Guo <gary@kernel.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <raemoar63@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: fix off-by-one line number in rustdoc tests
Date: Thu, 11 Dec 2025 18:22:07 +0000
Message-ID: <20251211182208.2791025-1-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

When the `#![allow]` line was added, the doctest line number anchor
isn't updated which causes the line number printed in kunit test to be
off-by-one.

Fixes: ab844cf32058 ("rust: allow `unreachable_pub` for doctests")
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 scripts/rustdoc_test_gen.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index be05610496605..6fd9f5c84e2e4 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -206,7 +206,7 @@ macro_rules! assert_eq {{
 
     /// The anchor where the test code body starts.
     #[allow(unused)]
-    static __DOCTEST_ANCHOR: i32 = ::core::line!() as i32 + {body_offset} + 1;
+    static __DOCTEST_ANCHOR: i32 = ::core::line!() as i32 + {body_offset} + 2;
     {{
         #![allow(unreachable_pub, clippy::disallowed_names)]
         {body}

base-commit: 559e608c46553c107dbba19dae0854af7b219400
-- 
2.51.2


