Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463611D8A76
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgERWNz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:13:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:46546 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgERWNz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:13:55 -0400
IronPort-SDR: R+qKp6Sip0FyJFuuU94ST0QqtcFP7kuK7i50ewkQIUJdtOfJZK1Klz7Dn2HyL3fKlSb+wyz7qa
 AEnF76Ibs9xA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:13:55 -0700
IronPort-SDR: 46uiIUCjFGYyrJePkjdKdZqabN9uEr/1XQNmvzcFHY3DqZ83lfZPCRNiUveX6a7HWB6XoizMI7
 Bw4w7BGRRecw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420344"
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
Subject: [PATCH V2 05/19] selftests/resctrl: Return if resctrl file system is not supported
Date:   Mon, 18 May 2020 15:08:25 -0700
Message-Id: <0142414b5480b4325cb28656c9508292ed80ab7a.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Presently, return value of check_resctrlfs_support() is not checked and
hence the test tries to execute individual tests like CAT, CMT, MBM and
MBA even if resctrl file system is not supported in /proc/filesystems. Fix
this by checking for the return value of check_resctrlfs_support() and if
it returns false i.e. resctrl file system is not supported, then don't run
any tests.

Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index b2a560c0c5dc..d24de546d4ef 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -155,7 +155,11 @@ int main(int argc, char **argv)
 	sprintf(bw_report, "reads");
 	sprintf(bm_type, "fill_buf");
 
-	check_resctrlfs_support();
+	if (!check_resctrlfs_support()) {
+		printf("Bail out! resctrl FS does not exist\n");
+		goto out;
+	}
+
 	filter_dmesg();
 
 	if (!is_amd && mbm_test) {
@@ -196,6 +200,7 @@ int main(int argc, char **argv)
 		cat_test_cleanup();
 	}
 
+out:
 	printf("1..%d\n", tests_run);
 
 	return 0;
-- 
2.19.1

