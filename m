Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2E333E6D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhCQCZC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:55652 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhCQCYf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:35 -0400
IronPort-SDR: SJ4h2nlRoPRhTh1EOselnljBRROstV9xuGEM3cCetEaqUKvjvxeGIW3UItbPQq32Nbt8vT3wM9
 l5OFcaDjDV8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328709"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328709"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:33 -0700
IronPort-SDR: HVXp1k+TMP1UDaQaPehxWXXp7Bj5XhEWRvQF2DDAssxTQTsM/PulBl1UAFPwCx8nNQPTn3cs6o
 NxyFrRIgVCxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290251"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2021 19:24:33 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 05/21] selftests/resctrl: Ensure sibling CPU is not same as original CPU
Date:   Wed, 17 Mar 2021 02:22:39 +0000
Message-Id: <20210317022255.2536745-6-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
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

Tested-by: Babu Moger <babu.moger@amd.com>
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
2.31.0

