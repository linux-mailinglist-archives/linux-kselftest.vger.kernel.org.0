Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550C33E42B3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Aug 2021 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhHIJcF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 05:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234375AbhHIJcD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 05:32:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E836061056;
        Mon,  9 Aug 2021 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628501503;
        bh=BnQTvsR4vQ50eHLG1KZBQd1nNSSzVndxngtFP2th434=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gs20PztHuc1ec8Hpy/+KiVArX0h2KS37iguWc3ax7tDh2LMJoTbX5F08ftVm/ApTN
         Uc8Bp/5vyMrEV+h/d4y383ycEVBZADeSlg7YE0lcwYvIzLvUvT0jl7/AV7Thktnkx4
         WDsqlQSYgunqSm3i9Of9LYafJK0YO9ktbvhuk/aXpjbEorCSFTeCbILFMKoboJKKGd
         h/c+ekfTONgY37HjjjNmCWswFjVLFfdUmzqjjYnidNsiZ1jBY665VAA3PyH3n5h5sV
         LFT25jQESQjjWIchlle+8bptHO8kBIm1kaY+XUiNypK9xM3Y8cJ+eOXfkV+ALOu8Se
         dj1fN2s1sf4Gg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] selftests/sgx: Make data measurement for an enclave segment optional
Date:   Mon,  9 Aug 2021 12:31:22 +0300
Message-Id: <20210809093127.76264-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809093127.76264-1-jarkko@kernel.org>
References: <20210809093127.76264-1-jarkko@kernel.org>
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

