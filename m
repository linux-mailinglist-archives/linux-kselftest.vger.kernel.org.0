Return-Path: <linux-kselftest+bounces-30213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C17A7D4BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD52188ABAC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3146A22DF9F;
	Mon,  7 Apr 2025 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BxVIMfeP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ex6DkJvT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAB22CBE2;
	Mon,  7 Apr 2025 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008799; cv=none; b=qRs/A3Q9exIgcK3Wfw4asq6wItBAm/Hjc6TRu3eWF3tV9nn4lcpLlQk7+47QoRKKQ3Xal8RsHN+zxvN/GPsvoLkzA9jGYu3KothsOOInpPP8kgL1b31+fHS2YUa4c5SwUYq5pnvjqRLzaAHnDs8EikdAG76tJ8ONjLoOBN7LJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008799; c=relaxed/simple;
	bh=MN6AkwH7M04l/Z4uzha4BvhmgdSGZ7J563KtStfiHRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rMzG+L7CDWBuNhOjcTc/p6k096hNbfxtj35CbwYEM3TGEVND8pJ/1aJ+6wPCKV0o8mQOiWbGcbhQN7QyY4koNhA2C0FYvQ9X1X8rjqrBnHWRzGgeZ2Ldlxe2z72cwvBFOAY1mK5lt5TEtBs4kbvTSm4qO2vqBrWmcSGc8TG/N+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BxVIMfeP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ex6DkJvT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psPihsV7XI/HoMHLIosI4/jOkhz9urwrehOWAUKYKjE=;
	b=BxVIMfePCq7MiKSN3T6DPTfo4WJddcGat7+gp6i9WgBidRGQHaMxaturBsmv59fQveovtX
	LADQMEaGINpNolayCRp0wobv51NgdwppDRC4iHLAcsuor7aziQzEJPrtLOCdXefUz3F73F
	mOnamlUF4fVUChbWyXxKi8dxKiouRcmhEIlWC45NlwqYdZ4JeD0vBJrHVQPE0QRI6ZctLX
	CfvrczcOKqkncwtQexikl5MLWwv+Y2kfnVTUOb3zmb2kvrAzHc4iw2W8s90xIZS5wxnlyq
	O4Uuj4czy1SORsQClT7pmdGVwYvuEMGk5kiHLZ4thiLgDl3PtlmXdvvNOZSHFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psPihsV7XI/HoMHLIosI4/jOkhz9urwrehOWAUKYKjE=;
	b=ex6DkJvThdjAQweOSJel42sGdBop35w3/FeRsojnk/h+GHAoZAo0SahRt1J7DsNsRQx4sy
	R+fruN1EZJU5L9Cw==
Date: Mon, 07 Apr 2025 08:52:51 +0200
Subject: [PATCH v2 28/32] selftests/nolibc: use snprintf() for printf tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-28-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1769;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MN6AkwH7M04l/Z4uzha4BvhmgdSGZ7J563KtStfiHRc=;
 b=6DuZnZsMm7M2fM8yoQAI8p76Temf70okFkuGrfK/aETEsEfNtUo2jQypz4gNTP46thjUBH7FB
 BkT0d5oKKmUCs13O0xXacId7ZVmP7tf0KjUmT5hRqrTJ3yo9ce5IFSc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With a proper snprintf() implementation in place, the ugly pipe usage is
not necessary anymore.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 30 +++-------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b4b9a8422d76e1170ff967850429916a2190139b..8fb241af33cbba2ceb1303bf41582d51f70df68e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1300,27 +1300,14 @@ int run_stdlib(int min, int max)
 
 static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
 {
-	int ret, pipefd[2];
-	ssize_t w, r;
 	char buf[100];
-	FILE *memfile;
 	va_list args;
+	ssize_t w;
+	int ret;
 
-	ret = pipe(pipefd);
-	if (ret == -1) {
-		llen += printf(" pipe() != %s", strerror(errno));
-		result(llen, FAIL);
-		return 1;
-	}
-
-	memfile = fdopen(pipefd[1], "w");
-	if (!memfile) {
-		result(llen, FAIL);
-		return 1;
-	}
 
 	va_start(args, fmt);
-	w = vfprintf(memfile, fmt, args);
+	w = vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
 	if (w != c) {
@@ -1329,17 +1316,6 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 		return 1;
 	}
 
-	fclose(memfile);
-
-	r = read(pipefd[0], buf, sizeof(buf) - 1);
-
-	if (r != w) {
-		llen += printf(" written(%d) != read(%d)", (int)w, (int)r);
-		result(llen, FAIL);
-		return 1;
-	}
-
-	buf[r] = '\0';
 	llen += printf(" \"%s\" = \"%s\"", expected, buf);
 	ret = strncmp(expected, buf, c);
 

-- 
2.49.0


