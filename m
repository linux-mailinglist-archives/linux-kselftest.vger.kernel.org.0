Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1F337622F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 May 2021 10:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhEGIhJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 04:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236347AbhEGIhF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 04:37:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 023D760FDC;
        Fri,  7 May 2021 08:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620376565;
        bh=I+qN+0aqIyLTx4KBomCn8E0G7kBDY8z+bAk62yK5pIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmH+prl+5ntKjNuny4tzsesY56MjuDqD0wKQ1rjtaes53SQhgF800YP0AVyUiT7Yt
         Jp2T92BQC2mOp5TgfXyZ/0gaqDB33GejHBJ2QN4k7B+AKYG+9xuKyQ3KtY3Pblaxvo
         Naz79bv9DOeJAnvyHZy04hMTMGKFBFNUiSJ2ZSksmqDuPwhnYxwJf1lw05hyD2YEk/
         VdMH5adblafLzNAuDyUYEOHN1jLKRxLCh4M8lARvYktOAr6S0y9czGCSveyeczB9VF
         6uGoVGHTeamNxM0BeAU+YhngPkAuFKlsdn2v8DMkl8+kedighCLbg1qazytO2ikQgz
         GRqGHiEhbhpxA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-sgx@vger.kernel.org, dave.hansen@intel.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] selftests/sgx: Migrate to kselftest harness
Date:   Fri,  7 May 2021 11:35:52 +0300
Message-Id: <20210507083552.6832-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507083552.6832-1-jarkko@kernel.org>
References: <20210507083552.6832-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Migrate to kselftest harness so that the kselftest framework can probably
count and report passed and failed tests.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---

v3:
* Use helper macros.
v2:
* Add the missing string argument to ksft_test_result_pass() and
  ksft_test_result_fail() calls.

 tools/testing/selftests/sgx/main.c | 120 +++++++++++++++++------------
 1 file changed, 71 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 43da68388e25..4622dedcd290 100644
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
@@ -107,31 +107,27 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
 	return NULL;
 }
 
-bool report_results(struct sgx_enclave_run *run, int ret, uint64_t result,
-		  const char *test)
+bool is_test_passed(struct sgx_enclave_run *run, int ret, uint64_t result)
 {
 	bool valid = true;
 
 	if (ret) {
-		printf("FAIL: %s() returned: %d\n", test, ret);
+		ksft_print_msg("ret = %d\n", ret);
 		valid = false;
 	}
 
 	if (run->function != EEXIT) {
-		printf("FAIL: %s() function, expected: %u, got: %u\n", test, EEXIT,
-		       run->function);
+		ksft_print_msg("run->function: expected: %u, got: %u\n", EEXIT, run->function);
 		valid = false;
 	}
 
 	if (result != MAGIC) {
-		printf("FAIL: %s(), expected: 0x%lx, got: 0x%lx\n", test, MAGIC,
-		       result);
+		ksft_print_msg("result: expected: 0x%lx, got: 0x%lx\n", MAGIC, result);
 		valid = false;
 	}
 
 	if (run->user_data) {
-		printf("FAIL: %s() user data, expected: 0x0, got: 0x%llx\n",
-		       test, run->user_data);
+		ksft_print_msg("run->user_data:expected: 0x0, got: 0x%llx\n", run->user_data);
 		valid = false;
 	}
 
@@ -145,47 +141,42 @@ static int user_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r
 	return 0;
 }
 
-int main(int argc, char *argv[])
+FIXTURE(enclave) {
+	struct encl encl;
+};
+
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
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		struct encl_segment *seg = &self->encl.segment_tbl[i];
 
-		addr = mmap((void *)encl.encl_base + seg->offset, seg->size,
-			    seg->prot, MAP_SHARED | MAP_FIXED, encl.fd, 0);
+		addr = mmap((void *)self->encl.encl_base + seg->offset, seg->size,
+			    seg->prot, MAP_SHARED | MAP_FIXED, self->encl.fd, 0);
 		if (addr == MAP_FAILED) {
-			perror("mmap() segment failed");
-			exit(KSFT_FAIL);
+			ksft_print_msg("mmap() segment: %s", strerror(errno));
+			goto err;
 		}
 	}
 
-	memset(&run, 0, sizeof(run));
-	run.tcs = encl.encl_base;
-
 	/* Get vDSO base address */
 	addr = (void *)getauxval(AT_SYSINFO_EHDR);
 	if (!addr)
@@ -200,32 +191,63 @@ int main(int argc, char *argv[])
 
 	vdso_sgx_enter_enclave = addr + sgx_enter_enclave_sym->st_value;
 
-	ret = sgx_enter_enclave((void *)&MAGIC, &result, 0, EENTER,
-					    NULL, NULL, &run);
-	if (!report_results(&run, ret, result, "sgx_enter_enclave_unclobbered"))
-		goto err;
+err:
+	if (!sgx_enter_enclave_sym)
+		encl_delete(&self->encl);
+
+	ASSERT_NE(sgx_enter_enclave_sym, NULL);
+}
+
+FIXTURE_TEARDOWN(enclave)
+{
+	encl_delete(&self->encl);
+	vdso_sgx_enter_enclave = NULL;
+}
+
+
+TEST_F(enclave, unclobbered_vdso)
+{
+	struct sgx_enclave_run run;
+	uint64_t result = 0;
+	int ret;
+
+	memset(&run, 0, sizeof(run));
+
+	ret = sgx_enter_enclave((void *)&MAGIC, &result, 0, EENTER, NULL, NULL, &run);
 
+	ASSERT_EQ(true, is_test_passed(&run, ret, result));
+}
+
+TEST_F(enclave, clobbered_vdso)
+{
+	struct sgx_enclave_run run;
+	uint64_t result = 0;
+	int ret;
+
+	memset(&run, 0, sizeof(run));
 
-	/* Invoke the vDSO directly. */
-	result = 0;
 	ret = vdso_sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result,
 				     0, EENTER, 0, 0, &run);
-	if (!report_results(&run, ret, result, "sgx_enter_enclave"))
-		goto err;
 
-	/* And with an exit handler. */
+
+	ASSERT_EQ(true, is_test_passed(&run, ret, result));
+}
+
+TEST_F(enclave, clobbered_vdso_and_user_function)
+{
+	struct sgx_enclave_run run;
+	uint64_t result = 0;
+	int ret;
+
+	memset(&run, 0, sizeof(run));
+
 	run.user_handler = (__u64)user_handler;
 	run.user_data = 0xdeadbeef;
+
 	ret = vdso_sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result,
 				     0, EENTER, 0, 0, &run);
-	if (!report_results(&run, ret, result, "user_handler"))
-		goto err;
 
-	printf("SUCCESS\n");
-	encl_delete(&encl);
-	exit(KSFT_PASS);
-
-err:
-	encl_delete(&encl);
-	exit(KSFT_FAIL);
+	ASSERT_EQ(true, is_test_passed(&run, ret, result));
 }
+
+TEST_HARNESS_MAIN
-- 
2.31.1

