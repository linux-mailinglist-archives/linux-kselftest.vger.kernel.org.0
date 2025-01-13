Return-Path: <linux-kselftest+bounces-24310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607EDA0AEA1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 06:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765E61882F6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 05:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC62314AD02;
	Mon, 13 Jan 2025 05:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ACoFZwQQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09863C1F
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 05:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745008; cv=none; b=aIOjvEMwgv83ojDs7utm3clW/dXJwrgudxyOS4H/yjsxzUk43Ekbvrri8Ml8q9+oAjW3AzUEup0EIbuxs0sJOd60xd87QEUzmXDfmJnDc+LQHbsPNISmvHg/uRL+9orFAA1ftBwxO2QhOl5g8fP9X0h90OlwJAWkhnUlH6gT4U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745008; c=relaxed/simple;
	bh=sUA2Uz0TlX1E/VT259pkHlX2VdOg35KZ7pWVgZAbEOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UAl88aHD0zQSlJLOrGja6ClaK7o9lB0NU40jD354vy7kKY2x6ve/2d+irOGExnXePpwHRqFJ9Mln8OHdiCqA/aPcGvw1e8VX2z4MhKPGdMWERu0BMN7RhIZqoLN5HG2EEzrNzdw2cBI4xLws12IPV4MHlRbjA8qlgsqh2R+UgTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ACoFZwQQ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736744998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1l78jd0qMMKBnpeHqnyXlXnFzz9Dvsbdkukvh1fc9lc=;
	b=ACoFZwQQpdRGjNwYtx0yuCGYY3g7W1LW6ejwb0w8JHnarM2hgBYnylRuLjvzGsWtBfLh4u
	JCZr8wKMala0bX89MFlWgqSvVcnLjJiTzY4YIB6Lx9PfvGqmape62DVJpldE1glbkvghZ9
	/bJ0+S3BVrI4qkucKpYwv9QZi35LBqc=
From: Hao Ge <hao.ge@linux.dev>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: sj@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] selftests/mm/cow: Modify the incorrect checking parameters
Date: Mon, 13 Jan 2025 13:09:08 +0800
Message-Id: <20250113050908.93638-1-hao.ge@linux.dev>
In-Reply-To: <1514aee8-e75c-4c05-8943-65681254feda@linux.dev>
References: <1514aee8-e75c-4c05-8943-65681254feda@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

In the cow.c,some error handle have passed incorrect
parameters. It should be "smem", but it was mistakenly
written as "mem".

Let's fix it.

Fixes: f8664f3c4a08 ("selftests/vm: cow: basic COW tests for non-anonymous pages")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2: Anshuman pointed out that the error is not limited to the run_with_memfd_hugetlb function;
    there are other places where it occurs as well.
    Therefore, let's fix it all together.
    Similarly, Update the Fix tag to be accurate.
---
 tools/testing/selftests/mm/cow.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 32c6ccc2a6be..c52c93996ba1 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1482,7 +1482,7 @@ static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
 	}
 
 	smem = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANON, -1, 0);
-	if (mem == MAP_FAILED) {
+	if (smem == MAP_FAILED) {
 		ksft_test_result_fail("mmap() failed\n");
 		goto munmap;
 	}
@@ -1583,7 +1583,7 @@ static void run_with_memfd(non_anon_test_fn fn, const char *desc)
 		goto close;
 	}
 	smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
-	if (mem == MAP_FAILED) {
+	if (smem == MAP_FAILED) {
 		ksft_test_result_fail("mmap() failed\n");
 		goto munmap;
 	}
@@ -1634,7 +1634,7 @@ static void run_with_tmpfile(non_anon_test_fn fn, const char *desc)
 		goto close;
 	}
 	smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
-	if (mem == MAP_FAILED) {
+	if (smem == MAP_FAILED) {
 		ksft_test_result_fail("mmap() failed\n");
 		goto munmap;
 	}
@@ -1684,7 +1684,7 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
 		goto close;
 	}
 	smem = mmap(NULL, hugetlbsize, PROT_READ, MAP_SHARED, fd, 0);
-	if (mem == MAP_FAILED) {
+	if (smem == MAP_FAILED) {
 		ksft_test_result_fail("mmap() failed\n");
 		goto munmap;
 	}
@@ -1696,7 +1696,7 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
 	fn(mem, smem, hugetlbsize);
 munmap:
 	munmap(mem, hugetlbsize);
-	if (mem != MAP_FAILED)
+	if (smem != MAP_FAILED)
 		munmap(smem, hugetlbsize);
 close:
 	close(fd);
-- 
2.25.1


