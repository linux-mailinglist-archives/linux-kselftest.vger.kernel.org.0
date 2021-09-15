Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74A440CE05
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 22:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhIOUcr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 16:32:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:13814 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232182AbhIOUcn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 16:32:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286109378"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="286109378"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545092801"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:16 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     linux-sgx@vger.kernel.org, jarkko@kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] selftests/sgx: Add test for multiple TCS entry
Date:   Wed, 15 Sep 2021 13:31:04 -0700
Message-Id: <b908c7d2f210f11fc50abeb84a2dc22566941ffd.1631731214.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Each thread executing in an enclave is associated with a Thread Control
Structure (TCS). The SGX test enclave contains two hardcoded TCS, thus
supporting two threads in the enclave.

Add a test to ensure it is possible to enter enclave at both entrypoints.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
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
index 308cf09ab02a..0a2552ad9ec8 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -393,6 +393,38 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
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

