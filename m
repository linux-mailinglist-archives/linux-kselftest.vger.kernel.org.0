Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06FC4CD13F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 10:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbiCDJia (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 04:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiCDJiP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB023EBAFD;
        Fri,  4 Mar 2022 01:37:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61BE961877;
        Fri,  4 Mar 2022 09:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D52BC340E9;
        Fri,  4 Mar 2022 09:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386643;
        bh=td03E+VxqV1sHqZ2twwWB29v96HBJ+vNd/qZrzoqWmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qu6IhPohZUNxdhVhxzWLb27+1Yj9lmA0hhWZuNCaqEWFo+zPc0XX9Q6GRFMZ4QLDM
         S+dUEwsOvMLSxHgj05zXQFM/pAdjAgNv7XHbnTikaC4ayNUGU4Gva3ntqF4CrueJDO
         dU24VfnhfOxdl5uECaQmgJ+oIh21IvacsESHiif/DzNKeRKePsRQIpsEeR3zIddKEE
         RJxILLrKp2HP40jqAt+iISo7TB+vjuHl03Ql3R1NipLwRlxmSz8gnOQNbOmoolMu0B
         fuYz1o5uqpuS+LAIiizwu8B5Rg2x80hQl7F2jELBJ9ERBhAeWSCNMw2BA8jMfDbd05
         7dH6h/XAxFqZA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2.1 25/30] selftests/sgx: Test complete changing of page type flow
Date:   Fri,  4 Mar 2022 11:35:19 +0200
Message-Id: <20220304093524.397485-25-jarkko@kernel.org>
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

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/load.c |  41 ++++
 tools/testing/selftests/sgx/main.c | 347 +++++++++++++++++++++++++++++
 tools/testing/selftests/sgx/main.h |   1 +
 3 files changed, 389 insertions(+)

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
index 13542c5de66f..f9872c6746a3 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1106,4 +1106,351 @@ TEST_F(enclave, augment_via_eaccept)
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
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_get_from_buf get_buf_op;
+	struct encl_op_put_to_buf put_buf_op;
+	void *addr, *tcs, *stack_end, *ssa;
+	struct encl_op_eaccept eaccept_op;
+	struct sgx_enclave_modt modt_ioc;
+	struct sgx_secinfo secinfo;
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
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &modt_ioc);
+
+	if (ret == -1) {
+		if (errno == ENOTTY)
+			SKIP(return, "Kernel does not support SGX_IOC_ENCLAVE_MODIFY_TYPE ioctl()");
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
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = SGX_PAGE_TYPE_TCS << 8;
+	modt_ioc.offset = total_size + PAGE_SIZE;
+	modt_ioc.length = PAGE_SIZE;
+	modt_ioc.secinfo = (unsigned long)&secinfo;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &modt_ioc);
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
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = SGX_PAGE_TYPE_TRIM << 8;
+	modt_ioc.offset = total_size;
+	modt_ioc.length = 3 * PAGE_SIZE;
+	modt_ioc.secinfo = (unsigned long)&secinfo;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &modt_ioc);
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
2.35.1

