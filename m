Return-Path: <linux-kselftest+bounces-3839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B247D84414C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC79288A24
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549784A29;
	Wed, 31 Jan 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wPNX67SU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1A83CD8;
	Wed, 31 Jan 2024 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709934; cv=none; b=X2ghvwgc210EjpdSSl8hUj8OWVJ5u3Ja0tx6kIvak39T77CKid4P6hJUFOwpVilhpxnWvz8GCDrdmeHnrQ3PQv1AjLC+iq608iDFqRS8lqPz6HvNqq6oC1XaDU3s+Jw0Qi80UhhXaDKsXFniax468PD9frxDC8d+9oYFoicVta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709934; c=relaxed/simple;
	bh=SKE8pMm9wj80+Eluj9OfOxnVYjWtsY8duRngXOEJh3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7+TYORpRdXgC9xEapEqGVMkCxje1u3KXBpHG941fOt9n8klu0mopLZSzexNvKZ4PJ/HXqlKAo24ocaKxvLXDt6cStRXrI0ayAo40sn1MNZxsn2SgGgdOBbl2AGhQJwRg/aIMW/DReT69N8wDKwYOK3+o+dNifzgFNEma7LSjkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wPNX67SU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706709930;
	bh=SKE8pMm9wj80+Eluj9OfOxnVYjWtsY8duRngXOEJh3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wPNX67SUgEQLlZYrDr/wsFSlH2sQMpKUAAIRr9G3b8rq+a+FnMRWIbkXpYE0dec8w
	 OCJ6rjTSn3Qv0BcCVx2GiSHbGl9B356zAqlDkgn8hCeAagZEatvImz3P9JFv1f61JV
	 Z4t4VdwkAQanripUhgj7f42vjYCXsjA3u1vMrz9ZAdHn1pvHwvb2h66pIkyqvbfyWM
	 YfM3iLrHOV4U/RXAKUFFsrvlqh8eWd3lpbac8DVkKOKoMaQwY6YnjTpgC3pUBiJ+f0
	 JDkQeAuzTmshNFYaErn0KJl3L9/o3yDG5Zj9RSmVk9W26bPwnQ/IS6zVVF6KEnfoIw
	 50B3VnnGMUaUw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2BAE73782084;
	Wed, 31 Jan 2024 14:05:29 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] selftests/mm: mremap_dontunmap: conform test to TAP format output
Date: Wed, 31 Jan 2024 19:05:17 +0500
Message-ID: <20240131140528.320252-7-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240131140528.320252-1-usama.anjum@collabora.com>
References: <20240131140528.320252-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/mremap_dontunmap.c | 32 ++++++++++++-------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
index a06e73ec85682..1d75084b9ca56 100644
--- a/tools/testing/selftests/mm/mremap_dontunmap.c
+++ b/tools/testing/selftests/mm/mremap_dontunmap.c
@@ -27,14 +27,14 @@ static void dump_maps(void)
 	system(cmd);
 }
 
-#define BUG_ON(condition, description)					      \
-	do {								      \
-		if (condition) {					      \
-			fprintf(stderr, "[FAIL]\t%s():%d\t%s:%s\n", __func__, \
-				__LINE__, (description), strerror(errno));    \
-			dump_maps();					  \
-			exit(1);					      \
-		} 							      \
+#define BUG_ON(condition, description)						\
+	do {									\
+		if (condition) {						\
+			dump_maps();						\
+			ksft_exit_fail_msg("[FAIL]\t%s:%d\t%s:%s\n",		\
+					   __func__, __LINE__, (description),	\
+					   strerror(errno));			\
+		}								\
 	} while (0)
 
 // Try a simple operation for to "test" for kernel support this prevents
@@ -122,6 +122,7 @@ static void mremap_dontunmap_simple()
 	       "unable to unmap destination mapping");
 	BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
 	       "unable to unmap source mapping");
+	ksft_test_result_pass("%s\n", __func__);
 }
 
 // This test validates that MREMAP_DONTUNMAP on a shared mapping works as expected.
@@ -173,6 +174,7 @@ static void mremap_dontunmap_simple_shmem()
 	       "unable to unmap destination mapping");
 	BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
 	       "unable to unmap source mapping");
+	ksft_test_result_pass("%s\n", __func__);
 }
 
 // This test validates MREMAP_DONTUNMAP will move page tables to a specific
@@ -219,6 +221,7 @@ static void mremap_dontunmap_simple_fixed()
 	       "unable to unmap destination mapping");
 	BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
 	       "unable to unmap source mapping");
+	ksft_test_result_pass("%s\n", __func__);
 }
 
 // This test validates that we can MREMAP_DONTUNMAP for a portion of an
@@ -269,6 +272,7 @@ static void mremap_dontunmap_partial_mapping()
 	       "unable to unmap destination mapping");
 	BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
 	       "unable to unmap source mapping");
+	ksft_test_result_pass("%s\n", __func__);
 }
 
 // This test validates that we can remap over only a portion of a mapping.
@@ -328,19 +332,24 @@ static void mremap_dontunmap_partial_mapping_overwrite(void)
 	       "unable to unmap destination mapping");
 	BUG_ON(munmap(source_mapping, 5 * page_size) == -1,
 	       "unable to unmap source mapping");
+	ksft_test_result_pass("%s\n", __func__);
 }
 
 int main(void)
 {
+	ksft_print_header();
+
 	page_size = sysconf(_SC_PAGE_SIZE);
 
 	// test for kernel support for MREMAP_DONTUNMAP skipping the test if
 	// not.
 	if (kernel_support_for_mremap_dontunmap() != 0) {
-		printf("No kernel support for MREMAP_DONTUNMAP\n");
-		return KSFT_SKIP;
+		ksft_print_msg("No kernel support for MREMAP_DONTUNMAP\n");
+		ksft_finished();
 	}
 
+	ksft_set_plan(5);
+
 	// Keep a page sized buffer around for when we need it.
 	page_buffer =
 	    mmap(NULL, page_size, PROT_READ | PROT_WRITE,
@@ -356,6 +365,5 @@ int main(void)
 	BUG_ON(munmap(page_buffer, page_size) == -1,
 	       "unable to unmap page buffer");
 
-	printf("OK\n");
-	return 0;
+	ksft_finished();
 }
-- 
2.42.0


