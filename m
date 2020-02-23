Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5C31698F1
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Feb 2020 18:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBWR3A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Feb 2020 12:29:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:48896 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgBWR27 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Feb 2020 12:28:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 09:28:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,476,1574150400"; 
   d="scan'208";a="229650308"
Received: from ajbergin-mobl.ger.corp.intel.com (HELO localhost) ([10.252.23.203])
  by fmsmga007.fm.intel.com with ESMTP; 23 Feb 2020 09:28:52 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v27 20/22] selftests/x86: Add vDSO selftest for SGX
Date:   Sun, 23 Feb 2020 19:25:57 +0200
Message-Id: <20200223172559.6912-21-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223172559.6912-1-jarkko.sakkinen@linux.intel.com>
References: <20200223172559.6912-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Expand the selftest by invoking the enclave by using
__vdso_sgx_enter_enclave() in addition to direct ENCLS[EENTER].

Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 tools/testing/selftests/x86/sgx/main.c     | 132 +++++++++++++++++++++
 tools/testing/selftests/x86/sgx/sgx_call.S |  43 +++++++
 tools/testing/selftests/x86/sgx/sgx_call.h |   3 +
 3 files changed, 178 insertions(+)

diff --git a/tools/testing/selftests/x86/sgx/main.c b/tools/testing/selftests/x86/sgx/main.c
index 48ed5fdfb3cb..d97cc3cf0093 100644
--- a/tools/testing/selftests/x86/sgx/main.c
+++ b/tools/testing/selftests/x86/sgx/main.c
@@ -21,6 +21,109 @@
 #define PAGE_SIZE  4096
 
 static const uint64_t MAGIC = 0x1122334455667788ULL;
+void *eenter;
+
+struct vdso_symtab {
+	Elf64_Sym *elf_symtab;
+	const char *elf_symstrtab;
+	Elf64_Word *elf_hashtab;
+};
+
+static void *vdso_get_base_addr(char *envp[])
+{
+	Elf64_auxv_t *auxv;
+	int i;
+
+	for (i = 0; envp[i]; i++)
+		;
+
+	auxv = (Elf64_auxv_t *)&envp[i + 1];
+
+	for (i = 0; auxv[i].a_type != AT_NULL; i++) {
+		if (auxv[i].a_type == AT_SYSINFO_EHDR)
+			return (void *)auxv[i].a_un.a_val;
+	}
+
+	return NULL;
+}
+
+static Elf64_Dyn *vdso_get_dyntab(void *addr)
+{
+	Elf64_Ehdr *ehdr = addr;
+	Elf64_Phdr *phdrtab = addr + ehdr->e_phoff;
+	int i;
+
+	for (i = 0; i < ehdr->e_phnum; i++)
+		if (phdrtab[i].p_type == PT_DYNAMIC)
+			return addr + phdrtab[i].p_offset;
+
+	return NULL;
+}
+
+static void *vdso_get_dyn(void *addr, Elf64_Dyn *dyntab, Elf64_Sxword tag)
+{
+	int i;
+
+	for (i = 0; dyntab[i].d_tag != DT_NULL; i++)
+		if (dyntab[i].d_tag == tag)
+			return addr + dyntab[i].d_un.d_ptr;
+
+	return NULL;
+}
+
+static bool vdso_get_symtab(void *addr, struct vdso_symtab *symtab)
+{
+	Elf64_Dyn *dyntab = vdso_get_dyntab(addr);
+
+	symtab->elf_symtab = vdso_get_dyn(addr, dyntab, DT_SYMTAB);
+	if (!symtab->elf_symtab)
+		return false;
+
+	symtab->elf_symstrtab = vdso_get_dyn(addr, dyntab, DT_STRTAB);
+	if (!symtab->elf_symstrtab)
+		return false;
+
+	symtab->elf_hashtab = vdso_get_dyn(addr, dyntab, DT_HASH);
+	if (!symtab->elf_hashtab)
+		return false;
+
+	return true;
+}
+
+static unsigned long elf_sym_hash(const char *name)
+{
+	unsigned long h = 0, high;
+
+	while (*name) {
+		h = (h << 4) + *name++;
+		high = h & 0xf0000000;
+
+		if (high)
+			h ^= high >> 24;
+
+		h &= ~high;
+	}
+
+	return h;
+}
+
+static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
+{
+	Elf64_Word bucketnum = symtab->elf_hashtab[0];
+	Elf64_Word *buckettab = &symtab->elf_hashtab[2];
+	Elf64_Word *chaintab = &symtab->elf_hashtab[2 + bucketnum];
+	Elf64_Sym *sym;
+	Elf64_Word i;
+
+	for (i = buckettab[elf_sym_hash(name) % bucketnum]; i != STN_UNDEF;
+	     i = chaintab[i]) {
+		sym = &symtab->elf_symtab[i];
+		if (!strcmp(name, &symtab->elf_symstrtab[sym->st_name]))
+			return sym;
+	}
+
+	return NULL;
+}
 
 static bool encl_create(int dev_fd, unsigned long bin_size,
 			struct sgx_secs *secs)
