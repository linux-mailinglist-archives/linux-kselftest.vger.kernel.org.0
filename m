Return-Path: <linux-kselftest+bounces-27596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D796A45D7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBEE171CC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F54F21C19F;
	Wed, 26 Feb 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nasqugvG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CWmvpnCr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E521A436;
	Wed, 26 Feb 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570318; cv=none; b=hI64Fr8mEZ4d5fyinH7jG8TrST5yIT07wtzZf3f9NHDnJusiSXb08CFeyfhMgQgOBWrd5iry4+gzYPikHxu3mGj3RR2udzwBIjRHYDDJWdd3lcl+rIYxRRhOgLuJtd9Qyd0PI7IG1SNepvhAVvSfTtp1/OV3F9aEOrKwIgHa2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570318; c=relaxed/simple;
	bh=C3WrIXo4pF6mfQdzvKKu1BjqdXgy4M3jnZi0dZUjrCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4d/2kd79LUa5PArcFqn30DpG5VzR92EhK93My06+I+Pki3I1UZIVrhM3NYPGz0w5VQkK1f0iMffxdeW0D7c+2WAdNLpuTThiFyVDnD8VqBWJ2k3TrhW5FHkwnGTX7vcUfmC9aB6IGFKYaCdm1GhOS4Q01HTvQsTIUH+U9AiVLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nasqugvG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CWmvpnCr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRuD5hbVHSSw/8cljIctKIY+Y3ZkYhQFJxv3Eq1eG8c=;
	b=nasqugvGFKackdKOCTch+AP72kWRqEucxypuXDsMds9gPwL8RK61E3IAURJfFRwVz6qCFV
	borLyAg+H0LG9tWwXNBlUwuDFwYZPS4sMuMxBeAx6ObJr9TGjNFDhtRAWyulzmylyhWtwJ
	P723Y+vsU/GF2dTuLScSrd42stge6MnfiMB8FerpsLUDR/zDnvtjIEmaOYfykQmjZqPh6N
	9J2wj71O+zBQnyIXpq2/C7y6QezLH5rhiXHdkKjY0lULjTCFb6/K4L75NxQ/9D4sys6/zp
	nDlUnoAgYdIMx/DPTHflxDyqMuOQYiBxugcpuMRiDOgqbdn4WR2SX8G87j/Qbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRuD5hbVHSSw/8cljIctKIY+Y3ZkYhQFJxv3Eq1eG8c=;
	b=CWmvpnCrI4ggnNzOB2bFK5VZej2qGU4p7haIEM0fQFYcPsUdGJejZoOoBmHUpDnIp5RS2p
	vfN2Hj/oogOEL1BA==
Date: Wed, 26 Feb 2025 12:44:49 +0100
Subject: [PATCH v2 10/16] selftests: vDSO: vdso_standalone_test_x86: Use
 vdso_init_form_sysinfo_ehdr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-10-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=1895;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=C3WrIXo4pF6mfQdzvKKu1BjqdXgy4M3jnZi0dZUjrCw=;
 b=eQDHEgBbcQlTMN155d79X04vEswgzq72yKppWr5aBDgxbIbLYxd/IvNp2Y1YQ9/fNaQ7z11QT
 DAUfoLznQjjCZKLGqX216kBJX2mCS9MUbVbIRKbqrvmzEqOe0Ab+zYq
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vdso_standalone_test_x86 is the only user of vdso_init_from_auxv().
Instead of combining the parsing the aux vector with the parsing of the
vDSO, split them apart into getauxval() and the regular
vdso_init_from_sysinfo_ehdr().

The implementation of getauxval() is taken from
tools/include/nolibc/stdlib.h.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
All of this code will be deleted later again.
---
 .../selftests/vDSO/vdso_standalone_test_x86.c      | 27 +++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
index 644915862af8883131e5defd336f1bd80736fc0f..500608f89c66b5747e3d845ebc54e4c3a35b6ccd 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -15,6 +15,7 @@
 #include <sys/time.h>
 #include <unistd.h>
 #include <stdint.h>
+#include <linux/auxvec.h>
 
 #include "parse_vdso.h"
 
@@ -84,6 +85,30 @@ void to_base10(char *lastdig, time_t n)
 	}
 }
 
+unsigned long getauxval(const unsigned long *auxv, unsigned long type)
+{
+	unsigned long ret;
+
+	if (!auxv)
+		return 0;
+
+	while (1) {
+		if (!auxv[0] && !auxv[1]) {
+			ret = 0;
+			break;
+		}
+
+		if (auxv[0] == type) {
+			ret = auxv[1];
+			break;
+		}
+
+		auxv += 2;
+	}
+
+	return ret;
+}
+
 void c_main(void **stack)
 {
 	/* Parse the stack */
@@ -96,7 +121,7 @@ void c_main(void **stack)
 	stack++;
 
 	/* Now we're pointing at auxv.  Initialize the vDSO parser. */
-	vdso_init_from_auxv((void *)stack);
+	vdso_init_from_sysinfo_ehdr(getauxval((unsigned long *)stack, AT_SYSINFO_EHDR));
 
 	/* Find gettimeofday. */
 	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);

-- 
2.48.1


