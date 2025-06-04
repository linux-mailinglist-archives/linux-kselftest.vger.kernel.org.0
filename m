Return-Path: <linux-kselftest+bounces-34345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14653ACE701
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 01:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6167A4F04
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 23:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3826C382;
	Wed,  4 Jun 2025 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmREOMxe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF626B0A9
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749078725; cv=none; b=JIZQz0N1DOzQ0Zp1twY+OAnKXCOsYYicpgRRMeMQ3MSAUYepiilFChG+Y3qW6tBF5qD3fczrk2wbF3LsNB2q4lTCqSuPbBmtohyGW1fe2ZvSRC621R4CCyum71o5UVLMhY3NZ25fLjmUrJ3QuvieMSYXHakBnTVp9O1Pc7vH9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749078725; c=relaxed/simple;
	bh=1vDboiN+JpFr3VhknW6ngDyBW0PZNRwe/k/dYvbLNiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iFE0B6ImuwBo70emamjKLJ+M/AiLOSKjisozYUSSAEGzURzhsdQbP9f9/MghyeaEx8SYoQG7P094IIM4LaCMhGuqY+5gGnuGuawyedM3xQFiPJLq6ML+8ewBAN7A74oOOq20oNSWLE1MP8Lp2N6KM+ylUJKOvIwLDgDZskBj/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmREOMxe; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7370e73f690so515820b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749078723; x=1749683523; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn1CuoL7GOnivK1jg6V+q/afAc7Csel1kqBamqmGWos=;
        b=hmREOMxe1PcNy9uI1+sVCuNBDhlwnF0viEi2Q05bpvKDubsW7GLXATPifrBFsMQcZm
         pf/ikKsYa0g8D+HhlTVtE8udlyTW76ltTsa3IEvb7puYeIK97+UHRyzAuLodNo9O+WiH
         17fYeLZRfRKcjVwKN4m80xrDlPlLf0byPBZ/7TA2gAjQNOL7474QbsX9lR4qjEBLgRH2
         HtsNz5iuAjlhhXcdU45numivLsmFhPYBilXKTrTfI55zlgEb9orHZjW62RuEeWDZyBuj
         WdbVhyDQCSYY4vcNxYxeB9XnU48Du9PI6EXQcphSG9b8LFjZxBqnqkPKJqRrms5tBw/f
         QX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749078723; x=1749683523;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn1CuoL7GOnivK1jg6V+q/afAc7Csel1kqBamqmGWos=;
        b=LPpuhve579cB700XEvbXbiO/0eeAAKKz40/4lkmT58NbvR/vsQnORLeYTO8LeWq5mR
         +vfDINfFUXPC8t1i4anCO/osb9ZE+XH7dREET5jOpo5o2GofHuDCLUBvux5anz+AeOpM
         /kpRErBnWRTbpOBOJGXZZzlDbwkT16Gx0lvntSvGJaPOd+s5dV03OM9AM7zJesGzrgt5
         uaEZHlENR61YYZsLEOs0GTzOSCUrQmnfHycUFfx1tp6IykKTaDNux9fissduyIWZ5w8p
         87V32tbnLoh/Th7Fdjt2Av7eiVjhC+IwsONEH9CattcJuUMjjU7H0lPo9gkR/2D7Ker4
         xUIA==
X-Forwarded-Encrypted: i=1; AJvYcCU+c2dbdsggXjsFbke6TreTYt0r+TNZL9AEuOFnpwxjHl9gzee2m0W9Q6aCiDk3gMWxyVwAQle3hYDvFjq9v/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkOWkd8y0aCgpi+RHiK9oNnfgIKix91YB8U238T2V5zanMcZz
	mzyQjtOp/5TBvJxbIHhv6VsEJDs1U7q9hzrXUGan26YrinXYEAKsx7boOi4JKmqvEOwE/wewfB/
	WA4s8yA==
X-Google-Smtp-Source: AGHT+IGP+DfdXdLpP6/QarYMevGBa3Y0zZIyyxRVm7jNq4fA+66yl/00aXVcKUbDun5QpuD+I3S+pPim8k0=
X-Received: from pfdc11.prod.google.com ([2002:aa7:8c0b:0:b0:746:257b:1d37])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:339f:b0:215:fb74:2dc2
 with SMTP id adf61e73a8af0-21d22ba385amr7389771637.11.1749078723086; Wed, 04
 Jun 2025 16:12:03 -0700 (PDT)
