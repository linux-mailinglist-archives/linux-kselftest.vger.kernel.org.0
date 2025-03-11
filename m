Return-Path: <linux-kselftest+bounces-28737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A643A5C241
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A42316ED23
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074CF1BD00C;
	Tue, 11 Mar 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqgZKTOz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088F199237
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699103; cv=none; b=SoHVucKibhQJprpZwE1FW+oDHQzWyjhmTYN6WFhCNYrtIuCxXMcbZUxMr7FWttUTELzMTkuthZ374z3ZDtD8hX85QFUGEWQVRIL5TUNEh8ZgZ7BiytTOvx1h9MlLLPwS5P5tCDtadu6LjjgC8GxhFfx/hhI7RYqQwdwxevO0GG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699103; c=relaxed/simple;
	bh=JQhRr6deSyIwx2zw/NuSPazbVfMmtvtNqOIabeeTs8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VPvM+oIv6CxmpbuXxl9LqhLAbxYZCQmaS9p5GlPMDrYOyKrT+hHOoEiA8j2UpRRVTuuGY8n7VBfGA9SxjXk7UzoIW2TsWj6Mv7BN1Ep/eFG0FwniNZpXBSCFvA3KVlHrKaMMvOY2svCbnEhBdLw06ZblOR0bHWXMqpOjuEqLVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqgZKTOz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43947a0919aso46334985e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699100; x=1742303900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3kjR3e+tUhw3L1FQAPtkpKMwUmzOI7e4dVWjhqVqwM=;
        b=GqgZKTOzQfPAi905c5YmvBCypQts0zgmtYFsl1TJpL5IEjPvx0l2LKgyd7njdeK92I
         DaDODI5yt2UwldUS0iWgen9/R5rjcRaTRgFSBAadwCZ2fXAmzBWq8h3wPCeNgmZrHR2d
         SoWQBObMopX6qhlYXtxyUaZSJqdaCxUFiNm1vHQm6qjqyKkz8TQ6PZhDTnbHeIDLTKdQ
         4vD3RthaJfMTAydVeBc8bZ6oxxqYsE7dCsCJzmkJXQa55JZUkiYPHA+uC2d/i4jk9MoD
         EXvifftU5AwbZvOJuUGhvvw/Er3MHm179Q4lvlWN9wnTwcNOYKrg2ohWah9JzogTZZM4
         9BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699100; x=1742303900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3kjR3e+tUhw3L1FQAPtkpKMwUmzOI7e4dVWjhqVqwM=;
        b=ZqaUuTvujdqZkYP9xmNubYIL2FfKiIfYLAdEjCMu/9W6I0e/LXYxDGl6WhdmrNbwpP
         1DxSUfOnt/BKd086swoqtwp5eAaSZtBROjqI5SL0vIyW6P78eSC64WeA4ggWn0Bn74rt
         Ma8gvKRaFIn1bZzUbrQ3QoQd/nbuWG2hiC7LnC7+XTIfe56hTLk0Hl27qYaCHtKX7qlr
         xKx7+/eqlxKjQPgubb4vSW0xFSzrkkgbeW7O/y8wv6Kr4BApOWBON6WkkAzmCM/IPDGe
         AURIXi0RcokkaoGF2UNB6ApeOcAzSKdyUAXgwDtI81YRL726hamcQLI/ri+oaDdLpoQg
         /ZRw==
X-Forwarded-Encrypted: i=1; AJvYcCWpnI6MdLtGA27CxdbCAEl1hGRcqKyDJfYXGWcMVf7MNp+exBNSk5nvQpGDXTU1GuQ0ZMqE/81D1gY0z4/XoxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC1bF/zSjktNfPOk8IRUsRAf0M54ZoQq31w2hnnwyLGU4pg0yu
	AfvSysiibmxqWsE6UXYsfL9yJKXyB1/j6uHelLgJI4LhURWGs9sFp1GzFO+KAkN9K3LrPjSqMbh
	ao0lihlA8kw==
X-Google-Smtp-Source: AGHT+IFvDSGF/OHbPFKrTNFDJv2bYNbhXrjsIZlG+nsyMMEqyV04VNqP84+SWfbxxSYLZ4nKYbR3gmw1XGhYsg==
X-Received: from wmpz16.prod.google.com ([2002:a05:600c:a10:b0:43c:ee49:c14d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba3:b0:43c:fcbc:968c with SMTP id 5b1f17b1804b1-43cfcbc97d3mr87744455e9.7.1741699100416;
 Tue, 11 Mar 2025 06:18:20 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:12 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-1-dec210a658f5@google.com>
Subject: [PATCH v4 01/12] selftests/mm: Report errno when things fail in gup_longterm
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Just reporting failure doesn't tell you what went wrong. This can fail
in different ways so report errno to help the reader get started
debugging.

Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/gup_longterm.c | 37 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 9423ad439a6140163bdef2974615bb86406a8c14..15335820656b1c143b440b8a1065a025378e22a2 100644
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
+					      strerror(-ret));
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
+					      strerror(-ret));
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
2.49.0.rc0.332.g42c0ae87b1-goog


