Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF35330242
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhCGOza (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:5870 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231537AbhCGOzK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:10 -0500
IronPort-SDR: SMDaxnbj9jPpBwXfndXXp6HcYy3qpXyPgbFk8jSjBQqQOlf6GNsQgsV8UTm7ByRcDYDM7babzr
 EVc1f/IAv3qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813490"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813490"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:09 -0800
IronPort-SDR: uamEnH5FLUQki28u+PUkRIRx42AgaEmwOmuUuBOI4s0vl2WuIjxFdaH66+v5spFUIkYouDuOtM
 P4GRRKBqpcBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189092"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:09 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 03/21] selftests/resctrl: Fix compilation issues for other global variables
Date:   Sun,  7 Mar 2021 14:54:44 +0000
Message-Id: <20210307145502.2916364-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reinette reported following compilation issue on Fedora 32, gcc version
10.1.1

/usr/bin/ld: resctrl_tests.o:<src_dir>/resctrl.h:65: multiple definition
of `bm_pid'; cache.o:<src_dir>/resctrl.h:65: first defined here

Other variables are ppid, tests_run, llc_occup_path, is_amd. Compiler
isn't happy because these variables are defined globally in two .c files
but are not declared as extern.

To fix issues for the global variables, declare them as extern.

Chang Log:
- Split this patch from v4's patch 1 (Shuah).

Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 959c71e39bdc..12b77182cb44 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -62,11 +62,11 @@ struct resctrl_val_param {
 	int		(*setup)(int num, ...);
 };
 
-pid_t bm_pid, ppid;
-int tests_run;
+extern pid_t bm_pid, ppid;
+extern int tests_run;
 
-char llc_occup_path[1024];
-bool is_amd;
+extern char llc_occup_path[1024];
+extern bool is_amd;
 
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
-- 
2.30.1

