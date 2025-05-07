Return-Path: <linux-kselftest+bounces-32593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 355D7AAE8CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410881C413AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F8B28EA79;
	Wed,  7 May 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxTsO8yk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1728EA68;
	Wed,  7 May 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641781; cv=none; b=SK/LdFGGrO2QU7OqPdkwGVb3dvxBUh/UuBs53vVM2RK8ys58HDCqgEHLRCdl8R8zXoEHwQlByiFXIKpS93/TvdE1EDZRIJLmo49DvR/9CMg/52egP44xzzyg0HTjQpl0jekjBZO6X+2w7t7J+i6JC5+V8NRgLxkFHy7AsaH/Y5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641781; c=relaxed/simple;
	bh=HWoalOBMMGh9CGDJhSNrUZqEPdcdOzZUgEuD85/CAd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ro9sqRc+jUr4OgPa+mfZS01P04JZBroqhqaZ8GTri/ub1OejHRyCs9Tbv5WLUZZQPURPm531SaC5Sewxh7924q5N+yccw984OCm4r3riR8TXwBK97fslKqkCOnBYp/BYGTrYhoPX7ll+wdcBXoDnPLHoX0V/F9ayjBq3cO6QRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxTsO8yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415D2C4AF0D;
	Wed,  7 May 2025 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746641781;
	bh=HWoalOBMMGh9CGDJhSNrUZqEPdcdOzZUgEuD85/CAd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxTsO8ykqQtoOsOd9xDG+/enjDzLXUsyguLr8qcMDo7z25PUjNA3ctp+C5+vEU/iz
	 acPEf4SFolFxUXbbWo+yOPM+yOoeM+ecKmTktuuFRwMv7zhdF3FAc9f4w4MtU0SxmH
	 LMMBFfB1Fs5YdHx+JHb01PbWo+v5UXa/GUQlqAx0XW8c5NTL9x/1nSjokQuPwm45hZ
	 WbgmZM+qsjf0qmCZgGyHrUOf1/Dv8v3jFpNvk/ZWIe4liVXUsL3Mxq1tpVxtAmoOX1
	 0g/ZLCu3kk7zpO68JNaDl8pD7mK2VBFfnCeJZvUgWjGwU0tnN0TzoYaOTMZ+5ukiM4
	 YKu967X4A/fow==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kbuild@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 6/8] stackleak: Support Clang stack depth tracking
Date: Wed,  7 May 2025 11:16:12 -0700
Message-Id: <20250507181615.1947159-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507180852.work.231-kees@kernel.org>
References: <20250507180852.work.231-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2395; i=kees@kernel.org; h=from:subject; bh=HWoalOBMMGh9CGDJhSNrUZqEPdcdOzZUgEuD85/CAd4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnSi3OV3f9aX9C6psL+Z4P189SPmrHrPq2vaGzQi7++J e3+b/9ZHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOZW8zIcOOQ8o9DShIK8v8K 78ip3l31Xjeztf3PMTP1fVIJigJ7RBj+absd2iPNURU2fbXh3XVreGuX+2wvdGKVFoni+iFa91+ TGwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Wire up CONFIG_STACKLEAK to Clang 21's new stack depth tracking
callback[1] option.

Link: https://clang.llvm.org/docs/SanitizerCoverage.html#tracing-stack-depth [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas.schier@linux.dev>
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: <linux-kbuild@vger.kernel.org>
Cc: <kasan-dev@googlegroups.com>
Cc: <linux-hardening@vger.kernel.org>
---
 security/Kconfig.hardening | 5 ++++-
 scripts/Makefile.stackleak | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 2be6aed71c92..94aa8612c4e4 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -158,10 +158,13 @@ config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	  initialized. Since not all existing initializers are detected
 	  by the plugin, this can produce false positive warnings.
 
+config CC_HAS_SANCOV_STACK_DEPTH_CALLBACK
+	def_bool $(cc-option,-fsanitize-coverage-stack-depth-callback-min=1)
+
 config STACKLEAK
 	bool "Poison kernel stack before returning from syscalls"
 	depends on HAVE_ARCH_STACKLEAK
-	depends on GCC_PLUGINS
+	depends on GCC_PLUGINS || CC_HAS_SANCOV_STACK_DEPTH_CALLBACK
 	help
 	  This option makes the kernel erase the kernel stack before
 	  returning from system calls. This has the effect of leaving
diff --git a/scripts/Makefile.stackleak b/scripts/Makefile.stackleak
index 1db0835b29d4..639cc32bcd1d 100644
--- a/scripts/Makefile.stackleak
+++ b/scripts/Makefile.stackleak
@@ -8,6 +8,12 @@ stackleak-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE) += -fplugin-arg-stacklea
 DISABLE_STACKLEAK  := -fplugin-arg-stackleak_plugin-disable
 endif
 
+ifdef CONFIG_CC_IS_CLANG
+stackleak-cflags-y += -fsanitize-coverage=stack-depth
+stackleak-cflags-y += -fsanitize-coverage-stack-depth-callback-min=$(CONFIG_STACKLEAK_TRACK_MIN_SIZE)
+DISABLE_STACKLEAK  := -fno-sanitize-coverage=stack-depth
+endif
+
 STACKLEAK_CFLAGS   := $(stackleak-cflags-y)
 
 export STACKLEAK_CFLAGS DISABLE_STACKLEAK
-- 
2.34.1


