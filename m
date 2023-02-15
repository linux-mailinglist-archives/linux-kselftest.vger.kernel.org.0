Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB353697CC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjBONHY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 08:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjBONHQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 08:07:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF838B74;
        Wed, 15 Feb 2023 05:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676466412; x=1708002412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TMTPGCBFEcyXIrRfllTsJbANrKN0ke5YKs8+ZFm0YOU=;
  b=A7l7IwMJm5LfeHSE4k4jCw3PP/iyCp+/IygZSffoEgcWJPo/aZqvoVD8
   xw6Mv+lfZi8zRWV3BgrB8rmAwWjeQaMXtsj/3ND7MOMWwkxe1GF3xbpoY
   Y4woRDWoU33dO6A38eCeMJLNX1uUIbnAOZbkvlY2kvDjRFzwP58JvACfA
   TLOjwrH2Ui3HJzwpLdls5GuL+xpvWCXGYC86jtyRUkCnSQ3J2PDoxl38p
   24YAE0EVsgl83z5AAZ0VenbkKePhZFnCBNRqs0bSNTI4p+OQGThWYeVDv
   tOhRK9jxHwq/jobOw0/9b1zoSfLqIoCbNm0Tq/m5JnF70ttKNn9hRiJez
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319456365"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319456365"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812436116"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="812436116"
Received: from hshannan-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.120])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:46 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 9/9] selftests/resctrl: Correct get_llc_perf() param in function comment
Date:   Wed, 15 Feb 2023 15:06:05 +0200
Message-Id: <20230215130605.31583-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
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

get_llc_perf() function comment refers to cpu_no parameter that does
not exist.

Correct get_llc_perf() the comment to document llc_perf_miss instead.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 585186c874dc..8a4fe8693be6 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -77,7 +77,7 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
 
 /*
  * get_llc_perf:	llc cache miss through perf events
- * @cpu_no:		CPU number that the benchmark PID is binded to
+ * @llc_perf_miss:	LLC miss counter that is filled on success
  *
  * Perf events like HW_CACHE_MISSES could be used to validate number of
  * cache lines allocated.
-- 
2.30.2

