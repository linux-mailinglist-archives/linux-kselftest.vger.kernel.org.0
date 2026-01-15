Return-Path: <linux-kselftest+bounces-48996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DCBD232E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 09:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C2533112E56
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E403346BC;
	Thu, 15 Jan 2026 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIPGLfQS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fTyM0dN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784A334C27;
	Thu, 15 Jan 2026 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465813; cv=none; b=GJAtu/oDIMizkCKtHdirIIyeJaIJBC28OjPxgm2URvHrciAwZT1vD6SPBKqYloRQqBNurGpGs/jAimVnPTvLBa9AxH8/UYHCGW2UrKK2azP6uX8t6zzUNJnX6ObrJ2UWjPbDGSz8Y8WimHzpmr9AU12UGca88Zw3lQbJLcU7ISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465813; c=relaxed/simple;
	bh=aT4hP/Xjaz7+PkNF5DQWPJA6Sb3o1cAR5eFVQ/RwAdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F2RsAzT0Y4viyabz9U8c7kUHmkX98fQ4gqT8n5Po1D+Q1x5bXvX0tw5mRsoChiMEMkckkMCYSFVbQONS7ktN80e+FkH8wmYUKtngCo62D1xsyPpsQSpcj0PVPPNWCS6cnVEzMboXqetxJOCIzKTgY27u7ux5MzVuvmfLzn9py6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIPGLfQS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fTyM0dN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768465800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIAW7yt+HRVaavrO4/GGIGyhQt+lpXP6LVx2zSI/KXc=;
	b=TIPGLfQSzSugXhKQw1yssBHRvchWYzGcuaW8ybb+u2jLmm74sgm78+9ftN5DRnHdBBAQGX
	Jpp1UVu1a1wA3LjIY2L2BX1xLpe6f0qWztL87cE6dSQpoPd5zvhqZ/uL7IcxQteOwtJuzI
	27QR1ckjlpJVusFKivOJMUxeK0SPJ6odESqU/cixRNNVWcgJfv4GgLNM5VkRDc+xQKoreB
	3w6VukK4o29tDoLAEX4q9yAPk9WH2dHckZ11vSv+MNAXaQA7jgoDIWEMDfXupgG1zWNvze
	0EQiPWsyyYrKtx0zZnbqa/ewZ8GEnW/xmS3Pfn6qaIIUeuN9eNV3SmHa44aGKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768465800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIAW7yt+HRVaavrO4/GGIGyhQt+lpXP6LVx2zSI/KXc=;
	b=1fTyM0dNy/EUlGLy7sQnMjBZH2RN0QUXP8zweyJ9e1OkjJI7mEF+qAUyaDrzwY+e+NgU+n
	kDbissPk5F0iJhBw==
Date: Thu, 15 Jan 2026 09:29:53 +0100
Subject: [PATCH 1/6] Revert "selftests: vDSO: parse_vdso: Use UAPI headers
 instead of libc headers"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260115-vdso-selftest-cleanups-v1-1-103e1ccbfdc3@linutronix.de>
References: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
In-Reply-To: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465799; l=1734;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aT4hP/Xjaz7+PkNF5DQWPJA6Sb3o1cAR5eFVQ/RwAdY=;
 b=I1sfybExBJCy65ulQBUldZkCE+AIFZ+APUUjN9OEYTkWzDg9g5zT4tiNtKRpNkqYQe1CyFkzA
 fuWbHkETWwFCQX/MHnM7vOJHxSbM1X38YWCxTZyCnpjPhuXL/06RSYi
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
index e361aca22a74..2de5cef311c8 100644
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
index 3ff00fb624a4..c6ff4413ea36 100644
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
2.52.0


