Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E182043E9B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 22:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhJ1UkI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 16:40:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:2684 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhJ1UkD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 16:40:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="217692554"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="217692554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:31 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="498563005"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:30 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com
Cc:     seanjc@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 15/15] selftests/sgx: Add test for multiple TCS entry
Date:   Thu, 28 Oct 2021 13:37:40 -0700
Message-Id: <d48a495488f8556dcea1255945a2eed2f09623da.1635447301.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635447301.git.reinette.chatre@intel.com>
References: <cover.1635447301.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Each thread executing in an enclave is associated with a Thread Control
Structure (TCS). The SGX test enclave contains two hardcoded TCS, thus
supporting two threads in the enclave.

Add a test to ensure it is possible to enter enclave at both entrypoints.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Add Jarkko and Dave's signatures.

 tools/testing/selftests/sgx/defines.h   |  1 +
 tools/testing/selftests/sgx/main.c      | 32 +++++++++++++++++++++++++
 tools/testing/selftests/sgx/test_encl.c |  6 +++++
 3 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index 0bbda6f0c7d3..02d775789ea7 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -23,6 +23,7 @@ enum encl_op_type {
 	ENCL_OP_GET_FROM_BUFFER,
 	ENCL_OP_PUT_TO_ADDRESS,
 	ENCL_OP_GET_FROM_ADDRESS,
+	ENCL_OP_NOP,
 	ENCL_OP_MAX,
 };
 
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 9efb619e0393..a86796d70a7b 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -448,6 +448,38 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
+/*
+ * Sanity check that it is possible to enter either of the two hardcoded TCS
+ */
+TEST_F(enclave, tcs_entry)
+{
+	struct encl_op_header op;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	op.type = ENCL_OP_NOP;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/* Move to the next TCS. */
+	self->run.tcs = self->encl.encl_base + PAGE_SIZE;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+}
+
 /*
  * Second page of .data segment is used to test changing PTE permissions.
  * This spans the local encl_buffer within the test enclave.
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 5d86e3e6456a..4fca01cfd898 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -49,6 +49,11 @@ static void do_encl_op_get_from_addr(void *_op)
 	memcpy(&op->value, (void *)op->addr, 8);
 }
 
+static void do_encl_op_nop(void *_op)
+{
+
+}
+
 void encl_body(void *rdi,  void *rsi)
 {
 	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
@@ -56,6 +61,7 @@ void encl_body(void *rdi,  void *rsi)
 		do_encl_op_get_from_buf,
 		do_encl_op_put_to_addr,
 		do_encl_op_get_from_addr,
+		do_encl_op_nop,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
-- 
2.25.1

