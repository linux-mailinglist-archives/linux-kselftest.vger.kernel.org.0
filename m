Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDABD1D8A77
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgERWN4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:13:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:46546 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgERWN4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:13:56 -0400
IronPort-SDR: 9sUJy+Ul37koJmIPs6/Q72TRGWhyw/9C/SbnmU2y03YH+p+M04KZbC1K6iuI7To0mBC/qlcWfj
 Fhn9VPfXjNLw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:13:56 -0700
IronPort-SDR: WuwUUgMPxHKFfNDumWaZUEVUta2d8RGygCAMBi4RwRwdTRbCdXABkoiKzmRduePSVoqlpvOJMB
 eDvvr2Up0Dyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420347"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:13:55 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 06/19] selftests/resctrl: Check for resctrl mount point only if resctrl FS is supported
Date:   Mon, 18 May 2020 15:08:26 -0700
Message-Id: <523fc548414652dfe2068f60b959905e5a4a0e1d.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Presently, check_resctrlfs_support() tries to open "/sys/fs/resctrl" and
will also look for resctrl mount point in "/proc/mounts" even if resctrl
file system is not supported. Both the above will fail if resctrl file
system is not supported. Hence, return immediately if resctrl file system
is not supported.

Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 727e667e2cc9..e43ddebd1aa4 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -581,6 +581,9 @@ bool check_resctrlfs_support(void)
 	printf("%sok kernel supports resctrl filesystem\n", ret ? "" : "not ");
 	tests_run++;
 
+	if (!ret)
+		return ret;
+
 	dp = opendir(RESCTRL_PATH);
 	printf("%sok resctrl mountpoint \"%s\" exists\n",
 	       dp ? "" : "not ", RESCTRL_PATH);
-- 
2.19.1

