Return-Path: <linux-kselftest+bounces-36141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C963AEEDB0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8BB440379
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59D022A7E2;
	Tue,  1 Jul 2025 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="bSfWsoCC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEDA47;
	Tue,  1 Jul 2025 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348191; cv=none; b=WZpBs2wV9qsMjhsqSF7e5sFt2UnX0LvuZjk5KzhE0mWHJ6/GH4kJeQGlXNycNGcmlra5xRpGXsgYgXsbAAyPZ2yF1kBrZC3Krzosy2pT8+MHbWVqNt5W5B6sLDde5+ZFk++8yobgG0EzMgvHj7Npkh4jGntlhqXES/swMCM9fBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348191; c=relaxed/simple;
	bh=+eIrbPhrMh0++e6kz5iSAOdM+z+t7Psr3bYkT3DkrO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5YI6yOFttKEbnN1tcW6G6z4x5y0k/BH2TVq78SYnUuucUuWvMxrMgFVbWZtOmz/cJUXcJwEp9y07gmvssKwKz24GzdsaVxDae9lTpho+NLODEtPKXQ1muq4TVAKHX94/hcuEwrwuRqYtpmh/6we0ttrGO2wEDReLDC5vtDXA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=bSfWsoCC; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2f3c:0:640:5ff5:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 29CAA60B26;
	Tue,  1 Jul 2025 08:36:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6aSk1O9Lw4Y0-O8ja4a0R;
	Tue, 01 Jul 2025 08:36:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751348178;
	bh=y+LAMmnFYTdz8jpbgDC1hzvn1qc57V9XPIM+KBbaED0=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=bSfWsoCCoApYmQOWQ88UCQqIYtJ2JlIT9ZInwoh5nrhzZADZOCpiZrCsKSevzh0Kc
	 vu20S9V1MqMvtHEZnnt19Sg2CzztAqCys92d6YxmGqOlMPYeILl5ZiWre4ILiuqwzj
	 j5lBtnmZt0Uy1Ml6EiMxppRjy0vTg8hpWxJL+3NE=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	gregkh@linuxfoundation.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	davidgow@google.com,
	nm@ti.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v4 1/6] rust: switch to `#[expect(...)]` in core modules
Date: Tue,  1 Jul 2025 08:35:52 +0300
Message-ID: <20250701053557.20859-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701053557.20859-1-work@onurozkan.dev>
References: <20250701053557.20859-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This makes it clear that the warning is expected not just
ignored, so we don't end up having various unnecessary
linting rules in the codebase.

Some parts of the codebase already use this approach, this
patch just applies it more broadly.

No functional changes.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/alloc/allocator_test.rs | 2 +-
 rust/kernel/error.rs                | 2 +-
 rust/kernel/types.rs                | 2 +-
 rust/macros/helpers.rs              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index d19c06ef0498..844197d7194e 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -7,7 +7,7 @@
 //! `Cmalloc` allocator within the `allocator_test` module and type alias all kernel allocators to
 //! `Cmalloc`. The `Cmalloc` allocator uses libc's `realloc()` function as allocator backend.

-#![allow(missing_docs)]
+#![expect(missing_docs)]

 use super::{flags::*, AllocError, Allocator, Flags};
 use core::alloc::Layout;
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 3dee3139fcd4..a59613918d4c 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -263,7 +263,7 @@ fn from(e: core::convert::Infallible) -> Error {
 /// [`samples/rust/rust_minimal.rs`]):
 ///
 /// ```
-/// # #[allow(clippy::single_match)]
+/// # #[expect(clippy::single_match)]
 /// fn example() -> Result {
 ///     let mut numbers = KVec::new();
 ///
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 22985b6f6982..a5d5a4737a41 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -600,5 +600,5 @@ pub enum Either<L, R> {
 /// constructed.
 ///
 /// [`NotThreadSafe`]: type@NotThreadSafe
-#[allow(non_upper_case_globals)]
+#[expect(non_upper_case_globals)]
 pub const NotThreadSafe: NotThreadSafe = PhantomData;
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index e2602be402c1..6fd1462ff01a 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -98,7 +98,7 @@ pub(crate) fn file() -> String {
     }

     #[cfg(CONFIG_RUSTC_HAS_SPAN_FILE)]
-    #[allow(clippy::incompatible_msrv)]
+    #[expect(clippy::incompatible_msrv)]
     {
         proc_macro::Span::call_site().file()
     }
--
2.50.0


