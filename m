Return-Path: <linux-kselftest+bounces-6459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF72885787
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288201C2204F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 10:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCCC433D5;
	Thu, 21 Mar 2024 10:36:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC11957867;
	Thu, 21 Mar 2024 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017406; cv=none; b=OwFjNawVe+4RDivv6I/+yMBRKaSSkPhu2VkjwQ2XDU/myj86AvAxxz/1GxT3Zg0dGYsoqBwwP/VF2boU6Ww02Jq6r6/IpZveS7ySvoonEse3iC9mlL9UetBG9T8hP/h3vpKWMmUOodz+Nw31UWhy4I3HwqOr3HzQ2ih6Vqrpxn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017406; c=relaxed/simple;
	bh=SyJMQIj0GXjFOk1fDTe5O7EqtWzLUjb2EUSythGeJxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IEgp3vjuis4jlk81/ta4Bw0N7uDZ5cY/l20fWswtROtJVlrQBApAj7R1qMFu9cWezqt/wJ9/K+NYDLP0bkf/zsBuDyQbntzv+VQPBXBYtoWj/Qo6Ue1jeBWbwe9aZ8iOFkzYujZ+zMoeLbmy9f2Uwtr3JrX8KAXJhJwDpKqK4W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D3E81007;
	Thu, 21 Mar 2024 03:37:17 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F6A43F67D;
	Thu, 21 Mar 2024 03:36:40 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] selftests/mm: Confirm VA exhaustion without reliance on correctness of mmap()
Date: Thu, 21 Mar 2024 16:05:22 +0530
Message-Id: <20240321103522.516097-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, VA exhaustion is being checked by passing a hint to mmap() and
expecting it to fail. This patch makes a stricter test by successful write()
calls from /proc/self/maps to a dump file, confirming that a free chunk is
indeed not available.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
Merge dependency: https://lore.kernel.org/all/20240314122250.68534-1-dev.jain@arm.com/

 .../selftests/mm/virtual_address_range.c      | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 7bcf8d48256a..31063613dfd9 100644
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
@@ -93,6 +95,69 @@ static int validate_lower_address_hint(void)
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
+		int ret;
+
+		ret = sscanf(line, "%lx-%lx %s[rwxp-]",
+			     &start_addr, &end_addr, prot);
+		if (ret != 3)
+			ksft_exit_fail_msg("sscanf failed, cannot parse\n");
+
+		/* end of userspace mappings; ignore vsyscall mapping */
+		if (start_addr & (1UL << 63))
+			return 0;
+
+		/* /proc/self/maps must have gaps less than 1GB only */
+		if (start_addr - prev_end_addr >= SZ_1GB)
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
+			else
+				lseek(fd, 0, SEEK_SET);
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
@@ -135,6 +200,10 @@ int main(int argc, char *argv[])
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


