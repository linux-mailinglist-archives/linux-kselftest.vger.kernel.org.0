Return-Path: <linux-kselftest+bounces-2897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7525482BBA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 08:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A05F1C24FA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44E05D72A;
	Fri, 12 Jan 2024 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FrHH7po2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A75C916;
	Fri, 12 Jan 2024 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705044101;
	bh=o1IUw1D3iI8Y90Z4hsu7JwinzA97QoWLS2TEa1p944o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FrHH7po2p6f5bJlnjjARK+E5oPRZy5Mjhz3oMXw6a4KRpAireAwHVRMKyYKttNYQi
	 RpUFQFefBsY+jE/5hw1Ps0LoPTWBUkgW9L+ig/KnkPuRQZMjYM15rUQoXZJBcfTdgi
	 VwUYi3SkK90zBwqL2fpFPYAKbUKAXPCTQ+qsBESUZaaa//vhC7uhDq86ZNNngOZ1Nl
	 dLxYceVowQeEdshFlKMb0jUiOANh0aBJ+ZDwc0Gr2zV/XkhrJYROP56QYlXwQd6i9t
	 VOq0K+dn95R3MOABRQEjVLn1dYf361vSLVza18YnsflWC4PweFc4ee3jqYvYIK7WxC
	 AADZGFRpj+Kxg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 06CC23782021;
	Fri, 12 Jan 2024 07:21:39 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] selftests/mm: hugepage-vmemmap: conform test to TAP format output
Date: Fri, 12 Jan 2024 12:21:35 +0500
Message-ID: <20240112072144.620098-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240112072144.620098-1-usama.anjum@collabora.com>
References: <20240112072144.620098-1-usama.anjum@collabora.com>
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
 tools/testing/selftests/mm/hugepage-vmemmap.c | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-vmemmap.c b/tools/testing/selftests/mm/hugepage-vmemmap.c
index 5b354c209e93..125b96a65286 100644
--- a/tools/testing/selftests/mm/hugepage-vmemmap.c
+++ b/tools/testing/selftests/mm/hugepage-vmemmap.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include "../kselftest.h"
 
 #define MAP_LENGTH		(2UL * 1024 * 1024)
 
@@ -77,7 +78,7 @@ static int check_page_flags(unsigned long pfn)
 	read(fd, &pageflags, sizeof(pageflags));
 	if ((pageflags & HEAD_PAGE_FLAGS) != HEAD_PAGE_FLAGS) {
 		close(fd);
-		printf("Head page flags (%lx) is invalid\n", pageflags);
+		ksft_print_msg("Head page flags (%lx) is invalid\n", pageflags);
 		return -1;
 	}
 
@@ -91,7 +92,7 @@ static int check_page_flags(unsigned long pfn)
 		if ((pageflags & TAIL_PAGE_FLAGS) != TAIL_PAGE_FLAGS ||
 		    (pageflags & HEAD_PAGE_FLAGS) == HEAD_PAGE_FLAGS) {
 			close(fd);
-			printf("Tail page flags (%lx) is invalid\n", pageflags);
+			ksft_print_msg("Tail page flags (%lx) is invalid\n", pageflags);
 			return -1;
 		}
 	}
@@ -106,11 +107,12 @@ int main(int argc, char **argv)
 	void *addr;
 	unsigned long pfn;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	addr = mmap(MAP_ADDR, MAP_LENGTH, PROT_READ | PROT_WRITE, MAP_FLAGS, -1, 0);
-	if (addr == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 
 	/* Trigger allocation of HugeTLB page. */
 	write_bytes(addr, MAP_LENGTH);
@@ -118,23 +120,19 @@ int main(int argc, char **argv)
 	pfn = virt_to_pfn(addr);
 	if (pfn == -1UL) {
 		munmap(addr, MAP_LENGTH);
-		perror("virt_to_pfn");
-		exit(1);
+		ksft_exit_fail_msg("virt_to_pfn: %s\n", strerror(errno));
+	} else if (!pfn && geteuid()) {
+		ksft_test_result_skip("Unable to read the pfn as non-root user\n");
+		ksft_finished();
 	}
 
-	printf("Returned address is %p whose pfn is %lx\n", addr, pfn);
+	ksft_print_msg("Returned address is %p whose pfn is %lx\n", addr, pfn);
 
-	if (check_page_flags(pfn) < 0) {
-		munmap(addr, MAP_LENGTH);
-		perror("check_page_flags");
-		exit(1);
-	}
+	ksft_test_result(!check_page_flags(pfn), "Check page flags\n");
 
 	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
-	if (munmap(addr, MAP_LENGTH)) {
-		perror("munmap");
-		exit(1);
-	}
+	if (munmap(addr, MAP_LENGTH))
+		ksft_exit_fail_msg("munmap: %s\n", strerror(errno));
 
-	return 0;
+	ksft_finished();
 }
-- 
2.42.0


