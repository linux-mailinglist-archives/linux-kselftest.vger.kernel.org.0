Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884957AAC57
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjIVILK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 04:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjIVIKj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 04:10:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E6170D;
        Fri, 22 Sep 2023 01:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695370232; x=1726906232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+9QRUeCNbWBg9HFmG2BsNklF6qiJkbemQMortAEpZN0=;
  b=bPXZZJpI0L/OXoi8zdxloZ1kS0ZCgvPQqucZpKgOrTWd5PfXxSBgWQ26
   AGYHsqLw3Ac8XQdG09Q74/iK9FvRENIhRSKxepEdBh/rLsHgnrEkRGpTI
   BofbdW0As+yd21cwIsnCKAOV7nhWtDtHf5AqlTbIjWioU0qbFkh/VzYVK
   Pir+o8VPJ8oNLjbngSL+kbh/k2SoECaK998V1IWxbkC4TYGb7BzkgQh6o
   bWU7zvuiPIjG1hDNtjRRqU0j9YWMGBrw/8p+9N/AFqnlWyT1YlmH95Phw
   0Zn8YsDUXHDSP8+D0bA6A0XFL1tBhupFOXKS2o4znMrf7o1gMzewUVhVi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383516255"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="383516255"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:10:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="776766345"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="776766345"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:10:30 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v4 1/2] selftests/resctrl: Fix schemata write error check
Date:   Fri, 22 Sep 2023 10:10:10 +0200
Message-ID: <5e17ed39ffb8d6bd530c057aa04e3ffb997573a9.1695369120.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695369120.git.maciej.wieczor-retman@intel.com>
References: <cover.1695369120.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v4:
- Unify error checking between open() and write(). (Reinette)
- Add fcntl.h for glibc backward compatiblitiy. (Reinette)

Changelog v3:
- Rename fp to fd. (Ilpo)
- Remove strlen, strcspn and just use the snprintf value instead. (Ilpo)

Changelog v2:
- Rewrite patch message.
- Double "reason" buffer size to fit longer error explanation.
- Redo file interactions with syscalls instead of stdio functions.

 tools/testing/selftests/resctrl/resctrlfs.c | 30 ++++++++++++---------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 3a8111362d26..edc8fc6e44b0 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -8,6 +8,7 @@
  *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
  *    Fenghua Yu <fenghua.yu@intel.com>
  */
+#include <fcntl.h>
 #include <limits.h>
 
 #include "resctrl.h"
@@ -490,9 +491,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
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
@@ -520,27 +520,31 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 
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
-		sprintf(reason, "Failed to open control group");
+	fd = open(controlgroup, O_WRONLY);
+	if (!fd) {
+		snprintf(reason, sizeof(reason),
+			 "open() failed : %s", strerror(errno));
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

