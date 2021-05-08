Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2797B376F4F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 May 2021 05:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhEHD5x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 23:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231129AbhEHD5x (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 23:57:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46A8261106;
        Sat,  8 May 2021 03:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620446212;
        bh=R0O9/+3NWKcgkdhHuXxWuRHSC7X1XKa4b11RA5ahgDo=;
        h=From:To:Cc:Subject:Date:From;
        b=GOMUeeLS1VCHhk3XgLtQLAE0wQrqFLLgX89RApUvVVmASHZDHgeRaPpASvDwr9NW9
         OLJFimoEQbwJoMuwcD6HTCJW4frq9ELzXSRicqJIWOfhPUEBKWfC4ISqscmHMk9l5j
         zs1Y3R1+JUF4lk8N5KV5y4F6KkEulKdbEg3Nj0WdkY+ZCJrj3H3eHp6plbJ10pLnxp
         NFTP7O6ehUr2AZfKg5jrd/z8cfavE32FftkNPU8vJqrjy7ZtQoAM1a7m7R5MUxnSUU
         dwAB1m4Qpkh1Kl6UQzEbOlz61V8qTK7Gh2ITV4iCKHO+ivZfK45xvCYIyhRZ1AeNqA
         q8nJ+NAsb9Xdw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        reinette.chatre@intel.com, Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] selftests/sgx: Rename 'eenter' and 'sgx_call_vdso'
Date:   Sat,  8 May 2021 06:56:46 +0300
Message-Id: <20210508035648.18176-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename symbols for better clarity:

* 'eenter' -> 'vdso_sgx_enter_enclave'
* 'sgx_call_vdso' -> 'sgx_enter_enclave'

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---

v2:
Refined thh renames just a bit.

 tools/testing/selftests/sgx/call.S |  6 +++---
 tools/testing/selftests/sgx/main.c | 25 +++++++++++++------------
 tools/testing/selftests/sgx/main.h |  4 ++--
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/sgx/call.S b/tools/testing/selftests/sgx/call.S
index 4ecadc7490f4..b09a25890f3b 100644
--- a/tools/testing/selftests/sgx/call.S
+++ b/tools/testing/selftests/sgx/call.S
@@ -5,8 +5,8 @@
 
 	.text
 
-	.global sgx_call_vdso
-sgx_call_vdso:
+	.global sgx_enter_enclave
+sgx_enter_enclave:
 	.cfi_startproc
 	push	%r15
 	.cfi_adjust_cfa_offset	8
@@ -27,7 +27,7 @@ sgx_call_vdso:
 	.cfi_adjust_cfa_offset	8
 	push	0x38(%rsp)
 	.cfi_adjust_cfa_offset	8
-	call	*eenter(%rip)
+	call	*vdso_sgx_enter_enclave(%rip)
 	add	$0x10, %rsp
 	.cfi_adjust_cfa_offset	-0x10
 	pop	%rbx
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index d304a4044eb9..43da68388e25 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -21,7 +21,7 @@
 #include "../kselftest.h"
 
 static const uint64_t MAGIC = 0x1122334455667788ULL;
-vdso_sgx_enter_enclave_t eenter;
+vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
 
 struct vdso_symtab {
 	Elf64_Sym *elf_symtab;
@@ -149,7 +149,7 @@ int main(int argc, char *argv[])
 {
 	struct sgx_enclave_run run;
 	struct vdso_symtab symtab;
-	Elf64_Sym *eenter_sym;
+	Elf64_Sym *sgx_enter_enclave_sym;
 	uint64_t result = 0;
 	struct encl encl;
 	unsigned int i;
@@ -194,29 +194,30 @@ int main(int argc, char *argv[])
 	if (!vdso_get_symtab(addr, &symtab))
 		goto err;
 
-	eenter_sym = vdso_symtab_get(&symtab, "__vdso_sgx_enter_enclave");
-	if (!eenter_sym)
+	sgx_enter_enclave_sym = vdso_symtab_get(&symtab, "__vdso_sgx_enter_enclave");
+	if (!sgx_enter_enclave_sym)
 		goto err;
 
-	eenter = addr + eenter_sym->st_value;
+	vdso_sgx_enter_enclave = addr + sgx_enter_enclave_sym->st_value;
 
-	ret = sgx_call_vdso((void *)&MAGIC, &result, 0, EENTER, NULL, NULL, &run);
-	if (!report_results(&run, ret, result, "sgx_call_vdso"))
+	ret = sgx_enter_enclave((void *)&MAGIC, &result, 0, EENTER,
+					    NULL, NULL, &run);
+	if (!report_results(&run, ret, result, "sgx_enter_enclave_unclobbered"))
 		goto err;
 
 
 	/* Invoke the vDSO directly. */
 	result = 0;
-	ret = eenter((unsigned long)&MAGIC, (unsigned long)&result, 0, EENTER,
-		     0, 0, &run);
-	if (!report_results(&run, ret, result, "eenter"))
+	ret = vdso_sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result,
+				     0, EENTER, 0, 0, &run);
+	if (!report_results(&run, ret, result, "sgx_enter_enclave"))
 		goto err;
 
 	/* And with an exit handler. */
 	run.user_handler = (__u64)user_handler;
 	run.user_data = 0xdeadbeef;
-	ret = eenter((unsigned long)&MAGIC, (unsigned long)&result, 0, EENTER,
-		     0, 0, &run);
+	ret = vdso_sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result,
+				     0, EENTER, 0, 0, &run);
 	if (!report_results(&run, ret, result, "user_handler"))
 		goto err;
 
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index 67211a708f04..68672fd86cf9 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -35,7 +35,7 @@ bool encl_load(const char *path, struct encl *encl);
 bool encl_measure(struct encl *encl);
 bool encl_build(struct encl *encl);
 
-int sgx_call_vdso(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
-		  struct sgx_enclave_run *run);
+int sgx_enter_enclave(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
+		      struct sgx_enclave_run *run);
 
 #endif /* MAIN_H */
-- 
2.31.1

