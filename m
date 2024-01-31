Return-Path: <linux-kselftest+bounces-3844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 425BA844165
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E3CB293F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3140612A16E;
	Wed, 31 Jan 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NDduIphe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9226112A148;
	Wed, 31 Jan 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709946; cv=none; b=Og+rE/egHWJCkos191fTuQ72kJaMxGccEnBfEkwzVkD+Oeirf+5z7WM1ZM3xdNFfWdEYJzZ2fCE6mOIxNggSgI/qyMJZWHJOx7pu4/FgLlbNJuCGOahoj2CwYzq3vu31p8A357hWQeXQekZKnf2nMC+3j9/RUMaGSJ3SBBlsePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709946; c=relaxed/simple;
	bh=2kIkJOhTpv8Q3QiyGfqRKh0McTWdwjht00wQfRsByJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyc62yhkUekUEF/9WrWlynBW5LWFZJNa1TtyFVrCcDAHnYdzmTVRQZvHxGiaN+VxO3thN2NCZ2k3tt+OJ2xt8t7dA0OejSsiYLEzTfFuA0VTZyDacha54zQagH7di2G5DCBEzoL3hZJe7mTj+BJaeXHHxUbCv4CcBIUCC68weIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NDduIphe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706709943;
	bh=2kIkJOhTpv8Q3QiyGfqRKh0McTWdwjht00wQfRsByJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDduIphetMOQtuiPrCjAjVqGhbHMOGChazuerTGytlmJkwljYhUqUgJ4eh2KwUdvL
	 G6QGhqSC6PGhjZRmbzH2RZSat5WaEUBEzUg9bnuze8UHIkUiEdK+7mgLpbWx9Ko+fS
	 qJSmj+0YAqeQwSiesltDdilDr4ZkJ144vQ6jtdn6y1j7pQmKZ1esdyq7U/C9J9dmYT
	 Cp3KbS7/TIlhEVUEv0MhVQ9ojxFJgnnxIjguuYQKKA9SiuhWYOtmfU26SoNc9Zn5cp
	 suHOo24MGltQVnhmARjiYnIg6b6tjm4Uk2B6M2mjNQUJ+JDWVLeZOxnK7XNP4VKk1j
	 Qcs9zRB8H7bzQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A7DA4378200E;
	Wed, 31 Jan 2024 14:05:41 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] selftests/mm: virtual_address_range: conform to TAP format output
Date: Wed, 31 Jan 2024 19:05:22 +0500
Message-ID: <20240131140528.320252-12-usama.anjum@collabora.com>
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
 .../selftests/mm/virtual_address_range.c      | 44 +++++++++----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index bae0ceaf95b13..7bcf8d48256a6 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -12,6 +12,7 @@
 #include <errno.h>
 #include <sys/mman.h>
 #include <sys/time.h>
+#include "../kselftest.h"
 
 /*
  * Maximum address range mapped with a single mmap()
@@ -68,23 +69,15 @@ static char *hind_addr(void)
 	return (char *) (1UL << bits);
 }
 
-static int validate_addr(char *ptr, int high_addr)
+static void validate_addr(char *ptr, int high_addr)
 {
 	unsigned long addr = (unsigned long) ptr;
 
-	if (high_addr) {
-		if (addr < HIGH_ADDR_MARK) {
-			printf("Bad address %lx\n", addr);
-			return 1;
-		}
-		return 0;
-	}
+	if (high_addr && addr < HIGH_ADDR_MARK)
+		ksft_exit_fail_msg("Bad address %lx\n", addr);
 
-	if (addr > HIGH_ADDR_MARK) {
-		printf("Bad address %lx\n", addr);
-		return 1;
-	}
-	return 0;
+	if (addr > HIGH_ADDR_MARK)
+		ksft_exit_fail_msg("Bad address %lx\n", addr);
 }
 
 static int validate_lower_address_hint(void)
@@ -107,23 +100,29 @@ int main(int argc, char *argv[])
 	char *hint;
 	unsigned long i, lchunks, hchunks;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	for (i = 0; i < NR_CHUNKS_LOW; i++) {
 		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
 					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
 		if (ptr[i] == MAP_FAILED) {
-			if (validate_lower_address_hint())
-				return 1;
+			if (validate_lower_address_hint()) {
+				ksft_test_result_skip("Memory constraint not fulfilled\n");
+				ksft_finished();
+			}
 			break;
 		}
 
-		if (validate_addr(ptr[i], 0))
-			return 1;
+		validate_addr(ptr[i], 0);
 	}
 	lchunks = i;
 	hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
-	if (hptr == NULL)
-		return 1;
+	if (hptr == NULL) {
+		ksft_test_result_skip("Memory constraint not fulfilled\n");
+		ksft_finished();
+	}
 
 	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
 		hint = hind_addr();
@@ -133,8 +132,7 @@ int main(int argc, char *argv[])
 		if (hptr[i] == MAP_FAILED)
 			break;
 
-		if (validate_addr(hptr[i], 1))
-			return 1;
+		validate_addr(hptr[i], 1);
 	}
 	hchunks = i;
 
@@ -145,5 +143,7 @@ int main(int argc, char *argv[])
 		munmap(hptr[i], MAP_CHUNK_SIZE);
 
 	free(hptr);
-	return 0;
+
+	ksft_test_result_pass("Test\n");
+	ksft_finished();
 }
-- 
2.42.0


