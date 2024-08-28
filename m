Return-Path: <linux-kselftest+bounces-16548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB9962963
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 15:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88601285EB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14757172767;
	Wed, 28 Aug 2024 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HP/Mp13X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4397166F12
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853320; cv=none; b=NcveNlMY51/AhTO92I/t/tAdWZrGopl4foWszk0itCggTXVRNGm1Y5etJ/RzwIFzGHrpXTVG15pRn7UiiNDmVun5FGl6ra1cclP44TauiA1EMtBgqX8AaANegwbQDQTXl+pCdPpzbr67T4MilGsyB4R1uX11mnLbazDsj7SJT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853320; c=relaxed/simple;
	bh=SQ2vMFOvErbJplJdylIMCJngKOduTdkQJwlJNWK4DFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgQxJf/0jcV11WxXbH3Wg8j7SpHevyt2KQaMGjUxGt78NbLb0cG0O1+aOln1el3UH0x/EKAjBiAyS2oGeac5KmmorSL+57JvYBeI2AWEE2wI69NvnHiWA8owBHbg2VDlXOmcfFAxv88ibutXqdS3i1qImY6q2OjmceOoXhGoFLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=HP/Mp13X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DB4C98EC6;
	Wed, 28 Aug 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HP/Mp13X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724853317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cQjhV5gdcFxxduXtqmpeetlkIv7a//q0rytcY+GhD9Y=;
	b=HP/Mp13Xe2N6xKubPqdlG1LBGGVerwd6GH2RSLKIWXipJNF76ZIg2TtstuYpPAulQMNlIs
	EbKHtsMa4uatbFgB2sQkziPrr8K2k4EcHZoNN8jIa24Rlr1nEw4kvSQ7Fh5SL4QOdwnif9
	XLK3HDM6mPVJb/d00u7neKk8W4C60j0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 47745ba7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 13:55:16 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kselftest@vger.kernel.org,
	xry111@xry111.site,
	christophe.leroy@csgroup.eu,
	adhemerval.zanella@linaro.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] selftests/vDSO: open code basic chacha instead of linking to libsodium
Date: Wed, 28 Aug 2024 15:55:06 +0200
Message-ID: <20240828135510.3414909-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linking to libsodium makes building this test annoying in cross
compilation environments and is just way too much. Since this is just a
basic correctness test, simply open code a simple, unoptimized, dumb
chacha, rather than linking to libsodium.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/vDSO/Makefile         |  7 +--
 .../testing/selftests/vDSO/vdso_test_chacha.c | 46 ++++++++++++++++++-
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 13a626ef64f7..93c50a462858 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
-SODIUM_LIBS := $(shell pkg-config --libs libsodium 2>/dev/null)
-SODIUM_CFLAGS := $(shell pkg-config --cflags libsodium 2>/dev/null)
 
 TEST_GEN_PROGS := vdso_test_gettimeofday
 TEST_GEN_PROGS += vdso_test_getcpu
@@ -14,10 +12,8 @@ endif
 TEST_GEN_PROGS += vdso_test_correctness
 ifeq ($(uname_M),x86_64)
 TEST_GEN_PROGS += vdso_test_getrandom
-ifneq ($(SODIUM_LIBS),)
 TEST_GEN_PROGS += vdso_test_chacha
 endif
-endif
 
 CFLAGS := -std=gnu99
 
@@ -43,8 +39,7 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
                                          -isystem $(top_srcdir)/include/uapi
 
 $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(ARCH)/vdso/vgetrandom-chacha.S
-$(OUTPUT)/vdso_test_chacha: LDLIBS += $(SODIUM_LIBS)
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
                                       -idirafter $(top_srcdir)/arch/$(ARCH)/include \
                                       -idirafter $(top_srcdir)/include \
-                                      -D__ASSEMBLY__ -Wa,--noexecstack $(SODIUM_CFLAGS)
+                                      -D__ASSEMBLY__ -Wa,--noexecstack
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index ca5639d02969..019e8fbdf570 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
-#include <sodium/crypto_stream_chacha20.h>
 #include <sys/random.h>
 #include <string.h>
 #include <stdint.h>
@@ -14,6 +13,49 @@ typedef uint8_t u8;
 typedef uint32_t u32;
 typedef uint64_t u64;
 #include <vdso/getrandom.h>
+#include <tools/le_byteshift.h>
+
+static u32 rol32(u32 word, unsigned int shift)
+{
+	return (word << (shift & 31)) | (word >> ((-shift) & 31));
+}
+
+static void reference_chacha20_blocks(u8 *dst_bytes, const u32 *key, size_t nblocks)
+{
+	u32 s[16] = {
+		0x61707865U, 0x3320646eU, 0x79622d32U, 0x6b206574U,
+		key[0], key[1], key[2], key[3], key[4], key[5], key[6], key[7]
+	};
+
+	while (nblocks--) {
+		u32 x[16];
+		memcpy(x, s, sizeof(x));
+		for (unsigned int r = 0; r < 20; r += 2) {
+		#define QR(a, b, c, d) ( \
+			x[a] += x[b], \
+			x[d] = rol32(x[d] ^ x[a], 16), \
+			x[c] += x[d], \
+			x[b] = rol32(x[b] ^ x[c], 12), \
+			x[a] += x[b], \
+			x[d] = rol32(x[d] ^ x[a], 8), \
+			x[c] += x[d], \
+			x[b] = rol32(x[b] ^ x[c], 7))
+
+			QR(0, 4, 8, 12);
+			QR(1, 5, 9, 13);
+			QR(2, 6, 10, 14);
+			QR(3, 7, 11, 15);
+			QR(0, 5, 10, 15);
+			QR(1, 6, 11, 12);
+			QR(2, 7, 8, 13);
+			QR(3, 4, 9, 14);
+		}
+		for (unsigned int i = 0; i < 16; ++i, dst_bytes += sizeof(u32))
+			put_unaligned_le32(x[i] + s[i], dst_bytes);
+		if (!++s[12])
+			++s[13];
+	}
+}
 
 int main(int argc, char *argv[])
 {
@@ -31,7 +73,7 @@ int main(int argc, char *argv[])
 			printf("getrandom() failed!\n");
 			return KSFT_SKIP;
 		}
-		crypto_stream_chacha20(output1, sizeof(output1), nonce, (uint8_t *)key);
+		reference_chacha20_blocks(output1, key, BLOCKS);
 		for (unsigned int split = 0; split < BLOCKS; ++split) {
 			memset(output2, 'X', sizeof(output2));
 			memset(counter, 0, sizeof(counter));
-- 
2.46.0


