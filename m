Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92917AAD75
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 11:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjIVJIC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 05:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjIVJHz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 05:07:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAC5197;
        Fri, 22 Sep 2023 02:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695373668; x=1726909668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bdu41z44xg0Fpb+rhew4qBVoBtMMCUBJABN2/+5EZiI=;
  b=dm2ozLtKqJ0JkEouBiqDh8ZJpRfahXupL67sAyHRJaFAv1StZBswa/GW
   5SBSLbpKr7aLwp+AMypsBH9OXwLwQ3EShzXWzTwospUtSiJ3z8QA7B5Bb
   faVB1s3yV+WTMbrgjzi3dDvsf1PvP3WsGuFhNMNu5dCOlRfMTSD9Wtft4
   2Wu2mMKDirOLoaqwNN/97IiddQ/AgP2vzpENEOm6EdK2RjGvsUOe6xiuP
   BpDqHPh0ZwaccdeCxmN2fk9zeXHygKAG4lZAUX83OAqR7BiM8ZU687Q31
   GvKu5r+LhD0iISA/lopKfVFNPWr8qliZbz6hgbZgbDwEs0e1CBvMbZ/GV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="378070925"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="378070925"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="837663993"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="837663993"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:07:45 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] selftests/mm: Substitute attribute with a macro
Date:   Fri, 22 Sep 2023 11:06:43 +0200
Message-ID: <b7b3027b59e3642c08fa53476be49576ec6e22d7.1695373131.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
References: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
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

The mm selftest uses the printf attribute in its full form. Since the
header file that uses it also includes kselftests.h it can use the macro
defined there.

Use __printf() included with kselftests.h instead of the full attribute.

Fix a wrong format specifier in ksft_print_msg().

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Add this patch to the series.

 tools/testing/selftests/mm/mremap_test.c  | 2 +-
 tools/testing/selftests/mm/pkey-helpers.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5c3773de9f0f..1dbfcf6df255 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -338,7 +338,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 		char c = (char) rand();
 
 		if (((char *) dest_addr)[i] != c) {
-			ksft_print_msg("Data after remap doesn't match at offset %d\n",
+			ksft_print_msg("Data after remap doesn't match at offset %llu\n",
 				       i);
 			ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
 					((char *) dest_addr)[i] & 0xff);
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 92f3be3dd8e5..1af3156a9db8 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -34,7 +34,7 @@ extern int test_nr;
 extern int iteration_nr;
 
 #ifdef __GNUC__
-__attribute__((format(printf, 1, 2)))
+__printf(1, 2)
 #endif
 static inline void sigsafe_printf(const char *format, ...)
 {
-- 
2.42.0

