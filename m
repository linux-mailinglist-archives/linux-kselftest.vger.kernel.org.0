Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF75B33023E
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhCGOz3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:5870 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231571AbhCGOzK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:10 -0500
IronPort-SDR: XY4zi5kffjmshjEmjg8iIpjfu6SSp0wICKr8GdSJHulZXeG5I7gzI+YVgwzbvyb/nqbX7GBV7w
 UMYN06hmzwGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813492"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813492"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:09 -0800
IronPort-SDR: uiLkQZGoqfosUgz+swDVIRfb0Uz9O3/BgaMzrvvKweYhXaZwpULY3oToYoqPB/DPkoOSaYGRRs
 VNzaMa7X3JCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189098"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:09 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 05/21] selftests/resctrl: Ensure sibling CPU is not same as original CPU
Date:   Sun,  7 Mar 2021 14:54:46 +0000
Message-Id: <20210307145502.2916364-6-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

The resctrl tests can accept a CPU on which the tests are run and use
default of CPU #1 if it is not provided. In the CAT test a "sibling CPU"
is determined that is from the same package where another thread will be
run.

The current algorithm with which a "sibling CPU" is determined does not
take the provided/default CPU into account and when that CPU is the
first CPU in a package then the "sibling CPU" will be selected to be the
same CPU since it starts by picking the first CPU from core_siblings_list.

Fix the "sibling CPU" selection by taking the provided/default CPU into
account and ensuring a sibling that is a different CPU is selected.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
v5:
- Move from v4's patch 8 to this patch as the fix patch should be first
  (Shuah).

 tools/testing/selftests/resctrl/resctrlfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 4174e48e06d1..bc52076bee7f 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -268,7 +268,7 @@ int get_core_sibling(int cpu_no)
 	while (token) {
 		sibling_cpu_no = atoi(token);
 		/* Skipping core 0 as we don't want to run test on core 0 */
-		if (sibling_cpu_no != 0)
+		if (sibling_cpu_no != 0 && sibling_cpu_no != cpu_no)
 			break;
 		token = strtok(NULL, "-,");
 	}
-- 
2.30.1

