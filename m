Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D049168EB75
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 10:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjBHJcA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 04:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjBHJba (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 04:31:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5973110D0;
        Wed,  8 Feb 2023 01:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675848668; x=1707384668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+bOX5BBL2eeaqq9jlV7GStORno+/xHgQmrDAzhBVJp8=;
  b=b3tHZEInbL1Y/IOeHZFaj6WNemZWaGaQYcLWplGAR9lHGpvYT9XH7bYC
   YL9ERzUOBGt5FrJnH9K3iAJwtVHmH7hlMQvPjLQOXTho2amSqtHL0rnO7
   QJPrcWfzebx59+Emp+5GmXUdo/xLCvtCu6lZ5T0w8hJeAPODoFYz0LnLU
   RduwV99vStVg3lE0VAhlD6iAGvtXJPg7z98xcN/8iNU57cwRDCX/xYqA+
   71W6itIFKfS5GCVZ/VX3OQ0pQp1E+8zCTLInGZr0leQdk7kK5xjRlv61f
   EZZbZLu8n4lpIz7bN0Me6i8AyTE+girQwxeQwJtrwZ7tE5j0jxav9gYQK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415974570"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="415974570"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:30:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="697613971"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="697613971"
Received: from jstelter-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.38.39])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:30:38 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/4] selftests/resctrl: Check for return value after write_schemata()
Date:   Wed,  8 Feb 2023 11:30:16 +0200
Message-Id: <20230208093016.20670-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208093016.20670-1-ilpo.jarvinen@linux.intel.com>
References: <20230208093016.20670-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MBA test case writes schemata but it forgets to check if the write is
successful or not. Hence, add the check and return error properly.

Fixes: 01fee6b4d1f9 ("selftests/resctrl: Add MBA test")
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index f32289ae17ae..97dc98c0c949 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -28,6 +28,7 @@ static int mba_setup(int num, ...)
 	struct resctrl_val_param *p;
 	char allocation_str[64];
 	va_list param;
+	int ret;
 
 	va_start(param, num);
 	p = va_arg(param, struct resctrl_val_param *);
@@ -45,7 +46,11 @@ static int mba_setup(int num, ...)
 
 	sprintf(allocation_str, "%d", allocation);
 
-	write_schemata(p->ctrlgrp, allocation_str, p->cpu_no, p->resctrl_val);
+	ret = write_schemata(p->ctrlgrp, allocation_str, p->cpu_no,
+			     p->resctrl_val);
+	if (ret < 0)
+		return ret;
+
 	allocation -= ALLOCATION_STEP;
 
 	return 0;
-- 
2.30.2

