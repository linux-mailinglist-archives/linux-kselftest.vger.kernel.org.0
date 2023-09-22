Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EEF7AAD69
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjIVJHW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 05:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjIVJHU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 05:07:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51605E8;
        Fri, 22 Sep 2023 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695373634; x=1726909634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KlaAKoKuo0NKz+v+pcQZY3dMuGk4elrmUzP0ASroud8=;
  b=C8uSrl0aT1P8I5t3p60pD2N40VhIjQwxc1vODrx69jCv0/1ZfkIBJhLc
   vNCtfhT6U7ViDoM1tHNBO1AcqlCCF3HcHLeCvCFC9gkInw9dtaRCdKVex
   4HYH4QPWjwOv4tc4p7CISDXzqiLPBKXjf1wILMFNaexqskdgqkzg3lzrT
   28dq2B2/8vj/BF36IjzEWoCFkYp58qpPWe2RDiF/WGreyx4EL2MJOfbpJ
   Poovfsho4/WLjI/jyQJLAUXC17Rhnno8c6Z6ere24dHAvWMcA1RP0LCqY
   IP4yu9mTKv3I5VpZLrxOBnOZQrBwZKpFLrQpRHNZf9Quhq/KAdfInEpoZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="378070799"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="378070799"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="837663676"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="837663676"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:07:10 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] selftests/openat2: Fix wrong format specifier
Date:   Fri, 22 Sep 2023 11:06:39 +0200
Message-ID: <6733bc42d9c4df87d13c1272e4ab69753fad9ab9.1695373131.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
References: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Ksft_print_msg() inside test_openat2_flags() uses the wrong format
specifier for printing test.how->flags variable.

Change the format specifier to %llX so it matches the printed variable.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Add Reviewed-by tag (Ilpo)

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

