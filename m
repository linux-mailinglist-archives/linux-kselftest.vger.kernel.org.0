Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE807858DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjHWNRr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 09:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjHWNRp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 09:17:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC65170C;
        Wed, 23 Aug 2023 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692796634; x=1724332634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIZOCpZjGIosGR9hEbRXO2VXgXsR2o3Brc7nxbfgOpA=;
  b=X3Du8V2JzRsEy6tw96D6q1l+iFo0fU5Py748Sqr4V/KTQafykVl4hHUA
   Q99MnRbHiAP3N+JSSlb+NDOaUqfJIHjOTSXMxml8876RHq0ts4P4v/c7I
   BhQV2yRDmQa8sK7I1iBLZ+6mXzRj0eSHE4QS+EXyUtWCY3kNq2S9IXL/C
   feCtNTPm85Reltv42rjVzt385ulpXIshO8SJC6thgEoZodotI8W7fGRC0
   jWHs4p/17Ar9MNzocE11xQfUpZKstavQqU/yJSbOjnW0qwdzvYbOnnOh9
   0FyNI1A1VGNfm6z+xhm9zcmLJvCqs1+Drt1xQuF1pdLc4qIxlIrWsFx4K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373043972"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="373043972"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 06:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="713572718"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713572718"
Received: from amangalo-mobl4.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.55.236])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 06:16:10 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 1/7] selftests/resctrl: Ensure the benchmark commands fits to its array
Date:   Wed, 23 Aug 2023 16:15:50 +0300
Message-Id: <20230823131556.27617-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
References: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index d511daeb6851..1e464ebeac47 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -255,9 +255,14 @@ int main(int argc, char **argv)
 		return ksft_exit_skip("Not running as root. Skipping...\n");
 
 	if (has_ben) {
+		if (argc - ben_ind >= BENCHMARK_ARGS - 1)
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

