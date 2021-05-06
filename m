Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D709374F16
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 May 2021 07:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhEFF4y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 May 2021 01:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232985AbhEFF4l (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 May 2021 01:56:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D1D261176;
        Thu,  6 May 2021 05:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620280544;
        bh=b+2RfTUiONjTPWj2RWgXPoWQTd6b2XSJBDS+ELenGm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ki9gJgbSxz1VITZYQEehYLrGZiuk919hoLmGzFaLib9jhJVeN1TGNFk4jxlx3xdhN
         gytHdKTbNLnjUPbKkN2eiFUB4r6u1Dvsoc4ZD6YMRiAZ/Btg7s6cdA1RUdV+uGOC3V
         UTUINEZYoBcp0OZUO7VHpAq5rdXzHSMB+R78Ghr1TPQ2l6PptGBbbOSHL3XFpZXDvX
         3jl07s5BNDhy+aQrs5ZQ/xPngPRdomFEI+62RP5HOtfXIQ7a9bJfBzMelfuTVKUDfG
         0HOwPFxk0F2TmdkD7Ygb7KBAql7ExiVhN2No7O2fSD1ikKC4ngb+6YAUU2NMW+IYHT
         HHY7zGuvLE+gA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-sgx@vger.kernel.org, dave.hansen@intel.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/sgx: Report kselftest results
Date:   Thu,  6 May 2021 08:55:37 +0300
Message-Id: <20210506055537.132199-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210506055537.132199-1-jarkko@kernel.org>
References: <20210506055537.132199-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use ksft API documented in tools/testing/selftests/kselftest.h to count
succeeded and failed tests and print all the debug output with
ksft_print_msg(), as advised by the documentation.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---

v2:
* Add the missing string argument for the test case to
  ksft_test_result_pass() and ksft_test_result_fail() calls.

 tools/testing/selftests/sgx/main.c | 48 +++++++++++++++++-------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 43da68388e25..d61db69f65c6 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -20,6 +20,8 @@
 #include "main.h"
 #include "../kselftest.h"
 
+#define NR_KSELFTESTS 3
+
 static const uint64_t MAGIC = 0x1122334455667788ULL;
 vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
 
@@ -107,34 +109,35 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
 	return NULL;
 }
 
-bool report_results(struct sgx_enclave_run *run, int ret, uint64_t result,
-		  const char *test)
+bool update_ksft(struct sgx_enclave_run *run, int ret, uint64_t result, const char *test)
 {
 	bool valid = true;
 
 	if (ret) {
-		printf("FAIL: %s() returned: %d\n", test, ret);
+		ksft_print_msg("%s: ret = %d\n", test, ret);
 		valid = false;
 	}
 
 	if (run->function != EEXIT) {
-		printf("FAIL: %s() function, expected: %u, got: %u\n", test, EEXIT,
-		       run->function);
+		ksft_print_msg("%s: function, expected: %u, got: %u\n", test, EEXIT, run->function);
 		valid = false;
 	}
 
 	if (result != MAGIC) {
-		printf("FAIL: %s(), expected: 0x%lx, got: 0x%lx\n", test, MAGIC,
-		       result);
+		ksft_print_msg("%s: expected: 0x%lx, got: 0x%lx\n", test, MAGIC, result);
 		valid = false;
 	}
 
 	if (run->user_data) {
-		printf("FAIL: %s() user data, expected: 0x0, got: 0x%llx\n",
-		       test, run->user_data);
+		ksft_print_msg("%s: user data, expected: 0x0, got: 0x%llx\n", test, run->user_data);
 		valid = false;
 	}
 
+	if (valid)
+		ksft_test_result_pass("%s", test);
+	else
+		ksft_test_result_fail("%s", test);
+
 	return valid;
 }
 
@@ -156,6 +159,9 @@ int main(int argc, char *argv[])
 	void *addr;
 	int ret;
 
+	ksft_print_header();
+	ksft_set_plan(NR_KSELFTESTS);
+
 	memset(&run, 0, sizeof(run));
 
 	if (!encl_load("test_encl.elf", &encl)) {
@@ -178,8 +184,8 @@ int main(int argc, char *argv[])
 		addr = mmap((void *)encl.encl_base + seg->offset, seg->size,
 			    seg->prot, MAP_SHARED | MAP_FIXED, encl.fd, 0);
 		if (addr == MAP_FAILED) {
-			perror("mmap() segment failed");
-			exit(KSFT_FAIL);
+			ksft_print_msg("mmap() segment: %s", strerror(errno));
+			goto err;
 		}
 	}
 
@@ -200,32 +206,32 @@ int main(int argc, char *argv[])
 
 	vdso_sgx_enter_enclave = addr + sgx_enter_enclave_sym->st_value;
 
+	/* 1: unclobbered vDSO */
 	ret = sgx_enter_enclave((void *)&MAGIC, &result, 0, EENTER,
-					    NULL, NULL, &run);
-	if (!report_results(&run, ret, result, "sgx_enter_enclave_unclobbered"))
+				NULL, NULL, &run);
+	if (!update_ksft(&run, ret, result, "unclobbered"))
 		goto err;
 
-
-	/* Invoke the vDSO directly. */
+	/* 2: clobbered vDSO */
 	result = 0;
 	ret = vdso_sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result,
 				     0, EENTER, 0, 0, &run);
-	if (!report_results(&run, ret, result, "sgx_enter_enclave"))
+	if (!update_ksft(&run, ret, result, "sgx_enter_enclave"))
 		goto err;
 
-	/* And with an exit handler. */
+	/* 3: clobbered vDSO with a callback. */
 	run.user_handler = (__u64)user_handler;
 	run.user_data = 0xdeadbeef;
+
 	ret = vdso_sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result,
 				     0, EENTER, 0, 0, &run);
-	if (!report_results(&run, ret, result, "user_handler"))
+	if (!update_ksft(&run, ret, result, "user_handler"))
 		goto err;
 
-	printf("SUCCESS\n");
 	encl_delete(&encl);
-	exit(KSFT_PASS);
+	ksft_exit_pass();
 
 err:
 	encl_delete(&encl);
-	exit(KSFT_FAIL);
+	ksft_exit_fail();
 }
-- 
2.31.1

