Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7553343E9B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 22:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhJ1UkI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 16:40:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:2692 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231341AbhJ1UkD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 16:40:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="217692553"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="217692553"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:31 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="498563003"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:30 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com
Cc:     seanjc@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 13/15] selftests/sgx: Add page permission and exception test
Date:   Thu, 28 Oct 2021 13:37:38 -0700
Message-Id: <85dd8852e85cd1fcdf70f5b6be9389b6df096b0d.1635447301.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635447301.git.reinette.chatre@intel.com>
References: <cover.1635447301.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Enclave Page Cache Map (EPCM) is a secure structure used by the
processor to track the contents of the enclave page cache. The EPCM
contains permissions with which enclave pages can be accessed. SGX
support allows EPCM and PTE page permissions to differ - as long as
the PTE permissions do not exceed the EPCM permissions.

Add a test that:
(1) Creates an SGX enclave page with writable EPCM permission.
(2) Changes the PTE permission on the page to read-only. This should
    be permitted because the permission does not exceed the EPCM
    permission.
(3) Attempts a write to the page. This should generate a page fault
    (#PF) because of the read-only PTE even though the EPCM
    permissions allow the page to be written to.

This introduces the first test of SGX exception handling. In this test
the issue that caused the exception (PTE page permissions) can be fixed
from outside the enclave and after doing so it is possible to re-enter
enclave at original entrypoint with ERESUME.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Make changelog more readable (Dave).
- Add signature from Dave.
- Improve loop locating data segment (Jarkko).

 tools/testing/selftests/sgx/defines.h   |  14 +++
 tools/testing/selftests/sgx/main.c      | 134 ++++++++++++++++++++++++
 tools/testing/selftests/sgx/test_encl.c |  21 ++++
 3 files changed, 169 insertions(+)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index 9ea0c7882dfb..0bbda6f0c7d3 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -21,6 +21,8 @@
 enum encl_op_type {
 	ENCL_OP_PUT_TO_BUFFER,
 	ENCL_OP_GET_FROM_BUFFER,
+	ENCL_OP_PUT_TO_ADDRESS,
+	ENCL_OP_GET_FROM_ADDRESS,
 	ENCL_OP_MAX,
 };
 
@@ -38,4 +40,16 @@ struct encl_op_get_from_buf {
 	uint64_t value;
 };
 
+struct encl_op_put_to_addr {
+	struct encl_op_header header;
+	uint64_t value;
+	uint64_t addr;
+};
+
+struct encl_op_get_from_addr {
+	struct encl_op_header header;
+	uint64_t value;
+	uint64_t addr;
+};
+
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index f1802faed78e..9efb619e0393 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -23,6 +23,7 @@
 #include "main.h"
 
 static const uint64_t MAGIC = 0x1122334455667788ULL;
+static const uint64_t MAGIC2 = 0x8877665544332211ULL;
 vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
 
 struct vdso_symtab {
@@ -109,6 +110,25 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
 	return NULL;
 }
 
+/*
+ * Return the offset in the enclave where the data segment can be found.
+ * The first RW segment loaded is the TCS, skip that to get info on the
+ * data segment.
+ */
+static off_t encl_get_data_offset(struct encl *encl)
+{
+	int i;
+
+	for (i = 1; i < encl->nr_segments; i++) {
+		struct encl_segment *seg = &encl->segment_tbl[i];
+
+		if (seg->prot == (PROT_READ | PROT_WRITE))
+			return seg->offset;
+	}
+
+	return -1;
+}
+
 FIXTURE(enclave) {
 	struct encl encl;
 	struct sgx_enclave_run run;
@@ -428,4 +448,118 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
+/*
+ * Second page of .data segment is used to test changing PTE permissions.
+ * This spans the local encl_buffer within the test enclave.
+ *
+ * 1) Start with a sanity check: a value is written to the target page within
+ *    the enclave and read back to ensure target page can be written to.
+ * 2) Change PTE permissions (RW -> RO) of target page within enclave.
+ * 3) Repeat (1) - this time expecting a regular #PF communicated via the
+ *    vDSO.
+ * 4) Change PTE permissions of target page within enclave back to be RW.
+ * 5) Repeat (1) by resuming enclave, now expected to be possible to write to
+ *    and read from target page within enclave.
+ */
+TEST_F(enclave, pte_permissions)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	unsigned long data_start;
+	int ret;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	data_start = self->encl.encl_base +
+		     encl_get_data_offset(&self->encl) +
+		     PAGE_SIZE;
+
+	/*
+	 * Sanity check to ensure it is possible to write to page that will
+	 * have its permissions manipulated.
+	 */
+
+	/* Write MAGIC to page */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = data_start;
+	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/*
+	 * Read memory that was just written to, confirming that it is the
+	 * value previously written (MAGIC).
+	 */
+	get_addr_op.value = 0;
+	get_addr_op.addr = data_start;
+	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(get_addr_op.value, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/* Change PTE permissions of target page within the enclave */
+	ret = mprotect((void *)data_start, PAGE_SIZE, PROT_READ);
+	if (ret)
+		perror("mprotect");
+
+	/*
+	 * PTE permissions of target page changed to read-only, EPCM
+	 * permissions unchanged (EPCM permissions are RW), attempt to
+	 * write to the page, expecting a regular #PF.
+	 */
+
+	put_addr_op.value = MAGIC2;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_error_code, 0x7);
+	EXPECT_EQ(self->run.exception_addr, data_start);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/*
+	 * Change PTE permissions back to enable enclave to write to the
+	 * target page and resume enclave - do not expect any exceptions this
+	 * time.
+	 */
+	ret = mprotect((void *)data_start, PAGE_SIZE, PROT_READ | PROT_WRITE);
+	if (ret)
+		perror("mprotect");
+
+	EXPECT_EQ(vdso_sgx_enter_enclave((unsigned long)&put_addr_op, 0,
+					 0, ERESUME, 0, 0, &self->run),
+		 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	get_addr_op.value = 0;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(get_addr_op.value, MAGIC2);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 4e8da738173f..5d86e3e6456a 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -4,6 +4,11 @@
 #include <stddef.h>
 #include "defines.h"
 
+/*
+ * Data buffer spanning two pages that will be placed first in .data
+ * segment. Even if not used internally the second page is needed by
+ * external test manipulating page permissions.
+ */
 static uint8_t encl_buffer[8192] = { 1 };
 
 static void *memcpy(void *dest, const void *src, size_t n)
@@ -30,11 +35,27 @@ static void do_encl_op_get_from_buf(void *op)
 	memcpy(&op2->value, &encl_buffer[0], 8);
 }
 
+static void do_encl_op_put_to_addr(void *_op)
+{
+	struct encl_op_put_to_addr *op = _op;
+
+	memcpy((void *)op->addr, &op->value, 8);
+}
+
+static void do_encl_op_get_from_addr(void *_op)
+{
+	struct encl_op_get_from_addr *op = _op;
+
+	memcpy(&op->value, (void *)op->addr, 8);
+}
+
 void encl_body(void *rdi,  void *rsi)
 {
 	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
 		do_encl_op_put_to_buf,
 		do_encl_op_get_from_buf,
+		do_encl_op_put_to_addr,
+		do_encl_op_get_from_addr,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
-- 
2.25.1

