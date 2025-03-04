Return-Path: <linux-kselftest+bounces-28170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA4A4D47F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896D8189889A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F091FCFD4;
	Tue,  4 Mar 2025 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WG0QfnVJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r0kiB+Pi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1EB1FCF63;
	Tue,  4 Mar 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072284; cv=none; b=dzithRWTWBoxTwVQ3cCTjgUjrnXCoeVwx6acCkoJ2D4FFUzG2P42q3CrrnQIGzs93dnoMGv63aMNsEWbbmIz8KQqefIIutJXyyUjs4QnjKFn1vYtwpnbYx7+6z7bDqGJGDxShpRsf0R2kTRVwrBb0Hz2BX154pmXWNk8InuTpf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072284; c=relaxed/simple;
	bh=45SY/2K5N8Gfwr9j3PMqdGQfwtsZ0Rt1wns1znRxmck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NBiZr/fxMV/p26bYlAa0KjClXAipqmQZ19WTpZ5Hh3uvOVF0ne7z80Wbr4RXq2cq8v6FchGqIV9SAY1taIbZ8kpOoRBvEDnsJ6dOGTOhMPNKqU6QUj6OTkb/zMavBVq3JGa0mOw5VSEGOtfMVgsbPZ1X5T4EU8QahDY+iZc3HGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WG0QfnVJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r0kiB+Pi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEZfqRWMaENs1Hn1R1Aw9ErUtNc8GnsReE3QTJpFuzg=;
	b=WG0QfnVJTOwNUrBeC8DPzSVhmiOhVKgD3jHId4zHHfg5OF86yz+Hg1cgQOc1b2cVBRp/Gf
	4h9JTxg0WD4BV0t61WhwMTVXLhQ4ccJ68o3Mv45X4hvQ+s884ignBl+/KGWbwIEUcEqrbs
	RnOB/Is6KCW2aJ0D6U9aseSitb0+u0LCfMvAICARVejUnkxP3xes0J8VTd4mbHlzc60qsX
	E/4tvO4BYPzx/QYuSBk9ZzRI6DvzGKZwzVHiyUTlAjnUENuJ0l94vGaM+Zf57l6ix3vW5L
	gPjBtZ13PgYcN45qVAi6zBhYfCMDMAS885cK6JQF+1q0ZYw+0fqgMOkGtIQCEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEZfqRWMaENs1Hn1R1Aw9ErUtNc8GnsReE3QTJpFuzg=;
	b=r0kiB+PiXZkSyrOTZIc2X2eYwBRRDsFSfjSWUsSkccP7nB171ALYMzseWgxfcxJuZowhMw
	J71Iw+6h+BQg4GCA==
Date: Tue, 04 Mar 2025 08:10:53 +0100
Subject: [PATCH 23/32] tools/nolibc: add dprintf() and vdprintf()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-23-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1353;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=45SY/2K5N8Gfwr9j3PMqdGQfwtsZ0Rt1wns1znRxmck=;
 b=DfzuFkav/AIjNzpP16lMSeJByBD9Ni0Qn16vW9Bucf5KJSMrsRTefOVdoeuRb7u5/ksftYqRv
 doNg63jHH2QAySVYSvzUpEPY6AN+4emGOHxMXDwf9IaAf+zoCTpEFFt
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

dprintf() and vdprintf() are printf() variants printing directly into a
filedescriptor. As FILE in nolibc is based directly on filedescriptors,
the implementation is trivial.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/stdio.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index b32b8b794015276ab6242c2be18f860c095f90a3..262d0da4da9062e0c83b55661b2509f36548cf88 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -351,6 +351,30 @@ int printf(const char *fmt, ...)
 	return ret;
 }
 
+static __attribute__((unused, format(printf, 2, 0)))
+int vdprintf(int fd, const char *fmt, va_list args)
+{
+	FILE *stream;
+
+	stream = fdopen(fd, NULL);
+	if (!stream)
+		return -1;
+	/* Technically 'stream' is leaked, but as it's only a wrapper around 'fd' that is fine */
+	return vfprintf(stream, fmt, args);
+}
+
+static __attribute__((unused, format(printf, 2, 3)))
+int dprintf(int fd, const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = vdprintf(fd, fmt, args);
+	va_end(args);
+	return ret;
+}
+
 static __attribute__((unused))
 int vsscanf(const char *str, const char *format, va_list args)
 {

-- 
2.48.1


