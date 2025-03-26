Return-Path: <linux-kselftest+bounces-29817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CBAA71A4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 16:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC9B37A4CD6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDF11F30D1;
	Wed, 26 Mar 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kDkwiMaw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0AJ4PUxT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE491EFF98;
	Wed, 26 Mar 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002990; cv=none; b=E7oR46vZmbJej1eri1ghX4U1kkiji6z4IrpLnEQrDPMWWGBgxmCYw0NW7MlwdaAui/VKaV2Pe+2sS8Gz0gkPBfQSO/5LqjOIYV1awZGqaOJenrMoPWfP/CZ8RcDNdDQI7gjVCutyrG5919lCDINMR+JoxKKJNp498tdcaRrASIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002990; c=relaxed/simple;
	bh=MLbtTzBQx5OdjYKpjtxDUn5tdndb/5oZLxSoLHDizus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZZ0S7H7EDRW/tNZn6oYEi4AKATI3FppDKXW97D7sO1H6AGUykZSHRu1yqZVyvE1KqGsBX52eBap/cyzrWBAIS4TV3NteAkzXLe7mO4A/zr3q5WhtHxhmbAcSXdmrto0WmBCufLI+EnzZYEjjJGWCC5nX4gyouLwtSQmH+D4912k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kDkwiMaw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0AJ4PUxT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743002986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J0vOEbKpHri4No3U/KbtJIopKffmnQhIcO+bSOOwA4o=;
	b=kDkwiMawiepgnOm4Vg/HlKXvCau0DfkUpx+oIf1XFEmKWrPCtEr67QMFtZigsM/qliOqSl
	yyvpS+fRYRfQBN/KE7snujbvotsmZjKEV6r0UHyho8T2N1TaG/evF9W/MI57H3SL+S7QqG
	+11YoF4H8pgVW7yEa7iJG4/Mg3D1iHheYuN7/Y2BTUwm7skFZj2zMkWt2vSKj+6ozu/UM5
	glwNOJqrG6spmeIibX8fGbdcefg816nsJRjDXGsqmGVi3BpTWWRmnujDUrFm2C2KigZqsu
	Dsrnxm6MR7kk1kNXCVXorLmaULvt7SEF4LJWGTRnSz98WDWX2yNskNGYrCpu8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743002986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J0vOEbKpHri4No3U/KbtJIopKffmnQhIcO+bSOOwA4o=;
	b=0AJ4PUxT+Nfk/Y+4ySXxphPll7KEhFXTCylNQX9V5KR32FldtaEuByyHY2m8fYVUDtUMgB
	oNoOE7e0hOnknNBQ==
Date: Wed, 26 Mar 2025 16:29:42 +0100
Subject: [PATCH] selftests: vDSO: vdso_standalone_test_x86: Replace source
 file with symlink
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-vdso-selftests-fix-vdso_standalone_test_x86-v1-1-682ad396e15e@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAGUd5GcC/x2NUQqEMAxEryL53oBb0cpeRZZS26gBaaUpIoh3t
 /r5Zh4zJwglJoFfdUKinYVjKPD9VOAWG2ZC9oVB1aqtG9Xh7iWi0Dplkiw48fFGRrIN3q4xkHk
 ac/QdusZqPbbaudFDWdwSFf99G/7XdQN8ZJ/rfQAAAA==
X-Change-ID: 20250326-vdso-selftests-fix-vdso_standalone_test_x86-c3a77b57ccbd
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743002982; l=3432;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MLbtTzBQx5OdjYKpjtxDUn5tdndb/5oZLxSoLHDizus=;
 b=K6heyjHjn4vhme5rCfYK1EbZyEbEBMJjhJqNRhuPIaogV3PJ5SK+xfasOXNm4Vdik5YnudZ1Y
 Wfwk5K0gPoDCaK6kY37bitdp/DciB0cR1J+K/Zra7GHNVW1O4UfzyJF
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

---
base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
change-id: 20250326-vdso-selftests-fix-vdso_standalone_test_x86-c3a77b57ccbd

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


