Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F253F78ADD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjH1Kvn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjH1Kuu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:50:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF250199;
        Mon, 28 Aug 2023 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693219825; x=1724755825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yeabUHzSr9wnJ5Khd/Kxt8JMKHZYb3HenPBaDj2y7Bw=;
  b=XiXrDSwxfMaYndVIHbKk2K9Y+ha9boTBhY4t2O+o6AWtRveg356IvsOk
   CPFVE6RtOLembWFeY6sfSykflTeRQMwn8xu71SEQMOyqmfKIWlcypUPmW
   QkYtNKhjK2OMUEtdEGM/AiF/yB/GQFdWHoRmBH/pmhECH4IJsMkIf79Jx
   N1D7A/kESZL44Y/TEoFkRfuUZA/zxZalh0Kcq4IugDVP2Eg4T/SzaD/Ne
   2pTkXKwUylkf61donEE3MGbM0LE0Wih/B8u15EOez2MQJvtqRdyQXSGjS
   s20vZCj3xcJaRk7dXVijWbug8kHt0gZvH1T+7uXfUQUpAswqHY4w4HoKw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="355398873"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="355398873"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="803658331"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="803658331"
Received: from nwiklans-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:50:22 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, reinette.chatre@intel.com,
        "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        Wieczor-Retman@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] selftests/openat2: Fix wrong format specifier
Date:   Mon, 28 Aug 2023 12:49:07 +0200
Message-ID: <d71aa14c2a136d9faa7743b6bde414495f4b763c.1693216959.git.maciej.wieczor-retman@intel.com>
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

Ksft_print_msg() inside test_openat2_flags() uses the wrong format
specifier for printing test.how->flags variable.

Change the format specifier to %llX so it matches the printed variable.

Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/openat2/openat2_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 7fb902099de4..9024754530b2 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -300,7 +300,7 @@ void test_openat2_flags(void)
 
 			ksft_print_msg("openat2 unexpectedly returned ");
 			if (fdpath)
-				ksft_print_msg("%d['%s'] with %X (!= %X)\n",
+				ksft_print_msg("%d['%s'] with %X (!= %llX)\n",
 					       fd, fdpath, fdflags,
 					       test->how.flags);
 			else
-- 
2.42.0

