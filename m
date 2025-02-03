Return-Path: <linux-kselftest+bounces-25544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB116A25556
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60691885BA9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD71FFC71;
	Mon,  3 Feb 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sMnBRWh5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xwTeEsva"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F11FF603;
	Mon,  3 Feb 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573526; cv=none; b=pbvcnD8UWeUBkCYYAXRMdfBjPdzXUwMjF5ErwqTaID68m2U+2NutIXLRG+x6AtLVCoG4hCwY7P+weWsBoAp5ZCzY1CFs6aL5yAz8rV0R0yYU94SfZK/ehqWbGQSJJuqCA6CeubKSKeEn/mkWSG9Vj7qE0R/qO0CNTtNYn9Bdzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573526; c=relaxed/simple;
	bh=C3WrIXo4pF6mfQdzvKKu1BjqdXgy4M3jnZi0dZUjrCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fiq8ICBr8eSOx4cvgHEfIZpLejuqMxxfAs/HH01avRZ/Sr7F+j3b4bV0nIdMnD3awr++Zf4KxJeDneRjeY00I3W94VR3hKujb9oixKj04v+4HInhOo60M1yphUQB33lNicNcmnYULq5Gd38aSBBt33C6s+0tgBoUMVHdX8P3NMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sMnBRWh5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xwTeEsva; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRuD5hbVHSSw/8cljIctKIY+Y3ZkYhQFJxv3Eq1eG8c=;
	b=sMnBRWh5Odu/hj5HZMTeDDMsDUsT1NHGleJvFt0LCBuMV7COMniMpGez18OWPxAgA6u7MG
	X0LXW4hxnmeKSs+3ZS06zwWpivEevPl5q1Zs/Ya0kd488hSx/EEhmi7yHMsnNIiCwDGmaT
	kn9Si5Bv8TDq1iZJavb5pT6bGqInyMMEyGzSDgRWhz/pGJPALzRuGx0oNjCRgdFOGB+Fye
	3ZO72L3jxvwcioTkFQJOdPNG0U9D6Q9ZN81917whURIBSyDbVvtJNzT5V+SVrV9dFXmrFr
	xBVd7BbtrVaWa0v0+QLcNs2f/AI8LyAG+ppaVAdglfVjOqtR1P3okLxGNmmBSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRuD5hbVHSSw/8cljIctKIY+Y3ZkYhQFJxv3Eq1eG8c=;
	b=xwTeEsvab709zFyQI9k93t/nyI1n1BCLhqfH7Pd7esKStlGj7syuEBBF5uT3Oi1q45FpGe
	RtCosuKtkd5H1GBA==
Date: Mon, 03 Feb 2025 10:05:10 +0100
Subject: [PATCH 09/16] selftests: vDSO: vdso_standalone_test_x86: Use
 vdso_init_form_sysinfo_ehdr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-9-9cb6268d77be@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
In-Reply-To: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=1895;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=C3WrIXo4pF6mfQdzvKKu1BjqdXgy4M3jnZi0dZUjrCw=;
 b=vqn4AilDy7ubG5y+C+hp2FjcC5G15khR+tILwCvaP1GUME4dr3rv0qNjecgSBJ09SsGUhU9Ln
 6sEIXscGBezCysoRDXLnNFoAbxqVNBfjeEVRJkZdbJVF7MPnQxvFLvX
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


