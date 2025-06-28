Return-Path: <linux-kselftest+bounces-36024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94523AEC4C5
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 06:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83C61C43AFF
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 04:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1737721D58C;
	Sat, 28 Jun 2025 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="GHbUrAZG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182D198A09;
	Sat, 28 Jun 2025 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751083834; cv=none; b=oPJznQIh9HvLhxcVzKn58dQQSkS0Y/dT+x20VUrsERZWKoPIbg1wMKxSCNVczvQk7Lrfh+INtsUMYnEFuayqDPdX4e7SlDOGlzAHMBrpXdb09GJx1Y4Cdahx3qSODoFOG5C3NxksNr4/x2RDuUYtTxwrjHlqIoQb40MQSpRMa5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751083834; c=relaxed/simple;
	bh=MHf2LFg84werqxYDZJfhmApfMPTrh5lfupXyN5hzHB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlLQssDJ9HrJzHp5X0oUriEO7OIwoRrGr7GPd+Z2FafI45kImzxI0otDGnBv/gTr8o5Rd8cTHk2IpZycBVVj4EYIcmEX/GLTB2qxCVpmD7nEtbC237+/KOX5vH9jqXk8ac89hG5KjqmgtUvYVZIYvDY+xF9ItajN4xEUCmKGqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=GHbUrAZG; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:623d:0:640:ecee:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id B848360A75;
	Sat, 28 Jun 2025 07:10:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id w9OeTYGL2iE0-wEEruX1y;
	Sat, 28 Jun 2025 07:10:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751083829;
	bh=MHf2LFg84werqxYDZJfhmApfMPTrh5lfupXyN5hzHB8=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=GHbUrAZGDm9qgkioODj+bY6jK80Gh5LgMq0CoOURuNdnzkzoty9FJhBluy56alMFo
	 re2yi/QbQYkk1XhDNoZJ6SoY9EZIPjoJCPSM6fArN7R0FdxEkqyNkHyNnlLLe4mA7z
	 XCHvLJriBg2BFre9gzd79EFZ4IZfNu1VE+LIqSYY=
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
Subject: [PATCH v3 3/3] rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`
Date: Sat, 28 Jun 2025 07:09:56 +0300
Message-ID: <20250628040956.2181-4-work@onurozkan.dev>
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

Clippy no longer complains about this lint.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/cpufreq.rs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 11b03e9d7e89..97de9b0573da 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -907,7 +907,6 @@ fn register_em(_policy: &mut Policy) {
 /// or CPUs, so it is safe to share it.
 unsafe impl<T: Driver> Sync for Registration<T> {}

-#[allow(clippy::non_send_fields_in_send_ty)]
 /// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any
 /// thread.
 unsafe impl<T: Driver> Send for Registration<T> {}
--
2.50.0


