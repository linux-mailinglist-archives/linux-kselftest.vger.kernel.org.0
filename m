Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0AF782700
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjHUKX5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 06:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjHUKX4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 06:23:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E29E2;
        Mon, 21 Aug 2023 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692613431; x=1724149431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=llGoiX9kvGRAD6y37KNMcP/C6n/myE64p2AP0zsHirc=;
  b=enU/Lx8AzfqeKNVYsXZh5+w+bP9FYLc3NXCUw6NUhk2KCIggnq0QF54K
   YJIxkWbxzC4qeU7SIDmvKXslZW+iOUbgJ/eV/ejLCwAnn30as0bizSuf5
   8faVWZrZH7RtZg1kFNboPjhS9er/SanRxM1SiZ4gpkr391W7ZD6F9n0kv
   RZc8dLGt1jnMrKliA4/HxBqiaxEP0EIFFNhfyGSOwl0H8Vtq3cjndqq1y
   kqI8jCryj0xtfwWbyB6te8lLKz8gYD0IdskMjEa6f/Qcrf4Q3pGTfhpSQ
   C11PEm++5vYk2wMFvksGkV0VWr+zR2YRobPqeIEcOMxYW8/YX5UBGRg4x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="358530401"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="358530401"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="735798147"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="735798147"
Received: from nsnaveen-mobl.gar.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.54.252])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:23:27 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 6/7] selftests/resctrl: Remove ben_count variable
Date:   Mon, 21 Aug 2023 13:22:44 +0300
Message-Id: <20230821102245.14430-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230821102245.14430-1-ilpo.jarvinen@linux.intel.com>
References: <20230821102245.14430-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ben_count is only used to write the terminator for the list. It is
enough to use i from the loop so no need for another variable.

Remove ben_count variable as it is not needed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 9b582da6f986..b440c4e3e153 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -176,7 +176,7 @@ int main(int argc, char **argv)
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
 	const char *benchmark_cmd[BENCHMARK_ARGS];
-	int ben_ind, ben_count, tests = 0;
+	int ben_ind, tests = 0;
 	char *span_str = NULL;
 	bool cat_test = true;
 	char *skip_reason;
@@ -185,7 +185,6 @@ int main(int argc, char **argv)
 	for (i = 0; i < argc; i++) {
 		if (strcmp(argv[i], "-b") == 0) {
 			ben_ind = i + 1;
-			ben_count = argc - ben_ind;
 			argc_new = ben_ind - 1;
 			has_ben = true;
 			break;
@@ -262,7 +261,7 @@ int main(int argc, char **argv)
 		/* Extract benchmark command from command line. */
 		for (i = 0; i < argc - ben_ind; i++)
 			benchmark_cmd[i] = argv[i + ben_ind];
-		benchmark_cmd[ben_count] = NULL;
+		benchmark_cmd[i] = NULL;
 	} else {
 		/* If no benchmark is given by "-b" argument, use fill_buf. */
 		benchmark_cmd[0] = "fill_buf";
-- 
2.30.2

