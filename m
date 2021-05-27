Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4323929D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 May 2021 10:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhE0It0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 May 2021 04:49:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:37974 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235457AbhE0ItZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 May 2021 04:49:25 -0400
IronPort-SDR: psRkKszfQ1tQlQ7bcYn1GblHqSmKqPAeUz/7FG1XECt6TlTtYs7JU2xhYP+sLu73F/8kDUuvWV
 jSkmmxUSCKmg==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="199643609"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="199643609"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 01:47:41 -0700
IronPort-SDR: gSd5OEyWbYGYUDl0sJB6wLFBAC1oofaYg/9qI6LSfDslwDsCBhKiqY+Q+lOoaW18o0qowdMq6I
 bbZdlQFliWaw==
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="443472181"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 01:47:34 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     shuah@kernel.org, tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     babu.moger@amd.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH] selftests/resctrl: Fix incorrect parsing of option "-t"
Date:   Thu, 27 May 2021 17:31:53 +0800
Message-Id: <1622107913-22186-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Resctrl test suite accepts command line argument "-t" to specify the
unit tests to run in the test list (e.g., -t mbm,mba,cmt,cat) as
documented in the help.

When calling strtok() to parse the option, the incorrect delimiters
argument ":\t" is used. As a result, passing "-t mbm,mba,cmt,cat" throws
an invalid option error.

Fix this by using delimiters argument "," instead of ":\t" for parsing
of unit tests list. At the same time, remove the unnecessary "spaces"
between the unit tests in help documentation to prevent confusion.

Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Fixes: 034c7678dd2c ("selftests/resctrl: Add README for resctrl tests")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 tools/testing/selftests/resctrl/README          | 2 +-
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
index 4b36b25b6ac0..3d2bbd4fa3aa 100644
--- a/tools/testing/selftests/resctrl/README
+++ b/tools/testing/selftests/resctrl/README
@@ -47,7 +47,7 @@ Parameter '-h' shows usage information.
 
 usage: resctrl_tests [-h] [-b "benchmark_cmd [options]"] [-t test list] [-n no_of_bits]
         -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT default benchmark is builtin fill_buf
-        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cmt, cat
+        -t test list: run tests specified in the test list, e.g. -t mbm,mba,cmt,cat
         -n no_of_bits: run cache tests using specified no of bits in cache bit mask
         -p cpu_no: specify CPU number to run the test. 1 is default
         -h: help
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index f51b5fc066a3..973f09a66e1e 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -40,7 +40,7 @@ static void cmd_help(void)
 	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT\n");
 	printf("\t   default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
-	printf("e.g. -t mbm, mba, cmt, cat\n");
+	printf("e.g. -t mbm,mba,cmt,cat\n");
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
 	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
 	printf("\t-h: help\n");
@@ -173,7 +173,7 @@ int main(int argc, char **argv)
 
 					return -1;
 				}
-				token = strtok(NULL, ":\t");
+				token = strtok(NULL, ",");
 			}
 			break;
 		case 'p':
-- 
1.8.3.1

