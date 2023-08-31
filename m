Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1E378EB65
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 13:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244579AbjHaLJF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 07:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244724AbjHaLJE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 07:09:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB78CF4;
        Thu, 31 Aug 2023 04:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693480141; x=1725016141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XQXK6fhjhXcfZH4QEGgWP4TrZpjHicumuuVlnvT5mfs=;
  b=Zm86+X/A19N/heX1af7wMXUD1urXMZBRBvTiPRcltRbEgIgzSaLBGUWn
   wkz8aljMW331bQvP+8qBy9YlFDNN7xTq+zvxKRJ2RZ1BlOsQgaADDhsu3
   AjsXr797AE8bJNaJcZrdZYwGHuvFLFEa5uZkyw9OCc2IhEERsAiUkdQZP
   0ZgNxA4Yadx2I3xn/aA8q5W95K4aIfdFvDcb6Qx0M0pPBTqTS74sfDucd
   vNYmaraLV6S8XlHpI3elDJ27eXGnnxiCdMpGuTvksOuG99TmnJFulhezy
   Rj3ov1p+X6zapRgvCgPNNPAPT4U28TNDdQIqvqmWqznk2vqigcwzuz6M5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="439852203"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="439852203"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="863020934"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="863020934"
Received: from pshishpo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.214.20])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:08:58 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 1/8] selftests/resctrl: Ensure the benchmark commands fits to its array
Date:   Thu, 31 Aug 2023 14:08:36 +0300
Message-Id: <20230831110843.26719-2-ilpo.jarvinen@linux.intel.com>
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
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index d511daeb6851..a9331b31c32d 100644
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
+			if (strlen(argv[i]) >= BENCHMARK_ARG_SIZE - 1)
+				ksft_exit_fail_msg("Too long benchmark command argument.\n");
 			sprintf(benchmark_cmd[i - ben_ind], "%s", argv[i]);
 		}
 		benchmark_cmd[ben_count] = NULL;
-- 
2.30.2

