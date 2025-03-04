Return-Path: <linux-kselftest+bounces-28174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C3A4D47D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467C97A2DE8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B141FECC9;
	Tue,  4 Mar 2025 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PM4fsjf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oKCLJsxC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394111FDE23;
	Tue,  4 Mar 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072286; cv=none; b=A50zrE3lDnyfuv4LzVfezaYvdbw4k2DJMAl00+T+cMcA6XncbXPD4CrkjD9IjWBOOP7yVEgASJbOExmXXVOj92HspOeZDyWzdUsiiZZD9cNoyrL4Ry0urYJmz1aKzTeRtYL5ii0ZwUWtsjvYInRUJhcbN6rlNS9N+6WOg+20FgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072286; c=relaxed/simple;
	bh=wIUwKicz+gysRQyqA5MCMZEHceZHhrrMizxP+FzW0V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S85hWuoUE1W2Vpy7QP9rc7PRjSOO6DYFBIGtUkdN/293Z2t8yuYosTDYCVTasPIiOFUf4bcO5moq7BLF98QqmGF7OiTcN1XbDRx7HQuxcsan1BC6Ve38MRt+KjwrXPjJbEXbqsmxDK4DPqrbz1hr0QFbIzLr4ijKtMEzCoL1jDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3PM4fsjf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oKCLJsxC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCXMt69eUoyqO3viGj4al7IsmTDxenZ0uYvjtF1qcX0=;
	b=3PM4fsjfwHu6TujdWAlZR3nVmsOc41gu8v1+XYxAbQKXv3kNEjCO3oU0sH/d9i71KIckCd
	K49L5mYs2uZkxyowtVKxc4/v3lDup5PmX+HGRrmw1KWBEzQUcQO2bMy42pcDmuZ5glzsNl
	HCH9FUoJyGbwajHJW8/jssAfwNP+PshgIJ7SEkmfFvcB3YHralWTFLW3ygN7y0GqE3lG9x
	ZE9ijhdGitfur58I0Sdp/PzqXgZgmwWVYbFIfxEyaSSkeks2t6j5cshNW3LoLkYIouJ/rz
	AiK0CanIzWcEN8nwHAdStM4oY6dTcy8D9qJlZWPsun/MrnyaWPmmgfcLBTwwzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCXMt69eUoyqO3viGj4al7IsmTDxenZ0uYvjtF1qcX0=;
	b=oKCLJsxCsZmSX0PIhN4EnqDzUznM+4R6pd6umzPKhcVW9a7yB3uKVtfPTzUgNq0q5ELIJL
	euaHPAqf6Rx0s9DQ==
Date: Tue, 04 Mar 2025 08:10:57 +0100
Subject: [PATCH 27/32] tools/nolibc: add snprintf() and friends
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-27-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1851;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wIUwKicz+gysRQyqA5MCMZEHceZHhrrMizxP+FzW0V4=;
 b=jbXLEEpYwr5OH1QRaGHfpX17imHdpqz3QIq2EsIY7ZVPaXpVCrsubw4taenCxWuNxT002IyzC
 RIYr3nk2PtmAsof3NpTW9gn6R7Yv8uwli7FzEqzH00zW9jIp3HJPIBT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add more of the printf() functions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/stdio.h | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index b484a19466394d55d7d21248031837238b58f3ff..e9f9cb2e8d9877221b442f9f3757d7ace1a5538c 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -389,6 +389,61 @@ int dprintf(int fd, const char *fmt, ...)
 	va_start(args, fmt);
 	ret = vdprintf(fd, fmt, args);
 	va_end(args);
+
+	return ret;
+}
+
+static int _sprintf_cb(intptr_t _state, const char *buf, size_t size)
+{
+	char **state = (char **)_state;
+
+	memcpy(*state, buf, size);
+	*state += size;
+	return 0;
+}
+
+static __attribute__((unused, format(printf, 3, 0)))
+int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
+{
+	char *state = buf;
+	int ret;
+
+	ret = _printf(_sprintf_cb, (intptr_t)&state, size, fmt, args);
+	if (ret < 0)
+		return ret;
+	buf[(size_t)ret < size ? (size_t)ret : size - 1] = '\0';
+	return ret;
+}
+
+static __attribute__((unused, format(printf, 3, 4)))
+int snprintf(char *buf, size_t size, const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = vsnprintf(buf, size, fmt, args);
+	va_end(args);
+
+	return ret;
+}
+
+static __attribute__((unused, format(printf, 2, 0)))
+int vsprintf(char *buf, const char *fmt, va_list args)
+{
+	return vsnprintf(buf, SIZE_MAX, fmt, args);
+}
+
+static __attribute__((unused, format(printf, 2, 3)))
+int sprintf(char *buf, const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = vsprintf(buf, fmt, args);
+	va_end(args);
+
 	return ret;
 }
 

-- 
2.48.1


