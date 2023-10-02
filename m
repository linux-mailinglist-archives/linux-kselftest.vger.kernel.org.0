Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142317B4F80
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjJBJtt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 05:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbjJBJtr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 05:49:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED42A10D;
        Mon,  2 Oct 2023 02:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696240182; x=1727776182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sp0x4fJkDtvf5U3jrcchNzXDHSx4PqVE55/imOH1bT4=;
  b=Axn64ntUCu4JVs+35v0jPCkV9PCp/IMBvVVNZMqj2bspTzNFG7lgwe1O
   Wm6809huDVD4r6nmOmFpOjRHAK0EbTzEWDlMGoDrglhB7NGp6TSc2JJtq
   NEOw2urCrUBWVbKlxKiSZChD/qCKPP7XlbJdlJ0UL6yERIbddBr+KUOER
   2M22wj0mbHkJqmsD5hQhUXmtRBZn5hB7S6BD3i/phk3vN/wmN2l7W5Hqb
   0FJJ6JglCB61zc5rX129ki9AJzNYAFSUTaeDBrJaY0BR0vqERqUKufHQh
   i6R8/Qc12xx4OpxfUQSruPFrUr30fCuxEntCWlsloodcsFZOd9n4/wR14
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="372960722"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="372960722"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="754005604"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754005604"
Received: from aanantha-mobl.gar.corp.intel.com (HELO localhost) ([10.251.221.191])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:49:37 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 7/7] selftests/resctrl: Reduce failures due to outliers in MBA/MBM tests
Date:   Mon,  2 Oct 2023 12:48:13 +0300
Message-Id: <20231002094813.6633-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
References: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The initial value of 5% chosen for the maximum allowed percentage
difference between resctrl mbm value and IMC mbm value in commit
06bd03a57f8c ("selftests/resctrl: Fix MBA/MBM results reporting
format") was "randomly chosen value" (as admitted by the changelog).

When running tests in our lab across a large number platforms, 5%
difference upper bound for success seems a bit on the low side for the
MBA and MBM tests. Some platforms produce outliers that are slightly
above that, typically 6-7%, which leads MBA/MBM test frequently
failing.

Replace the "randomly chosen value" with a success bound that is based
on those measurements across large number of platforms by relaxing the
MBA/MBM success bound to 8%. The relaxed bound removes the failures due
the frequent outliers.

Fixes: 06bd03a57f8c ("selftests/resctrl: Fix MBA/MBM results reporting format")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc: <stable@vger.kernel.org>
---
 tools/testing/selftests/resctrl/mba_test.c | 2 +-
 tools/testing/selftests/resctrl/mbm_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index cf8284dadcb2..d3bf4368341e 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -12,7 +12,7 @@
 
 #define RESULT_FILE_NAME	"result_mba"
 #define NUM_OF_RUNS		5
-#define MAX_DIFF_PERCENT	5
+#define MAX_DIFF_PERCENT	8
 #define ALLOCATION_MAX		100
 #define ALLOCATION_MIN		10
 #define ALLOCATION_STEP		10
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 1ae131a2e246..d3c0d30c676a 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -11,7 +11,7 @@
 #include "resctrl.h"
 
 #define RESULT_FILE_NAME	"result_mbm"
-#define MAX_DIFF_PERCENT	5
+#define MAX_DIFF_PERCENT	8
 #define NUM_OF_RUNS		5
 
 static int
-- 
2.30.2

