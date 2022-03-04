Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427C94CD146
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 10:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiCDJif (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 04:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbiCDJiJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E941ACA08;
        Fri,  4 Mar 2022 01:36:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 239C46191C;
        Fri,  4 Mar 2022 09:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B31C340E9;
        Fri,  4 Mar 2022 09:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386615;
        bh=HMrIADXooJjGZ7EpMmlwH2a1jVV7YZRmMZqgEe0cQAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrrAjOuxd9UJc6iobOWb88NxBa/F1EG/5mFXc6RdH5cfPMWbZ5R8q38y5Q4EbuYbe
         ae5l0RSziD9WdZDlSo8fELlOxrWetAvibaF1/6WnZv/sWirxB4ZMQS4GyAKRN6qCJ6
         Ea5kAR/Yv67kB1sT7Iq8fniyBx/lDKsfJ6gj8mZmOYQ2mrCVFd5xTn0ZWoWSM/sBGC
         o01Ych7+voxjQewvXX3Dy8fpuoBlToUc5o8bBixUtWcTaZcGj6tv09UfTYKIeeaBLT
         bRavAGIFt65mz0bxEWKhrxrL7fpoEAw1U7UIClC4hTK6fy1aZ8TdhTt5YCge0+F5Z3
         +GZexBhrRmmNA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2.1 15/30] selftests/sgx: Add test for EPCM permission changes
Date:   Fri,  4 Mar 2022 11:35:09 +0200
Message-Id: <20220304093524.397485-15-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

EPCM permission changes could be made from within (to relax
permissions) or out (to restrict permissions) the enclave. Kernel
support is needed when permissions are restricted to be able to
call the privileged ENCLS[EMODPR] instruction and ensure PTEs
allowing the restricted permissions are flushed. EPCM permissions
can be relaxed via ENCLU[EMODPE] from within the enclave but the
enclave still depends on the kernel to install PTEs with the new
permissions.

Add a test that exercises a few of the enclave page permission flows:
1) Test starts with a RW (from enclave and kernel perspective)
   enclave page that is mapped via a RW VMA.
2) Use the SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl() to restrict
   the enclave (EPCM) page permissions to read-only (kernel removes
   PTE in the process).
3) Run ENCLU[EACCEPT] from within the enclave to accept the new page
   permissions.
4) Attempt to write to the enclave page from within the enclave - this
   should fail with a page fault on the PTE since the page
   table entry accurately reflects the (read-only) EPCM permissions.
5) Restore EPCM permissions to RW by running ENCLU[EMODPE] from within
   the enclave.
6) Attempt to write to the enclave page from within the enclave - this
   should fail again with a page fault because even though the EPCM
   permissions are RW the PTE does not yet reflect that.
7) Use the SGX_IOC_ENCLAVE_RELAX_PERMISSIONS ioctl() to inform the
   kernel of new page permissions and PTEs will accurately reflect
   RW EPCM permissions.
8) Writing to enclave page from within enclave succeeds.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/defines.h   |  15 ++
 tools/testing/selftests/sgx/main.c      | 234 ++++++++++++++++++++++++
 tools/testing/selftests/sgx/test_encl.c |  38 ++++
 3 files changed, 287 insertions(+)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index 02d775789ea7..b638eb98c80c 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -24,6 +24,8 @@ enum encl_op_type {
 	ENCL_OP_PUT_TO_ADDRESS,
 	ENCL_OP_GET_FROM_ADDRESS,
 	ENCL_OP_NOP,
+	ENCL_OP_EACCEPT,
+	ENCL_OP_EMODPE,
 	ENCL_OP_MAX,
 };
 
@@ -53,4 +55,17 @@ struct encl_op_get_from_addr {
 	uint64_t addr;
 };
 
+struct encl_op_eaccept {
+	struct encl_op_header header;
+	uint64_t epc_addr;
+	uint64_t flags;
+	uint64_t ret;
+};
+
+struct encl_op_emodpe {
+	struct encl_op_header header;
+	uint64_t epc_addr;
+	uint64_t flags;
+};
+
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index dd74fa42302e..aec3355d2ace 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -25,6 +25,18 @@ static const uint64_t MAGIC = 0x1122334455667788ULL;
 static const uint64_t MAGIC2 = 0x8877665544332211ULL;
 vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
 
+/*
+ * Security Information (SECINFO) data structure needed by a few SGX
+ * instructions (eg. ENCLU[EACCEPT] and ENCLU[EMODPE]) holds meta-data
+ * about an enclave page. &enum sgx_secinfo_page_state specifies the
+ * secinfo flags used for page state.
+ */
+enum sgx_secinfo_page_state {
+	SGX_SECINFO_PENDING = (1 << 3),
+	SGX_SECINFO_MODIFIED = (1 << 4),
+	SGX_SECINFO_PR = (1 << 5),
+};
+
 struct vdso_symtab {
 	Elf64_Sym *elf_symtab;
 	const char *elf_symstrtab;
@@ -555,4 +567,226 @@ TEST_F(enclave, pte_permissions)
 	EXPECT_EQ(self->run.exception_addr, 0);
 }
 
