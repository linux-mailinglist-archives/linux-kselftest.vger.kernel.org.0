Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD636DF005
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDLJGW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 05:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDLJGV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 05:06:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33705FEF
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 02:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681290379; x=1712826379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U/E41p5YxUaG+iYuz5KZNygcpR42Y5NTine/xKFrUcs=;
  b=JoJjy3WtC69T3LOhrv/q0id54D3VkAIgM8NdV4faRNcpLCF57n3rQ9vT
   C2CYZ+Wii3Ys0QuP0OKJTxT7As+bXWAVRijIyOYzdVlnY5izyfuaTQ7Y/
   MhWEh+63BQSoG0+4Kt8sk0wPpMj8zdR34aDiSg5Dxphpsmp/zMtPOdTq/
   uxAudroFfq8nyuibbTfN4FNQ7R5gkNbZ+va2WwpaWE26iEkR4GHcRf0jB
   /yjguBJoG4S1Pza7JWXoK+rz8rEfZVY1VrecBf80/eaTySOOkNKehZk4/
   wABWU6EC5NH0YzDBlS8HdqbYsMUr2OzQ33PefQr9q9EA20KfR9c0Xl2Hs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="323468664"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="323468664"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 02:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="682419255"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="682419255"
Received: from laiyi-workstation.sh.intel.com ([10.239.161.127])
  by orsmga007.jf.intel.com with ESMTP; 12 Apr 2023 02:06:01 -0700
From:   Yi Lai <yi1.lai@intel.com>
To:     jarkko@kernel.org, shuah@kernel.org, jethro@fortanix.com
Cc:     linux-kselftest@vger.kernel.org, heng.su@intel.com,
        pengfei.xu@intel.com, Yi Lai <yi1.lai@intel.com>
Subject: [PATCH] selftests/sgx: Add "test_encl.elf" to TEST_FILES
Date:   Wed, 12 Apr 2023 17:05:58 +0800
Message-Id: <20230412090558.55183-1-yi1.lai@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The "test_encl.elf" file used by test_sgx is not installed in
INSTALL_PATH. Attempting to execute test_sgx causes false negative:

"
enclave executable open(): No such file or directory
main.c:188:unclobbered_vdso:Failed to load the test enclave.
"

Add "test_encl.elf" to TEST_FILES so that it will be installed.

Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
Signed-off-by: Yi Lai <yi1.lai@intel.com>
---
 tools/testing/selftests/sgx/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 75af864e07b6..50aab6b57da3 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -17,6 +17,7 @@ ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
 
 TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
+TEST_FILES := $(OUTPUT)/test_encl.elf
 
 ifeq ($(CAN_BUILD_X86_64), 1)
 all: $(TEST_CUSTOM_PROGS) $(OUTPUT)/test_encl.elf
-- 
2.25.1

