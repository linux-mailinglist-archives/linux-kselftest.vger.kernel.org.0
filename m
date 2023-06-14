Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBE172F76E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 10:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjFNIKy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjFNIJj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 04:09:39 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A5170E
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 01:09:38 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgykl6VWWzBQgnx
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 16:09:35 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686730175; x=1689322176; bh=JijrW1fwSsmefAAG9n8gwRM/0xn
        Z2LBWhX2qj/HdfiQ=; b=J/5YZBrJTrfOf71Urz8ML/6OoHkvClOA2hkelQGJI1T
        ok5T222ZYns389Nld9oOUY3Fn1jucn1n89bLqygeiCcgTUVawf95I9OT0eov3jLg
        nGKOk8/BNtRf1O72GaAk9Eh8XeYEm6e2oVAQpDFkoIiwJT9+B/Vz9U+ZIBvjAcQn
        9xtWqAhrIdvJpqDRhP6CHpzGWy+llnG8pIoIy4FF35igi8fBdo4L/sMezgbnl8N6
        nxT2wvT+6US25KMXTSkNPVgdSR8O3oFXOQNctIpmp4YNbxWeKzPBfVwKuA4BZIKg
        ftOrzBxc46kbn5AvsKXAkFqETOfmooeUt/GjoTRGCnA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4Jg4CIYPplLV for <linux-kselftest@vger.kernel.org>;
        Wed, 14 Jun 2023 16:09:35 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgykl4NnyzBQJZ9;
        Wed, 14 Jun 2023 16:09:35 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 16:09:35 +0800
From:   wuyonggang001@208suo.com
To:     w@1wt.eu, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/nolibc: Remove unneeded variable
In-Reply-To: <20230614080240.48197-1-zhanglibing@cdjrlc.com>
References: <20230614080240.48197-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f964d3dbc6362c2cae56bdbdc05befea@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warning:

tools/testing/selftests/nolibc/nolibc-test.c:646:5-8: Unneeded variable: 
"ret". Return "0"

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  tools/testing/selftests/nolibc/nolibc-test.c | 15 ++++++---------
  1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c 
b/tools/testing/selftests/nolibc/nolibc-test.c
index 486334981e60..2b723354e085 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -546,7 +546,6 @@ int run_syscall(int min, int max)
      int proc;
      int test;
      int tmp;
-    int ret = 0;
      void *p1, *p2;

      /* <proc> indicates whether or not /proc is mounted */
@@ -632,18 +631,17 @@ int run_syscall(int min, int max)
          CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, 
syscall(__NR_getpid), getpid()); break;
          CASE_TEST(syscall_args);      EXPECT_SYSER(1, 
syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
          case __LINE__:
-            return ret; /* must be last */
+            return 0; /* must be last */
          /* note: do not set any defaults so as to permit holes above */
          }
      }
-    return ret;
+    return 0;
  }

  int run_stdlib(int min, int max)
  {
      int test;
      int tmp;
-    int ret = 0;
      void *p1, *p2;

      for (test = min; test >= 0 && test <= max; test++) {
@@ -726,11 +724,11 @@ int run_stdlib(int min, int max)
  # warning "__SIZEOF_LONG__ is undefined"
  #endif /* __SIZEOF_LONG__ */
          case __LINE__:
-            return ret; /* must be last */
+            return 0; /* must be last */
          /* note: do not set any defaults so as to permit holes above */
          }
      }
-    return ret;
+    return 0;
  }

  #define EXPECT_VFPRINTF(c, expected, fmt, ...)                \
@@ -790,7 +788,6 @@ static int run_vfprintf(int min, int max)
  {
      int test;
      int tmp;
-    int ret = 0;
      void *p1, *p2;

      for (test = min; test >= 0 && test <= max; test++) {
@@ -810,11 +807,11 @@ static int run_vfprintf(int min, int max)
          CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); 
break;
          CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void 
*) 0x1); break;
          case __LINE__:
-            return ret; /* must be last */
+            return 0; /* must be last */
          /* note: do not set any defaults so as to permit holes above */
          }
      }
-    return ret;
+    return 0;
  }

  static int smash_stack(void)
