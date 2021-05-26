Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94457390FBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 06:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhEZEs1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 00:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhEZEs1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 00:48:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 881AA61378;
        Wed, 26 May 2021 04:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622004416;
        bh=EPv1u0azdmPO9qKoh7wx6ebVCAg50T2BxrxpYsroTDs=;
        h=From:To:Cc:Subject:Date:From;
        b=BH1lkpU0C5RayPE9bRpySSlxO3WFhg3zxGtmN1bEei8wjYZz50C9I1i4xGXD4k2XM
         N7eFSa3KOehVawgdSGWbc+yT9GhQkVEBLRItaY1+KO1hVeQwNkPFyweTE/oHOdwro7
         Pw3cZRtNvxBG6jjWJrK5NGKHnKZouSD4lGdw3rXoFAiwEUMTAJ2ESjgKP1WgbPBMJ8
         mBaSlQUZrlOf9BbiPhakAb8NosAWqCUFkA9X0s0DhrLqI/mFEdY1ES2IQEvk364J04
         O1n4izL3a88XFWOTmhYQF+QiI1kUeQIv/ToC1BPv17/5Q0NqOQJlBy2w+aaPAsPRiu
         eowmRsPmEx7Tw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] selftests/sgx: Rename 'eenter' and 'sgx_call_vdso'
Date:   Wed, 26 May 2021 07:46:47 +0300
Message-Id: <20210526044649.988789-1-jarkko@kernel.org>
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

