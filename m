Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC179176B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352927AbjIDMpw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbjIDMpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 08:45:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1054CDB;
        Mon,  4 Sep 2023 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693831533; x=1725367533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVZ45VVk9jiOwslIlVhrQyeA3gThQGKo4Ac1RQA0Wo4=;
  b=gc0j+d2Ghbn2EgBhZHI9mvQ+3iN5RKyxd2WCtyISp0zyn///bNNWiVJg
   zGOKjxRfYX5fZN2ABjB+SBV60qx6pfAnESWPsrLmQyzZgJwmZzbEt4rtd
   ZVvXtXdEeJtLLlP2XZsO/lg2pi6iScS2uKFTtGPPrrzNclfwr59uBYXKh
   25cjctNaEGm/Dhn8EOBh6vnuWlIjdpwuwElkhM1lJdQCyBw8bJ3h9QXcs
   ypSqOHEYiQZQ7hGcCbKZtkb9I0nlsDEdLnCUKJXD8H4S1BNrf7TVFHAQD
   IPzMyMNgZMgdg5hfanqO/GbRvG4ml9Us+YqvBO/jQc77RojEOCLoJDCj8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="440555386"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="440555386"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="914497771"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914497771"
Received: from mfederki-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.15.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:23 -0700
From:   Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] selftests/cachestat: Fix print_cachestat format
Date:   Mon,  4 Sep 2023 14:44:25 +0200
Message-ID: <de1b432982f099e7fac71f3915c5a879b7078cbe.1693829810.git.maciej.wieczor-retman@intel.com>
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

The format specifier in printf() call expects long int variables and
received long long int.

Change format specifiers to long long int so they match passed
variables.

Acked-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Added Acked-by tag (Nhat)

 tools/testing/selftests/cachestat/test_cachestat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index a5a4ac8dcb76..7f3871eef409 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -23,7 +23,7 @@ static const char * const dev_files[] = {
 void print_cachestat(struct cachestat *cs)
 {
 	ksft_print_msg(
-	"Using cachestat: Cached: %lu, Dirty: %lu, Writeback: %lu, Evicted: %lu, Recently Evicted: %lu\n",
+	"Using cachestat: Cached: %llu, Dirty: %llu, Writeback: %llu, Evicted: %llu, Recently Evicted: %llu\n",
 	cs->nr_cache, cs->nr_dirty, cs->nr_writeback,
 	cs->nr_evicted, cs->nr_recently_evicted);
 }
-- 
2.42.0

