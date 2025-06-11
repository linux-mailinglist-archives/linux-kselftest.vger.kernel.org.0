Return-Path: <linux-kselftest+bounces-34688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D671AD521C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5938C1BC3BD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACFD2797B1;
	Wed, 11 Jun 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1kFXDPGc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pk1wJk3t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568C27875C;
	Wed, 11 Jun 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638051; cv=none; b=AWhz9WlL3ShGn9AwDPv2xxEOqt1jiBKfRM4kaQ0NPgjv55zLTYOS8BTfVgOPaPFSS9PlJ0q/uWY12H3p3V64XqipE1wBQ/QWQKoafOlCTnYWQS41II04STxwIwkTcDqK9jueBrEmdZkTyA2rI8QeIXkgEGgnG/FRO7VswooBOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638051; c=relaxed/simple;
	bh=owT0IqKZrmXfpFVIFSxWZ8tODMcTTrsVbJpX/11Psvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEuz1tO+4v5MiNcvVSd2yoRlJW/UWVHpnlI07nI/2MaJ/qybkbEXBBvjTq1h9HVAtJphZcGSr245OwcfX8XeQOBXJWoKN4zwHlxZQPUuVJMPKVFyuizrzR7yPzBJTPi9/US0DuT6OLeov/92MK9t2qGdtqkfs5GpYEZAJtpNTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1kFXDPGc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pk1wJk3t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749638047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5neFC7G/s72w2dzYTYdUxPwPnB727dQ0pCaRBuSPo4o=;
	b=1kFXDPGcXiO9gMKzebm9vEy2P+J7usRKCpe5yokbTxV137YsqxlKnbdX8xdHJE4kzqtCEk
	Jb62iS48ViJChVLLZ7e8cimgb68ZTaJaTFhlT6O2wZ6Cg2ZLIPWl2ZUSLA6qqAZGXkxmoQ
	tRS9BeU2Z8P07O2Ptme3HYXEbCoHl88ko32ENDBSQTBG/gCkdmaZxPWe9VD3lEbqOCnr89
	Xo8yWB05wV5ivz2De86Pc+mZsIcFZbd33vVC8CphYvRluTfZvrB7WXdtjYo0UMdPEdH/LR
	yVTaELPbuN+auQBkFxIo74LEFpP3x4BqpS9NF2t7xxuj6vKmSg0qeHP2BnWhXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749638047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5neFC7G/s72w2dzYTYdUxPwPnB727dQ0pCaRBuSPo4o=;
	b=pk1wJk3tgfgUK/D51nfRp1IX7jQhfX7SD/FnyIUyLN6O+jrZEev1ecCr2Ahb5D+ZovRMj2
	TV8kOONJDQpNKaDQ==
Date: Wed, 11 Jun 2025 12:33:59 +0200
Subject: [PATCH v3 9/9] selftests: vDSO: vdso_standalone_test_x86: Replace
 source file with symlink
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-selftests-vdso-fixes-v3-9-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
In-Reply-To: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749638036; l=3234;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=owT0IqKZrmXfpFVIFSxWZ8tODMcTTrsVbJpX/11Psvw=;
 b=GbMLYG8jc4AN9Y6bqLTEZGhObiz25zuitOM4zcpWZVzzEjU1Q357B9BQrsyuW3ZtBEON2SX0r
 HH9Nrx2/mTSDeFdcGalWEA5o6rjYnxa+eAmqmIECU5w/yYhkmbH7k+P
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With the switch over to nolibc the source file vdso_standalone_test_x86.c
was intended to be replaced with a symlink to vdso_test_gettimeofday.c.
This was the patch that was submitted to LKML, but during application the
symlink was replaced by a textual copy of the linked-to file.

Having two copies introduces the possibility of divergence and increases
maintenance burden, switch back to a symlink.

Link: https://lore.kernel.org/lkml/20250226-parse_vdso-nolibc-v2-16-28e14e031ed8@linutronix.de/
Fixes: 8770a9183fe1 ("selftests: vDSO: vdso_standalone_test_x86: Switch to nolibc")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
If symlinks are problematic an #include shim would also work.
These are not handled really well by the kselftests build system though,
as #include dependencies are not tracked by it.
---
 .../selftests/vDSO/vdso_standalone_test_x86.c      | 59 +---------------------
 1 file changed, 1 insertion(+), 58 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
deleted file mode 100644
index 9ce795b806f0992b83cef78c7e16fac0e54750da..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ /dev/null
@@ -1,58 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * vdso_test_gettimeofday.c: Sample code to test parse_vdso.c and
- *                           vDSO gettimeofday()
- * Copyright (c) 2014 Andy Lutomirski
- *
- * Compile with:
- * gcc -std=gnu99 vdso_test_gettimeofday.c parse_vdso_gettimeofday.c
- *
- * Tested on x86, 32-bit and 64-bit.  It may work on other architectures, too.
- */
-
-#include <stdio.h>
-#ifndef NOLIBC
-#include <sys/auxv.h>
-#include <sys/time.h>
-#endif
-
-#include "../kselftest.h"
-#include "parse_vdso.h"
-#include "vdso_config.h"
-#include "vdso_call.h"
-
-int main(int argc, char **argv)
-{
-	const char *version = versions[VDSO_VERSION];
-	const char **name = (const char **)&names[VDSO_NAMES];
-
-	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
-	if (!sysinfo_ehdr) {
-		printf("AT_SYSINFO_EHDR is not present!\n");
-		return KSFT_SKIP;
-	}
-
-	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
-
-	/* Find gettimeofday. */
-	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
-	gtod_t gtod = (gtod_t)vdso_sym(version, name[0]);
-
-	if (!gtod) {
-		printf("Could not find %s\n", name[0]);
-		return KSFT_SKIP;
-	}
-
-	struct timeval tv;
-	long ret = VDSO_CALL(gtod, 2, &tv, 0);
-
-	if (ret == 0) {
-		printf("The time is %lld.%06lld\n",
-		       (long long)tv.tv_sec, (long long)tv.tv_usec);
-	} else {
-		printf("%s failed\n", name[0]);
-		return KSFT_FAIL;
-	}
-
-	return 0;
-}
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
new file mode 120000
index 0000000000000000000000000000000000000000..4d3d96f1e440c965474681a6f35375a60b3921be
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -0,0 +1 @@
+vdso_test_gettimeofday.c
\ No newline at end of file

-- 
2.49.0


