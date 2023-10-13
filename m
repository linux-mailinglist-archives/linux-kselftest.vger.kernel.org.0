Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FACA7C848A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 13:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjJMLhU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 07:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjJMLhT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 07:37:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B53BE;
        Fri, 13 Oct 2023 04:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697197038; x=1728733038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gTgib667BScrz5onb7ynxK7m+MW46u9fJ0JCzv+4y3s=;
  b=NyAxajDAvMySUR/VPdqaYxho5Tmfn2AsmCiZl3SXfjscMjY9oFO2w+cQ
   aPDHYpYoP1EXAsNwacK5CJ3YxTEDzeK//+7jvy0U+Xp+8QrldmPFkJSay
   ehD7ZS7TUHh39UinusA68511dikXh6pA7ayEC9sW8uQIVszv6hlPBypm6
   ZYtnLCZTcLmAAwD8TkOgbbTn9Ne+y2TmP22mEm6xckGU/eHxNT4BQYQks
   ixQKbedHXR18hHtDdp/NJ9SxojD/oW7L1mN56hVcnq7qJQyjtyFaymNi8
   qSE81/YdK60uwub9/9RpDOCVWrtZwxciuvuvd02hSZA9etxSLNQtcaMrB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449353259"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="449353259"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:37:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754675671"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="754675671"
Received: from bsankiew-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:37:15 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] selftests/openat2: Fix wrong format specifier
Date:   Fri, 13 Oct 2023 13:36:27 +0200
Message-ID: <d0fd9e1506676076f14e0ea65766667cb7d3239c.1697196663.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
References: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Compiling openat2 selftest after adding a __printf() attribute to
ksft_print_msg() exposes a -Wformat warning in test_openat2_flags().
The wrong format specifier is used for printing test.how->flags
variable.

Change the format specifier to %llX so it matches the printed variable.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changelog v6:
- Add an explanation to the patch message on how the warning that the
  patch resolves was caught. (Shuah)

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

