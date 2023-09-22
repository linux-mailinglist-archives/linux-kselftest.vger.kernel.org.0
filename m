Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B527AAD6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjIVJHe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 05:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjIVJHd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 05:07:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D05E8;
        Fri, 22 Sep 2023 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695373647; x=1726909647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zojj109GZBbPxByigSVPb5D5ra85zAqBk8BYV5s4DvQ=;
  b=A1z9tSD16hX8tDDo/AaM4W72dIXKlBDfQGWf+a35ZuVvMsyxMmVpXQZu
   0WdA4of7BS6NuV6T52PlFMKI4zHgO7gqsnrPrNzVjAP2rkrZYff3nkTi7
   A8PrxKCmkvkmW+dHkkHmdOoFbDmhxeWfVcMkjDV7W8eAqxznK861A3nXS
   E1oYZoatrTP511x2W2zSdwPHAIRkI6+l9UkpblSHKzIljS4gf1xzjUEox
   JIY5Hsuwyvv2SrC4IHF1+M61+sgbC/q2UaD6+ggs8N1/mvdXld+oMMZCv
   eC93wkqf8Ffk4Q9HWrsQjaTcxZ367wH0t8yEJWHaC7pz/htU6XnknsmKR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="378070874"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="378070874"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="837663857"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="837663857"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:07:25 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] selftests/sigaltstack: Fix wrong format specifier
Date:   Fri, 22 Sep 2023 11:06:41 +0200
Message-ID: <84fc912d23fec3d2a866df7a8f0a48665784fa8c.1695373131.git.maciej.wieczor-retman@intel.com>
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

The format specifier inside ksft printing function expects a long
unsigned int but the passed variable is of unsigned int type.

Fix the format specifier so it matches the passed variable.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Add Reviewed-by tag (Ilpo)

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

