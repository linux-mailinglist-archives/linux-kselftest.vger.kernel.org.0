Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1043843E9A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 22:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhJ1UkE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 16:40:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:25715 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhJ1UkA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 16:40:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="230775404"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="230775404"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:30 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="498562993"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:29 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com
Cc:     seanjc@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/15] selftests/sgx: Assign source for each segment
Date:   Thu, 28 Oct 2021 13:37:29 -0700
Message-Id: <ca1e02fc9e77fdaf5b6a2b33b462541d099101f3.1635447301.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635447301.git.reinette.chatre@intel.com>
References: <cover.1635447301.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

Define source per segment so that enclave pages can be added from different
sources, e.g. anonymous VMA for zero pages. In other words, add 'src' field
to struct encl_segment, and assign it to 'encl->src' for pages inherited
from the enclave binary.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Add signature from Dave.

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
2.25.1

