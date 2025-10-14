Return-Path: <linux-kselftest+bounces-43093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630F4BD7B14
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AC43E4888
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6491B30F808;
	Tue, 14 Oct 2025 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uUTK5yjx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wBLcltCP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF22D12EB;
	Tue, 14 Oct 2025 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424565; cv=none; b=qWNVEDjNTHrcBMZZ6jcFpGHEDjN5sYZWigCjMHEq12yOROErLDr8OovLGVHlp05tsENMJkphXRY7/NIH8Luvgn9uvcy/7yx+pwP2RbFWbsdjhmxPB1h4lePokEWiQ7mlFS7/quQZpYINTzrrQ07dz4d1+4ZYgWRS6lGwAcRrE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424565; c=relaxed/simple;
	bh=2hSFMUISgDavbKKRu1atPOpNqM6l7sLyIWcWtFRLYDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMFaFXDuYV2c8ox6bUs+AQ/DA7tDN8BukZDL28LOPgW9IzqJyqbtKlCgnNXRPbqhCe2VH+q10XlEGEJVxADaqei8RHFpQcun01N2ri3L5ep8XoMN6IRqZpFvWtuhaubCnPCIMvgobRHyCEq1lYo/9rTwIpdH2AS6CyIQCf+N1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uUTK5yjx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wBLcltCP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3tGpR5SbTtmYH9/UhUB7FG7sTK6XysaxzCJ0fbVJv4=;
	b=uUTK5yjxYeHVCab4+mSk4CSyqeV7aL2+6VMhldMX8S/Yt+QEROo4AqkxxYXxMRu/B71SaK
	hfTjAvShOVSr5klbOKf8hAY83WiH0bA2MZsKsjDQCNn7gECyHdzwkZWFE+58L65dytwwB6
	Lh/WxrG+mJNgwMwX8I0Z8UWE76nKOrRNyMc8Pf2lpSJ6JnkR5CgHYsq4Cdtx2QMfRLcTGh
	1ZCzziRwzi3/0B/fwngL3rkbvu+kpBT9GyQr2Y5MEuYaVmRF6I/MfCWx5qTYKlm73RSkPf
	imXv08p4nL2iXi5/9MSNJlru3E3Tv+k6OLlsAXXcTV0z8ZNJLXyQtyvs/FWX4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3tGpR5SbTtmYH9/UhUB7FG7sTK6XysaxzCJ0fbVJv4=;
	b=wBLcltCPIWmQf+pZww9BCaRZLkV10mLosq/TzjJMbWnYGrT96VGtYrPRkUHHqmrqQtbqEh
	qZj3K8K/YyTDDyBA==
Date: Tue, 14 Oct 2025 08:49:06 +0200
Subject: [PATCH v4 20/35] s390/time: Set up vDSO datapage later
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-20-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=1384;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=2hSFMUISgDavbKKRu1atPOpNqM6l7sLyIWcWtFRLYDU=;
 b=fSCsg9SdQvcBY2ZNPU9EUfDTd+/VWdJRzU8b3Z2sJ0uqAUbt73DRMWmeTEMv4NqR3wqYMipML
 zeVuoiUC8X1BFPo6EGqZbGAX9qiRiM1vYrQKBG6d5+fnwLPTPFs9lD/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Upcoming changes to the generic vDSO library will mean that the vDSO
datapage will not yet be usable during time_early_init().

Move the initialization to time_init() which is called later. This is
valid as the value of tod_clock_base.tod only changes in stop_machine()
context and both time_init_early() and time_init() are called before
interrupts are enabled.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/s390/kernel/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 63517b85f4c930b799235c381d9d6b263fff5431..6b948b9e61fe674bbc842a0143dd35a26b91a860 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -78,8 +78,6 @@ void __init time_early_init(void)
 	struct ptff_qto qto;
 	struct ptff_qui qui;
 
-	vdso_k_time_data->arch_data.tod_delta = tod_clock_base.tod;
-
 	if (!test_facility(28))
 		return;
 
@@ -248,6 +246,8 @@ struct clocksource * __init clocksource_default_clock(void)
  */
 void __init time_init(void)
 {
+	vdso_k_time_data->arch_data.tod_delta = tod_clock_base.tod;
+
 	/* Reset time synchronization interfaces. */
 	stp_reset();
 

-- 
2.51.0


