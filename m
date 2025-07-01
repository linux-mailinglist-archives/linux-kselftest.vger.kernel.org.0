Return-Path: <linux-kselftest+bounces-36142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E27AEEDB2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB887A194B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED04241666;
	Tue,  1 Jul 2025 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Dlik2Jxw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E121CC5D;
	Tue,  1 Jul 2025 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348193; cv=none; b=mxjAGi/7F8xr8PVD3z4dTUdchTqnHfQ1zfgsTEK9Z0XkQNcR4IVvI8Co+n3jr6FI9kcPrzuRDanUTXx014yPdc3at4YMIkf+iGNZ4V/otxn+ZrU4FCFlFHerECFIfhO+kBjZ0tnhyw5pN0l23sGR5PtSDpCGGPx6i1bdjph/YiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348193; c=relaxed/simple;
	bh=vrPJWN941QVnpQ/d7LvVaOBwHEMzgQZ+babRIJu8FRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fjces62qlTcX9IBENjtnUM2bmOE8Il5Oj5XvegZkoUgDEYPt8c56e7iz825SUmCuhhnVZPH5bp5RcQmZsr9u9oLVndg559QwNG0ZeLmZkB6kAYxjap6grgQYEy3wXdEozjFHy58jd8jhZoz3r0MbAmwb4avW/v9hFyAMLGp69hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Dlik2Jxw; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2f3c:0:640:5ff5:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id CC1BB60D55;
	Tue,  1 Jul 2025 08:36:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6aSk1O9Lw4Y0-pYGl2S2K;
	Tue, 01 Jul 2025 08:36:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751348182;
	bh=Fu/EvnRcgzeSqzXsKWwb9gUgTOQaKWQ8C0GMLKqO88M=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=Dlik2Jxwp+xx0rQZbJ7/IiXcdzuBneu412xiV+Jx3/QOrGK2Ak+7+5ItER6Bnhgcz
	 bEKGqoLIzYWXQhtODA2h7Wdl9TylA1EtQl1L13xCoDyyDnEN+5JhoVxp83HjUCuhPv
	 IKaT1v0aHLCl7RmldGah7CfH/vXKQbaMxspqqrsM=
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
Subject: [PATCH v4 2/6] rust: switch to `#[expect(...)]` in init and kunit
Date: Tue,  1 Jul 2025 08:35:53 +0300
Message-ID: <20250701053557.20859-3-work@onurozkan.dev>
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
 rust/kernel/init.rs  | 6 +++---
 rust/kernel/kunit.rs | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 8d228c237954..288b1c2a290d 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -30,7 +30,7 @@
 //! ## General Examples
 //!
 //! ```rust,ignore
-//! # #![allow(clippy::disallowed_names)]
+//! # #![expect(clippy::disallowed_names)]
 //! use kernel::types::Opaque;
 //! use pin_init::pin_init_from_closure;
 //!
@@ -67,11 +67,11 @@
 //! ```
 //!
 //! ```rust,ignore
-//! # #![allow(unreachable_pub, clippy::disallowed_names)]
+//! # #![expect(unreachable_pub, clippy::disallowed_names)]
 //! use kernel::{prelude::*, types::Opaque};
 //! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
 //! # mod bindings {
-//! #     #![allow(non_camel_case_types)]
+//! #     #![expect(non_camel_case_types)]
 //! #     pub struct foo;
 //! #     pub unsafe fn init_foo(_ptr: *mut foo) {}
 //! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 4b8cdcb21e77..91710a1d7b87 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -280,7 +280,7 @@ macro_rules! kunit_unsafe_test_suite {
             static mut KUNIT_TEST_SUITE: ::kernel::bindings::kunit_suite =
                 ::kernel::bindings::kunit_suite {
                     name: KUNIT_TEST_SUITE_NAME,
-                    #[allow(unused_unsafe)]
+                    #[expect(unused_unsafe)]
                     // SAFETY: `$test_cases` is passed in by the user, and
                     // (as documented) must be valid for the lifetime of
                     // the suite (i.e., static).
--
2.50.0


