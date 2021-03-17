Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142BE33E6DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhCQCZD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:55652 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhCQCYf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:35 -0400
IronPort-SDR: Q7bE8qBN0x6L2cPeKOy1DtARq0kVbwUrtKATvuZm6iKcbgiIYH+uHP0NVh//aphiF72ZM08Vf/
 +CHwysJxvVSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328708"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328708"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:33 -0700
IronPort-SDR: 5X4G8+CDpGLsl6AOS3L5TjPi6/T7cAQwvVU+CifkYdWqBRuAznjeFTJahBLLRetbavBVj9sAup
 t7+TA83hVZsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290254"
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
Subject: [PATCH v6 06/21] selftests/resctrl: Fix missing options "-n" and "-p"
Date:   Wed, 17 Mar 2021 02:22:40 +0000
Message-Id: <20210317022255.2536745-7-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

resctrl test suite accepts command line arguments (like -b, -t, -n and -p)
as documented in the help. But passing -n and -p throws an invalid option
error. This happens because -n and -p are missing in the list of
characters that getopt() recognizes as valid arguments. Hence, they are
treated as invalid options.

Fix this by adding them to the list of characters that getopt() recognizes
as valid arguments. Please note that the main() function already has the
logic to deal with the values passed as part of these arguments and hence
no changes are needed there.

Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
v5:
- Move from v4's patch 9 to this patch as the fix patch should be first
  (Shuah).

 tools/testing/selftests/resctrl/resctrl_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 4b109a59f72d..ac2269610aa9 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -73,7 +73,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	while ((c = getopt(argc_new, argv, "ht:b:")) != -1) {
+	while ((c = getopt(argc_new, argv, "ht:b:n:p:")) != -1) {
 		char *token;
 
 		switch (c) {
-- 
2.31.0

