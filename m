Return-Path: <linux-kselftest+bounces-31168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E63A93C47
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 19:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1D81B6124A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6020E224236;
	Fri, 18 Apr 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpNzRx0W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB722259B
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998614; cv=none; b=PR9bL97jI3qsx7CaKOovy76MzG68uzLLLD9+Y/VqZ2fg7UmisF11Jwk8btEPojkdM80AVnKcGE+YugmgoDzOzFUm14dvXrqXCwoGmzJOGt0sNisatya3s1r8J91IW2q7XFrXrgF2v903mETEsTeagilEi6XFUbNghh8w7hLvQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998614; c=relaxed/simple;
	bh=uhXXixeQxZQZ9ZI8mpiMJ9ZnVW4idzYW13f4X6dKbPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aMc0WI5GU7HlPNPCBm6HTdR1qUaDOrbZc4wN5nMtyP8VAMPDuTifs8SkrX9b7piRsh6/G7FyZmTZwbdfhKMHgGO+4P3gM4DjWNWlPdvSoeLG6+wyfO/hlQV1z5nUUK4c/YRqTUfkxk+OlFd+m3YQsVN659iqnjE+pJUmrRfHMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpNzRx0W; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af54a9109f4so987507a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744998612; x=1745603412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUB6q+v0EpFzFu3PlHq45yNrya7EC7jKKGmhERTYTZQ=;
        b=gpNzRx0WjBK+hFs1U4pMiD9FHvYKBsXf0BCfVxReNyWi3/LU9dcZYTabEYsltxxCF5
         ohiF6fsfmsOALWRILucVkKmVQJUaFt4lyZkAiugsHpCXjDSqU/BALh8noSuWtEqwhLft
         XLNgWpLfL/NccQVomW2bPfaLOCJOLJ9lsEceC6U2esyQ5A2ABvZtS5hh8zxYTlYdlzMo
         C3RnP3lQG9LEiUvJzHZm4+plRoeBBuVqEtDEbdHafXcwP0YhBsuKPCFJhUsTSbOIYXJQ
         VGaJW1cTHUBm9C6aLMObEbOzpfUTvMNzyT4Gpatbrc1nDsS0CyITqYedO0zXDK1G6t0F
         mevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744998612; x=1745603412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUB6q+v0EpFzFu3PlHq45yNrya7EC7jKKGmhERTYTZQ=;
        b=ZZ4lXYR3IXZR1p9wPdSLEq7NSDVSK41sLRACnT1NVaPvaCjs9XIWlCEdHcb2dwFDae
         6tpF8JDR60Z+ZtHlunbs6qChrbDA+K4Q5B878F99WSoPfBvs30bKv6s3GFq52yUH2Si1
         pXs1DwGdztIwCQgIBmG14TApBdRYK+4Vqrg5XOfZ/ofX6oE+8r6tiirf0WQj9ScqdhKU
         sDAgzcjxMQnLxlo528AJHWWg4wFQOl4vI7Lf+rdYva9kp1p0cHzZC9gD4smggGR30p6A
         MDx8yHJ79yb/0so+bKLqLsVWwHaqVC5sD2jjYXPBwW/GjjoZEyGqIm80O6j8WfyTKZcV
         pO4A==
X-Forwarded-Encrypted: i=1; AJvYcCU4wJXoIlLskUL1TSlvkYtxGwB8ctDkFSgHdDK9jmTwZGotXGShPEqM8tnSYDW4/OEGy7dy1tIDTMBJy5QwgU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe7koebLXS6Zc6B9021uwVlY8aj/lrNF51hVSLLOGGwRMHslEE
	Cgu6T3u6L5vaw8VQWJHvlZY6CfwoE4PzE0zQE/kysjk5UTVPq76gWKaUYlfzeCsrKhD8LE5Slw8
	q/w==
X-Google-Smtp-Source: AGHT+IGyaQr+2pZMSmPsh5wX1RoiROvtwBkd0HseqzqLOxOjXALv+e2mSSAlluxAbqqn3sMiDcQhj5J0Y/Q=
X-Received: from pjbqx7.prod.google.com ([2002:a17:90b:3e47:b0:301:2679:9aa])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2809:b0:301:1c29:a1d9
 with SMTP id 98e67ed59e1d1-3087bb66b26mr5412483a91.21.1744998612089; Fri, 18
 Apr 2025 10:50:12 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:49:55 -0700
