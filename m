Return-Path: <linux-kselftest+bounces-27072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B189A3DDC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348F14203E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B61FF1BE;
	Thu, 20 Feb 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPU/PEhm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A91E5B9F
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063824; cv=none; b=EK7XWJaREzkMwCnBCvjdvvagnHqcwtqwwSD90PLyOI4ufma66F5q08BRC56U/t56bE+tQVHSt12DS+cNw5kfpRdmicvQqgzUsJK6MW0NzoF2ltly0vhpkEceDe4WV9usIXYSzVyHOZQkWnt5D2aLMp5NzUof/zkVQJndLePYolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063824; c=relaxed/simple;
	bh=mvZIKYgOX6EYSfhAM5B9z6KMXjLDBBxNXjsjITMmL9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NUdpqcr4u5FU8R3eDLdDPhZoyb3uLRbU53Xr3eQ9foBp/5wF/kYzDJwrDz2339WzPMiai77+OS3XAvDF+EBrbQuUzL6jCItT6ISQP5gwsXmjFNaLZxC8WGM7gSQnEEB9XEn3sbCI6TaW7z+D2xZ5S1ZrsWwC9w9P5R8Kgzh/qs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPU/PEhm; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4399304b329so5454305e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 07:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740063820; x=1740668620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/GEg9bTAKZaokpu/RBxFBw77BnqyC2KwAVRaZb3wfC8=;
        b=LPU/PEhm7n/FfaG2a39KA3/5WzgsyhiSvazMWkSojX9lSIsvjJ4YmS0YJFDEZP6KJg
         N3+1nYJXFzREtMr7HKJ1jcP/gsz0QJGIeZZkzUMtCsbVMildF1VEiENHvFyM+G1FlQLk
         xXbnx1QimeO1oTfvoJim5UvNE+9O40H+7s2A6SYX8LtI9Cum4VsLpYquzHcRJw3lptaF
         jzOVSoRCZN//IGccPHR4NXaYozJIaM2xKlaCBK2+PsfHr6oZaj73i+lz0txWW7/2eBPR
         vZCCNyybLGB+jKrfZ+rQDw1B+qa0/kfExAHQcAqEL203B3zWx9YQqvSargv/kaLkiz+i
         T0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063820; x=1740668620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GEg9bTAKZaokpu/RBxFBw77BnqyC2KwAVRaZb3wfC8=;
        b=kdTa99ul56R5zo4eLoAr7x72hDJ/iPi8RCTJBewQ2bpWhZztqkkXAK+wadEGC6HwFf
         vYEkTZrCsw9WCP8SxM+KI2ohkdluCf79oBLv5nLybTsv/tvfSHbK0l/iXa+TSeib6IS+
         Z5EDW4DnltOX9v5bHh/Y6EDLVIWNtVew/2nXkoNyUKbzxtV3iaynV29c0MMc31fWq5gi
         ThUaTPAuv6rbnUzPr3OfCZf22a8r2wWsQhUiwpMtAlWtMDFtBTyEAE6Y4QpQLfWQ30b9
         xPNk+HXdAceYNUcfCQoYdkuyc2anqcOzQt91ASM+66LVbcLnmW1Y6khvSrbKY65cC7A9
         K9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWffoV00WDX6kw+VEYCwYCndT6wvU7XSrVqzf3B1WSDPmmM0KAGvjv/iYv64NI7+rEwnBJ6oXhsSXStPx6A0c4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3RApMMpkFEVhJyqOW+p+73Fx7gsTaEnxcq2/4FSGDGhrYACn
	2dU/spS+/gGBFcYizhYOPk/jOCRCDDjmrSAP4x4+szwPaouRy80xg5Vm8+Xml9jHLx3Owc/oOtl
	eD+h3FuhUAw==
