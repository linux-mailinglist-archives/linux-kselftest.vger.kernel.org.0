Return-Path: <linux-kselftest+bounces-45551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA935C587A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C2FB34FABF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879B354AD0;
	Thu, 13 Nov 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZLDdAIP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGNr/nNr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF2C2F362D;
	Thu, 13 Nov 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047870; cv=none; b=D1MDOKIalBLCfAgdqV84gjywazALQgZMBPVQb7SsrfyOo5molgG2tLVeHbBPc0P31ggojPYR3+H4vPdNTDEsMyF4e5hHywUGAShv5H0ZDv+E48oiTx7wuH6ZpKtrZU7llIEkFhI9GKNxzk5qAOcaUHyEPCw+HzLEHnd8D5hhnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047870; c=relaxed/simple;
	bh=5Op/T/eyCK+F5h2kEKIs2m7fYFFJJ7Y0BBAu8h5Itc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBt29mujNnmSwzlMp+r7yGFhTsZEg0EASp1FIgZPR7trAdlrrHRZ7Yx254+GEFmAr+Cz53GedaipLot/irr/ykTCGlSW1HjjnHE5MnxDOdImeKSo4tgQYAkX4LnVfEgjVNK+bFMadDJiJniMXoYPoG2cj2rqLOlEZfUjZhFnpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZLDdAIP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGNr/nNr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkJuPkbdEbvr1D9/q5FGwGe2aiPkXcMa/v88BuPKdsA=;
	b=yZLDdAIPOYIcB52Qnz/xUJyrjUzFvrcX2jMeZSHkQlH5B/Q6Sh7ZM7YaNI+t4sCefMTOjF
	l/Md0cklT/05zVFK4Wu+tSuJS/ee70DgNygkfONMJlmtbTrBuDjxy8ZXgri4eDDA4toovd
	/X8Q1bWH41xX8s72paZn3nxvTVAM2TpUP2RzUIx9qLN+DeLOvX9WYQ9H5Oo8DIq0el3eD7
	f9vkQb+nVFwy3GoENnSWhHuiYe68Vz5N3e82SCsKY1Q41rsQoODWydWZOAJzWrAUDN445t
	pk6t3bnUDjAI1AQWA/hTeZMpNwfQ1SuEAHHha5JfSOjNVeg/zx1NXtC8htOUJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkJuPkbdEbvr1D9/q5FGwGe2aiPkXcMa/v88BuPKdsA=;
	b=dGNr/nNrz2bvdkTmrB9YxETJuRAQx1sQTUGQuJXFPrcwy+yMzSKHL1hHSdGs/5pZTabTEY
	Zj8Q5q/QIJsaqbBg==
Date: Thu, 13 Nov 2025 16:30:17 +0100
Subject: [PATCH v2 01/14] Revert "selftests: vDSO: parse_vdso: Use UAPI
 headers instead of libc headers"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-1-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=1846;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5Op/T/eyCK+F5h2kEKIs2m7fYFFJJ7Y0BBAu8h5Itc8=;
 b=3vyDLpbd397jWGe+N6QwdtnJCklB7Ey+qMGVwoRLiXFZz17v4y2DTqkKRmjXNttsggpq0rov3
 BmZs8uc3V6jC+ojKrd5HnqJOhxwje5NKsAHlwXK6fohBB7vYwexFNCS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This reverts commit c9fbaa879508 ("selftests: vDSO: parse_vdso: Use UAPI
headers instead of libc headers")

The kernel headers were used to make parse_vdso.c compatible with
nolibc.  Unfortunately linux/elf.h is incompatible with glibc's
sys/auxv.h. When using glibc it is therefore not possible build
parse_vdso.c as part of the same compilation unit as its caller
as sys/auxv.h is needed for getauxval().

In the meantime nolibc gained its own elf.h, providing compatibility
with the documented libc interfaces.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/Makefile     | 2 --
 tools/testing/selftests/vDSO/parse_vdso.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index f94ea07cddc97ea8b13d8bed2b35a32bb99a2423..74dfc60e636edce91cc1df9643ca8aa008ecfe65 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -19,8 +19,6 @@ endif
 
 include ../lib.mk
 
-CFLAGS += $(TOOLS_INCLUDES)
-
 CFLAGS_NOLIBC := -nostdlib -nostdinc -ffreestanding -fno-asynchronous-unwind-tables \
 		 -fno-stack-protector -include $(top_srcdir)/tools/include/nolibc/nolibc.h \
 		 -I$(top_srcdir)/tools/include/nolibc/ $(KHDR_INCLUDES)
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 3ff00fb624a44b964cc54954f1f088cabe11a901..c6ff4413ea367ae57bc6a60073314b29f938c99d 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -19,8 +19,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <limits.h>
-#include <linux/auxvec.h>
-#include <linux/elf.h>
+#include <elf.h>
 
 #include "parse_vdso.h"
 

-- 
2.51.0


