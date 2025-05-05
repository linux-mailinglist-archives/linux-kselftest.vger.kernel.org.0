Return-Path: <linux-kselftest+bounces-32324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF8AA8F4E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9701717509D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4A1FF7B4;
	Mon,  5 May 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ko7tEoKB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TjbbwK4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924811FE46D;
	Mon,  5 May 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436800; cv=none; b=N2926nUrVU9KOfumv/E0JPQX5tYMfQ+9Q0rxJb6g/1MiS86b7En9HN0dCJdqBSAAuzzm/Vw5Ai4+FbxB4mFOwitdwXfgjo5C7iRSpQJmCTWo90hNyYWkHH3M3gPhbNbvB4yJtpbyWODyMszh+F5RO4LLz/LL6NgkJiW/MT7DaJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436800; c=relaxed/simple;
	bh=NofZC/DmnGUuNGlTi2IqNXpglr+RDL+aFfdurFKJ/WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDA0/RT0ZGwk1K/3i5zKnNQvSiSORwm/ee7jfKaY8Z3cz/UM7eeTh4sB2cSYL0/E1m4eRCVDWFYuEq/WBXU8OnJTbF3XSPh4rHak3JCXHQRkqklzCeh8j92NMteN3UNGiYmhLoLJxAj83oxtuR2iIylp/C8TyIZQLUYSqEGrwJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ko7tEoKB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TjbbwK4t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746436796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpSgt7v8Hrv9itXHHVUXHleGLHRYcjyC62pnB8nU680=;
	b=Ko7tEoKBqwcH5ylgnqflLeA+PFzAdbjBolB5pq5Oh365k802ZcEgT3q9gPqafuaQpRwJRA
	AIBE16biVJIhFvFqWD0CRa211BAhuxWbVCgKOoVLdKMdptUVgyi+odZfPkm002OXpwcm/d
	PoQlRa7HYWlLctdAsEFPIx4ORWzb+BEKE2+TX+bQhQnpfCwDuXwMrnVsh0XljS4KgZLXPW
	F0o+zXQnjNPdz6FNM5dcrTZwvOoUlJaOX+tTlxG2XgVwb4N3YNTeFVVQJ6Iylqb0PyoJmL
	MjEhbIWCN/ILoS3oXtn+PjWvaOXgZ91dO/xh9YMFrZ2CKcg7vORmw4gis3bVFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746436796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpSgt7v8Hrv9itXHHVUXHleGLHRYcjyC62pnB8nU680=;
	b=TjbbwK4tyOLsWLOK06H8UsATrSPLz7fc6A96WdgGUpQQ3gYxuSZKvN8MnV3JWK/wD8KA5r
	byLxq+8Bvn2bt7BQ==
Date: Mon, 05 May 2025 11:19:41 +0200
Subject: [PATCH v2 7/8] selftests: vDSO: vdso_test_correctness: Fix
 -Wstrict-prototypes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-selftests-vdso-fixes-v2-7-3bc86e42f242@linutronix.de>
References: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
In-Reply-To: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436782; l=1813;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NofZC/DmnGUuNGlTi2IqNXpglr+RDL+aFfdurFKJ/WI=;
 b=FoQaxDdRmUXL311eQvrGxpFjqNYX+GxlfAF7rWSSYg0RCW3JU+7hzn0zaMZJCh7w3uT2aY5H6
 YUUF9Ob01ICD6QcuYzbiuHzWMw8RhaHXtjpvO8lap6ZShzCGKG8wxpE
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


