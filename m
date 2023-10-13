Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574E87C848E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjJMLhi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 07:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJMLhf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 07:37:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B4EF2;
        Fri, 13 Oct 2023 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697197051; x=1728733051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bx8/TmfDVTeLxrpfdTbDmZDE+cWxEKh3qGqlPOmMng=;
  b=iZdKPMCGGckxmal5iV9nMHy55QeycyUMFXx2J2KMOJQMJKO2evzLpl79
   QkP0u+UR+xLMdNI07gbaQK7GZRZmin0+bct2BjOh6AosKTg1Liyq+2e5G
   kMCJoD7wAV9T0h+j8XfL+31zl27XbrCCQ5vbEVlGrTGni5Tvw9/nfaqGS
   6OL8pTpOww6WCp5VMkk6bxqBOLwnWNlJLgJIxLnmDYfiDqJiTGH9FwPR1
   n/kBdUtil9AXTJY9RUpf5zsWAsq5my27i9Ds1tK1QHLtnjAlokrKqrvX7
   YgTViSUsslJwXEP+tqizSwT2R1NY2VBcC+lMvluvdlJrTzerVwNbPZid7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449353302"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="449353302"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:37:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754675749"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="754675749"
Received: from bsankiew-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:37:27 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/8] selftests/sigaltstack: Fix wrong format specifier
Date:   Fri, 13 Oct 2023 13:36:29 +0200
Message-ID: <64236465acd03192975dd174aae9b99aad323987.1697196663.git.maciej.wieczor-retman@intel.com>
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

Compiling sigaltstack selftest after adding a __printf() attribute to
ksft_print_msg() exposes -Wformat warning in main().
The format specifier inside ksft_print_msg() expects a long
unsigned int but the passed variable is of unsigned int type.

Fix the format specifier so it matches the passed variable.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changelog v6:
- Add an explanation to the patch message on how the warning that the
  patch resolves was caught. (Shuah)

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