In-Reply-To: <20250418174959.1431962-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418174959.1431962-5-surenb@google.com>
Subject: [PATCH v3 4/8] selftests/proc: test PROCMAP_QUERY ioctl while vma is
 concurrently modified
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Extend /proc/pid/maps tearing test to verify PROCMAP_QUERY ioctl operation
correctness while the vma is being concurrently modified.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 1aef2db7e893..b582f40851fb 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -486,6 +486,21 @@ static void capture_mod_pattern(int maps_fd,
 	assert(strcmp(restored_first_line->text, first_line->text) == 0);
 }
 
+static void query_addr_at(int maps_fd, void *addr,
+			  unsigned long *vma_start, unsigned long *vma_end)
+{
+	struct procmap_query q;
+
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	/* Find the VMA at the split address */
+	q.query_addr = (unsigned long long)addr;
+	q.query_flags = 0;
+	assert(!ioctl(maps_fd, PROCMAP_QUERY, &q));
+	*vma_start = q.vma_start;
+	*vma_end = q.vma_end;
+}
+
 static inline void split_vma(const struct vma_modifier_info *mod_info)
 {
 	assert(mmap(mod_info->addr, page_size, mod_info->prot | PROT_EXEC,
@@ -546,6 +561,8 @@ static void test_maps_tearing_from_split(int maps_fd,
 	do {
 		bool last_line_changed;
 		bool first_line_changed;
+		unsigned long vma_start;
+		unsigned long vma_end;
 
 		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
 
@@ -576,6 +593,19 @@ static void test_maps_tearing_from_split(int maps_fd,
 		first_line_changed = strcmp(new_first_line.text, first_line->text) != 0;
 		assert(last_line_changed == first_line_changed);
 
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		query_addr_at(maps_fd, mod_info->addr + page_size,
+			      &vma_start, &vma_end);
+		/*
+		 * The vma at the split address can be either the same as
+		 * original one (if read before the split) or the same as the
+		 * first line in the second page (if read after the split).
+		 */
+		assert((vma_start == last_line->start_addr &&
+			vma_end == last_line->end_addr) ||
+		       (vma_start == split_first_line.start_addr &&
+			vma_end == split_first_line.end_addr));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
 
@@ -637,6 +667,9 @@ static void test_maps_tearing_from_resize(int maps_fd,
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
 
 		/* Check if we read vmas after shrinking it */
@@ -656,6 +689,17 @@ static void test_maps_tearing_from_resize(int maps_fd,
 			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
 			       !strcmp(new_first_line.text, restored_first_line.text));
 		}
+
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		query_addr_at(maps_fd, mod_info->addr, &vma_start, &vma_end);
+		/*
+		 * The vma should stay at the same address and have either the
+		 * original size of 3 pages or 1 page if read after shrinking.
+		 */
+		assert(vma_start == last_line->start_addr &&
+		       (vma_end - vma_start == page_size * 3 ||
+			vma_end - vma_start == page_size));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
 
@@ -726,6 +770,9 @@ static void test_maps_tearing_from_remap(int maps_fd,
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
 
 		/* Check if we read vmas after remapping it */
@@ -745,6 +792,19 @@ static void test_maps_tearing_from_remap(int maps_fd,
 			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
 			       !strcmp(new_first_line.text, restored_first_line.text));
 		}
+
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		query_addr_at(maps_fd, mod_info->addr + page_size, &vma_start, &vma_end);
+		/*
+		 * The vma should either stay at the same address and have the
+		 * original size of 3 pages or we should find the remapped vma
+		 * at the remap destination address with size of 1 page.
+		 */
+		assert((vma_start == last_line->start_addr &&
+			vma_end - vma_start == page_size * 3) ||
+		       (vma_start == last_line->start_addr + page_size &&
+			vma_end - vma_start == page_size));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
 
-- 
2.49.0.805.g082f7c87e0-goog


