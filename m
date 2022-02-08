Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CFD4AE432
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 23:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386523AbiBHWZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 17:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387030AbiBHVsw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 16:48:52 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11888C0612B8;
        Tue,  8 Feb 2022 13:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644356931; x=1675892931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SE5sCiy+dRL7r3+PSeTM1Kw96jjyzlor4t7Em7ahwY0=;
  b=NgvC2HhJQ/nPf0Tn24dRwSO2IKLF/JF9gUUq47TS6DZYRM6/V2HGZVNR
   NG8BWPKtsa/SmldJyjtonna6TGdtbLaPMY3SZBBrx4nCBFwhZ6RkP6y6V
   a4XkYyuk7yXBf6Jw/KBvi5n+1txxrNTcpQ4uEzf8ZSJSLfFeOdZKn+dui
   96j3KM6q5khZg//6zMbDAyR2+qgCaK11inbrUwuTDvL/rcqSwGz+Lx2iH
   5cgWW+E7fACoFfTd2dF5QszLe6hBZo61mJqyP/0xWtvsGbr8IXDDnd7Ps
   JAis5tVHvU7kfGaXhMOFwsabNMb+LYv4kb0W9IMT8msXP7Mp+K9iJpclE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="309805367"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="309805367"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:48:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="632992866"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:48:49 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/4] selftests/sgx: Do not attempt enclave build without valid enclave
Date:   Tue,  8 Feb 2022 13:48:40 -0800
Message-Id: <e3778c77f95e6dca348c732b12f155051d2899b4.1644355600.git.reinette.chatre@intel.com>
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

It is not possible to build an enclave if it was not possible to load
the binary from which it should be constructed. Do not attempt
to make further progress but instead return with failure. A
"return false" from setup_test_encl() is expected to trip an
ASSERT_TRUE() and abort the rest of the test.

Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- Add Acked-by from Shuah.

Changes since V1:
- Add Acked-by from Dave.
- Detail in commit log what callers will see with this change (Dave).

 tools/testing/selftests/sgx/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 370c4995f7c4..a7cd2c3e6f7e 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -147,6 +147,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 	if (!encl_load("test_encl.elf", encl, heap_size)) {
 		encl_delete(encl);
 		TH_LOG("Failed to load the test enclave.\n");
+		return false;
 	}
 
 	if (!encl_measure(encl))
-- 
2.25.1

