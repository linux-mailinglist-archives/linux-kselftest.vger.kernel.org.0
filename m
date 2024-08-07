Return-Path: <linux-kselftest+bounces-14922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A276C94AD00
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 17:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D5E280C80
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31B85931;
	Wed,  7 Aug 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJF5d+oI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E774E09
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044951; cv=none; b=qa6o/MNc3/ZKP1JtI+cYfML9RtV2tLeRlH15lIE10VPu+antFNnR9B9bNob+v2LSDfjM6LY9rds2Eph0DAUfqO5zddeUD5rYgJcqYm0icvXsGlZMxO6eLWxb7EDoZPvg14VA/70zrDxKFhGOAAxEPVKO+PDBqsDnWa/cvt0Y1Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044951; c=relaxed/simple;
	bh=s9CkfNWvW6jQ+KuZef0P+IXflX2IogIAMHBgJSRl9Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdKE4cx6RQql+CkIJ4f4oAunbukpt7hToBQ76Ciq3pHnE+na/ekaII4wKizRRLiDiyfXfQHBTTn0LMHE9lmE/TsK96TjuuItVtFbhkCh+tw6xWE8VRazFjCzUPVkXlVvQxMt8pCqaPWWfig8jBHjMxAa8e4ao+B/+9GxzB4FUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UJF5d+oI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fed72d23a7so388965ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2024 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723044949; x=1723649749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwzf1u9uZY62W33ta9kOU+Pg3rCPU/ryARfGIfXdTqQ=;
        b=UJF5d+oIpyRH/tzBzrFKKlEVSqR629mp+03LPfGPsivzJwVy6nyiUtMR18tt6sRiGD
         /6otdjQt0o4ZXzuf1yGZd6bDJPUEaPXJqErg3ST2SYOqsV8ryW6yRI62UKQNu35tSGu0
         k5Eu+DSJhiz2dXaUvAbVM+ML0rgXuJARqgdTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044949; x=1723649749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wwzf1u9uZY62W33ta9kOU+Pg3rCPU/ryARfGIfXdTqQ=;
        b=NAO72RGR9bmdrjjV6oUQUlko4eicPlDkyy+UWCGMuyXrRaYJwemjWruvj32ChHO3Wi
         dYmHsI5tdjTLKZlTl1dWoVPHWdiMpLb865gc77UFf3jFves+rnh6ImbrHqA9YDyZPgKN
         i/4HS3pgSfC0Cc8qwEWHacUYnjEgyt+oL+/0DvMJ0puhlB5mk3x2+nj7m0/m4cflWYkR
         E+UG1lANAlctiIX4DJp+YxKJlSD46PlY+sCXU5nFUOsCznmzAGG6tITHjqt6ndbzo9X7
         IAI/7eUrqsrtzgX0zyIQPCuqPQL+X5aljXYiDA2zuHq1eicCyhDQpXWRjz4NwJBkq6ZO
         S6ow==
X-Forwarded-Encrypted: i=1; AJvYcCVRdH/Kl5JzgeIPEJQBzDajhyyqRWuX/oSf7J8iWDsn8gdTrZfNPnLU8VCCzOwzhpgVyQPD7+mTr7kF/VLJNbcGHZBHr376O3+qNI+omgfU
X-Gm-Message-State: AOJu0YxUacwAqVjoIRXkVyPGK1ivun/p3lzqCHWl3loCQkoL7wH5bh2K
	leUxk5XLn+1MTo2/wNaaZm5qHH6zc10Rf34wB+1Mpl6Tf0PNVAo4RTndIh5VvQ==
X-Google-Smtp-Source: AGHT+IGvi7dQHzYwS3aVaZb2F6yx2nnD9//HN/3+Cc1hlgmg2cIb+ocyDjoQkdIhNeB/X542y+CYmQ==
X-Received: by 2002:a17:902:ecd2:b0:1fd:64d2:62da with SMTP id d9443c01a7336-1ff572c4e13mr220549835ad.29.1723044949167;
        Wed, 07 Aug 2024 08:35:49 -0700 (PDT)
