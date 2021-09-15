Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46040CDFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 22:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhIOUcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 16:32:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:13811 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231998AbhIOUcf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 16:32:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286109367"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="286109367"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:15 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545092782"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:15 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     linux-sgx@vger.kernel.org, jarkko@kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] selftests/sgx: Move setup_test_encl() to each TEST_F()
Date:   Wed, 15 Sep 2021 13:30:58 -0700
Message-Id: <093e85bac35416d0159bf5ea917f2871c6169e42.1631731214.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

Create the test enclave inside each TEST_F(), instead of FIXTURE_SETUP(),
so that the heap size can be defined per test.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/main.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 5b3e49a36344..f41fba919d06 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -191,10 +191,6 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 
 FIXTURE_SETUP(enclave)
 {
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
-
-	memset(&self->run, 0, sizeof(self->run));
-	self->run.tcs = self->encl.encl_base;
 }
 
 FIXTURE_TEARDOWN(enclave)
@@ -226,6 +222,11 @@ TEST_F(enclave, unclobbered_vdso)
 {
 	struct encl_op op;
 
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
 	op.type = ENCL_OP_PUT;
 	op.buffer = MAGIC;
 
@@ -248,6 +249,11 @@ TEST_F(enclave, clobbered_vdso)
 {
 	struct encl_op op;
 
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
 	op.type = ENCL_OP_PUT;
 	op.buffer = MAGIC;
 
@@ -278,6 +284,11 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 {
 	struct encl_op op;
 
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
 	self->run.user_handler = (__u64)test_handler;
 	self->run.user_data = 0xdeadbeef;
 
-- 
2.25.1

