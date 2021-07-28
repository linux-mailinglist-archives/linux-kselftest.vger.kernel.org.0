Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09713D9912
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 00:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhG1Wvy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 18:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232529AbhG1Wvy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 18:51:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4A916101B;
        Wed, 28 Jul 2021 22:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627512712;
        bh=4dKc/HZAppIt8IkwQuN2ogmAZCk+GY5EwArJF9/nIh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsniZmpND9fcg4YvDXqEUCLFwJ8P0GDpNGnx3zqiQ3JOspOD8CeF/KS/g3+MCE5h/
         veXn58780cwzan/M+7i51d8Q0asJM6AK30YPrX16vMkodI10dr5lmqcXCYmSZ9R5ko
         6C6UE8LQeIG4K+GD9kFb+4mSuXcXtysOKV0778v0hMefl8RPuE/wehvsd5uyt5h/Oq
         CHrBWdkE1eL9HJlh9vVcP43kS/JsoCcmricK9RLyEz2upyglxAd7sSNbJg5PUo0FCN
         2ebnpbcMdxC25qjOeYsOYvR4kl0Qs4WvStWMJ66ucoWps59MBFqJ50LSpD4qxBkkFl
         0DUNo1J3pPm+Q==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] selftests/sgx: Assign source for each segment
Date:   Thu, 29 Jul 2021 01:51:39 +0300
Message-Id: <20210728225140.248408-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210728225140.248408-1-jarkko@kernel.org>
References: <20210728225140.248408-1-jarkko@kernel.org>
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
index 00928be57fc4..9946fab2a3d6 100644
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
@@ -226,6 +226,7 @@ bool encl_load(const char *path, struct encl *encl)
 
 		if (j == 0) {
 			src_offset = phdr->p_offset & PAGE_MASK;
+			encl->src = encl->bin + src_offset;
 
 			seg->prot = PROT_READ | PROT_WRITE;
 			seg->flags = SGX_PAGE_TYPE_TCS << 8;
@@ -238,13 +239,13 @@ bool encl_load(const char *path, struct encl *encl)
 
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

