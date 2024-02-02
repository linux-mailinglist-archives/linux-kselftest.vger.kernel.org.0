Return-Path: <linux-kselftest+bounces-4011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6DD846EFA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 12:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C091F229AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 11:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF50814078A;
	Fri,  2 Feb 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XDgeClVE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1F140784;
	Fri,  2 Feb 2024 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873506; cv=none; b=eqRqLpaCyisjfETBUOp0PjYrhQjpx0kg+s9Up2Men1sMzj7B8dlpJWcZAnqnHEXXyJd4Kdd0ZMCeH33szLsTGCmb0I5kl+TqZ8OB8PhSCM4QQJhzh0Ydh8hwAl3JXNR0OJM6lIsWqmlakhOQJOv5BgydZJbWm9D72dJmomozMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873506; c=relaxed/simple;
	bh=SKE8pMm9wj80+Eluj9OfOxnVYjWtsY8duRngXOEJh3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5TwG5N8RD5zBzW7pKp6NzR9NHrfL156qCeDV0iveBYI8OWVKLglPJzAKp2Xtkp5YjFza3tZJwMZOQRTIqSNAyhGrFf7wC51Ch4gcsDRgmwgeClZJIBMhvHXhvdCxwlfE1+s4Amc3igwlFwD5GaTtYJ2YXpvM5mRWvRhGMAFjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XDgeClVE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706873503;
	bh=SKE8pMm9wj80+Eluj9OfOxnVYjWtsY8duRngXOEJh3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XDgeClVEVe8aFmyX6ZG0LNsjD6DIm4Co1wCBY44huyVlp8Z8IOoz7PHJG94tXpyrs
	 ojEFVkVSg2Z8We2lMlYANwczm7K4D3D775Qorey38Xdd+i7LGcJK11xpFsC2CuL/PH
	 3Uw7HERuRZ2Y0g5cC+w1iLRE0oYbmwyIgOBgcAGzLioPyO1uJzIqt/YnDo//B2jtWK
	 lpBVV6iwTGzmZHilpC4eAxIzqyoBqT6E2uO9C3TKGwW7tFZgQOq4anua7SZYU5La0R
	 WDhcXlAhtK34YdgQC9+ORwoCgn4XbfPJcGyGwX8jZwKVdpuMUTa2VHRlIAflCIuNFw
	 p1E4k/bv/R07Q==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A4D383782098;
	Fri,  2 Feb 2024 11:31:41 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/12] selftests/mm: mremap_dontunmap: conform test to TAP format output
Date: Fri,  2 Feb 2024 16:31:14 +0500
Message-ID: <20240202113119.2047740-8-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240202113119.2047740-1-usama.anjum@collabora.com>
References: <20240202113119.2047740-1-usama.anjum@collabora.com>
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


