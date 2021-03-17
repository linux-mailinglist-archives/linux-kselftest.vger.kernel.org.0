Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B317433E6E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhCQCZJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:55653 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhCQCYh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:37 -0400
IronPort-SDR: 1o1/sQxpB0gZvcBkhnAy+Oyyf42m4WXT+swgS4YKz1IshB3T51mqGcoyWxGTZRrsmVSbywHOxC
 hAtbxyN9C5EQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328724"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328724"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:34 -0700
IronPort-SDR: vXfN79S7QTwmfBhMsvsE75rOm7yrmM0uWVCGB8CX7kLIg73p6icmoIJT04VOmaO3eEjbqwrwcr
 nK9qPaR2HBLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290302"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2021 19:24:34 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 21/21] selftests/resctrl: Create .gitignore to include resctrl_tests
Date:   Wed, 17 Mar 2021 02:22:55 +0000
Message-Id: <20210317022255.2536745-22-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create .gitignore to hold the test file resctrl_tests generated after
compiling.

Suggested-by: Shuah Khan <shuah@kernel.org>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
v5:
- Add this patch (Shuah)

 tools/testing/selftests/resctrl/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/.gitignore

diff --git a/tools/testing/selftests/resctrl/.gitignore b/tools/testing/selftests/resctrl/.gitignore
new file mode 100644
index 000000000000..ab68442b6bc8
--- /dev/null
+++ b/tools/testing/selftests/resctrl/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+resctrl_tests
-- 
2.31.0