Date: Wed,  4 Jun 2025 16:11:46 -0700
In-Reply-To: <20250604231151.799834-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604231151.799834-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.1266.g31b7d2e469-goog
Message-ID: <20250604231151.799834-3-surenb@google.com>
Subject: [PATCH v4 2/7] selftests/proc: extend /proc/pid/maps tearing test to
 include vma resizing
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Test that /proc/pid/maps does not report unexpected holes in the address
space when a vma at the edge of the page is being concurrently remapped.
This remapping results in the vma shrinking and expanding from  under the
reader. We should always see either shrunk or expanded (original) version
of the vma.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 6e3f06376a1f..39842e4ec45f 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -583,6 +583,86 @@ static void test_maps_tearing_from_split(int maps_fd,
 	signal_state(mod_info, TEST_DONE);
 }
 
+static inline void shrink_vma(const struct vma_modifier_info *mod_info)
+{
+	assert(mremap(mod_info->addr, page_size * 3, page_size, 0) != MAP_FAILED);
+}
+
+static inline void expand_vma(const struct vma_modifier_info *mod_info)
+{
+	assert(mremap(mod_info->addr, page_size, page_size * 3, 0) != MAP_FAILED);
+}
+
+static inline void check_shrink_result(struct line_content *mod_last_line,
+				       struct line_content *mod_first_line,
+				       struct line_content *restored_last_line,
+				       struct line_content *restored_first_line)
+{
+	/* Make sure only the last vma of the first page is changing */
+	assert(strcmp(mod_last_line->text, restored_last_line->text) != 0);
+	assert(strcmp(mod_first_line->text, restored_first_line->text) == 0);
+}
+
+static void test_maps_tearing_from_resize(int maps_fd,
+					  struct vma_modifier_info *mod_info,
+					  struct page_content *page1,
+					  struct page_content *page2,
+					  struct line_content *last_line,
+					  struct line_content *first_line)
+{
+	struct line_content shrunk_last_line;
+	struct line_content shrunk_first_line;
+	struct line_content restored_last_line;
+	struct line_content restored_first_line;
+
+	wait_for_state(mod_info, SETUP_READY);
+
+	/* re-read the file to avoid using stale data from previous test */
+	read_boundary_lines(maps_fd, page1, page2, last_line, first_line);
+
+	mod_info->vma_modify = shrink_vma;
+	mod_info->vma_restore = expand_vma;
+	mod_info->vma_mod_check = check_shrink_result;
+
+	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
+			    &shrunk_last_line, &shrunk_first_line,
+			    &restored_last_line, &restored_first_line);
+
+	/* Now start concurrent modifications for test_duration_sec */
+	signal_state(mod_info, TEST_READY);
+
+	struct line_content new_last_line;
+	struct line_content new_first_line;
+	struct timespec start_ts, end_ts;
+
+	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	do {
+		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
+
+		/* Check if we read vmas after shrinking it */
+		if (!strcmp(new_last_line.text, shrunk_last_line.text)) {
+			/*
+			 * The vmas should be consistent with shrunk results,
+			 * however if the vma was concurrently restored, it
+			 * can be reported twice (first as shrunk one, then
+			 * as restored one) because we found it as the next vma
+			 * again. In that case new first line will be the same
+			 * as the last restored line.
+			 */
+			assert(!strcmp(new_first_line.text, shrunk_first_line.text) ||
+			       !strcmp(new_first_line.text, restored_last_line.text));
+		} else {
+			/* The vmas should be consistent with the original/resored state */
+			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
+			       !strcmp(new_first_line.text, restored_first_line.text));
+		}
+		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
+
+	/* Signal the modifyer thread to stop and wait until it exits */
+	signal_state(mod_info, TEST_DONE);
+}
+
 static int test_maps_tearing(void)
 {
 	struct vma_modifier_info *mod_info;
@@ -674,6 +754,9 @@ static int test_maps_tearing(void)
 	test_maps_tearing_from_split(maps_fd, mod_info, &page1, &page2,
 				     &last_line, &first_line);
 
+	test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &page2,
+				      &last_line, &first_line);
+
 	stop_vma_modifier(mod_info);
 
 	free(page2.data);
-- 
2.49.0.1266.g31b7d2e469-goog


