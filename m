Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15DC6D3C98
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 06:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjDCEzl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 00:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDCEzk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 00:55:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE359030;
        Sun,  2 Apr 2023 21:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680497739; x=1712033739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Is8fj3zJKTZDSXv8iw0EPER+gTr6qXPPdy6BaVHjocs=;
  b=BsMf/gZ1TYalkF+c10zgoAOUcmBHT4wcTAPFKh3N1NCw93C1C4Ha2dud
   yeqYq10VCgFr2QuUBuoKBobOu8NEYlGf7tCUKYCve92gqCmSPLEY3X3AN
   7kOSjI2sUAAJ+U+tm9FsiYd52MYi0zd7i3aBcYIlx8cxx8zetkpiK+LDm
   x9gQ6/Z462McjpVYnWOFmycOERGUwYYjNJva74Y4Y2xYG5HvC8LkTTWdG
   HKBG2kiZGFLkR+UWW39Y9uMz7WCCCyyJ3RTS+G87uU7nHr6UQ34VCfrUw
   F58N46fuOPNO3yODBof1c53Iy7oSZqnzdpeNk1accwATtB5NSH9ow8l0H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="344362547"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="344362547"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 21:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="829421520"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="829421520"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2023 21:55:37 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, luto@kernel.org, dave.hansen@intel.com,
        tglx@linutronix.de, bp@suse.de, jun.miao@windriver.com,
        chang.seok.bae@intel.com
Subject: [PATCH v1 2/4] selftests/x86/mov_ss_trap: Include processor-flags.h
Date:   Sun,  2 Apr 2023 21:43:38 -0700
Message-Id: <20230403044340.1312-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230403044340.1312-1-chang.seok.bae@intel.com>
References: <20230403044340.1312-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Instead of defining X86_EFLAGS_RF, include the header file.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Resolve here before including helper.h in the next patch which,
otherwise, has to remove the define there along with other changes.
---
 tools/testing/selftests/x86/mov_ss_trap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index 6b9bf8dc3b60..f8633aafc90c 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -35,8 +35,7 @@
 #include <string.h>
 #include <setjmp.h>
 #include <sys/prctl.h>
-
-#define X86_EFLAGS_RF (1UL << 16)
+#include <asm/processor-flags.h>
 
 #if __x86_64__
 # define REG_IP REG_RIP
-- 
2.17.1

