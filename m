Return-Path: <linux-kselftest+bounces-34649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207FEAD4D22
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492213A823A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD0239E7A;
	Wed, 11 Jun 2025 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FtjiXTJr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xIy08ukS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346DE2356DD;
	Wed, 11 Jun 2025 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627517; cv=none; b=LteLd1mBY0eg130WnPsaKvAbNgnr50Q2L6OaAyNy+Rz1xPWaMyKDrnzlE0u/xa1k6r3MTCpTjs/DI5x/o58J9MMnhP5wKQuLHrLCkdsQvPBSnN8BGii7Fet3IfLYEBaAFWiA1RseAYFw/V3snLDyDkUvqrr9mM69OPKIizrwKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627517; c=relaxed/simple;
	bh=NCYTY30jFMB+Vxbmu6gr5/Uxw4+rY0ZcejjmNfEv86U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRWebZMiyPPd/c/Osurtj5NS63OMKfVBmvTwxW4RH8hrbJEduqchPxGiB2OZ+eCIIH/kEHZVyogBCLcXwcf1mwt+7nXNBdUAmUoze2FK0rSjykqJkKeChSva5f2aiuNwIieBXWJFfhaRxDBWkX6s6b9zK7xhXarW9hYmwB6Nisk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FtjiXTJr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xIy08ukS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bG4aMoRqijm3QsbYqiZsQD0WSL7HKO6ZuqtzLxBHQU=;
	b=FtjiXTJrFGffV5jhH+yFjWxWUATl/QvykL8dX798Lj6XiLu2SWe948QyGqN8DeDVUm7NJe
	dhdNr6M2sBpSA47K4GzSqLsJlNUbnU6zny6ovmVNbFQ13U2Ifzf1stY9pypJqyK0g/Iezg
	SoRbmwjZZXoqjQXtBT1Qr/aZ0LsflD+5fbAWggU+H01hue47gmAnkAiQc9iuwJWOLWPqIX
	tHsHRPysx/z8vRn5m5csfz5bpMtFsVVQk48C7mcAqG5peJkRJgeBGRQNPHRXimQtohD3iB
	8/g9ve1Sjo8I7G2ufDq7VWot6Q9s7tcKRLX6JMZqXUdsuMJKzVfly2225Azt6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bG4aMoRqijm3QsbYqiZsQD0WSL7HKO6ZuqtzLxBHQU=;
	b=xIy08ukSjsvelw4n9iDAl/SKLtOjP40mLJaUSwtRzttZ9Kue2Xd0byi/dKPInKbVlzMLz8
	T4CKfurqQSuSpUBA==
Date: Wed, 11 Jun 2025 09:38:11 +0200
Subject: [PATCH v3 05/16] kbuild: introduce CONFIG_ARCH_HAS_NOLIBC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-5-55e3d148cbc6@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Nicolas Schier <nicolas.schier@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=1774;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NCYTY30jFMB+Vxbmu6gr5/Uxw4+rY0ZcejjmNfEv86U=;
 b=C+X62q9na/SevRhmECzkRpWWu/ZtskbFub2LDFhmDIb1LkmC0kEXosS7Qp5TK+9oIMXwYXsvZ
 3j4MvU6yBZDDlcPlW+u3ECJRTUjkZY+yQ2ESvNuM/Pcq9271nNEmAQi
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nolibc does not support all architectures.
Add a kconfig option, so users can know where it is available.

The new option is maintained inside tools/include/nolibc/ as only that
directory is responsible for nolibc's availability.

Reviewed-by: Nicolas Schier <n.schier@avm.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 init/Kconfig                        |  2 ++
 tools/include/nolibc/Kconfig.nolibc | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 26cafbad4f1560fb56b4bef31ae29baf54175661..6d10f2816e453d1d28e4b8249cbbd95c28baa0f1 100644
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
index 0000000000000000000000000000000000000000..29cbc5437e70cbc5e256f00b74d0ab4801b40de7
--- /dev/null
+++ b/tools/include/nolibc/Kconfig.nolibc
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config ARCH_HAS_NOLIBC
+	bool
+	default y if ARM
+	default y if ARM64
+	default y if LOONGARCH
+	default y if M68K
+	default y if MIPS
+	default y if PPC
+	default y if RISCV
+	default y if S390
+	default y if SPARC
+	default y if UML_X86
+	default y if X86

-- 
2.49.0


