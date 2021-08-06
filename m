Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF613E1FD9
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 02:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhHFARb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 20:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235872AbhHFARb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 20:17:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73A0E61165;
        Fri,  6 Aug 2021 00:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628209036;
        bh=26Mke/ZG9UNwcz+wcy8EloekYjH8aivYrRzQOW/SWCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGHT7o3LVUjq62qwaFfZvP5ySCzfF/XpIfNIF0I5g7GyDm1vRgsWof03ugCtM7vYs
         jskotXbKrDOUQTp+D7D0XnkLOrPLhASA9fszP3aAWEwW6I1Uk2O7Yt7VoPwM9+5JOL
         pZjC/9sHTIMpZcqcvPg68AYv9qvmkxoi90dc4r3A3b+fcRvqMtEJJyBBPhk4Yg4neu
         D+KyTfAp2KCmdOm6J+B0owH9j3X3rA6nDq3XkdQrGYIHkEGqZkRSPXr73sUaZtBO3A
         plJhF85xMlBGf9d8mnq9uHY/kKOa/t9L4pSfg5Qa1IRkqpKNh8JC3/OeRJMaeOsKDb
         uVGcn06d6Wg6w==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] selftests/sgx: Assign source for each segment
Date:   Fri,  6 Aug 2021 03:16:58 +0300
Message-Id: <20210806001704.667889-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806001704.667889-1-jarkko@kernel.org>
References: <20210806001704.667889-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Define source per segment so that enclave pages can be added from different
sources, e.g. anonymous VMA for zero pages. In other words, add 'src' field
to struct encl_segment, and assign it to 'encl->src' for pages inherited
from the enclave binary.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/load.c      | 5 +++--
 tools/testing/selftests/sgx/main.h      | 1 +
 tools/testing/selftests/sgx/sigstruct.c | 8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 3ebe5d1fe337..5605474aab73 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -107,7 +107,7 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
 	memset(&secinfo, 0, sizeof(secinfo));
 	secinfo.flags = seg->flags;
 
-	ioc.src = (uint64_t)encl->src + seg->offset;
+	ioc.src = (uint64_t)seg->src;
 	ioc.offset = seg->offset;
 	ioc.length = seg->size;
 	ioc.secinfo = (unsigned long)&secinfo;
@@ -216,6 +216,7 @@ bool encl_load(const char *path, struct encl *encl)
 
 		if (j == 0) {
 			src_offset = phdr->p_offset & PAGE_MASK;
+			encl->src = encl->bin + src_offset;
 
 			seg->prot = PROT_READ | PROT_WRITE;
 			seg->flags = SGX_PAGE_TYPE_TCS << 8;
@@ -228,13 +229,13 @@ bool encl_load(const char *path, struct encl *encl)
 
 		seg->offset = (phdr->p_offset & PAGE_MASK) - src_offset;
 		seg->size = (phdr->p_filesz + PAGE_SIZE - 1) & PAGE_MASK;
+		seg->src = encl->src + seg->offset;
 
 		j++;
 	}
 
 	assert(j == encl->nr_segments);
 
-	encl->src = encl->bin + src_offset;
 	encl->src_size = encl->segment_tbl[j - 1].offset +
 			 encl->segment_tbl[j - 1].size;
 
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index 68672fd86cf9..452d11dc4889 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -7,6 +7,7 @@
 #define MAIN_H
 
 struct encl_segment {
+	void *src;
 	off_t offset;
 	size_t size;
 	unsigned int prot;
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index 92bbc5a15c39..202a96fd81bf 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -289,14 +289,14 @@ static bool mrenclave_eextend(EVP_MD_CTX *ctx, uint64_t offset,
 static bool mrenclave_segment(EVP_MD_CTX *ctx, struct encl *encl,
 			      struct encl_segment *seg)
 {
-	uint64_t end = seg->offset + seg->size;
+	uint64_t end = seg->size;
 	uint64_t offset;
 
-	for (offset = seg->offset; offset < end; offset += PAGE_SIZE) {
-		if (!mrenclave_eadd(ctx, offset, seg->flags))
+	for (offset = 0; offset < end; offset += PAGE_SIZE) {
+		if (!mrenclave_eadd(ctx, seg->offset + offset, seg->flags))
 			return false;
 
-		if (!mrenclave_eextend(ctx, offset, encl->src + offset))
+		if (!mrenclave_eextend(ctx, seg->offset + offset, seg->src + offset))
 			return false;
 	}
 
-- 
2.32.0

