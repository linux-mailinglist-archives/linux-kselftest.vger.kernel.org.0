Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC9D7C8483
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 13:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJMLhP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjJMLhP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 07:37:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68939CE;
        Fri, 13 Oct 2023 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697197032; x=1728733032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lrw09RBhlTNOQ+591h8E6O2k4lnZljQLuL1ioE3nYNM=;
  b=OmR4mAHcgCHV49NVE3FErF/9KW7ArfdmHp+GuSerFgkm0prAWHMVbElq
   Y8YWSYN5HmEcxOU/IzgE8cfO/GAmbZSls2qtEZ0AHb3HBPO1fllTXzaXw
   /o01Ufg3ggvv+S3xg6nwWxkW+RH9zokkwEp5jvqK1LZVm3ApRPwmSi1+t
   DLV5TACFi8aJi2fX+oNnUnSbJNyVuoTgSxgKN08P1er5bN41aIFAY0JPe
   CvxVJFi/Mw6hnQzOSJY1qqA7UbQv4wk37FQbCloD1zgBwDVt3tUihll2N
   Ijule8oRFp9M2hYshDR8RY5BIDyLoaLF8e6hbVnXrxkOLLQDZZVKQiQ1B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449353217"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="449353217"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754675625"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="754675625"
Received: from bsankiew-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:37:06 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/8] selftests/cachestat: Fix print_cachestat format
Date:   Fri, 13 Oct 2023 13:36:26 +0200
Message-ID: <0988d25d89523ba21307f70a265cd5446ae15d4d.1697196663.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
References: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
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

Compiling cachestat selftest after adding a __printf() attribute to
ksft_print_msg() exposes a -Wformat warning in print_cachestat().
The format specifier in printf() call expects long int variables and
received long long int.

Change format specifiers to long long int so they match passed
variables.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
---
Changelog v6:
- Add an explanation to the patch message on how the warnings that the
  patch resolves were caught. (Shuah)

Changelog v2:
- Add Acked-by tag (Nhat)

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

