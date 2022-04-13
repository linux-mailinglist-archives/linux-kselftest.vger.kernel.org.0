Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C725000CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbiDMVNq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbiDMVNP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B865403DD;
        Wed, 13 Apr 2022 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884252; x=1681420252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J9ONP2AU20g+TWB2bu+Uixk+63/TlKNYnMCGuVPlhBE=;
  b=LrCBBAQbdiIeb1loHHFSfn16GDy3ut4c+IDNn+QFZRrzG8cgcJ+EXICT
   LjIV3WEk9gXVw5qCVc0husP3YE0ya7dJj2lDhfZkB3RkM1vNNAQG/PDYP
   mVh6+mIBe2jTc32aJADB8UeUT9cDKfBxUfJZmu4O71QkUG6c8s6a+8My4
   u1A2k3iwNSmDM7ORLt3bF7rFQY4eV2bB6aHQj10IJYDm22k0E66scf/uZ
   +iaxB24xarWzrzL4nptWEtq3LyGAdC9nQDBbIaOv6YWOG+W5iPtCdJD2K
   erHALSHQxSyyRuxA+wC7g+cKyt25BjNsTb1ol0KAyFxI0s0CylcUCdMMH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219070"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219070"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054325"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:46 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 27/31] selftests/sgx: Test complete changing of page type flow
Date:   Wed, 13 Apr 2022 14:10:27 -0700
Message-Id: <67cb2605f016157219f35c9ff0be7bac0064ba6c.1649878359.git.reinette.chatre@intel.com>
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

Support for changing an enclave page's type enables an initialized
enclave to be expanded with support for more threads by changing the
type of a regular enclave page to that of a Thread Control Structure
(TCS).  Additionally, being able to change a TCS or regular enclave
page's type to be trimmed (SGX_PAGE_TYPE_TRIM) initiates the removal
of the page from the enclave.

Test changing page type to TCS as well as page removal flows
in two phases: In the first phase support for a new thread is
dynamically added to an initialized enclave and in the second phase
the pages associated with the new thread are removed from the enclave.
As an additional sanity check after the second phase the page used as
a TCS page during the first phase is added back as a regular page and
ensured that it can be written to (which is not possible if it was a
TCS page).

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Add Jarkko's Acked-by tag.
- Rename SGX_IOC_ENCLAVE_MODIFY_TYPE to
  SGX_IOC_ENCLAVE_MODIFY_TYPES. (Jarkko)
- User provides just page type to SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl(),
  replacing secinfo. (Jarkko)
- Let the SKIP() call involving SGX_IOC_ENCLAVE_MODIFY_TYPES span
  two lines to address checkpatch.pl warning triggered by new longer
  name.

Changes since V2:
- Rename struct sgx_enclave_modt -> struct sgx_enclave_modify_type

Changes since V1:
- Update to support ioctl() name change (SGX_IOC_PAGE_MODT ->
  SGX_IOC_ENCLAVE_MODIFY_TYPE) and provide secinfo as parameter instead
  of just page type (Jarkko).
- Update test to reflect page removal ioctl() and struct name change:
  SGX_IOC_PAGE_REMOVE->SGX_IOC_ENCLAVE_REMOVE_PAGES,
  struct sgx_page_remove -> struct sgx_enclave_remove_pages (Jarkko).
- Use ioctl() instead of ioctl (Dave).

 tools/testing/selftests/sgx/load.c |  41 ++++
 tools/testing/selftests/sgx/main.c | 343 +++++++++++++++++++++++++++++
 tools/testing/selftests/sgx/main.h |   1 +
 3 files changed, 385 insertions(+)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 006b464c8fc9..94bdeac1cf04 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -130,6 +130,47 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
 	return true;
 }
 
+/*
+ * Parse the enclave code's symbol table to locate and return address of
+ * the provided symbol
+ */
+uint64_t encl_get_entry(struct encl *encl, const char *symbol)
+{
+	Elf64_Shdr *sections;
+	Elf64_Sym *symtab;
+	Elf64_Ehdr *ehdr;
+	char *sym_names;
+	int num_sym;
+	int i;
+
+	ehdr = encl->bin;
+	sections = encl->bin + ehdr->e_shoff;
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (sections[i].sh_type == SHT_SYMTAB) {
+			symtab = (Elf64_Sym *)((char *)encl->bin + sections[i].sh_offset);
+			num_sym = sections[i].sh_size / sections[i].sh_entsize;
+			break;
+		}
+	}
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (sections[i].sh_type == SHT_STRTAB) {
+			sym_names = (char *)encl->bin + sections[i].sh_offset;
+			break;
+		}
+	}
+
+	for (i = 0; i < num_sym; i++) {
+		Elf64_Sym *sym = &symtab[i];
+
+		if (!strcmp(symbol, sym_names + sym->st_name))
+			return (uint64_t)sym->st_value;
+	}
+
+	return 0;
+}
+
 bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
 {
 	const char device_path[] = "/dev/sgx_enclave";
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 79c08e347112..a3f22b15a4f8 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1090,4 +1090,347 @@ TEST_F(enclave, augment_via_eaccept)
 	munmap(addr, PAGE_SIZE);
 }
 
