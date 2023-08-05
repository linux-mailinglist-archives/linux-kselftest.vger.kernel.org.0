Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341AE770E82
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 09:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjHEHiy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 03:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjHEHiq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 03:38:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6761F525A;
        Sat,  5 Aug 2023 00:38:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [59.103.216.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE42E6607185;
        Sat,  5 Aug 2023 08:38:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691221114;
        bh=In4FO/9lllojbgFO3Ya8vVojH0/z+2k6hIAGD5/ABPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2c6VFm8vaNWpSQmI7bqgpZztKbwhXY9nF4UrQHk/Gh3g/43pXLZSj+8vrQQTqRai
         n9gx4IUjluBs2E2AVi9ZG/ONbhctcZbdklyugqCha3VId5pUDlmhFGCRkyKtLX5vol
         RKbdKVkx2KvM/ZF1ghyM690ii3P7XUP2FKn82Uo7oees7sPj3IoNSwZxUTQUO/bupS
         RsOxpxrQLaz6lwC7ASRHKhOMvxSe1ywyxIvwseDU2ljpZd0eNeppC0oeKRdrgh7TCF
         7upUDF6+F33wt7dKdRRgLS5XEQ8auuPmULYUAbCPjGzAAmo4rNHat1M+pRNi6J1n5V
         QUFLbkKhZ4Jmw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] selftests: fchmodat2: remove duplicate unneeded defines
Date:   Sat,  5 Aug 2023 12:38:02 +0500
Message-Id: <20230805073809.1753462-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230805073809.1753462-1-usama.anjum@collabora.com>
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These duplicate defines should automatically be picked up from kernel
headers. Use KHDR_INCLUDES to add kernel header files.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/fchmodat2/Makefile    |  2 +-
 .../selftests/fchmodat2/fchmodat2_test.c      | 20 -------------------
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
index 45b519eab8514..20839f8e43f2a 100644
--- a/tools/testing/selftests/fchmodat2/Makefile
+++ b/tools/testing/selftests/fchmodat2/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
 TEST_GEN_PROGS := fchmodat2_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
index 2d98eb215bc6b..e0319417124d5 100644
--- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -9,26 +9,6 @@
 
 #include "../kselftest.h"
 
-#ifndef __NR_fchmodat2
-	#if defined __alpha__
-		#define __NR_fchmodat2 562
-	#elif defined _MIPS_SIM
-		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
-			#define __NR_fchmodat2 (452 + 4000)
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
-			#define __NR_fchmodat2 (452 + 6000)
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
-			#define __NR_fchmodat2 (452 + 5000)
-		#endif
-	#elif defined __ia64__
-		#define __NR_fchmodat2 (452 + 1024)
-	#else
-		#define __NR_fchmodat2 452
-	#endif
-#endif
-
 int sys_fchmodat2(int dfd, const char *filename, mode_t mode, int flags)
 {
 	int ret = syscall(__NR_fchmodat2, dfd, filename, mode, flags);
-- 
2.39.2

