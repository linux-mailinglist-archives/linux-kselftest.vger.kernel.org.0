Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B057C84A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 13:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjJMLiN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 07:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjJMLiB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 07:38:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668B4D8;
        Fri, 13 Oct 2023 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697197080; x=1728733080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ariT8CxKR/Cq66g3cxCDu1qA3Q2jySEnMOrVryK1YyE=;
  b=KeaW/zj8Fyo7JmVkJ9AJB/uUDUgXpt6pahieTmhUCpAwU6kbzE0MUpSC
   KO1e/M+4GiSy0ipHcD+gNCcfxdUiqQyi4rW9N5R47/Qrfqr/fdFZ5PRPm
   gCLtzzi3lDSkYyafYLqYUKyjThcaSugOFLhfqk8ftnw8RDGteSevz99ft
   Aun7ZmegWj4YQV4SdTe7kLetHa1+iMdjquuGD4rTueUPRNCyPfc5bICQp
   HhEB76Vg2U9RVenIrTsOrBwpxwcJKO+dt/LUBQtiVLo4D2iS+VnuxVMir
   ilGkMDAGkB0vzdk+u+tO3+uK09S6EtFKUvuHvUMkHV9QbCdjbJSsEAo/R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449353365"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="449353365"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754675817"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="754675817"
Received: from bsankiew-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:37:56 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/8] selftests/mm: Substitute attribute with a macro
Date:   Fri, 13 Oct 2023 13:36:31 +0200
Message-ID: <d12e0d3f4c7505972877a507b2bfe29591ddde93.1697196663.git.maciej.wieczor-retman@intel.com>
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

Compiling mm selftest after adding a __printf() attribute to
ksft_print_msg() exposes -Wformat warning in remap_region().

Fix the wrong format specifier causing the warning.

The mm selftest uses the printf attribute in its full form. Since the
header file that uses it also includes kselftests.h it can use the macro
defined there.

Use __printf() included with kselftests.h instead of the full attribute.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v6:
- Add an explanation to the patch message on how the warning that the
  patch resolves was caught. (Shuah)

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

