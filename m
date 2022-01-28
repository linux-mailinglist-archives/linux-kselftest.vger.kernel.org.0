Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8824A0010
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347038AbiA1SYZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 13:24:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:26182 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346536AbiA1SYY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 13:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643394264; x=1674930264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/PUqiKdHwxgbFpofEH5q7cvMjoCYoa9qFbdKYcfqqY=;
  b=D94Ve+JNyrzzzecEVhB4V6qUdyCH/dpE4w/Y4nQp4gt758a9nPtQMKyC
   0hnrJ6nxVZJNKaCnhdEuK9gJOMI8ZMHKWd/MHk/uuo+GVsVgkB0v7IQuJ
   4YPwL6X+FRuA4pzeW772QIX343qlPXoJq8tyDZSXZ/poqNRVohmkh6bOk
   mpQpzbB5NNZFvHEnJCHW7r0lUU3BhS+IW7YLSQf+GTftAFCdgTGo2EhwO
   TH0UiE4wxYegN4cJNUB/UtB3lktz8DSjBG032EYk1voFo7I29ALC+iQMm
   UEDsg/Br6Qmexnr4h5Np8AAcYpmnBjff6gbEPYLDX0sI83WCAo/fo6x1m
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="244773368"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="244773368"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:24:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="581930431"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:24:23 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH 3/4] selftests/sgx: Ensure enclave data available during debug print
Date:   Fri, 28 Jan 2022 10:23:58 -0800
Message-Id: <ddb6554a95b0978aa018740fbfb32f786bcbd284.1643393473.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643393473.git.reinette.chatre@intel.com>
References: <cover.1643393473.git.reinette.chatre@intel.com>
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

