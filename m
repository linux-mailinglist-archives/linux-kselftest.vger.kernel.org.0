Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A3F4AE41A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 23:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386553AbiBHWZt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 17:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387031AbiBHVsw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 16:48:52 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407AEC0612BC;
        Tue,  8 Feb 2022 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644356932; x=1675892932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s0tX+0pl5bXcA0SPU+yggYgA8LCS4TYSxMJl38V+Muc=;
  b=X/4Mnzc08m2lRQCs30OFD+Obo+g30ysvf4C05wOviQS7+0qC7UHLExcS
   8QjigbILEgk9ofUxUkxK2qTGaVEggdW/94ql+9FYeF2JF+rXtoFw470ID
   fePBugZAJpiQNcb9psfEyaWJycQSnFiOStcHZlwsjz7vqUyvaiTr+7Yme
   HVnE1jIlN3qEJTPcThxxMc1YtwawTZR3EeieucqWTqenCYJu1JPmfr6Z0
   nX8aES+BC0QSMFYc52EEbPQYqtzH2C6GvsjGZN1bpIDowcb0MpE0PM2MF
   xes0XaGuEOjWIe50XCTcJz829UX6bVJSEdQnUZrlH4MM9lmA2gp0U9d01
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="309805368"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="309805368"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:48:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="632992867"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:48:49 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/4] selftests/sgx: Ensure enclave data available during debug print
Date:   Tue,  8 Feb 2022 13:48:41 -0800
Message-Id: <dab672f771e9b99e50c17ae2a75dc0b020cb0ce9.1644355600.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644355600.git.reinette.chatre@intel.com>
References: <cover.1644355600.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In support of debugging the SGX tests print details from
the enclave and its memory mappings if any failure is encountered
during enclave loading.

When a failure is encountered no data is printed because the
printing of the data is preceded by cleanup of the data.

Move the data cleanup after the data print.

Fixes: 147172148909 ("selftests/sgx: Dump segments and /proc/self/maps only on failure")
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- Add Acked-by from Shuah.

 tools/testing/selftests/sgx/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index a7cd2c3e6f7e..b0bd95a4730d 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -186,8 +186,6 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 	return true;
 
 err:
-	encl_delete(encl);
-
 	for (i = 0; i < encl->nr_segments; i++) {
 		seg = &encl->segment_tbl[i];
 
@@ -208,6 +206,8 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 
 	TH_LOG("Failed to initialize the test enclave.\n");
 
+	encl_delete(encl);
+
 	return false;
 }
 
-- 
2.25.1

