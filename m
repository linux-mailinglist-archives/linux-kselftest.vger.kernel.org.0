Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC217CB94
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 04:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCGDqN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 22:46:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:57577 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgCGDqM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 22:46:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 19:46:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,524,1574150400"; 
   d="scan'208";a="235035991"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2020 19:46:12 -0800
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V1 01/13] selftests/resctrl: Fix feature detection
Date:   Fri,  6 Mar 2020 19:40:42 -0800
Message-Id: <7e3e4b91f5786a489e68eecda21e1d8049b60181.1583657204.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

The intention of the resctrl selftests is to only run the tests
associated with the feature(s) supported by the platform. Through
parsing of the feature flags found in /proc/cpuinfo it is possible
to learn which features are supported by the plaform.

There are currently two issues with the platform feature detection that
together result in tests always being run, whether the platform supports
a feature or not. First, the parsing of the the feature flags loads the
line containing the flags in a buffer that is too small (256 bytes) to
always contain all flags. The consequence is that the flags of the features
being tested for may not be present in the buffer. Second, the actual
test for presence of a feature has an error in the logic, negating the
test for a particular feature flag instead of testing for the presence of a
particular feature flag.

These two issues combined results in all tests being run on all
platforms, whether the feature is supported or not.

Fix these issue by (1) increasing the buffer size being used to parse
the feature flags, and (2) change the logic to test for presence of the
feature being tested for.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 19c0ec4045a4..226dd7fdcfb1 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -596,11 +596,11 @@ bool check_resctrlfs_support(void)
 
 char *fgrep(FILE *inf, const char *str)
 {
-	char line[256];
 	int slen = strlen(str);
+	char line[2048];
 
 	while (!feof(inf)) {
-		if (!fgets(line, 256, inf))
+		if (!fgets(line, 2048, inf))
 			break;
 		if (strncmp(line, str, slen))
 			continue;
@@ -631,7 +631,7 @@ bool validate_resctrl_feature_request(char *resctrl_val)
 	if (res) {
 		char *s = strchr(res, ':');
 
-		found = s && !strstr(s, resctrl_val);
+		found = s && strstr(s, resctrl_val);
 		free(res);
 	}
 	fclose(inf);
-- 
2.7.4

