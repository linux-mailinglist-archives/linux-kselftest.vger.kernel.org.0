Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AA44CD141
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbiCDJib (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 04:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbiCDJiK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579291986EF;
        Fri,  4 Mar 2022 01:37:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA4BFB827BD;
        Fri,  4 Mar 2022 09:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD26C340E9;
        Fri,  4 Mar 2022 09:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386626;
        bh=pjNa9LSA/lm7QztCmvwZlUV4qn6sayOEKKTO0IME/PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPU97KCbG5YpiP954z37Lgc1+FlW2BJpBFHBQJ+/So8KbV5pT5Y1Vb282ybU2kEm2
         eHIaZ1Sd2yt/h8dakugrBRTNHTDAyHBEKIUR5r2oyQP/10HF2trs32/UqOkhIKkxQ3
         hTB4kOZkwXa+8OB2eJYZ8pts7+pLOIqzUlTHq3MJyKME1theajb7d82K09+jV9F4zo
         U9jlyEWHroL/X3v8Q6J/6fPDx9sfVC7emAMzixjz0zbH3THfSgIiwCogW23WYTo42S
         M6m52Q48bfbC8i1cVWgVnd6huuArYSE1jNyFPDR6Wxu1BNLR+oj31nmYu0KkVjCegE
         z+zldwB9FXxrQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2.1 19/30] selftests/sgx: Test two different SGX2 EAUG flows
Date:   Fri,  4 Mar 2022 11:35:13 +0200
Message-Id: <20220304093524.397485-19-jarkko@kernel.org>
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

Enclave pages can be added to an initialized enclave when an address
belonging to the enclave but without a backing page is accessed from
within the enclave.

Accessing memory without a backing enclave page from within an enclave
can be in different ways:
1) Pre-emptively run ENCLU[EACCEPT]. Since the addition of a page
   always needs to be accepted by the enclave via ENCLU[EACCEPT] this
   flow is efficient since the first execution of ENCLU[EACCEPT]
   triggers the addition of the page and when execution returns to the
   same instruction the second execution would be successful as an
   acceptance of the page.

2) A direct read or write. The flow where a direct read or write
   triggers the page addition execution cannot resume from the
   instruction (read/write) that triggered the fault but instead
   the enclave needs to be entered at a different entry point to
   run needed ENCLU[EACCEPT] before execution can return to the
   original entry point and the read/write instruction that faulted.

Add tests for both flows.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/main.c | 243 +++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index ea5f2e064687..13542c5de66f 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -86,6 +86,15 @@ static bool vdso_get_symtab(void *addr, struct vdso_symtab *symtab)
 	return true;
 }
 
+static inline int sgx2_supported(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	__cpuid_count(SGX_CPUID, 0x0, eax, ebx, ecx, edx);
+
+	return eax & 0x2;
+}
+
 static unsigned long elf_sym_hash(const char *name)
 {
 	unsigned long h = 0, high;
@@ -863,4 +872,238 @@ TEST_F(enclave, epcm_permissions)
 	EXPECT_EQ(self->run.exception_addr, 0);
 }
 
+/*
+ * Test the addition of pages to an initialized enclave via writing to
+ * a page belonging to the enclave's address space but was not added
+ * during enclave creation.
+ */
+TEST_F(enclave, augment)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_eaccept eaccept_op;
+	size_t total_size = 0;
+	void *addr;
+	int i;
+
+	if (!sgx2_supported())
+		SKIP(return, "SGX2 not supported");
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		struct encl_segment *seg = &self->encl.segment_tbl[i];
+
+		total_size += seg->size;
+	}
+
+	/*
+	 * Actual enclave size is expected to be larger than the loaded
+	 * test enclave since enclave size must be a power of 2 in bytes
+	 * and test_encl does not consume it all.
+	 */
+	EXPECT_LT(total_size + PAGE_SIZE, self->encl.encl_size);
+
+	/*
+	 * Create memory mapping for the page that will be added. New
+	 * memory mapping is for one page right after all existing
+	 * mappings.
+	 */
+	addr = mmap((void *)self->encl.encl_base + total_size, PAGE_SIZE,
+		    PROT_READ | PROT_WRITE | PROT_EXEC,
+		    MAP_SHARED | MAP_FIXED, self->encl.fd, 0);
+	EXPECT_NE(addr, MAP_FAILED);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/*
+	 * Attempt to write to the new page from within enclave.
+	 * Expected to fail since page is not (yet) part of the enclave.
+	 * The first #PF will trigger the addition of the page to the
+	 * enclave, but since the new page needs an EACCEPT from within the
+	 * enclave before it can be used it would not be possible
+	 * to successfully return to the failing instruction. This is the
+	 * cause of the second #PF captured here having the SGX bit set,
+	 * it is from hardware preventing the page from being used.
+	 */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = (unsigned long)addr;
+	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(self->run.function, ERESUME);
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_addr, (unsigned long)addr);
+
+	if (self->run.exception_error_code == 0x6) {
+		munmap(addr, PAGE_SIZE);
+		SKIP(return, "Kernel does not support adding pages to initialized enclave");
+	}
+
+	EXPECT_EQ(self->run.exception_error_code, 0x8007);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/* Handle AEX by running EACCEPT from new entry point. */
+	self->run.tcs = self->encl.encl_base + PAGE_SIZE;
+
+	eaccept_op.epc_addr = self->encl.encl_base + total_size;
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
+	/* Can now return to main TCS to resume execution. */
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
+	/*
+	 * Read memory from newly added page that was just written to,
+	 * confirming that data previously written (MAGIC) is present.
+	 */
+	get_addr_op.value = 0;
+	get_addr_op.addr = (unsigned long)addr;
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
+	munmap(addr, PAGE_SIZE);
+}
+
+/*
+ * Test for the addition of pages to an initialized enclave via a
+ * pre-emptive run of EACCEPT on page to be added.
+ */
+TEST_F(enclave, augment_via_eaccept)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_eaccept eaccept_op;
+	size_t total_size = 0;
+	void *addr;
+	int i;
+
+	if (!sgx2_supported())
+		SKIP(return, "SGX2 not supported");
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
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
+	EXPECT_LT(total_size + PAGE_SIZE, self->encl.encl_size);
+
+	/*
+	 * mmap() a page at end of existing enclave to be used for dynamic
+	 * EPC page.
+	 */
+
+	addr = mmap((void *)self->encl.encl_base + total_size, PAGE_SIZE,
+		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_SHARED | MAP_FIXED,
+		    self->encl.fd, 0);
+	EXPECT_NE(addr, MAP_FAILED);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/*
+	 * Run EACCEPT on new page to trigger the #PF->EAUG->EACCEPT(again
+	 * without a #PF). All should be transparent to userspace.
+	 */
+	eaccept_op.epc_addr = self->encl.encl_base + total_size;
+	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
+	eaccept_op.ret = 0;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	if (self->run.exception_vector == 14 &&
+	    self->run.exception_error_code == 4 &&
+	    self->run.exception_addr == self->encl.encl_base + total_size) {
+		munmap(addr, PAGE_SIZE);
+		SKIP(return, "Kernel does not support adding pages to initialized enclave");
+	}
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	/*
+	 * New page should be accessible from within enclave - attempt to
+	 * write to it.
+	 */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = (unsigned long)addr;
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
+	get_addr_op.addr = (unsigned long)addr;
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
+	munmap(addr, PAGE_SIZE);
+}
+
 TEST_HARNESS_MAIN
-- 
2.35.1

