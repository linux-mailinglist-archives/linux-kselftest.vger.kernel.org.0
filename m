Return-Path: <linux-kselftest+bounces-30564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A95A8576A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3217A3B86DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3472C375A;
	Fri, 11 Apr 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9onRm5S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGXdUt7c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EFC29898C;
	Fri, 11 Apr 2025 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362123; cv=none; b=UsI0Aibhqhv9a1EjImyVm1iabn6PmnXsXzBUs6sytzpCsTKBZvWYtYRsGukkr2Bx1/V8+OAMWYqbI7MI6w5dXcmJGu69+Sy5emvTgUiqEyrN3aUDS4TH8wyFMM4aPSU2r7jD2N8fl2K34E1eM6vTpSjg2qcCD7SmrbBsdgKURZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362123; c=relaxed/simple;
	bh=MN6AkwH7M04l/Z4uzha4BvhmgdSGZ7J563KtStfiHRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sTDIBjYNqHVqL20bcvZce8ttf5OZWSJkTyLUHKLUOZzJmeBfsRzJbTx1j+0T+Sl7xPwlnZEBBk/3IV6DT3X3HU5D8UQKVVsvxvLp+a4N9ebofL++HpLnVVbwziOSLOfC5My7I3ptfncNox2T/yyWHvlbDOiDGdKeLwht+x2/WlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9onRm5S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGXdUt7c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psPihsV7XI/HoMHLIosI4/jOkhz9urwrehOWAUKYKjE=;
	b=L9onRm5SlM5ySECoRhgL2N/WAOVR5cDWaHlAE4hfd9YFCoA2Lvmz2CKfTpII/PnP8xt4hp
	IfmSEMPFFc+nwA4CBwodKu8QabN/glcukBLF+Xbdd4v3UHFucEqdhZKr98dlgNwYD1lGm7
	xJeALKflkG2FOx5HS/VZdGc8usuaVYtk4fyNXL6CNNeBIPxP9jLYXpBUHWd/eiajgj5Ice
	H9FiVWQs/u5zBMCoUsecpIHmgg94+GAgoq6y4Prw0W36ljVMSKVqY6uSejWlWAWr7yig9/
	r95NdNubs+o9CrMQ47eN3g8lUYiVILv6Mwavf+iJngC7vBpv7lPXajSs/XjgHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psPihsV7XI/HoMHLIosI4/jOkhz9urwrehOWAUKYKjE=;
	b=ZGXdUt7cwIv1ZPvsxoCWuBAQD4RrhefRR6f/vmgMQTQthBV5JcR31nlS5oeXGWukbjBYXw
	7ZNWwFxcccYhYyDQ==
Date: Fri, 11 Apr 2025 11:00:52 +0200
Subject: [PATCH v3 28/32] selftests/nolibc: use snprintf() for printf tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-28-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1769;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MN6AkwH7M04l/Z4uzha4BvhmgdSGZ7J563KtStfiHRc=;
 b=RuUcFra6BR5ZXJUkZDXhyUbd204Y2ZQExG+CqVXcx8m3FNaUnqB+tqHgMvZ5Ia0MtRgG2Y9lR
 0gmtrLedk3BCqp+6eb4PkxSpIWlJdGtQgzSJiV+aUTHHGJAafH+Kswr
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


