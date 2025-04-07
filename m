Return-Path: <linux-kselftest+bounces-30222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7FFA7D67E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0DC188A81A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A34022655E;
	Mon,  7 Apr 2025 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IN3DPG78";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X6W2bmZL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CCC224259;
	Mon,  7 Apr 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011782; cv=none; b=n45xLvGwt2PtBfvgnzXoNo7bCPEZtWzCYzV0pcvX/+R5BOgjhN7tVdlecB1viecOGct/NLFQPL8n4YqnsUgQNb6oX5urUIsm7MTUqZpjTnvOXfqsXoDtREgkqhYfEmiz1/TT/IMgns2poHrKKWz5CMLfWheJmZG6E9zlZZDk3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011782; c=relaxed/simple;
	bh=hMsH2whwJq0cQmVjJiNwx2jThvXh8C810oX/uNh66Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvMLCmkUg6s07ZDHBurj8qGEKiCh+8VGQ0VqpDYIzCohv/AVA4oV309H+3DLQKe4AwMdyBuHR6YgsiQ02lSR4/2Klz8SnN6MdqchOfhuQZlWY3bG0KObIJ+uxwMiyJd+TFfM+V3vCHd8PAEojkaMLJ7bq3tU++/9ZJUcIN0SBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IN3DPG78; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X6W2bmZL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3P1ftOqJGlh3OYId8jLnR+64DoJM4jPC3xvoE1umU8=;
	b=IN3DPG78Bg6HGQX4+Nu23i31mfEiJomhNaCoeTQGtWTBbyQixj7zefW9APzJLSzw7XQ6tq
	GNl8ZFuHC33po18OrIlHiB+NHqOeutb3bV5T/WEU0VHrO0S5uxRzGG7wFiyo2Y3dOcEWeE
	vAScPESbFUkYZQNAYv7qFm8HVSnKnggbZaM6NtWltWXxOMuIcLL1CZ5fVdKtXNORxkf17I
	AyzrtNggH4/l+s/fNWkBDTV13c8Dks3yckCkrBH93WA5V88RX5RuJShOIFudv6MxUbaSWg
	VsvixZLelBfp4zZah7S8tyjk8U7A7wVn8BCNC+4CGXQnwg+Mc1N7djZY1ifpqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3P1ftOqJGlh3OYId8jLnR+64DoJM4jPC3xvoE1umU8=;
	b=X6W2bmZLzH4IrpQkxP6uK/2tOHeix3Hw8bVFRDVUgjW5OXUKBhBh0GDR9p6UXQaRxtkdbb
	UUkMb11+OoDlDdCQ==
Date: Mon, 07 Apr 2025 09:42:39 +0200
Subject: [PATCH v2 02/11] kbuild: introduce CONFIG_ARCH_HAS_NOLIBC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-kselftests-v2-2-454114e287fd@linutronix.de>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
In-Reply-To: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=1682;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hMsH2whwJq0cQmVjJiNwx2jThvXh8C810oX/uNh66Qs=;
 b=Oyh90OX8Z62DpMfsUaHwzFuY11dxkrcm8TX5qRGZ6JLvARhk6fjYjaFeXgApOGD7K6aT4bj2d
 10esdoXtl/AAs280erdcxohKzLguCOs6zYRhJ4NR5ZY2P0ouIZf+i6/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nolibc does not support all architectures.
Add a kconfig option, so users can know where it is available.

The new option is maintained inside tools/include/nolibc/ as only that
directory is responsible for nolibc's availability.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 init/Kconfig                        |  2 ++
 tools/include/nolibc/Kconfig.nolibc | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index dd2ea3b9a799205daa4c1f0c694a9027e344c690..661079a71f30d8d7894d51726686801f8a25b50b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -92,6 +92,8 @@ config CC_CAN_LINK_STATIC
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
 
+source "tools/include/nolibc/Kconfig.nolibc"
+
 # Fixed in GCC 14, 13.3, 12.4 and 11.5
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
 config GCC_ASM_GOTO_OUTPUT_BROKEN
diff --git a/tools/include/nolibc/Kconfig.nolibc b/tools/include/nolibc/Kconfig.nolibc
new file mode 100644
index 0000000000000000000000000000000000000000..60408f02d0da3275c70f550b98a9e60c1558238f
--- /dev/null
+++ b/tools/include/nolibc/Kconfig.nolibc
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config ARCH_HAS_NOLIBC
+	bool
+	default y if X86
+	default y if ARM
+	default y if ARM64
+	default y if PPC
+	default y if MIPS
+	default y if LOONGARCH
+	default y if RISCV
+	default y if S390
+	default y if UML_X86

-- 
2.49.0


