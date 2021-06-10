Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE783A2708
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 10:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFJIca (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 04:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhFJIc2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 04:32:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 418A3610C7;
        Thu, 10 Jun 2021 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623313830;
        bh=maiKAPMXax7P6jxTxySa7yisj43wKULjh2bKNt1t99A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPB4slklPyeONuEKEPP5ERxZJty/pJbvUemVp4xNBaPDelx86tSBkuYAm5W/6LmPZ
         j/0v/SWAEEgMhgJO3TRPclxyKFm9GoEydNsyylu5HREEJXzN9E7f81pAb8a2EXgM2g
         hEwLtbbmgqFNoPymt79boY5xgkUBGNZJu6D9uDbkS7Meo/nEbiywuNm74XIPeAaO4Y
         91v2wMWq2sBd+JGleG9RduxMmHa9Znryzrj4HmO1c94jqffhVClQYRjO9C67unEwar
         FyTc+eK8QlYiwXTR2r8QTgvfuFAT8AubsqBRts21zKZXMJ49956ZMi1FOClbwOnkiQ
         2I1GLJ8p4iSFA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/5] selftests/sgx: Migrate to kselftest harness
Date:   Thu, 10 Jun 2021 11:30:18 +0300
Message-Id: <20210610083021.392269-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610083021.392269-1-jarkko@kernel.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Migrate to kselftest harness. Use a fixture test with enclave initialized
and de-initialized for each of the existing three tests, in other words:

1. One FIXTURE() for managing the enclave life-cycle.
2. Three TEST_F()'s, one for each test case.

Dump lines of /proc/self/maps matching "sgx" in FIXTURE_SETUP() as this
can be very useful debugging information later on.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---

v8:
* Replace inline function call with ENCL_CALL() macro.

v7:
* Implement encl_call() that wraps the logic of invoking the vDSO for the
  test enclave.

v6:
* Remove extra '\n' from TH_LOG() calls.

v5:
* Use TH_LOG() for printing enclave address ranges instead of printf(),
  based on Reinette's remark.

v4:
* Refine to take better use of the kselftest harness macros.
* Fix: TCS base address was not initialized for a run struct.

v3:
* Use helper macros.

v2:
* Add the missing string argument to ksft_test_result_pass() and
  ksft_test_result_fail() calls.

 tools/testing/selftests/sgx/load.c |   3 -
 tools/testing/selftests/sgx/main.c | 177 +++++++++++++++--------------
 2 files changed, 92 insertions(+), 88 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index f441ac34b4d4..00928be57fc4 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -239,9 +239,6 @@ bool encl_load(const char *path, struct encl *encl)
 		seg->offset = (phdr->p_offset & PAGE_MASK) - src_offset;
 		seg->size = (phdr->p_filesz + PAGE_SIZE - 1) & PAGE_MASK;
 
-		printf("0x%016lx 0x%016lx 0x%02x\n", seg->offset, seg->size,
-		       seg->prot);
-
 		j++;
 	}
 
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 43da68388e25..6da19b6bf287 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -17,8 +17,8 @@
 #include <sys/types.h>
 #include <sys/auxv.h>
 #include "defines.h"
+#include "../kselftest_harness.h"
 #include "main.h"
-#include "../kselftest.h"
 
 static const uint64_t MAGIC = 0x1122334455667788ULL;
 vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
@@ -107,85 +107,49 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
 	return NULL;
 }
 
-bool report_results(struct sgx_enclave_run *run, int ret, uint64_t result,
-		  const char *test)
-{
-	bool valid = true;
-
-	if (ret) {
-		printf("FAIL: %s() returned: %d\n", test, ret);
-		valid = false;
-	}
-
-	if (run->function != EEXIT) {
-		printf("FAIL: %s() function, expected: %u, got: %u\n", test, EEXIT,
-		       run->function);
-		valid = false;
-	}
-
-	if (result != MAGIC) {
-		printf("FAIL: %s(), expected: 0x%lx, got: 0x%lx\n", test, MAGIC,
-		       result);
-		valid = false;
-	}
-
-	if (run->user_data) {
-		printf("FAIL: %s() user data, expected: 0x0, got: 0x%llx\n",
-		       test, run->user_data);
-		valid = false;
-	}
-
-	return valid;
-}
-
-static int user_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r9,
-			struct sgx_enclave_run *run)
-{
-	run->user_data = 0;
-	return 0;
-}
+FIXTURE(enclave) {
+	struct encl encl;
+	struct sgx_enclave_run run;
+};
 
