Return-Path: <linux-kselftest+bounces-24149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DF8A07F03
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19837188D6CF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9DF1FECCE;
	Thu,  9 Jan 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="UQ3swVZv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E519D07A;
	Thu,  9 Jan 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444400; cv=pass; b=X4hF/Y1NPGBMtZ4Vj+ZMogCicoe6oqw+lMEJypUdlU/kaxORA/aCUyrjJbl4Hxi54BtaImughsepLDwrDimMApR4m9mXDewmocrIj0jgfMaCXyqFsUP9m4mWCsmjrOmJKs3Wce2M0tEcTgHD0EgBxe2oDW1nd9HrvD6S1FUYX8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444400; c=relaxed/simple;
	bh=Xv25IT5hltGS0rQXrYFy+xkFP4o+4H/DLa2ogsYrUZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h557VQ7QTNQELV+qh/clX8MXdSCHDhYVXRPbzpPoGD4yDbYebnBfMIxjCcVd9yMffXc9MDiwGsGIrWq9halGaoQKPMcGOj8/VAwHq03iEi+yOTDtvlLMCgLD+ENL1/kStQ/GvDII1Jw4o+lL9gwL/18JdDIM/laYQQOCy12Sol0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=UQ3swVZv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444384; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PHb8dCW9PsSrkgiVvy89CX6NtRRSc5wJyJpqofaA9Dm9uTekK3hmP66n8zHmSXHaLwXdnsfJrZSi1lb2CgfN/56gU4Ldb0pz7NymDHXvtk2CwX5+fv/hilL3lnzaYdgWheqFhhbo+id4bokFtW+lmDgoLVZVQkk6BmY6NqB/c58=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444384; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cUnEN6YUpTMMgOpnHZpEAdwLBYl8OGrY4+GN/GOq3J8=; 
	b=U3qhjteAQzwH/C2ZCdDKiIb4CM/PFVYxhZ7tHLLsitY0XLdGkKQopA+BIb2ltOTCFS49X776Q+777LD8rw4E00V+8KsmovQpxFpm5Kk2X67IVN7sRIbG/RjYBtjoVH6/ysbjS6GFaFeu6X7NS1PUXHkYrOBqkD9OXKCAU+fJh+g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444384;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=cUnEN6YUpTMMgOpnHZpEAdwLBYl8OGrY4+GN/GOq3J8=;
	b=UQ3swVZvqhbr8qX8U+H5z1BO9RPCr4yETMNjAHOUT7lN3IGgsnEudIoj+S4145Pj
	shouJU/NVGZtxN/HmJ7FskpjssHRat7nBX50KjAcvWfno+eXQtCwc0HS9SYWUVkvgZF
	j4Sg2EPiAvoUzvP7h5OGLApi6fVsywicPRqBiaRs=
Received: by mx.zohomail.com with SMTPS id 1736444383262634.9970969812879;
	Thu, 9 Jan 2025 09:39:43 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 11/16] selftests/mm: hugetlb-read-hwpoison: Fix type mismatch warnings
Date: Thu,  9 Jan 2025 22:38:37 +0500
Message-Id: <20250109173842.1142376-12-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix type mismatch warnings.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/hugetlb-read-hwpoison.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
index ba6cc6f9cabcd..e2a2bb1989d58 100644
--- a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
+++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
@@ -72,7 +72,7 @@ static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
 {
 	char buf[MAX_WRITE_READ_CHUNK_SIZE];
 	ssize_t ret_count = 0;
-	ssize_t total_ret_count = 0;
+	size_t total_ret_count = 0;
 	char val = offset / wr_chunk_size + offset % wr_chunk_size;
 
 	printf(PREFIX PREFIX "init val=%u with offset=0x%lx\n", val, offset);
@@ -83,7 +83,7 @@ static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
 		return false;
 	}
 
-	while (offset + total_ret_count < len) {
+	while ((unsigned long)offset + total_ret_count < len) {
 		ret_count = read(fd, buf, wr_chunk_size);
 		if (ret_count == 0) {
 			printf(PREFIX PREFIX "read reach end of the file\n");
@@ -109,7 +109,7 @@ static bool read_hugepage_filemap(int fd, size_t len,
 {
 	char buf[MAX_WRITE_READ_CHUNK_SIZE];
 	ssize_t ret_count = 0;
-	ssize_t total_ret_count = 0;
+	size_t total_ret_count = 0;
 	char val = 0;
 
 	printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
-- 
2.39.5


