Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7963A5A59C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 05:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiH3DNH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 23:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiH3DMx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 23:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B1A346B;
        Mon, 29 Aug 2022 20:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F5C6614CC;
        Tue, 30 Aug 2022 03:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB087C433C1;
        Tue, 30 Aug 2022 03:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661829159;
        bh=y8P5HA7NSy7pcLtmRq3CnXqiTQr7yq/+6nSCLosUDmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVpol8DYKIK1Zkt6PJMX/A/1Bmn2j8d/h0KmsO7GRnXsDBeEZQzwvsiQEi9YwNzjX
         UTtNc9o/AdQxj/HW7mMu+wFseoGIFODlp2BNHA0yXJdJZrqZaT6v3QAQ0fRPf7Eapv
         6lnuFybHBTNfo8CroYxbxghen67PfdvtI4aKSfiMNbIyHmeN+sr6evguOxOZuOyZvs
         Lqo7B3MsMCpCCOvxt3KQ+cjXsB+gMdAy5OrrUy5Teo+27Amm/u9+EPysIeBnM2rPUY
         FZy3G2BC7190gYtQMPNN/YTbuW/VAbXEOnfGQ80kccw1n3sqOkJMmBtj10kzMq65hx
         bUGqiD1BAJXQg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/6] selftests/sgx: Add SGX selftest augment_via_eaccept_long
Date:   Tue, 30 Aug 2022 06:12:04 +0300
Message-Id: <20220830031206.13449-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830031206.13449-1-jarkko@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Vijay Dhanraj <vijay.dhanraj@intel.com>

Add a new test case which is same as augment_via_eaccept but adds a
larger number of EPC pages to stress test EAUG via EACCEPT.

Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Addressed Reinette's feedback:
  https://lore.kernel.org/linux-sgx/24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com/
---
 tools/testing/selftests/sgx/load.c      |   5 +-
 tools/testing/selftests/sgx/main.c      | 141 +++++++++++++++++++++---
 tools/testing/selftests/sgx/main.h      |   3 +-
 tools/testing/selftests/sgx/sigstruct.c |   2 +-
 4 files changed, 129 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 94bdeac1cf04..7de1b15c90b1 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -171,7 +171,8 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
 	return 0;
 }
 
-bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
+bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
+			   unsigned long edmm_size)
 {
 	const char device_path[] = "/dev/sgx_enclave";
 	struct encl_segment *seg;
@@ -300,7 +301,7 @@ bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
 
 	encl->src_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size;
 
-	for (encl->encl_size = 4096; encl->encl_size < encl->src_size; )
+	for (encl->encl_size = 4096; encl->encl_size < encl->src_size + edmm_size;)
 		encl->encl_size <<= 1;
 
 	return true;
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 9820b3809c69..867e98502120 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -21,8 +21,15 @@
 #include "../kselftest_harness.h"
 #include "main.h"
 
+/*
+ * The size was chosen based on a bug report:
+ * https://lore.kernel.org/linux-sgx/DM8PR11MB55912A7F47A84EC9913A6352F6999@DM8PR11MB5591.namprd11.prod.outlook.com/
+ */
+static const unsigned long EDMM_SIZE_LONG = 8L * 1024L * 1024L * 1024L; // 8 GB
+static const unsigned long TIMEOUT_LONG = 900; /* seconds */
 static const uint64_t MAGIC = 0x1122334455667788ULL;
 static const uint64_t MAGIC2 = 0x8877665544332211ULL;
+
 vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
 
 /*
@@ -173,7 +180,8 @@ FIXTURE(enclave) {
 };
 
 static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
-			    struct __test_metadata *_metadata)
+			    struct __test_metadata *_metadata,
+			    unsigned long edmm_size)
 {
 	Elf64_Sym *sgx_enter_enclave_sym = NULL;
 	struct vdso_symtab symtab;
@@ -183,7 +191,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 	unsigned int i;
 	void *addr;
 
-	if (!encl_load("test_encl.elf", encl, heap_size)) {
+	if (!encl_load("test_encl.elf", encl, heap_size, edmm_size)) {
 		encl_delete(encl);
 		TH_LOG("Failed to load the test enclave.");
 		return false;
@@ -284,7 +292,7 @@ TEST_F(enclave, unclobbered_vdso)
 	struct encl_op_get_from_buf get_op;
 	struct encl_op_put_to_buf put_op;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -357,7 +365,7 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 
 	total_mem = get_total_epc_mem();
 	ASSERT_NE(total_mem, 0);
-	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -401,7 +409,7 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
 	ASSERT_NE(total_mem, 0);
 	TH_LOG("Creating an enclave with %lu bytes heap may take a while ...",
 	       total_mem);
-	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata, 0));
 
 	/*
 	 * Hardware (SGX2) and kernel support is needed for this test. Start
@@ -506,7 +514,7 @@ TEST_F(enclave, clobbered_vdso)
 	struct encl_op_get_from_buf get_op;
 	struct encl_op_put_to_buf put_op;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -542,7 +550,7 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	struct encl_op_get_from_buf get_op;
 	struct encl_op_put_to_buf put_op;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -575,7 +583,7 @@ TEST_F(enclave, tcs_entry)
 {
 	struct encl_op_header op;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -620,7 +628,7 @@ TEST_F(enclave, pte_permissions)
 	unsigned long data_start;
 	int ret;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -722,7 +730,7 @@ TEST_F(enclave, tcs_permissions)
 	struct sgx_enclave_restrict_permissions ioc;
 	int ret, errno_save;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -785,7 +793,7 @@ TEST_F(enclave, epcm_permissions)
 	unsigned long data_start;
 	int ret, errno_save;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -986,7 +994,7 @@ TEST_F(enclave, augment)
 	if (!sgx2_supported())
 		SKIP(return, "SGX2 not supported");
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -1116,7 +1124,7 @@ TEST_F(enclave, augment_via_eaccept)
 	if (!sgx2_supported())
 		SKIP(return, "SGX2 not supported");
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -1210,6 +1218,103 @@ TEST_F(enclave, augment_via_eaccept)
 	munmap(addr, PAGE_SIZE);
 }
 
+/*
+ * Test for the addition of large number of pages to an initialized enclave via
+ * a pre-emptive run of EACCEPT on every page to be added.
+ */
+TEST_F_TIMEOUT(enclave, augment_via_eaccept_long, TIMEOUT_LONG)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_eaccept eaccept_op;
+	size_t total_size = 0;
+	unsigned long i;
+	void *addr;
+
+	if (!sgx2_supported())
+		SKIP(return, "SGX2 not supported");
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata,
+				    EDMM_SIZE_LONG));
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
+	 * mmap() every page at end of existing enclave to be used for
+	 * EDMM.
+	 */
+	addr = mmap((void *)self->encl.encl_base + total_size, EDMM_SIZE_LONG,
+			PROT_READ | PROT_WRITE | PROT_EXEC, MAP_SHARED | MAP_FIXED,
+			self->encl.fd, 0);
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
+	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
+	eaccept_op.ret = 0;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	for (i = 0; i < EDMM_SIZE_LONG; i += 4096) {
+		eaccept_op.epc_addr = (uint64_t)(addr + i);
+
+		EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+		if (self->run.exception_vector == 14 &&
+			self->run.exception_error_code == 4 &&
+			self->run.exception_addr == self->encl.encl_base) {
+			munmap(addr, EDMM_SIZE_LONG);
+			SKIP(return, "Kernel does not support adding pages to initialized enclave");
+		}
+
+		EXPECT_EQ(self->run.exception_vector, 0);
+		EXPECT_EQ(self->run.exception_error_code, 0);
+		EXPECT_EQ(self->run.exception_addr, 0);
+		ASSERT_EQ(eaccept_op.ret, 0);
+		ASSERT_EQ(self->run.function, EEXIT);
+	}
+
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
+	munmap(addr, EDMM_SIZE_LONG);
+}
+
 /*
  * SGX2 page type modification test in two phases:
  * Phase 1:
@@ -1238,7 +1343,7 @@ TEST_F(enclave, tcs_create)
 	int ret, i;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl,
-				    _metadata));
+				    _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -1568,7 +1673,7 @@ TEST_F(enclave, remove_added_page_no_eaccept)
 	unsigned long data_start;
 	int ret, errno_save;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -1679,7 +1784,7 @@ TEST_F(enclave, remove_added_page_invalid_access)
 	unsigned long data_start;
 	int ret, errno_save;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -1794,7 +1899,7 @@ TEST_F(enclave, remove_added_page_invalid_access_after_eaccept)
 	unsigned long data_start;
 	int ret, errno_save;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -1918,7 +2023,7 @@ TEST_F(enclave, remove_untouched_page)
 	unsigned long data_start;
 	int ret, errno_save;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
 
 	/*
 	 * Hardware (SGX2) and kernel support is needed for this test. Start
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index fc585be97e2f..fe5d39ac0e1e 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -35,7 +35,8 @@ extern unsigned char sign_key[];
 extern unsigned char sign_key_end[];
 
 void encl_delete(struct encl *ctx);
-bool encl_load(const char *path, struct encl *encl, unsigned long heap_size);
+bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
+			   unsigned long edmm_size);
 bool encl_measure(struct encl *encl);
 bool encl_build(struct encl *encl);
 uint64_t encl_get_entry(struct encl *encl, const char *symbol);
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index a07896a46364..decd767434d5 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -349,7 +349,7 @@ bool encl_measure(struct encl *encl)
 	if (!ctx)
 		goto err;
 
-	if (!mrenclave_ecreate(ctx, encl->src_size))
+	if (!mrenclave_ecreate(ctx, encl->encl_size))
 		goto err;
 
 	for (i = 0; i < encl->nr_segments; i++) {
-- 
2.37.2

