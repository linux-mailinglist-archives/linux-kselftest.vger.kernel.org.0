Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF435C6E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Apr 2021 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhDLM6n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 08:58:43 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:58568 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240631AbhDLM6n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 08:58:43 -0400
Received: from wanjb-KLV-WX9.lan (unknown [60.232.195.58])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 14220400381;
        Mon, 12 Apr 2021 20:58:23 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] [v2] selftests: powerpc: Remove unneeded variables
Date:   Mon, 12 Apr 2021 20:57:44 +0800
Message-Id: <20210412125746.2766-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQktISlZDTh1CT0JPS04YTENVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ND46SRw4NT8NEh8XDwEUAUgY
        NDEKCwlVSlVKTUpDSUhJSEtPS0JJVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlN
        S1VJSElVSkJOVU5DWVdZCAFZQUxITkM3Bg++
X-HM-Tid: 0a78c6296015d991kuws14220400381
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix coccicheck warning:

./tools/testing/selftests/powerpc/alignment/alignment_handler.c:539:5-7:
Unneeded variable: "rc". Return "0" on line 562
./tools/testing/selftests/powerpc/alignment/alignment_handler.c:567:5-7:
Unneeded variable: "rc". Return "0" on line 580
./tools/testing/selftests/powerpc/alignment/alignment_handler.c:585:5-7:
Unneeded variable: "rc". Return "0" on line 594
./tools/testing/selftests/powerpc/alignment/alignment_handler.c:600:5-7:
Unneeded variable: "rc". Return "0" on line 611
./tools/testing/selftests/powerpc/alignment/alignment_handler.c:416:5-7:
Unneeded variable: "rc". Return "0" on line 470
./tools/testing/selftests/powerpc/alignment/alignment_handler.c:475:5-7:
Unneeded variable: "rc". Return "0" on line 485
./tools/testing/selftests/powerpc/alignment/alignment_handler.c:490:5-7:
Unneeded variable: "rc". Return "0" on line 506
./tools/testing/selftests/powerpc/alignment/alignment_handler.c:511:5-7:
Unneeded variable: "rc". Return "0" on line 534
./tools/testing/selftests/powerpc/alignment/alignment_handler.c:331:5-7:
Unneeded variable: "rc". Return "0" on line 344
./tools/testing/selftests/powerpc/alignment/alignment_handler.c:349:5-7:
Unneeded variable: "rc". Return "0" on line 360
./tools/testing/selftests/powerpc/alignment/alignment_handler.c:365:5-7:
Unneeded variable: "rc". Return "0" on line 392
./tools/testing/selftests/powerpc/alignment/alignment_handler.c:397:5-7:
Unneeded variable: "rc". Return "0" on line 411

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Modify the subject line.
---
 .../powerpc/alignment/alignment_handler.c     | 48 +++++--------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/powerpc/alignment/alignment_handler.c b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
index c25cf7cd45e9..48bfb7b36d84 100644
--- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
+++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
@@ -328,8 +328,6 @@ static bool can_open_cifile(void)
 
 int test_alignment_handler_vsx_206(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
 
@@ -341,13 +339,11 @@ int test_alignment_handler_vsx_206(void)
 	STORE_VSX_XFORM_TEST(stxvd2x);
 	STORE_VSX_XFORM_TEST(stxvw4x);
 	STORE_VSX_XFORM_TEST(stxsdx);
-	return rc;
+	return 0;
 }
 
 int test_alignment_handler_vsx_207(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_2_07));
 
@@ -357,13 +353,11 @@ int test_alignment_handler_vsx_207(void)
 	LOAD_VSX_XFORM_TEST(lxsiwzx);
 	STORE_VSX_XFORM_TEST(stxsspx);
 	STORE_VSX_XFORM_TEST(stxsiwx);
-	return rc;
+	return 0;
 }
 
 int test_alignment_handler_vsx_300(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
@@ -389,13 +383,11 @@ int test_alignment_handler_vsx_300(void)
 	STORE_VSX_XFORM_TEST(stxvx);
 	STORE_VSX_XFORM_TEST(stxvl);
 	STORE_VSX_XFORM_TEST(stxvll);
-	return rc;
+	return 0;
 }
 
 int test_alignment_handler_vsx_prefix(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
 
@@ -408,13 +400,11 @@ int test_alignment_handler_vsx_prefix(void)
 	STORE_VSX_8LS_PREFIX_TEST(PSTXSSP, 0);
 	STORE_VSX_8LS_PREFIX_TEST(PSTXV0, 0);
 	STORE_VSX_8LS_PREFIX_TEST(PSTXV1, 1);
-	return rc;
+	return 0;
 }
 
 int test_alignment_handler_integer(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 
 	printf("Integer\n");
@@ -467,13 +457,11 @@ int test_alignment_handler_integer(void)
 	STORE_DFORM_TEST(stmw);
 #endif
 
-	return rc;
+	return 0;
 }
 
 int test_alignment_handler_integer_206(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
 
@@ -482,13 +470,11 @@ int test_alignment_handler_integer_206(void)
 	LOAD_XFORM_TEST(ldbrx);
 	STORE_XFORM_TEST(stdbrx);
 
-	return rc;
+	return 0;
 }
 
 int test_alignment_handler_integer_prefix(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
 
@@ -503,13 +489,11 @@ int test_alignment_handler_integer_prefix(void)
 	STORE_MLS_PREFIX_TEST(PSTH);
 	STORE_MLS_PREFIX_TEST(PSTW);
 	STORE_8LS_PREFIX_TEST(PSTD);
-	return rc;
+	return 0;
 }
 
 int test_alignment_handler_vmx(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 	SKIP_IF(!have_hwcap(PPC_FEATURE_HAS_ALTIVEC));
 
@@ -531,13 +515,11 @@ int test_alignment_handler_vmx(void)
 	STORE_VMX_XFORM_TEST(stvehx);
 	STORE_VMX_XFORM_TEST(stvewx);
 	STORE_VMX_XFORM_TEST(stvxl);
-	return rc;
+	return 0;
 }
 
 int test_alignment_handler_fp(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 
 	printf("Floating point\n");
@@ -559,13 +541,11 @@ int test_alignment_handler_fp(void)
 	STORE_FLOAT_XFORM_TEST(stfsux);
 	STORE_FLOAT_XFORM_TEST(stfiwx);
 
-	return rc;
+	return 0;
 }
 
 int test_alignment_handler_fp_205(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_05));
 
@@ -577,13 +557,11 @@ int test_alignment_handler_fp_205(void)
 	STORE_FLOAT_DFORM_TEST(stfdp);
 	STORE_FLOAT_XFORM_TEST(stfdpx);
 
-	return rc;
+	return 0;
 }
 
 int test_alignment_handler_fp_206(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
 
@@ -591,14 +569,12 @@ int test_alignment_handler_fp_206(void)
 
 	LOAD_FLOAT_XFORM_TEST(lfiwzx);
 
-	return rc;
+	return 0;
 }
 
 
 int test_alignment_handler_fp_prefix(void)
 {
-	int rc = 0;
-
 	SKIP_IF(!can_open_cifile());
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
 
@@ -608,7 +584,7 @@ int test_alignment_handler_fp_prefix(void)
 	LOAD_FLOAT_MLS_PREFIX_TEST(PLFD);
 	STORE_FLOAT_MLS_PREFIX_TEST(PSTFS);
 	STORE_FLOAT_MLS_PREFIX_TEST(PSTFD);
-	return rc;
+	return 0;
 }
 
 void usage(char *prog)
-- 
2.30.2

