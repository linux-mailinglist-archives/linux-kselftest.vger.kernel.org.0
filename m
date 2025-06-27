Return-Path: <linux-kselftest+bounces-35952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CEBAEAF5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 08:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC13188568E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 06:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979E0221DB9;
	Fri, 27 Jun 2025 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="ddps08uT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB521D3CC;
	Fri, 27 Jun 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007303; cv=none; b=FuoUt1W91hT2hDdmsWe7BPosH+lLHjy0NgmZcr/Mum2fSpyWKyRhCHQDWmZrO1jSUPgpcoPqKx84ktgDOpkKYMNKuU3ZoBrQE+5TW7pkBM1O9Ib/UmxjtRUCwNLLKn80FIEaY6MijokXb2wVXJmk0J1ViHrRFkPqUzJ0e84ncFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007303; c=relaxed/simple;
	bh=5jNHxYiPINqgM7TZSD4XvG1CJYs9BSX4iWIo7g+ug3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edG4yjMblc3QZH4bWnQ1TN9L7alu0bAXEBYvgCOoDvMFePJGPVa3qWhclV5QTmHHhBVvQ5EZ65ARW2fImbsWEOITlXxaAbfX0vjj7oaWZNCShtCfgQnONb2d68wLaVddvXoJ8R0nEY9L94vB06GhATXMix2ZjX5WSdfZhkd77hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=ddps08uT; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2ea3:0:640:da3e:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 67D3960D56;
	Fri, 27 Jun 2025 09:54:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PsPIlP9LwSw0-30PUW0YP;
	Fri, 27 Jun 2025 09:54:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751007292;
	bh=ry/nljdjBuoojwts/DOYg5GF1XJZ/JGUBkyIcJh8zZo=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=ddps08uTBCP09eSC4n4fKqSw9gwwa9whkwZ2+r2vs3xRJa3djOaGCs+k0ZfslHT1f
	 WqGEpbVVJHEPKoi4RS+uptc9l0msnV8s3ASVNsLadBCeAu2d4NIJFIp3Mbuz4ZPns1
	 0egVE0dgDMhXQz3qqQZJio+kJczBWlqTF8U0kI1o=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
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
Subject: [PATCH v2 2/3] rust: remove `#[allow(clippy::unnecessary_cast)]`
Date: Fri, 27 Jun 2025 09:53:19 +0300
Message-ID: <20250627065320.9315-3-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627065320.9315-1-work@onurozkan.dev>
References: <20250627065320.9315-1-work@onurozkan.dev>
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


