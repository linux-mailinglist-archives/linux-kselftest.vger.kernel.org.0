Return-Path: <linux-kselftest+bounces-24363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B679A0B7F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206101606C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 13:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D632451D7;
	Mon, 13 Jan 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1CBuV9LM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4mvRayE0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E51A28D;
	Mon, 13 Jan 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774235; cv=none; b=EAywfreqjMcjf/G6hBlgdJEOUfJVYtXYiTB2MBjXdRz41zUNEchuiFc8whd/P0sZi1e1zpOwu3C40eEh/5UqHeCRCfebKzyg09ogt2ponBxqpjJSa2sVHy0wkatYQAKSqsy8EOwBUUHYBZAqsU6SoPBTDbms4hGTKcPQlD4y5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774235; c=relaxed/simple;
	bh=+J+pIjUkTrbA4CGXJ2S1U5YIbW5DfoH8SKBNfbwggwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5/LK/DbgKl06X2rL5HaREY1eiq9YQA8o9RgpgZkpIp5AWG5hJXm7gQaCbtUQCPsmPxp4SZ02zSUTRTYraMS3h0hq5GUiPi5I9YAqSL1bmNK/07fSiewMtE4tpE6BsaNyGCQiIRSgjES01gkL/iHsbqf5VGe+fA6JsKcXMU8HZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1CBuV9LM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4mvRayE0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736774232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BB2O49jg7bdHh5I8SFkvOSGpR/2gpeyIP8hG/oWKnuA=;
	b=1CBuV9LMXAMrlJ9IflbNljk0JXuo2zd1MPzCAD9297JXLmLapQgdndJiXwT9Vw1dv1uKvA
	3kICr8J0Qe1Tq4VBT8i+HBZMz24xJjspAfUAPBBG8Hlg6ueJV0YyCI5RFnaBAG1OgXxsKq
	YapIM26nzRMoFgxDh73szQ+M2S2EEJ9gRWRIypMbuhzp1HP1p9qlmWMp6i2uZcRUHN+ABj
	exBQpNpNN6nUzy3zt3I1iNRjVKI3GKVsYRj43hvJtSVDXSxH5aF/yxKFFF0pU/tduSeWpL
	jAqd4m77yFE9yk/NJfqGzFRd/38BDctkg8gkUVC/8WmJLzSILbZAxQcBcL6GVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736774232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BB2O49jg7bdHh5I8SFkvOSGpR/2gpeyIP8hG/oWKnuA=;
	b=4mvRayE0CAw8tX3kK9BfIK84n94lkVUmzadM8HdJlJ0M9Ts30Nn0HAT/7T/QT7TYsJ4nq9
	3oA4maHReyzVsBAA==
Date: Mon, 13 Jan 2025 14:15:36 +0100
Subject: [PATCH v3 2/4] selftests/mm: virtual_address_range: Unmap chunks
 after validation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250113-virtual_address_range-tests-v3-2-f4a8e6b7feed@linutronix.de>
References: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
In-Reply-To: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736774229; l=3957;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+J+pIjUkTrbA4CGXJ2S1U5YIbW5DfoH8SKBNfbwggwk=;
 b=uq6vmORxXVZbLi6UjqFMoF/YkYKRm8KQxCroQXGFlQap/Mqol+by324sYz153F6iNnwjZ6KOL
 VMaXve+XTJRDEdc0V6gkAQOwLRX6E/dWtAUFFJK3OOzNeRGN9Dg8+3q
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For each accessed chunk a PTE is created.
More than 1GiB of PTEs is used in this way.
Remove each PTE after validating a chunk to reduce peak memory usage.

It is important to only unmap memory that previously mmap()ed,
as unmapping other mappings like the stack, heap or executable mappings
will crash the process.
The mappings read from /proc/self/maps and the return values from mmap()
don't allow a simple correlation due to merging and no guaranteed order.
To correlate the pointers and mappings use prctl(PR_SET_VMA_ANON_NAME).
While it introduces a test dependency, other alternatives would
introduce runtime or development overhead.

Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/mm/config                  |  1 +
 tools/testing/selftests/mm/virtual_address_range.c | 33 ++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
index 4309916f629e36498efb07eb606b2f0c49ee6211..a28baa536332f3fcfb1b83759b5fbb432ae80178 100644
--- a/tools/testing/selftests/mm/config
+++ b/tools/testing/selftests/mm/config
@@ -7,3 +7,4 @@ CONFIG_TEST_HMM=m
 CONFIG_GUP_TEST=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_MEM_SOFT_DIRTY=y
+CONFIG_ANON_VMA_NAME=y
diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index ea6ccf49ef4c552f26317c2a40b09bca1a677f8f..386e4e46fa65b98af78dee4bb30144eb2b51f528 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -10,6 +10,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
+#include <sys/prctl.h>
 #include <sys/mman.h>
 #include <sys/time.h>
 #include <fcntl.h>
@@ -82,6 +83,24 @@ static void validate_addr(char *ptr, int high_addr)
 		ksft_exit_fail_msg("Bad address %lx\n", addr);
 }
 
+static void mark_range(char *ptr, size_t size)
+{
+	if (prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, size, "virtual_address_range") == -1) {
+		if (errno == EINVAL) {
+			/* Depends on CONFIG_ANON_VMA_NAME */
+			ksft_test_result_skip("prctl(PR_SET_VMA_ANON_NAME) not supported\n");
+			ksft_finished();
+		} else {
+			ksft_exit_fail_perror("prctl(PR_SET_VMA_ANON_NAME) failed\n");
+		}
+	}
+}
+
+static int is_marked_vma(const char *vma_name)
+{
+	return vma_name && !strcmp(vma_name, "[anon:virtual_address_range]\n");
+}
+
 static int validate_lower_address_hint(void)
 {
 	char *ptr;
@@ -116,12 +135,17 @@ static int validate_complete_va_space(void)
 
 	prev_end_addr = 0;
 	while (fgets(line, sizeof(line), file)) {
+		const char *vma_name = NULL;
+		int vma_name_start = 0;
 		unsigned long hop;
 
-		if (sscanf(line, "%lx-%lx %s[rwxp-]",
-			   &start_addr, &end_addr, prot) != 3)
+		if (sscanf(line, "%lx-%lx %4s %*s %*s %*s %n",
+			   &start_addr, &end_addr, prot, &vma_name_start) != 3)
 			ksft_exit_fail_msg("cannot parse /proc/self/maps\n");
 
+		if (vma_name_start)
+			vma_name = line + vma_name_start;
+
 		/* end of userspace mappings; ignore vsyscall mapping */
 		if (start_addr & (1UL << 63))
 			return 0;
@@ -149,6 +173,9 @@ static int validate_complete_va_space(void)
 				return 1;
 			lseek(fd, 0, SEEK_SET);
 
+			if (is_marked_vma(vma_name))
+				munmap((char *)(start_addr + hop), MAP_CHUNK_SIZE);
+
 			hop += MAP_CHUNK_SIZE;
 		}
 	}
@@ -175,6 +202,7 @@ int main(int argc, char *argv[])
 			break;
 		}
 
+		mark_range(ptr[i], MAP_CHUNK_SIZE);
 		validate_addr(ptr[i], 0);
 	}
 	lchunks = i;
@@ -192,6 +220,7 @@ int main(int argc, char *argv[])
 		if (hptr[i] == MAP_FAILED)
 			break;
 
+		mark_range(ptr[i], MAP_CHUNK_SIZE);
 		validate_addr(hptr[i], 1);
 	}
 	hchunks = i;

-- 
2.47.1


