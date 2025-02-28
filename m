Return-Path: <linux-kselftest+bounces-27925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C18A49F80
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721863BC46F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD227605E;
	Fri, 28 Feb 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkonPi7Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FCB2755E3
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761701; cv=none; b=Ti7OcurOwP6uVw1n0FVDH7nc+hygVmD1s+Y542/6sZfmxnzq8t/Xu5rgqYVw4Lk2oLEjZsuTnL7h38Vp7q9abhxDZwRqPMZmsKmClvsRPiOav0xFV8ggRQaU7hdTTZPUXzMziS/oJthfVWgIK+534Y89slCzhv3gdo3w7tSt3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761701; c=relaxed/simple;
	bh=AamrcRtPXOIol6EA4/dpfgzqJ+de0/XMyu5CLWyqWeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tABaI00d+swCqd9M/rVNraIgpJfasK0V29HuI7JAztm0q2AmLIzucgfc3IEOQzfeIT7Hl+4HJKlhy57ZCb7G8kcA5K0PvNvcShqTir5FwNkpJRVkMcQLEXmU5Yh019KcYvfT0wa92f+XhwMWmyHFwINn/izOy5r2EYr7U8Cejf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkonPi7Z; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43995bff469so15743755e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 08:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761698; x=1741366498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QncY2yvGTglAf/0LuL4dyh3O1wXM9xZ09WdsenWnBoE=;
        b=wkonPi7ZLg/5alr5lwGZmnrhxmH80aqaR8pzaa52rw6A1OuIIpLgy6oyJZc6P08lJy
         P70IBxFUSAtPk5ERHeubraHXMzl5+isjPWUF0T75YDKYyO+2WsoZVDHtKpEeWJN/KxCg
         ux5v8TnX+6+zDDGHiU4col6TOEFAtUIafT8lEmzZaK1tve0AIKz9awSzttgkimZBzB+n
         D6fW6FVitsxUOBtSAviz5cw4HemCgaaNN2ChBdANvjcl+mwP/bJ8krF4p7CE/n/Kpnph
         BZ5w1SP9YzR87IA2jg8oCDO1kIfbpDmp/85m7NgmRn89N3wYW7wKAsHImIDZ1zcmjLrj
         DZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761698; x=1741366498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QncY2yvGTglAf/0LuL4dyh3O1wXM9xZ09WdsenWnBoE=;
        b=cmT3J6uR1zNP1WHFDJQOR2xqMAgX3z4Ekzv3EUpJG15tTCw3hEvLYRa+0hZDQvTvmm
         Zvf5/NCvyConXM+q+xuDcfgkHVSEMskXWTPjVQXkneWUSkGZJEKwXTFH0IID7acMHaoV
         LYjQH5ieWLj6o8rzpkOfiv23VqcYErL2Tc3YL0fRlHU2fLiMA6n1jEtJ6pAQHqsdNfyj
         aE+5G/PvGbmnU5blY/tFSLW6fUMZPa/LJOExpNgysqJ/zy5HlPVkLKwW5MhXuIiYu8Ys
         7qw8apAfHOVjKFrO8B9g+6D30oVoeVkRvUHfcljKs6oe5uaM+bIrRr2LE0ghBMMLV7JS
         ZzlA==
X-Forwarded-Encrypted: i=1; AJvYcCXgpqYYMOqanon6vXYTwYxuqI/+MU6vwtMz/oZoodDCtPe4eksm0PEf6HZqeE4BQMUFsdvaFkN4k0cG6NEJMCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa55om1TE39zvFlzCQhz2StcwwSG42NkYorksvtnsEAqvzh8JY
	XUZXfHQnz6rkvU3aF9hhtJw+Mx83AeyJQQHEo/ngd1Cls4uI2O6D2S4x/eNQr8/tot6og1rnDcs
	zLIzY9xcQGw==
X-Google-Smtp-Source: AGHT+IHicUU5z+iWE2KYovQO/NyD9BP+fwXrc9YK1TI1vNtv7VrgMEVzfL9fF+5H0fCQp7q+fQoKvN3hnL1mpQ==
X-Received: from wmgg6.prod.google.com ([2002:a05:600d:6:b0:439:67c6:5642])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a47:b0:439:969e:d80f with SMTP id 5b1f17b1804b1-43ba6773869mr38269205e9.31.1740761697834;
 Fri, 28 Feb 2025 08:54:57 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:49 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-1-958e3b6f0203@google.com>
