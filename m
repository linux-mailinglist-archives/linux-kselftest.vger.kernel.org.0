Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CA57AAD72
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 11:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjIVJIP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 05:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjIVJIC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 05:08:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1526197;
        Fri, 22 Sep 2023 02:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695373677; x=1726909677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fIfufOMVX6qOMz3hJ3V7MKHi5KE15rGIfodp2fmInKw=;
  b=eovIzkBa9VdzZXo9vZ/d8A3SfiyknOIgG8jJB3GUt+7BLlUOhR7633AP
   R/34funHYfnQZFOEGS+0VqblfF93vs6ozYcHEb7fA7SgGYUxO09bykveV
   n9s8e22w3+AhVAiv9Qjt0UyMGjtEp5EqsiXq91wIkyRPz3mo4V55RInFy
   Yw3hziaTnkwD6ePEHp7togl25bdFgKR2dnlsqT3oEEvL9uAhIwg5TvnG6
   Ux8Wb35qCiB6tqHN4TCwmq5MgZ96SJi1EjAlgeTGAVWSBBa9Kf3vHkojS
   lWMOFF7dmBHzFEIneYOqbr16Z/QAywijSCO7zCsNjYJY6yUVZRX+jFm36
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="378070941"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="378070941"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:07:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="837664095"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="837664095"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:07:54 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 8/8] selftests/resctrl: Fix wrong format specifier
Date:   Fri, 22 Sep 2023 11:06:44 +0200
Message-ID: <1545d7dfb7dd73a7bb2b28fe2f643b87421bf20c.1695373131.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
References: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A long unsigned int variable is passed to the ksft_print_msg() and the
format specifier used expects a variable of type int.

Change the format specifier to match the passed variable.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v3:
- Add Reviewed-by tag. (Ilpo)

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

