Return-Path: <linux-kselftest+bounces-32169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C5AA711F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EC13A8D17
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28903251782;
	Fri,  2 May 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8A29vJL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="04+ZMncK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2A23E34D;
	Fri,  2 May 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187440; cv=none; b=Nq2I5wvKKRXp8EJfDqIi2BOsFWl5+W2AvFGAbMHwKVvH21a51rb35AhXlSndDGLB1Arf8uDE3Jwpv3kn1QiowKkl+FwnGvbbmTsrmHWc4MfOoCXKYqYtZMDXqcFURhVmHcNGWDL0pIfzbfl+6n7EQZYbSLHqLPPj9CdbzkrcgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187440; c=relaxed/simple;
	bh=bKYg1D2ylPp8HO3cA0WaB8pof/yiIbtfXjk7xmZzDzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryn6MRpWe17sirRK4VPB3twMBIUTAVceenhHrUuBlr8/eUwJVSPzK7XrVSmkaAWjMqQ7F9BzHPlNDUd4uzkUsEiKT33Wxg6cK0sCqvfyUEycKXvTwe4s5yog2ij1M9qpwftpWIrJyr1bJzm/bRLLu+jqma7GbaeiVbrX3gQSD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8A29vJL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=04+ZMncK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746187436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edZd0kV0+koCw8lYbVPKuVCGx2sjEO4QeAvt2CTLOrU=;
	b=t8A29vJLeAWrPpm9+cfpaWTxuj2SLMXDJ7Murig9t8TeUBbaD6oshjELh0ZYmNBcsL53mj
	QwA6lPkzuHhZqjL1lZQhthON+jWdTeB0LolIXsjibl+5ZNpF7xa4hJtLCc0vzf2l3ell59
	LHaMQWNzCsRRAZrleQvC1MfmpOqO/rjUN9leLUTQlzUGETHEEbuVYcaCiTEnDtbr+3/G6c
	Vji6yKHaSwId3VZTrIFkhAbtFTLZJz89CNdgXqJiQq+/D7QhrzXz52sLwrJ+hQ1kT6HErr
	VZFiwQiqff54x+rpkEdnoG7qPfB4quoCbJ8eLUFtvwUIPMoBXzN7eVC0Kd03cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746187436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edZd0kV0+koCw8lYbVPKuVCGx2sjEO4QeAvt2CTLOrU=;
	b=04+ZMncK9KnkTzlHbZheAQFHNfvK5VBdEoaUd1v2MiA3C8ozyupeT8+R5raT1MzGQG8pPi
	dKaX5n6SLEh7fNDg==
Date: Fri, 02 May 2025 14:03:51 +0200
Subject: [PATCH 2/3] selftests/timens: Make run_tests() functions static
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250502-selftests-timens-fixes-v1-2-fb517c76f04d@linutronix.de>
References: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
In-Reply-To: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746187432; l=2103;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=bKYg1D2ylPp8HO3cA0WaB8pof/yiIbtfXjk7xmZzDzc=;
 b=acb0eMtHrGWKZdR0oM4H8sgxr9Z4EI2aRm0mDmSEvKjsc1Mp7EKSbnWDGaaePhGz/FJjcDwIF
 s4OpwNiEjKyAJL1JGLaK1OQNQJCRHi12Pmmw9LgNqhEXAXlkDvTYdX6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These functions are never used outside their defining compilation unit and
can be made static.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/timens/clock_nanosleep.c | 2 +-
 tools/testing/selftests/timens/timer.c           | 2 +-
 tools/testing/selftests/timens/timerfd.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
index 346bff3d128dfa8c8c743cc2eba74917994bb2f7..5cc0010e85ff00e00c89940a82268994a1769873 100644
--- a/tools/testing/selftests/timens/clock_nanosleep.c
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -38,7 +38,7 @@ void *call_nanosleep(void *_args)
 	return NULL;
 }
 
-int run_test(int clockid, int abs)
+static int run_test(int clockid, int abs)
 {
 	struct timespec now = {}, rem;
 	struct thread_args args = { .now = &now, .rem = &rem, .clockid = clockid};
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 51babe63e233bdaaef35c1cafbcb5b5cc91c021e..79543ceb2c0f97fdd638271a762c97a8b19d9a4a 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -15,7 +15,7 @@
 #include "log.h"
 #include "timens.h"
 
-int run_test(int clockid, struct timespec now)
+static int run_test(int clockid, struct timespec now)
 {
 	struct itimerspec new_value;
 	long long elapsed;
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index e58bc8b64ce2738dccb8c2a2c88e592c237b55d5..d6adf66bd8df064f5b76ccc265c13217d7a53f5b 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -22,7 +22,7 @@ static int tclock_gettime(clock_t clockid, struct timespec *now)
 	return clock_gettime(clockid, now);
 }
 
-int run_test(int clockid, struct timespec now)
+static int run_test(int clockid, struct timespec now)
 {
 	struct itimerspec new_value;
 	long long elapsed;

-- 
2.49.0


