Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8264978FE85
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 15:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349868AbjIANn2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349845AbjIANnX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 09:43:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C042E1732;
        Fri,  1 Sep 2023 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575782; x=1725111782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EEReJSRlcv9+PTEBmSIxl61qsJVklng9DcbuIC4vK8M=;
  b=m88ITuuRI9osZ9Ppodfs5SbqV2EyhzVQwW9yKSmzUsKy25Hj+eY+zrnG
   7kYMUcSQfdwP5ityvDVhO3+Qq2t9xxtfnCPdgxpDnAWAn76m3iW3PIwk8
   QpcACkzNwGSDwAGZXHtmd3UkuNPxtblZXkXCXWzMcTnitnYwzjuYqVM6F
   VnSaJ6pbWjaJsijQ8SmQezi5qsEdtq5zYNLW8LTz2NKiEvIE64QOkU6GM
   7pzZgpHseu8tkI11gkjXUAlzG4En8kYirmJopcguH47eljX0awpeECSbw
   5zt2SQNPw6fah9r7bGjegOUb5wGOXxxN9AzoUBXEyQNmQGywyuN45fBD+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373618270"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="373618270"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739936738"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="739936738"
Received: from rawskaal-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.136])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:42:59 -0700
From:   Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH RESEND v3 1/2] selftests/resctrl: Fix schemata write error check
Date:   Fri,  1 Sep 2023 15:42:33 +0200
Message-ID: <960b5302cee8e5bb0e83dcf20cd2ef4d353b7b0b.1693575451.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
References: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Writing bitmasks to the schemata can fail when the bitmask doesn't
adhere to constraints defined by what a particular CPU supports.
Some example of constraints are max length or having contiguous bits.
The driver should properly return errors when any rule concerning
bitmask format is broken.

Resctrl FS returns error codes from fprintf() only when fclose() is
called. Current error checking scheme allows invalid bitmasks to be
written into schemata file and the selftest doesn't notice because the
fclose() error code isn't checked.

Substitute fopen(), flose() and fprintf() with open(), close() and
write() to avoid error code buffering between fprintf() and fclose().

Remove newline character from the schema string after writing it to
the schemata file so it prints correctly before function return.

Pass the string generated with strerror() to the "reason" buffer so
the error message is more verbose. Extend "reason" buffer so it can hold
longer messages.

Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
---
Changelog v3:
- Rename fp to fd (Ilpo)
- Remove strlen, strcspn and just use the snprintf value instead (Ilpo)

Changelog v2:
- Rewrite patch message.
- Double "reason" buffer size to fit longer error explanation.
- Redo file interactions with syscalls instead of stdio functions.

 tools/testing/selftests/resctrl/resctrlfs.c | 26 +++++++++++----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index bd36ee206602..b0b14a5bcbf5 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -488,9 +488,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
  */
 int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 {
-	char controlgroup[1024], schema[1024], reason[64];
-	int resource_id, ret = 0;
-	FILE *fp;
+	char controlgroup[1024], schema[1024], reason[128];
+	int resource_id, fd, schema_len = -1, ret = 0;
 
 	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
 	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
@@ -518,27 +517,30 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 
 	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
 	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
+		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
+				      "L3:", resource_id, '=', schemata);
 	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
 	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
-		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
+		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
+				      "MB:", resource_id, '=', schemata);
 
-	fp = fopen(controlgroup, "w");
-	if (!fp) {
+	fd = open(controlgroup, O_WRONLY);
+	if (!fd) {
 		sprintf(reason, "Failed to open control group");
 		ret = -1;
 
 		goto out;
 	}
-
-	if (fprintf(fp, "%s\n", schema) < 0) {
-		sprintf(reason, "Failed to write schemata in control group");
-		fclose(fp);
+	if (write(fd, schema, schema_len) < 0) {
+		snprintf(reason, sizeof(reason),
+			 "write() failed : %s", strerror(errno));
+		close(fd);
 		ret = -1;
 
 		goto out;
 	}
-	fclose(fp);
+	close(fd);
+	schema[schema_len - 1] = 0;
 
 out:
 	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
-- 
2.42.0

