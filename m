Return-Path: <linux-kselftest+bounces-45303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B0EC4D2E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2259334F9AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5435504E;
	Tue, 11 Nov 2025 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nfodT/Ws";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KBxkZoJA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7C354AE1;
	Tue, 11 Nov 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858207; cv=none; b=g5BCowh6W4i4PKSG9MtOXyYbslSB7fEKy6NhWjJy5aij/ds/G9u47pMYzu25pRguxV7YLGVbxMzBrtcUr6+pXZCG82U/2s4IhTTm26RmmyjWeTQI05/+u6SFj0bdRnd/pYstRJ5dxAU0iKGwxaI770qJYFSK37vdZbCHPMZ/FZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858207; c=relaxed/simple;
	bh=eDYIfI87JtASKFq5DZDwOQRcnHRn2lkznxw3yqxmbZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZT+xgn3yv5VMVEzTu7LxH9T78UFeUZszo4jHBy2JRpTLJy/hCLWVzaObRHLtBKqj6I6Xr0gNPjy4WINWmd/ynZpzuA3tNFZdmDQLPUM1yrfOi/7SLGWfzCNppgizq2Q5AwepMyGe7ujQTCxlmXHiBZIXNH4M08D7WH5SLY+gpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nfodT/Ws; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KBxkZoJA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762858203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSfAUOk1ZvIB9pdyoAnLsCO05GQqSiGT56a4QjuGta8=;
	b=nfodT/Wsb3CPO6RRF4ESRNU3K4f0yIepPn+8c+nCHPvchMITYvn4oNAOotr0Z1/e07GmnL
	Oy307wJrW20aYpR56NEagbp1sHzVaUzkMS0Wr3PUn/zqVDwM1FJHL7ecbgL7IFDaRxiYXZ
	4ayAZQDebItP3i+ZBP/3IVtwaojeSSeEkPS5Jfgqzb45mccihoWl4m1tdV1sy8O1k2KvLG
	lfCSLLsh3Ck+AclxbzR9YaoB/E9GBl13rhkoLQ7nc3PzWZepTmHFtWg1dn4BpVd+8cLjDG
	ZOXR8pJqm8MqmeG0Go2Eq1WM+krRTZR9LI9pwXnl8nO32AivMidgSYb3TuHkDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762858203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSfAUOk1ZvIB9pdyoAnLsCO05GQqSiGT56a4QjuGta8=;
	b=KBxkZoJAk6ru88kdsZUkDPZZtixPcPLi/aO6ZfWs42YzQjXObIUE0A2XMgtGrwMbTqKC0g
	R6XCa5Y9d6I5TODw==
Date: Tue, 11 Nov 2025 11:49:55 +0100
Subject: [PATCH 09/10] selftests: vDSO: vdso_test_correctness: Provide
 compatibility with 32-bit musl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251111-vdso-test-types-v1-9-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
In-Reply-To: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762858197; l=1419;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=eDYIfI87JtASKFq5DZDwOQRcnHRn2lkznxw3yqxmbZk=;
 b=IcCRhHV57188lxxjMd2rGBSFLt/GGQSGuNU9TF29c1zxSy1cQEEhdYBPs1egggYdCQXnjr6SN
 KT7cV9iGDC1BsAncPXBdJ0k4K8PekJavoCV8p57niq5IrRBLHTDc2j7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The 32-bit time variants on musl have different names, provide fallbacks.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_correctness.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 77bd77c32456617fc1ee240aebce57cf5b1cf89d..b27c28cd00a2b974751dffae850f34517ada094d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -133,7 +133,11 @@ static long sys_getcpu(unsigned * cpu, unsigned * node,
 
 static inline int sys_clock_gettime(__kernel_clockid_t id, struct __kernel_old_timespec *ts)
 {
+#ifdef __NR_clock_gettime
 	return syscall(__NR_clock_gettime, id, ts);
+#else
+	return syscall(__NR_clock_gettime32, id, ts);
+#endif
 }
 
 static inline int sys_clock_gettime64(__kernel_clockid_t id, struct __kernel_timespec *ts)
@@ -143,7 +147,11 @@ static inline int sys_clock_gettime64(__kernel_clockid_t id, struct __kernel_tim
 
 static inline int sys_gettimeofday(struct __kernel_old_timeval *tv, struct kernel_timezone *tz)
 {
+#ifdef __NR_gettimeofday
 	return syscall(__NR_gettimeofday, tv, tz);
+#else
+	return syscall(__NR_gettimeofday_time32, tv, tz);
+#endif
 }
 
 static void test_getcpu(void)

-- 
2.51.0


