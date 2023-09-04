Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBECD791535
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 11:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbjIDJyq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352733AbjIDJym (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 05:54:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0461AB;
        Mon,  4 Sep 2023 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693821264; x=1725357264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSx1zJM3KtE7WuZSLuns2rfRmMmTMdKSlrgoe3aP1DY=;
  b=ddZxE/QC1kdpsPBx0Gga7qW4d6SCnvkxo7XL8CC1yTcjCBcRqF+ef2SN
   rG0cuWruUigPilOh4ErD8f8f51qlrFhu/mcUa9sjLqH7bmgM+dCnE0pj0
   gzqfkuMRKsf5YiC3yCzYpQTdd4NQqqZQFAD13DRNbt8VbcfE2I6s68s+x
   WVV/ClMT89sk2b7gd9gR1fdD4R5RBsO30oxCKMwIcbwiL9VMwSkid8cKt
   rMIfxtG4/Zg89ftxQHoIAOke0CpVMJSS78e8RjHWz2lzPOyzmJCf+mb4I
   gh4OBTiQQHDGwLTGdMJDpG4+ADtAyovyyrRmFkYDeFF/spx5dXztM6Q4q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="356880707"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="356880707"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="740700682"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="740700682"
Received: from okozlyk-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.44.17])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:13 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 5/8] selftests/resctrl: Reorder resctrl FS prep code and benchmark_cmd init
Date:   Mon,  4 Sep 2023 12:53:36 +0300
Message-Id: <20230904095339.11321-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
References: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 64e28bde5131..f105e00d6099 100644
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

