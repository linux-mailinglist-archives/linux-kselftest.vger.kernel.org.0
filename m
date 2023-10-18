Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC59F7CD5C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbjJRHzq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 03:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjJRHzq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 03:55:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AAFC6;
        Wed, 18 Oct 2023 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697615744; x=1729151744;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v9WPbSLAJSd1nBR3aP50+jggvvGNsUWZe+tO6/XexwM=;
  b=CpffZcq8sNN3QGmzwfYGxLH+lBkrsBU+9MqfW3YLnzPXXHlG3j5oduM0
   Y2z1hU7bUTzglUg5Dc9LWYfFymeJGH6xeZ+H6Nm6jCn2j3Mvcr3spzYZw
   SVTWLiMvWfvxDoJJACE3fAcVRDqnPQZGC6Z/NNTzaww1++wIRjwZZ1Mir
   GKy9UlyJbx6RSmDRfRWRV5wSBc67hWGk1je/bfZ05Jm18hhms9A5OJh7Z
   SrbQxEPA3mPl+C7fHvgqViq/Rp89atDwUCimKarLjBqEk6bKHF25oUiau
   kzi0kzvAOK2R0x1IVxCxobBy19aK0WfG7hHN/6AKB7Kz2iDvjOLvIDtNm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389837086"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="389837086"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900235401"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="900235401"
Received: from suguccin-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.44.63])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:53:36 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/1] selftests/resctrl: Fix MBM test failure when MBA unavailable
Date:   Wed, 18 Oct 2023 10:55:26 +0300
Message-Id: <20231018075526.2251-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 20d96b25cc4c ("selftests/resctrl: Fix schemata write error
check") exposed a problem in feature detection logic in MBM selftest.
If schemata does not support MB:x=x entries, the schemata write to
initialize 100% memory bandwidth allocation in mbm_setup() will now
fail with -EINVAL due to the error handling corrected by the commit
20d96b25cc4c ("selftests/resctrl: Fix schemata write error check").
That commit just uncovers the failed write, it is not wrong itself.

If MB:x=x is not supported by schemata, it is safe to assume 100%
memory bandwidth is always set. Therefore, the previously ignored error
does not make the MBM test itself wrong.

Restore the previous behavior of MBM test by checking MB support before
attempting to write it into schemata which results in behavior
equivalent to ignoring the write error.

Fixes: 20d96b25cc4c ("selftests/resctrl: Fix schemata write error check")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/mbm_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d3c0d30c676a..741533f2b075 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -95,7 +95,7 @@ static int mbm_setup(struct resctrl_val_param *p)
 		return END_OF_TESTS;
 
 	/* Set up shemata with 100% allocation on the first run. */
-	if (p->num_of_runs == 0)
+	if (p->num_of_runs == 0 && validate_resctrl_feature_request("MB", NULL))
 		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
 				     p->resctrl_val);
 
-- 
2.30.2

