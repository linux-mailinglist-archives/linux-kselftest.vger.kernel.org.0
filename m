Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5776C4AE421
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 23:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387621AbiBHWZy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 17:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387033AbiBHVsw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 16:48:52 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAB4C0612BE;
        Tue,  8 Feb 2022 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644356932; x=1675892932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i0kAY4g/MZJ7vvBHPcqkSBopKtS9n2VC7jnthVGE/BE=;
  b=c5Op6eBzbfACVJuQkPiWmMX0zHWEF97Rq2eNyyjdorOpxMAW8CuZsjKp
   mu24r7Tt0mh7iQXO48cBA/MLKWKIF62CYX8TvejTcQ8L1rwzuJqYrKBHG
   xs7DbKhsEv/VFNH9UrvyDRc+/TFIOYlx/I8WQmcOGaMTW1d5yd5Luzh14
   +L0uXGCIrbWyKyfjeSRuvuSjb52UJxZbJ+V1zHeef4m+4BqRTtAOoPZFT
   o6L/cERqTuOhzeczWpNaiQ4F/OvqxsNaKIiHGHuEcvBx0TAKgOzAMkxV3
   +vn4lUctf9yy1kTwXFGpy9npmkFcKtSlOyZnIkqVxyoLDYliS82AyXfJg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="309805369"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="309805369"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:48:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="632992868"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:48:49 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] selftests/sgx: Remove extra newlines in test output
Date:   Tue,  8 Feb 2022 13:48:42 -0800
Message-Id: <6fd171ba622aed172a7c5b129d34d50bd0482f24.1644355600.git.reinette.chatre@intel.com>
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

The TH_LOG() macro is an optional debug logging function made
available by kselftest itself. When TH_LOG_ENABLED is set it
prints the provided message with additional information and
formatting that already includes a newline.

Providing a newline to the message printed by TH_LOG() results
in a double newline that produces irregular test output.

Remove the unnecessary newlines from the text provided to
TH_LOG().

Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- Add Acked-by from Shuah.

Changes since V1:
- Add Acked-by from Dave.

 tools/testing/selftests/sgx/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index b0bd95a4730d..dd74fa42302e 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -146,7 +146,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 
 	if (!encl_load("test_encl.elf", encl, heap_size)) {
 		encl_delete(encl);
-		TH_LOG("Failed to load the test enclave.\n");
+		TH_LOG("Failed to load the test enclave.");
 		return false;
 	}
 
@@ -204,7 +204,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 		fclose(maps_file);
 	}
 
-	TH_LOG("Failed to initialize the test enclave.\n");
+	TH_LOG("Failed to initialize the test enclave.");
 
 	encl_delete(encl);
 
-- 
2.25.1

