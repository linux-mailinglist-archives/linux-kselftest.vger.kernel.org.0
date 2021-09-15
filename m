Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64C40CDFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 22:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhIOUcf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 16:32:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:13811 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231863AbhIOUce (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 16:32:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286109362"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="286109362"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:14 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545092776"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:13 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     linux-sgx@vger.kernel.org, jarkko@kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] selftests/sgx: Make data measurement for an enclave segment optional
Date:   Wed, 15 Sep 2021 13:30:54 -0700
Message-Id: <e472d57df58916f88a9a59ca1343204c2f2a9ad9.1631731214.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

For a heap makes sense to leave its contents "unmeasured" in the SGX
enclave build process, meaning that they won't contribute to the
cryptographic signature (a RSA-3072 signed SHA56 hash) of the enclave.

Enclaves are signed blobs where the signature is calculated both from
page data and also from "structural properties" of the pages.  For
instance a page offset of *every* page added to the enclave is hashed.

For data, this is optional, not least because hashing a page has a
significant contribution to the enclave load time. Thus, where there is
no reason to hash, do not. The SGX ioctl interface supports this with
SGX_PAGE_MEASURE flag. Only when the flag is *set*, data is measured.

Add seg->measure boolean flag to struct encl_segment. Only when the
flag is set, include the segment data to the signature (represented
by SIGSTRUCT architectural structure).

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/load.c      | 6 +++++-
 tools/testing/selftests/sgx/main.h      | 1 +
 tools/testing/selftests/sgx/sigstruct.c | 6 ++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 5605474aab73..f1be78984c50 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -111,7 +111,10 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
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
@@ -230,6 +233,7 @@ bool encl_load(const char *path, struct encl *encl)
 		seg->offset = (phdr->p_offset & PAGE_MASK) - src_offset;
 		seg->size = (phdr->p_filesz + PAGE_SIZE - 1) & PAGE_MASK;
 		seg->src = encl->src + seg->offset;
+		seg->measure = true;
 
 		j++;
 	}
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index 452d11dc4889..aebc69e7cdc8 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -12,6 +12,7 @@ struct encl_segment {
 	size_t size;
 	unsigned int prot;
 	unsigned int flags;
+	bool measure;
 };
 
 struct encl {
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
2.25.1

