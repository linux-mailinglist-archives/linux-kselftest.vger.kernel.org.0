Return-Path: <linux-kselftest+bounces-30214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE20BA7D4BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B43188C730
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3722DFFA;
	Mon,  7 Apr 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mkb5WT+Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QZWUTXSj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04A22D7B2;
	Mon,  7 Apr 2025 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008800; cv=none; b=DZwFg3q+ligmlmmstwqA7DNrTZHsg1c61RNSEEh2HFuZyDiXxUefPs/V6FWY3C3NlqQg9wYg436VCtwNRgbCqBO7ZDpSAiia/En6u+Vo2Qfx3y4mCtXwPiRKwME9YMApL5hVHz2l/0WxSdjThf1l1TWCVuK2/gH0J7ujWw046GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008800; c=relaxed/simple;
	bh=1m4pGrKjarsVyBk2sHbIz0kz1QLrAgcqnYe0JpUbZkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lH+RFSbNrOTijuHU66lRgzovl95GpHi7q6GvS8RKk1NTDlAPk9qQ9/RazNsVudG1XJcsq99lEm1oIZHds5GAp0U9xWnzHoRiwgLima7a9n8OZmqXeJadeN61BlQQz11FQmVcdOA2ClSQVj9VvZUGlUFy55SyHQfacEzwTb6J5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mkb5WT+Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QZWUTXSj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hGEGPrYAeGEEY4KfXy0LyZoEFXiYSsEkS/Ru5j/+Io=;
	b=Mkb5WT+YUXsT/8FtcHbecxTApa0LVrVumSyNF2ddzkoDb6a76Rqms1Ow/ee1RZjkkS+16K
	u6Yuk23PdLEWsYsj2NfrFboHJHncaAR+gLnjlvcoFSv80vLBhIHQN335zzdCvSGOOWextH
	p7GD1FYakO6AsMlZCWf4snM5GYaGiswMvyRZXkjR8hUiOQARfl2G4PC6gJApRyKYNf1MGh
	+ttf8h4OzWdHupbGYWNyCYPm6jA40U2fL18S61XNw5L9L7q2YCf/o2N1fbArEk8AmzcnU5
	im4fjC1zoBCKMenCdUQzuON/w3kHkW+wiOgizJtLI8JNSj4RATcg0P2NlnGjYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hGEGPrYAeGEEY4KfXy0LyZoEFXiYSsEkS/Ru5j/+Io=;
	b=QZWUTXSj1lfBXo5lr71SoE9ResbdyhCYHc0UahaVHh3rWVoE/wSj6uBKtR/apJvLTvRjzD
	fz1vKkZdRc0ap2Bw==
Date: Mon, 07 Apr 2025 08:52:52 +0200
Subject: [PATCH v2 29/32] selftests/nolibc: rename vfprintf test suite
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-29-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1295;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1m4pGrKjarsVyBk2sHbIz0kz1QLrAgcqnYe0JpUbZkA=;
 b=jK4ZmALcMJeh5JmuULzDop3M2vDXEc2vzdzs7aK+yBMOlg+bb4hg5LRVK6XDmm1oSLKmfhLXe
 GEaC/2qMZQADrB8p5eTQzPIgK1CmR2KtkNFvsYupfMWTzRfBg4nUvlK
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With the addition of snprintf() and its usage in nolibc-test, the name of
the "vfprintf" test suite is not accurate anymore.

Rename the suite to be more generic.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 8fb241af33cbba2ceb1303bf41582d51f70df68e..6dfa94df37547dae46ab19195a763fe22b065bab 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1390,7 +1390,7 @@ static int test_scanf(void)
 	return 0;
 }
 
-static int run_vfprintf(int min, int max)
+static int run_printf(int min, int max)
 {
 	int test;
 	int ret = 0;
@@ -1551,7 +1551,7 @@ static const struct test test_names[] = {
 	{ .name = "startup",    .func = run_startup    },
 	{ .name = "syscall",    .func = run_syscall    },
 	{ .name = "stdlib",     .func = run_stdlib     },
-	{ .name = "vfprintf",   .func = run_vfprintf   },
+	{ .name = "printf",     .func = run_printf     },
 	{ .name = "protection", .func = run_protection },
 	{ 0 }
 };

-- 
2.49.0


