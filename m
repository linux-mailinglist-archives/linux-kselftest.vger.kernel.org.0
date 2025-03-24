Return-Path: <linux-kselftest+bounces-29645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FBBA6DC82
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 15:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6431C188A87F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938F25FA11;
	Mon, 24 Mar 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3XJJCaFd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wLfI4hnZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1925F7A4;
	Mon, 24 Mar 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825009; cv=none; b=H+kUHtw5E6D9jg1ksCrtIacpUh8yjQh3ZdSUN2cBBrl9pJ10yRqtwhE0Dgy7LIlUScXujgZkQXjXjyu/kEwLch3L8jrjN7fjzzaBX1QSTrY1UsXTMwBb6xKkSCWpeOPH17kb7ht6DzYI/onyTc7P3u9xduFKPfOhW3Kh/N5bYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825009; c=relaxed/simple;
	bh=aM4JcR3866WrCbYTHlk8iWIrMznIfA9/J8oATxvESHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SsFMGPzfMJ4FOvfsj/XJK2yKqqkjYlgwHV362gvygxmc/FKFBIBxkVSqY993ZRAh/fasg+LZCFG7fd66sCd2Nvqz/OK93YzNEGpFppN+3Qx4bIx94TwotMf/pTMz4jkUYe9IHkVE4hwh7Y35MgboDckubwn9w9m1EDYZEmOQ4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3XJJCaFd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wLfI4hnZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742825005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qj8y0TcZWBHDPwJrLqATbmFxejNYXTMZhfjNczSoSVE=;
	b=3XJJCaFdkXm+QYPX/vthk0TDjyeoYkhXlf3y8Dj9SdklN0EzhdHBgL/ato2AH7IefIaBpU
	YJSvkPOYzk8xoonUpKiVxuLWsnTTq1MIJlsCN3vdSW9vFC/M7PTNVHQH1lpf6pNlkHPbBw
	PcJrNCkxJvsW7UDiTThd+TS4cOVc2CICXfChBPC50hUjMkmwK3/o9vYpaJ+qmXcNrnVx2G
	PC5qkCg+YaSkuwb/oBawx+Oz2SqJ2m47tqD32tGwJ+57D8bNok2jpRt74PO4ts+rOv++Q5
	rIU9APdietC970maR5NbqaXpOlI8TCsaQGfBds5wSQfOi7odrq5JYs8nF0hTDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742825005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qj8y0TcZWBHDPwJrLqATbmFxejNYXTMZhfjNczSoSVE=;
	b=wLfI4hnZJg2uUCk87WAHgXKIA++xJA+AVboP+WaAOGoGzR/kF+DAsov+8ZGCH7CphXv4in
	Ru9NPQJdlzDjaACw==
Date: Mon, 24 Mar 2025 15:03:17 +0100
Subject: [PATCH 3/3] selftests: vDSO: chacha: Provide default definition of
 HWCAP_S390_VXRS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250324-s390-vdso-hwcap-v1-3-cb9ad001ceba@linutronix.de>
References: <20250324-s390-vdso-hwcap-v1-0-cb9ad001ceba@linutronix.de>
In-Reply-To: <20250324-s390-vdso-hwcap-v1-0-cb9ad001ceba@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742825002; l=1036;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aM4JcR3866WrCbYTHlk8iWIrMznIfA9/J8oATxvESHs=;
 b=viBYPTwPx1ECWXIR3TyrNZisIuV6STuzuZCaWmK1duWGrECRobn/tdn6COju7kd9AZlsQgpb0
 B55WnQz4kjrCNMaI9rAewd+r46UaNCicIe8E6GPEkgtGZIUmujeCXGe
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

s390 does not provide a hwcap.h UAPI header.

Add an inline definition for the constant HWCAP_S390_VXRS until a proper
UAPI header is introduced.

Fixes: 210860e7f733 ("selftests: vDSO: check cpu caps before running chacha test")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_chacha.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index fd5c5108b42f04ec459d39b74f33edc2ceafbba1..0ce5189718ce35b0a4d69b71559db8379b598b93 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -19,6 +19,9 @@ static bool cpu_has_capabilities(void)
 	return getauxval(AT_HWCAP) & HWCAP_ASIMD;
 }
 #elif defined(__s390x__)
+#ifndef HWCAP_S390_VXRS
+#define HWCAP_S390_VXRS	(1 << 11)
+#endif
 static bool cpu_has_capabilities(void)
 {
 	return getauxval(AT_HWCAP) & HWCAP_S390_VXRS;

-- 
2.48.1


