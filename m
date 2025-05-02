Return-Path: <linux-kselftest+bounces-32168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992AAA711E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3210189C956
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C102505D2;
	Fri,  2 May 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jQGaOsIs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vPaNF++h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C922A7E2;
	Fri,  2 May 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187440; cv=none; b=nZ5jwBWqrlyqsw4Fx+Jl/yvTSuMObf+Iq7CvRZoRKbjMt+PYIAEOv5ny99Dtqk/DWTb4njbZu/gpihrZIsqjxgJlFaoZMgsfm3FGkybdYBcFpS7nKzhOPHIN8ei37ot42IDdAJhLJ/lo2VK5zJ9Yr2wuoYei0XwKnM43LVxPLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187440; c=relaxed/simple;
	bh=Le/SWYfSH/kGVW6ptZ6Ul3m1kirAQHpQ9706grwfzos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CiDqswUTZSx7tBeQ1bLKs/OLUSyaqhCYIrpwuNKv8njrvNLuwmLrImMQAG+fnr5KKSgt3XWGrqiubI6YKPuknR12uyzuUmdJrL/PZGgFWX+ih5Mq7KFx1Vq38p0dpz4FEpjtpL8HhqBmUYb1c9GPbQBIVf+eSTnn2dCxf8R/FZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jQGaOsIs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vPaNF++h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746187436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYTGSftcl8LW2JMow7gIBVI+Bpm0vOk2cjj2v4azH3g=;
	b=jQGaOsIsiBOkcRg4UG6HX9UnWzqQIrfbc/z4jMp6IqTLuFxnDKoGp7O0zcb4Wc3Hk14uI1
	kyHOC/rDYpEbWZsNh/Svx9SpQIYYbMuQuJygh9/fVBjKDxHrwxQktseUlrWSmBUzIo97Qx
	EEia77oIV1loKcWRlWvmOiSmvclR2EdCi4DTNJ4ZuncJgWMFc4Qt2RKpLOimg2vCoaXwXP
	RNzJwMhFnbuVZWIMcqflFjz2gLrkVp65hnLH0Hj6c7xAibWAZt43oIzvcpM/iuflQzoyuk
	gONr+3vs6cjJqk0PAKVau15GV5i+gRQfgxBarRcNeJGO5CuhAE2NMqkY0SorYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746187436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYTGSftcl8LW2JMow7gIBVI+Bpm0vOk2cjj2v4azH3g=;
	b=vPaNF++hoS1PuCiadUgbmSt2EYIuBu9S9ohJXSsWjSWvVL6l0AuSFZJbh32qdpayiUz0y4
	pD27Xcu6sJX5RHBQ==
Date: Fri, 02 May 2025 14:03:52 +0200
Subject: [PATCH 3/3] selftests/timens: timerfd: Use correct clockid type in
 tclock_gettime()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250502-selftests-timens-fixes-v1-3-fb517c76f04d@linutronix.de>
References: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
In-Reply-To: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746187432; l=922;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Le/SWYfSH/kGVW6ptZ6Ul3m1kirAQHpQ9706grwfzos=;
 b=HRwQibpE+GRGuZVKtTBA0HC7+AxCAVTQ7kv7CeLNC77gyUXxmcCtj7RHXJJE8QGlva9X+afVV
 UyAS3nh7wIHBW+M0ZL5IRcDBfvQl5iComI373j4grX/4OfouLu45L9R
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

tclock_gettime() is a wrapper around clock_gettime().
The first parameter of clock_gettime() is of type "clockid_t",
not "clock_t".

Use the correct type instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/timens/timerfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index d6adf66bd8df064f5b76ccc265c13217d7a53f5b..402e2e4155450d946796b8297a8be85f93cea16f 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -15,7 +15,7 @@
 #include "log.h"
 #include "timens.h"
 
-static int tclock_gettime(clock_t clockid, struct timespec *now)
+static int tclock_gettime(clockid_t clockid, struct timespec *now)
 {
 	if (clockid == CLOCK_BOOTTIME_ALARM)
 		clockid = CLOCK_BOOTTIME;

-- 
2.49.0


