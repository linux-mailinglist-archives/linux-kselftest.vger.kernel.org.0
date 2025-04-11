Return-Path: <linux-kselftest+bounces-30563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A2DA85773
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672E71B8371F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43F02C3752;
	Fri, 11 Apr 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lswV6A3G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FNn4vut7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59F2BEC5B;
	Fri, 11 Apr 2025 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362123; cv=none; b=pxNW8teBnQsOIN9FsM5MRy05yOeLQk9zIL1wi0hc56O+XR1YrgSs+E/qbBrePjHMnGkHA4oMAWhYEdbro5Lh3NZyOIAXIWms9lpJk9ViIDlXSGxQB3LMIgNOUJiCbV21aWrJySNo+u48mOxJ46XkZ5WeqONpC/96hQAhBATtiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362123; c=relaxed/simple;
	bh=kr1493r0mCxh9Smwnzq2sT4EOgraIN/H6Zk+RSFwpBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5Y6mCMD6aYWZaUwR5xs74feUOIw52UKQtRPQTaQYNdfzRoweTciaR8gQRJl+AsiWhQ0L+MUf3zKlm+Ks0f3mE+ZSN+UOoRXUmgzygTV9lVEJiuQSWIbmFfit2yWD8gdhKpDm7ZpUDKrq9iJ6wRFLbYIXa5gR/SFpLy3h4nynuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lswV6A3G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FNn4vut7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9tNYn1A7xCJCEfyuN7DqxsUEM5cT1Wf6v4wfadNgQw=;
	b=lswV6A3GDcsTEylftDeg1TLTlyXVNkXIuondQMbGzMR0Q+wZ3VxaW1eFBiPyntDLBCBdkj
	Pl8eV+ZGu0ch5YnrZDuDoFFjepA+yM9m39dgckGkJLiTAL/3Hk9ddDn6socBJUws5FV7Lu
	uBvGR+zk3tOTpjkn8FkZVaAKiFTW4YKaeFFyc6EkmQkkViPrkm9GAi9Ya/Cxxp2fkmCmSF
	97panHuFYPnktOBjL8EtsFmHERC7q0Dd2mkY4tmOsUzkU8v+n+8B8qOhOs8HjdBC9SSCn6
	xwf5dJU4AVq2B4ZQeM4nKgXU3DzgLO85GiWeRV23lZ24IVuvpcIsP5WgH71Zlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9tNYn1A7xCJCEfyuN7DqxsUEM5cT1Wf6v4wfadNgQw=;
	b=FNn4vut7RerQLrH+tkUa0+TzkrO7LXuJ7kBaUjiLUtrLshjQQa74brNSTHZzi4lggUohCs
	CAGKDNf9317Lq1CQ==
Date: Fri, 11 Apr 2025 11:00:51 +0200
Subject: [PATCH v3 27/32] tools/nolibc: add snprintf() and friends
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-27-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1911;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kr1493r0mCxh9Smwnzq2sT4EOgraIN/H6Zk+RSFwpBw=;
 b=ne/2R8RR+l2VhltEDs/txqus/cSPrDcysM8GQZIZcZaIfeWhy8ba6uwOXsxZGhNWg81Pftv3k
 M94lZlCD0y7C3/YU5lbMkC6g0mUGi/Ok8SkjTB0o+d5Uy2Vnn0n6wYf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add more of the printf() functions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index b17b473bd8751a6283309178b4848e61e1683305..46bd90f96d654fadda20292baddc98358a3afc62 100644
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
+static int __nolibc_sprintf_cb(intptr_t _state, const char *buf, size_t size)
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
+	ret = __nolibc_printf(__nolibc_sprintf_cb, (intptr_t)&state, size, fmt, args);
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
2.49.0


