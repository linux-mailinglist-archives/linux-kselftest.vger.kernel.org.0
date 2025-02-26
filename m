Return-Path: <linux-kselftest+bounces-27597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E66A45D7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38A918901F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F721CC7D;
	Wed, 26 Feb 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mm50riJ/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gwEw/R+G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736D4A1A;
	Wed, 26 Feb 2025 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570319; cv=none; b=LYb3QYVxBSyijq6yNoAJKHY4aepo9139EhZLgX6xBqUdiwGbKt1Bba/zUZe1jI5xTkWUKMfo9Y7+a8eOQ0xdUb0bTW+8TDzmrYmmlEt8KE0tzeGpEZNBCtfBOAhJbIuw1QVGqEvsMFVj/dcTgiMYZXEXS3IiT0WLygpYW/2OCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570319; c=relaxed/simple;
	bh=A1kWnuxSjddtYmSNb4mmBChj4pwVLpMyiEtralFeWbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSns1yQClSA14yX+zFbeOWzWW86r4881gLcLc6KyKs1Gr9UBW9d6IO2O89KdSl/KUezDkqHr5qHjkU0pwulllSd7s1HRUOvZqmv7kQQYY99yN0Vt0m+4xVZJvGqPqIZnZvY7GqD0oV89tPoJjn7Az32uXqgOhvQGh+Jzxg/XVo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mm50riJ/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gwEw/R+G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vZq6Mizd+5YJ4l7yIE5cDkh9TCxZxJ/8pRyPBqAE2A=;
	b=mm50riJ/QI0hYXWmgp0n2Ceaq6y2i025mU/Nrb8myNu711a1XqRiDrMXNzqa7Tt1hRD1Ra
	3iqNvW3MVDUfUONWeLBASeCGTSBeBf5FnRvFeaPh1cLl4dYaUYSM7RBRXh+VdMF95j1wV2
	c63AcrZP4KXL+322jcLkogbb3//zJd6l9yQk5nYlNVrxglpvjW7HRyt+FWuDRllSmA+G0M
	qPRzw7MyOOPhErWVKSidF0ASRhEeBN8AQczBqVwWj/U0jwY1L48GK7ClkjIb/7Zp2D1o93
	L0+qvX11dFa5cgTeP8Jr8YoA/47FzTwREZkTzGuku1pTPMMM/p5hKQLJNCCZzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vZq6Mizd+5YJ4l7yIE5cDkh9TCxZxJ/8pRyPBqAE2A=;
	b=gwEw/R+GbXArirKPDsiQS2N5OssetzDHeesyeOVlrNMhJCwMZTg+UKL8OGaYLCPX6pvgSF
	z+NIf+s5ryqkapAQ==
Date: Wed, 26 Feb 2025 12:44:50 +0100
Subject: [PATCH v2 11/16] selftests: vDSO: parse_vdso: Drop
 vdso_init_from_auxv()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-11-28e14e031ed8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=1530;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=A1kWnuxSjddtYmSNb4mmBChj4pwVLpMyiEtralFeWbQ=;
 b=6Mmz3dXcabGtLn+Rg9aEA6+Z37gSWfeF8Jy/tPN9nrrE42fFeHYx1hDFmq5TzYJvJGLe1Yz35
 bAGyI6jHtmpBF4EPpdiHgELAoUeTpUf5JZqzrj1TNwYpaxlZtzN0l3N
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There are no users left.

This also removes the usage of ElfXX_auxv_t,
which is not formally standardized.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 14 --------------
 tools/testing/selftests/vDSO/parse_vdso.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 2fe5e983cb22f1ed066d0310a54f6aef2ed77ed8..3638fe605e80ca41b29d43c6ac452964eef35d56 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -297,17 +297,3 @@ void *vdso_sym(const char *version, const char *name)
 
 	return 0;
 }
-
-void vdso_init_from_auxv(void *auxv)
-{
-	ELF(auxv_t) *elf_auxv = auxv;
-	for (int i = 0; elf_auxv[i].a_type != AT_NULL; i++)
-	{
-		if (elf_auxv[i].a_type == AT_SYSINFO_EHDR) {
-			vdso_init_from_sysinfo_ehdr(elf_auxv[i].a_un.a_val);
-			return;
-		}
-	}
-
-	vdso_info.valid = false;
-}
diff --git a/tools/testing/selftests/vDSO/parse_vdso.h b/tools/testing/selftests/vDSO/parse_vdso.h
index de0453067d7cd0d8b63f7d3738842f60370db813..09d068ed11f97f0c5c8f4e7b341f08fa261c9735 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.h
+++ b/tools/testing/selftests/vDSO/parse_vdso.h
@@ -26,6 +26,5 @@
  */
 void *vdso_sym(const char *version, const char *name);
 void vdso_init_from_sysinfo_ehdr(uintptr_t base);
-void vdso_init_from_auxv(void *auxv);
 
 #endif

-- 
2.48.1


