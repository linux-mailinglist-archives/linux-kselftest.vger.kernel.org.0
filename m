Return-Path: <linux-kselftest+bounces-30208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7D1A7D4B3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1B6169C07
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C422CBFD;
	Mon,  7 Apr 2025 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lGM6hPZP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o0wkToQ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7FB22B8D4;
	Mon,  7 Apr 2025 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008795; cv=none; b=oXXmbftIe6UTgn1o5kySoNsE8lSzpmm5MWJJxzpHnyoQdLKzt28SaLnpApzFcifi81SX25Um6CShW2pHhTA3Xr28AgPb4tSj3B42Prnzecgmi9c1nNKUY2Cw349Fh5uUssjLlYeo8dcHExKwE0xraJHoridGIWjawuzVB8ZtObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008795; c=relaxed/simple;
	bh=q4kd7mGGuPTJdyPDCjQYjszzTh6pp6UOGPR7zUxPBBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHRvXW968BTPDHUctaLHosJhJ56TLXwAzcT0FSscizMpLpQ+xGAxSMySHReZks5RFQVnd435QlQIyMvyMeUyh2THCoOW9lPvcAmw3HfvHsmOntmfSVOEf0GBAXIYLg2xeZrg1M7+og1RHCFnWHJyutbFhIhhZEEcSrgCooIqJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lGM6hPZP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o0wkToQ1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqLj2uDZACTDisGAnX7h0mSVa8/8RdDY0n+eZ6yxnAE=;
	b=lGM6hPZP5H7TtTPmf4PmBteB2HK/GYA/rQ0NUQkKz7EsXh6kR6/RDwqD8C4NwEp/WMILmD
	5gpnkz+IfOm7LHK/h1XZPhV/Ld1Uxs8RCt+8QmXeuG/C5zL0m1r+JYlHgh2yViOheCFrxD
	vZoNkX9mHa264PuHmnmlw4ZwOTWUeaI4Vb7S7pcuOltnzXWDd6shUDX7VPYOirT7OPMZgY
	Okj6c+gDpT8QHX0wZ/59RWc1cdaJNpJw2nTj/5r2A6pQYqD94Cqfcr16aXak/hF8OStpuT
	DFw4u/PuLu9rAAaDOAYlZpp7f7hN3G13hrO3eeRir2iInPdnig0tGFu/fsCB7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqLj2uDZACTDisGAnX7h0mSVa8/8RdDY0n+eZ6yxnAE=;
	b=o0wkToQ1Qqw4XHfLLxzjGRHEnmQAgQRfiZGTc9fjkmu8U89YiAYp+1FKnsb+8M1kHSLZxJ
	y43l5d8+/Mtu2/BA==
Date: Mon, 07 Apr 2025 08:52:45 +0200
Subject: [PATCH v2 22/32] Revert "selftests/nolibc: use waitid() over
 waitpid()"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-22-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1651;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=q4kd7mGGuPTJdyPDCjQYjszzTh6pp6UOGPR7zUxPBBs=;
 b=CDj6H+Bwa7JIQMAieYEjLtY7FkRGQnhzlMzywRHig/rtA8y1a+vPuSKNMRdap2rxZo9V0Pnry
 8qi80tZiGH3A6TupLC5dICsbnAfv7A8m6OBAjO9fuhCLGJA+vO49pxI
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

nolibc's waitpid() now uses the waitid() syscall internally.
This removes the original reasoning for the reverted commit as
waitpid() is now available on all platforms and has an easier interface.

Switch back to waitpid().

This reverts commit a0bc8947ac731ff95a56e0c1737e69e8c56d5b78.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 70d418b87f7731572b85d64a8128c62d01df6b2b..b4b9a8422d76e1170ff967850429916a2190139b 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1462,8 +1462,7 @@ static int run_protection(int min __attribute__((unused)),
 			  int max __attribute__((unused)))
 {
 	pid_t pid;
-	int llen = 0, ret;
-	siginfo_t siginfo = {};
+	int llen = 0, status;
 	struct rlimit rlimit = { 0, 0 };
 
 	llen += printf("0 -fstackprotector ");
@@ -1501,11 +1500,10 @@ static int run_protection(int min __attribute__((unused)),
 		return 1;
 
 	default:
-		ret = waitid(P_PID, pid, &siginfo, WEXITED);
+		pid = waitpid(pid, &status, 0);
 
-		if (ret != 0 || siginfo.si_signo != SIGCHLD ||
-		    siginfo.si_code != CLD_KILLED || siginfo.si_status != SIGABRT) {
-			llen += printf("waitid()");
+		if (pid == -1 || !WIFSIGNALED(status) || WTERMSIG(status) != SIGABRT) {
+			llen += printf("waitpid()");
 			result(llen, FAIL);
 			return 1;
 		}

-- 
2.49.0


