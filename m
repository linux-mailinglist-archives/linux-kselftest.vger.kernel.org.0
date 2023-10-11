Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9410D7C4D07
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 10:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjJKIYy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 04:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjJKIYw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 04:24:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E78FE5;
        Wed, 11 Oct 2023 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697012691; x=1728548691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IHXhr/Amo8gh/HA2VTVFzzTi37cYr/rpIJkcT+9qONg=;
  b=GmS8t6GDSmKu0CtDygyTFadd32639nQBJ8Dq7FWC8lEiYJuXKVY+sMb5
   cLg4IiX+/zKwvMc5a5ENOZ2KGcLgMH/qAW/lnWvlPGwUEAVdddD7WW/O3
   DXNyGxn0lVndA+LR7JxZuOxex/uJkNcvEytU77onwHxN8Q27gR4Cj0AgO
   KbHUripOXeRfmyEFwRzxI2Xw5OYtfrVRbSz/kF2bEhNJ0CQCYCQoCiSZA
   cmCQhFqxl/L0z/QKeQvHnA7xiQXRiRUvx2JoiCPt0cj1b9Yt9pP17Hkpr
   tHgpE9O2b1Rnpco3wA6YRb6PsIQWqrlvumlECIwTNMMTNm/9AqdOyOS/2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3200842"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="3200842"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730411699"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730411699"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.17.119])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:24:48 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/8] selftests/sigaltstack: Fix wrong format specifier
Date:   Wed, 11 Oct 2023 10:24:01 +0200
Message-ID: <df27092ac13effd0e916f305a7f94ca36800af2c.1697012398.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
References: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The format specifier inside ksft printing function expects a long
unsigned int but the passed variable is of unsigned int type.

Fix the format specifier so it matches the passed variable.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changelog v2:
- Added Reviewed-by tag (Ilpo)

 tools/testing/selftests/sigaltstack/sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 98d37cb744fb..07227fab1cc9 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -111,7 +111,7 @@ int main(void)
 
 	/* Make sure more than the required minimum. */
 	stack_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
-	ksft_print_msg("[NOTE]\tthe stack size is %lu\n", stack_size);
+	ksft_print_msg("[NOTE]\tthe stack size is %u\n", stack_size);
 
 	ksft_print_header();
 	ksft_set_plan(3);
-- 
2.42.0

