Return-Path: <linux-kselftest+bounces-32232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42336AA7B9C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC961B63959
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 21:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1DF221FD8;
	Fri,  2 May 2025 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYJxa0fO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A8221F21;
	Fri,  2 May 2025 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222722; cv=none; b=ZurvBqxx+aBVP6qVKS9Xfe4d8zRz2o1jGqWavULApm32g9CmhlIlXn0+FKu9As5RZ8swTnW7dk9YcSBl85DnCtx9/ZeC4MPrCoiP8DNXXQVhXbDjaKAgzQhzid9P0Gv0fhjTmLSrzjSt/woIo5nlalYS359GoraDogYncvQA508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222722; c=relaxed/simple;
	bh=Ywzns9kdzvgchDQq8gUskAhoVH1XxfCbNL7gC5kzNDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4g6JTjkca8dcivixdrb6yJzPfUGRSfTV7Eebvjn7ocvBKOuxo4hvQzFcQt5F12QA5eFIlZNuUYjLL87115tcrcdAManoe3hbcHGJJ/Q/tBc2ewvzua7LOy/grWX1UP6F1EDESskVUCsi8SymungQhAQTvWVSAusXPjdRPk6J38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYJxa0fO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19A2C4CEEB;
	Fri,  2 May 2025 21:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746222722;
	bh=Ywzns9kdzvgchDQq8gUskAhoVH1XxfCbNL7gC5kzNDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYJxa0fOKQNQqSN0tZ1fD5HfOhHC4111Fosluxj856LqCVvm1i0bw/BiMz2LGr1Cq
	 dtCFMp+b+4N272rKP6CvTAWLgArXYlUCpxw74GwvqQMyAvh2ofbie1Dn2Bp1Zdd28c
	 Lqzt0u3WyEPFJmv3Wig1dGARB0gwhirUFUimzNMcx3P9ugogPciIevNdC4WYrfA9fc
	 EaVwygKjs3rpK1s4gvezw8Z9qic4K307JQTj2C2V2EBgGYx0odRCeFvOcWklajdt61
	 OUQfDlAj2OIjTrqRCHYKb/NJOOvtYc+DTFZA3LTDWdnOymVpcpZi9B+0/NJL6ME++R
	 WnFvWCd66PhXA==
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
Subject: [PATCH 3/7] rust: add `kunit_tests` to the prelude
Date: Fri,  2 May 2025 23:51:28 +0200
Message-ID: <20250502215133.1923676-4-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-1-ojeda@kernel.org>
References: <20250502215133.1923676-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is convenient to have certain things in the `kernel` prelude, and
means kernel developers will find it even easier to start writing tests.

And, anyway, nobody should need to use this identifier for anything else.

Thus add it to the prelude.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/kunit.rs   | 3 +--
 rust/kernel/prelude.rs | 2 +-
 rust/macros/lib.rs     | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index f43e3ed460c2..053a7da147d5 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -6,6 +6,7 @@
 //!
 //! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
 
+use crate::prelude::*;
 use core::{ffi::c_void, fmt};
 
 /// Prints a KUnit error-level message.
@@ -40,8 +41,6 @@ pub fn info(args: fmt::Arguments<'_>) {
     }
 }
 
-use macros::kunit_tests;
-
 /// Asserts that a boolean expression is `true` at runtime.
 ///
 /// Public but hidden since it should only be used from generated tests.
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index baa774a351ce..e5d61a83952f 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -17,7 +17,7 @@
 pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
 
 #[doc(no_inline)]
-pub use macros::{export, module, vtable};
+pub use macros::{export, kunit_tests, module, vtable};
 
 pub use pin_init::{init, pin_data, pin_init, pinned_drop, InPlaceWrite, Init, PinInit, Zeroable};
 
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 8bd7906276be..8b8d46e759d4 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -406,7 +406,7 @@ pub fn paste(input: TokenStream) -> TokenStream {
 /// # Examples
 ///
 /// ```ignore
-/// # use macros::kunit_tests;
+/// # use kernel::prelude::*;
 /// #[kunit_tests(kunit_test_suit_name)]
 /// mod tests {
 ///     #[test]
-- 
2.49.0


