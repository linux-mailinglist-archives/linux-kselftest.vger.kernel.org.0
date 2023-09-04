Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDAB791522
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 11:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351352AbjIDJyR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 05:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348055AbjIDJyQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 05:54:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AC8E54;
        Mon,  4 Sep 2023 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693821241; x=1725357241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QIhDNZOjoBuIRTtsqyOS8+9qZ2I1zQKVMs1FA+2oWcw=;
  b=PKpggrYg8UqPkykYrXjeMy97P4RaTvj57EyiL3aRara33dxc1Wue9ISA
   6xb8EDy3+u8+9mLG9V8mBIFUO+uGDN2em4/VTWEbQXgm3AqY1Py0rg+DB
   oN+vWHKImcd1B/vxi82g3cvgvH5MFSZ+YJOIUq6IHGDV3DXKpwz7+mskb
   5MBtjuXO8vb8P7sU5uYPVEukDTxsARCdgoZ0lKvLGs0q5ChbNpBPN3Bu0
   m2Z3EZYsNUtKyT2BqaUIP+qZwiKZQlbvMiXXrqb6ABnlXHS/39evCjdMR
   AGCA41xgleLSSYrm2ax1Rrmxp01Am/vKuSR6lKhgFY4InAdYq/KwSLNx1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="356880655"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="356880655"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="740700632"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="740700632"
Received: from okozlyk-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.44.17])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:53:57 -0700
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
Subject: [PATCH v5 1/8] selftests/resctrl: Ensure the benchmark commands fits to its array
Date:   Mon,  4 Sep 2023 12:53:32 +0300
Message-Id: <20230904095339.11321-2-ilpo.jarvinen@linux.intel.com>
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

Benchmark command is copied into an array in the stack. The array is
BENCHMARK_ARGS items long but the command line could try to provide a
longer command. Argument size is also fixed by BENCHMARK_ARG_SIZE (63
bytes of space after fitting the terminating \0 character) and user
could have inputted argument longer than that.

Return error in case the benchmark command does not fit to the space
allocated for it.

Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index d511daeb6851..9e2bc8ba95f1 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -255,9 +255,14 @@ int main(int argc, char **argv)
 		return ksft_exit_skip("Not running as root. Skipping...\n");
 
 	if (has_ben) {
+		if (argc - ben_ind >= BENCHMARK_ARGS)
+			ksft_exit_fail_msg("Too long benchmark command.\n");
+
 		/* Extract benchmark command from command line. */
 		for (i = ben_ind; i < argc; i++) {
 			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];
+			if (strlen(argv[i]) >= BENCHMARK_ARG_SIZE)
+				ksft_exit_fail_msg("Too long benchmark command argument.\n");
 			sprintf(benchmark_cmd[i - ben_ind], "%s", argv[i]);
 		}
 		benchmark_cmd[ben_count] = NULL;
-- 
2.30.2

