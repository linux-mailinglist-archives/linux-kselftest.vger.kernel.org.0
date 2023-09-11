Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EEA79B376
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbjIKVU2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbjIKLT4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 07:19:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E5CDD;
        Mon, 11 Sep 2023 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694431191; x=1725967191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLwew0FGrNlO4wtyN0Y18C8cvUXaHIIyCDls0VyYU/A=;
  b=MJgJC9X6E5Ss9D3hMdTjm2DoitzlDWnojmVy23lyEV6AvmejdhH7fQSV
   lEqW51CGA4xRSY0kctD+0BlZ3tAVupGnEXPF/I1krmx1TCRZgS5wRZtSl
   iYU/cEgCNBZf4j5nmc0nZd8isnN0pdXnvOwNCjFftb96vLvGArVClorUO
   qQSGoK+IRFdlPgMlQWuAq3+hhiITx2MJ97t5oDcuxphIXfl61UNRXaK+K
   1iNr10IIA0Si8WgPZlv1CJl0zD4HxJOanAUMkrd9Dw6nIDMRlq2NxUU7B
   aKZBdBi618Cg51A7+Bo5hy+Vy5XMrCq3kZEg/ChYuokrX3HRCuwqMMgpY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="464428610"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="464428610"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:19:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="916990559"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="916990559"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:19:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/5] selftests/resctrl: Remove duplicate feature check from CMT test
Date:   Mon, 11 Sep 2023 14:19:27 +0300
Message-Id: <20230911111930.16088-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
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

