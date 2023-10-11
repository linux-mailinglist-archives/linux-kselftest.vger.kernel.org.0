Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBBC7C4D04
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjJKIYm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344007AbjJKIYl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 04:24:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13AA92;
        Wed, 11 Oct 2023 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697012680; x=1728548680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ArKiKzRHxYzfbJNN+HN0Ktz/ZV7JTI0Hu+EuWZDRMeU=;
  b=i99FAbNUAwAh0DIX4lgt61xwLUVYgXhRY+84Qq4IQwU4lvbwnxImM3Z5
   sBbi7iPsX51AcnhYhV4QYQFCmIbpvjrvkqsvBOq5awh7Lgh2Y0kpzU0yd
   T2z0bDfdsgHa8nyVVjtOT7DjG3CmFr9WX6Q089CEH4I+kwrMpxJbDA8Zu
   kXAHEfUvBohsnYDrzDj728o1udZ7h61EBYjX2OwZjDYaZ1mPTumAMOYQN
   a+eUrhUGbIywIp4XBPucJsGI3/FPdUXJF0cej59c3NYMxTu0G5VIkkVe2
   nrykx4PS+6CSBgDdFrOda+UCq5T3sRQjt0rOH4zvtGxggqvcaAletp82k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3200738"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="3200738"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730411611"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730411611"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.17.119])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:24:32 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/8] selftests/cachestat: Fix print_cachestat format
Date:   Wed, 11 Oct 2023 10:23:58 +0200
Message-ID: <46044a7aea13532ea7d5a97201dc152ec653ea52.1697012398.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
References: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The format specifier in printf() call expects long int variables and
received long long int.

Change format specifiers to long long int so they match passed
variables.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
---
Changelog v2:
- Added Acked-by tag (Nhat)

 tools/testing/selftests/cachestat/test_cachestat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 4804c7dc7b31..b171fd53b004 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -27,7 +27,7 @@ static const char * const dev_files[] = {
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

