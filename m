Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345694A682D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 23:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiBAWrQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 17:47:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:18698 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241098AbiBAWrP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 17:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643755635; x=1675291635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JE82XzBjwOsa8Dx89eCExGVuYLlGOygBUFLZoVdUfTc=;
  b=XA+0Dp3gaBQPwLsT180L5vrcpcT/5P+tduwXxlc6+gD2nyuuPlSjBF/e
   SUeX/0H3heS0Vt6i835VcxMIDY4v3p1eE5omYHyaHM4Q0S12MDmGS8ECD
   6mkvUfTEwTmi1Kb2WSSagAvYmTnIaydc7wPL177LLjZl1GZ+qdyG5pvlL
   WE2xGarq0zsgbBy2DkMtQNnNPMBKt/by00fxv5nzhTp7ISjkrT5ty2wta
   5kKA4ULhZV6oK1v6evhEgGVo1JU6+yYwtPRguNrNEXwpPj46AbCsS3M6d
   EOR2tDBmSNQRfxAQfeThQCZtXBuSsBiD7KRYaWKoqzdru+jgEMsfa76Nn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247582284"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="247582284"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:47:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="698584745"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:47:14 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH V2 4/4] selftests/sgx: Remove extra newlines in test output
Date:   Tue,  1 Feb 2022 14:47:06 -0800
Message-Id: <16317683a1822bbd44ab3ca48b60a9a217ac24de.1643754040.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643754040.git.reinette.chatre@intel.com>
References: <cover.1643754040.git.reinette.chatre@intel.com>
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
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
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

