Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D778C7BD896
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345840AbjJIKbW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345831AbjJIKbS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:31:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C996099;
        Mon,  9 Oct 2023 03:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696847476; x=1728383476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ArKiKzRHxYzfbJNN+HN0Ktz/ZV7JTI0Hu+EuWZDRMeU=;
  b=g61bKAaXEEmqFP2zDhItMP7htBB8tUapSXC5zr5IlKWxWIPNibKGMhdO
   SwAvJ6ztZQfN8OkZrte+uRykdkm8ruNXghrXO695AQtnVlrELA0bnVBBq
   uTY1LavGsO4ri5aXGzH6a8MbNkHmfBqZiB9WlH5rIdHvugprEcHVDMk5g
   fbKX0sPIE+OWVkTnXtiP3dSdWXv2EWmNRlkAHY5PdKITTe96J3SSqdVlg
   eALyv56CqLtrBucBZqm9oZ8JEyk4GFNjPRlDkPfuDPmbUpBMBk+cvX3W2
   2eepf45IHt1Ngr5mjtN9EaBuum4W9J7nJhVNzV9F4GD2TsMxO+58qsIoh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="363468380"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="363468380"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="926718650"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="926718650"
Received: from kkensic-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.30.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:13 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] selftests/cachestat: Fix print_cachestat format
Date:   Mon,  9 Oct 2023 12:30:36 +0200
Message-ID: <2f34bb45233c29fda28eb8fb66215d475c3c7fd6.1696846568.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
References: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
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

