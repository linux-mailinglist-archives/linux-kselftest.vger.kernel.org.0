Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94478791774
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352997AbjIDMp6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 08:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352971AbjIDMp4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 08:45:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77494CDB;
        Mon,  4 Sep 2023 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693831551; x=1725367551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HI4lVmI1BviZYccM5IrIZHGszBCHZkniFynHIcYP17g=;
  b=XmKvkhp3ofRk3f9OdPjvhoKCosAi8RszwFRSH6JxqOEdLGLjSowPBdPZ
   T8wBUsXAVN21dzi3/BxcqYawalkhpWih3xaxkh3AMiU+vO4IVOLns+TLU
   paoEdNtlkhTOLU2VpTjub/zBAjxuQ2XvNQsee+/IO4aC4+K8GAegg9jQw
   jG7NpbMkd9NTrs/O1mDqdjeLUoj0my3HQEamn4XrvpY+G7BbG20HN9sjc
   S5bEYWfj+D1rFUo0cK4+y91Iyt//XFk9vQrmxcNbbNHa+XEktdr2mxR0O
   36fE2zgZOgMs+Tp3zDMlXHWE0OGcrEZYv9t5AuhXG6TLcFy1gxP7g+SUl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="440555430"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="440555430"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="914497849"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914497849"
Received: from mfederki-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.15.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:35 -0700
From:   Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] selftests/mm: Substitute attribute with a macro
Date:   Mon,  4 Sep 2023 14:44:30 +0200
Message-ID: <b052de0ba4f0649eaedc2bba004bd68fa2aeb50d.1693829810.git.maciej.wieczor-retman@intel.com>
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

The mm selftest uses the printf attribute in its full form. Since the
header file that uses it also includes kselftests.h it can use the macro
defined there.

Use __printf() included with kselftests.h instead of the full attribute.

Fix a wrong format specifier in ksft_print_msg().

Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Added this patch to the series.

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

