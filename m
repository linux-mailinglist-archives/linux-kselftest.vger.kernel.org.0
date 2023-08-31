Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4497F78EB6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345486AbjHaLJY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 07:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345692AbjHaLJX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 07:09:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B06DE47;
        Thu, 31 Aug 2023 04:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693480156; x=1725016156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ozvRGDwAe0Z03AYp0LDWXSaCRHlbnr2jOWAp594etfc=;
  b=Hg0y1h9inV7Qi4VDr4TdefZ4QbOxg38fkbXlL6oP8koMP/uGMvh0oIie
   If2LQGleXs9Ny74+OpKkAnUwE3/SRFvuvM3sE6YV1vJ1/byE+PygqslOV
   qgP95cJ4guqH8PkzL0HVkIF07+WjQqbtcH/evTSX1jAyK2Oo+eznvJ0ZT
   yLCRFvNgameXGdCrcwQ+jIBeSbh4k3z/Mu0o7oliwoJGOJtiJycRAm9h9
   /DComV9jJTPerSay2C8uaKvXIaHVr6ttX7/pvAcpE3BhBN7ItDednirUt
   OMaA32e3Jlz6pv9DL/HMpgLB5Cd2MO54jRuTxFTnGTB8djEE78LSTLgXB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="439852267"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="439852267"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="863021036"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="863021036"
Received: from pshishpo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.214.20])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:09:13 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 5/8] selftests/resctrl: Reorder resctrl FS prep code and benchmark_cmd init
Date:   Thu, 31 Aug 2023 14:08:40 +0300
Message-Id: <20230831110843.26719-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com>
References: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Benchmark command is initialized before resctrl FS check and
preparation code that can call ksft_exit_skip(). There is no strong
reason why the resctrl FS support check and unmounting it (if already
mounted), has to be done after the benchmark command initialization.

Move benchmark command initialization such that it is done not until
right before the tests commence. This simplifies rollback handling when
benchmark command initialization starts to use dynamic allocation (in a
change following this).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 89decda09487..a1b292d5636b 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -252,6 +252,14 @@ int main(int argc, char **argv)
 	if (geteuid() != 0)
 		return ksft_exit_skip("Not running as root. Skipping...\n");
 
+	if (!check_resctrlfs_support())
+		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
+
+	if (umount_resctrlfs())
+		return ksft_exit_skip("resctrl FS unmount failed.\n");
+
+	filter_dmesg();
+
 	if (has_ben) {
 		if (argc - ben_ind >= BENCHMARK_ARGS)
 			ksft_exit_fail_msg("Too long benchmark command.\n");
@@ -277,14 +285,6 @@ int main(int argc, char **argv)
 		benchmark_cmd[5] = NULL;
 	}
 
-	if (!check_resctrlfs_support())
-		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
-
-	if (umount_resctrlfs())
-		return ksft_exit_skip("resctrl FS unmount failed.\n");
-
-	filter_dmesg();
-
 	ksft_set_plan(tests ? : 4);
 
 	if (mbm_test)
-- 
2.30.2

