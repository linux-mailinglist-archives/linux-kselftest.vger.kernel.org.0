Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10153A270C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 10:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFJIch (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 04:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhFJIce (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 04:32:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FC3B610C7;
        Thu, 10 Jun 2021 08:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623313838;
        bh=0Yz8aoA/pKM0FyQzZ8BU6q+olMLL0VditF3T2f9a4/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=II8ydX7wxVkUCTC5mXFz7SC/W2C+fe0eDAPLpQwsVWta4PdGy0Fait99do7H7m6Hc
         iby0wY0+6AE5rOrTYeLBznYXcFBwl45/Sw/QoacNXHsY+tp2CWjg+G4TkOK4fongS7
         Ah9J0yixvv2vwvzrSvmP1R68XPgs88mT6/3WpLcucPq9O8u/q534jrZCHysSJYmHTD
         +KXmG3N2dnbx1DSEH2DAoUbg1CTM3nq1DuiINgfl2iOv19Bpy1g4TKMv/yyEUicL1V
         vYCYNyKDRF2ZcI7fEV2J5vtlqWrlUKlDn+a2CQAWkdM4MWVLojF5BlkXSkfeAQ3JtB
         q4ffZPBVQII2g==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/5] selftests/sgx: Refine the test enclave to have storage
Date:   Thu, 10 Jun 2021 11:30:21 +0300
Message-Id: <20210610083021.392269-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610083021.392269-1-jarkko@kernel.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend the enclave to have two operations: ENCL_OP_PUT and ENCL_OP_GET.
ENCL_OP_PUT stores value inside the enclave address space and
ENCL_OP_GET reads it. The internal buffer can be later extended to be
variable size, and allow reclaimer tests.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/defines.h     | 10 ++++
 tools/testing/selftests/sgx/main.c        | 57 ++++++++++++++++++-----
 tools/testing/selftests/sgx/test_encl.c   | 19 +++++++-
 tools/testing/selftests/sgx/test_encl.lds |  3 +-
 4 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index 0bd73428d2f3..f88562afcaa0 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -18,4 +18,14 @@
 #include "../../../../arch/x86/include/asm/enclu.h"
 #include "../../../../arch/x86/include/uapi/asm/sgx.h"
 
+enum encl_op_type {
+	ENCL_OP_PUT,
+	ENCL_OP_GET,
+};
+
+struct encl_op {
+	uint64_t type;
+	uint64_t buffer;
+};
+
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index bcd0257f48e0..e252015e0c15 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -193,14 +193,14 @@ FIXTURE_TEARDOWN(enclave)
 	encl_delete(&self->encl);
 }
 
-#define ENCL_CALL(in, out, run, clobbered) \
+#define ENCL_CALL(op, run, clobbered) \
 	({ \
 		int ret; \
 		if ((clobbered)) \
-			ret = vdso_sgx_enter_enclave((unsigned long)(in), (unsigned long)(out), 0, \
+			ret = vdso_sgx_enter_enclave((unsigned long)(op), 0, 0, \
 						     EENTER, 0, 0, (run)); \
 		else \
-			ret = sgx_enter_enclave((void *)(in), (void *)(out), 0, EENTER, NULL, NULL, \
+			ret = sgx_enter_enclave((void *)(op), NULL, 0, EENTER, NULL, NULL, \
 						(run)); \
 		ret; \
 	})
@@ -215,22 +215,44 @@ FIXTURE_TEARDOWN(enclave)
 
 TEST_F(enclave, unclobbered_vdso)
 {
-	uint64_t result = 0;
+	struct encl_op op;
 
-	EXPECT_EQ(ENCL_CALL(&MAGIC, &result, &self->run, false), 0);
+	op.type = ENCL_OP_PUT;
+	op.buffer = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
 
-	EXPECT_EQ(result, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	op.type = ENCL_OP_GET;
+	op.buffer = 0;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+
+	EXPECT_EQ(op.buffer, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
 TEST_F(enclave, clobbered_vdso)
 {
-	uint64_t result = 0;
+	struct encl_op op;
+
+	op.type = ENCL_OP_PUT;
+	op.buffer = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	op.type = ENCL_OP_GET;
+	op.buffer = 0;
 
-	EXPECT_EQ(ENCL_CALL(&MAGIC, &result, &self->run, true), 0);
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
 
-	EXPECT_EQ(result, MAGIC);
+	EXPECT_EQ(op.buffer, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
@@ -245,14 +267,25 @@ static int test_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r
 
 TEST_F(enclave, clobbered_vdso_and_user_function)
 {
-	uint64_t result = 0;
+	struct encl_op op;
 
 	self->run.user_handler = (__u64)test_handler;
 	self->run.user_data = 0xdeadbeef;
 
-	EXPECT_EQ(ENCL_CALL(&MAGIC, &result, &self->run, true), 0);
+	op.type = ENCL_OP_PUT;
+	op.buffer = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	op.type = ENCL_OP_GET;
+	op.buffer = 0;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
 
-	EXPECT_EQ(result, MAGIC);
+	EXPECT_EQ(op.buffer, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index cf25b5dc1e03..734ea52f9924 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -4,6 +4,8 @@
 #include <stddef.h>
 #include "defines.h"
 
+static uint8_t encl_buffer[8192] = { 1 };
+
 static void *memcpy(void *dest, const void *src, size_t n)
 {
 	size_t i;
@@ -14,7 +16,20 @@ static void *memcpy(void *dest, const void *src, size_t n)
 	return dest;
 }
 
-void encl_body(void *rdi, void *rsi)
+void encl_body(void *rdi,  void *rsi)
 {
-	memcpy(rsi, rdi, 8);
+	struct encl_op *op = (struct encl_op *)rdi;
+
+	switch (op->type) {
+	case ENCL_OP_PUT:
+		memcpy(&encl_buffer[0], &op->buffer, 8);
+		break;
+
+	case ENCL_OP_GET:
+		memcpy(&op->buffer, &encl_buffer[0], 8);
+		break;
+
+	default:
+		break;
+	}
 }
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index 0fbbda7e665e..a1ec64f7d91f 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -18,9 +18,10 @@ SECTIONS
 	.text : {
 		*(.text*)
 		*(.rodata*)
+		FILL(0xDEADBEEF);
+		. = ALIGN(4096);
 	} : text
 
-	. = ALIGN(4096);
 	.data : {
 		*(.data*)
 	} : data
-- 
2.31.1

