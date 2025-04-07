Return-Path: <linux-kselftest+bounces-30188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C8DA7D48B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F55B3AC4D4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586FA225419;
	Mon,  7 Apr 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CWpeqjD9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iVY0muvJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A14218AC1;
	Mon,  7 Apr 2025 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008783; cv=none; b=eYwOl+h/vjQXtYwe5+BC/xdQfCf9NPaQ7MSQmEaHdCPVa9XZlO4tSdzUFMumDU6Q2rSULQLePauBVuhkqPWBf0dExZIOsGbdyEA4W5cOvrP5IQ8l9TsEM5WNnyQEdRtbxdCQKGeHMg+bQt0mrycD3MRLxDfagn4mIZnPjHJ0w0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008783; c=relaxed/simple;
	bh=jGKlKoofOPJIAZx1RxcX4p7LfMYOyHoN+Nx2/9d9seQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJvmNYkqpppfAd3vzn80zUFZ0S8B4yhCfbfgHzGDLe1iAGVbrbjEqyKtslibgok059T5a1zOrfSZYnpkP3J2M263rMABWbr2waQ4V+0ZPVoPCbyYNM+rDu73SAD4YiQBKTBCSg9jl9j9CZi7DZp1d+WYR22qAXpbbMm9ktJaYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CWpeqjD9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iVY0muvJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLj0ETsEs/I2mut8MoZZYVz5W4X+4bN5Q7Nlryt1VEQ=;
	b=CWpeqjD9Bp/CjmVDcAfS9JVG/V0nAppFVTKu5W3L+a4Kaa0jybvIpkSqqmIQ/iqeYwuqHq
	aE314RwRal/v22PFAoYHdTfEIW8UhC+BSxZCsVjyEKcIsoPQOMjqE6h1jHSzT8Gk1XYAAQ
	dg4fDKVfg3/khB884XTUQC8qfPbfkgxIe3tpgutQmPGtLUEbpQHiZcbB4lDLmwSNrQvpzn
	7dvp5/j1Pu2I4HVXoDYr947mdbip5TSD6xM+cmUSwZ0buocz0v7K404aaOjtvnnN3/DG/O
	8RWhnNffLYqO+Jvx5Mma8fNZo/PG2IiFYUx7mZkHrG1dIWTgBA8SburKVqLO+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLj0ETsEs/I2mut8MoZZYVz5W4X+4bN5Q7Nlryt1VEQ=;
	b=iVY0muvJWrhR1sS89voVwio+aL527Uo9ygv0b0F+Y1UUCLwOt1061DFp6+Ibbx2ODoeRa0
	WeKclcuRBdPfsjBg==
Date: Mon, 07 Apr 2025 08:52:25 +0200
Subject: [PATCH v2 02/32] selftests: harness: Use C89 comment style
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-2-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=842;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jGKlKoofOPJIAZx1RxcX4p7LfMYOyHoN+Nx2/9d9seQ=;
 b=UWCBg0T/rsIh7DRZAFxDpi3u/2xYdHQwh9pXhNssosgTrvVklijQ3t07uXdUCm2wScdA6Y+Y0
 mjHm8TgQyZJA++zAqkxP0fcuYmhTBobhHKZOLXGAbf7OmMi5tgK7NL4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All comments in this file use C89 comment style.
Except for this one. Change it to get one step closer to C89
compatibility.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 666c9fde76da9d25fe6e248a7f2143c113473fe1..bac4327775ea65dbe977e9b22ee548bedcbd33ff 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -983,7 +983,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	}
 
 	t->timed_out = true;
-	// signal process group
+	/* signal process group */
 	kill(-(t->pid), SIGKILL);
 }
 

-- 
2.49.0


