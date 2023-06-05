Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE7722E37
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjFESDt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjFESDd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:03:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB08E5D;
        Mon,  5 Jun 2023 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988186; x=1717524186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9EARwlPZfMMlJoAYqZckfPS6SwIENQaRdEYW+Dd8Q3w=;
  b=RdwM3jU2CHdXK9Hnw16nhav7HrytyinHfeqFCrBF9sUJZ3qLfaxja0MQ
   J31O4U93K7YLYxb3q989F9T30RsBshDbYU5LWXETv7EnhGfG1N/adhXus
   R4yP44S4i2LZzKyJwNIWNPEqnSQgXoMzJkGtFJR2iWsbi6t+hm0lzvoDa
   6cg2aEFt85ZCRAHBrydEL6QA8s9T02M8SLkxVe+Xedwu5DJ7T120NGRLw
   oSVoYccC1gbLsyAWf5u24dRJYWldFxzZImHKWcamHe2RPH+RFZjS+j2kH
   3L3V+cjIgAiDjkhU6J9tnPNs341D89ih+d7hidfUcd3ysg8Z9wNIZThN5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442815201"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442815201"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821274172"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821274172"
Received: from gfittedx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:02:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 11/19] selftests/resctrl: Remove duplicated preparation for span arg
Date:   Mon,  5 Jun 2023 21:01:37 +0300
Message-Id: <20230605180145.112924-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
References: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When no benchmark_cmd is given, benchmark_cmd[1] is set to span in
main(). There's no need to do it again in run_mba_test().

Remove the duplicated preparation for span argument into
benchmark_cmd[1] from run_mba_test(). After this, the has_ben and span
arguments to run_mba_test() can be removed.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 0fe83264e925..d54c5fd2c707 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -99,8 +99,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, size_t span,
 	umount_resctrlfs();
 }
 
-static void run_mba_test(bool has_ben, char **benchmark_cmd, size_t span,
-			 int cpu_no, char *bw_report)
+static void run_mba_test(char **benchmark_cmd, int cpu_no, char *bw_report)
 {
 	int res;
 
@@ -117,8 +116,6 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, size_t span,
 		goto umount;
 	}
 
-	if (!has_ben)
-		sprintf(benchmark_cmd[1], "%zu", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 
@@ -298,7 +295,7 @@ int main(int argc, char **argv)
 		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
 	if (mba_test)
-		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
+		run_mba_test(benchmark_cmd, cpu_no, bw_report);
 
 	if (cmt_test)
 		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
-- 
2.30.2

