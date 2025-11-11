Return-Path: <linux-kselftest+bounces-45296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95193C4D3AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2CB420B87
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912CE354703;
	Tue, 11 Nov 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N9ryGHdT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VdU1bGAo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63114350D53;
	Tue, 11 Nov 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858202; cv=none; b=iXDFWuIQ6DZIJBVQmraY7A9iLDqjRpGt4obQZP2qPTpZtw8ZmsGvePLxUghmaNK/nOookBRIAcUUJsGR/C6LseecpJkllHXVWsEcN3lLa4QaxwQ6HC4fRRC9HZXpxeekrm61w0YRS/KTy9RmBG1x8Qc7eo10uQ7hEkoeDKhH9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858202; c=relaxed/simple;
	bh=Q5mSZf+7MhMKjYa8bZA1DaNfmC77pb9wgo99bPVZlqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WsoL+NqSfWZ8pxU2CaUWgakkbRC8CZyf2K8TTMCMppyjB9p84EkIK6eqQfaobCeNarlfPc+jGhVAiIPq+V5byom5ZO943YLhDmUUcACPiEQj39r0qZIhnVAScb5eGzLSCM4nQKZpPdXjeIMuHk8ylpNPmwcdhUq346liDMwg4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N9ryGHdT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VdU1bGAo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762858198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJP89vqyADPfhvP8ZPlnau0zbtJnEIPmJb5qcOrBLl8=;
	b=N9ryGHdTJNSCEOFCRPejU6S6912qeS0LBGEAelBVg39o+74wjqoUpmMKFSDx2s9dP4EQxx
	4WwZK3ST1bWZsEJtWm7ZvNeYgqVNwkRyHenvjGfrFA0mG4kxl7ZRfXHnbXEh+c8UoNXxgU
	bkDrFFOMykvyetLuP0uOxl8bclE9PQDqcMzMpdSZ07FSsKyr1OKbHJOz/QUN8MS3GEykEd
	i6DMqnee6GHoz6PxLxiBbIQnc9e7hSE3CH4IS4uYJWRKOMJe2bO4H4FB1tJoGJdVQ37GuH
	++2ReVomecAeH7Q17Rzts8931eK5DkE2q4cVad/zzbwDYV0hOPQhbNpnH4qEMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762858198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJP89vqyADPfhvP8ZPlnau0zbtJnEIPmJb5qcOrBLl8=;
	b=VdU1bGAoGNPvTs9Rwcf6r/Q26xqbH6qxXwzd+C5kyWBBBRCCeSxwgRBKmnH3sR2d+D6Jos
	6tudacrMRm8B2qCA==
Date: Tue, 11 Nov 2025 11:49:47 +0100
Subject: [PATCH 01/10] Revert "selftests: vDSO: parse_vdso: Use UAPI
 headers instead of libc headers"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251111-vdso-test-types-v1-1-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
In-Reply-To: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762858197; l=1846;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Q5mSZf+7MhMKjYa8bZA1DaNfmC77pb9wgo99bPVZlqs=;
 b=3Hxec+pMUmgW55M4lF1EHCA4py0Rxp1o2wPLKdTKj3wPLG0qb3mccUJRf6JQ/2L2GbmuKeqJA
 k79gvz/2fngBUm7H2JtjayZgq94eIbrx8nxlGsgAOMzoQMHpmhaN7cW
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
index e361aca22a74dc5c279ab1aa16f308b7e6e85bf1..2de5cef311c8ab695606cf7f408c04910842e377 100644
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


