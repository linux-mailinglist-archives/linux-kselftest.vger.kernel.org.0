Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969CF2945A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410624AbgJTXwc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:52:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:54960 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410708AbgJTXvb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:31 -0400
IronPort-SDR: dR+1YH3fiTNCgxlJVZ4PU5uBysjLGtUvfNRaxDqrnaYabItjGXu6vaWHVBBooZ7CinxJHxHqxT
 NOZZ7oV+cRCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="164686723"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="164686723"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:30 -0700
IronPort-SDR: JsBpaXDUtVVUTRdEYrIjdmzlvym7X67C1SI00YYXWVLCt+dsnom5T7CIWV1y8fmAv0x4U8EYKp
 1sjr0WDc4EBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833823"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:29 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 04/21] selftests/resctrl: Declare global variables as extern
Date:   Tue, 20 Oct 2020 23:51:09 +0000
Message-Id: <20201020235126.1871815-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

resctrl test suite uses global variables (E.g: bm_pid, ppid, llc_occup_path
and is_amd) that are used across .c files. These global variables are
defined in resctrl.h file and the header file is included in .c files where
needed. Sparse tool isn't very happy about defining global variables in .h
file and hence complains as below

resctrl.h:65:7: warning: symbol 'bm_pid' was not declared.
		Should it be static?
resctrl.h:65:15: warning: symbol 'ppid' was not declared.
		 Should it be static?
resctrl.h:66:5: warning: symbol 'tests_run' was not declared.
		Should it be static?
resctrl.h:68:6: warning: symbol 'llc_occup_path' was not declared.
		Should it be static?
resctrl.h:69:6: warning: symbol 'is_amd' was not declared.
		Should it be static?

Sparse tool thinks that since the variables are defined and not declared,
it assumes that the scope of these variables is limited to a .c file and
hence suggests making them static variables. But these variables are used
across .c files and hence cannot be static variables.

Fix these warnings by declaring the variables (i.e. use extern keyword)
rather than defining them in resctrl.h file.

Please note that sparse tool still complains about other issues and they
will be fixed in later patches.

Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file
system operations and data")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 68522b19b235..814d0dd517a4 100644
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
2.29.0

