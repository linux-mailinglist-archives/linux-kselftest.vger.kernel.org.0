Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9DD79177C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 14:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352939AbjIDMqE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 08:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345281AbjIDMp4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 08:45:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53725CE2;
        Mon,  4 Sep 2023 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693831552; x=1725367552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MHP/tyZYUAXuReqVf8J+AcZrD7lYWnZcCDK9Q2cSu4Y=;
  b=FcsRw9aWgZ04rnL52sIAkNR5XMhgVqYWyIYbCaWwDCz9hgZ0M/misGUq
   kqQXCq/bvWXUjqVyilhEkQttyQ9ezyzJTXxyHKHdZrOcqpy6S92xfINx4
   2OtzbKCm50dLw+B2Qe0TVZKcu5ubJlTAp7xtXcpwtB1q43kH2ssCoaebr
   WgYnqBu0enhnK7mR+lNQY8QmT1NLKAx6zGRFjhFlPmzBWe9STfFoEHk6g
   7opkr5blF9LrJHsdD+fiWFliNX2TqKv8HgNZ9Rpry3JuCIUPhWMgxT5wW
   8IXcwCM+QwjxoeWKNSS7LaO6cOaKIjizK8/Gf1YMecJRy6SNbVcybq5KS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="440555438"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="440555438"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="914497878"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914497878"
Received: from mfederki-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.15.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:37 -0700
From:   Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 8/8] selftests/resctrl: Fix wrong format specifier
Date:   Mon,  4 Sep 2023 14:44:31 +0200
Message-ID: <a10dfa9cbfec05e8056744bc5e3ac0697a4fbd9b.1693829810.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693829810.git.maciej.wieczor-retman@intel.com>
References: <cover.1693829810.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A long unsigned int variable is passed to the ksft_print_msg() and the
format specifier used expects a variable of type int.

Change the format specifier to match the passed variable.

Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Added this patch to the series.

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

