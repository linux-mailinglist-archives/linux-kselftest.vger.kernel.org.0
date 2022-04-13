Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B9F5000DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiDMVNg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbiDMVNM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2844D4757B;
        Wed, 13 Apr 2022 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884250; x=1681420250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X9uIYJfbQsSkIE7LUGHv8YHCdP2Irp3KtR7vZwz4Y78=;
  b=iWgcOjusLf5k3xd1Hbxdw/7RimQmKQIeO7BpU1EYVVmnoWNIZCMICRj6
   CZDlZb1jSSxT3yV0o10JyJ3HruUKLuvM/7cx9xWQ4KJKZFL3Zbg4hHsvx
   Li6wwSkhCHcvj9PBTdQlaoGiQN6UXFTkmSalmZEq+Rh45rqpOm/GEcPjg
   59eUrUobPDXnd5879zqpmNV7R8y1vMx794MimrJRDd97PFpim/iZwPpR9
   1rsRxYAFKIbv3MifI+29Z0QGe0LVtaBAoWNIclb2qAOCuLpvFegC5Ppfr
   PvfGlTnnktHUO3pjpiJgtoUv2DbRcOS+Bg7/pL7ZfSKjoTw//IuXIAKOZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219053"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219053"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054307"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:45 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 22/31] selftests/sgx: Add test for EPCM permission changes
Date:   Wed, 13 Apr 2022 14:10:22 -0700
Message-Id: <64e8cf67aa564b317f4028aee9b3e77f3c1ce326.1649878359.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

EPCM permission changes could be made from within (to relax
permissions) or out (to restrict permissions) the enclave. Kernel
support is needed when permissions are restricted to be able to
call the privileged ENCLS[EMODPR] instruction. EPCM permissions
can be relaxed via ENCLU[EMODPE] from within the enclave but the
enclave still depends on the kernel to install PTEs with the needed
permissions.

Add a test that exercises a few of the enclave page permission flows:
1) Test starts with a RW (from enclave and kernel perspective)
   enclave page that is mapped via a RW VMA.
2) Use the SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl() to restrict
   the enclave (EPCM) page permissions to read-only.
3) Run ENCLU[EACCEPT] from within the enclave to accept the new page
   permissions.
4) Attempt to write to the enclave page from within the enclave - this
   should fail with a page fault on the EPCM permissions since the page
   table entry continues to allow RW access.
5) Restore EPCM permissions to RW by running ENCLU[EMODPE] from within
   the enclave.
6) Attempt to write to the enclave page from within the enclave - this
   should succeed since both EPCM and PTE permissions allow this access.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Add Jarkko's Acked-by tag.
- User provides only new permissions in
  SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl(), replacing secinfo. (Jarkko)
- Use SGX page permission bits instead of VMA protection bits.

Changes since V2:
- Modify test to support separation between EPCM and PTE/VMA permissions
  - Fix changelog and comments to reflect new relationship between
    EPCM and PTE/VMA permissions.
  - With EPCM permissions controlling access instead of PTE permissions,
    check for SGX error code now encountered in page fault.
  - Stop calling SGX_IOC_ENCLAVE_RELAX_PERMISSIONS and ensure that
    only calling ENCLU[EMODPE] from within enclave is necessary to restore
    access to the enclave page.
- Update to use new struct name struct sgx_enclave_restrict_perm -> struct
  sgx_enclave_restrict_permissions. (Jarkko)

Changes since V1:
- Adapt test to the kernel interface changes: the ioctl() name change
  and providing entire secinfo as parameter.
- Remove the ENCLU[EACCEPT] call after permissions are relaxed since
  the new flow no longer results in the EPCM PR bit being set.
- Rewrite error path to reduce line lengths.

 tools/testing/selftests/sgx/defines.h   |  15 ++
 tools/testing/selftests/sgx/main.c      | 214 ++++++++++++++++++++++++
 tools/testing/selftests/sgx/test_encl.c |  38 +++++
 3 files changed, 267 insertions(+)

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
index dd74fa42302e..46eac09cd955 100644
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
@@ -555,4 +567,206 @@ TEST_F(enclave, pte_permissions)
 	EXPECT_EQ(self->run.exception_addr, 0);
 }
 
+/*
+ * Enclave page permission test.
+ *
+ * Modify and restore enclave page's EPCM (enclave) permissions from
+ * outside enclave (ENCLS[EMODPR] via kernel) as well as from within
+ * enclave (via ENCLU[EMODPE]). Check for page fault if
+ * VMA allows access but EPCM permissions do not.
+ */
+TEST_F(enclave, epcm_permissions)
+{
+	struct sgx_enclave_restrict_permissions restrict_ioc;
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_eaccept eaccept_op;
+	struct encl_op_emodpe emodpe_op;
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
+	 * At start of test @data_start should have EPCM as well as PTE and
+	 * VMA permissions of RW.
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
+	 * Change EPCM permissions to read-only. Kernel still considers
+	 * the page writable.
+	 */
+	memset(&restrict_ioc, 0, sizeof(restrict_ioc));
+
+	restrict_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	restrict_ioc.length = PAGE_SIZE;
+	restrict_ioc.permissions = SGX_SECINFO_R;
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
+	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_REG | SGX_SECINFO_PR;
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
+	 * on EPCM when attempting to write to page from within enclave.
+	 */
+	put_addr_op.value = MAGIC2;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(self->run.function, ERESUME);
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_error_code, 0x8007);
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
+	emodpe_op.flags = SGX_SECINFO_R | SGX_SECINFO_W;
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
+	 * instruction, PTE should continue to allow writing to the page.
+	 */
+	self->run.tcs = self->encl.encl_base;
+
+	/*
+	 * Wrong page permissions that caused original fault has
+	 * now been fixed via EPCM permissions.
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
2.25.1

