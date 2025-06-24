Return-Path: <linux-kselftest+bounces-35706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B344AE6FAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 21:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DFDC7AC136
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789102EA737;
	Tue, 24 Jun 2025 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHzLRaeQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6B3074BB
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793651; cv=none; b=ggbrgp1BdOaKlmv50Y2ek49z9a67b+n8T6KGs6bDliKUQodeJw1c7s8HWEjFsX/2Kcw6/R36OE7csw90Qu1gOga4293LOfeCixy4YrsHv5Rz6onsrqzGTd/7Sd1e7FllVbVqVjj87gBpBud6pFVmGHsc/9EPfaHtFk7gBfQlJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793651; c=relaxed/simple;
	bh=CkY0yRlPblz/oHTqqCyzbBSv1yWCABFDXWr+I+GLZGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m6KzEKhy824xgmp2bOmgQg+HeFYC9F/M7g4AWvCQJLaqnAPRge08R/6fkoasv5SCZuicxce3ND3uKagZrScw0Klwam1bLF4/pAOjE1A130GrBNBPvuxOT1jT9xFa/8hoDMdYO4F4dQ0iX/A6uaDF0C2MaU8nFYQa3YTvjfXUNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHzLRaeQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23638e1605dso41430465ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750793649; x=1751398449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTpxqo9rYzmnOlbgrt5I9x/wPv8qMNQnGNX8faPUhlk=;
        b=GHzLRaeQC0LkJtNgZWa/qpMHTsWpMQINWQ8IhwrlNgMlLXJdlk+JxhFYzKp2ez/zum
         fWSgsueafYBrAQ2p4mwl8DaSrs5yjqVtjvCvsWt3dyu85K35ofbTRxrQg50mq7E7xf7Y
         oy6PBLoX2pB7KnBdBbP/cvgcdvDhyxtNw97tEClUz/bfBvtZioa3snqNVawlSkoDy00F
         M5m8wVZPiKxdzGodIo2mrHjlclVjuwbi3UQgM6vwq4sSeiFoN3WuXgjawxOoALrzpJ6c
         PPboH49AN1J5Xs9DX/a4j5YY+qdWmJkCrAg0A78CRDeTGftvSktWRO45Fho2w5StJctL
         sOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793649; x=1751398449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTpxqo9rYzmnOlbgrt5I9x/wPv8qMNQnGNX8faPUhlk=;
        b=fDomYApJEM4oDS+KPI7y2IZih2ybf088TsCcXJY3gu82+LlzJZNL80josUUfJRbXgY
         mlu+nXgQO2cU6esRH0bL4NZ3TkNmwV4yiMel1k379P5vsJ0HNSvnGFjdT9JZcyCJRGUw
         D0dbjsW0gQO9zC9oxe49CChXo0hTsnOxTHZmy9pThoV3fuLBTEL0xpBTdG3t3s20usSp
         tKo1F/ctXJGjdN0U0893hN4IlRusNGazmhfPbZmCS0kcGrVn7Xix1W2mEMaYpgAAX5in
         H4cyx8WoQIE6cSIboMVoBbApT9jM5opxqhmBqsMUxcm+X2fleANhFgWx4txLwE+08/pB
         VBEg==
X-Forwarded-Encrypted: i=1; AJvYcCUnQiiMEMH5mihYgZsRem72zUJfqoKAfBNmZ7AzoU1FxJcmsPVbYG2DQgJ9Z2WptFxFCXVPkhB5Za10+dA32/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTbwArD0Uwoqa0ZHXpx44EnA8FerDK1C6OCrKylEjCTFW353Kc
	XTFDk52tIThQuNO3PymaEHiLdPfyO3JwfrzR+JbMYBKHR3lsbDwwshw9Cs3fB3p3gICmECeDCTb
	Dz+dcHg==
