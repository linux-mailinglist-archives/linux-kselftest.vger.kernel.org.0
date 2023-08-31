Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31A678EB70
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245229AbjHaLJf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 07:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244885AbjHaLJe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 07:09:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C8EE5E;
        Thu, 31 Aug 2023 04:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693480163; x=1725016163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lr1Q+utxphrLwiDGzulyb5nFkK7bfs2IKt+N1lBvsHw=;
  b=WBoNvDZAfSz7Nendt0MSGEEKdNjfHKIBJ5+r5jJrXON3fKHMFMAjb4d0
   dC9+kgTdyG/QlRDob40Qv3vt7plRJJKQnAFrPrizUd6PU7CXSir2FGdQN
   0B6D+IP2rhTGx649iPZlO1OHS4ZDXq5M4OCbXPaeZz0WN5tzu3kHhNwjP
   u2vv5SS+DDAKlhX7iaXtcqTht2GLTV+oP7RXpxy/mQSZUJoRYwm+PRbBc
   6lwI6N4QCHi/y3TRwW7elDWcOyetrukDhTwgM+rm7ZH5fFUBJri3859RD
   BLKk/KG6UmWWLRwD40rrSsoOiBKc33GgNmtFAGSSQJxm9AN0u+hg7AS46
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="439852295"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="439852295"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="863021070"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="863021070"
Received: from pshishpo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.214.20])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:09:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 7/8] selftests/resctrl: Remove ben_count variable
Date:   Thu, 31 Aug 2023 14:08:42 +0300
Message-Id: <20230831110843.26719-8-ilpo.jarvinen@linux.intel.com>
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

ben_count is only used to write the terminator for the list. It is
enough to use i from the loop so no need for another variable.

Remove ben_count variable as it is not needed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 89edde416f07..48e5afb1530c 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -172,7 +172,7 @@ int main(int argc, char **argv)
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
 	const char *benchmark_cmd[BENCHMARK_ARGS];
-	int ben_ind, ben_count, tests = 0;
+	int ben_ind, tests = 0;
 	char *span_str = NULL;
 	bool cat_test = true;
 	int ret;
@@ -180,7 +180,6 @@ int main(int argc, char **argv)
 	for (i = 0; i < argc; i++) {
 		if (strcmp(argv[i], "-b") == 0) {
 			ben_ind = i + 1;
-			ben_count = argc - ben_ind;
 			argc_new = ben_ind - 1;
 			has_ben = true;
 			break;
@@ -265,7 +264,7 @@ int main(int argc, char **argv)
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

