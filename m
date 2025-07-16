Return-Path: <linux-kselftest+bounces-37399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E998B06BEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 05:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399F7176C6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 03:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF7D27BF7D;
	Wed, 16 Jul 2025 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlvXGTil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9327A908
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635169; cv=none; b=nv7YO60v1aTXWp1X0uTqANr/qHfvnDULTYoKQUQOQYgSICoBoBy1Ibko2JqbyWhJs6otOJdeSXPQnLMq3CYDsRVryS29eSeXI1d2IiD3VRxB1XnQSPysmMWDR6tDJum+tcrnFWkRsVE4D45KFjQuK8trNAF6GXB3afni8e8Py18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635169; c=relaxed/simple;
	bh=ZMGFntAQnjjtMoQxDdiUKIBvPxmH73C1FhJ2CMHVp1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sff1OgBW7k5/lp+KAqVBpIRsv9pKb6yoIjdx1c+xxce1sFDlHnBuZxN4OZUdlgCCNwLEy8guy1b94rLTCC7PXOQVay08wZ+2esSjPw+sa0AcMrRg3rLfwwF2gIjfM83JFUAoyVD+T94e+Lo1J7zH5deyQbvXRcqtvQl0pllThR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlvXGTil; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747ddba7c90so5094037b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 20:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752635167; x=1753239967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Li63ssKppcLITl1ITfej/YujyWpoLXNJQdKFDqdnOTk=;
        b=UlvXGTilHnFbR6Bw0/ZQtPiJApwjvLaRyQRdmJZM2Ne28bVk6pDu6fYOK2wY54rWhq
         8yY0vjE4qSMirX/xtCXr/fI8V6ePWRPXCJJHV5fRpo3WO7om3q1K+SphTIJz1aoqXELA
         mJ6wZ8cxjHC6LhFOLwClEU3s1FyRWBUN8kXyie4xj2BOls1mD0lXayVnzyiRDGIGucPY
         Fht5ZEjei0Cxo3/RVz6JDIGz+98VLbccpn9S96ie7BObwvKDLRk5wLOqroVGMazrZqTO
         QOxA3EnrVsqyEGnyyUwHFTnPxq5jDod8Nlfhn3bO4rSEMJdHxmqNOAqnl6yoHGGy7HtT
         1j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635167; x=1753239967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Li63ssKppcLITl1ITfej/YujyWpoLXNJQdKFDqdnOTk=;
        b=MPM0RtQUDuYCLRgXmo/0vu96VAA2bqwMYJQpkuU596LKX0B2VLEkKKbPSY5GeEQx51
         e8m1LnoWI3Zy0PSkdsRUdfY6bzEOqG3YddmrJnsA/boycbnarZdvV+rpe8kpBXYiL+sr
         F+eU+G5S5jWNt+V9KhrQ3mXXJsnH2FmD5J8PD/eeE0Ojy11WMp7goaI++4TylG9zlhak
         bFCfRy8XjqH5l+oAcbKWwU6o0w/j2PjeKT1jaB1We3ATgqGg+Z5pxslRssUdRzTAuRVW
         vnuF5Ydzs+JAo+FjV3QGxxeDH9osTq3kResPMwAjURmbQ2f4ase8lhE520w8KDkLVk83
         xUkg==
X-Forwarded-Encrypted: i=1; AJvYcCUs9tlgTKG3DYFVsmPj/Y79T0wwyMmwYbROOs49dIDiJOVAmvAZ66AgR68TPU6boSUB39jJA/zkGXvH2oeeFOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjpxtfy8X4oh6SubmyeQytBcv2XhS9GiofTCw4fRbcOymspku4
	O/57P3dvj6wimJMwMqeOXmJLlFt1lJKt3UOYcrR0oGgCK0SwYFcHt5f0KWVLTkuabEfixuIDhnf
	3tn9atQ==
X-Google-Smtp-Source: AGHT+IHN4KjxRUYFy2gmozTCR7TK1ofpV5QP2mqF+y0rY8P1k6j/G7f8VA9mG0zvAsbo/1BgyAC1yTm//HE=
X-Received: from pfvb10.prod.google.com ([2002:a05:6a00:cca:b0:748:f270:c438])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:982:b0:74e:c917:3b1a
 with SMTP id d2e1a72fcca58-75724c805c8mr1488713b3a.24.1752635166933; Tue, 15
 Jul 2025 20:06:06 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:05:52 -0700
In-Reply-To: <20250716030557.1547501-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716030557.1547501-4-surenb@google.com>
Subject: [PATCH v7 3/7] selftests/proc: extend /proc/pid/maps tearing test to
 include vma remapping
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

Test that /proc/pid/maps does not report unexpected holes in the address
space when we concurrently remap a part of a vma into the middle of
another vma. This remapping results in the destination vma being split
into three parts and the part in the middle being patched back from,
all done concurrently from under the reader. We should always see either
original vma or the split one with no holes.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 10365b4e68e1..764821ffd63d 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -416,6 +416,95 @@ static void test_maps_tearing_from_resize(int maps_fd,
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
 int usage(void)
 {
 	fprintf(stderr, "Userland /proc/pid/{s}maps race test cases\n");
@@ -527,6 +616,9 @@ int main(int argc, char **argv)
 	test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &page2,
 				      &last_line, &first_line);
 
+	test_maps_tearing_from_remap(maps_fd, mod_info, &page1, &page2,
+				     &last_line, &first_line);
+
 	stop_vma_modifier(mod_info);
 
 	free(page2.data);
-- 
2.50.0.727.gbf7dc18ff4-goog


