Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9576E6029
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjDRLpg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDRLpf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:45:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852686588;
        Tue, 18 Apr 2023 04:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818333; x=1713354333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GJB674v5NrvIZOn3jfZ46l+HF/VsfpsEZVPcKvhkSv8=;
  b=Mjl366wT9jjlusq9UztVP+XJC/5WTxjV3dZSQOe3I60eCVpb3EUa0rzr
   BoIEQpPg67It6DdHW/99X7rwj2JmNPEqQCfhwbkqq9iDVDCKFqkz7ASbr
   MANXL65AylIvlrO1Ijw5IldOZcGEe8NDDj1FECEVub1qUa462OJEowKts
   +qXk28pZMhT4oBKHjzw/8r8QW8lzLgIKtd7KlfxlSkWvS0VCIe7G6+F54
   ur4eaTTWMjfGO75FwMsmjAsElBqhKpgRdQgcQSnl+iwRZ61VIBBDvFjC1
   WhChfRjDqylCGNg/dJ8wzb0bbSGjcrqhBD+xrCXWWhDWszsDfFMPSuqFR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994286"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994286"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601532"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601532"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:30 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 02/24] selftests/resctrl: Check also too low values for CBM bits
Date:   Tue, 18 Apr 2023 14:44:44 +0300
Message-Id: <20230418114506.46788-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index fb1443f888c4..722c9cd4120d 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -129,7 +129,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	if (!n)
 		n = count_of_bits / 2;
 
-	if (n > count_of_bits - 1) {
+	if (n < 1 || n > count_of_bits - 1) {
 		ksft_print_msg("Invalid input value for no_of_bits n!\n");
 		ksft_print_msg("Please enter value in range 1 to %d\n",
 			       count_of_bits - 1);
-- 
2.30.2

