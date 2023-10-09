Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004457BD8A3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbjJIKcC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345888AbjJIKbu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:31:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5409C;
        Mon,  9 Oct 2023 03:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696847505; x=1728383505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VXxoZYWc1k9TebbKU7+nIiD46KUiapqhrZ8TkPNyZG4=;
  b=mD9m564DnVBZmiC/YkQt1k7PfqExGiimQHYnx6QveiIyRLq+4KaqXL3d
   H0KblwdqDmj7AxfnkuZRE8Uk2GGAGsmAAu7hq90MWEuuFztm5E+x6ZMMM
   eyRXbkTuHc2E58RQhmY0qQTn8BvHRLKqy86PzBr1jhoMuY9JiFXljxDsg
   zmMvR8bgyepm7/Wxku6RFiLedgHDT24Zg/wyQRJSwQIDGkiPtdElMFnY9
   nlPz62RQL27i5iz5HHyuF6s1I5fFvzmgMyAXV1aTt/BEUSSMwbaZPlp+a
   nTKbN04ryDKvQWHnpiBwOFVYwaseNoytCSSqfNeFArU/EHP5f+K1ySPXk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="363468470"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="363468470"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="926718745"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="926718745"
Received: from kkensic-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.30.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:41 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] selftests/mm: Substitute attribute with a macro
Date:   Mon,  9 Oct 2023 12:30:41 +0200
Message-ID: <288075f2e0d9c34e5789165f688b2fbbc212b56c.1696846568.git.maciej.wieczor-retman@intel.com>
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

The mm selftest uses the printf attribute in its full form. Since the
header file that uses it also includes kselftests.h it can use the macro
defined there.

Use __printf() included with kselftests.h instead of the full attribute.

Fix a wrong format specifier in ksft_print_msg().

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
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

