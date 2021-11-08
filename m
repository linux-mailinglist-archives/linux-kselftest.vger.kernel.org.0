Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFD449F1A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Nov 2021 00:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbhKHXos (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Nov 2021 18:44:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:5566 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240902AbhKHXor (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Nov 2021 18:44:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232292396"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="232292396"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 15:42:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="641642471"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2021 15:42:01 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        bp@alien8.de, mingo@redhat.com, yang.zhong@intel.com,
        jing2.liu@intel.com, chang.seok.bae@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/x86/amx: Update the ARCH_REQ_XCOMP_PERM test
Date:   Mon,  8 Nov 2021 15:35:01 -0800
Message-Id: <20211108233501.11516-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211108233501.11516-1-chang.seok.bae@intel.com>
References: <20211108233501.11516-1-chang.seok.bae@intel.com>
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

