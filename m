Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB64A682B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 23:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbiBAWrP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 17:47:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:18697 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239860AbiBAWrP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 17:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643755635; x=1675291635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pkVzBF2FA4/VUakkZoRXj7x9NWg00p1UuaLfO/qP4vk=;
  b=SLZewVWKuYTR39y1hO8JVwh6Ib/DJPBEEgmrvwwThwwm5kulB4vV7rFH
   8I3Lhbuj0Som6Pork3gfDA6dhdd9dN/CdekrnNbHTeTKypdQ53yirYNyA
   prnRg3NkawfzRuMI6cNkS0qcvLTOhzZY2cmkXmBPMyc4HMNsYtEE8SLHv
   ymx4mXrvcb4DYNJTUHQ1ifO9pJzSxVo7+whA1DsEczJebbR1DzjigXsd2
   zD29AKjuIHNd0mmVNs5svLmq/svmIfZ2q0aHJ7Ae8jVcaleOjAadG8Kl/
   zU+r58Xuy/BHBxrNyNr94bnOjfDOeh2wvSpEpuvIRzbxH83JRcI0anEqh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247582283"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="247582283"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:47:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="698584744"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:47:14 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH V2 3/4] selftests/sgx: Ensure enclave data available during debug print
Date:   Tue,  1 Feb 2022 14:47:05 -0800
Message-Id: <eaaeeb9122916d831942fc8a3043c687137314c1.1643754040.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643754040.git.reinette.chatre@intel.com>
References: <cover.1643754040.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V1.

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

