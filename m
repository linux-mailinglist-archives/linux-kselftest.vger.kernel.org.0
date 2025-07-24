Return-Path: <linux-kselftest+bounces-37912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99AEB10080
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0784E7745
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742A721B192;
	Thu, 24 Jul 2025 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1/z3drG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="USaVSV7S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1451EA7DF;
	Thu, 24 Jul 2025 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338438; cv=none; b=tId1mTKPd76xoO9tnCeXOQDQ/saFkrrIBPizr2YvXyFY0bWmfed2DVc88R0H2AupSdBBMCGT8f6yaJYnsJtn3vdhRJAgHY5+KELJFrOVDZTepOXY3GNyAQrYhjhSvAwBSn4qqRO5lqqYxBHQp+crC7/9UnE/NcWcxag96Vyu9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338438; c=relaxed/simple;
	bh=A2YNc0MwCxtVL2QJwYK0jWBU1Qh+09MjIWJv0XFIwVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bR2mtikYQRURicSQ2ZK5HN+9z0iZxUnqJPu0ft63IRzVQcYEgBX+B3yVbWfhKTEdSAQQFbd75VPfKo2dFW35NIws1EdaNe/vlsljYiUOW+OaLq1TK5+NRgTbryARiVJrmyqvRZKeHtkVDx9ar4st7oD+TKQvSCM2rB+Rmn/RRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1/z3drG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=USaVSV7S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753338434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0YJNOPK2tBNibBCGd9a6FHp1U2Oqwk6iytj2eWY/Z0=;
	b=j1/z3drGXsE3OdO/fwBYWE4cBsABOrd0yEsK+kiXNvvQeVS0elY5C0eRvN/lgXeuzwujpH
	65vL7qm9kHSd4fbkxRdDgAMYcqk6j48ZQSc2q6pLDOKHC0Ut1OPNskqQWZGIpIo0f1VBo2
	AZ0RECE1e1fOTYS3vyDprVjxvS+/XisDFIAm8O6l8WYuyS0I23vkGUfcQRf7hnI6Tr7s2C
	oZtYNz6+DeUIO7xjjF0F9p5MOsYjCA7iKcg7yeqRDQEkbMpeX259UTeAdLfzL9pgGrSfXO
	qtR6C3D1czjSSf82srv5TZsu+YTwi9mZcN+9zfeZN7xh6IQxC/E0fZojdvUzCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753338434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0YJNOPK2tBNibBCGd9a6FHp1U2Oqwk6iytj2eWY/Z0=;
	b=USaVSV7Ss3ymG8DDWMytF7iwTN8Vk/bXvwgccgKo64qRhkp1ze1cPHnqLHcCTmab0Y79cz
	/63T/QM7U4AJgIAg==
Date: Thu, 24 Jul 2025 08:26:51 +0200
Subject: [PATCH RFC 01/14] vdso: add struct __kernel_old_timeval forward
 declaration to gettime.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-vdso-sparc64-generic-2-v1-1-e376a3bd24d1@linutronix.de>
References: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
In-Reply-To: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753338429; l=817;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=A2YNc0MwCxtVL2QJwYK0jWBU1Qh+09MjIWJv0XFIwVo=;
 b=ULQFgWPakPa4uW+z+iM0TFkS3g7vhBbeq5Gm3Dh69MnYS/MqZZGYk/Ev3nEiHCVCE85An98Sy
 o6exw8dXsbiCCm8J0aHfQ/TF9/B2kPXP0RaWtg+7043SLUNdXXW/fly
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The prototype of __vdso_gettimeofday() uses this struct.
However gettime.h's own includes do not provide a definition for it.

Add a forward declaration, similar to other used structs.

Fixes: 42874e4eb35b ("arch: vdso: consolidate gettime prototypes")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/gettime.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/gettime.h b/include/vdso/gettime.h
index c50d152e7b3e0670ea87cb51452c0a03b98403a0..9ac161866653a01c2a54702cb72fe5bda488ee2c 100644
--- a/include/vdso/gettime.h
+++ b/include/vdso/gettime.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 
 struct __kernel_timespec;
+struct __kernel_old_timeval;
 struct timezone;
 
 #if !defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)

-- 
2.50.1


