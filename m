Return-Path: <linux-kselftest+bounces-24213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B315CA0916B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 14:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F77C188C5DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 13:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206AF20DD79;
	Fri, 10 Jan 2025 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vflGQwKo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xv1l3BxM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567A20D4FB;
	Fri, 10 Jan 2025 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514379; cv=none; b=Q6qMx/pYktR0UtuBL+lJAE+YQhMmwRWup/vKGczZUvjd03ZlKL6sEGTsXcIyAIAHzwFXVvvx4jgj/uTCr0LhcRPDwHRnRMbn7xCIdnwaqNfeSZJuGJW16XxZdb81/UJngo3sK2ODnQaLz9tfMjWQ5lHy+/ZsTTGXjhV1Oh62dFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514379; c=relaxed/simple;
	bh=oH2aay2q7fFXdPQqT97Za+YuSgFw9tqAjxqs/EP1Kzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkXIiAohTVknQq5NK8XVscZtduavZ2TVPPjwo4d+Nu0o9X2I3KsX6n2otAYkhEu0YkJ9g1sMaGxCBKMLpdYn+A9ZPYlMISIyixIUw9Av34uID+O1ROB4Eu43dQwp1XSNXMqx31vuICuyeO6NJOyd9K7TqKBvUHwjhp7bAzHQOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vflGQwKo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xv1l3BxM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736514375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfSwcoper7Dt8IbJd6SAJbSWE7t+Dn+VNNOEgXwNNto=;
	b=vflGQwKokksy9wndTuq2JDp+6s69Q4PSQE8lsJVo/7ytgk1kgyOqo2DNj7xUlianGmIxpM
	dwtU55pWT9kh/QtQ3bPk2y9YrAyJzjFYnlTrQEieNrCbY7DOnCStBvTuAaf4GwVKd7HRwG
	JmHRaoF0AGj8YJbtKHGI2Lxh4rUA9xu82Lwu3yu6mDmzlRx3voVagjPpMSuxK/nH88OYC3
	NJsTYU3D2P8oehUd23xQ1N1id1VFGhEDBWcnuCHMxLZGt8DK7csgf/dA/QK+IO89+FOaSW
	crR4UkvEa3TOGQIinakJzlWKpLeOm290nKcGAKzRvvy0rL+5Ghkskz5gOE82cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736514375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfSwcoper7Dt8IbJd6SAJbSWE7t+Dn+VNNOEgXwNNto=;
	b=xv1l3BxMw4fVDw1Q7ltYhO+FHNtq+hmY6thNOPkVzJOhJW55YkcR0nToy/OQXE3yrsADa+
	oCwAHbkGm0wmjkAA==
Date: Fri, 10 Jan 2025 14:05:51 +0100
Subject: [PATCH v2 2/3] selftests/mm: virtual_address_range: Unmap chunks
 after validation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-virtual_address_range-tests-v2-2-262a2bf3c3d0@linutronix.de>
References: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
In-Reply-To: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736514373; l=3739;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=oH2aay2q7fFXdPQqT97Za+YuSgFw9tqAjxqs/EP1Kzk=;
 b=mS86EYLMAXqOl7y/cnaZgsSNJY87tS1Z/rkrO57qBRkaq02XGrGaGId/wVKSlYBOv1mWsF16C
 J0pGqBlWmmJDP2C0qPH9D6og59+leY8TwHdjXT7pyuGMpY13DOhWck2
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
 tools/testing/selftests/mm/virtual_address_range.c | 26 ++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

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
index ea6ccf49ef4c552f26317c2a40b09bca1a677f8f..4fc1c21a5e218eaec4d059b75c31a21dd4e8a215 100644
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
@@ -82,6 +83,17 @@ static void validate_addr(char *ptr, int high_addr)
 		ksft_exit_fail_msg("Bad address %lx\n", addr);
 }
 
+static void mark_addr(char *ptr)
+{
+	if (prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, MAP_CHUNK_SIZE, "virtual_address_range"))
+		ksft_exit_fail_msg("prctl(PR_SET_VMA_ANON_NAME) failed: %s\n", strerror(errno));
+}
+
+static int is_marked_addr(const char *vma_name)
+{
+	return vma_name && !strcmp(vma_name, "[anon:virtual_address_range]\n");
+}
+
 static int validate_lower_address_hint(void)
 {
 	char *ptr;
@@ -116,12 +128,17 @@ static int validate_complete_va_space(void)
 
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
@@ -149,6 +166,9 @@ static int validate_complete_va_space(void)
 				return 1;
 			lseek(fd, 0, SEEK_SET);
 
+			if (is_marked_addr(vma_name))
+				munmap((char *)(start_addr + hop), MAP_CHUNK_SIZE);
+
 			hop += MAP_CHUNK_SIZE;
 		}
 	}
@@ -175,6 +195,7 @@ int main(int argc, char *argv[])
 			break;
 		}
 
+		mark_addr(ptr[i]);
 		validate_addr(ptr[i], 0);
 	}
 	lchunks = i;
@@ -192,6 +213,7 @@ int main(int argc, char *argv[])
 		if (hptr[i] == MAP_FAILED)
 			break;
 
+		mark_addr(ptr[i]);
 		validate_addr(hptr[i], 1);
 	}
 	hchunks = i;

-- 
2.47.1


