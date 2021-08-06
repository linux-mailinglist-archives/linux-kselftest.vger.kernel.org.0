Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A983E1FDC
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 02:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbhHFARf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 20:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236860AbhHFARd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 20:17:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B21F61165;
        Fri,  6 Aug 2021 00:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628209038;
        bh=BnQTvsR4vQ50eHLG1KZBQd1nNSSzVndxngtFP2th434=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2OojP27JnfTt3KWhgc4gFgRTIMPgIDwOdA1bJI8L6LBFicQsdSNRqhpM5TTxBQ87
         tUlfsYHMbob+KDGsCCJyseL/OnfGuY9vHQJoKbRgN+/tb269ScdXsP9MCFYAC5EMSe
         tBhRUrjvu3k+Is4wSErC6Wm07xudsMu6IvWm2PufRAZXtHbHSrWtSZ4Uu/UFvtvoxR
         G2aXYCJ38v6rIh1jmj9UPKg7A0FCb5CR1TCHoaLoGthW1ReazZz4j7D+rO/eqft3aN
         zuFHumLD8FPMtwsjf0643zcpt/fJVQfYcuwW7BaSp2fztG9jU8JE/08VWMYHytEMIm
         kKtJYwTMR+LRw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] selftests/sgx: Make data measurement for an enclave segment optional
Date:   Fri,  6 Aug 2021 03:16:59 +0300
Message-Id: <20210806001704.667889-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806001704.667889-1-jarkko@kernel.org>
References: <20210806001704.667889-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
2.32.0

