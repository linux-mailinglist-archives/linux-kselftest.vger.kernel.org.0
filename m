Return-Path: <linux-kselftest+bounces-16893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB0B9672C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 19:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888721F220CA
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B67F3EA86;
	Sat, 31 Aug 2024 17:11:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425E81E;
	Sat, 31 Aug 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725124305; cv=none; b=X5McUm2X0LvMxc979PLNYICTWWNirLC5Q4Pz+sxSxeAUt0ZI1nzT6sO8Z3qIZbTYjcCoICeu0PaJoCNoDlSP7v/pTbQKIPVjQ/BkJIdDpjStF4uw4r3hNZLgNgTPruW5JVLpIVLdUzDO5VL/BfeaoYRGFH3iO2pXuMUp+UClZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725124305; c=relaxed/simple;
	bh=GLhGRmiZ6Sgd3urA7ewXSYOuW6rVAhmqUnDPRSDRq7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=af3iPYgb6UAdQ/Mho/7wqCOU/65xr40I5D71rbdPdd/ob5eF2/Xh4CAmHUPD1n2xOJr0FSViky67MuxaE+N7D1rtLX3OiAhXAQn9fq5oW+7YK19KBm/AEcszD6jgG1JQvhmN4ODRbx7quWqHtj4YGhoYsiAum5wgY1mfG8nO34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wx1lB5tJ7z9sSK;
	Sat, 31 Aug 2024 19:11:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P11Ppt1QQ7bg; Sat, 31 Aug 2024 19:11:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wx1lB4fkvz9sSC;
	Sat, 31 Aug 2024 19:11:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 91ABA8B76C;
	Sat, 31 Aug 2024 19:11:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 6qfx2MPn75E3; Sat, 31 Aug 2024 19:11:34 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.150])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2DE7D8B764;
	Sat, 31 Aug 2024 19:11:34 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] selftests: vDSO: Do not rely on $ARCH for vdso_test_getrandom && vdso_test_chacha
Date: Sat, 31 Aug 2024 19:11:28 +0200
Message-ID: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725124288; l=6821; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=GLhGRmiZ6Sgd3urA7ewXSYOuW6rVAhmqUnDPRSDRq7o=; b=CmSvxM/8VumUnTNpAxeF5EJRoIcW6UdJ48CI3XuU8BEvrQd7PfhUEcwjT41v75PSM3qzLmooV dOCBiJBChviBZvSjz+C3E5seOlrgViKHdNtan2l5vK8YNFpHPa+kHXL
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

$ARCH is not always enough to know whether getrandom vDSO is supported
or not. For instance on x86 we want it for x86_64 but not i386.

On the other hand, we already have detailed architecture selection in
vdso_config.h, the only difference is that it cannot be used for
Makefile. But most selftests are built regardless of whether a
functionality is supported or not. The return value KSFT_SKIP is there
for than: it tells the test is skipped because it is not supported.

Make the implementation more flexible by setting a VDSO_GETRANDOM
macro in vdso_config.h. That macro contains the path to the file that
defines __arch_chacha20_blocks_nostack(). It avoids the symbolic
link to vdso directory and will allow architectures to have several
implementations of __arch_chacha20_blocks_nostack() if needed.

Then restore the original behaviour which was dedicated to
vdso_standalone_test_x86 and build getrandom and chacha tests all
the time just like other vDSO selftests and return SKIP when the
functionality to be tested is not implemented.

This has the advantage of doing architecture specific selection at
only one place.

Also change vdso_test_getrandom to return SKIP instead of FAIL when
vDSO function is not found, just like vdso_test_getcpu or
vdso_test_gettimeofday.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Based on latest random tree (0dfed8092247)

 tools/arch/x86/vdso                                 |  1 -
 tools/testing/selftests/vDSO/Makefile               | 10 ++++------
 tools/testing/selftests/vDSO/vdso_config.h          |  3 +++
 tools/testing/selftests/vDSO/vdso_test_chacha-asm.S |  7 +++++++
 tools/testing/selftests/vDSO/vdso_test_chacha.c     | 11 +++++++++++
 tools/testing/selftests/vDSO/vdso_test_getrandom.c  |  2 +-
 6 files changed, 26 insertions(+), 8 deletions(-)
 delete mode 120000 tools/arch/x86/vdso
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_chacha-asm.S

