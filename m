Return-Path: <linux-kselftest+bounces-35850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34C5AE9ACE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 12:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D3C4E0974
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E19223DE9;
	Thu, 26 Jun 2025 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Z4gyJwgj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D8221FD2;
	Thu, 26 Jun 2025 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932367; cv=none; b=odzwAFGp3uj0KSKTZcjAihp7hDMMB0dbE8pX52D41sqpJef/sPogipCdzGIdUMtqAqPhiEOB6NLmgzP8IYE2LQkE8Jr5zelP0SsdBdBipUx8Lu0RpdZ/0XuI844KgyykVARBn7L9I1WPjt/dg8yIC3vjB06VghY1Wp0woDbTfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932367; c=relaxed/simple;
	bh=GJyOYBeBxAOaaQMlngdo/qAS2pBRzdCbDeXsTknGx4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDbkNaaR6dqAKZ+omX5Y55jA8Lakx3/aXpEO+C5M0ZQUPP7wyDjz0wJzgtMWFcWGJG0vMrGtyg3tXPiMqtiCTfmSbM7mpXUsjpFQDPWKWZeuVlSfGdnH/uQa/a32qfR32zPYsAMFSUY+6/KHshuZYaHjxae+gs6GnT9IK54ghqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Z4gyJwgj; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:299f:0:640:8fbe:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 9157D60B26;
	Thu, 26 Jun 2025 13:06:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id R5SeXwKLg8c0-J9H8A4Mi;
	Thu, 26 Jun 2025 13:06:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1750932362;
	bh=kqMshCxPmW4F8K7H4VL6x56CsNX+GRFgU1LhbTWjh9M=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Z4gyJwgjYAUli756zmvo2jRbrLkMVpzwlLO7EhKLDKm4EPGXCW7SAWDPk9sB4TpbY
	 S9bPtm1/3Lk7qF1ki07xwwwuuD15gNobC/mMxYK6+IPlXQ/lsq7ONnHJrweIpQZfP8
	 GI5g9qcCityQTziF7DjFoRc83njKOK3q71+cIasI=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org,
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
	onur-ozkan <work@onurozkan.dev>
Subject: [PATCH 2/2] rust: drop unnecessary lints caught by `#[expect(...)]`
Date: Thu, 26 Jun 2025 13:04:48 +0300
Message-ID: <20250626100448.27921-3-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250626100448.27921-1-work@onurozkan.dev>
References: <20250626100448.27921-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: onur-ozkan <work@onurozkan.dev>

They are no longer needed.

Signed-off-by: onur-ozkan <work@onurozkan.dev>
---
 rust/kernel/cpufreq.rs | 1 -
 rust/kernel/error.rs   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 7b20dff23a68..97de9b0573da 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -907,7 +907,6 @@ fn register_em(_policy: &mut Policy) {
 /// or CPUs, so it is safe to share it.
 unsafe impl<T: Driver> Sync for Registration<T> {}
 
-#[expect(clippy::non_send_fields_in_send_ty)]
 /// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any
 /// thread.
 unsafe impl<T: Driver> Send for Registration<T> {}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 1ff2d57c2f14..05c6e71c0afb 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -413,7 +413,6 @@ pub fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
         // SAFETY: The FFI function does not deref the pointer.
         let err = unsafe { bindings::PTR_ERR(const_ptr) };
 
-        #[expect(clippy::unnecessary_cast)]
         // CAST: If `IS_ERR()` returns `true`,
         // then `PTR_ERR()` is guaranteed to return a
         // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
-- 
2.50.0


