Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD09E1D8A75
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgERWNz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:13:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:46546 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgERWNz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:13:55 -0400
IronPort-SDR: iBX7dBcQ3g1hXvcjDxPKqh7hPE4qw2c49+RKqn7URzBkaXv4rewsmUCoIFmpPacmZSmW/PdhfQ
 ngRlhLk4nNaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:13:54 -0700
IronPort-SDR: MLk15Xr3jpM92YntC4U3Hy2Ui8LS9WFVY2WnJRJ+X7ovwM++twmuh+4OtHMXEybGAuigMTCsJl
 OUIY9qMqSE6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420341"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:13:54 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 04/19] selftests/resctrl: Declare global variables as extern
Date:   Mon, 18 May 2020 15:08:24 -0700
Message-Id: <5417736f2334c43098dd64733bd220dfe56a7c90.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

resctrl test suite uses global variables (E.g: bm_pid, ppid, llc_occup_path
and is_amd) that are used across .c files. Declare them as 'extern'
variables in resctrl.h file so that they are defined only in one .c file.
Otherwise sparse tool warns it as multiple definitions of the same
variable.

Sparse still complains about "bm_pid" variable name being used globally and
locally to a function in cache.c file. This issue will be addressed in a
later patch series.

Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file system operations and data")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
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
2.19.1