X-Google-Smtp-Source: AGHT+IFOliTpraR15CWTkacKeBSUqf8FbRBDdkQpsEi0GIcWjSpwR0EViFfPxP8qN/+qIjSryFofPr/PtV4xXg==
X-Received: from wmbhc12.prod.google.com ([2002:a05:600c:870c:b0:439:98ca:e39d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b26:b0:439:31e0:d9a5 with SMTP id 5b1f17b1804b1-43999dd1e1cmr69699445e9.22.1740063820541;
 Thu, 20 Feb 2025 07:03:40 -0800 (PST)
Date: Thu, 20 Feb 2025 15:03:13 +0000
In-Reply-To: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250220-mm-selftests-v1-1-9bbf57d64463@google.com>
Subject: [PATCH 1/6] selftests/mm: Report errno when things fail
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Just reporting failure doesn't tell you what went wrong. This can fail
in different ways so report errno to help the reader get started
debugging.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/gup_longterm.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 9423ad439a6140163bdef2974615bb86406a8c14..46a2139b3a646f6c050eb031a770f615be76c433 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -96,13 +96,13 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 	int ret;
 
 	if (ftruncate(fd, size)) {
-		ksft_test_result_fail("ftruncate() failed\n");
+		ksft_test_result_fail("ftruncate() failed (%d)\n", errno);
 		return;
 	}
 
 	if (fallocate(fd, 0, 0, size)) {
 		if (size == pagesize)
-			ksft_test_result_fail("fallocate() failed\n");
+			ksft_test_result_fail("fallocate() failed (%d)\n", errno);
 		else
 			ksft_test_result_skip("need more free huge pages\n");
 		return;
@@ -112,7 +112,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		   shared ? MAP_SHARED : MAP_PRIVATE, fd, 0);
 	if (mem == MAP_FAILED) {
 		if (size == pagesize || shared)
-			ksft_test_result_fail("mmap() failed\n");
+			ksft_test_result_fail("mmap() failed (%d)\n", errno);
 		else
 			ksft_test_result_skip("need more free huge pages\n");
 		return;
@@ -130,7 +130,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		 */
 		ret = mprotect(mem, size, PROT_READ);
 		if (ret) {
-			ksft_test_result_fail("mprotect() failed\n");
+			ksft_test_result_fail("mprotect() failed (%d)\n", errno);
 			goto munmap;
 		}
 		/* FALLTHROUGH */
@@ -165,18 +165,18 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
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
+			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed (%d)\n", errno);
 			break;
 		}
 
 		if (ioctl(gup_fd, PIN_LONGTERM_TEST_STOP))
-			ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed\n");
+			ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed (%d)\n", errno);
 
 		/*
 		 * TODO: if the kernel ever supports long-term R/W pinning on
@@ -202,7 +202,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		/* Skip on errors, as we might just lack kernel support. */
 		ret = io_uring_queue_init(1, &ring, 0);
 		if (ret < 0) {
-			ksft_test_result_skip("io_uring_queue_init() failed\n");
+			ksft_test_result_skip("io_uring_queue_init() failed (%d)\n", errno);
 			break;
 		}
 		/*
@@ -215,13 +215,13 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		/* Only new kernels return EFAULT. */
 		if (ret && (errno == ENOSPC || errno == EOPNOTSUPP ||
 			    errno == EFAULT)) {
-			ksft_test_result(!should_work, "Should have failed\n");
+			ksft_test_result(!should_work, "Should have failed (%d)\n", errno);
 		} else if (ret) {
 			/*
 			 * We might just lack support or have insufficient
 			 * MEMLOCK limits.
 			 */
-			ksft_test_result_skip("io_uring_register_buffers() failed\n");
+			ksft_test_result_skip("io_uring_register_buffers() failed (%d)\n", errno);
 		} else {
 			ksft_test_result(should_work, "Should have worked\n");
 			io_uring_unregister_buffers(&ring);
@@ -249,7 +249,7 @@ static void run_with_memfd(test_fn fn, const char *desc)
 
 	fd = memfd_create("test", 0);
 	if (fd < 0) {
-		ksft_test_result_fail("memfd_create() failed\n");
+		ksft_test_result_fail("memfd_create() failed (%d)\n", errno);
 		return;
 	}
 
@@ -266,13 +266,13 @@ static void run_with_tmpfile(test_fn fn, const char *desc)
 
 	file = tmpfile();
 	if (!file) {
-		ksft_test_result_fail("tmpfile() failed\n");
+		ksft_test_result_fail("tmpfile() failed (%d)\n", errno);
 		return;
 	}
 
 	fd = fileno(file);
 	if (fd < 0) {
-		ksft_test_result_fail("fileno() failed\n");
+		ksft_test_result_fail("fileno() failed (%d)\n", errno);
 		goto close;
 	}
 
@@ -290,12 +290,12 @@ static void run_with_local_tmpfile(test_fn fn, const char *desc)
 
 	fd = mkstemp(filename);
 	if (fd < 0) {
-		ksft_test_result_fail("mkstemp() failed\n");
+		ksft_test_result_fail("mkstemp() failed (%d)\n", errno);
 		return;
 	}
 
 	if (unlink(filename)) {
-		ksft_test_result_fail("unlink() failed\n");
+		ksft_test_result_fail("unlink() failed (%d)\n", errno);
 		goto close;
 	}
 
@@ -317,7 +317,7 @@ static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
 
 	fd = memfd_create("test", flags);
 	if (fd < 0) {
-		ksft_test_result_skip("memfd_create() failed\n");
+		ksft_test_result_skip("memfd_create() failed (%d)\n", errno);
 		return;
 	}
 

-- 
2.48.1.601.g30ceb7b040-goog


