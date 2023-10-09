Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2801A7BD8A2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345831AbjJIKcA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345828AbjJIKb4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:31:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F474FA;
        Mon,  9 Oct 2023 03:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696847511; x=1728383511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e6BI+6LqlyJDuHOdbdL+OddfPbz+bxG5n4BSrS0nh0Y=;
  b=k0P2vL59iS+F2kzPYLuOYMd3IwTbh83AvUGZsC+dr91urmpOspwSiI5Y
   NgoZpF2hdWcjoCXpjdBduRqSHHFqRdegPfAifNgt1pbDLDMAueCCnDgm2
   irAHAUFIv1NduiGt3Ez5mfKsayZCXlYKBuMS/8hNZrxxgYIO06nmhPrSL
   bTAM+3u15XI5xZBNhAYdib27C94+9TMQWLY9Gch3X6BNlwrWsGw99KxZ/
   L1gHXM+W1+OAx7XTiVQBfNscFOaglXi7yjMd4xlrR4C1gI7Ot8BA7PRU/
   Lb78+OoWdbrJAOCKfq+GGUJXBxv1kQwAXxVqbZvqJSAZS6QWoW7l94Joe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="363468488"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="363468488"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="926718784"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="926718784"
Received: from kkensic-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.30.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:47 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v4 8/8] selftests/resctrl: Fix wrong format specifier
Date:   Mon,  9 Oct 2023 12:30:42 +0200
Message-ID: <1d2bccaf291207cb1cf2fefa65efc087ccdf20d2.1696846568.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
References: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
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

A long unsigned int variable is passed to the ksft_print_msg() and the
format specifier used expects a variable of type int.

Change the format specifier to match the passed variable.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v4:
- Added Reinette's reviewed-by tag.

Changelog v3:
- Added Ilpo's reviewed-by tag.

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

