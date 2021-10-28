Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C88D43E9B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 22:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhJ1UkI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 16:40:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:2686 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhJ1UkC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 16:40:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="217692552"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="217692552"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:31 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="498563001"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:30 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com
Cc:     seanjc@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/15] selftests/sgx: Provide per-op parameter structs for the test enclave
Date:   Thu, 28 Oct 2021 13:37:36 -0700
Message-Id: <3550814d68ce0601ef2cee04383fc70d44b3966c.1635447301.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635447301.git.reinette.chatre@intel.com>
References: <cover.1635447301.git.reinette.chatre@intel.com>
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
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
[reinette: rebased to apply on top of oversubscription test series]
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Add signature from Dave.

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
index 541862c15901..2ac5c3300df2 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -222,27 +222,28 @@ FIXTURE_TEARDOWN(enclave)
 
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
@@ -331,7 +332,8 @@ static unsigned long get_total_epc_mem(void)
 TEST_F(enclave, unclobbered_vdso_oversubscribed)
 {
 	unsigned long total_mem;
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
 	total_mem = get_total_epc_mem();
 	ASSERT_NE(total_mem, 0);
@@ -340,20 +342,20 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
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
 
@@ -361,27 +363,28 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 
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
@@ -396,7 +399,8 @@ static int test_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r
 
 TEST_F(enclave, clobbered_vdso_and_user_function)
 {
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
@@ -406,20 +410,20 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
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

