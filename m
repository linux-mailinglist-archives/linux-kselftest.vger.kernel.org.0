Return-Path: <linux-kselftest+bounces-30557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB44A85760
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D84165C68
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1D829898B;
	Fri, 11 Apr 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1hduLAVP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qMQyxFAq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE529CB42;
	Fri, 11 Apr 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362119; cv=none; b=X/IgbO9kpKBNTHeo0l2aLbQlhHFPvNz5yHa262HG7i85ty1B/UoLLWZO13zNoMbg7rxdGZBYFjFUxKiGCLVgaH8+G0Snez/mVQPtaHgGljffauQKRy+FFUFErCh6glgmh8gxgNOHJZcXuEM+uk2KKf0jVXuvbMar+fuOzyv/VMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362119; c=relaxed/simple;
	bh=d5MljKKNkutS36nrGWCEFbpFryRCK+Ka8uE6LBhTqxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZZSk3ri2ePZz0E3zBf/8ZyWmx8ewWCj1F8JEIUHSN9STLTs9IZ74JIQ/mhXlNckhvARxcVjTe2SnRfxUKIB1iGj+gq2Xl+dbLYCWuy8ZYbHYzU9OeKAutRkNwPPvf4YVzAgVYiJytAPXVFFGeBfYzwla5B4Jj+BG0Y/PBAHpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1hduLAVP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qMQyxFAq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGIsurDNbt9wfy1oRuJrCVBPEF2XC6rkda0U4p2igXs=;
	b=1hduLAVPSC7LhNDkK+oh8ubI0EjAv7Ii3yWxRtGfgrzhCvZPzvsKezyrkC8gUEJTpbvg5y
	na5dYNRas4qI8bttYdXUBY1LFFqLvziGfcWjwFwJge2y2Hm+kIZOf7erLtzU/A0y/nqCg/
	/Jf0thRAFupjEUFAH/FIQw+DBG1GqWrD+Ywg3IatnlpHTgdt+cLwQbFuEFvcS0BFDLRTP0
	x6lN9j7lAU1nlHe8u0MY4tez+DLA2IPWBLBC/CXl/6Fy2eeZJxVaQ/1ysp9lT+KLdksjJY
	CuX7+YHK8uCUxu1KLQ5jkQ9Mv9RDZDNoSVFZItsrerxBMr/lf1V3+zy/jRegYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGIsurDNbt9wfy1oRuJrCVBPEF2XC6rkda0U4p2igXs=;
	b=qMQyxFAqGGSQCrQ4UsmlO5iBxBuixhL1HYpcKBWPXMh4rRthmEUMSnb9su8dnUim7XebRl
	nOUfOIp/XYp/jYCA==
Date: Fri, 11 Apr 2025 11:00:44 +0200
Subject: [PATCH v3 20/32] tools/nolibc: add setpgrp()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-20-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=772;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=d5MljKKNkutS36nrGWCEFbpFryRCK+Ka8uE6LBhTqxg=;
 b=ZLeqnDWJ0xdsLz7Aw+CfdW+YpEgafYTrPnjVfnhMPj+X2R424VX6/7x5r/mhazV+5ggzWVkXV
 XboC74478WmDtiEAxvflsLnH4pvtbf36j/VR76mxe02zMopq7A1lyue
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

setpgrp() is defined to be identical to setpgid(0, 0).

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index f52e1953020945fb2902d47ad5f7a8e7c2c1c290..5c71a2f65c7bd93f6f516a54f7e63244466fad47 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1073,6 +1073,16 @@ int setpgid(pid_t pid, pid_t pgid)
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
2.49.0


