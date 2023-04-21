Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17CC6EA25A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 05:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDUDbd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 23:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjDUDbc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 23:31:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF211FCE;
        Thu, 20 Apr 2023 20:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682047891; x=1713583891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U/E41p5YxUaG+iYuz5KZNygcpR42Y5NTine/xKFrUcs=;
  b=PwXmeB6sVHBoEqQkp86QKRkKhF2QXIxC+WyltJ8Drt66qlh2MlRtBTkz
   MuvW1VgKiQiS7cigj3BfKgsP4+jawKg2uGtWKgXd3uyCuetehjZwaifkz
   i/QPscICD4BXm7fpeynxgl3PfrSEsWQG+3p27ir0d1FgVPYYIR+a3sX0M
   YCMd1veVMsKf9RxkAJmT37WWl2/bvcGRmiZ7ZwJ8nB+Kfu9eSGMr0S/qd
   9ziAUctxOhGyEnvww1kuARLHntTUUWOivCMOzijAspQzOzUsRzytnbt3z
   qGsj7eVjAimii6BY0KJIU3up8CtugBQwvl7wF2lCXF+j4HyfErzp3CHmZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="345923929"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="345923929"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 20:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="816275075"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="816275075"
Received: from laiyi-workstation.sh.intel.com ([10.239.161.127])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2023 20:31:26 -0700
From:   Yi Lai <yi1.lai@intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, shuah@kernel.org,
        jethro@fortanix.com, bp@suse.de
Cc:     linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        heng.su@intel.com, pengfei.xu@intel.com, Yi Lai <yi1.lai@intel.com>
Subject: [RESEND PATCH] selftests/sgx: Add "test_encl.elf" to TEST_FILES
Date:   Fri, 21 Apr 2023 11:31:23 +0800
Message-Id: <20230421033123.445883-1-yi1.lai@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

