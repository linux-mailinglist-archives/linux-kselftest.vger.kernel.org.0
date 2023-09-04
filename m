Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE02791539
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 11:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjIDJys (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 05:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbjIDJyr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 05:54:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E31AD;
        Mon,  4 Sep 2023 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693821268; x=1725357268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4f0ZiGdP9qvMi+chEUCuJ8YtsHh7qkSv3SZMl6phZyU=;
  b=gLSHv8+S7zJ/vv2wYNIwueCY9n90faVoqUcRoQlCnCDFYrFSvVUi7I22
   f5CC9m5LbQzl2dDeOrGuxhcIxkim35vo2J98CIEWKR4na64rUKTr8d4Hy
   JFK/iXRnFj7FPDj2izbVbpI6/rF+vQ6pkOachGw/U08PYsavmELeK8qzM
   mkfe6fWQ63bJiq7dJrtsJArssDA3paIvtej0GQMWc/uR43B8I9nKgcLrd
   1sFRJ+keG79GyvhTi6gKlGZ3mObE8HI8Y3fcmCaRjjW0akQ/ZraFoW2wb
   PCNHboLVKLvqUainOJCzcJbW+SPhay5ScQsjiLuqBc4BAPTit4gefUfN5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="356880738"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="356880738"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="740700700"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="740700700"
Received: from okozlyk-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.44.17])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:23 -0700
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
Subject: [PATCH v5 7/8] selftests/resctrl: Remove ben_count variable
Date:   Mon,  4 Sep 2023 12:53:38 +0300
Message-Id: <20230904095339.11321-8-ilpo.jarvinen@linux.intel.com>
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

ben_count is only used to write the terminator for the list. It is
enough to use i from the loop so no need for another variable.

Remove ben_count variable as it is not needed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
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

