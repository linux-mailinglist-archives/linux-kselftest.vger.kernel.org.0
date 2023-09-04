Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE954791778
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 14:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352957AbjIDMpz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352939AbjIDMpx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 08:45:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADEF100;
        Mon,  4 Sep 2023 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693831541; x=1725367541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oK2oMG0iXA0jLGcy05yT1KHeEFd9CnCki26bJnytwqQ=;
  b=XTedPjpaIvXID4QVEEMNYZHn+iARRIRNgJ/jfMHubTMN7ROxif8pHpAx
   9co9v2654a2gbwKEaCVBNNBEe+BlFNAl7XLE8dt/Om6/ZPug2c+jrgdXo
   wsP64a01ENsPC61b7ieETAxRsJg0ZES7e1xfOSpUYCtQZgIzVxcAPBuii
   elV9gfTgIYZnayCvZ+wKCKTYr4S3nlfUI2ySxbhcyaBLS2fLuq11M4ft2
   3WBizbXrb4PEMqDH68+SlIGcAMOk5a/2Mt+Q+M+78YMrH8AwpqsDmtZn4
   hteSZ0egb5L9H642hwUfFHa/Jd4PGx/v9z/MLhIcNnVqFwoJU9QsxMx6o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="440555397"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="440555397"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="914497813"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914497813"
Received: from mfederki-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.15.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:26 -0700
From:   Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] selftests/openat2: Fix wrong format specifier
Date:   Mon,  4 Sep 2023 14:44:26 +0200
Message-ID: <88c3f59b8fad5296e9e0235946fe48dab154f378.1693829810.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693829810.git.maciej.wieczor-retman@intel.com>
References: <cover.1693829810.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Added Reviewed-by tag (Ilpo)

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