Subject: [PATCH v3 01/10] selftests/mm: Report errno when things fail in gup_longterm
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Just reporting failure doesn't tell you what went wrong. This can fail
in different ways so report errno to help the reader get started
debugging.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/gup_longterm.c | 37 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 9423ad439a6140163bdef2974615bb86406a8c14..879e9e4e8cce8127656fabe098abf7db5f6c5e23 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -96,13 +96,13 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 	int ret;
 
 	if (ftruncate(fd, size)) {
-		ksft_test_result_fail("ftruncate() failed\n");
+		ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
 		return;
 	}
 
 	if (fallocate(fd, 0, 0, size)) {
 		if (size == pagesize)
-			ksft_test_result_fail("fallocate() failed\n");
+			ksft_test_result_fail("fallocate() failed (%s)\n", strerror(errno));
 		else
 			ksft_test_result_skip("need more free huge pages\n");
 		return;
@@ -112,7 +112,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		   shared ? MAP_SHARED : MAP_PRIVATE, fd, 0);
 	if (mem == MAP_FAILED) {
 		if (size == pagesize || shared)
-			ksft_test_result_fail("mmap() failed\n");
+			ksft_test_result_fail("mmap() failed (%s)\n", strerror(errno));
 		else
 			ksft_test_result_skip("need more free huge pages\n");
 		return;
@@ -130,7 +130,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		 */
 		ret = mprotect(mem, size, PROT_READ);
 		if (ret) {
-			ksft_test_result_fail("mprotect() failed\n");
+			ksft_test_result_fail("mprotect() failed (%s)\n", strerror(errno));
 			goto munmap;
 		}
 		/* FALLTHROUGH */
@@ -165,18 +165,20 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		args.flags |= rw ? PIN_LONGTERM_TEST_FLAG_USE_WRITE : 0;
 		ret = ioctl(gup_fd, PIN_LONGTERM_TEST_START, &args);
 		if (ret && errno == EINVAL) {
-			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed\n");
+			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed (EINVAL)n");
 			break;
 		} else if (ret && errno == EFAULT) {
 			ksft_test_result(!should_work, "Should have failed\n");
 			break;
 		} else if (ret) {
-			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed\n");
+			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed (%s)\n",
+					      strerror(errno));
 			break;
 		}
 
 		if (ioctl(gup_fd, PIN_LONGTERM_TEST_STOP))
-			ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed\n");
+			ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed (%s)\n",
+				       strerror(errno));
 
 		/*
 		 * TODO: if the kernel ever supports long-term R/W pinning on
@@ -202,7 +204,8 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		/* Skip on errors, as we might just lack kernel support. */
 		ret = io_uring_queue_init(1, &ring, 0);
 		if (ret < 0) {
-			ksft_test_result_skip("io_uring_queue_init() failed\n");
+			ksft_test_result_skip("io_uring_queue_init() failed (%s)\n",
+					      strerror(errno));
 			break;
 		}
 		/*
@@ -215,13 +218,15 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		/* Only new kernels return EFAULT. */
 		if (ret && (errno == ENOSPC || errno == EOPNOTSUPP ||
 			    errno == EFAULT)) {
-			ksft_test_result(!should_work, "Should have failed\n");
+			ksft_test_result(!should_work, "Should have failed (%s)\n",
+					 strerror(errno));
 		} else if (ret) {
 			/*
 			 * We might just lack support or have insufficient
 			 * MEMLOCK limits.
 			 */
-			ksft_test_result_skip("io_uring_register_buffers() failed\n");
+			ksft_test_result_skip("io_uring_register_buffers() failed (%s)\n",
+					      strerror(errno));
 		} else {
 			ksft_test_result(should_work, "Should have worked\n");
 			io_uring_unregister_buffers(&ring);
@@ -249,7 +254,7 @@ static void run_with_memfd(test_fn fn, const char *desc)
 
 	fd = memfd_create("test", 0);
 	if (fd < 0) {
-		ksft_test_result_fail("memfd_create() failed\n");
+		ksft_test_result_fail("memfd_create() failed (%s)\n", strerror(errno));
 		return;
 	}
 
@@ -266,13 +271,13 @@ static void run_with_tmpfile(test_fn fn, const char *desc)
 
 	file = tmpfile();
 	if (!file) {
-		ksft_test_result_fail("tmpfile() failed\n");
+		ksft_test_result_fail("tmpfile() failed (%s)\n", strerror(errno));
 		return;
 	}
 
 	fd = fileno(file);
 	if (fd < 0) {
-		ksft_test_result_fail("fileno() failed\n");
+		ksft_test_result_fail("fileno() failed (%s)\n", strerror(errno));
 		goto close;
 	}
 
@@ -290,12 +295,12 @@ static void run_with_local_tmpfile(test_fn fn, const char *desc)
 
 	fd = mkstemp(filename);
 	if (fd < 0) {
-		ksft_test_result_fail("mkstemp() failed\n");
+		ksft_test_result_fail("mkstemp() failed (%s)\n", strerror(errno));
 		return;
 	}
 
 	if (unlink(filename)) {
-		ksft_test_result_fail("unlink() failed\n");
+		ksft_test_result_fail("unlink() failed (%s)\n", strerror(errno));
 		goto close;
 	}
 
@@ -317,7 +322,7 @@ static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
 
 	fd = memfd_create("test", flags);
 	if (fd < 0) {
-		ksft_test_result_skip("memfd_create() failed\n");
+		ksft_test_result_skip("memfd_create() failed (%s)\n", strerror(errno));
 		return;
 	}
 

-- 
2.48.1.711.g2feabab25a-goog


