Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781FA7BF851
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 12:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjJJKQp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 06:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjJJKQh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 06:16:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6256CE6;
        Tue, 10 Oct 2023 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696932992; x=1728468992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=13xQlZVS/d3Fnw5Uih4vnyyNxo0vPH4oWAoiObRGY2Y=;
  b=Kbe9avFIH/UyxCYN4c6cgBGzxw1HNHnlzeNf4LE4zJLPMDFPT8Kejwoh
   GYHw77mCjHMBhJbMkV7Qk4ZO4++edf2rNa7JLtb21AlT6JMNhfCSnE3ZA
   5IfEc104TPoPxBnN35rrPqHnxbuPAVL1RCamGHjGKDOD6jnbYQ99Qp6Hu
   a8E8R3C2UXBDRC3BWL+k64Y8ymm0xrTn53Mn2jDiMOefRUwNM9/AuLySp
   eC8EPrxT16OFYfDSa2JEXrtmwiUalK/ePskDmnq7RYuPph1Psgcde4zAw
   R8GLWZv8ef/GJ+3I0v/QjT0cICCYIA7ZM005CdXYS6G+r5jLcrdfOly6r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="364652593"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="364652593"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:16:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="703252901"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="703252901"
Received: from asalaman-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.16.145])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:16:27 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH RESEND v7 1/2] selftests/resctrl: Fix schemata write error check
Date:   Tue, 10 Oct 2023 12:16:10 +0200
Message-ID: <7d463146d208304e61cd97c60e718372fc2c21d6.1696932728.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696932728.git.maciej.wieczor-retman@intel.com>
References: <cover.1696932728.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v7:
- Add label for non-empty schema error case. (Reinette)
- Add Reinette's reviewed-by tag.

Changelog v6:
- Align schema_len error checking with typical snprintf format.
  (Reinette)
- Initialize schema string for early return eventuality. (Reinette)

Changelog v5:
- Add Ilpo's reviewed-by tag.
- Fix wrong open() error checking. (Reinette)
- Add error checking to schema_len variable.

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

 tools/testing/selftests/resctrl/resctrlfs.c | 41 +++++++++++++--------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 3a8111362d26..05390afd4d6f 100644
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
+	char controlgroup[1024], reason[128], schema[1024] = {};
+	int resource_id, fd, schema_len = -1, ret = 0;
 
 	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
 	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
@@ -520,28 +520,39 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 
 	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
 	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
+		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
+				      "L3:", resource_id, '=', schemata);
 	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
 	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
-		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
-
-	fp = fopen(controlgroup, "w");
-	if (!fp) {
-		sprintf(reason, "Failed to open control group");
+		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
+				      "MB:", resource_id, '=', schemata);
+	if (schema_len < 0 || schema_len >= sizeof(schema)) {
+		snprintf(reason, sizeof(reason),
+			 "snprintf() failed with return value : %d", schema_len);
 		ret = -1;
-
 		goto out;
 	}
 
-	if (fprintf(fp, "%s\n", schema) < 0) {
-		sprintf(reason, "Failed to write schemata in control group");
-		fclose(fp);
+	fd = open(controlgroup, O_WRONLY);
+	if (fd < 0) {
+		snprintf(reason, sizeof(reason),
+			 "open() failed : %s", strerror(errno));
 		ret = -1;
 
-		goto out;
+		goto err_schema_not_empty;
 	}
-	fclose(fp);
+	if (write(fd, schema, schema_len) < 0) {
+		snprintf(reason, sizeof(reason),
+			 "write() failed : %s", strerror(errno));
+		close(fd);
+		ret = -1;
+
+		goto err_schema_not_empty;
+	}
+	close(fd);
 
+err_schema_not_empty:
+	schema[schema_len - 1] = 0;
 out:
 	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
 		       schema, ret ? " # " : "",
-- 
2.42.0

