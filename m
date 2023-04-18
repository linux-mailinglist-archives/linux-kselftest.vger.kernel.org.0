Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E8B6E6034
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjDRLqS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjDRLqJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:46:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4E89EFA;
        Tue, 18 Apr 2023 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818349; x=1713354349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XvnhBQByfg3h7H+zzMbDixJv01cITD/50orz6/f0R8s=;
  b=nH+Zml/U6v7XXiV6TAYMPj640qDVeIKur3/O8rozyx2so/ngUiV9tgOW
   TR8+szejk/amPB7WadP5e2VHsN9k2sH5fRftFiVDME2zoUBxEkvpDVaEA
   lRW3/qgvirbWtEm3HFdsM9NZK4PB5TtR/aYSkDPdQjAqQcxQBinQGPzPe
   GmbPXkMda8C8e4GAmySsQi99WWxSYsi0JEEX7rHZdmZ+d9mWy4fvrR9fB
   sl62H+lHJINKzsAQ6Ei6tzuW8D/s13+j7lQ0uvFBqSzDrnn2cwW1/Wjji
   2OZ5bWpGrlvitjMpoXJI3COnF2sgfN/baT8tYdHnDiLlw6I4T7rBMnJ4d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994331"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994331"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601600"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601600"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:46 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 07/24] selftests/resctrl: Remove duplicated preparation for span arg
Date:   Tue, 18 Apr 2023 14:44:49 +0300
Message-Id: <20230418114506.46788-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When no benchmark_cmd is given, benchmark_cmd[1] is set to span in
main(). There's no need to do it again in run_mba_test().

Remove the duplicated preparation for span argument into
benchmark_cmd[1] from run_mba_test(). It enables also removing has_ben
argument from run_mba_test() as unnecessary.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index f1ed2c89f228..3c8ec68eb507 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -99,8 +99,8 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, unsigned long span,
 	umount_resctrlfs();
 }
 
-static void run_mba_test(bool has_ben, char **benchmark_cmd, unsigned long span,
-			 int cpu_no, char *bw_report)
+static void run_mba_test(char **benchmark_cmd, unsigned long span, int cpu_no,
+			 char *bw_report)
 {
 	int res;
 
@@ -117,8 +117,6 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, unsigned long span,
 		goto umount;
 	}
 
-	if (!has_ben)
-		sprintf(benchmark_cmd[1], "%lu", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 
@@ -297,7 +295,7 @@ int main(int argc, char **argv)
 		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
 	if (mba_test)
-		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
+		run_mba_test(benchmark_cmd, span, cpu_no, bw_report);
 
 	if (cmt_test)
 		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
-- 
2.30.2

