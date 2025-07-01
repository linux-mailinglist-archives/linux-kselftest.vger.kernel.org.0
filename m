Return-Path: <linux-kselftest+bounces-36143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA437AEEDB4
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C101F1BC2A4F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA119244671;
	Tue,  1 Jul 2025 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="MIjsTkTC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91D221F37;
	Tue,  1 Jul 2025 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348193; cv=none; b=UEKC40YUOIVUzzGOuBsdov6vWeOZuPUenLNMvaWA3IYagwdjASMxLY9YIvOv143UOiHY7BGgTuRrAgW8sjNsWd0GrdfszOR4MXgqlDSYI+bcgRAO7jnPjlCR9enAunvZb4A8mMhpOGBdIydFfDmdJOgXtLG1HJGi+V/kr3xdHnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348193; c=relaxed/simple;
	bh=uAnU3kDp5eULh9YY0m4O2RAbhlB1sslSRQ44j/FLrBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo+f6lNQoSKrIgCW7AMlvYvBn3WYQ+g9uYU18zAptXiJ/RAsqyF4InpQBESf1eKArPs0sIX/g3pqgK6l7te8d1wwps8BemoM8hmMpa6XpFaKPpxV+W9LpchZ/FDf98/LuNILbVDW+glzH2cmDhIIR8R9XwPbe1JD2q+v+L1Xebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=MIjsTkTC; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2f3c:0:640:5ff5:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id A961860A78;
	Tue,  1 Jul 2025 08:36:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6aSk1O9Lw4Y0-plAPQCWS;
	Tue, 01 Jul 2025 08:36:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751348189;
	bh=pm/en0ZhUL0BgyJub87GJFGa1ribxd2XG0S8lpom2u0=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=MIjsTkTCDCjKX3QrRdPaFBQlNPTevzwkWwI/P0mKU877VgJ/Se5ZWPTTVtJyZYsa+
	 JuSCScKvINjAMNUpMwLuquV8ZwAPWEFLX1xNyjaN/oxZEKz95zdAT+T2jfjS590qLn
	 CvWEC1xfrD8hya+GobD0iRUpI3uMoIg1gY2VzoJk=
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
Subject: [PATCH v4 4/6] rust: switch to `#[expect(...)]` in devres, driver and ioctl
Date: Tue,  1 Jul 2025 08:35:55 +0300
Message-ID: <20250701053557.20859-5-work@onurozkan.dev>
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
 rust/kernel/devres.rs    | 2 +-
 rust/kernel/driver.rs    | 2 +-
 rust/kernel/drm/ioctl.rs | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 57502534d985..0e9510cf4625 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -157,7 +157,7 @@ fn remove_action(this: &Arc<Self>) -> bool {
         success
     }

-    #[allow(clippy::missing_safety_doc)]
+    #[expect(clippy::missing_safety_doc)]
     unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
         let ptr = ptr as *mut DevresInner<T>;
         // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index ec9166cedfa7..fc7bd65b01f1 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -168,7 +168,7 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
     }

     #[cfg(not(CONFIG_OF))]
-    #[allow(missing_docs)]
+    #[expect(missing_docs)]
     fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
         None
     }
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 445639404fb7..3ae8d2d8263f 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -9,28 +9,28 @@
 const BASE: u32 = uapi::DRM_IOCTL_BASE as u32;

 /// Construct a DRM ioctl number with no argument.
-#[allow(non_snake_case)]
+#[expect(non_snake_case)]
 #[inline(always)]
 pub const fn IO(nr: u32) -> u32 {
     ioctl::_IO(BASE, nr)
 }

 /// Construct a DRM ioctl number with a read-only argument.
-#[allow(non_snake_case)]
+#[expect(non_snake_case)]
 #[inline(always)]
 pub const fn IOR<T>(nr: u32) -> u32 {
     ioctl::_IOR::<T>(BASE, nr)
 }

 /// Construct a DRM ioctl number with a write-only argument.
-#[allow(non_snake_case)]
+#[expect(non_snake_case)]
 #[inline(always)]
 pub const fn IOW<T>(nr: u32) -> u32 {
     ioctl::_IOW::<T>(BASE, nr)
 }

 /// Construct a DRM ioctl number with a read-write argument.
-#[allow(non_snake_case)]
+#[expect(non_snake_case)]
 #[inline(always)]
 pub const fn IOWR<T>(nr: u32) -> u32 {
     ioctl::_IOWR::<T>(BASE, nr)
--
2.50.0


