Return-Path: <linux-kselftest+bounces-36025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DFEAEC4C7
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 06:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278BD4A604A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 04:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFA421E0BE;
	Sat, 28 Jun 2025 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Gcg8clb/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B9E1F1905;
	Sat, 28 Jun 2025 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751083835; cv=none; b=j9bM3R1JiygnfHxYt/itl9qNGU5ARwa7RdffJKDPc/Sfim7YMhEDC22+Z+/SeEX2uJFXDJ78rolXeooqGImfyYFf7NTQ8xr/+ZFfBV5Vnk4Mhqz3sy7QUU9RgpigWEmyDV+/MuY9/UldGHzRBYDj55L6M6nIaNuRcfb1V8JkNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751083835; c=relaxed/simple;
	bh=5jNHxYiPINqgM7TZSD4XvG1CJYs9BSX4iWIo7g+ug3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uep08PHiz/duvJyFRdsSgFJV9jaYS4+ucBdGgl0/xNoBvpooe9D6RHEVwtITmHhBY+X35KwfiqLL+qosD72T8qxEXFF9zbkiBaOP85vRqR+Mi38Y8+0NkamAR8zMN5mBDUzM0naFg0i4wSEVRmRYErYjIgfzHtgKemo2w1VVygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Gcg8clb/; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:623d:0:640:ecee:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 95FB346D0B;
	Sat, 28 Jun 2025 07:10:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id w9OeTYGL2iE0-EekBB0WJ;
	Sat, 28 Jun 2025 07:10:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751083825;
	bh=ry/nljdjBuoojwts/DOYg5GF1XJZ/JGUBkyIcJh8zZo=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=Gcg8clb/vGIe/LEr6mX5P0AP9WabVIb3OzlxX04CzkHu7qONVRbhI0UYM+iJ754jt
	 fnQb/4vtuemiss/GQYJDRQeIZOGzPenNcLHCfKa4BwHu9wwbOb2P4jplxM381GfAsW
	 c0jm/xcdISgF7ihUvEvlcZK+32/eAXgrRLvZsV0A=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
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
Subject: [PATCH v3 2/3] rust: remove `#[allow(clippy::unnecessary_cast)]`
Date: Sat, 28 Jun 2025 07:09:55 +0300
Message-ID: <20250628040956.2181-3-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250628040956.2181-1-work@onurozkan.dev>
References: <20250628040956.2181-1-work@onurozkan.dev>
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


