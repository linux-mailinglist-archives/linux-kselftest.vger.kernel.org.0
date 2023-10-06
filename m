Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C21F7BB4C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjJFKIF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 06:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjJFKIE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 06:08:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3EF9F;
        Fri,  6 Oct 2023 03:08:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.34.184.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54FB96612212;
        Fri,  6 Oct 2023 11:07:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696586880;
        bh=/P0lxjquv/ZpR7Ni5SUJUUznYG0dkXXtdTFeHTzDUQo=;
        h=From:To:Cc:Subject:Date:From;
        b=jrP5aWqxBLjtDs2aLqN/U/f8VbG2WqcULJYTBjKFFBLvQDcjBxW9tvMx6p7w+1JAI
         YuIUBqH82skD1jce04v3XMOqMpvQuJti0FPhIq7t4WmHefpTEs8zenu2WlkPt5t3hs
         xqkLrHYJWvUwuG823jb8wcDLQHpHWaQxG7GuEw1dj0ZCNPCFEOqygjGknF1ymBKqUV
         RARjFl5dV3h89NAmZJJJwK6YyUbgHuOXt4sGsEvfUHctB9Hug6dgMbl8LfyMsI4+8r
         1G/0/hdMZjLgeobtBZQEPNbfhDueSeGxy3rXvbyYgceMhjNZHbGoBmcNsi1WoIbEFC
         ZsT5y5Q6PwJXg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] selftests: capabilities: remove duplicate unneeded defines
Date:   Fri,  6 Oct 2023 15:07:35 +0500
Message-Id: <20231006100743.1631334-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1

