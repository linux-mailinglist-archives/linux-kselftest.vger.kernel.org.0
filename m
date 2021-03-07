Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1B33023B
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhCGOz1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:5871 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231585AbhCGOzK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:10 -0500
IronPort-SDR: YqnStW/9oba/qzgJeJpx9qn+wFS9RwwjaYlH1IofumW0Zu6idWpZd2r2Qih1uTE3k8lFcZQ2c8
 3vTJdyW55Krg==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813498"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813498"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:10 -0800
IronPort-SDR: rgzkXnqYbWVEMVzAdul3xfw6679MIdO2DQCHIEAz4+Uhd2DT0WAl8r4LG3n99KC1KcWlNHkRsf
 H8IGTlStt4YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189115"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:09 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 10/21] selftests/resctrl: Fix a printed message
Date:   Sun,  7 Mar 2021 14:54:51 +0000
Message-Id: <20210307145502.2916364-11-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

Add a missing newline to the printed help text to improve readability.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
v5:
- Remove the "notok" fix part because the API change fixes it already.

 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index ebc24992cc2c..f1b08afbc3d0 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -37,8 +37,8 @@ void detect_amd(void)
 static void cmd_help(void)
 {
 	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
-	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT");
-	printf("\t default benchmark is builtin fill_buf\n");
+	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT\n");
+	printf("\t   default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
 	printf("e.g. -t mbm, mba, cmt, cat\n");
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
-- 
2.30.1

