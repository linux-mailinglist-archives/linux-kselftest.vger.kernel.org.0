Return-Path: <linux-kselftest+bounces-34686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E63CEAD5219
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348B318987F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFC27781B;
	Wed, 11 Jun 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t79twcnv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wkBL7R0I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0227702C;
	Wed, 11 Jun 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638048; cv=none; b=J2HiMegXjXrAJLxEuD2XaoBAX5var8JTHCxtgIA8NdqLI4ELZN7sO6FfziHyjngk2xI7bskJ9DyYBedULzSYccVfeUmatfovEEFSwCZO89Zht5UN9JW0meuJ9iIDOGp9q0vwPEE27wyTnPUkXpoL5DU/TyGwXDvmNmYL/pl6MIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638048; c=relaxed/simple;
	bh=NofZC/DmnGUuNGlTi2IqNXpglr+RDL+aFfdurFKJ/WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZ5fV9KLHFlQTCrcgjDV524mwZopMHxAnGRHidqUezwrYrZc3wKySJRd3figOaSB97eoPW8SYGqG2UEWrzeR9i5HYSIGPO9aw4G763fk4u92KRFrZruQ3AZ+qxmeRTmM5wew1U97IkqIXiXKjaYAmnknfrLnR5QinaFQhmRjgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t79twcnv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wkBL7R0I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749638045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpSgt7v8Hrv9itXHHVUXHleGLHRYcjyC62pnB8nU680=;
	b=t79twcnvF9BGreh25Lw3lGsmz3RhPMhT5g/IYCC9bkmIY5dWnEDo/cFX7zt6TyAjRu09Wd
	13uJA2pRS2KEKgZEn8V1gBVOZjeZHVwIyf2Z2ITO27KVWwwt15hBCxKgLa47SaCinQKIYH
	pvwP8z2xe/3OKp42LI+Coeyh316hC4JwYhK3ylUjfgTJy1Rn5bBzxiJiD0Q3KW7mkRiuPY
	rT3c1k+W5QwLVvaTio0mEae9fyO/fhLIyP16+o7NTLJX9QJh5gRGmzYmuXSsxD2Rj6iQ/3
	3hijxwT2iix+puNwY3kBiFSLqKu2UKc4+USDYzYk2TzR/l0ELAY9dffcAYsC+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749638045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpSgt7v8Hrv9itXHHVUXHleGLHRYcjyC62pnB8nU680=;
	b=wkBL7R0IxvNWuIqnOkNsJ/q47KW65muOiZFlSxkwQ5I0BWHxEet2fWZRiLIBP7BKb5mMqC
	F/xqQmQ6Uhn53yDw==
Date: Wed, 11 Jun 2025 12:33:57 +0200
Subject: [PATCH v3 7/9] selftests: vDSO: vdso_test_correctness: Fix
 -Wstrict-prototypes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-selftests-vdso-fixes-v3-7-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
In-Reply-To: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749638036; l=1813;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NofZC/DmnGUuNGlTi2IqNXpglr+RDL+aFfdurFKJ/WI=;
 b=RFNWeBgHw1KG+iuiUMsQ/H61i4QFn/qs7FajDA+J4gS4w/nykOM/DRLAQYVP+4AcC61r2XrHW
 dgiVqbylu58APJmFmGlKihIDMsXqDcbBjwBJ7C6Xn7KdswDWrRseSHJ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Functions definitions without any argument list produce a warning with
-Wstrict-prototypes:

vdso_test_correctness.c:111:13: warning: function declaration isn’t a prototype [-Wstrict-prototypes]
  111 | static void fill_function_pointers()
      |             ^~~~~~~~~~~~~~~~~~~~~~

Explicitly use an empty argument list.

Now that all selftests a free of this warning, enable it in the Makefile.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/Makefile                | 2 +-
 tools/testing/selftests/vDSO/vdso_test_correctness.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 06d72254ec75dbdcc2b20935534199fabc40a9de..918a2caa070ebc681a9525f0518afffcf10f5ae3 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -12,7 +12,7 @@ TEST_GEN_PROGS += vdso_test_correctness
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
 
-CFLAGS := -std=gnu99 -O2 -Wall
+CFLAGS := -std=gnu99 -O2 -Wall -Wstrict-prototypes
 
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 5fb97ad67eeaf17b6cfa4f82783c57894f03e5c5..da651cf53c6ca4242085de109c7fc57bd807297c 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -108,7 +108,7 @@ static void *vsyscall_getcpu(void)
 }
 
 
-static void fill_function_pointers()
+static void fill_function_pointers(void)
 {
 	void *vdso = dlopen("linux-vdso.so.1",
 			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);

-- 
2.49.0


