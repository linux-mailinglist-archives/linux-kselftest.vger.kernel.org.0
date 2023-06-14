Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA1872F52D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 08:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbjFNGv1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 02:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbjFNGv0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 02:51:26 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A821709
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 23:51:23 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgx0Q6nNQzBQJYj
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 14:51:18 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686725478; x=1689317479; bh=al9eC0wF9Cr04Db3aeUxvwdfMDY
        yTZcCS6mBC7etczI=; b=TH5cjuzqNESH8AIn2MMiag4E6xxN9ju3AMP6SF4CK6p
        AHNhcUZh8AD1kfNDABq2hRomDZ88yeEao6LzL2tgiSYLDir/ck4glkhICi3XCre+
        AvvRgtTPKsf3vTff0404ZJq00EN2BJ4gi2zLKQ9ESdwNe2ynzl7AfsHvi/y7VCe+
        7rPpa1vOHEziYpMR+T9ExeOoiG/BOQgr8IRdkKRGBIg1j0/Izw0gDgX2knfhzeUR
        z05BIkQj6m20bahbTcCresu6x6uGkJIXiFXWFA/SIPFZy+BIXeLVrZUjBUtQFXpK
        xrI/wTY1IkE9AkiMhhuMNuwUORYVxQD+HVo5UVBNy7A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x8P68_pQzn88 for <linux-kselftest@vger.kernel.org>;
        Wed, 14 Jun 2023 14:51:18 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgx0Q3RT1zBJLB3;
        Wed, 14 Jun 2023 14:51:18 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 14:51:18 +0800
From:   baomingtong001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        shuah@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/powerpc: remove unneeded variable
In-Reply-To: <20230614064848.5648-1-luojianhong@cdjrlc.com>
References: <20230614064848.5648-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <d71a676bc9e2af23b3a89459c7320f74@208suo.com>
X-Sender: baomingtong001@208suo.com
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

fix the following coccicheck warning:

tools/testing/selftests/powerpc/alignment/alignment_handler.c:530:5-7: 
Unneeded variable: "rc". Return "0".
tools/testing/selftests/powerpc/alignment/alignment_handler.c:558:5-7: 
Unneeded variable: "rc". Return "0".
tools/testing/selftests/powerpc/alignment/alignment_handler.c:576:5-7: 
Unneeded variable: "rc". Return "0".
tools/testing/selftests/powerpc/alignment/alignment_handler.c:591:5-7: 
Unneeded variable: "rc". Return "0".
tools/testing/selftests/powerpc/alignment/alignment_handler.c:407:5-7: 
Unneeded variable: "rc". Return "0".
tools/testing/selftests/powerpc/alignment/alignment_handler.c:466:5-7: 
Unneeded variable: "rc". Return "0".
tools/testing/selftests/powerpc/alignment/alignment_handler.c:481:5-7: 
Unneeded variable: "rc". Return "0".
tools/testing/selftests/powerpc/alignment/alignment_handler.c:502:5-7: 
Unneeded variable: "rc". Return "0".
tools/testing/selftests/powerpc/alignment/alignment_handler.c:322:5-7: 
Unneeded variable: "rc". Return "0".
tools/testing/selftests/powerpc/alignment/alignment_handler.c:340:5-7: 
Unneeded variable: "rc". Return "0".
tools/testing/selftests/powerpc/alignment/alignment_handler.c:356:5-7: 
Unneeded variable: "rc". Return "0".
tools/testing/selftests/powerpc/alignment/alignment_handler.c:388:5-7: 
Unneeded variable: "rc". Return "0".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  .../powerpc/alignment/alignment_handler.c     | 36 +++++++------------
  1 file changed, 12 insertions(+), 24 deletions(-)

diff --git 
a/tools/testing/selftests/powerpc/alignment/alignment_handler.c 
b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
index 33ee34fc0828..56fc26c2b75a 100644
--- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
+++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
@@ -319,7 +319,6 @@ static bool can_open_cifile(void)

  int test_alignment_handler_vsx_206(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());
      SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
@@ -332,12 +331,11 @@ int test_alignment_handler_vsx_206(void)
      STORE_VSX_XFORM_TEST(stxvd2x);
      STORE_VSX_XFORM_TEST(stxvw4x);
      STORE_VSX_XFORM_TEST(stxsdx);
