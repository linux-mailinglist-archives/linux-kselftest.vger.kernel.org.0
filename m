Return-Path: <linux-kselftest+bounces-6322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A7887BB49
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 11:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C7E1F23652
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907DA5D91E;
	Thu, 14 Mar 2024 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W0RatWj8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67759B6C;
	Thu, 14 Mar 2024 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412317; cv=none; b=UnMRt8KU474IdU/Fa6W0GS1qTCd9od22f03O9qs025XzobNwifiXervjd0zG9aswx1l+Q+fVIk6B8MMh8aF6qdUUtPkv5WlUdGt3to/EDQg7KnwiRFoHyfV8AZLUk6cT9qWnz+q711b4iwBmpBtES910VWFb14pVF85iooQtkcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412317; c=relaxed/simple;
	bh=exuGrWSRS6cE3AtRRe5kVccLgVt8p90B506qHZAesl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QOmZYrdyKrdqdfc3n1sFotmyxgTE/oU0QdbhLwmrJH7jMbiwXIOnG/xfmdgAhlbllaeAnoEyTsv9KW04rjFTmovMYlbXEXAQAaSMvk1/enc+QgJD5HOaOstUwjZERQW2juZZREhPAQNQ4blgPvNWzTvyeMABNbsxiJ5AXlPDqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W0RatWj8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710412314;
	bh=exuGrWSRS6cE3AtRRe5kVccLgVt8p90B506qHZAesl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0RatWj8Swbx6niZjeKRzCrod++h6Ac9U/Ic1C18A2WDqC0CN2lEMdjkUFKtmoxLS
	 Q5AOwjYX5LRMedgxfsY/HOftEc69QFuIV42SE88MTU732NULeSSgBCfzYpKIQqeG7U
	 WSJXGTGPxcYY2/rhySRwnRjcuob3UQPqFWDBw9eA/grbl65YTGSu/e/g3bSyGTkc5M
	 zuJs6DB2kzW5GMWDc2amsDaCrfVv/0px/awDA2zSguIIi+rmMDvv1HSPN+y/XnMuzB
	 K7aVfSPAiwk3dKjgKnjd5OaxGVZs76v4fJfnQ/qsF6GBySV/3UczlaXz3kbzK6beWT
	 iVF1soE1ztIsA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 106AC37820F5;
	Thu, 14 Mar 2024 10:31:51 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: x86: test_mremap_vdso: conform test to TAP format output
Date: Thu, 14 Mar 2024 15:32:14 +0500
Message-Id: <20240314103216.286603-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240314103216.286603-1-usama.anjum@collabora.com>
References: <20240314103216.286603-1-usama.anjum@collabora.com>
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
 .../testing/selftests/x86/test_mremap_vdso.c  | 43 +++++++++----------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
index f0d876d482778..d53959e035930 100644
--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -19,6 +19,7 @@
 #include <sys/auxv.h>
 #include <sys/syscall.h>
 #include <sys/wait.h>
+#include "../kselftest.h"
 
 #define PAGE_SIZE	4096
 
@@ -29,13 +30,13 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
 	/* Searching for memory location where to remap */
 	dest_addr = mmap(0, size, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
 	if (dest_addr == MAP_FAILED) {
-		printf("[WARN]\tmmap failed (%d): %m\n", errno);
+		ksft_print_msg("WARN: mmap failed (%d): %m\n", errno);
 		return 0;
 	}
 
-	printf("[NOTE]\tMoving vDSO: [%p, %#lx] -> [%p, %#lx]\n",
-		vdso_addr, (unsigned long)vdso_addr + size,
-		dest_addr, (unsigned long)dest_addr + size);
+	ksft_print_msg("Moving vDSO: [%p, %#lx] -> [%p, %#lx]\n",
+		       vdso_addr, (unsigned long)vdso_addr + size,
+		       dest_addr, (unsigned long)dest_addr + size);
 	fflush(stdout);
 
 	new_addr = mremap(vdso_addr, size, size,
@@ -43,10 +44,10 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
 	if ((unsigned long)new_addr == (unsigned long)-1) {
 		munmap(dest_addr, size);
 		if (errno == EINVAL) {
-			printf("[NOTE]\tvDSO partial move failed, will try with bigger size\n");
+			ksft_print_msg("vDSO partial move failed, will try with bigger size\n");
 			return -1; /* Retry with larger */
 		}
-		printf("[FAIL]\tmremap failed (%d): %m\n", errno);
+		ksft_print_msg("[FAIL]\tmremap failed (%d): %m\n", errno);
 		return 1;
 	}
 
@@ -58,11 +59,12 @@ int main(int argc, char **argv, char **envp)
 {
 	pid_t child;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	child = fork();
-	if (child == -1) {
-		printf("[WARN]\tfailed to fork (%d): %m\n", errno);
-		return 1;
-	}
+	if (child == -1)
+		ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
 
 	if (child == 0) {
 		unsigned long vdso_size = PAGE_SIZE;
@@ -70,9 +72,9 @@ int main(int argc, char **argv, char **envp)
 		int ret = -1;
 
 		auxval = getauxval(AT_SYSINFO_EHDR);
-		printf("\tAT_SYSINFO_EHDR is %#lx\n", auxval);
+		ksft_print_msg("AT_SYSINFO_EHDR is %#lx\n", auxval);
 		if (!auxval || auxval == -ENOENT) {
-			printf("[WARN]\tgetauxval failed\n");
+			ksft_print_msg("WARN: getauxval failed\n");
 			return 0;
 		}
 
@@ -92,16 +94,13 @@ int main(int argc, char **argv, char **envp)
 		int status;
 
 		if (waitpid(child, &status, 0) != child ||
-			!WIFEXITED(status)) {
-			printf("[FAIL]\tmremap() of the vDSO does not work on this kernel!\n");
-			return 1;
-		} else if (WEXITSTATUS(status) != 0) {
-			printf("[FAIL]\tChild failed with %d\n",
-					WEXITSTATUS(status));
-			return 1;
-		}
-		printf("[OK]\n");
+			!WIFEXITED(status))
+			ksft_test_result_fail("mremap() of the vDSO does not work on this kernel!\n");
+		else if (WEXITSTATUS(status) != 0)
+			ksft_test_result_fail("Child failed with %d\n", WEXITSTATUS(status));
+		else
+			ksft_test_result_pass("%s\n", __func__);
 	}
 
-	return 0;
+	ksft_finished();
 }
-- 
2.39.2


