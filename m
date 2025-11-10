Return-Path: <linux-kselftest+bounces-45218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F52FC46514
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 12:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEB5A4ECD11
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 11:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071E030BB94;
	Mon, 10 Nov 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPLAInXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EA30AD1F;
	Mon, 10 Nov 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774541; cv=none; b=iPMDB91UerKMTKHWkQi9h66bdxNhzEwgDd0Cb+CrRpSBOXHvSfOjxUM9Xkxc3OzdGr54lKF7jRF6QW7NbPjN0NNoeeMXh/KSUZHiakqyETTUG8eRdXUaV1mERnPFgeQf7p1TEaM0aPkcyk5cmeOhOV1CBp3dgMNVRdceSAu0blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774541; c=relaxed/simple;
	bh=Trw3VkOpFEcmS9Rt6F8pvQePozUV3ete57zjNzKHvuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLzEDK6qjSI8MqCOaMfvHtFEowg2yXCWmMfvCfVJkaL7bjb7YLQ1FwqGYRxrxHeY0TQ+hUjd8zNQfAD4wYGhWzFjGqR2+3rb+JCh56rejfVOH8SI0rEYegQUAf2C9mPHkVyHK1Rg0M23PugJw3ns7CewPmCigISslNEin0F/1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPLAInXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49CFC4CEF5;
	Mon, 10 Nov 2025 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762774541;
	bh=Trw3VkOpFEcmS9Rt6F8pvQePozUV3ete57zjNzKHvuQ=;
	h=From:To:Cc:Subject:Date:From;
	b=iPLAInXPZw/D61DVlxUjkvYqo6g/qe407waall6A6dN/96v9W29S3uVe3Jz4Z7lIx
	 eNiqPpbdkO8i3GjuF4rxmtr3dXy9XvHcJ9kLiUW2LzLPuX0ba2jGfij4S01WHP0AwL
	 OHLSqkjd2O4RfhkTYdCUKjGorF455/qKBA07U9YrZOuQcQnMPO92thPXMtyel3N7Aj
	 SJr0pXgbJH5GKJ84936xK9fweogKzSIfzT5A97GLwLqHPmoOKh1ITn7tC9X3RgIdkJ
	 zi6BrAcxJ9JA/RlGB7jj6YSrqRJoj4nt9m5SccUi5zi3To6k+NfEsjWzROPygk+oTf
	 EGTCegenCyzQw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 1/2] rust: allow `unreachable_pub` for doctests
Date: Mon, 10 Nov 2025 12:35:27 +0100
Message-ID: <20251110113528.1658238-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Examples (i.e. doctests) may want to show public items such as structs,
thus the `unreachable_pub` warning is not very helpful.

Thus allow it for all doctests.

In addition, remove it from the existing `expect`s we have in a couple
doctests.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/rust-for-linux/aRG9VjsaCjsvAwUn@google.com/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/init.rs         | 2 +-
 rust/kernel/types.rs        | 2 +-
 scripts/rustdoc_test_gen.rs | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 4949047af8d7..e476d81c1a27 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -67,7 +67,7 @@
 //! ```
 //!
 //! ```rust
-//! # #![expect(unreachable_pub, clippy::disallowed_names)]
+//! # #![expect(clippy::disallowed_names)]
 //! use kernel::{prelude::*, types::Opaque};
 //! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
 //! # mod bindings {
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index dc0a02f5c3cf..835824788506 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -289,7 +289,7 @@ fn drop(&mut self) {
 /// # Examples
 ///
 /// ```
-/// # #![expect(unreachable_pub, clippy::disallowed_names)]
+/// # #![expect(clippy::disallowed_names)]
 /// use kernel::types::Opaque;
 /// # // Emulate a C struct binding which is from C, maybe uninitialized or not, only the C side
 /// # // knows.
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index c8f9dc2ab976..0e6a0542d1bd 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -208,6 +208,7 @@ macro_rules! assert_eq {{
     #[allow(unused)]
     static __DOCTEST_ANCHOR: i32 = ::core::line!() as i32 + {body_offset} + 1;
     {{
+        #![allow(unreachable_pub)]
         {body}
         main();
     }}

base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.51.2


