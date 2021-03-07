Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1011330245
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhCGOzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:5870 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231638AbhCGOzL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:11 -0500
IronPort-SDR: 8BF7a2thKp+AI9GPQa9A7KmXGmQtYpUjA3h/PRH1SHnVl8M0SHKhaRjBdJZ943QvSSroZYIv8v
 EBJNAiljK7Cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813508"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813508"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:10 -0800
IronPort-SDR: hJcCWhI3iMAVs/doR0Mcqjyh77c7+fRAhii0EaYF7ejoZhBceH49AlxoWdcmA5x9pfSAkErqDr
 /no3oG3Hsy0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189149"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:10 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 21/21] selftests/resctrl: Create .gitignore to include resctrl_tests
Date:   Sun,  7 Mar 2021 14:55:02 +0000
Message-Id: <20210307145502.2916364-22-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create .gitignore to hold the test file resctrl_tests generated after
compiling.

Suggested-by: Shuah Khan <shuah@kernel.org>
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
2.30.1