X-Google-Smtp-Source: AGHT+IEYzVFlaafTK+NJEStVfwqaXhWigt92zShqce3bvq87pwtPR0sp6zBPOudQkJC7xdMwRNzMBfU8jZI=
X-Received: from plbkk15.prod.google.com ([2002:a17:903:70f:b0:234:908f:4e22])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8cd:b0:236:6f43:7047
 with SMTP id d9443c01a7336-23823f87ed4mr8275335ad.9.1750793648973; Tue, 24
 Jun 2025 12:34:08 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:33:55 -0700
In-Reply-To: <20250624193359.3865351-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624193359.3865351-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624193359.3865351-4-surenb@google.com>
Subject: [PATCH v5 3/7] selftests/proc: extend /proc/pid/maps tearing test to
 include vma remapping
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
space when we concurrently remap a part of a vma into the middle of
another vma. This remapping results in the destination vma being split
into three parts and the part in the middle being patched back from,
all done concurrently from under the reader. We should always see either
original vma or the split one with no holes.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 39842e4ec45f..1aef2db7e893 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -663,6 +663,95 @@ static void test_maps_tearing_from_resize(int maps_fd,
 	signal_state(mod_info, TEST_DONE);
 }
 
+static inline void remap_vma(const struct vma_modifier_info *mod_info)
+{
+	/*
+	 * Remap the last page of the next vma into the middle of the vma.
+	 * This splits the current vma and the first and middle parts (the
+	 * parts at lower addresses) become the last vma objserved in the
+	 * first page and the first vma observed in the last page.
+	 */
+	assert(mremap(mod_info->next_addr + page_size * 2, page_size,
+		      page_size, MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
+		      mod_info->addr + page_size) != MAP_FAILED);
+}
+
+static inline void patch_vma(const struct vma_modifier_info *mod_info)
+{
+	assert(!mprotect(mod_info->addr + page_size, page_size,
+			 mod_info->prot));
+}
+
+static inline void check_remap_result(struct line_content *mod_last_line,
+				      struct line_content *mod_first_line,
+				      struct line_content *restored_last_line,
+				      struct line_content *restored_first_line)
+{
+	/* Make sure vmas at the boundaries are changing */
+	assert(strcmp(mod_last_line->text, restored_last_line->text) != 0);
+	assert(strcmp(mod_first_line->text, restored_first_line->text) != 0);
+}
+
+static void test_maps_tearing_from_remap(int maps_fd,
+				struct vma_modifier_info *mod_info,
+				struct page_content *page1,
+				struct page_content *page2,
+				struct line_content *last_line,
+				struct line_content *first_line)
+{
+	struct line_content remapped_last_line;
+	struct line_content remapped_first_line;
+	struct line_content restored_last_line;
+	struct line_content restored_first_line;
+
+	wait_for_state(mod_info, SETUP_READY);
+
+	/* re-read the file to avoid using stale data from previous test */
+	read_boundary_lines(maps_fd, page1, page2, last_line, first_line);
+
+	mod_info->vma_modify = remap_vma;
+	mod_info->vma_restore = patch_vma;
+	mod_info->vma_mod_check = check_remap_result;
+
+	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
+			    &remapped_last_line, &remapped_first_line,
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
+		/* Check if we read vmas after remapping it */
+		if (!strcmp(new_last_line.text, remapped_last_line.text)) {
+			/*
+			 * The vmas should be consistent with remap results,
+			 * however if the vma was concurrently restored, it
+			 * can be reported twice (first as split one, then
+			 * as restored one) because we found it as the next vma
+			 * again. In that case new first line will be the same
+			 * as the last restored line.
+			 */
+			assert(!strcmp(new_first_line.text, remapped_first_line.text) ||
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
@@ -757,6 +846,9 @@ static int test_maps_tearing(void)
 	test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &page2,
 				      &last_line, &first_line);
 
+	test_maps_tearing_from_remap(maps_fd, mod_info, &page1, &page2,
+				     &last_line, &first_line);
+
 	stop_vma_modifier(mod_info);
 
 	free(page2.data);
-- 
2.50.0.714.g196bf9f422-goog


