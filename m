Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4FB78A96A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjH1J4n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjH1J4i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 05:56:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7715B10C;
        Mon, 28 Aug 2023 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693216595; x=1724752595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MwJO9kVVLHDRdzipUSYQDkBXMcwUOolgXO2rJ0yrZgg=;
  b=I7xjsNyCI1LrxfV61cHl47CfLyNfSF/gLXH7Us1zfVA0J34w9cq8B2yI
   XAyP+mUS7OagnprnqaDfDbtKrxG/REb9orUF/1Gsqh5ABPNbFarvMUrR+
   CGkHa08ZnOsZ5ncEm5Gvy3+a1kQ0/S8iU5ZWJEBy2Hu3+96rv1nVjf1f+
   SXBem4vnygKfxsKvdWcH+xPzsExyQ2hnTy94JSJ6yaBq/qq/wCxoGDi6g
   1+sbxSU3jYYeIqsV7/NxYLgutbm6/GwJ7jzuZLOvk4ptpr78VaODdeTjR
   K/7zI5vOOhU7fcG+ROci/qGFkGNulj9knsxGZj5YcfPV2/kx/F+YMQia7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="365266311"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="365266311"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 02:56:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="803650168"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="803650168"
Received: from nwiklans-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 02:56:19 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     ilpo.jarvinen@linux.intel.com
Subject: [PATCH v2 1/2] selftests/resctrl: Fix schemata write error check
Date:   Mon, 28 Aug 2023 11:56:07 +0200
Message-ID: <6c263fdd2b09060e667d179be13ce8f989821673.1693213468.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693213468.git.maciej.wieczor-retman@intel.com>
References: <cover.1693213468.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Writing bitmasks to the schemata can fail when the bitmask doesn't
adhere to some constraints defined by what a particular CPU supports.
Some example of constraints are max length or having contiguous bits.
The driver should properly return errors when any rule concerning
bitmask format is broken.

Resctrl FS returns error codes from fprintf() only when fclose() is
called. Current error checking scheme allows invalid bitmasks to be
written into schemata file and the selftest doesn't notice because the
fclose() error code isn't checked.

Substitute fopen(), flose() and fprintf() with open(), close() and
write() to avoid error code buffering between fprintf() and fclose().

Add newline to the end of the schema string so it satisfies rdt
schemata writing requirements.

Remove newline character from the schemat string after writing it to
the schemata file so it prints correctly before function return.

Pass the string generated with strerror() to the "reason" buffer so
the error message is more verbose. Extend "reason" buffer so it can hold
longer messages.

Changelog v2:
- Rewrite patch message.
- Double "reason" buffer size to fit longer error explanation.
- Redo file interactions with syscalls instead of stdio functions.

Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 24 +++++++++++----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index bd36ee206602..0f9644e5a25e 100644
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
+	int resource_id, fp, ret = 0;
 
 	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
 	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
@@ -518,27 +517,30 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 
 	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
 	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
+		snprintf(schema, sizeof(schema), "%s%d%c%s\n", "L3:",
+			 resource_id, '=', schemata);
 	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
 	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
-		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
+		snprintf(schema, sizeof(schema), "%s%d%c%s\n", "MB:",
+			 resource_id, '=', schemata);
 
-	fp = fopen(controlgroup, "w");
+	fp = open(controlgroup, O_WRONLY);
 	if (!fp) {
 		sprintf(reason, "Failed to open control group");
 		ret = -1;
 
 		goto out;
 	}
-
-	if (fprintf(fp, "%s\n", schema) < 0) {
-		sprintf(reason, "Failed to write schemata in control group");
-		fclose(fp);
+	if (write(fp, schema, strlen(schema)) < 0) {
+		snprintf(reason, sizeof(reason),
+			 "write() failed : %s", strerror(errno));
+		close(fp);
 		ret = -1;
 
 		goto out;
 	}
-	fclose(fp);
+	close(fp);
+	schema[strcspn(schema, "\n")] = 0;
 
 out:
 	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
-- 
2.42.0

