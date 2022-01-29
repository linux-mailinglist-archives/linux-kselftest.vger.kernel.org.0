Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55844A3110
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jan 2022 18:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346024AbiA2Rof (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jan 2022 12:44:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:54627 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349021AbiA2Roe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jan 2022 12:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643478274; x=1675014274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Owt2/avuqAtl47qyDRa69L2r49VRLIBmzHJVHbW63DI=;
  b=Eq8l1mgmpBjGQGZdDUWC4dJ6conUqJPVO/Lca1/+7cLVZHemH+oBcPkX
   UMItrGkOOorlaf8Nc7xviLpdBuvQ1W9S9rThBtPQmXNQuU9Nxy/EfW2FG
   3RWCTjMU693M1r+8R9gkFxIK6eqLELp7Rpa5yzBUkZkA+9Iu9uxE2fYZL
   0GU3+RHD/Q37wU9rXVLqOXvbSpMk1pramWIduJsV53fAedcD3VWx1Q4ye
   V1up1PEiGE0C8pxUhJmSZMeEIo0ghi4Nvq3cjxuXLjGXwW0fAZcitCfyd
   5CwxstTcd+cUVnNDA+bpeo9tTY/S8E8jkbd5TnS1gqC7WSsLHJgCgeoha
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="308016821"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="308016821"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 09:44:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="675370405"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2022 09:44:34 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com
Cc:     yang.zhong@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: [PATCH v4 2/2] selftests/x86/amx: Update the ARCH_REQ_XCOMP_PERM test
Date:   Sat, 29 Jan 2022 09:36:47 -0800
Message-Id: <20220129173647.27981-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220129173647.27981-1-chang.seok.bae@intel.com>
References: <20220129173647.27981-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update the arch_prctl test to check the permission bitmap whether the
requested feature is added as expected or not.

Every non-dynamic feature that is enabled is permitted already for use.
TILECFG is not dynamic feature. Ensure the bit is always on from
ARCH_GET_XCOMP_PERM.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/x86/amx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 3615ef4a48bb..e1e2c8f3356f 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -368,9 +368,16 @@ static void req_xtiledata_perm(void)
 
 static void validate_req_xcomp_perm(enum expected_result exp)
 {
-	unsigned long bitmask;
+	unsigned long bitmask, expected_bitmask;
 	long rc;
 
+	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_PERM, &bitmask);
+	if (rc) {
+		fatal_error("prctl(ARCH_GET_XCOMP_PERM) error: %ld", rc);
+	} else if (!(bitmask & XFEATURE_MASK_XTILECFG)) {
+		fatal_error("ARCH_GET_XCOMP_PERM returns XFEATURE_XTILECFG off.");
+	}
+
 	rc = syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_PERM, XFEATURE_XTILEDATA);
 	if (exp == FAIL_EXPECTED) {
 		if (rc) {
@@ -383,10 +390,15 @@ static void validate_req_xcomp_perm(enum expected_result exp)
 		fatal_error("ARCH_REQ_XCOMP_PERM saw unexpected failure.\n");
 	}
 
+	expected_bitmask = bitmask | XFEATURE_MASK_XTILEDATA;
+
 	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_PERM, &bitmask);
 	if (rc) {
 		fatal_error("prctl(ARCH_GET_XCOMP_PERM) error: %ld", rc);
-	} else if (bitmask & XFEATURE_MASK_XTILE) {
+	} else if (bitmask != expected_bitmask) {
+		fatal_error("ARCH_REQ_XCOMP_PERM saw a wrong bitmask: %lx, expected: %lx.\n",
+			    bitmask, expected_bitmask);
+	} else {
 		printf("\tARCH_REQ_XCOMP_PERM is successful.\n");
 	}
 }
-- 
2.17.1

