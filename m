Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9353EAD53
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Aug 2021 00:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhHLWrV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Aug 2021 18:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235927AbhHLWrU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Aug 2021 18:47:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 687516103E;
        Thu, 12 Aug 2021 22:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628808414;
        bh=SQhani1VVy1Ae63mZycxBPAbJS0W6NsmF0SGPT8IkvM=;
        h=From:To:Cc:Subject:Date:From;
        b=OdqMB1CzXWKvb31LtzrWnoXXbDTle8dWRtFu5Mb51m7+nRGNuSIbpZfbPFpWnoLmJ
         a9clM46kqlWMrrQfrmSjRpiYeDt4fDpQZBZ2Xu71FjXopcmm8pWuwKMc6Ec3lrSKMi
         5oOmLTTqN48s6tQnw2fXEFMJBx++N8St0sVS+m3YwN6wnkyqcaU4lxzaS3UAyBFYF7
         vAS9cnF128w3g8RRDC8zwutuK65gg3YDtSI82q4tP/rTJy/IM7Yfi9LZ23Nwxnw4On
         TyEoac27H5naK1p+z4Z6gjH0bkeaPbLo3k7pzQPVuSwwzARW8MbEzNbJDV4i9u3qHB
         Se1x3O//IZEAQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/sgx: Provide per-op parameter structs for the test enclave
Date:   Fri, 13 Aug 2021 01:46:45 +0300
Message-Id: <20210812224645.90280-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To add more operations to the test enclave, the protocol needs to allow
to have operations with varying parameters. Create a separate parameter
struct for each existing operation, with the shared parameters in struct
encl_op_header.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
* Declare do_encl_op_put() and do_encl_op_get() as static symbols.
* Use a jump table for ops.
---
 tools/testing/selftests/sgx/defines.h   | 14 ++++++-
 tools/testing/selftests/sgx/main.c      | 52 +++++++++++++------------
 tools/testing/selftests/sgx/test_encl.c | 33 ++++++++++------
 3 files changed, 61 insertions(+), 38 deletions(-)

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
index e252015e0c15..5c1625fa49de 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -215,46 +215,49 @@ FIXTURE_TEARDOWN(enclave)
 
 TEST_F(enclave, unclobbered_vdso)
 {
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
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
 
 TEST_F(enclave, clobbered_vdso)
 {
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
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
+
 }
 
 static int test_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r9,
@@ -267,25 +270,26 @@ static int test_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r
 
 TEST_F(enclave, clobbered_vdso_and_user_function)
 {
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
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
2.32.0

