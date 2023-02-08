Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD9E68EBD4
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 10:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjBHJkp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 04:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBHJko (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 04:40:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219D11BFF;
        Wed,  8 Feb 2023 01:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675849244; x=1707385244;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=fQj277y5B7yPRyeIaCrwNJtSSoMya5ytfa5/89NyjF4=;
  b=jJVVSyJyaMw4j6Pwt7jbqbXRLFa4R4Tpqzs3aNEEDeh8WV7/hnflXBam
   dZidFfeqIofJId9USTOkzNeXuNr3aFblAiWYBl317bRe7p89k22NFJC6I
   lJXr0E5tP4BQ7s2JYlc4Cjvyco5ehScjob65E8bSBx6Zi3b8OSN6TjwaC
   4UboAzekgd8T6cgSi9crdAxGl0Wmx/9rOU4Iob4BTDiNh7eJ+akFFABVF
   bW2ePAX828Vo2ytro+yl/+r9eIu8uQGt9IOfsE6TjOCeklKpw07/GuuZT
   9wr8mni/rSjTTdM/RPrkxtHVSH76R7jcgB5m1Nqi5bB1UDX5XlzX0Ks+0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="328410791"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="328410791"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:40:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="617150264"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="617150264"
Received: from jstelter-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.38.39])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:40:41 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH 2/4] selftests/resctrl: Don't hard code divisor in MBM results
Date:   Wed,  8 Feb 2023 11:40:24 +0200
Message-Id: <20230208094026.22529-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com>
References: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Presently, while calculating MBM results, the divisor is hard coded as 4.
It's hard coded to 4 because "NUM_OF_RUNS" is defined as 5 and the test
does not count first result and hence 4. So, instead of hard coding the
value to 4, change it to NUM_OF_RUNS - 1.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/mbm_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 8392e5c55ed0..4f85cbbfd037 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -31,8 +31,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 		sum_bw_resc += bw_resc[runs];
 	}
 
-	avg_bw_imc = sum_bw_imc / 4;
-	avg_bw_resc = sum_bw_resc / 4;
+	avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
+	avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
 	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
 	avg_diff_per = (int)(avg_diff * 100);
 
-- 
2.30.2

