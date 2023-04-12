Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADEB6DF6EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjDLNWR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjDLNWO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:22:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86201FE;
        Wed, 12 Apr 2023 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305715; x=1712841715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wgdJ1BBFDFmDCVxAiWUlHgUdxyNPmJO/s/ypHKHJoVU=;
  b=iMTT7MPw+raY0zDLEI+U0zjO3pcvYDjBPIalfaRgCU5+8xyORSXdmU1n
   033ELHR6S6JcjBCCNfOb5nHKTHb1pgut4JUabd7I+QnT/CcZ+Ap/XndUW
   IsnqAma20sTigEOx8If0ZxG9QqEaNjzIdPFYPSQJk+DrVKRBV56/40Rzz
   XDfgqNcQ2nYlHwlbZM+mECUl/9qljXoCHhhpqlGge+IpvWLXwUMnifY6N
   LI7wv4V9AuMoj5QjCfTpjw+e8ZsTSMz0FxrjdrAcIajnngbLVP2EZhjNg
   VscEteHQ9SuId4MmTB/lFoCV9WKwCuQpFy+R+/pMzH6lhJkX6XMHTr/gb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590028"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590028"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230030"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230030"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:41 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/22] selftests/resctrl: Check also too low values for CBM bits
Date:   Wed, 12 Apr 2023 16:21:02 +0300
Message-Id: <20230412132122.29452-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
References: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CAT test only validates that the number of CBM bits is not too large
but it could be too small too.

Check and return error before starting the CAT test if the number of
CBM bits is too small.

Fixes: 09a67934625a ("selftests/resctrl: Don't hard code value of "no_of_bits" variable")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 08070d4fa735..de2860bf5d80 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -130,7 +130,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	if (!n)
 		n = count_of_bits / 2;
 
-	if (n > count_of_bits - 1) {
+	if (n < 1 || n > count_of_bits - 1) {
 		ksft_print_msg("Invalid input value for no_of_bits n!\n");
 		ksft_print_msg("Please enter value in range 1 to %d\n",
 			       count_of_bits - 1);
-- 
2.30.2

