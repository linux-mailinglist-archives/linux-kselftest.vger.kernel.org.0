Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A4E67E8B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 15:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjA0O4n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 09:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjA0O4m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 09:56:42 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5E43BD95;
        Fri, 27 Jan 2023 06:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674831402; x=1706367402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nqGsro9x3Ly10ZkoIRHvC0P7jMS0S/jmWDsPx3WjnAQ=;
  b=llyz1y5BinRmqBqQQA2f6MLHmVSBl7d57sXFa2e7OyHfjVIfDsrzVlNa
   VV3+K0A4C6poRkGl0G7rmf3eCH4lldyJbiKbm1MFuN1pU+HYWIsNAFafE
   oxFvMh6Brjc0q8D7ky5hzJd40bz6nqkcgZC+lb+Rd5YphPnbcklwkA2ri
   pNb/CUAWoNr5O7Og0otiJPPotbUsBPMXexWL9wzlVfv35Sbbn+7cMH5gX
   s5rUrppDt5JvHCY0mVRselsmvWCDvDX12HcPIz2KUgyJYArnlmJZ8pFpo
   gCJjWeRqrGwMsY0Gzg54HONDuQxJUuqJEYZkLC7kKq3MHD+iaSxG5e8Lh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="307444799"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="307444799"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 06:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="663288299"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="663288299"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2023 06:56:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CE5BC1A5; Fri, 27 Jan 2023 16:57:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] .gitignore: Unignore .kunitconfig
Date:   Fri, 27 Jan 2023 16:57:08 +0200
Message-Id: <20230127145708.12915-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are almost dozen of .kunitconfig files that are ignored but
tracked. Unignore them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 22984d22d29e..e4f2ba0be516 100644
--- a/.gitignore
+++ b/.gitignore
@@ -100,6 +100,7 @@ modules.order
 !.get_maintainer.ignore
 !.gitattributes
 !.gitignore
+!.kunitconfig
 !.mailmap
 !.rustfmt.toml
 
-- 
2.39.0

