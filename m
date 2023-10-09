Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287597BD898
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbjJIKb3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345857AbjJIKb2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:31:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6D8DB;
        Mon,  9 Oct 2023 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696847484; x=1728383484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b4TyoAhMCzLpIfy+bwpbogijkWzx9xqBmM+wkUI3lCg=;
  b=ZxfpsSbbubPHPc6g0/mRarUrxaXXStdrl36m0qkXa7MSqAmEi/kyrIS8
   N4Iv0N25ZJIX9Z902x6M0E9BcRXmFUVPcVo6dXlhr2q6HkWjeTxS/d3xT
   +20u4/BCejrG1Yi+nTc3tRw1GyhXkeaYybiRm6SNU4bJoiYxvsOzmuDr5
   sSr+wfWbo6HPvak9jac4VGibwJJp3BPf5mWcO3huqpRFwyb5xrxTJM8sk
   EjkbYclq96yfUxRENnAMPPNnKzKraDIuuTTkBCQ/p4KOnm0MPBnemhoWY
   7hSWWf4B5lZL+6MYms0Pt8f0WDOeCRDWmPecXb/8Y08wVq0zM2RomMAHW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="363468413"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="363468413"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="926718676"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="926718676"
Received: from kkensic-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.30.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:22 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] selftests/openat2: Fix wrong format specifier
Date:   Mon,  9 Oct 2023 12:30:37 +0200
Message-ID: <d49fbcd95fd5f0c839e73dedb8f10b3f714e3f52.1696846568.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
References: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
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

Ksft_print_msg() inside test_openat2_flags() uses the wrong format
specifier for printing test.how->flags variable.

Change the format specifier to %llX so it matches the printed variable.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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

