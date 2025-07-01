Return-Path: <linux-kselftest+bounces-36144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D853AEEDB8
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F99F1BC28C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B40820C009;
	Tue,  1 Jul 2025 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="TafVrYzf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1AA1F8753;
	Tue,  1 Jul 2025 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348200; cv=none; b=fHLRaIhK7cMUMqKbBUezK16aHf0m/4opmuEKVzBG1RC/OCK0ohOARv05PwA9UTYSPHoexL4VoPPQsLdrmzJ9T5DIzlvVV9ZWLfK72XotgDdB4OPbBuywJQp23p3Ua4jvUimyxSzFirjHgmzDYXW07zEcwreFw9Jd0rljls4Up0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348200; c=relaxed/simple;
	bh=DlQdZ+tKxr2mrZ0rbdKHurSPk85XG411g8Jq+IVgsOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhf7iEdiXQYjZwDxxNcQ4gqRqsqniGJaw57usxWnAcoiNmnGXaoWuvWCvXU5Nmhns3VFLEZmbsjRJJRCcLj4gMq/JSwMHCUA6ixc+zqzg41VVW1KclFF1s6KeNw8ibi63pWXK/HqYYTXrNc2mAVUB9ytunjMD4+3Q11EkOZH2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=TafVrYzf; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2f3c:0:640:5ff5:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 8844B60B52;
	Tue,  1 Jul 2025 08:36:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6aSk1O9Lw4Y0-5nNzaaUb;
	Tue, 01 Jul 2025 08:36:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751348196;
	bh=DlQdZ+tKxr2mrZ0rbdKHurSPk85XG411g8Jq+IVgsOc=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=TafVrYzf7ghMvfbJ0L4pTQER77oEf0SCoMteGufwb9wk2AhdeH7r5713694Wg/FcN
	 fuvEOrE2AITwu9/8E1eRIR6mLCgUwIphPsb/KoFMP4SDkB0VMckvLrS6X/fVRleYNl
	 dsgYgfFsmguGuGZmJdJwYEn0OYV81phhn1w3PfHE=
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
Subject: [PATCH v4 6/6] rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`
Date: Tue,  1 Jul 2025 08:35:57 +0300
Message-ID: <20250701053557.20859-7-work@onurozkan.dev>
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

Just like how we did in [1], we no longer need this lint
as it's no longer part of Clippy's `suspicious` lint group.

Link: https://github.com/torvalds/linux/commit/5e7c9b84ad08cc7a41b2ddbbbaccb60057da3860 [1]

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


