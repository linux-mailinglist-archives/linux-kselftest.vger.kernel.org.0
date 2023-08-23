Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E3E785900
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbjHWNS4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 09:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjHWNSf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 09:18:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2556E66;
        Wed, 23 Aug 2023 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692796684; x=1724332684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UkgzjJ9eX8w1l7DbgwNJ3+L1odGvya/GwDebascw+zY=;
  b=JZlcAMJcevD0dKmjt7mj3zlXj1G0emYnV8pm8E34FXLaUN/zAsKMbtvy
   ndyfwLeYZtA7DP2PExWIZtRrI/IX0n163HZC4b2i2WETGcoPAbmkOtZBy
   NxhsDhXlxZ9jwIP7ONaWtPDEUgkC8EIAyZzGV2Yv0AfgeE9Z/A5yzD3qY
   pl5cXX7d/QEOVAFNg76EGyhi5LHCxKUs3kCIcbHaOHfuaLvBHpj/wZs2j
   yWxOqafdVSVxja6csFFYPO0u2+ike47Ofa/aL5kB0CgSTg4U0gd+YprgG
   K1Xa+WUf+pQMjx4/DNjdmcdKBVzvbBvEEz/eZffQPXz4Uk08ylM19UuUM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373044066"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="373044066"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 06:16:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="713572882"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713572882"
Received: from amangalo-mobl4.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.55.236])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 06:16:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 6/7] selftests/resctrl: Remove ben_count variable
Date:   Wed, 23 Aug 2023 16:15:55 +0300
Message-Id: <20230823131556.27617-7-ilpo.jarvinen@linux.intel.com>
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

ben_count is only used to write the terminator for the list. It is
enough to use i from the loop so no need for another variable.

Remove ben_count variable as it is not needed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 84a37bf67306..94516d1f4307 100644
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
 	char *skip_reason;
@@ -181,7 +181,6 @@ int main(int argc, char **argv)
 	for (i = 0; i < argc; i++) {
 		if (strcmp(argv[i], "-b") == 0) {
 			ben_ind = i + 1;
-			ben_count = argc - ben_ind;
 			argc_new = ben_ind - 1;
 			has_ben = true;
 			break;
@@ -258,7 +257,7 @@ int main(int argc, char **argv)
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

