Return-Path: <linux-kselftest+bounces-28167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF6CA4D47A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B9E188AE52
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8A21FCFCB;
	Tue,  4 Mar 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mB1PwVjc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tct/9tTr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153C1FC7E6;
	Tue,  4 Mar 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072282; cv=none; b=sw5f9wlyk/ibnUBhgRsTCuPx8AG+EPw09Uvt44OUYHnIdFZn2tygF1VIHonNQNWP9P3NJctN+VIIszKAdXhEVy7flqnYPZliO4ywfvcGwSBSS3sPweKVwX5ZWNu8lTVsHJjnhoB2ZOIRhb6f907ZZmVHzij8G9rPkdHdBg9HojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072282; c=relaxed/simple;
	bh=KMEkGJFuUv2orA59LI8OnvYt5A2QmizIsPu2s2FpUW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J5FpFP6xjeLCIQoyIhvuwpwmf572qHIkUtG3X6vBpe1PAD+cSW0lv12I+SED8uJNyGHHVVJZCmdWyXUYkKwVnFa/Yyk6bZ+RqqPOcsrHyvwdIPqudfD8SkjkB8oFHiieJTdzD7BoluNWfumcxxAqq1bkHHVtz8SlEN6VBS3/Ibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mB1PwVjc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tct/9tTr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cX2Trr3UgHxoCMPiHBlkygN9ZyBF4Oszhks+5ytjR90=;
	b=mB1PwVjc4rj6ww+/JYqMC+pJfJ+TglHmVBjKLVmLkQAjIKu5dYrCsS8qOEz5aROL9Vidot
	WjxmCo/g1xXzpeF/3Yr+j1SRKj/pM+73Tp6l3wMxThJuyTBK4XNkQnl4dJWjBHL5Kt5chs
	4mbbMMkeid/yuLL1Lffggj8WKxToG1gN/L0HAuEuI4iP13EBmok+FBiOYnJ7vCOTVtvq6f
	fxzowNHSrxkDqMREFDTNvwrPNpOWtnPCfDmUmYq6r6YkilzVHNtNoKkgEtPFrJmcC3lWdd
	V2tmh96A+QjKmwuj08YyYGqk72waOSx3IuJ9gy8hygWjJs7laoJEvjUEucjaCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cX2Trr3UgHxoCMPiHBlkygN9ZyBF4Oszhks+5ytjR90=;
	b=Tct/9tTrqMqll3Qw5kyCl6Z1sWGBG5Kh5Ekw11mqe5ZIomW+N3XLxWAbY/V5P5L4FNcUiO
	Kh/FE+teFaD8icDQ==
Date: Tue, 04 Mar 2025 08:10:50 +0100
Subject: [PATCH 20/32] tools/nolibc: add setpgrp()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-20-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=736;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=KMEkGJFuUv2orA59LI8OnvYt5A2QmizIsPu2s2FpUW0=;
 b=DcqVjLqXv+yhhbC7tJKunU4CNfcNSRh2OXY9vAANT7aBedi/N+mmn6T/u+LPTB00MQCcm1bG5
 6nMx80bKxjVAe8QTrQMKpusGbjprDIHWQhI1h19xmgjamNG0F2tCN14
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

setpgrp() is defined to be identical to setpgid(0, 0).

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index d98515120785223aaf74d1848a0ad68e308d6893..43b1bfa7a582ea926a062ff17fcf3e1b79be187d 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1055,6 +1055,16 @@ int setpgid(pid_t pid, pid_t pgid)
 	return __sysret(sys_setpgid(pid, pgid));
 }
 
+/*
+ * pid_t setpgrp(void)
+ */
+
+static __attribute__((unused))
+pid_t setpgrp(void)
+{
+	return setpgid(0, 0);
+}
+
 
 /*
  * pid_t setsid(void);

-- 
2.48.1


