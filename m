Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366D87C84A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 13:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjJMLiQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 07:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjJMLiI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 07:38:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51FF11B;
        Fri, 13 Oct 2023 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697197086; x=1728733086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZvbQAiqLOInu1U0RntXsBEHZb5uxccipeWHVXzxZd4=;
  b=lOSpa9+880bPVN9cSGYLYezhDGd6YGBXqf3rql+hbtuTaFhjBsGYg5HD
   jnroe5DHigmX9QqLEOLGpOEBuuf1KwrCzAi2+q8Zhgqe0xp9KTFIgpz8Q
   Xyaw5zRaZ6MsrBlCJj9z9J+mJcXNoBxDjNgAqUokBBMVkEIbPO8tia3iC
   Vb8eSkRpjO4o1lbd68yylxDH8XjzsPJ+uYUlIUKvr8ArgQSb1NPBi/jPO
   1u2sasyNHCtYX0vigmqMNbY4nIuVMwfE+lo+Z4e+ua7EFHKgDCEIps6ci
   9JRT3/Ac2sNkHMqVnmPULca35muDKtxjVIgXKIzXT3W/FX3aHy+q+pljo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449353376"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="449353376"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754675871"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="754675871"
Received: from bsankiew-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:38:02 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 8/8] selftests/resctrl: Fix wrong format specifier
Date:   Fri, 13 Oct 2023 13:36:32 +0200
Message-ID: <5c91c8deb7cfffeef6c32adfde9782df04f1082e.1697196663.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
References: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Compiling resctrl selftest after adding a __printf() attribute to
ksft_print_msg() exposes -Wformat warning in show_cache_info().
The format specifier used expects a variable of type int but a long
unsigned int variable is passed instead.

Change the format specifier to match the passed variable.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v6:
- Add an explanation to the patch message on how the warning that the
  patch resolves was caught. (Shuah)

Changelog v4:
- Add Reinette's reviewed-by tag.

Changelog v3:
- Add Ilpo's reviewed-by tag.

Changelog v2:
- Add this patch to the series.

 tools/testing/selftests/resctrl/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index d3cbb829ff6a..a5d082cd2d53 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -294,7 +294,7 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 	ret = platform && abs((int)diff_percent) > max_diff_percent &&
 	      (cmt ? (abs(avg_diff) > max_diff) : true);
 
-	ksft_print_msg("%s Check cache miss rate within %d%%\n",
+	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
 		       ret ? "Fail:" : "Pass:", max_diff_percent);
 
 	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
-- 
2.42.0

