Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B9F1D8A80
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgERWOC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:14:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:46558 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgERWOC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:14:02 -0400
IronPort-SDR: rQ8VZy1/OtQCLjMrUE+pU7lgYImIbDwgsAhAHeLiA3KyyCfTLFTr7ZQAISRilaywQTyy5u3OMG
 TuFMt1p2ENEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:14:02 -0700
IronPort-SDR: tkP4nnxwCuLHusJT7MyrbdQod75s63mtfAJYKB3cRRdo5F3eeGXJGJCAHF87LVFTncmxzh6m+7
 O8iLPInAgd2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420420"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:14:01 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 15/19] selftests/resctrl: Change return type of umount_resctrlfs() to void
Date:   Mon, 18 May 2020 15:08:35 -0700
Message-Id: <3c00e744acbfa67a1988638f1718cd67382a6f59.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

umount_resctrlfs() is used only during tear down path and there is nothing
much to do if unmount of resctrl file system fails, so, all the callers of
this function are not checking for the return value. Hence, change the
return type of this function from int to void.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 9 ++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 65ca24bf3eac..23b691001f0b 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -76,7 +76,7 @@ bool check_resctrlfs_support(void);
 int filter_dmesg(void);
 int remount_resctrlfs(bool mum_resctrlfs);
 int get_resource_id(int cpu_no, int *resource_id);
-int umount_resctrlfs(void);
+void umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
 bool validate_resctrl_feature_request(const char *resctrl_val);
 char *fgrep(FILE *inf, const char *str);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 05956319d9ce..83cd3b026c52 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -90,15 +90,10 @@ int remount_resctrlfs(bool mum_resctrlfs)
 	return ret;
 }
 
-int umount_resctrlfs(void)
+void umount_resctrlfs(void)
 {
-	if (umount(RESCTRL_PATH)) {
+	if (umount(RESCTRL_PATH))
 		perror("# Unable to umount resctrl");
-
-		return errno;
-	}
-
-	return 0;
 }
 
 /*
-- 
2.19.1

