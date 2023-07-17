Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5872275641C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGQNP4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjGQNPo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:15:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F95170A;
        Mon, 17 Jul 2023 06:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599733; x=1721135733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=utpy5BGCIvPzFA+bsfhON0Cfks9MPvt0T8AGQrfu3OI=;
  b=MX5gunKcmkqW1YCmEXWnWfbPK3d62rcHtnUTav0iyPDQbAfAW6NCl5KA
   mAqmuhPJYTyDKy8f3TQikcQBNZuAp6pEbKdwwtDSGOnqqGOCfvdPXELZW
   o1kZ5BGSXkrYrE0mtA75ILrPy8nnhEf4+KQS+lERelzlk9cKsbslGgIEZ
   gRx3ZujRViYDURsRA+TLaXXgd4D6QN7H1uYVOPU8VJZu+xD87bFRlNo/l
   RP33a3yqXMTbMWjIMJuQQ59z1EMEj9SUM0EwF2JdfGaeLw5VQLvkYckql
   5APvsdDGWW35/jmhM3+FgTG+kJNyERe5BFmsNO+mdsTmOrQXiPFJqdwDJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368568857"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368568857"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793246749"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793246749"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:30 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 04/19] selftests/resctrl: Close perf value read fd on errors
Date:   Mon, 17 Jul 2023 16:14:52 +0300
Message-Id: <20230717131507.32420-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Perf event fd (fd_lm) is not closed when run_fill_buf() returns error.

Close fd_lm only in cat_val() to make it easier to track it is always
closed.

Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 8a4fe8693be6..289b619116fe 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -87,21 +87,19 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
 static int get_llc_perf(unsigned long *llc_perf_miss)
 {
 	__u64 total_misses;
+	int ret;
 
 	/* Stop counters after one span to get miss rate */
 
 	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
 
-	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
+	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
+	if (ret == -1) {
 		perror("Could not get llc misses through perf");
-
 		return -1;
 	}
 
 	total_misses = rf_cqm.values[0].value;
-
-	close(fd_lm);
-
 	*llc_perf_miss = total_misses;
 
 	return 0;
@@ -253,19 +251,25 @@ int cat_val(struct resctrl_val_param *param)
 					 memflush, operation, resctrl_val)) {
 				fprintf(stderr, "Error-running fill buffer\n");
 				ret = -1;
-				break;
+				goto pe_close;
 			}
 
 			sleep(1);
 			ret = measure_cache_vals(param, bm_pid);
 			if (ret)
-				break;
+				goto pe_close;
+
+			close(fd_lm);
 		} else {
 			break;
 		}
 	}
 
 	return ret;
+
+pe_close:
+	close(fd_lm);
+	return ret;
 }
 
 /*
-- 
2.30.2

