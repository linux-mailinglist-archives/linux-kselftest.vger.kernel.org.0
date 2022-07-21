Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060D757D44E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 21:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiGUTlD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUTlC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 15:41:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC3721835;
        Thu, 21 Jul 2022 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658432460; x=1689968460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PhS/zQUPcfu9H4uVYieyirL1CK6rsaq9YcmD4ElQ4/Q=;
  b=UjEdckXKhPB1D1iYJwhOYKJwPVZItpO7yllisGOV9T0UpMkxhwAs19hT
   tZ4gyNE2I/mG32U00oiwnTG1rt8sHgD7L1/Ma2osKSAqM4PYmyoxwjpth
   otMZHMry2fOKTtDr1zbZs1WLVO+CBNp/F3NdKqLuKz4hbL8LDXLJep3Pz
   QlowpzrYKCoti2hBGw1sczhrXFH0mLbOFCDEPxcK8lEaVhjcCNp8VNESF
   uWIDIqtFU8jO49vPRVQ9yc6SBhMFt1B9C7pwJZwqE2PCwp8dTTVO8w7sk
   p6Mug0HgtiHpikVSrX2F8rtC/NlLgrAbKRPTtrO7bSEEYK7Cq00dpheQu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287164465"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="287164465"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 12:40:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="548910711"
Received: from kputtann-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.21.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 12:40:58 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/sgx: Ignore OpenSSL 3.0 deprecated functions warning
Date:   Thu, 21 Jul 2022 12:40:40 -0700
Message-Id: <20220721194041.43970-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

OpenSSL 3.0 deprecates some of the functions used in the SGX
selftests, causing build errors on new distros. For now ignore
the warnings until support for the functions is no longer
available.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 tools/testing/selftests/sgx/sigstruct.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index 50c5ab1aa6fa..bb191b70141a 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -17,6 +17,9 @@
 #include "defines.h"
 #include "main.h"
 
+/* OpenSSL 3.0 has deprecated some functions. For now just ignore the warnings. */
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 struct q1q2_ctx {
 	BN_CTX *bn_ctx;
 	BIGNUM *m;
-- 
2.36.1

