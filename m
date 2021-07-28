Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878A43D9913
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 00:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhG1Wv5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 18:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232281AbhG1Wv5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 18:51:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B67A60EFD;
        Wed, 28 Jul 2021 22:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627512715;
        bh=RFdz5NdgktigNk1Z+IYwsFr+Xfnwyf6KGApYnpb/tjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmMAXK7idhXzXWk2J1jhuGo3Ic+sG08jOOJf3DzEUVYaCqh5HPQcNRu2K8lWoGuob
         tkZRbY7DQgBV+bQJVK0QqBARE4d08+PX8uJAxliTYyOps+RPgHgwWEYeyKSC6o3VQe
         J3nZI4gApM3ICS4GqLsP8z1Jh0enePWLT+vDaJDtD9jk7Cua5OaJ6vXEF3zFX9PYgA
         bh4n/vVwb5X8lGcaMuosYxwXEcxnofvCBHeXLPPa8s2kMz0MEDb7jDPQu3WbsOFk5P
         XP3bPXi3ifKAe1M9+hGbFxl/V82yJI/76hNe0kKmc3k7dnUQaGmY3CsWD+D9uwxW+t
         6wjytycKhuuLg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] selftests/sgx: Trigger the reclaimer and #PF handler
Date:   Thu, 29 Jul 2021 01:51:40 +0300
Message-Id: <20210728225140.248408-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210728225140.248408-1-jarkko@kernel.org>
References: <20210728225140.248408-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create a heap for the test enclave, which has the same size as all
available Enclave Page Cache (EPC) pages in the system. This will guarantee
that all test_encl.elf pages *and* SGX Enclave Control Structure (SECS)
have been swapped out by the page reclaimer during the load time. Actually,
this adds a bit more stress than that since part of the EPC gets reserved
for the Version Array (VA) pages.

For each test, the page fault handler gets triggered in two occasions:

- When SGX_IOC_ENCLAVE_INIT is performed, SECS gets swapped in by the
  page fault handler.
- During the execution, each page that is referenced gets swapped in
  by the page fault handler.

In addition, add two new checks:

1. All of the EPC memory must be unused before the test execution
   starts.
2. Before SGX_IOC_ENCLAVE_INIT, the number of free EPC pages must
   be zero.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---

