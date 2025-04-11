Return-Path: <linux-kselftest+bounces-30566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B97CA8576E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DDC3AF17D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0802D1F50;
	Fri, 11 Apr 2025 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ldSBgIjw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y1PGnTso"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82882C374B;
	Fri, 11 Apr 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362125; cv=none; b=NGB7Mk6zzHywGvr0/Q59HhlsGrM0JX3GFZCzW2S+jjrOU4/8sayBTti4mbHL9cm8VQ3nTJpxPFvNcRzucqqaRWF56kcBNKXV9QfDBNhT4qAsfY8lU2hJ/SntymeJJH1cvQZQK+3pMU6x27k1+6iKS8hJeVbYkNkP0e3wi0Ytzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362125; c=relaxed/simple;
	bh=1m4pGrKjarsVyBk2sHbIz0kz1QLrAgcqnYe0JpUbZkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuLy6hp0PxGNWt9A1BmAMPr3rOdpjtgqYog0SFMbyKVPBR+WAYhbLnNGzsnSPs1wyXlCpOKqAu3ESPtRfHqN5g1RmpYc0JZKlBWIRhBMZIaESn7x9y2D/+LQiGIhqdYBCxBkU7qUaOyo9xjJZqwtyslsUkjdS1F18ovfWClzjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ldSBgIjw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y1PGnTso; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hGEGPrYAeGEEY4KfXy0LyZoEFXiYSsEkS/Ru5j/+Io=;
	b=ldSBgIjwZF1hDyVmSXxXOGNusGqJvmcpjAYkWmxwdtZQggMyqdJYWkv9E/rGweUzxy0Aqy
	/eh0YvcH0maTqkr1ouNVpvBqAwfwKPmQ2oHRQXjyBQFvRV9icl8iSDq2em0+dNtzaL8OUx
	rC9WK0CFcTrQIBTb4PCtHQNHNc/y4Kbf7Ke905NQgs//QylBlPa90CqXDSsCdeF/KUmd/E
	6o4wo+U4X1EQpfuVSF8OLj8NgLXLRSpMCf+KFzr4rEPCa2PwEvdiWxMYBeoVjy2lPbdKP9
	tpHJGeP2FS/0ExHpkcgWU60OzYz/G6LflwBNTYHkJivmPOPRxyKY4MyCYJdSYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hGEGPrYAeGEEY4KfXy0LyZoEFXiYSsEkS/Ru5j/+Io=;
	b=Y1PGnTsoBIz9Jms599E42Q4JRfCZmoQEvaw4oRJUWkCCcRPkYEuGqicnGUJSqhjsDT5USy
	uRzLvg06Q/X4tSDw==
Date: Fri, 11 Apr 2025 11:00:53 +0200
Subject: [PATCH v3 29/32] selftests/nolibc: rename vfprintf test suite
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-29-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1295;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1m4pGrKjarsVyBk2sHbIz0kz1QLrAgcqnYe0JpUbZkA=;
 b=s5jd/oAjod4BGhI5gBOfnk1py9vROPlp4HibskMyz5tLKCuFZuLs4dJ0hbeSd6Hg+Cisf1JcJ
 5VW7vg2scG1CVx0fnAcaFuwwUkIUPisOy5q63qH0XDFSpNquRzujfqz
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


