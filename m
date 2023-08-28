Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85578ADD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjH1Kul (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjH1Ku3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:50:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87411B4;
        Mon, 28 Aug 2023 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693219802; x=1724755802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oBFESXQeo8XUbeSjtiiAngLi2J8A9Sds/W2gNaZedsA=;
  b=ljUitEwj6gxEmWTMiQBDOeY3v93h/zvfHJuo3QqNyZ6LwgW7raWe/7sy
   vtoJgV6FGcba1MRwh8CfDFqywlP/0y3r8F58NP52o8HtQFmiZSMJGLXLv
   uRWuRCmKKitSQa/7it9rUpGgqbJsuquvHCq2X62nF3q1oDyXE8N62X8Zy
   vJEK5siVb0CQZMpHlv3lDlHSnQWC4Cqzcb61EpHFr1QPivXslAStvyTSq
   9JSjfItyznL1eiag+lkfwWhUxhpnjY88PUGAbyMnq13oTUEQifmKKEMXr
   jXNhBArSlTmjj7/AY3ehlnpHxuSctsy9BonYDvV7IEMUPJFLWQm5naD5k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="355398803"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="355398803"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:49:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="803658311"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="803658311"
Received: from nwiklans-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:49:54 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, reinette.chatre@intel.com,
        "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        Wieczor-Retman@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] selftests/cachestat: Fix print_cachestat format
Date:   Mon, 28 Aug 2023 12:49:06 +0200
Message-ID: <8417dcd7ebdc464d12850873d6c48f95293e673c.1693216959.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
References: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
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

Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/cachestat/test_cachestat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 77620e7ecf56..a7adf42afb20 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -25,7 +25,7 @@ static const char * const dev_files[] = {
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

