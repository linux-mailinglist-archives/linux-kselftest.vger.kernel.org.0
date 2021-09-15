Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8015240CDFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 22:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhIOUch (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 16:32:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:13811 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231940AbhIOUce (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 16:32:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286109365"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="286109365"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:14 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545092778"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:14 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     linux-sgx@vger.kernel.org, jarkko@kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] selftests/sgx: Dump segments and /proc/self/maps only on failure
Date:   Wed, 15 Sep 2021 13:30:56 -0700
Message-Id: <968ee11bd65ef200716ec070ec098eb95f0578b6.1631731214.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

Logging is always a compromise between clarity and detail. The main use
case for dumping VMA's is when FIXTURE_SETUP() fails, and is less important
for enclaves that do initialize correctly. Therefore, print the segments
and /proc/self/maps only in the error case.

Finally, if a single test ever creates multiple enclaves, the amount of
log lines would become enormous.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/main.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 6858a35fed20..deab02f2f3ce 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -127,12 +127,6 @@ FIXTURE_SETUP(enclave)
 		ksft_exit_skip("cannot load enclaves\n");
 	}
 
-	for (i = 0; i < self->encl.nr_segments; i++) {
-		seg = &self->encl.segment_tbl[i];
-
-		TH_LOG("0x%016lx 0x%016lx 0x%02x", seg->offset, seg->size, seg->prot);
-	}
-
 	if (!encl_measure(&self->encl))
 		goto err;
 
@@ -169,6 +163,17 @@ FIXTURE_SETUP(enclave)
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
+	return;
+
+err:
+	encl_delete(&self->encl);
+
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		seg = &self->encl.segment_tbl[i];
+
+		TH_LOG("0x%016lx 0x%016lx 0x%02x", seg->offset, seg->size, seg->prot);
+	}
+
 	maps_file = fopen("/proc/self/maps", "r");
 	if (maps_file != NULL)  {
 		while (fgets(maps_line, sizeof(maps_line), maps_file) != NULL) {
@@ -181,11 +186,7 @@ FIXTURE_SETUP(enclave)
 		fclose(maps_file);
 	}
 
-err:
-	if (!sgx_enter_enclave_sym)
-		encl_delete(&self->encl);
-
-	ASSERT_NE(sgx_enter_enclave_sym, NULL);
+	ASSERT_TRUE(false);
 }
 
 FIXTURE_TEARDOWN(enclave)
-- 
2.25.1

