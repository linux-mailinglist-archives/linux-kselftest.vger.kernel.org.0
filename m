Return-Path: <linux-kselftest+bounces-45300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6EC4D3C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD6E3B6FB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A918335502C;
	Tue, 11 Nov 2025 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WfU01Wzm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T348zkGA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A495354AC5;
	Tue, 11 Nov 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858206; cv=none; b=rQEcE8jfzIsv7S3IkZfDgIB8DoteE334Mhv111pKDllxDaMaeTxA45TSjLAVl4RfEs+d3V2bNNR/CkPNEBiFC1MIRdFUMlXEU0TFJS/EoPI6bRrLUs6iwflCj6vZNCjhWBekK8VINZR7e7NdcImflBc7TsP/Z5Tno6EQsFAhhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858206; c=relaxed/simple;
	bh=IhZCZpYTEfcsIhUb1OvA+o2aZg+IqFDuCoJX9+mQwCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KfVhYLet0puU5F+3Viv2efRljKkCYR7PI2KzBwxNFC14DYVKj10OsnDGI+DVm1PoB1JQDL4JGtlqgmsL49kA67KD+alCjiPSxMaAGzgYteWmxwHgcfdo/Zfj5G70oq4bMtHc26xSf2pBDzkC3/4O19LtcrdR9CFKQkptItEsvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WfU01Wzm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T348zkGA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762858201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mBr7wG1x9Eu1Fb7Qvx7iJnYkPB3hiuiZVSG49/GyNg=;
	b=WfU01Wzmk8dpo431BaDYCaTV1EL3VOGQ76evwKijVL/Upb49txCvNceaDhRs/gW7re9y87
	ArKwOgfEXdhZ9zS2hQ8C3G0W6lC8FGtEkPrNU+Kay1dNvn+mvFTVHowg0sKEOqbWYEeAdL
	YXHa9hpuM1o4BI1G0gxQWqA4ilvx+/lNyjRw54ZI7m6L/ygRxSYIKN4a+/SueMyKHSiCJH
	WdyDyIZ7/y0l9QffCW3YwUCr4YHpoNc1LrpGaQ2cwaBiiBCz4Cf27KJ/h1tmaNwjl/STZf
	ps40MmB2AbRhRTf7hVhYgMzMImkyeviLy5SGhIoA7LXrqpq3hIBzDkWNX7hgKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762858201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mBr7wG1x9Eu1Fb7Qvx7iJnYkPB3hiuiZVSG49/GyNg=;
	b=T348zkGAlrXxJl/WRR54xuuvZzhy3V7QS+SiMtWKcO7s5n/o3rB/r2wn8lLebG/ethhC5j
	sotsISteaPedYlDg==
Date: Tue, 11 Nov 2025 11:49:51 +0100
Subject: [PATCH 05/10] selftests: vDSO: vdso_test_gettimeofday: Remove
 nolibc checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251111-vdso-test-types-v1-5-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
In-Reply-To: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762858197; l=778;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=IhZCZpYTEfcsIhUb1OvA+o2aZg+IqFDuCoJX9+mQwCg=;
 b=4a0qkz1c329rNTLWsQJt4rnjWgS+Gn5XRo9JZJ7wynRAbBnzpBwPXeKIapVeDZQtoCQQhQGDr
 UffzOJH3JzpAd0aluOcQEmNzaS7xzTorDbXe6rtzYw8lBdD8LGpgRln
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

nolibc now provides these headers, making the check unnecessary.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index 9ce795b806f0992b83cef78c7e16fac0e54750da..636a56ccf8e4e7943ca446fe3fad6897598ca77f 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -11,10 +11,8 @@
  */
 
 #include <stdio.h>
-#ifndef NOLIBC
 #include <sys/auxv.h>
 #include <sys/time.h>
-#endif
 
 #include "../kselftest.h"
 #include "parse_vdso.h"

-- 
2.51.0