Received: from localhost (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1ff592aa11csm107549745ad.272.2024.08.07.08.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 08:35:48 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	willy@infradead.org,
	torvalds@linux-foundation.org,
	Liam.Howlett@oracle.com,
	pedro.falcato@gmail.com
Cc: jeffxu@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mpe@ellerman.id.au,
	oliver.sang@intel.com,
	vbabka@suse.cz,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1] selftest mm/mseal: fix test_seal_mremap_move_dontunmap_anyaddr
Date: Wed,  7 Aug 2024 15:35:44 +0000
Message-ID: <20240807153544.2754247-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

the syscall remap accepts following:

sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
		(void*) 0xdead0000)

when the src is sealed, the call will fail with when error code:
EPERM

Also remove the dependency on glibc for mremap(), the previous
version of test pass on certain version of glibc and fail in another.
By calling syscall directly, we test and verify remap function
in kernel directly.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 tools/testing/selftests/mm/mseal_test.c | 44 ++++++++++++++-----------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index a818f010de47..45d299fd74ed 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -110,6 +110,16 @@ static int sys_madvise(void *start, size_t len, int types)
 	return sret;
 }
 
+static void *sys_mremap(void *addr, size_t old_len, size_t new_len,
+	unsigned long flags, void *new_addr)
+{
+	void *sret;
+
+	errno = 0;
+	sret = (void *) syscall(__NR_mremap, addr, old_len, new_len, flags, new_addr);
+	return sret;
+}
+
 static int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
 {
 	int ret = syscall(__NR_pkey_alloc, flags, init_val);
@@ -1115,12 +1125,12 @@ static void test_seal_mremap_shrink(bool seal)
 	}
 
 	/* shrink from 4 pages to 2 pages. */
-	ret2 = mremap(ptr, size, 2 * page_size, 0, 0);
+	ret2 = sys_mremap(ptr, size, 2 * page_size, 0, 0);
 	if (seal) {
-		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
-		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
+		FAIL_TEST_IF_FALSE(ret2 != (void *) MAP_FAILED);
 
 	}
 
@@ -1147,7 +1157,7 @@ static void test_seal_mremap_expand(bool seal)
 	}
 
 	/* expand from 2 page to 4 pages. */
-	ret2 = mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
+	ret2 = sys_mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1180,7 +1190,7 @@ static void test_seal_mremap_move(bool seal)
 	}
 
 	/* move from ptr to fixed address. */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newPtr);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newPtr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1299,7 +1309,7 @@ static void test_seal_mremap_shrink_fixed(bool seal)
 	}
 
 	/* mremap to move and shrink to fixed address */
-	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
@@ -1330,7 +1340,7 @@ static void test_seal_mremap_expand_fixed(bool seal)
 	}
 
 	/* mremap to move and expand to fixed address */
-	ret2 = mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
@@ -1361,7 +1371,7 @@ static void test_seal_mremap_move_fixed(bool seal)
 	}
 
 	/* mremap to move to fixed address */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newAddr);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1390,14 +1400,13 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
 	/*
 	 * MREMAP_FIXED can move the mapping to zero address
 	 */
-	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
 		FAIL_TEST_IF_FALSE(ret2 == 0);
-
 	}
 
 	REPORT_TEST_PASS();
@@ -1420,13 +1429,12 @@ static void test_seal_mremap_move_dontunmap(bool seal)
 	}
 
 	/* mremap to move, and don't unmap src addr. */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
 		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
-
 	}
 
 	REPORT_TEST_PASS();
@@ -1449,18 +1457,16 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 	}
 
 	/*
-	 * The 0xdeaddead should not have effect on dest addr
+	 * The 0xdead0000 should not have effect on dest addr
 	 * when MREMAP_DONTUNMAP is set.
 	 */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
-			0xdeaddead);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
+			(void *) 0xdead0000);
 	if (seal) {
-		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
-		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
-		FAIL_TEST_IF_FALSE((long)ret2 != 0xdeaddead);
-
+		FAIL_TEST_IF_FALSE(ret2 == (void *) 0xdead0000);
 	}
 
 	REPORT_TEST_PASS();
-- 
2.46.0.rc2.264.g509ed76dc8-goog


