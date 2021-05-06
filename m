Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988B7374CE1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 May 2021 03:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhEFBdO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 May 2021 21:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhEFBdN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 May 2021 21:33:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 924F36139A;
        Thu,  6 May 2021 01:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620264736;
        bh=1xn40oQKUVwuTZyaZSO40QqkHHGTwn9D+xdZOmEckzU=;
        h=From:To:Cc:Subject:Date:From;
        b=oUcy/DaH57sYVYz+CNC2vAcDU14jVTt5wtNG8jvdUx6a/pyHxqo03FQPbaHPbPEN0
         RHjdntUCFmJwoGZiAtitMEHtTdBi1zsfHxdjUqeYik2niogqluAClU4Clz2NvhFi7P
         fuPd5QaB+U0vOpQ1I0G3ZkH4zBgVKDjjZ+YyZFMU9QdtjDtRImRueELQXSDtDM/x0E
         oZQ7nWs0c5W+j4+MBpaLjXjy7soUrdYLx2dVxLSKgTHr50ikXItvX9Yx65SNH0bBG3
         sHsc+yzHuPJY52861ZTo64bkk+Y5sZqnzKTYetDIlpqlACuLXvvyPFmFYhwB7ZAdC7
         SZH13mvUXQ58Q==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-sgx@vger.kernel.org, dave.hansen@intel.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests/sgx: Rename 'eenter' and 'sgx_call_vdso'
Date:   Thu,  6 May 2021 04:31:59 +0300
Message-Id: <20210506013201.126612-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename 'eenter' as 'sgx_enter_enclave', and 'sgx_call_vdso' as
'sgx_enter_enclave_unclobbered', in order to better self-describe the
meaning and purpose of the symbols.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/call.S |  6 +++---
 tools/testing/selftests/sgx/main.c | 25 +++++++++++++------------
 tools/testing/selftests/sgx/main.h |  4 ++--
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/sgx/call.S b/tools/testing/selftests/sgx/call.S
index 4ecadc7490f4..71865302119c 100644
--- a/tools/testing/selftests/sgx/call.S
+++ b/tools/testing/selftests/sgx/call.S
@@ -5,8 +5,8 @@
 
 	.text
 
-	.global sgx_call_vdso
-sgx_call_vdso:
+	.global sgx_enter_enclave_unclobbered
+sgx_enter_enclave_unclobbered:
 	.cfi_startproc
 	push	%r15
 	.cfi_adjust_cfa_offset	8
@@ -27,7 +27,7 @@ sgx_call_vdso:
 	.cfi_adjust_cfa_offset	8
 	push	0x38(%rsp)
 	.cfi_adjust_cfa_offset	8
-	call	*eenter(%rip)
+	call	*sgx_enter_enclave(%rip)
 	add	$0x10, %rsp
 	.cfi_adjust_cfa_offset	-0x10
 	pop	%rbx
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index d304a4044eb9..d3e1db9ee4bc 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -21,7 +21,7 @@
 #include "../kselftest.h"
 
 static const uint64_t MAGIC = 0x1122334455667788ULL;
-vdso_sgx_enter_enclave_t eenter;
+vdso_sgx_enter_enclave_t sgx_enter_enclave;
 
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
+	sgx_enter_enclave = addr + sgx_enter_enclave_sym->st_value;
 
-	ret = sgx_call_vdso((void *)&MAGIC, &result, 0, EENTER, NULL, NULL, &run);
-	if (!report_results(&run, ret, result, "sgx_call_vdso"))
+	ret = sgx_enter_enclave_unclobbered((void *)&MAGIC, &result, 0, EENTER,
+					    NULL, NULL, &run);
+	if (!report_results(&run, ret, result, "sgx_enter_enclave_unclobbered"))
 		goto err;
 
 
 	/* Invoke the vDSO directly. */
 	result = 0;
-	ret = eenter((unsigned long)&MAGIC, (unsigned long)&result, 0, EENTER,
-		     0, 0, &run);
-	if (!report_results(&run, ret, result, "eenter"))
+	ret = sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result,
+				0, EENTER, 0, 0, &run);
+	if (!report_results(&run, ret, result, "sgx_enter_enclave"))
 		goto err;
 
 	/* And with an exit handler. */
 	run.user_handler = (__u64)user_handler;
 	run.user_data = 0xdeadbeef;
-	ret = eenter((unsigned long)&MAGIC, (unsigned long)&result, 0, EENTER,
-		     0, 0, &run);
+	ret = sgx_enter_enclave((unsigned long)&MAGIC, (unsigned long)&result,
+				0, EENTER, 0, 0, &run);
 	if (!report_results(&run, ret, result, "user_handler"))
 		goto err;
 
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index 67211a708f04..13479837f6eb 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -35,7 +35,7 @@ bool encl_load(const char *path, struct encl *encl);
 bool encl_measure(struct encl *encl);
 bool encl_build(struct encl *encl);
 
-int sgx_call_vdso(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
-		  struct sgx_enclave_run *run);
+int sgx_enter_enclave_unclobbered(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
+				  struct sgx_enclave_run *run);
 
 #endif /* MAIN_H */
-- 
2.31.1

