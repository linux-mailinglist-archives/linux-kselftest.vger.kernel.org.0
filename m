Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D957B376F51
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 May 2021 05:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhEHD54 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 23:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231129AbhEHD54 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 23:57:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D92F56147D;
        Sat,  8 May 2021 03:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620446215;
        bh=YUDcfHUcZIdtNrzxkj4k+WqdNvMvqz8JMJM2Ahkx0i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KQ1BF+3rPSqLcEdAAuXRHBEbbXjQczawvSppVLJAjNJ0itvnO1P7XRLtkbitSY1vZ
         +FQ1dbT61UDSW2mWKR4NW2Ib79mFBjYyb4rBlFDHxpV2EP75ywonpPmJY/B8g+n//2
         E24mKBkM5sN4k2rvv4LlKE8o/EB17x18ZBaikT5FWp7ow74LRDlW8oI1+QDlwVwTSx
         DZ9+FVjGN+falzQQGLPkpGn0l0ZjhpMwbzi/BUvFXHz20QjmZS3HsCssisDSNO4juS
         hl0kyV+qN7eE9kILw89XNhP73RM2zMTAb/UXkSSF+2OOoIDR5Zy+m84pC9Yc0SU5fe
         gfLSWXkoYXGFg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        reinette.chatre@intel.com, Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] selftests/sgx: Migrate to kselftest harness
Date:   Sat,  8 May 2021 06:56:47 +0300
Message-Id: <20210508035648.18176-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210508035648.18176-1-jarkko@kernel.org>
References: <20210508035648.18176-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Migrate to kselftest harness. Use a fixture test with enclave initialized
and de-initialized for each of the existing three tests, in other words:

1. One FIXTURE() for managing the enclave life-cycle.
2. Three TEST_F()'s, one for each test case.

This gives a leaps better reporting than before. Here's an example
transcript:

TAP version 13
1..3
0x0000000000000000 0x0000000000002000 0x03
0x0000000000002000 0x0000000000001000 0x05
0x0000000000003000 0x0000000000003000 0x03
ok 1 enclave.unclobbered_vdso
0x0000000000000000 0x0000000000002000 0x03
0x0000000000002000 0x0000000000001000 0x05
0x0000000000003000 0x0000000000003000 0x03
ok 2 enclave.clobbered_vdso
0x0000000000000000 0x0000000000002000 0x03
0x0000000000002000 0x0000000000001000 0x05
0x0000000000003000 0x0000000000003000 0x03
ok 3 enclave.clobbered_vdso_and_user_function

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---

v4:
* Refine to take better use of the kselftest harness macros.
* Fix: TCS base address was not initialized for a run struct.

v3:
* Use helper macros.

v2:
* Add the missing string argument to ksft_test_result_pass() and
  ksft_test_result_fail() calls.

 tools/testing/selftests/sgx/main.c | 163 ++++++++++++++---------------
 1 file changed, 78 insertions(+), 85 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 43da68388e25..2a29883179e1 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -18,7 +18,7 @@
 #include <sys/auxv.h>
 #include "defines.h"
 #include "main.h"
-#include "../kselftest.h"
+#include "../kselftest_harness.h"
 
 static const uint64_t MAGIC = 0x1122334455667788ULL;
 vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
@@ -107,85 +107,42 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
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
 	unsigned int i;
 	void *addr;
-	int ret;
 
-	memset(&run, 0, sizeof(run));
-
-	if (!encl_load("test_encl.elf", &encl)) {
-		encl_delete(&encl);
+	if (!encl_load("test_encl.elf", &self->encl)) {
+		encl_delete(&self->encl);
 		ksft_exit_skip("cannot load enclaves\n");
 	}
 
-	if (!encl_measure(&encl))
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
@@ -200,32 +157,68 @@ int main(int argc, char *argv[])
 
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
+	vdso_sgx_enter_enclave = NULL;
+}
 
-	printf("SUCCESS\n");
-	encl_delete(&encl);
-	exit(KSFT_PASS);
 
-err:
-	encl_delete(&encl);
-	exit(KSFT_FAIL);
+TEST_F(enclave, unclobbered_vdso)
+{
+	uint64_t result = 0;
+
+	EXPECT_EQ(sgx_enter_enclave((void *)&MAGIC, &result, 0, EENTER, NULL, NULL, &self->run), 0);
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
+	EXPECT_EQ(vdso_sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result, 0,
+					 EENTER, 0, 0, &self->run), 0);
+
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
+	EXPECT_EQ(vdso_sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result, 0,
+					 EENTER, 0, 0, &self->run), 0);
+
+	EXPECT_EQ(result, MAGIC);
+	EXPECT_EQ(self->run.function, EEXIT);
+	EXPECT_EQ(self->run.user_data, 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.31.1

