Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EADC3A2707
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 10:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhFJIc3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 04:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhFJIcZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 04:32:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99F78613E7;
        Thu, 10 Jun 2021 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623313828;
        bh=EPv1u0azdmPO9qKoh7wx6ebVCAg50T2BxrxpYsroTDs=;
        h=From:To:Cc:Subject:Date:From;
        b=cF/0TWbmXLVuj6kyEF3W6yEHcuB588GmlouBQa367GgnKoKjqv6O4nJsJ0wXNq4eG
         6jglQmetD0sdglyVBu/7TrU8LO8iNbt++ts9PjsGYbm7OCo9n89LnWqsVy3nznnTiC
         M4I460Qjw3sjumcrWaBJyNhNjMHrH0Wd/WaC1iqvqgc3Jjs49raIviQtqIixZjJe5b
         F5Ui6oQuxq9cwdi5kbn78z5Q5DpV2QmwgOYZcU3Sz3642OS3ZtLe6O9qNKR6XELvZr
         a53LbOPEAt+2dqcR3HU0ST+c8UAs4JhBpqyh74YqZUDu3wxV7D+ce3bZXZurgd9dCg
         sbUwHqlPoT0oQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/5] selftests/sgx: Rename 'eenter' and 'sgx_call_vdso'
Date:   Thu, 10 Jun 2021 11:30:17 +0300
Message-Id: <20210610083021.392269-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename symbols for better clarity:

* 'eenter' might be confused for directly calling ENCLU[EENTER].  It does
  not.  It calls into the VDSO, which actually has the EENTER instruction.
* 'sgx_call_vdso' is *only* used for entering the enclave.  It's not some
  generic SGX call into the VDSO.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---

v3:
Refine the commit message according to Dave's suggestions.

v2:
Refined the renames just a bit.

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

