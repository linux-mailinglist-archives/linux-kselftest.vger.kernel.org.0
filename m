Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A44D17CBA4
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 04:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCGDqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 22:46:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:57577 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgCGDqN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 22:46:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 19:46:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,524,1574150400"; 
   d="scan'208";a="235035997"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2020 19:46:13 -0800
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V1 02/13] selftests/resctrl: Fix typo
Date:   Fri,  6 Mar 2020 19:40:43 -0800
Message-Id: <b57a42ccba086c42dcdcf42d8e450817c22c4cad.1583657204.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

The format "%sok" is used to print results of a test. If the test
passes, the empty string is printed and if the test fails "not " is
printed. This results in output of "ok" when test passes and "not ok"
when test fails.

Fix one instance where "not" (without a space) is printed on test
failure resulting in output of "notok" on test failure.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/cqm_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cqm_test.c
index c8756152bd61..fb4797cfda09 100644
--- a/tools/testing/selftests/resctrl/cqm_test.c
+++ b/tools/testing/selftests/resctrl/cqm_test.c
@@ -58,7 +58,7 @@ static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
 	else
 		res = false;
 
-	printf("%sok CQM: diff within %d, %d\%%\n", res ? "" : "not",
+	printf("%sok CQM: diff within %d, %d\%%\n", res ? "" : "not ",
 	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
 
 	printf("# diff: %ld\n", avg_diff);
-- 
2.7.4

