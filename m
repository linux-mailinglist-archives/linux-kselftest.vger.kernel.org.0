Return-Path: <linux-kselftest+bounces-37400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B131DB06BF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 05:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79473B5A7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7A328641E;
	Wed, 16 Jul 2025 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KaWk0017"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4627F4C7
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635172; cv=none; b=InN1uV/CYfMzPyynMIXZxA/cI/3V74nW2kbiDShAqB+xJf4L4e7tmwbE1jV2RflPNff6MGNzVxw+WUnO7SLP/G68QYqqSabKDp88y+kn53zg5Qt+z08QRc5t/ZvROWJuygrDK0KS5qBIa4SaoHZuE7VGD29FtCFUc/ImSxg3vSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635172; c=relaxed/simple;
	bh=6/KDaBp6ZM8MWS9qb0wO08Ku16BqGmytBKM3lNMr5qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oz/OLuaTAAi60HVAmrcQJI+lyaxJn+yhVUYXFdqWG3tTjuyfRDyHBpUCoM0LLsKee8/4u9ywZ14e520nw8Hc8iNZq4IBn7k/WV+3Br+0kI0wPr1wwiVx5JRtNl7zBtMUp8iWArU7mDbtOVdOzp9Yv4KKRSomSCHXhAuiq1CegMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KaWk0017; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74d15d90cdbso5152465b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 20:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752635169; x=1753239969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz+/Rb5/fWdnaWsOelI+A9jPFxhtbRCP90y3FqomvrU=;
        b=KaWk0017C6IjSQ4BJrwiv4wom+ZjWM2sI0fgEkOhuC5QsUM8bgbZxakLwDST6UhFS6
         qgSbExvo8QTdqHf3grNF3aNkEr3XHc6bt3JqE2o26MeyDSkOF+j3EG6FtJy9yC5XDSL4
         iKVEzJo/RRvOoM5eOF/oply6YPUevPaNnaMQVzI1Oq/0H0XsWI/rzfS3jNd002aD/jdo
         k1ORw5CEOP0KV6o1NnqjBoYHG+TWIEJeB8SZ1WEHqjRRk19omWP7RV6NLM+wiQ6UwzeL
         3b0CoPZzux6fD7jRRzF6Vn4d8qtz+8OEIFmJ2Uk+htW5RZSAhAHnjQMIolIQp5IAq0xB
         jC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635169; x=1753239969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz+/Rb5/fWdnaWsOelI+A9jPFxhtbRCP90y3FqomvrU=;
        b=q3IsChd7sKCHiqdpMABvOAEsUk0hWlFYc1249I3jQOGxXsILoWjqLPOcKz8sy1DExT
         AjVcC/WxbyA7/FxBv9co9XziZxH1PHwbnjLc8Cz+SXqNkSX5WXB1f43+V2fi+ZGFh9+z
         QWgZgnUW/jI/V5vwTFH58XTzoaIgVaWYGpedzvJKejymnsGk+5SUt2Cy5M95wUIjqKJp
         Q31v94GjbS3ppehmtZj1Kd2Gi0YLVQB1tmL9KX708RG9KRv0a4AgBHprxWnbjd8lswmr
         zKQD+07kTw38jH7A3UnG2GlZKrEV6dc2I4ZdqRHxdjS7CbvyQ5ah8qXggW/9Jn00FwIi
         rmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIliJGISS6UBOyx95UluUEr0UAXCcAlM32bkvaxzrJOS8upUvQqtycrvlrgNLosxL2T+0C81vM0+n6mo0yZT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrKilHQmYflUCbYLzWLUYv8PSD9aRC3xwEsx+DUUIh2i1fH5C
	gTIDIOqkcjF7OobGerkXsDP9eJhzY9bymGfgMyqGBwRrPk11+sxV3/IaJ4AHuUf3TaTg4fMTMLp
	dIa8X+Q==
X-Google-Smtp-Source: AGHT+IE5zlLJfJSiKDps9oa63lOpF1CpedYQdGtHutsY8b9qvB6aXOWJRFpftXMF7nK7d9tGDEfQnxjduYc=
X-Received: from pfbjw38.prod.google.com ([2002:a05:6a00:92a6:b0:748:ec4d:30ec])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1c:b0:220:e5e:5909
 with SMTP id adf61e73a8af0-23813c6df02mr1420419637.20.1752635169133; Tue, 15
 Jul 2025 20:06:09 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:05:53 -0700
In-Reply-To: <20250716030557.1547501-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716030557.1547501-5-surenb@google.com>
Subject: [PATCH v7 4/7] selftests/proc: test PROCMAP_QUERY ioctl while vma is
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
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Extend /proc/pid/maps tearing test to verify PROCMAP_QUERY ioctl operation
correctness while the vma is being concurrently modified.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 764821ffd63d..6acdafdac9db 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -30,6 +30,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -239,6 +241,21 @@ static void capture_mod_pattern(int maps_fd,
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
@@ -299,6 +316,8 @@ static void test_maps_tearing_from_split(int maps_fd,
 	do {
 		bool last_line_changed;
 		bool first_line_changed;
+		unsigned long vma_start;
+		unsigned long vma_end;
 
 		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
 
@@ -329,6 +348,19 @@ static void test_maps_tearing_from_split(int maps_fd,
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
 
@@ -390,6 +422,9 @@ static void test_maps_tearing_from_resize(int maps_fd,
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
 
 		/* Check if we read vmas after shrinking it */
@@ -409,6 +444,17 @@ static void test_maps_tearing_from_resize(int maps_fd,
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
 
@@ -479,6 +525,9 @@ static void test_maps_tearing_from_remap(int maps_fd,
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
 
 		/* Check if we read vmas after remapping it */
@@ -498,6 +547,19 @@ static void test_maps_tearing_from_remap(int maps_fd,
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
2.50.0.727.gbf7dc18ff4-goog


