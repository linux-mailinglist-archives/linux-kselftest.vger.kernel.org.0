Return-Path: <linux-kselftest+bounces-3622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2937083D93B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 12:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F6F1C27DA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136B3175AE;
	Fri, 26 Jan 2024 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZiXOzuzg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980814298;
	Fri, 26 Jan 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268099; cv=none; b=QlZ5xLkG+grBrNd2+3f+zxHM0CGsGHsC7VAuYW0eLR3a0XOQjYK0cZZ4cZa/nBikG2bFvawztlVQsgWWsVyF3RSdHYP8OfVmUb8PtJOBeGSSa2PWnz4hSVUD+706/Ka8q1eV7X/lUcp4Fj68DSS9Gcj40nMk0Ge0gsRdwaLjGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268099; c=relaxed/simple;
	bh=gbp4bpldYXMai1bSsa5vwkMEe02OYwC/9Rhgk1A/iN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o74YEGeTuu2o2gGKGNWrna+pGPYKfFnCm4NI1ZhZJOAse5eapDv2yeq+o++aHJoGqqvej34FG1YTztirUoqcA7yxYVQ/4X0QIbivXXI5VSGSqckMTbMNa+qKXP21XBTGzqdZbugpPuxBF5QvNdraih0sbN+JRCaypgyqJGywCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZiXOzuzg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706268095;
	bh=gbp4bpldYXMai1bSsa5vwkMEe02OYwC/9Rhgk1A/iN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiXOzuzg4aiDky/02dRhLu7ldeJ5EX4dN9lM/S0aVqQR4Yky3olG3YSE/YIcP1Qk/
	 eAAMVqLc8KRz10wrcDNHJY6bMaM4ajMWVqxWOE8QN5HoB8QUwHRmQiUiJ1hDnUS/g+
	 4RCopsCTurJp07GIIP5VT/3fTke48y2U7OyNjiM/PlCeF0+T3jKFLn1l1QdvNd8xts
	 bB0Y73sgNEM37YCVFVqvLu4Ow5EsPT0HrxoY7AZYB+CDr8inXJdtSHnQaT7Bw73wib
	 0pSiZ3aUdoWqgysiCLrEFYOwgPj0jusvrHmdyyUqNKk3j2yKNXLu0BUNfzxAYpcz4W
	 OyEIVOLfpjg4A==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 761883782075;
	Fri, 26 Jan 2024 11:21:33 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] selftests/mm: hugepage-vmemmap: conform test to TAP format output
Date: Fri, 26 Jan 2024 16:21:21 +0500
Message-ID: <20240126112129.1480265-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240126112129.1480265-1-usama.anjum@collabora.com>
References: <20240126112129.1480265-1-usama.anjum@collabora.com>
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
Changes since v3:
- Rebase to next-20240125
- Update newly updated code
---
 tools/testing/selftests/mm/hugepage-vmemmap.c | 39 ++++++++-----------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-vmemmap.c b/tools/testing/selftests/mm/hugepage-vmemmap.c
index 894d28c3dd478..9080e34bb297e 100644
--- a/tools/testing/selftests/mm/hugepage-vmemmap.c
+++ b/tools/testing/selftests/mm/hugepage-vmemmap.c
@@ -11,6 +11,7 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include "vm_util.h"
+#include "../kselftest.h"
 
 #define PAGE_COMPOUND_HEAD	(1UL << 15)
 #define PAGE_COMPOUND_TAIL	(1UL << 16)
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
@@ -106,18 +107,17 @@ int main(int argc, char **argv)
 	void *addr;
 	unsigned long pfn;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	pagesize  = psize();
 	maplength = default_huge_page_size();
-	if (!maplength) {
-		printf("Unable to determine huge page size\n");
-		exit(1);
-	}
+	if (!maplength)
+		ksft_exit_fail_msg("Unable to determine huge page size\n");
 
 	addr = mmap(MAP_ADDR, maplength, PROT_READ | PROT_WRITE, MAP_FLAGS, -1, 0);
-	if (addr == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 
 	/* Trigger allocation of HugeTLB page. */
 	write_bytes(addr, maplength);
@@ -125,23 +125,16 @@ int main(int argc, char **argv)
 	pfn = virt_to_pfn(addr);
 	if (pfn == -1UL) {
 		munmap(addr, maplength);
-		perror("virt_to_pfn");
-		exit(1);
+		ksft_exit_fail_msg("virt_to_pfn: %s\n", strerror(errno));
 	}
 
-	printf("Returned address is %p whose pfn is %lx\n", addr, pfn);
+	ksft_print_msg("Returned address is %p whose pfn is %lx\n", addr, pfn);
 
-	if (check_page_flags(pfn) < 0) {
-		munmap(addr, maplength);
-		perror("check_page_flags");
-		exit(1);
-	}
+	ksft_test_result(!check_page_flags(pfn), "check_page_flags\n");
 
 	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
-	if (munmap(addr, maplength)) {
-		perror("munmap");
-		exit(1);
-	}
+	if (munmap(addr, maplength))
+		ksft_exit_fail_msg("munmap: %s\n", strerror(errno));
 
-	return 0;
+	ksft_finished();
 }
-- 
2.42.0