+/*
+ * Enclave page permission test.
+ *
+ * Modify and restore enclave page's EPCM (enclave) permissions from
+ * outside enclave (ENCLS[EMODPR] via kernel) as well as from within
+ * enclave (via ENCLU[EMODPE]). Kernel should ensure PTE permissions
+ * are the same as the EPCM permissions so check for page fault if
+ * VMA allows access but EPCM and PTE does not.
+ */
+TEST_F(enclave, epcm_permissions)
+{
+	struct sgx_enclave_restrict_perm restrict_ioc;
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_eaccept eaccept_op;
+	struct encl_op_emodpe emodpe_op;
+	struct sgx_secinfo secinfo;
+	unsigned long data_start;
+	int ret, errno_save;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	/*
+	 * Ensure kernel supports needed ioctl() and system supports needed
+	 * commands.
+	 */
+	memset(&restrict_ioc, 0, sizeof(restrict_ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS,
+		    &restrict_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	/*
+	 * Invalid parameters were provided during sanity check,
+	 * expect command to fail.
+	 */
+	ASSERT_EQ(ret, -1);
+
+	/* ret == -1 */
+	if (errno_save == ENOTTY)
+		SKIP(return,
+		     "Kernel does not support SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl()");
+	else if (errno_save == ENODEV)
+		SKIP(return, "System does not support SGX2");
+
+	/*
+	 * Page that will have its permissions changed is the second data
+	 * page in the .data segment. This forms part of the local encl_buffer
+	 * within the enclave.
+	 *
+	 * At start of test @data_start should have EPCM as well as PTE
+	 * permissions of RW.
+	 */
+
+	data_start = self->encl.encl_base +
+		     encl_get_data_offset(&self->encl) + PAGE_SIZE;
+
+	/*
+	 * Sanity check that page at @data_start is writable before making
+	 * any changes to page permissions.
+	 *
+	 * Start by writing MAGIC to test page.
+	 */
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
+	 * Read memory that was just written to, confirming that
+	 * page is writable.
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
+	/*
+	 * Change EPCM permissions to read-only, PTE entry flushed by
+	 * kernel in the process.
+	 */
+	memset(&restrict_ioc, 0, sizeof(restrict_ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = PROT_READ;
+	restrict_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	restrict_ioc.length = PAGE_SIZE;
+	restrict_ioc.secinfo = (unsigned long)&secinfo;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS,
+		    &restrict_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(restrict_ioc.result, 0);
+	EXPECT_EQ(restrict_ioc.count, 4096);
+
+	/*
+	 * EPCM permissions changed from kernel, need to EACCEPT from enclave.
+	 */
+	eaccept_op.epc_addr = data_start;
+	eaccept_op.flags = PROT_READ | SGX_SECINFO_REG | SGX_SECINFO_PR;
+	eaccept_op.ret = 0;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	/*
+	 * EPCM permissions of page is now read-only, expect #PF
+	 * on PTE (not EPCM) when attempting to write to page from
+	 * within enclave.
+	 */
+	put_addr_op.value = MAGIC2;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(self->run.function, ERESUME);
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_error_code, 0x7);
+	EXPECT_EQ(self->run.exception_addr, data_start);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/*
+	 * Received AEX but cannot return to enclave at same entrypoint,
+	 * need different TCS from where EPCM permission can be made writable
+	 * again.
+	 */
+	self->run.tcs = self->encl.encl_base + PAGE_SIZE;
+
+	/*
+	 * Enter enclave at new TCS to change EPCM permissions to be
+	 * writable again and thus fix the page fault that triggered the
+	 * AEX.
+	 */
+
+	emodpe_op.epc_addr = data_start;
+	emodpe_op.flags = PROT_READ | PROT_WRITE;
+	emodpe_op.header.type = ENCL_OP_EMODPE;
+
+	EXPECT_EQ(ENCL_CALL(&emodpe_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/*
+	 * Attempt to return to main TCS to resume execution at faulting
+	 * instruction, but PTE should still prevent writing to the page.
+	 */
+	self->run.tcs = self->encl.encl_base;
+
+	EXPECT_EQ(vdso_sgx_enter_enclave((unsigned long)&put_addr_op, 0, 0,
+					 ERESUME, 0, 0,
+					 &self->run),
+		  0);
+
+	EXPECT_EQ(self->run.function, ERESUME);
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_error_code, 0x7);
+	EXPECT_EQ(self->run.exception_addr, data_start);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/*
+	 * Wrong page permissions that caused original fault has
+	 * now been fixed via EPCM permissions as well as PTE.
+	 * Resume execution in main TCS to re-attempt the memory access.
+	 */
+	self->run.tcs = self->encl.encl_base;
+
+	EXPECT_EQ(vdso_sgx_enter_enclave((unsigned long)&put_addr_op, 0, 0,
+					 ERESUME, 0, 0,
+					 &self->run),
+		  0);
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
+	EXPECT_EQ(self->run.user_data, 0);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 4fca01cfd898..5b6c65331527 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -11,6 +11,42 @@
  */
 static uint8_t encl_buffer[8192] = { 1 };
 
+enum sgx_enclu_function {
+	EACCEPT = 0x5,
+	EMODPE = 0x6,
+};
+
+static void do_encl_emodpe(void *_op)
+{
+	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
+	struct encl_op_emodpe *op = _op;
+
+	secinfo.flags = op->flags;
+
+	asm volatile(".byte 0x0f, 0x01, 0xd7"
+				:
+				: "a" (EMODPE),
+				  "b" (&secinfo),
+				  "c" (op->epc_addr));
+}
+
+static void do_encl_eaccept(void *_op)
+{
+	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
+	struct encl_op_eaccept *op = _op;
+	int rax;
+
+	secinfo.flags = op->flags;
+
+	asm volatile(".byte 0x0f, 0x01, 0xd7"
+				: "=a" (rax)
+				: "a" (EACCEPT),
+				  "b" (&secinfo),
+				  "c" (op->epc_addr));
+
+	op->ret = rax;
+}
+
 static void *memcpy(void *dest, const void *src, size_t n)
 {
 	size_t i;
@@ -62,6 +98,8 @@ void encl_body(void *rdi,  void *rsi)
 		do_encl_op_put_to_addr,
 		do_encl_op_get_from_addr,
 		do_encl_op_nop,
+		do_encl_eaccept,
+		do_encl_emodpe,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
-- 
2.35.1