+/*
+ * SGX2 page type modification test in two phases:
+ * Phase 1:
+ * Create a new TCS, consisting out of three new pages (stack page with regular
+ * page type, SSA page with regular page type, and TCS page with TCS page
+ * type) in an initialized enclave and run a simple workload within it.
+ * Phase 2:
+ * Remove the three pages added in phase 1, add a new regular page at the
+ * same address that previously hosted the TCS page and verify that it can
+ * be modified.
+ */
+TEST_F(enclave, tcs_create)
+{
+	struct encl_op_init_tcs_page init_tcs_page_op;
+	struct sgx_enclave_remove_pages remove_ioc;
+	struct encl_op_get_from_addr get_addr_op;
+	struct sgx_enclave_modify_type modt_ioc;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_get_from_buf get_buf_op;
+	struct encl_op_put_to_buf put_buf_op;
+	void *addr, *tcs, *stack_end, *ssa;
+	struct encl_op_eaccept eaccept_op;
+	size_t total_size = 0;
+	uint64_t val_64;
+	int errno_save;
+	int ret, i;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl,
+				    _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	/*
+	 * Hardware (SGX2) and kernel support is needed for this test. Start
+	 * with check that test has a chance of succeeding.
+	 */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
+
+	if (ret == -1) {
+		if (errno == ENOTTY)
+			SKIP(return,
+			     "Kernel does not support SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl()");
+		else if (errno == ENODEV)
+			SKIP(return, "System does not support SGX2");
+	}
+
+	/*
+	 * Invalid parameters were provided during sanity check,
+	 * expect command to fail.
+	 */
+	EXPECT_EQ(ret, -1);
+
+	/*
+	 * Add three regular pages via EAUG: one will be the TCS stack, one
+	 * will be the TCS SSA, and one will be the new TCS. The stack and
+	 * SSA will remain as regular pages, the TCS page will need its
+	 * type changed after populated with needed data.
+	 */
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		struct encl_segment *seg = &self->encl.segment_tbl[i];
+
+		total_size += seg->size;
+	}
+
+	/*
+	 * Actual enclave size is expected to be larger than the loaded
+	 * test enclave since enclave size must be a power of 2 in bytes while
+	 * test_encl does not consume it all.
+	 */
+	EXPECT_LT(total_size + 3 * PAGE_SIZE, self->encl.encl_size);
+
+	/*
+	 * mmap() three pages at end of existing enclave to be used for the
+	 * three new pages.
+	 */
+	addr = mmap((void *)self->encl.encl_base + total_size, 3 * PAGE_SIZE,
+		    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED,
+		    self->encl.fd, 0);
+	EXPECT_NE(addr, MAP_FAILED);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	stack_end = (void *)self->encl.encl_base + total_size;
+	tcs = (void *)self->encl.encl_base + total_size + PAGE_SIZE;
+	ssa = (void *)self->encl.encl_base + total_size + 2 * PAGE_SIZE;
+
+	/*
+	 * Run EACCEPT on each new page to trigger the
+	 * EACCEPT->(#PF)->EAUG->EACCEPT(again without a #PF) flow.
+	 */
+
+	eaccept_op.epc_addr = (unsigned long)stack_end;
+	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
+	eaccept_op.ret = 0;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	if (self->run.exception_vector == 14 &&
+	    self->run.exception_error_code == 4 &&
+	    self->run.exception_addr == (unsigned long)stack_end) {
+		munmap(addr, 3 * PAGE_SIZE);
+		SKIP(return, "Kernel does not support adding pages to initialized enclave");
+	}
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	eaccept_op.epc_addr = (unsigned long)ssa;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	eaccept_op.epc_addr = (unsigned long)tcs;
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
+	 * Three new pages added to enclave. Now populate the TCS page with
+	 * needed data. This should be done from within enclave. Provide
+	 * the function that will do the actual data population with needed
+	 * data.
+	 */
+
+	/*
+	 * New TCS will use the "encl_dyn_entry" entrypoint that expects
+	 * stack to begin in page before TCS page.
+	 */
+	val_64 = encl_get_entry(&self->encl, "encl_dyn_entry");
+	EXPECT_NE(val_64, 0);
+
+	init_tcs_page_op.tcs_page = (unsigned long)tcs;
+	init_tcs_page_op.ssa = (unsigned long)total_size + 2 * PAGE_SIZE;
+	init_tcs_page_op.entry = val_64;
+	init_tcs_page_op.header.type = ENCL_OP_INIT_TCS_PAGE;
+
+	EXPECT_EQ(ENCL_CALL(&init_tcs_page_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/* Change TCS page type to TCS. */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+
+	modt_ioc.offset = total_size + PAGE_SIZE;
+	modt_ioc.length = PAGE_SIZE;
+	modt_ioc.page_type = SGX_PAGE_TYPE_TCS;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(modt_ioc.result, 0);
+	EXPECT_EQ(modt_ioc.count, 4096);
+
+	/* EACCEPT new TCS page from enclave. */
+	eaccept_op.epc_addr = (unsigned long)tcs;
+	eaccept_op.flags = SGX_SECINFO_TCS | SGX_SECINFO_MODIFIED;
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
+	/* Run workload from new TCS. */
+	self->run.tcs = (unsigned long)tcs;
+
+	/*
+	 * Simple workload to write to data buffer and read value back.
+	 */
+	put_buf_op.header.type = ENCL_OP_PUT_TO_BUFFER;
+	put_buf_op.value = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&put_buf_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	get_buf_op.header.type = ENCL_OP_GET_FROM_BUFFER;
+	get_buf_op.value = 0;
+
+	EXPECT_EQ(ENCL_CALL(&get_buf_op, &self->run, true), 0);
+
+	EXPECT_EQ(get_buf_op.value, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/*
+	 * Phase 2 of test:
+	 * Remove pages associated with new TCS, create a regular page
+	 * where TCS page used to be and verify it can be used as a regular
+	 * page.
+	 */
+
+	/* Start page removal by requesting change of page type to PT_TRIM. */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+
+	modt_ioc.offset = total_size;
+	modt_ioc.length = 3 * PAGE_SIZE;
+	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(modt_ioc.result, 0);
+	EXPECT_EQ(modt_ioc.count, 3 * PAGE_SIZE);
+
+	/*
+	 * Enter enclave via TCS #1 and approve page removal by sending
+	 * EACCEPT for each of three removed pages.
+	 */
+	self->run.tcs = self->encl.encl_base;
+
+	eaccept_op.epc_addr = (unsigned long)stack_end;
+	eaccept_op.flags = SGX_SECINFO_TRIM | SGX_SECINFO_MODIFIED;
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
+	eaccept_op.epc_addr = (unsigned long)tcs;
+	eaccept_op.ret = 0;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	eaccept_op.epc_addr = (unsigned long)ssa;
+	eaccept_op.ret = 0;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	/* Send final ioctl() to complete page removal. */
+	memset(&remove_ioc, 0, sizeof(remove_ioc));
+
+	remove_ioc.offset = total_size;
+	remove_ioc.length = 3 * PAGE_SIZE;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(remove_ioc.count, 3 * PAGE_SIZE);
+
+	/*
+	 * Enter enclave via TCS #1 and access location where TCS #3 was to
+	 * trigger dynamic add of regular page at that location.
+	 */
+	eaccept_op.epc_addr = (unsigned long)tcs;
+	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
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
+	 * New page should be accessible from within enclave - write to it.
+	 */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = (unsigned long)tcs;
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
+	 * Read memory from newly added page that was just written to,
+	 * confirming that data previously written (MAGIC) is present.
+	 */
+	get_addr_op.value = 0;
+	get_addr_op.addr = (unsigned long)tcs;
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
+	munmap(addr, 3 * PAGE_SIZE);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index b45c52ec7ab3..fc585be97e2f 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -38,6 +38,7 @@ void encl_delete(struct encl *ctx);
 bool encl_load(const char *path, struct encl *encl, unsigned long heap_size);
 bool encl_measure(struct encl *encl);
 bool encl_build(struct encl *encl);
+uint64_t encl_get_entry(struct encl *encl, const char *symbol);
 
 int sgx_enter_enclave(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
 		      struct sgx_enclave_run *run);
-- 
2.25.1

