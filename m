Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BFA4A000F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiA1SYZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 13:24:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:26185 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347038AbiA1SYY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 13:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643394264; x=1674930264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ep1DSR67k0vTlYBwdxQUNSBLuOH3FnHrf9E0uu6Gkqg=;
  b=L+bMcgHarDtqqg7LqLHdh+IcMmoSs7ez0O5+m00fQ9kFiZpm8114exAa
   87tZS+OTqL0FBQuN4cG28MwC6rA7ZmjG16F3Fe3Uswzn4C/MDjo4viEZg
   NKQ+3r0PT1sJAjA74vzR9GgPoEtZ7MJ+OQc7XJ5sglfZmkHfj6Lyy4Bip
   /i3B+B3JDqIS0+LO1xlNDirqRCNnykQMSZbN9qv8YZ2B9cI8UCLq0Uo/P
   V5YyQxKVfkCauXRQ9hXJcSqE28JBHQKJygXO+95+2Dvhzo0NcNxdoDZt1
   UEFh8RK0cga1n9vtEtGqjfOLsQmSR9voovImiWER5EIKoKMeZ2Wjtkvyj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="244773369"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="244773369"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:24:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="581930432"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:24:23 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH 4/4] selftests/sgx: Remove extra newlines in test output
Date:   Fri, 28 Jan 2022 10:23:59 -0800
Message-Id: <699e4e1382e005386722bc296602d1b270a28b1e.1643393473.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643393473.git.reinette.chatre@intel.com>
References: <cover.1643393473.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
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

