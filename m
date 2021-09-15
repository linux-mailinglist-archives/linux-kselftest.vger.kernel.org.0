Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE740CE02
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhIOUcp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 16:32:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:13811 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232016AbhIOUcf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 16:32:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286109370"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="286109370"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:15 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545092787"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:15 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     linux-sgx@vger.kernel.org, jarkko@kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] selftests/sgx: Provide per-op parameter structs for the test enclave
Date:   Wed, 15 Sep 2021 13:31:00 -0700
Message-Id: <02e538162cf60dddde52ffda2ec9c27bcef7f930.1631731214.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

To add more operations to the test enclave, the protocol needs to allow
to have operations with varying parameters. Create a separate parameter
struct for each existing operation, with the shared parameters in struct
encl_op_header.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
[reinette: rebased to apply on top of oversubscription test series]
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/defines.h   | 14 ++++-
 tools/testing/selftests/sgx/main.c      | 68 +++++++++++++------------
 tools/testing/selftests/sgx/test_encl.c | 33 +++++++-----
 3 files changed, 69 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index f88562afcaa0..6ff95a766287 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -21,11 +21,21 @@
 enum encl_op_type {
 	ENCL_OP_PUT,
 	ENCL_OP_GET,
+	ENCL_OP_MAX,
 };
 
-struct encl_op {
+struct encl_op_header {
 	uint64_t type;
-	uint64_t buffer;
+};
+
+struct encl_op_put {
+	struct encl_op_header header;
+	uint64_t value;
+};
+
+struct encl_op_get {
+	struct encl_op_header header;
+	uint64_t value;
 };
 
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 2e0a6523c60c..a107fc576094 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -220,27 +220,28 @@ FIXTURE_TEARDOWN(enclave)
 
 TEST_F(enclave, unclobbered_vdso)
 {
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	op.type = ENCL_OP_PUT;
-	op.buffer = MAGIC;
+	put_op.header.type = ENCL_OP_PUT;
+	put_op.value = MAGIC;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
 
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	op.type = ENCL_OP_GET;
-	op.buffer = 0;
+	get_op.header.type = ENCL_OP_GET;
+	get_op.value = 0;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
 
-	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
@@ -277,7 +278,8 @@ static bool sysfs_get_ulong(const char *path, unsigned long *value)
 TEST_F(enclave, unclobbered_vdso_oversubscribed)
 {
 	unsigned long total_mem;
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
 	ASSERT_TRUE(sysfs_get_ulong(SGX_TOTAL_MEM_PATH, &total_mem));
 	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
@@ -285,20 +287,20 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	op.type = ENCL_OP_PUT;
-	op.buffer = MAGIC;
+	put_op.header.type = ENCL_OP_PUT;
+	put_op.value = MAGIC;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
 
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	op.type = ENCL_OP_GET;
-	op.buffer = 0;
+	get_op.header.type = ENCL_OP_GET;
+	get_op.value = 0;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
 
-	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
@@ -306,27 +308,28 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 
 TEST_F(enclave, clobbered_vdso)
 {
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	op.type = ENCL_OP_PUT;
-	op.buffer = MAGIC;
+	put_op.header.type = ENCL_OP_PUT;
+	put_op.value = MAGIC;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, true), 0);
 
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	op.type = ENCL_OP_GET;
-	op.buffer = 0;
+	get_op.header.type = ENCL_OP_GET;
+	get_op.value = 0;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, true), 0);
 
-	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
@@ -341,7 +344,8 @@ static int test_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r
 
 TEST_F(enclave, clobbered_vdso_and_user_function)
 {
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
@@ -351,20 +355,20 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	self->run.user_handler = (__u64)test_handler;
 	self->run.user_data = 0xdeadbeef;
 
-	op.type = ENCL_OP_PUT;
-	op.buffer = MAGIC;
+	put_op.header.type = ENCL_OP_PUT;
+	put_op.value = MAGIC;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, true), 0);
 
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	op.type = ENCL_OP_GET;
-	op.buffer = 0;
+	get_op.header.type = ENCL_OP_GET;
+	get_op.value = 0;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, true), 0);
 
-	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 734ea52f9924..f11eb8315704 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -16,20 +16,29 @@ static void *memcpy(void *dest, const void *src, size_t n)
 	return dest;
 }
 
-void encl_body(void *rdi,  void *rsi)
+static void do_encl_op_put(void *op)
+{
+	struct encl_op_put *op2 = op;
+
+	memcpy(&encl_buffer[0], &op2->value, 8);
+}
+
+static void do_encl_op_get(void *op)
 {
-	struct encl_op *op = (struct encl_op *)rdi;
+	struct encl_op_get *op2 = op;
 
-	switch (op->type) {
-	case ENCL_OP_PUT:
-		memcpy(&encl_buffer[0], &op->buffer, 8);
-		break;
+	memcpy(&op2->value, &encl_buffer[0], 8);
+}
+
+void encl_body(void *rdi,  void *rsi)
+{
+	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
+		do_encl_op_put,
+		do_encl_op_get,
+	};
 
-	case ENCL_OP_GET:
-		memcpy(&op->buffer, &encl_buffer[0], 8);
-		break;
+	struct encl_op_header *op = (struct encl_op_header *)rdi;
 
-	default:
-		break;
-	}
+	if (op->type < ENCL_OP_MAX)
+		(*encl_op_array[op->type])(op);
 }
-- 
2.25.1

