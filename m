Return-Path: <linux-kselftest+bounces-38388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF74B1C975
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 17:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB237A2E3F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA4299928;
	Wed,  6 Aug 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHyBu/3u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F47295DBC
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Aug 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495954; cv=none; b=NfOyTPKQ0llvy+ta6AlqdIwka9pHjQqGANs1D9vPK5jy9NlWVJlSjXiS1HGHqsEtiBWPLp2sYPUMouyrBjaPWUttV+1vh2mOJn6KvRZsQRZIQn8GTOq648yah9i8bZJ9mTwI0zI5DGDOrAVwgkqR5ECpufcT/eZHFDZW9dMA97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495954; c=relaxed/simple;
	bh=iUVqOV2h0uljyDUnMUl+kkbvIgii2KNnTTE9p+jQbC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BBBjmdY1VtT0NmrGsSdXaZThXxVH6hGGe2jfZKfg6nw18I0UInKwU6t/+ZofTZdT/hhmNxLfK4YC6bOjDnAg53wDf+OvenADh4+F61RjnfWigEQ/deZjVJ1HKUPKF/auHgYMpJT7oJpuS1kpeM5zYYDW/+6sFfzNEYOhC9v3HQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHyBu/3u; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32147620790so84785a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Aug 2025 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754495950; x=1755100750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXYe+deuPHevDPYBINDTsn9wi9CS1Jzi+BLJQIES5w4=;
        b=mHyBu/3uVC27TrGAJOYcGukM4kpk8CzsM5g0D7Rp+mvDyMTgTMEpe3pWMGSgTzTwpw
         87habpdv/6UOENPLIiECKCD8GbQUpt6LVhoEMQ263neVOh/lqYzmICdi8T/VEurtj46B
         BeGXj5FH9MorIBtPjtV2lVby0DWkgjwj5XdBdWOKK6+XyqlXz1rwMgmuuSHzFaSVufHT
         //TQTHCMCk6MAFZGI3YmTb1MOBURfkln5Bh1f/H21tlT/CMsfZePx4UBO1M5mG8KpMkP
         OTjCsh/X2xh6D9pN2qWe/ij0aCtDIj8uITewvJWi5rbnLuRqMjQInG3+7jttOM8Bm0OL
         gf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495950; x=1755100750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXYe+deuPHevDPYBINDTsn9wi9CS1Jzi+BLJQIES5w4=;
        b=vVylUsAUW+R/OoZO889gBKgDCcY+1r3JA0Jgnp2YekuW5tMfOZRfHJW4hx+agTD5vI
         /ckwq+fGKQL6n81t+JQyYanZ+h/NpBmgJDFhbTTkZ8JlCXDcikh/yTJebP7wB2+7i0sW
         CEY0g/VnaD6+95t57juHiEGGgnrUt1I7wJb8yhpmzs46CmSA3/pPN5ggoWcpsmTe2E1y
         3f0Tv+ktx1sTarEGrEtwLWPmgaLwJSj+V+Xl9VxqOyABGvAnrEYoKGGOutMKS/zR21AF
         Ysf51SVNgIdxZNXfzjt/Gfg/4yHEXRQfLcJffY8MABNnuDkesaA3vujp2rK1MzmuDDKi
         Rixw==
X-Forwarded-Encrypted: i=1; AJvYcCWLyKc0GTBq+KqpuwqzBoM+CGQ3I78ZMzkzzzoANi+RziZjmAEovgulpkqIBV+kCpZrgImdGLOP712Hm0GbYhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYEPqjoltiBdrxj6qavx4On8vQ9zytSp1pT8Hwla2tRynO67a
	rGByGhDqVBL7EFQ8znyRPA0DQRJT51yH1q5wQ4jFCKEbnVXqboEefkLDAPLyK3QWNibx5+jLWzB
	U/A6eBA==
