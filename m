Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B93275237D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjGMNVv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbjGMNVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:21:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F20359F;
        Thu, 13 Jul 2023 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689254458; x=1720790458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BklG/eCoHhbYFvki+htdCl8nS8+nMI8Vo6bNJZ2Xh8o=;
  b=iyBG81ylZduZNI/CzGdFf+gibXqcZt1sd9N9zQURB9AD3bzJxanp3gVt
   T7ziILS64/7N8wznblYpU6fYzloCeIJeALaZDiQaD5tx/AjY1KmaVCTho
   VGRQc4TVd32wRnSAjIh0mhI2zoNosXz7xACivTIhPHdkRpMofIF9j9/8L
   CEQBG0KUfrwzdM1wqfu52T6vrC/T2Ql/fDBD5qFyCFEFP704cYhWU6627
   dxnGsNmfszI4R+vr1ls7ALS07h2J7grCzW3p/KXMdOgmFqNUez+MOIX/W
   T5/AFOXYgLaiBZq4WmDKllfLiv9Bl/OAUd3hCyju59Or3SnklTz4oYSh1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345496801"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="345496801"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968615874"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968615874"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:52 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 11/19] selftests/resctrl: Remove duplicated preparation for span arg
Date:   Thu, 13 Jul 2023 16:19:24 +0300
Message-Id: <20230713131932.133258-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When no benchmark_cmd is given, benchmark_cmd[1] is set to span in
main(). There's no need to do it again in run_mba_test().

Remove the duplicated preparation for span argument into
benchmark_cmd[1] from run_mba_test(). After this, the has_ben and span
arguments to run_mba_test() can be removed.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 5205a13ed250..6e693f381a6e 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -99,8 +99,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, size_t span,
 	umount_resctrlfs();
 }
 
-static void run_mba_test(bool has_ben, char **benchmark_cmd, size_t span,
-			 int cpu_no, char *bw_report)
+static void run_mba_test(char **benchmark_cmd, int cpu_no, char *bw_report)
 {
 	int res;
 
@@ -117,8 +116,6 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, size_t span,
 		goto umount;
 	}
 
-	if (!has_ben)
-		sprintf(benchmark_cmd[1], "%zu", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 
@@ -298,7 +295,7 @@ int main(int argc, char **argv)
 		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
 	if (mba_test)
-		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
+		run_mba_test(benchmark_cmd, cpu_no, bw_report);
 
 	if (cmt_test)
 		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
-- 
2.30.2

