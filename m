Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D5078AE0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjH1Ky6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjH1Kyw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:54:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F5D8;
        Mon, 28 Aug 2023 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693220065; x=1724756065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QSTkRKepbci7ZibAbLE07UEc26Bgp7zEFWSUgACZfHY=;
  b=Eai3InN0kYeNuPXpWc7UglyYQMAFkt7qGX+k2jpkEU8O9LaYbEo/ZfNf
   OWje54hFiEK+gdg3k2Rnw4TtzKC2YwizNMLSXQoaZzOZJMHb8cU1qg3vp
   XpHohgSCf+XLKLngMqMKwAUhsNyZBXa4OWko6jzSIoPRkwcVoLBEE0DYj
   LGig1zJh33OscIqmoZsyjTulsyYw3y2BK6I1JnP1QviyGaRbZVRM8XZy/
   lFDMfl9EkNwTLkH/hnZhe4Ed1rzGdCDMs8C7v5a+jjtrY9CtWqp8LDHku
   HsnntEublYD6frubdPhT6paxY6P+eNPgqkKk2tYJldY/kILlICzbAyPlG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="355398964"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="355398964"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="803658351"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="803658351"
Received: from nwiklans-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:50:53 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, reinette.chatre@intel.com,
        "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        Wieczor-Retman@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] selftests/sigaltstack: Fix wrong format specifier
Date:   Mon, 28 Aug 2023 12:49:09 +0200
Message-ID: <613189f12a8c15df7dc725e4b7ed66ffa4b30fb5.1693216959.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
References: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
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

The format specifier inside ksft printing function expects a long
unsigned int but the passed variable is of unsigned int type.

Fix the format specifier so it matches the passed variable.

Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
---
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