v2:
* sgx_nr_all_pages -> sgx_total_mem

 tools/testing/selftests/sgx/load.c      | 33 +++++++++++++++----
 tools/testing/selftests/sgx/main.c      | 42 ++++++++++++++++++++++++-
 tools/testing/selftests/sgx/main.h      |  3 +-
 tools/testing/selftests/sgx/sigstruct.c |  6 ++--
 4 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 9946fab2a3d6..a312a132ac33 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -21,6 +21,8 @@
 
 void encl_delete(struct encl *encl)
 {
+	struct encl_segment *heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
+
 	if (encl->encl_base)
 		munmap((void *)encl->encl_base, encl->encl_size);
 
@@ -30,6 +32,8 @@ void encl_delete(struct encl *encl)
 	if (encl->fd)
 		close(encl->fd);
 
+	munmap(heap_seg->src, heap_seg->size);
+
 	if (encl->segment_tbl)
 		free(encl->segment_tbl);
 
@@ -111,7 +115,10 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
 	ioc.offset = seg->offset;
 	ioc.length = seg->size;
 	ioc.secinfo = (unsigned long)&secinfo;
-	ioc.flags = SGX_PAGE_MEASURE;
+	if (seg->measure)
+		ioc.flags = SGX_PAGE_MEASURE;
+	else
+		ioc.flags = 0;
 
 	rc = ioctl(encl->fd, SGX_IOC_ENCLAVE_ADD_PAGES, &ioc);
 	if (rc < 0) {
@@ -124,9 +131,10 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
 
 
 
-bool encl_load(const char *path, struct encl *encl)
+bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
 {
 	const char device_path[] = "/dev/sgx_enclave";
+	struct encl_segment *seg;
 	Elf64_Phdr *phdr_tbl;
 	off_t src_offset;
 	Elf64_Ehdr *ehdr;
@@ -188,6 +196,8 @@ bool encl_load(const char *path, struct encl *encl)
 	ehdr = encl->bin;
 	phdr_tbl = encl->bin + ehdr->e_phoff;
 
+	encl->nr_segments = 1; /* one for the heap */
+
 	for (i = 0; i < ehdr->e_phnum; i++) {
 		Elf64_Phdr *phdr = &phdr_tbl[i];
 
@@ -203,7 +213,6 @@ bool encl_load(const char *path, struct encl *encl)
 	for (i = 0, j = 0; i < ehdr->e_phnum; i++) {
 		Elf64_Phdr *phdr = &phdr_tbl[i];
 		unsigned int flags = phdr->p_flags;
-		struct encl_segment *seg;
 
 		if (phdr->p_type != PT_LOAD)
 			continue;
@@ -240,14 +249,26 @@ bool encl_load(const char *path, struct encl *encl)
 		seg->offset = (phdr->p_offset & PAGE_MASK) - src_offset;
 		seg->size = (phdr->p_filesz + PAGE_SIZE - 1) & PAGE_MASK;
 		seg->src = encl->src + seg->offset;
+		seg->measure = true;
 
 		j++;
 	}
 
-	assert(j == encl->nr_segments);
+	assert(j == encl->nr_segments - 1);
+
+	seg = &encl->segment_tbl[j];
+	seg->offset =  encl->segment_tbl[j - 1].offset + encl->segment_tbl[j - 1].size;
+	seg->size = heap_size;
+	seg->src = mmap(NULL, heap_size, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	seg->prot = PROT_READ | PROT_WRITE;
+	seg->flags = (SGX_PAGE_TYPE_REG << 8) | seg->prot;
+	seg->measure = false;
+
+	if (seg->src == MAP_FAILED)
+		goto err;
 
-	encl->src_size = encl->segment_tbl[j - 1].offset +
-			 encl->segment_tbl[j - 1].size;
+	encl->src_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size;
 
 	for (encl->encl_size = 4096; encl->encl_size < encl->src_size; )
 		encl->encl_size <<= 1;
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index e252015e0c15..fec85e1afd60 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -112,17 +112,57 @@ FIXTURE(enclave) {
 	struct sgx_enclave_run run;
 };
 
+#define SGX_TOTAL_MEM_PATH "/sys/kernel/debug/x86/sgx_total_mem"
+
+static int sysfs_get_ulong(const char *path, unsigned long *value)
+{
+	struct stat sbuf;
+	ssize_t ret = 0;
+	char buf[128];
+	int fd;
+
+	ret = stat(path, &sbuf);
+	if (ret)
+		return ret;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	ret = read(fd, buf, sizeof(buf));
+	if (ret < 0)
+		goto out;
+
+	/* Clear the read bytes count. */
+	ret = 0;
+
+	errno = 0;
+	*value = strtoul(buf, NULL, 0);
+	if (errno)
+		ret = -1;
+
+out:
+	close(fd);
+	return ret;
+}
+
 FIXTURE_SETUP(enclave)
 {
 	Elf64_Sym *sgx_enter_enclave_sym = NULL;
 	struct vdso_symtab symtab;
 	struct encl_segment *seg;
+	unsigned long total_mem;
 	char maps_line[256];
 	FILE *maps_file;
 	unsigned int i;
 	void *addr;
+	int ret;
+
+	ret = sysfs_get_ulong(SGX_TOTAL_MEM_PATH, &total_mem);
+	if (ret)
+		ksft_exit_skip("Failed to read " SGX_TOTAL_MEM_PATH "\n");
 
-	if (!encl_load("test_encl.elf", &self->encl)) {
+	if (!encl_load("test_encl.elf", &self->encl, total_mem)) {
 		encl_delete(&self->encl);
 		ksft_exit_skip("cannot load enclaves\n");
 	}
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index 452d11dc4889..a286861dc289 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -12,6 +12,7 @@ struct encl_segment {
 	size_t size;
 	unsigned int prot;
 	unsigned int flags;
+	bool measure;
 };
 
 struct encl {
@@ -32,7 +33,7 @@ extern unsigned char sign_key[];
 extern unsigned char sign_key_end[];
 
 void encl_delete(struct encl *ctx);
-bool encl_load(const char *path, struct encl *encl);
+bool encl_load(const char *path, struct encl *encl, unsigned long heap_size);
 bool encl_measure(struct encl *encl);
 bool encl_build(struct encl *encl);
 
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index 202a96fd81bf..50c5ab1aa6fa 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -296,8 +296,10 @@ static bool mrenclave_segment(EVP_MD_CTX *ctx, struct encl *encl,
 		if (!mrenclave_eadd(ctx, seg->offset + offset, seg->flags))
 			return false;
 
-		if (!mrenclave_eextend(ctx, seg->offset + offset, seg->src + offset))
-			return false;
+		if (seg->measure) {
+			if (!mrenclave_eextend(ctx, seg->offset + offset, seg->src + offset))
+				return false;
+		}
 	}
 
 	return true;
-- 
2.32.0