-int main(int argc, char *argv[])
+FIXTURE_SETUP(enclave)
 {
-	struct sgx_enclave_run run;
+	Elf64_Sym *sgx_enter_enclave_sym = NULL;
 	struct vdso_symtab symtab;
-	Elf64_Sym *sgx_enter_enclave_sym;
-	uint64_t result = 0;
-	struct encl encl;
+	struct encl_segment *seg;
 	unsigned int i;
 	void *addr;
-	int ret;
-
-	memset(&run, 0, sizeof(run));
 
-	if (!encl_load("test_encl.elf", &encl)) {
-		encl_delete(&encl);
+	if (!encl_load("test_encl.elf", &self->encl)) {
+		encl_delete(&self->encl);
 		ksft_exit_skip("cannot load enclaves\n");
 	}
 
-	if (!encl_measure(&encl))
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		seg = &self->encl.segment_tbl[i];
+
+		TH_LOG("0x%016lx 0x%016lx 0x%02x", seg->offset, seg->size, seg->prot);
+	}
+
+	if (!encl_measure(&self->encl))
 		goto err;
 
-	if (!encl_build(&encl))
+	if (!encl_build(&self->encl))
 		goto err;
 
 	/*
 	 * An enclave consumer only must do this.
 	 */
-	for (i = 0; i < encl.nr_segments; i++) {
-		struct encl_segment *seg = &encl.segment_tbl[i];
-
-		addr = mmap((void *)encl.encl_base + seg->offset, seg->size,
-			    seg->prot, MAP_SHARED | MAP_FIXED, encl.fd, 0);
-		if (addr == MAP_FAILED) {
-			perror("mmap() segment failed");
-			exit(KSFT_FAIL);
-		}
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		struct encl_segment *seg = &self->encl.segment_tbl[i];
+
+		addr = mmap((void *)self->encl.encl_base + seg->offset, seg->size,
+			    seg->prot, MAP_SHARED | MAP_FIXED, self->encl.fd, 0);
+		EXPECT_NE(addr, MAP_FAILED);
+		if (addr == MAP_FAILED)
+			goto err;
 	}
 
-	memset(&run, 0, sizeof(run));
-	run.tcs = encl.encl_base;
-
 	/* Get vDSO base address */
 	addr = (void *)getauxval(AT_SYSINFO_EHDR);
 	if (!addr)
@@ -200,32 +164,75 @@ int main(int argc, char *argv[])
 
 	vdso_sgx_enter_enclave = addr + sgx_enter_enclave_sym->st_value;
 
-	ret = sgx_enter_enclave((void *)&MAGIC, &result, 0, EENTER,
-					    NULL, NULL, &run);
-	if (!report_results(&run, ret, result, "sgx_enter_enclave_unclobbered"))
-		goto err;
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
 
+err:
+	if (!sgx_enter_enclave_sym)
+		encl_delete(&self->encl);
 
-	/* Invoke the vDSO directly. */
-	result = 0;
-	ret = vdso_sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result,
-				     0, EENTER, 0, 0, &run);
-	if (!report_results(&run, ret, result, "sgx_enter_enclave"))
-		goto err;
+	ASSERT_NE(sgx_enter_enclave_sym, NULL);
+}
 
-	/* And with an exit handler. */
-	run.user_handler = (__u64)user_handler;
-	run.user_data = 0xdeadbeef;
-	ret = vdso_sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result,
-				     0, EENTER, 0, 0, &run);
-	if (!report_results(&run, ret, result, "user_handler"))
-		goto err;
+FIXTURE_TEARDOWN(enclave)
+{
+	encl_delete(&self->encl);
+}
 
-	printf("SUCCESS\n");
-	encl_delete(&encl);
-	exit(KSFT_PASS);
+#define ENCL_CALL(in, out, run, clobbered) \
+	({ \
+		int ret; \
+		if ((clobbered)) \
+			ret = vdso_sgx_enter_enclave((unsigned long)(in), (unsigned long)(out), 0, \
+						     EENTER, 0, 0, (run)); \
+		else \
+			ret = sgx_enter_enclave((void *)(in), (void *)(out), 0, EENTER, NULL, NULL, \
+						(run)); \
+		ret; \
+	})
+
+TEST_F(enclave, unclobbered_vdso)
+{
+	uint64_t result = 0;
 
-err:
-	encl_delete(&encl);
-	exit(KSFT_FAIL);
+	EXPECT_EQ(ENCL_CALL(&MAGIC, &result, &self->run, false), 0);
+
+	EXPECT_EQ(result, MAGIC);
+	EXPECT_EQ(self->run.function, EEXIT);
+	EXPECT_EQ(self->run.user_data, 0);
+}
+
+TEST_F(enclave, clobbered_vdso)
+{
+	uint64_t result = 0;
+
+	EXPECT_EQ(ENCL_CALL(&MAGIC, &result, &self->run, true), 0);
+
+	EXPECT_EQ(result, MAGIC);
+	EXPECT_EQ(self->run.function, EEXIT);
+	EXPECT_EQ(self->run.user_data, 0);
 }
+
+static int test_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r9,
+			struct sgx_enclave_run *run)
+{
+	run->user_data = 0;
+
+	return 0;
+}
+
+TEST_F(enclave, clobbered_vdso_and_user_function)
+{
+	uint64_t result = 0;
+
+	self->run.user_handler = (__u64)test_handler;
+	self->run.user_data = 0xdeadbeef;
+
+	EXPECT_EQ(ENCL_CALL(&MAGIC, &result, &self->run, true), 0);
+
+	EXPECT_EQ(result, MAGIC);
+	EXPECT_EQ(self->run.function, EEXIT);
+	EXPECT_EQ(self->run.user_data, 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.31.1

