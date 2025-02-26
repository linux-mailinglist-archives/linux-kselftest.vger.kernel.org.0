Return-Path: <linux-kselftest+bounces-27599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FBCA45D83
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92F9171E2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9D21D3FC;
	Wed, 26 Feb 2025 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bcGSb3SQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fqvj2xz2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A95216397;
	Wed, 26 Feb 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570319; cv=none; b=LGYIBhC6i+oTJFwgBDTHJKFT5wNxP5loOD29gJ+bA5gFXuWQCVIiqFU6sOW/oMBKHtfMR535cpj7L0jgmC3UPH3wWsjDZZUrNPLZ9B3J8HHjoJ/qB81gLvpqXbDEFRIx+gsJ1NHfbWm+cHg0XwleV+upoZKPfcyqNgJXHSxCjdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570319; c=relaxed/simple;
	bh=NpOQuxLd7KblcjFPnaDO5YLxwLL0GxVqW0hZLzvIMGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KZj1H0a0uk11I05o2FeQNVHdv9pZunyhVpYATaKo8WKfUyBG6Kd3u3twzuf+Ia4RNvuX+6EGmVeXVmLco2DvKdlzNozOT448A8Q74x1LOCYs3373BWRKwkdB2rPCN4iWM2krKPxMus7bbnZ92HSSI8JrpVLY1+DNrjMrl9+Pb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bcGSb3SQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fqvj2xz2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOyFPIEiH7gm2OvTiVE+dNl/7Ao4pkwSxETN6MXhZOM=;
	b=bcGSb3SQiYGMOQ1VcKhYKOTrklR98D9VpgIchlARBRNfaI5sacVObkXd7dN1ZkhOKvunow
	mNeuEngk3Mf+7cDpevxNf+IwDZZdBgqG3QJ+TiUzrKG8RehOC1YJvQMzzJ7MCLRUnww1ii
	0fkIRJOhubwv3TMvN6TIaQBaCmEXG9EFcVR0sk527PDeOwymkNj6xQoWx5+qJrJY/ha69f
	1NYUiWFVSfS76ThI/0ZEJplxPmmB4diFJVHA0Bwg2upTJp3GSg4lDN9Bn63yD53LqB8TDB
	idMC554DjsFdYljkY2GT14KDJ5pkDlkez/jebzEgHzILbJBUIp3bC8qigg1XmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOyFPIEiH7gm2OvTiVE+dNl/7Ao4pkwSxETN6MXhZOM=;
	b=fqvj2xz2Y7LBfY2kgrkILXYe7OkS3V+0WNM5iI5zyLqVWz4ncPsj5Gug6+BdviZj1p19ht
	J9oq5i6iiypW51BA==
Date: Wed, 26 Feb 2025 12:44:51 +0100
Subject: [PATCH v2 12/16] selftests: vDSO: parse_vdso: Use UAPI headers
 instead of libc headers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-12-28e14e031ed8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=1432;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NpOQuxLd7KblcjFPnaDO5YLxwLL0GxVqW0hZLzvIMGU=;
 b=BydQiC7WSVdw/x16VGHd/isTYEFPQRCC8tWJqgc6V5z56jGxevn7QCMyZsO+B05AJDzv33MAK
 PuOScLjhZV2AIyOKJjKaNG13VKt33YtjRyhTvRtCC08kinDMNFqnNh0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To allow the usage of parse_vdso.c together with a limited libc like
nolibc, use the kernels own elf.h and auxvec.h headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/Makefile     | 3 +++
 tools/testing/selftests/vDSO/parse_vdso.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 1cf14a8da43803249f72fe1b09689c8834806986..bc8ca186fb877dc11740c37f1e07e45e84c2ae92 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -19,6 +19,9 @@ LDLIBS += -lgcc_s
 endif
 
 include ../lib.mk
+
+CFLAGS += $(TOOLS_INCLUDES)
+
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 3638fe605e80ca41b29d43c6ac452964eef35d56..200c534cc70e2c2381fce3be5c0ebe4cb5675e84 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -19,7 +19,8 @@
 #include <stdint.h>
 #include <string.h>
 #include <limits.h>
-#include <elf.h>
+#include <linux/auxvec.h>
+#include <linux/elf.h>
 
 #include "parse_vdso.h"
 

-- 
2.48.1


