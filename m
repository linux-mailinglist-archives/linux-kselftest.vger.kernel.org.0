Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FCC7A22C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjIOPpT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbjIOPpC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 11:45:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4154DE78;
        Fri, 15 Sep 2023 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694792697; x=1726328697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLwew0FGrNlO4wtyN0Y18C8cvUXaHIIyCDls0VyYU/A=;
  b=hnx+8B8+dB94xwDGnP/PcUzume1zC3kM6yaR4sjX9zJmc8NZQxcME9g2
   kPLFEtJxrxZzHkQjfNUh/t7S/9BKmBDTKNNJeqiH4MYa/kWyWWfj+DicM
   NHLhSx/JSJmuA9BU91tejFlHqTUc3lLC2Ru1ka/5Rxy92VocfmhKuItTs
   mNzh1O6aUPiVg0l3h7Upc8ULgCRWTRbw+4qohzl7aPusxera+2j26JFCR
   4qpCGFrhrEq3XgxYo/SGczPVFnE0xifwrlIurtOEZ0mxbNrFtfRkaewJ9
   xySiEY/xGrctvesCY4QttrMheHbVZRzfOduqWtCBY3qismLJ+AtM75pwU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410217275"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="410217275"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="991878580"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="991878580"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:44:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/6] selftests/resctrl: Remove duplicate feature check from CMT test
Date:   Fri, 15 Sep 2023 18:44:34 +0300
Message-Id: <20230915154438.82931-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
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

The test runner run_cmt_test() in resctrl_tests.c checks for CMT
feature and does not run cmt_resctrl_val() if CMT is not supported.
Then cmt_resctrl_val() also check is CMT is supported.

Remove the duplicated feature check for CMT from cmt_resctrl_val().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
 tools/testing/selftests/resctrl/cmt_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index cf2f5e92dea6..50bdbce9fba9 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -80,9 +80,6 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 	size_t span;
 	int ret, i;
 
-	if (!validate_resctrl_feature_request(CMT_STR))
-		return -1;
-
 	ret = get_cbm_mask("L3", cbm_mask);
 	if (ret)
 		return ret;
-- 
2.30.2