-    return rc;
+    return 0;
  }

  int test_alignment_handler_vsx_207(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());
      SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_2_07));
@@ -348,12 +346,11 @@ int test_alignment_handler_vsx_207(void)
      LOAD_VSX_XFORM_TEST(lxsiwzx);
      STORE_VSX_XFORM_TEST(stxsspx);
      STORE_VSX_XFORM_TEST(stxsiwx);
-    return rc;
+    return 0;
  }

  int test_alignment_handler_vsx_300(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());

@@ -380,12 +377,11 @@ int test_alignment_handler_vsx_300(void)
      STORE_VSX_XFORM_TEST(stxvx);
      STORE_VSX_XFORM_TEST(stxvl);
      STORE_VSX_XFORM_TEST(stxvll);
-    return rc;
+    return 0;
  }

  int test_alignment_handler_vsx_prefix(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());
      SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
@@ -399,12 +395,11 @@ int test_alignment_handler_vsx_prefix(void)
      STORE_VSX_8LS_PREFIX_TEST(PSTXSSP, 0);
      STORE_VSX_8LS_PREFIX_TEST(PSTXV0, 0);
      STORE_VSX_8LS_PREFIX_TEST(PSTXV1, 1);
-    return rc;
+    return 0;
  }

  int test_alignment_handler_integer(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());

@@ -458,12 +453,11 @@ int test_alignment_handler_integer(void)
      STORE_DFORM_TEST(stmw);
  #endif

-    return rc;
+    return 0;
  }

  int test_alignment_handler_integer_206(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());
      SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
@@ -473,12 +467,11 @@ int test_alignment_handler_integer_206(void)
      LOAD_XFORM_TEST(ldbrx);
      STORE_XFORM_TEST(stdbrx);

-    return rc;
+    return 0;
  }

  int test_alignment_handler_integer_prefix(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());
      SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
@@ -494,12 +487,11 @@ int test_alignment_handler_integer_prefix(void)
      STORE_MLS_PREFIX_TEST(PSTH);
      STORE_MLS_PREFIX_TEST(PSTW);
      STORE_8LS_PREFIX_TEST(PSTD);
-    return rc;
+    return 0;
  }

  int test_alignment_handler_vmx(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());
      SKIP_IF(!have_hwcap(PPC_FEATURE_HAS_ALTIVEC));
@@ -522,12 +514,11 @@ int test_alignment_handler_vmx(void)
      STORE_VMX_XFORM_TEST(stvehx);
      STORE_VMX_XFORM_TEST(stvewx);
      STORE_VMX_XFORM_TEST(stvxl);
-    return rc;
+    return 0;
  }

  int test_alignment_handler_fp(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());

@@ -550,12 +541,11 @@ int test_alignment_handler_fp(void)
      STORE_FLOAT_XFORM_TEST(stfsux);
      STORE_FLOAT_XFORM_TEST(stfiwx);

-    return rc;
+    return 0;
  }

  int test_alignment_handler_fp_205(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());
      SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_05));
@@ -568,12 +558,11 @@ int test_alignment_handler_fp_205(void)
      STORE_FLOAT_DFORM_TEST(stfdp);
      STORE_FLOAT_XFORM_TEST(stfdpx);

-    return rc;
+    return 0;
  }

  int test_alignment_handler_fp_206(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());
      SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
@@ -582,13 +571,12 @@ int test_alignment_handler_fp_206(void)

      LOAD_FLOAT_XFORM_TEST(lfiwzx);

-    return rc;
+    return 0;
  }

  int test_alignment_handler_fp_prefix(void)
  {
-    int rc = 0;

      SKIP_IF(!can_open_cifile());
      SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
@@ -599,7 +587,7 @@ int test_alignment_handler_fp_prefix(void)
      LOAD_FLOAT_MLS_PREFIX_TEST(PLFD);
      STORE_FLOAT_MLS_PREFIX_TEST(PSTFS);
      STORE_FLOAT_MLS_PREFIX_TEST(PSTFD);
-    return rc;
+    return 0;
  }

  void usage(char *prog)
