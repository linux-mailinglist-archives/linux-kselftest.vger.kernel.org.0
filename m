Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA201D8A82
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgERWOD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:14:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:46558 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgERWOD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:14:03 -0400
IronPort-SDR: cYbjDqWQtKvwtrnxtN9BT+zPhOX5t8AbSfj9cx7nmE15DHdWQ57RsXHvjotQtP3f29MbpBvWkS
 260srG4v4EDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:14:03 -0700
IronPort-SDR: 8c7bcOzsKScHuj0VCzI/7onjkTWO+S9RkyZcw5MEhjDFY0CqhigLwfUuHo5FX7ln6LSP2SPwRr
 kzZU1gw6v2FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420450"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:14:02 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 17/19] selftests/resctrl: Unmount resctrl FS after running all tests
Date:   Mon, 18 May 2020 15:08:37 -0700
Message-Id: <79f565afd45e9f4a72a4b84ea80df63b78c47d21.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

validate_resctrl_feature_request() would mount resctrl FS (if not already
mounted) to check if a requested feature is supported by the platform or
not. There could be situations where in all the resctrl tests are skipped
and hence main() function would return leaving the resctrl FS mounted.

To avoid resctrl FS being mounted, unmount resctrl FS before returning.
This shouldn't have any impact on the cases where all the tests might get
to run (or some of the test cases might get to run and the individual tests
unmount resctrl FS) because umount_resctrlfs() attempts to unmount
resctrl FS only if it's mounted.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index d45ae004ed77..a0c14555d259 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -226,6 +226,7 @@ int main(int argc, char **argv)
 	}
 
 out:
+	umount_resctrlfs();
 	printf("1..%d\n", tests_run);
 
 	return 0;
-- 
2.19.1

