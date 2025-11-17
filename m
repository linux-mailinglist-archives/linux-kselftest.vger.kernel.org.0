Return-Path: <linux-kselftest+bounces-45723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7247C62D98
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 09:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BA5C4E551D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9052630DD22;
	Mon, 17 Nov 2025 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd+UuJ5o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C263257854;
	Mon, 17 Nov 2025 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763366855; cv=none; b=emV9tS2SNga/nDzU/2UhXtLyzc/Urgv1rdcylf4RicKcX2LGhTBv3dCgyb+o5F5K7w+22eGuZ+orREC3V9bEgeWDUCDXAkcLG8oBw4z6o5Yn+uR1eZOATOCmrkapPlkf5X2iH/0D0OycVcpDpYlwN07VlfJ6rf2DA/Ci7OiCSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763366855; c=relaxed/simple;
	bh=0Y5joTHEG/T4wEe9HK5MTUHfE2O5S+RqR6z9Pchq/hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZ0iAT0jFXsUykfrrcOY4GniwDEpou2m/0DJHte6TqWoJfhs+YOGzbnyZRirjcHs32N8CJEvsnKReK4Hs6XeAyZfNr8u8cqmH9hvo9q1BOIStrD7qK2WxcTm7vjJqxjqy+LQNgNgIWullE98BHfA2Eum4dkHRwUJ6Yfg6SwV2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd+UuJ5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C67BC19423;
	Mon, 17 Nov 2025 08:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763366854;
	bh=0Y5joTHEG/T4wEe9HK5MTUHfE2O5S+RqR6z9Pchq/hY=;
	h=From:To:Cc:Subject:Date:From;
	b=Dd+UuJ5oxIfrTXcwJ2PAegOpNUSgHq8wDM4fcFWSpND6r873Yo5wV1XjrVT9c4Kpf
	 NkbpMlahDDwsjoYnXrIg2KIg6Ws6Gk4gLV6nxrWLokj/2u31JLC91YDRLiAVZI233J
	 sOEdlZ86xfJlNlFgULl+O1PMuYWasyyPTWkouLegKA1nTMaR8Z7m0HMYPWYwJ3pwHt
	 c+GDyHOFqviQEz9OJFyoqYb8URptVzAICJEa3711Rr6BszfOEXfwuGTnKAcAAAanV0
	 zj9sM2LGj3OqDXInD7dzC65m0BDweA0doYsroJTdRZsOw29v4K7Br42o7NJS8YUEPm
	 M2vp0mYgPCLAw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>
Cc: rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] rust: allow `clippy::disallowed_names` for doctests
Date: Mon, 17 Nov 2025 09:07:13 +0100
Message-ID: <20251117080714.876978-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Examples (i.e. doctests) may want to use names such as `foo`, thus the
`clippy::disallowed_names` lint gets in the way.

Thus allow it for all doctests.

In addition, remove it from the existing `expect`s we have in a few
doctests.

This does not mean that we should stop trying to find good names for
our examples, though.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/rust-for-linux/aRHSLChi5HYXW4-9@google.com/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/init.rs         | 3 +--
 rust/kernel/types.rs        | 1 -
 scripts/rustdoc_test_gen.rs | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index e476d81c1a27..899b9a962762 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -30,7 +30,7 @@
 //! ## General Examples
 //!
 //! ```rust
-//! # #![expect(clippy::disallowed_names, clippy::undocumented_unsafe_blocks)]
+//! # #![expect(clippy::undocumented_unsafe_blocks)]
 //! use kernel::types::Opaque;
 //! use pin_init::pin_init_from_closure;
 //!
@@ -67,7 +67,6 @@
 //! ```
 //!
 //! ```rust
-//! # #![expect(clippy::disallowed_names)]
 //! use kernel::{prelude::*, types::Opaque};
 //! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
 //! # mod bindings {
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 835824788506..9c5e7dbf1632 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -289,7 +289,6 @@ fn drop(&mut self) {
 /// # Examples
 ///
 /// ```
-/// # #![expect(clippy::disallowed_names)]
 /// use kernel::types::Opaque;
 /// # // Emulate a C struct binding which is from C, maybe uninitialized or not, only the C side
 /// # // knows.
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 0e6a0542d1bd..be0561049660 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -208,7 +208,7 @@ macro_rules! assert_eq {{
     #[allow(unused)]
     static __DOCTEST_ANCHOR: i32 = ::core::line!() as i32 + {body_offset} + 1;
     {{
-        #![allow(unreachable_pub)]
+        #![allow(unreachable_pub, clippy::disallowed_names)]
         {body}
         main();
     }}
-- 
2.51.2


