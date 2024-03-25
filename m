Return-Path: <linux-kselftest+bounces-6527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C4D88A8B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A15FB667B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B8D184421;
	Mon, 25 Mar 2024 07:32:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675301B1AC8;
	Mon, 25 Mar 2024 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711340940; cv=none; b=jWAt5O7C5RVqhqplUU8L9KExZKznwXAdbtWDbFWYqR9eMOr6Gg9ytWru3p6sd5yFsybbnqWJdtOLUajgE4aXG8NQh+HNNqbMdMwOSXoq6xI9E3NvxTqmq6krBPgkGCV7l2N35T70JbuwQ0FPDR7MsjXdHq8LywHx7MXuDUdpWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711340940; c=relaxed/simple;
	bh=cZf7sZdfV/mb7osuQGgPBqHJ1vNAfqFBOpg/Aa3UNw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFbjVlObhehwNJnFp4u46Er9dimCsTBayBcYXWCWPZ00U8bLGzri0KSqDHNZbT0Xr6nS33atKQtP1FDWIJmrZ4trt+s1uzbX5tB5FIC9ggB6LiOFYRgrkcRVKUX/ul+F+2+Ir/9ARDCdx4rLrr6w8YH4JCG5F5VW2pI1xr5lBR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40CCF1FB;
	Sun, 24 Mar 2024 21:29:25 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6BD83F67D;
	Sun, 24 Mar 2024 21:28:48 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2] selftests/mm: Confirm VA exhaustion without reliance on correctness of mmap()
Date: Mon, 25 Mar 2024 09:56:53 +0530
Message-Id: <20240325042653.867055-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, VA exhaustion is being checked by passing a hint to mmap() and
expecting it to fail. This patch makes a stricter test by successful
write() calls from /proc/self/maps to a dump file, confirming that a
free chunk is indeed not available.

Changes in v2:
- Replace SZ_1GB with MAP_CHUNK_SIZE, tidy-up

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
Merge dependency: https://lore.kernel.org/all/20240314122250.68534-1-dev.jain@arm.com/

 .../selftests/mm/virtual_address_range.c      | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 7bcf8d48256a..050e997e3be2 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -12,6 +12,8 @@
 #include <errno.h>
 #include <sys/mman.h>
 #include <sys/time.h>
+#include <fcntl.h>
+
 #include "../kselftest.h"
 
 /*
@@ -93,6 +95,66 @@ static int validate_lower_address_hint(void)
 	return 1;
 }
 
+static int validate_complete_va_space(void)
+{
+	unsigned long start_addr, end_addr, prev_end_addr;
+	char line[400];
+	char prot[6];
+	FILE *file;
+	int fd;
+
+	fd = open("va_dump", O_CREAT | O_WRONLY, 0600);
+	unlink("va_dump");
+	if (fd < 0) {
+		ksft_test_result_skip("cannot create or open dump file\n");
+		ksft_finished();
+	}
+
+	file = fopen("/proc/self/maps", "r");
+	if (file == NULL)
+		ksft_exit_fail_msg("cannot open /proc/self/maps\n");
+
+	prev_end_addr = 0;
+	while (fgets(line, sizeof(line), file)) {
+		unsigned long hop;
+
+		if (sscanf(line, "%lx-%lx %s[rwxp-]",
+			   &start_addr, &end_addr, prot) != 3)
+			ksft_exit_fail_msg("cannot parse /proc/self/maps\n");
+
+		/* end of userspace mappings; ignore vsyscall mapping */
+		if (start_addr & (1UL << 63))
+			return 0;
+
+		/* /proc/self/maps must have gaps less than MAP_CHUNK_SIZE */
+		if (start_addr - prev_end_addr >= MAP_CHUNK_SIZE)
+			return 1;
+
+		prev_end_addr = end_addr;
+
+		if (prot[0] != 'r')
+			continue;
+
+		/*
+		 * Confirm whether MAP_CHUNK_SIZE chunk can be found or not.
+		 * If write succeeds, no need to check MAP_CHUNK_SIZE - 1
+		 * addresses after that. If the address was not held by this
+		 * process, write would fail with errno set to EFAULT.
+		 * Anyways, if write returns anything apart from 1, exit the
+		 * program since that would mean a bug in /proc/self/maps.
+		 */
+		hop = 0;
+		while (start_addr + hop < end_addr) {
+			if (write(fd, (void *)(start_addr + hop), 1) != 1)
+				return 1;
+			lseek(fd, 0, SEEK_SET);
+
+			hop += MAP_CHUNK_SIZE;
+		}
+	}
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	char *ptr[NR_CHUNKS_LOW];
@@ -135,6 +197,10 @@ int main(int argc, char *argv[])
 		validate_addr(hptr[i], 1);
 	}
 	hchunks = i;
+	if (validate_complete_va_space()) {
+		ksft_test_result_fail("BUG in mmap() or /proc/self/maps\n");
+		ksft_finished();
+	}
 
 	for (i = 0; i < lchunks; i++)
 		munmap(ptr[i], MAP_CHUNK_SIZE);
-- 
2.34.1


