Return-Path: <linux-kselftest+bounces-36145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D97AEEDBC
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704BA3B186D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B025B1FC;
	Tue,  1 Jul 2025 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="UWHkH0fX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DDE25A631;
	Tue,  1 Jul 2025 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348203; cv=none; b=aPi/yCb5ptKfFiwJ1tIVPhCIp5qZOx2zMg9VUuOzvKfZfllSbgRohf1ezhNT17ANLFVBmQAj7uCaro0VgaUL810NMpt4Hw7eIqhNs/ZM7D1/JE6zbqd10uiRzTOfzzCY/0kHyWqLwGBVQkuWLpFah2AFvBfovn/8F84cV7t5aBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348203; c=relaxed/simple;
	bh=5jNHxYiPINqgM7TZSD4XvG1CJYs9BSX4iWIo7g+ug3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ab8eF0oyYrBBo+tDRMx8Q2Yx5CexR5y9433Nw0Ylg/z5/SGWt8AoCQAtiKb3GgFpRGGFYivosU+G4efQWst84l2eYwTW1XZXL22MgkjoE3w7Kote98ohoaNZISYWTAQfSx883d4kQOoj+Qbpxagh+r9V4LtcBs3891r0aC3tcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=UWHkH0fX; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2f3c:0:640:5ff5:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 591C560E90;
	Tue,  1 Jul 2025 08:36:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6aSk1O9Lw4Y0-1OE3Q5MK;
	Tue, 01 Jul 2025 08:36:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751348192;
	bh=ry/nljdjBuoojwts/DOYg5GF1XJZ/JGUBkyIcJh8zZo=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=UWHkH0fXVN3+tw31Ku6DMjgmpa4O7ffykpmPQclND3Raezz2+0vbkfPPJ/NwUiEUz
	 RMzm+tYNe76wq+isNP4tcpr1AfgVDMNnM7FgJ/4qTA+TXSwnj2cK26qVYvGpioDuGU
	 NiOnuGbJxam06BrRrjocCHMcV9ZKb+MZsD9h6E9A=
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
Subject: [PATCH v4 5/6] rust: remove `#[allow(clippy::unnecessary_cast)]`
Date: Tue,  1 Jul 2025 08:35:56 +0300
Message-ID: <20250701053557.20859-6-work@onurozkan.dev>
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

This isn't needed anymore since `kernel::ffi::c_int` type
is always `i32` which differs from `err` (isize).

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/error.rs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index a59613918d4c..05c6e71c0afb 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -413,7 +413,6 @@ pub fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
         // SAFETY: The FFI function does not deref the pointer.
         let err = unsafe { bindings::PTR_ERR(const_ptr) };

-        #[allow(clippy::unnecessary_cast)]
         // CAST: If `IS_ERR()` returns `true`,
         // then `PTR_ERR()` is guaranteed to return a
         // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
--
2.50.0


