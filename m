Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5A87AFB4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 08:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjI0Gpo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 02:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0Gpn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 02:45:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F382D6;
        Tue, 26 Sep 2023 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695797142; x=1727333142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fjpZ8Wfu81snskyoNajzNhzf6MUHxeEtKQbFHYozL5s=;
  b=G57yTHZfEk4IfBym6OT6Uutt71q3DYYJN0HguEwT6XM9K6flHjEOePHW
   2x76FOLhF2EEYXWscoTagFP0ShwL4/yZzS8FB2xee/zaDdkPxKtJECXxD
   MHLYxtecSAElmOeVOmcpXFjkAWsoFwtv4Ne477HRkM7Su10OChbGE2oTe
   IVosohBslsubyx9Zdnoxckh02wYCRwQFlRbFNxD2T4ASh5Uxlm7TkLf8A
   ttrksbT28X9sO6fA1PIrwon7sKnZ2uuocR1GxvJd5z5ZkS20uFE7EEVHG
   +v302JGazsqmSrNFwB5cFQ6egBLU278GmFYLS1DvXwDcnPOMw1wVbBIvt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361130910"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="361130910"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 23:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784212545"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="784212545"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO binbinwu-mobl.sh.intel.com) ([10.238.8.84])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 23:45:38 -0700
From:   Binbin Wu <binbin.wu@linux.intel.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, weihong.zhang@intel.com,
        kirill.shutemov@linux.intel.com, binbin.wu@linux.intel.com
Subject: [PATCH] selftests/x86/lam: Zero out buffer for readlink()
Date:   Sun, 24 Sep 2023 07:33:46 +0800
Message-Id: <20230923233346.12726-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Zero out the buffer for readlink() since readlink() does not append a
terminating null byte to the buffer.

Fixes: 833c12ce0f430 ("selftests/x86/lam: Add inherit test cases for linear-address masking")

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 tools/testing/selftests/x86/lam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index eb0e46905bf9..9f06942a8e25 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -680,7 +680,7 @@ static int handle_execve(struct testcases *test)
 		perror("Fork failed.");
 		ret = 1;
 	} else if (pid == 0) {
-		char path[PATH_MAX];
+		char path[PATH_MAX] = {0};
 
 		/* Set LAM mode in parent process */
 		if (set_lam(lam) != 0)

base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
-- 
2.25.1

