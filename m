Return-Path: <linux-kselftest+bounces-32380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 551A6AA9738
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F36F189986E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE342690D4;
	Mon,  5 May 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O0tqN8Jh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kN6Ner6/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF22673AA;
	Mon,  5 May 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458183; cv=none; b=CY6Y8hzcjUS4i9p5pkRMYvC8sZ2SC/YqBnB/UPYz8foEK+tnhd7UvbdkVzeGuZx4O4SZZ8XVgArxNg+xXWuMWorpa5BEMo1YFJIoI425mPae/E+FKMa/NPIUlixm5K3+22jkiw+32Rr1WpaDZ+A/RbxnGl7f1Q9wlHJqhreXMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458183; c=relaxed/simple;
	bh=q3F6Jm+0/xfrIArvrhazQ5Nby929J/SsWkb7TXkAHgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcKtrE+ho3JzfyyIQOP6vPQ15yMmRodjI/uCJOJp/IoCs+uqkCpSiOlKs5gyWO6yT2n05MxtMeqcJDE1tSypMrhgLsPEXfaVutXLtDXtepNDiTMPkyDXxSPNQzH9T+kmJkpN5bMFDX9VgQj9k8K0CNa/1LdxQWsDNwrU2EAoaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O0tqN8Jh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kN6Ner6/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AiNSxZF++ED923SbPZg8cZpQ/pm2Fkr2e/nA7wxrkFA=;
	b=O0tqN8JhxHGO9Gi8EIgdK2PaRxm2DFcc+pthAid0tlxChjul1GKtAQ4S1+jMCzNVYYd48L
	LC2q4tDGFgzI/SKPyovuBQk77ENRELgMOEjp8W+z0GFa7BgT3NQM+zKWjOX9Wdh6pZrdLu
	fit1ZUdwUKsznf2mWGdBGSyBwNHcfTJl23cWzA46B3S+rxvpecIBV+rbVJxmTrD8XC6dY1
	AxijNyOTnt4o0kxdNK3d6LMTUVYaiWea4h3vcON/NOqfYDPDBLhGpgnmTwiF052EThWRV2
	6vcMCIX5lHEY256APvfC8DWNx9zzHMpVQQ+/iifQVjQmAq1ZoqPBEfoHieneHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AiNSxZF++ED923SbPZg8cZpQ/pm2Fkr2e/nA7wxrkFA=;
	b=kN6Ner6/LYRPf8C9CxSHqzhmU1OGzYilv6KCWLNdxFMi7X5Gxn1XuN5bcE3HVyxFWo3vD/
	/QUIz6M0O5Lss3CA==
Date: Mon, 05 May 2025 17:15:31 +0200
Subject: [PATCH v4 13/14] selftests: harness: Guard includes on nolibc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-13-ee4dd5257135@linutronix.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
In-Reply-To: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Mark Brown <broonie@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=1132;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=q3F6Jm+0/xfrIArvrhazQ5Nby929J/SsWkb7TXkAHgk=;
 b=9ePNhLKywEPYAlUA0cza6UimkIEdmFvdXj1Uhl9bOJ5jFla+1s4NHEGdReKQM7u44ow0NJ+0J
 TcafEgy0dKQC40hY4+VYE8KBYKZ8FnUVljiWJ3kWLJPDnxUNKiZMXKB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nolibc doesn't provide all normal header files.

Don't try to include these non-existent header files, as the symbols are
available unconditionally anyways.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kselftest_harness.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db995d7197ed1f55bd9cc657669df9bd3..3fa92860cb25f399e27b25385d9de5b54359b93b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -57,16 +57,19 @@
 #include <ctype.h>
 #include <errno.h>
 #include <linux/unistd.h>
-#include <poll.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
+
+#ifndef NOLIBC
+#include <poll.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <unistd.h>
+#endif
 
 #include "kselftest.h"
 

-- 
2.49.0


