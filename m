Return-Path: <linux-kselftest+bounces-45555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15093C5888C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935314265B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B763559FE;
	Thu, 13 Nov 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tpZJ6RB2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQDJJmYk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8555A355800;
	Thu, 13 Nov 2025 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047874; cv=none; b=cNJgEXiUfGe4UJEJmTHSKyHuhV/PVVKK6tTVcU0eABM9OoQmRmNKr5oh2lriRnKVxet9D9CwV9684ivpuAXLoQwoIA5l30709EjMetb+G3G9iIww1KhgJ/1CkPD5XWw3zVEulWKJDv3DDiADIEThw83XyEUAlr5ousAH9PU+HhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047874; c=relaxed/simple;
	bh=aE/WV2Mi+bsanJlDrSl9gQQohVGvHhC6JpfJzLKQvZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KXqzBrlHo2BlA3KidT9PXNOQRGxp8oRx3gMrPfYuYmmAgkw6pyqPtgw6FOJyA4cJNIa0VQqYGk6dH+Rvw9suPvpNVkeQrJfcx4NhBBexO99uI7ng4MrKplcYs9MPFxo2ay6gimaz3l7pncb28UFdMDv7HRIE9UNCTVJyGNJ+iWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tpZJ6RB2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQDJJmYk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWRbOr5K7jIjvQLAayug9MX0ujPyaf2nA2ZDGHxUXu0=;
	b=tpZJ6RB2ZIWMQ0un4x93pd20M34fmnMYRKkyy9xaBC7z9leBe5c2jCbWKdnNhuYRHtmPlz
	PB5GhK/opGbBv/sOGccrvw06+bK5vRY2JY9IDaDzTTTTM0dlvOndWlDxWaeGoSNtUeI2q1
	if+QNECS1vQm8b4B1ZLE1OA8nz5l3dAVUyPp8OpM6NYMiaFg4NV9FErZ0fv2EODmhluFj2
	0hZiHpgT+90bhcDXkOuKwWXfxFj7yRlPVhi5Pw9W2mZll/zo026MUa/KE1qiDhP8P/kOMQ
	5M3vmXq2QIhuiKbJDEjThtOnT17HJLZbSXWz3XQolTepEAp58MLvdcT5td+KpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWRbOr5K7jIjvQLAayug9MX0ujPyaf2nA2ZDGHxUXu0=;
	b=sQDJJmYkRj6ZYQGLKn4+GzX6J7z/0ymTCf45xrdzmYLuIGdM3wKrikA/JMitN++QimZYYB
	vhIRj8LI79ziqjAg==
Date: Thu, 13 Nov 2025 16:30:21 +0100
Subject: [PATCH v2 05/14] selftests: vDSO: vdso_test_gettimeofday: Use
 types from vdso_types.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-5-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=1506;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aE/WV2Mi+bsanJlDrSl9gQQohVGvHhC6JpfJzLKQvZ4=;
 b=VNYLn2LfDOqE3yKLgg24YD0/DO4Gw8FiThFchHxpELdfOdSzRVN/FcZc794RaNgNqbD9WlcyP
 Tpd3IKmrrKBBLpWe6rGMsc1dNrMoSFYr5WFLgWkwYF7y/9uTbO4VKuE
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


