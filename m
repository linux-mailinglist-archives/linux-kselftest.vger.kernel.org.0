Return-Path: <linux-kselftest+bounces-30200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47271A7D4AC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470673B0A32
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41C322A4F2;
	Mon,  7 Apr 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R80EhLog";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rGBLEOBd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB7229B03;
	Mon,  7 Apr 2025 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008790; cv=none; b=sBRiqCWbfvEan2jGm/yyawleApTk35b0qrOiCyBhpNhVf6FPw/aohTPzMKP1+vduEo3iaiLvglfQsHRhY8dY22EDBz/Zoywda8UNZKlIN4uujVS0M8rhi0B5XvsBFslXZx8la9kc+La4ukySJgJqLeP5nFlWiOwzSpe0ytEzcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008790; c=relaxed/simple;
	bh=vziCUdNp26ABjp35XwXDT3/Jp4kbGW8VzXFVpyrSY4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtmUvTNIzQhJGWKnV0oUKz6F6uxV83cd2f0E1ufSW+EkkCEE1TKhlxjvyTWGlrGZ0mM9DeYTmroAdtlxdaM9YK3dsJ6RfGseYLAGRoxLWcaCKBPgLW043xbpnMsf5cWPCYoJUYLoU2/hlnBkn7UiC2dRvLrXuDk7obdPYYrd3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R80EhLog; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rGBLEOBd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGXtZX2jgI41oXqZ0O6HteDy6lpCTkO9gddogCmzDs8=;
	b=R80EhLoga4nnOSjJoCclYk/M5Axw/4T9Fkbx5TMLkp9scZfRAf9Od+vETHN3fAIuLCa6M6
	l7B3xH+kF+iSvTrPXBhGtNUMYk2pac5z1BqKY4gM9CYWn1YMx79rxi0Zo6UaC+fUkYUMqP
	3h+rEgGRLGm3ibS/6d5hCdF8T/o9silV9Dvn1RirrwtS7xrBceFYecKMclqMyoNIjpZq7c
	LTdEts8xQNd8SdnjjunQVMqMaNdUvmZeK15l/ch7VaKjOJ8xjQAkriKw23xD+3+wsYkdSY
	+LCo5ekf9P+kDAaLbJf84zXhWkjBfY0PdF9dyAXZox4bcxyLzSuHbR2Ul/OYCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGXtZX2jgI41oXqZ0O6HteDy6lpCTkO9gddogCmzDs8=;
	b=rGBLEOBduT9FbyBAuaJixgE3SAC/1AUTDSG4IbsadcPHr+K793nwRhAinCcdiMQ9eGpe3e
	YyrT+jm79uTnb8Ag==
Date: Mon, 07 Apr 2025 08:52:37 +0200
Subject: [PATCH v2 14/32] tools/nolibc: handle intmax_t/uintmax_t in printf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-14-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1971;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vziCUdNp26ABjp35XwXDT3/Jp4kbGW8VzXFVpyrSY4M=;
 b=vw6ZSUoX6zR+yKJ0gQorpmCbUzLlJv0goLlWMzKUTFWF3anga1U/fdsdUOJel6acgqW7GRDwY
 9TW2cLeHRISBSLyCbHJ1J4yAqmuov20P+TC0iBw1fYHN615VyaPj+m1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In nolibc intmax_t and uintmax_t are always the same as
(unsigned) long long/uint64_t as 128bit numbers are not supported.
Even libcs that do support 128bit numbers often fix intmax_t to 64bit
as it is used in ABIs and any change would break those.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h                 | 2 ++
 tools/testing/selftests/nolibc/nolibc-test.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index a403351dbf6098ac8292b9589ed8a054b4c5669f..b32b8b794015276ab6242c2be18f860c095f90a3 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -286,6 +286,8 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 				if (c == 'l') {
 					/* long format prefix, maintain the escape */
 					lpref++;
+				} else if (c == 'j') {
+					lpref = 2;
 				}
 				escape = 1;
 				goto do_escape;
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 5884a891c491544050fc35b07322c73a1a9dbaf3..ccf865e80eb715488f4ee5d623b7a02d9dd8abec 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1430,6 +1430,8 @@ static int run_vfprintf(int min, int max)
 		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
 		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
 		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
+		CASE_TEST(uintmax_t);    EXPECT_VFPRINTF(20, "18446744073709551615", "%ju", 0xffffffffffffffffULL); break;
+		CASE_TEST(intmax_t);     EXPECT_VFPRINTF(20, "-9223372036854775807", "%jd", 0x8000000000000001LL); break;
 		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.49.0