X-Google-Smtp-Source: AGHT+IGgvg3dQvTXmdt74y/yValTWb4FYmuEsFGJGvZhCliPSz+PpQKAizJFqhgIhOOFcKnbAdsQp68ZE7E=
X-Received: from pjv4.prod.google.com ([2002:a17:90b:5644:b0:313:245:8921])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2688:b0:321:38e0:d591
 with SMTP id 98e67ed59e1d1-32166c97f61mr5487656a91.17.1754495950179; Wed, 06
 Aug 2025 08:59:10 -0700 (PDT)
Date: Wed,  6 Aug 2025 08:59:02 -0700
In-Reply-To: <20250806155905.824388-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806155905.824388-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806155905.824388-2-surenb@google.com>
Subject: [PATCH v3 1/3] selftests/proc: test PROCMAP_QUERY ioctl while vma is
 concurrently modified
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com, 
	SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Extend /proc/pid/maps tearing tests to verify PROCMAP_QUERY ioctl operation
correctness while the vma is being concurrently modified.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: SeongJae Park <sj@kernel.org>
Acked-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/proc/proc-maps-race.c | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 94bba4553130..a546475db550 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -32,6 +32,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -317,6 +319,25 @@ static bool capture_mod_pattern(FIXTURE_DATA(proc_maps_race) *self,
 	       strcmp(restored_first_line->text, self->first_line.text) == 0;
 }
 
+static bool query_addr_at(int maps_fd, void *addr,
+			  unsigned long *vma_start, unsigned long *vma_end)
+{
+	struct procmap_query q;
+
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	/* Find the VMA at the split address */
+	q.query_addr = (unsigned long long)addr;
+	q.query_flags = 0;
+	if (ioctl(maps_fd, PROCMAP_QUERY, &q))
+		return false;
+
+	*vma_start = q.vma_start;
+	*vma_end = q.vma_end;
+
+	return true;
+}
+
 static inline bool split_vma(FIXTURE_DATA(proc_maps_race) *self)
 {
 	return mmap(self->mod_info->addr, self->page_size, self->mod_info->prot | PROT_EXEC,
@@ -559,6 +580,8 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 	do {
 		bool last_line_changed;
 		bool first_line_changed;
+		unsigned long vma_start;
+		unsigned long vma_end;
 
 		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
 
@@ -595,6 +618,19 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 		first_line_changed = strcmp(new_first_line.text, self->first_line.text) != 0;
 		ASSERT_EQ(last_line_changed, first_line_changed);
 
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
+					  &vma_start, &vma_end));
+		/*
+		 * The vma at the split address can be either the same as
+		 * original one (if read before the split) or the same as the
+		 * first line in the second page (if read after the split).
+		 */
+		ASSERT_TRUE((vma_start == self->last_line.start_addr &&
+			     vma_end == self->last_line.end_addr) ||
+			    (vma_start == split_first_line.start_addr &&
+			     vma_end == split_first_line.end_addr));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
@@ -636,6 +672,9 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	start_test_loop(&start_ts, self->verbose);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
 
 		/* Check if we read vmas after shrinking it */
@@ -662,6 +701,16 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 					"Expand result invalid", self));
 		}
 
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr, &vma_start, &vma_end));
+		/*
+		 * The vma should stay at the same address and have either the
+		 * original size of 3 pages or 1 page if read after shrinking.
+		 */
+		ASSERT_TRUE(vma_start == self->last_line.start_addr &&
+			    (vma_end - vma_start == self->page_size * 3 ||
+			     vma_end - vma_start == self->page_size));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
@@ -703,6 +752,9 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	start_test_loop(&start_ts, self->verbose);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
 
 		/* Check if we read vmas after remapping it */
@@ -729,6 +781,19 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 					"Remap restore result invalid", self));
 		}
 
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
+					  &vma_start, &vma_end));
+		/*
+		 * The vma should either stay at the same address and have the
+		 * original size of 3 pages or we should find the remapped vma
+		 * at the remap destination address with size of 1 page.
+		 */
+		ASSERT_TRUE((vma_start == self->last_line.start_addr &&
+			     vma_end - vma_start == self->page_size * 3) ||
+			    (vma_start == self->last_line.start_addr + self->page_size &&
+			     vma_end - vma_start == self->page_size));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
-- 
2.50.1.565.gc32cd1483b-goog


