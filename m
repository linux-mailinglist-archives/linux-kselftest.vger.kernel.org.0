Return-Path: <linux-kselftest+bounces-35951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A55EAEAF4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 08:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C50A1719AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 06:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECA0218ABA;
	Fri, 27 Jun 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="HkBIIXaG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BFE21B9C6;
	Fri, 27 Jun 2025 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007301; cv=none; b=uqlaJvCpIXbtsY5XABlqcAxz/005u8UcnpvUPF7BumF4dUgRZbthLQFvDZaXpLhNP5yJNrWe/IPCmyTpLVrG1wbRknWxOvQ2YvKE2C6apImeiVwcLPTLpN+5oun0xx1RlLqizzsnAQM5g9el4V2esL/Pb7mn0fSdGaEymCoC4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007301; c=relaxed/simple;
	bh=MHf2LFg84werqxYDZJfhmApfMPTrh5lfupXyN5hzHB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERgiiCpgvEJSqxsRg5JrcOoy9Cp/1JGw0j2yLfTj6KqZzMnLrgVroj/xW1bR1B2ZgB4mSBvXD0Ek8Vcsr3+uXK6Yd2mpPaQ6kgPhSZIBt9zmvqre2VwhPeTExJ61J+5M16QgAHWuoU5tjZuqCi7R3+njC88zwE7BtKz9XFuMkn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=HkBIIXaG; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2ea3:0:640:da3e:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 5407960A84;
	Fri, 27 Jun 2025 09:54:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PsPIlP9LwSw0-m2hF7xsP;
	Fri, 27 Jun 2025 09:54:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751007296;
	bh=MHf2LFg84werqxYDZJfhmApfMPTrh5lfupXyN5hzHB8=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=HkBIIXaGjNYuG7DZi/gmanqaauwujy8+HK4cyDosW8AZlSvmGpzV4cPP0DeaQqZKn
	 1FNUliEVdz5NMNiXx2orYtZK8YpKObhvLOCRZQPlN6lT60CU0RukmpRwy/GIW7fbCQ
	 slK5rt7Nfef8WWFKcDIB9p/xfa6uaSwI3/B6Xuak=
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
Subject: [PATCH v2 3/3] rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`
Date: Fri, 27 Jun 2025 09:53:20 +0300
Message-ID: <20250627065320.9315-4-work@onurozkan.dev>
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


