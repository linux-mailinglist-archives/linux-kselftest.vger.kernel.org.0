Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17752770E7C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 09:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjHEHiU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 03:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEHiT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 03:38:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8AA4ECB;
        Sat,  5 Aug 2023 00:38:18 -0700 (PDT)
Received: from localhost.localdomain (unknown [59.103.216.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F7D16607185;
        Sat,  5 Aug 2023 08:38:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691221096;
        bh=T1gmHJSmBZ1fsUMOMsX2TjrN4WmMi/RdeZt+BUdWBE4=;
        h=From:To:Cc:Subject:Date:From;
        b=mreXjLAsnKYryATtZ8P1ASgsHotjTcLRyKzRdkGE00wN3/dkfyl+3tvQGUs56Mfvc
         VLC6Qpv0dvdXI2fXXpqvC0fZSveMq6zyKreNgexdvPo53zfVr2Vc0zGlVPcFNLsGee
         JM38/VUtvZttrbKdTof33pwMhmhmaOVhHyqfKoxfxCS683g48OCjbnjdHK8+r7u475
         jIAFzk1iSHeYXHrCKcFk9umHtQtWwileMpQyl84mtm6OUwQq46XeoG76/9kgjeSduy
         nLaTSWuOj5DqVer2G6GzvinziQsVOOfiXKFtKKV8OaIYAKa/UhlaNI0ynKggPKitlN
         0ZONSjcbX02dg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] selftests: capabilities: remove duplicate unneeded defines
Date:   Sat,  5 Aug 2023 12:37:59 +0500
Message-Id: <20230805073809.1753462-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
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
 tools/testing/selftests/capabilities/Makefile       | 2 +-
 tools/testing/selftests/capabilities/test_execve.c  | 8 --------
 tools/testing/selftests/capabilities/validate_cap.c | 8 --------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/tools/testing/selftests/capabilities/Makefile b/tools/testing/selftests/capabilities/Makefile
index 6e9d98d457d5b..411ac098308f1 100644
--- a/tools/testing/selftests/capabilities/Makefile
+++ b/tools/testing/selftests/capabilities/Makefile
@@ -2,7 +2,7 @@
 TEST_GEN_FILES := validate_cap
 TEST_GEN_PROGS := test_execve
 
-CFLAGS += -O2 -g -std=gnu99 -Wall
+CFLAGS += -O2 -g -std=gnu99 -Wall $(KHDR_INCLUDES)
 LDLIBS += -lcap-ng -lrt -ldl
 
 include ../lib.mk
diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index df0ef02b40367..e3a352b020a79 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -20,14 +20,6 @@
 
 #include "../kselftest.h"
 
-#ifndef PR_CAP_AMBIENT
-#define PR_CAP_AMBIENT			47
-# define PR_CAP_AMBIENT_IS_SET		1
-# define PR_CAP_AMBIENT_RAISE		2
-# define PR_CAP_AMBIENT_LOWER		3
-# define PR_CAP_AMBIENT_CLEAR_ALL	4
-#endif
-
 static int nerrs;
 static pid_t mpid;	/*  main() pid is used to avoid duplicate test counts */
 
diff --git a/tools/testing/selftests/capabilities/validate_cap.c b/tools/testing/selftests/capabilities/validate_cap.c
index cdfc94268fe6e..60b4e7b716a75 100644
--- a/tools/testing/selftests/capabilities/validate_cap.c
+++ b/tools/testing/selftests/capabilities/validate_cap.c
@@ -9,14 +9,6 @@
 
 #include "../kselftest.h"
 
-#ifndef PR_CAP_AMBIENT
-#define PR_CAP_AMBIENT			47
-# define PR_CAP_AMBIENT_IS_SET		1
-# define PR_CAP_AMBIENT_RAISE		2
-# define PR_CAP_AMBIENT_LOWER		3
-# define PR_CAP_AMBIENT_CLEAR_ALL	4
-#endif
-
 #if __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 19)
 # define HAVE_GETAUXVAL
 #endif
-- 
2.39.2

