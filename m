Return-Path: <linux-kselftest+bounces-31780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8896DA9F10B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63C717B627
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6F270EB6;
	Mon, 28 Apr 2025 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IAcLD5+S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XwKjZS7C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310826FA77;
	Mon, 28 Apr 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844019; cv=none; b=ZRTTjtN5otir5JHS4QIvvCkbwx0P8gGSHdxO1GUJrB/6FZNBfNQ7uJ0FIg7xtgFaWxjsCm+Sj8SO8X160xsjTUi/ABhL42caaK+mNxRb3w96gIhO1JvuHK1ZesX4NhmaTWwHT56krDnNoXWgdXXRwA+2rsp0I0bLeILtoOry4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844019; c=relaxed/simple;
	bh=uR1uMvXkwy1U5+i9SR6QfCR7GUaSyCdxeSM6QC/XKuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MXGil2CRxqDFPf17TcMHoilDosMhMIUQSXu9n1+xxBraEMykt/i5z/ZvS26NIuA+hzbNV9YExgvSpsUJaH4feEbdP77cOniHuI/lughWXV16SjoNvEF5hhHKjsO9U7KW7cdcbhnbyU9Xq6BbO2gI9tzCYO9WoGQ7nkuTnuSStpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IAcLD5+S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XwKjZS7C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3v9eG5lyR1SK4v03tlBXazUzZEzaRroYU5b0iRkhlHw=;
	b=IAcLD5+S6eZkQCbPl8qMeB1FvhwdYq3Fi5Alodl9KhQvVEShZ+4lSrUtZGA6LrmAMaIEYj
	UHXVJeWSBWcDXbxbePjp7FlWAMDGclDZzknLLVPoiQGwoAPw5dPtnO/wyC3BzZcEcE8dFN
	f6aKPtFvZ80bO7xpMB+gPkY3kso3qEDvrti+wqaBDBz3NyF77OZ+6HsDP2OPCHv7NQ1EMK
	BsXlphvpvb84iw691rpFMCtuesl/sXhwRIqD9gUVvcoo6yBg3r55DI+TdIJOOfMl5+WtbO
	jFnokUl/8O2uQIfT1rGDa3J5A3EPnml+jP9kIBzmu9TzWMC3kmgQeGyGOG80SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3v9eG5lyR1SK4v03tlBXazUzZEzaRroYU5b0iRkhlHw=;
	b=XwKjZS7CnuewFlLx5T3J//xJ8PMWgPbk1Lu9I49cR8+WX2nNpARew/EQeKPUA6wa95ZWRs
	ZVgsASIFmiHKRCBQ==
Date: Mon, 28 Apr 2025 14:40:15 +0200
Subject: [PATCH v2 14/15] tools/nolibc: fall back to sys_clock_gettime() in
 gettimeofday()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-14-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=1463;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uR1uMvXkwy1U5+i9SR6QfCR7GUaSyCdxeSM6QC/XKuI=;
 b=LeCfvd2ShVjqzQbWqsTNhYtwd85Lan7zthLtgUXXABK2wSuCCbELnNAtMTVPFJz0Ao7im5IBB
 UkJNRxJ86xjAo40zrYoxa6N5nYgJsgDfjanibZAfnTAoUXRaDkB7qYd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Newer architectures (like riscv32) do not implement sys_gettimeofday().
In those cases fall back to sys_clock_gettime().
While that does not support the timezone argument of sys_gettimeofday(),
specifying this argument invokes undefined behaviour, so it's safe to ignore.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys/time.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys/time.h b/tools/include/nolibc/sys/time.h
index 785961c52fa3b6606ee30c19a4a1c11e86ccacc0..33782a19aae92907ccc636a656fc0f27b838dd61 100644
--- a/tools/include/nolibc/sys/time.h
+++ b/tools/include/nolibc/sys/time.h
@@ -13,6 +13,8 @@
 #include "../arch.h"
 #include "../sys.h"
 
+static int sys_clock_gettime(clockid_t clockid, struct timespec *tp);
+
 /*
  * int gettimeofday(struct timeval *tv, struct timezone *tz);
  */
@@ -23,7 +25,18 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 #ifdef __NR_gettimeofday
 	return my_syscall2(__NR_gettimeofday, tv, tz);
 #else
-	return __nolibc_enosys(__func__, tv, tz);
+	(void) tz; /* Non-NULL tz is undefined behaviour */
+
+	struct timespec tp;
+	int ret;
+
+	ret = sys_clock_gettime(CLOCK_REALTIME, &tp);
+	if (!ret && tv) {
+		tv->tv_sec = tp.tv_sec;
+		tv->tv_usec = tp.tv_nsec / 1000;
+	}
+
+	return ret;
 #endif
 }
 

-- 
2.49.0


