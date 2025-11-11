Return-Path: <linux-kselftest+bounces-45304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8911BC4D33B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06461885319
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A209335505B;
	Tue, 11 Nov 2025 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9lolI1B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EyvosTSU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A8354AC6;
	Tue, 11 Nov 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858207; cv=none; b=kKWVET/qnnuVuuYQXuPvUvRAc2yrv9I2MkdVObCpX0o4ePDPWoT5jPSBQ4dldJ/Uranplo58XrJUMjvOZmNJn7vs+lh1Qy9Sz/k+y3L2+CjuwCFjOuad9kEIwHtJ6R1oWo4kmBCjf+9bpYu5MSoGyTG0Wi9mpGgtsFft7cvJgXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858207; c=relaxed/simple;
	bh=aE/WV2Mi+bsanJlDrSl9gQQohVGvHhC6JpfJzLKQvZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8lxe6FuFYukU6lkybqWyrmHNZI38FHFBLGtpfp5kBpiUfEdr3AJ1nVVQ/F2hpEoxpgK21I46ksLkJjF67NRylpInWX+bzAu1bfHGa/ZqHiaosKHU5eYYDaLon3g7ZASe8Z8ZLY/q8P8Iy5zXZwD++GWhtYk+ReAuubhc/LK4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9lolI1B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EyvosTSU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762858201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWRbOr5K7jIjvQLAayug9MX0ujPyaf2nA2ZDGHxUXu0=;
	b=i9lolI1Bn0RSekhyqAdOd2QEQyuNQfRpiFVauBncJw/j0UhgkHldW7kecGbfcSlXNA/yQ8
	MP36fXmxQNxG10xV2HC32sqKCHX49hdTiga8pEKCuctlnV6kC+jh5VZZ08dMXuDVjoNQfr
	ktOUq1xg7Iu7O2m32BOvXMiUibO17G7mLy9UlC7ouUXG7TugAgQFUnR/NJAEsdhn5If7lm
	N5IUIQvL/O6M4MypTLRem110CF7Qu1sTh/DX4ZiKWqjbOVdC3NQJdSMuWhZv8iyk89BN4G
	aSOVLTogPT6Vw6K+C2CGJgg2FXcd20bfC0imGuYM8BSClN7tGDw2ozutnCQxgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762858201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWRbOr5K7jIjvQLAayug9MX0ujPyaf2nA2ZDGHxUXu0=;
	b=EyvosTSUNObO3aUsVv4sVFnmRzSLwrQyEIaGWw1wR9zXbZk9g5nXcBp4wDgx1bd+Ml7GqO
	FsL2Z9MOKz1Sr9BQ==
Date: Tue, 11 Nov 2025 11:49:52 +0100
Subject: [PATCH 06/10] selftests: vDSO: vdso_test_gettimeofday: Use types
 from vdso_types.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251111-vdso-test-types-v1-6-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
In-Reply-To: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762858197; l=1506;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aE/WV2Mi+bsanJlDrSl9gQQohVGvHhC6JpfJzLKQvZ4=;
 b=tEkNcq7+NZy5sFxOA6RFDjM0t4pvowlJ6pVzOV7q9hXnHptafetJy5+rd7wfBsgZgBtgge72w
 FkfLVCp+K69AIh2VSwEu4oThylG8zjMfei8tYMpgKkbkRP38scbMXLF
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The libc types are not necessarily compatible with the vDSO functions.

Use the dedicated types from vdso_types.h instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index 636a56ccf8e4e7943ca446fe3fad6897598ca77f..3c14ed654428e0dbe08e9d44671e82737ac61486 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -12,12 +12,12 @@
 
 #include <stdio.h>
 #include <sys/auxv.h>
-#include <sys/time.h>
 
 #include "../kselftest.h"
 #include "parse_vdso.h"
 #include "vdso_config.h"
 #include "vdso_call.h"
+#include "vdso_types.h"
 
 int main(int argc, char **argv)
 {
@@ -33,15 +33,14 @@ int main(int argc, char **argv)
 	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
 
 	/* Find gettimeofday. */
-	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
-	gtod_t gtod = (gtod_t)vdso_sym(version, name[0]);
+	vdso_gettimeofday_t gtod = (vdso_gettimeofday_t)vdso_sym(version, name[0]);
 
 	if (!gtod) {
 		printf("Could not find %s\n", name[0]);
 		return KSFT_SKIP;
 	}
 
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	long ret = VDSO_CALL(gtod, 2, &tv, 0);
 
 	if (ret == 0) {

-- 
2.51.0