@@ -218,10 +321,14 @@ bool load_sigstruct(const char *path, void *sigstruct)
 
 int main(int argc, char *argv[], char *envp[])
 {
+	struct sgx_enclave_exception exception;
 	struct sgx_sigstruct sigstruct;
+	struct vdso_symtab symtab;
+	Elf64_Sym *eenter_sym;
 	struct sgx_secs secs;
 	uint64_t result = 0;
 	off_t bin_size;
+	void *addr;
 	void *bin;
 
 	if (!encl_data_map("encl.bin", &bin, &bin_size))
@@ -243,5 +350,30 @@ int main(int argc, char *argv[], char *envp[])
 
 	printf("Output: 0x%lx\n", result);
 
+	memset(&exception, 0, sizeof(exception));
+
+	addr = vdso_get_base_addr(envp);
+	if (!addr)
+		exit(1);
+
+	if (!vdso_get_symtab(addr, &symtab))
+		exit(1);
+
+	eenter_sym = vdso_symtab_get(&symtab, "__vdso_sgx_enter_enclave");
+	if (!eenter_sym)
+		exit(1);
+	eenter = addr + eenter_sym->st_value;
+
+	printf("Input: 0x%lx\n", MAGIC);
+
+	sgx_call_vdso((void *)&MAGIC, &result, 0, NULL, NULL, NULL,
+		      (void *)secs.base, &exception, NULL);
+	if (result != MAGIC) {
+		fprintf(stderr, "0x%lx != 0x%lx\n", result, MAGIC);
+		exit(1);
+	}
+
+	printf("Output: 0x%lx\n", result);
+
 	exit(0);
 }
diff --git a/tools/testing/selftests/x86/sgx/sgx_call.S b/tools/testing/selftests/x86/sgx/sgx_call.S
index ca4c7893f9d9..e71f44f7a995 100644
--- a/tools/testing/selftests/x86/sgx/sgx_call.S
+++ b/tools/testing/selftests/x86/sgx/sgx_call.S
@@ -21,3 +21,46 @@ sgx_async_exit:
 	ENCLU
 	pop	%rbx
 	ret
+
+	.global sgx_call_vdso
+sgx_call_vdso:
+	.cfi_startproc
+	push	%r15
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%r15, 0
+	push	%r14
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%r14, 0
+	push	%r13
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%r13, 0
+	push	%r12
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%r12, 0
+	push	%rbx
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%rbx, 0
+	push	$0
+	.cfi_adjust_cfa_offset	8
+	push	0x48(%rsp)
+	.cfi_adjust_cfa_offset	8
+	push	0x48(%rsp)
+	.cfi_adjust_cfa_offset	8
+	push	0x48(%rsp)
+	.cfi_adjust_cfa_offset	8
+	mov	$2, %eax
+	call	*eenter(%rip)
+	add	$0x20, %rsp
+	.cfi_adjust_cfa_offset	-0x20
+	pop	%rbx
+	.cfi_adjust_cfa_offset	-8
+	pop	%r12
+	.cfi_adjust_cfa_offset	-8
+	pop	%r13
+	.cfi_adjust_cfa_offset	-8
+	pop	%r14
+	.cfi_adjust_cfa_offset	-8
+	pop	%r15
+	.cfi_adjust_cfa_offset	-8
+	ret
+	.cfi_endproc
diff --git a/tools/testing/selftests/x86/sgx/sgx_call.h b/tools/testing/selftests/x86/sgx/sgx_call.h
index bf72068ada23..a4072c5ecce7 100644
--- a/tools/testing/selftests/x86/sgx/sgx_call.h
+++ b/tools/testing/selftests/x86/sgx/sgx_call.h
@@ -8,4 +8,7 @@
 
 void sgx_call_eenter(void *rdi, void *rsi, void *entry);
 
+int sgx_call_vdso(void *rdi, void *rsi, long rdx, void *rcx, void *r8, void *r9,
+		  void *tcs, struct sgx_enclave_exception *ei, void *cb);
+
 #endif /* SGX_CALL_H */
-- 
2.20.1

