Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75F13E1FDE
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 02:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhHFARh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 20:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237202AbhHFARg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 20:17:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B912461165;
        Fri,  6 Aug 2021 00:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628209041;
        bh=sjoLOXtZc/fv3DwqCy5FArSUbVd9Q00sCNboj5j9OEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNK5fEbtFdsDQp/b4BcvRNR12CEZosuhOTJP+AhMb68cCooMLxtPB4gNYM338rOyR
         +tG3HNeVo5latY8S8lMtL5AdCrWzD8nzqzZQHDVOPQB7cz2kSQEeCuuU7XHHGo9CSi
         u6GoPt04wX1KjfyZSjvYzP3A8MR0AiDLdI+MG9OzbqIeWzO/DJA773SQl9P0ZsAied
         vE2V7qCYiz/8ddWBLuya+0TqpNu8BCvjIh+2xsWLA15IciXUjVHg7/7CcHDkjcJif0
         54Zl1X9Ubqrnxr3ZilCZ7+NIKsofV1+WRSNnYXF0fvW4SrjwyovmBOP/H2z7ZHQdVQ
         A+OMjCf/6vLPA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] selftests/sgx: Create a heap for the test enclave
Date:   Fri,  6 Aug 2021 03:17:00 +0300
Message-Id: <20210806001704.667889-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806001704.667889-1-jarkko@kernel.org>
References: <20210806001704.667889-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create a heap for the test enclave, which is allocated from /dev/null,
and left unmeasured. This is beneficial by its own because it verifies
that an enclave built from multiple choices, works properly. If LSM
hooks are added for SGX some day, a multi source enclave has higher
probability to trigger bugs on access control checks.

The immediate need comes from the need to implement page reclaim tests.
In order to trigger the page reclaimer, one can just set the size of
the heap to high enough.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/load.c | 29 ++++++++++++++++++++++-------
 tools/testing/selftests/sgx/main.c |  2 +-
 tools/testing/selftests/sgx/main.h |  4 +++-
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index f1be78984c50..9d4322c946e2 100644
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
 
@@ -125,11 +129,10 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
 	return true;
 }
 
-
-
-bool encl_load(const char *path, struct encl *encl)
+bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
 {
 	const char device_path[] = "/dev/sgx_enclave";
+	struct encl_segment *seg;
 	Elf64_Phdr *phdr_tbl;
 	off_t src_offset;
 	Elf64_Ehdr *ehdr;
@@ -181,6 +184,8 @@ bool encl_load(const char *path, struct encl *encl)
 	ehdr = encl->bin;
 	phdr_tbl = encl->bin + ehdr->e_phoff;
 
+	encl->nr_segments = 1; /* one for the heap */
+
 	for (i = 0; i < ehdr->e_phnum; i++) {
 		Elf64_Phdr *phdr = &phdr_tbl[i];
 
@@ -196,7 +201,6 @@ bool encl_load(const char *path, struct encl *encl)
 	for (i = 0, j = 0; i < ehdr->e_phnum; i++) {
 		Elf64_Phdr *phdr = &phdr_tbl[i];
 		unsigned int flags = phdr->p_flags;
-		struct encl_segment *seg;
 
 		if (phdr->p_type != PT_LOAD)
 			continue;
@@ -238,10 +242,21 @@ bool encl_load(const char *path, struct encl *encl)
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
index e252015e0c15..6858a35fed20 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -122,7 +122,7 @@ FIXTURE_SETUP(enclave)
 	unsigned int i;
 	void *addr;
 
-	if (!encl_load("test_encl.elf", &self->encl)) {
+	if (!encl_load("test_encl.elf", &self->encl, ENCL_HEAP_SIZE_DEFAULT)) {
 		encl_delete(&self->encl);
 		ksft_exit_skip("cannot load enclaves\n");
 	}
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index aebc69e7cdc8..b45c52ec7ab3 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -6,6 +6,8 @@
 #ifndef MAIN_H
 #define MAIN_H
 
+#define ENCL_HEAP_SIZE_DEFAULT	4096
+
 struct encl_segment {
 	void *src;
 	off_t offset;
@@ -33,7 +35,7 @@ extern unsigned char sign_key[];
 extern unsigned char sign_key_end[];
 
 void encl_delete(struct encl *ctx);
-bool encl_load(const char *path, struct encl *encl);
+bool encl_load(const char *path, struct encl *encl, unsigned long heap_size);
 bool encl_measure(struct encl *encl);
 bool encl_build(struct encl *encl);
 
-- 
2.32.0

