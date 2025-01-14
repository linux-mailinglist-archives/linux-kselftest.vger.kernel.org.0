Return-Path: <linux-kselftest+bounces-24458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C478A10BC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A2518854CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 16:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273511B0F2F;
	Tue, 14 Jan 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbCGZCKp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DZpT+FHa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A847189B8F;
	Tue, 14 Jan 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870834; cv=none; b=UMJ0QJHE0Guyyo2fAD5vgF6QVhaqKOkwuXtzBBTYOWQL04wsVZECRZlhfchUDe5I0OFgndG8/4rFBb3sKJXYLdBrEYya6qO36CQLbdJla0oom5cwCaPN+E4djZb1irQmYvRYWpIvweSpvJHPv8GGeQkEH7oTXvWzH1OWvbt3hPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870834; c=relaxed/simple;
	bh=82ZDLn8Ie616VeVZksZ+ubTOfL8+PSxtmk+JZNkNkyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fatf3L9k5P0h+tMKxThpaA2v+emaBk8FnNWBBdfEFAiZvi7ljkzxooI522l6MXHuESxNkzF/FhFyEOaT9oJkl15UUzdCFF3OvOKZ6akxc2EStdHppeW2MgFheD87Cooa/7fRuLHe0P2+qTkTEPdVAfwXJdfsNVrYNa/juljvPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbCGZCKp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DZpT+FHa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736870830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHdz6D6xQVTO4bkE6hrOmhg63h4CtMukNog1b9dscsc=;
	b=MbCGZCKplIQcKN5TErGlMPeR08toq1UH+O+tIlF++i2Erh1tWc+m0yFL5vxQwEjI91VGr5
	nEXjaAP22h8s3GzjqTRUPGezJU2lYE8nRTK66/BKA9dJjJFS/tLlQaXq5qX7xzRBe/OsQ5
	8ffkqjWJIubzs8nRGKQ8lSH5hzyOLmkgVNEHgUAzU0RRChCdX0y4kPtVwskHkkKV4p6vx+
	pyr2paCgjw7yCD+VEME5M42BMvTfzpM8RRfapSav7dHT/SM5tuSAhXzG04Pm3NqWMiv1w7
	bTd7k2sWsm0dMHrr1g+1b5ewaeel10i3eP6snHwA9z2jWZTJjpQ6YTGvrra4aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736870830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHdz6D6xQVTO4bkE6hrOmhg63h4CtMukNog1b9dscsc=;
	b=DZpT+FHaDSddwumeiTKVkMQotTZFJIFvJnQAW3V+YEbJDHdXS1YkTG6jZzapE/XjkvDueA
	P8QdLYx03nCk6zCg==
Date: Tue, 14 Jan 2025 17:06:46 +0100
Subject: [PATCH v4 2/4] selftests/mm: virtual_address_range: Unmap chunks
 after validation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-virtual_address_range-tests-v4-2-6fd7269934a5@linutronix.de>
References: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
In-Reply-To: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>, 
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736870827; l=4005;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=82ZDLn8Ie616VeVZksZ+ubTOfL8+PSxtmk+JZNkNkyo=;
 b=oPv0Faclo57WmFtlCTOx25wxfWPHxrzmgr+oQuEWlAm5dMTgsvyf6eWeOshX+7AJRPEXs6tq8
 xlW9TYQdyCzDR2m8rRreQCxCAWiDTX+sQh/R7IY2xopSEVQPFTGyUIC
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
Acked-by: David Hildenbrand <david@redhat.com>
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


