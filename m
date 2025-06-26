Return-Path: <linux-kselftest+bounces-35821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F9BAE95CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920931C403A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CA625A341;
	Thu, 26 Jun 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UnFTasB0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHZ7tSqJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2E239E61;
	Thu, 26 Jun 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918225; cv=none; b=nRcRO8lj0Rlblc5JUbTiKis+4x9ZxGuPJnVtOuMupK0eNdZSAsPSiRKbOm4X0ky8stjAwGG3BlxxG/IXga1e4GQmT8TfKkQCglXDPKvZCz3NddXxU7TUohFOb/pdHOtksVeUu0OtviecPXdIxNu0Wm8U96AHdIshNL3lQRoir/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918225; c=relaxed/simple;
	bh=j9q82O0F5uqiebw3qSo3efXgJ6wyxTkXdWeLSTmjF+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NewQ8iE1JIwVF2RzpA6UZXj6jaPMdu/oixzygCZDccYPTqbO4Ky6Q1Ad6TeUQ2Sralu0u2lSaAauqYNXfdIIctvC4XV2Hmruc1J0gLjGd9jsjWg9H+tNSB8+2tdhI88QnEsiLjqd87KCr6QNYxhjcXdi9JK2cnoZHUiyeOewkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UnFTasB0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHZ7tSqJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3O+ksBPgEqQWeSBbfJQ4cCno/OA75lx66SsnvePtQs0=;
	b=UnFTasB0/XzuKmoSBgZsKt6ICGZsdHovMrtJyYOZC83R2IPHPlQdzRSWoqu5aB2xq7rq+e
	Cmb4Uvx41bZpD8m5qOGmG5sotv04WpHwrQPVonozKmGyg4e9lo8jm15yiP/vGXGbBaEL9t
	0+FBvvzoXtZ+q6Tjq3sA+Jv3oYJO+wnKLDhVveY7vVLhHnDBQrp697bqdJO7gdXNoNayiB
	x0JXQllnwecDZbiaZU7Eove5kKIVr1Pdj3+xyLeZJqhOIMbDTGpExbAgTdQAB0CFnmBEkI
	eg8LU8DE5SRqDKyHoNREsW8WGscckc3xBzQWktWSdbCeDC5e+hDiOIh5mABR8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3O+ksBPgEqQWeSBbfJQ4cCno/OA75lx66SsnvePtQs0=;
	b=GHZ7tSqJxdvwsS8Thi8N5mTLO7DqmX49KwjTiB4mSEpXa2z/pxNC9ILS0e3moKBItpTJBR
	o16/VXQuTdtXaPBg==
Date: Thu, 26 Jun 2025 08:10:13 +0200
Subject: [PATCH v4 05/15] init: add nolibc build support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-5-48760534fef5@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
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
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=3139;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=j9q82O0F5uqiebw3qSo3efXgJ6wyxTkXdWeLSTmjF+4=;
 b=+8fwcErVHN9PH59sxOwSP7c7yoRgu4HhMTtG4/nA25VU0z93np1aLXGf288gIwCkzknfs6fGy
 1EUjQM+/aWRDrGYr314HS7UzBnptH0lRg/vobyZwcu89gEveB4vJjW7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Building userspace applications through the kbuild "userprogs" framework
requires a libc. Kernel toolchains often do not contain a libc.
In this case it is useful to use the nolibc library from the kernel tree.
Nolibc does not support all architectures and requires compiler flags.

Add a kconfig option, so users can know where it is available and provide a
variable for common options.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 MAINTAINERS          |  2 ++
 init/Kconfig         |  2 ++
 init/Kconfig.nolibc  | 15 +++++++++++++++
 init/Makefile.nolibc | 13 +++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa163f9fe8fe3f04bf66426f9a894409..e806158cc6798cf97a4aab58c038fb5351d469aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17702,6 +17702,8 @@ M:	Willy Tarreau <w@1wt.eu>
 M:	Thomas Weißschuh <linux@weissschuh.net>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
+F:	init/Kconfig.nolibc
+F:	init/Makefile.nolibc
 F:	tools/include/nolibc/
 F:	tools/testing/selftests/nolibc/
 
diff --git a/init/Kconfig b/init/Kconfig
index 26cafbad4f1560fb56b4bef31ae29baf54175661..0af62f135192e0470e16eb6bb2fbb45ac38f4b81 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -92,6 +92,8 @@ config CC_CAN_LINK_STATIC
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
 
+source "init/Kconfig.nolibc"
+
 # Fixed in GCC 14, 13.3, 12.4 and 11.5
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
 config GCC_ASM_GOTO_OUTPUT_BROKEN
diff --git a/init/Kconfig.nolibc b/init/Kconfig.nolibc
new file mode 100644
index 0000000000000000000000000000000000000000..29cbc5437e70cbc5e256f00b74d0ab4801b40de7
--- /dev/null
+++ b/init/Kconfig.nolibc
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
diff --git a/init/Makefile.nolibc b/init/Makefile.nolibc
new file mode 100644
index 0000000000000000000000000000000000000000..a8a193f78e34e0c4a6004e871bc206e06925f88a
--- /dev/null
+++ b/init/Makefile.nolibc
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+# Compiler flags, which are necessary to build userspace applications with the
+# in-kernel libc "nolibc".
+
+ifeq ($(and $(CONFIG_ARCH_HAS_NOLIBC),$(CONFIG_HEADERS_INSTALL)),y)
+
+NOLIBC_USERCFLAGS := -nostdlib -nostdinc -static -ffreestanding \
+		     -fno-asynchronous-unwind-tables -fno-stack-protector \
+		     -isystem $(objtree)/usr/include -isystem $(srctree)/tools/include/nolibc/
+
+NOLIBC_USERLDFLAGS := -nostdlib -nostdinc -static
+
+endif # CONFIG_ARCH_HAS_NOLIBC && CONFIG_HEADERS_INSTALL

-- 
2.50.0