diff --git a/tools/arch/x86/vdso b/tools/arch/x86/vdso
deleted file mode 120000
index 7eb962fd3454..000000000000
--- a/tools/arch/x86/vdso
+++ /dev/null
@@ -1 +0,0 @@
-../../../arch/x86/entry/vdso/
\ No newline at end of file
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 5ead6b1f0478..cfb7c281b22c 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-ARCH ?= $(shell uname -m | sed -e s/i.86/x86/)
-SRCARCH := $(subst x86_64,x86,$(ARCH))
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 TEST_GEN_PROGS := vdso_test_gettimeofday
 TEST_GEN_PROGS += vdso_test_getcpu
@@ -10,10 +10,8 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += vdso_test_correctness
-ifeq ($(ARCH),$(filter $(ARCH),x86_64))
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
-endif
 
 CFLAGS := -std=gnu99
 
@@ -38,8 +36,8 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
                                          $(KHDR_INCLUDES) \
                                          -isystem $(top_srcdir)/include/uapi
 
-$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S
+$(OUTPUT)/vdso_test_chacha: vdso_test_chacha-asm.S
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
-                                      -idirafter $(top_srcdir)/arch/$(SRCARCH)/include \
+                                      -idirafter $(top_srcdir)/arch/$(ARCH)/include \
                                       -idirafter $(top_srcdir)/include \
                                       -D__ASSEMBLY__ -Wa,--noexecstack
diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 740ce8c98d2e..693920471160 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -47,6 +47,7 @@
 #elif defined(__x86_64__)
 #define VDSO_VERSION		0
 #define VDSO_NAMES		1
+#define VDSO_GETRANDOM		"../../../../arch/x86/entry/vdso/vgetrandom-chacha.S"
 #elif defined(__riscv__) || defined(__riscv)
 #define VDSO_VERSION		5
 #define VDSO_NAMES		1
@@ -58,6 +59,7 @@
 #define VDSO_NAMES		1
 #endif
 
+#ifndef __ASSEMBLY__
 static const char *versions[7] = {
 	"LINUX_2.6",
 	"LINUX_2.6.15",
@@ -88,5 +90,6 @@ static const char *names[2][7] = {
 		"__vdso_getrandom",
 	},
 };
+#endif
 
 #endif /* __VDSO_CONFIG_H__ */
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S b/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S
new file mode 100644
index 000000000000..8e704165f6f2
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S
@@ -0,0 +1,7 @@
+#include "vdso_config.h"
+
+#ifdef VDSO_GETRANDOM
+
+#include VDSO_GETRANDOM
+
+#endif
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index 3a5a08d857cf..9d18d49a82f8 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -8,6 +8,8 @@
 #include <string.h>
 #include <stdint.h>
 #include <stdbool.h>
+#include <linux/kconfig.h>
+#include "vdso_config.h"
 #include "../kselftest.h"
 
 static uint32_t rol32(uint32_t word, unsigned int shift)
@@ -57,6 +59,10 @@ typedef uint32_t u32;
 typedef uint64_t u64;
 #include <vdso/getrandom.h>
 
+#ifdef VDSO_GETRANDOM
+#define HAVE_VDSO_GETRANDOM	1
+#endif
+
 int main(int argc, char *argv[])
 {
 	enum { TRIALS = 1000, BLOCKS = 128, BLOCK_SIZE = 64 };
@@ -68,6 +74,11 @@ int main(int argc, char *argv[])
 	ksft_print_header();
 	ksft_set_plan(1);
 
+	if (!__is_defined(HAVE_VDSO_GETRANDOM)) {
+		printf("__arch_chacha20_blocks_nostack() not implemented\n");
+		return KSFT_SKIP;
+	}
+
 	for (unsigned int trial = 0; trial < TRIALS; ++trial) {
 		if (getrandom(key, sizeof(key), 0) != sizeof(key)) {
 			printf("getrandom() failed!\n");
diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 8866b65a4605..47ee94b32617 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -115,7 +115,7 @@ static void vgetrandom_init(void)
 	vgrnd.fn = (__typeof__(vgrnd.fn))vdso_sym(version, name);
 	if (!vgrnd.fn) {
 		printf("%s is missing!\n", name);
-		exit(KSFT_FAIL);
+		exit(KSFT_SKIP);
 	}
 	ret = VDSO_CALL(vgrnd.fn, 5, NULL, 0, 0, &vgrnd.params, ~0UL);
 	if (ret == -ENOSYS) {
-- 
2.44.0


