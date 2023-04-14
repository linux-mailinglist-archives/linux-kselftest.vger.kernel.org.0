Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6FA6E289A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDNQpP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjDNQpN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 12:45:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57888A5F1;
        Fri, 14 Apr 2023 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681490698; x=1713026698;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r6G2cgO38OABPSaqXBsZicRMhYjzmuzMfmglknZdNY0=;
  b=ElertLU50hRcARZiiVwWg9I57EqFmfEeG97m7yEz5fXCf7tJfn6RJLHi
   dgqTExTkvNH3Wt9uXVlBezyW7ZbzpjcFgeZxFcGUY5eRS3yb5RtShJcIl
   cY/S+N6sQP8Pff2S5KOQQFQMAyu9H/I7vtNOoVpqLVMMUFvf/H+X5eFc0
   eJmWPXovVfnEUANwZvzlr+Km5LKu8yewPSceAI8JtF6Cxl7yTkvUU+p1U
   U8dxL1g5uOLauPmp8SuKBolGnuirxRV8AMCTgXIDXPDgQPs3AMQPzlCP6
   2AuAgyxP8c7NMVSt5yvXpoz9IMRkF8IU47nTkjir1r/gkrs+viwocdNRa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="407384287"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="407384287"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 09:44:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="833592556"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="833592556"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 09:44:03 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org
Cc:     ilpo.jarvinen@linux.intel.com, tan.shaopeng@jp.fujitsu.com,
        fenghua.yu@intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/resctrl: Fix incorrect error return on test complete
Date:   Fri, 14 Apr 2023 09:43:58 -0700
Message-Id: <37df0986015ecedec9a0244bdb0aa7c073bfe714.1681490161.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

An error snuck in between two recent conflicting changes:
Until recently ->setup() used negative values to indicate
normal test termination. This was changed in
commit fa10366cc6f4 ("selftests/resctrl: Allow ->setup() to return
errors") that transitioned ->setup() to use negative values
to indicate errors and a new END_OF_TESTS to indicate normal
termination.

commit 42e3b093eb7c ("selftests/resctrl: Fix set up schemata with 100%
allocation on first run in MBM test") continued to use
negative return to indicate normal test termination.

Fix mbm_setup() to use the new END_OF_TESTS to indicate
error-free test termination.

Fixes: 42e3b093eb7c ("selftests/resctrl: Fix set up schemata with 100% allocation on first run in MBM test")
Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/lkml/bb65cce8-54d7-68c5-ef19-3364ec95392a@linux.intel.com/
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Hi Shuah,

Apologies, this error snuck in between the two series
merged into kselftest's next this week.

 tools/testing/selftests/resctrl/mbm_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 146132fa986d..538d35a6485a 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -98,7 +98,7 @@ static int mbm_setup(int num, ...)
 
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
-		return -1;
+		return END_OF_TESTS;
 
 	/* Set up shemata with 100% allocation on the first run. */
 	if (p->num_of_runs == 0)
-- 
2.34.1

