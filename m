Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C2345240D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Nov 2021 02:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbhKPBfz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 20:35:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:59122 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242891AbhKOSrU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 13:47:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220713109"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="220713109"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 10:35:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="454130657"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 10:35:37 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com
Cc:     seanjc@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 07/13] selftests/sgx: Move setup_test_encl() to each TEST_F()
Date:   Mon, 15 Nov 2021 10:35:20 -0800
Message-Id: <70ca264535d2ca0dc8dcaf2281e7d6965f8d4a24.1636997631.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1636997631.git.reinette.chatre@intel.com>
References: <cover.1636997631.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

Create the test enclave inside each TEST_F(), instead of FIXTURE_SETUP(),
so that the heap size can be defined per test.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Add signature from Dave.

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

