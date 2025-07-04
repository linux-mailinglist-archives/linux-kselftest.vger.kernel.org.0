Return-Path: <linux-kselftest+bounces-36500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3130AF879E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 08:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A111544536
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 06:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C6422B5B8;
	Fri,  4 Jul 2025 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fh58pI9k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0794223DE1
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609257; cv=none; b=F8U/O/LCUqRU8GB8Y6igdhZ/AeESajDXha/LHifRawclTJd1k0wMbbbS9WIKu0OEyACb0PSgmIUMe0ZkD+jXSR0dF+o1i/R3d8nANUh83WIOBsDf4VGoOgvuF9v9wqstHYcSjoo0YQ1dXJLcW/JYPgcb0hm50uRhKu9beF7w7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609257; c=relaxed/simple;
	bh=ulewSdFhhtT6XYUvitzcBD75LHyogn8pm3lfZUrI9VI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NMkNM1raQrQmTdyg4bqDx9g6GzxgHpp6bBoxRtVBLzjykcEtIWfISIDMJoaPgT7Me9ggcJvSgIoc2LCgdkqK01oBe3Yb+I7L9FDkCtyB795r5ZnM3njGkR8uoR4s6q9op6rv6QsyxSF/DNB5qK3DCYDoqXVd4pBdYh5PljRirtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fh58pI9k; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74913385dd8so1069634b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 23:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751609255; x=1752214055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwmJhXkBZ0rkJP8ZDJsJXdxfIUoApnDNh42agcrLiOc=;
        b=fh58pI9kE4RSWF3lEcppnc3bOQwmyYNocvqm0Ts/0CvM6SBSuPOGT/JgnVi3R7QLCE
         5wne/xGTSUNn4elvupvomd86kItawhJcex1UiCNHTHeNEq28hlygbBYsSZLhG6+KdQCW
         Na2X4IpP0nC/d7UI5wrsGH6wc+4nDeTPTb5DTaNTpG59uPB9rR2mw+Wqzj0sgHYYbsw/
         +zNYy5ziY+IWKZjFuq2/CzlNR11mj5mkQLAfZgTnL+aThdGsJKzwPMrgK+CEkabWFcMe
         IO80vO40XD3XBZfltX+FPRLLpXvUvCIYrd9PpBztIlRq6LWhn8mdrxCVW7jsNdPgflbc
         Rhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751609255; x=1752214055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwmJhXkBZ0rkJP8ZDJsJXdxfIUoApnDNh42agcrLiOc=;
        b=lHzUKcxfdZdMwqKZ9oPk3O0rKfJJtPY2rwhcc1Ae/DZzza8lvim3oaKjYfl3RJg9P8
         5WSKV3mY/8TmPptAwPeL1BjoJ3z84cVj0iBpPaZ/SYVgZTFm4T1qMQ7DDQEvHOUY0KVI
         ABd00uEzl0K1oeAuMftYTYhd4ltooHgVFFmjaLASbdKw18kHDe+r7wo6Xz6Vb7uuwLwD
         h+zpAMyOR0LxizjSDe2HTNksn3CGZ7evrB5OMjM52GA6wGFhTYgN2bgQBwQLKrBAnzyD
         cEeG69F7LAE3o/ZOjCOSeNm5ZQYp6Wve/7o+beDQpAujpXsDIdfbQhFw1YnCJ+mirK3Z
         4hYw==
X-Forwarded-Encrypted: i=1; AJvYcCXrg/j7IHJ83Nd7wNVAHjcDjW8kwLqtWeKk19bPsGuvHqA44Hqpng2m5WTV05/AYrYUqjJxe5V5a2hooGGBbgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBA1XZb+k9/5q79O5tU92uRAMRFaAGti3FZsbLyNaQg/n4xnmf
	8y2M37K8rU9Yt27eNcJMDG7VoMTLLnrzFVjUO3dKFdLiNjXOMvgPbEVu6w5YWO4OSAQXEh3Cc3p
	aMNAD7w==
X-Google-Smtp-Source: AGHT+IGoB8QNnIkSWC4/zUTdGlarrbysVsWS8O8UNA9J6spZjeT17zKRWVRCaC7cIc1X4P3itAYlZ+WiQX4=
X-Received: from pgah2.prod.google.com ([2002:a05:6a02:4e82:b0:b31:ebae:e100])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914c:b0:220:a241:91a5
 with SMTP id adf61e73a8af0-225b85f40demr2440780637.16.1751609254814; Thu, 03
 Jul 2025 23:07:34 -0700 (PDT)
Date: Thu,  3 Jul 2025 23:07:20 -0700
In-Reply-To: <20250704060727.724817-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704060727.724817-3-surenb@google.com>
Subject: [PATCH v6 2/8] selftests/proc: extend /proc/pid/maps tearing test to
 include vma resizing
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
space when a vma at the edge of the page is being concurrently remapped.
This remapping results in the vma shrinking and expanding from  under the
reader. We should always see either shrunk or expanded (original) version
of the vma.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 523afd83d34f..10365b4e68e1 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -336,6 +336,86 @@ static void test_maps_tearing_from_split(int maps_fd,
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
 int usage(void)
 {
 	fprintf(stderr, "Userland /proc/pid/{s}maps race test cases\n");
@@ -444,6 +524,9 @@ int main(int argc, char **argv)
 	test_maps_tearing_from_split(maps_fd, mod_info, &page1, &page2,
 				     &last_line, &first_line);
 
+	test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &page2,
+				      &last_line, &first_line);
+
 	stop_vma_modifier(mod_info);
 
 	free(page2.data);
-- 
2.50.0.727.gbf7dc18ff4-goog


