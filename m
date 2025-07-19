Return-Path: <linux-kselftest+bounces-37641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065B9B0B15F
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 20:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB26563AEC
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAF328A1DC;
	Sat, 19 Jul 2025 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z7jCIRP0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F230289E21
	for <linux-kselftest@vger.kernel.org>; Sat, 19 Jul 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949745; cv=none; b=YXx6WbGPsbGUz+9249pu7uJcrwSEcHd0pZwKZev3VVXe8VvaKBHy4crVaM9JxY2LLDQxIo/ezXWN4nzyiUGFk7iEof5nO/8L27Ad7ImH9fIv2GYcYAIHZCnve7NO6gCCpnjQrAz24LydDRljRaGPJi6Hz89SJ3zQh6eguwQdv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949745; c=relaxed/simple;
	bh=UxAPbMUB0pIGsPbDU2jCpQ4QLRcvRQ4nl32Q3o4bVcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lNKji8vmIn0oJFtroNuvqUc8AFAR16BHORlP5hfobytKsER8wv6aGI8IZtIAtls3S38Uqj2s0jFaGqPRA1z7K9FBjyal0QYJ26N5oODe5Y1BaudIjs8FT5OJk3Paf4gh9qCxfMBrFszzEzIy7cklzmEy71BHsfjk8J4Z0Bbn2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z7jCIRP0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31215090074so4765883a91.0
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Jul 2025 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752949743; x=1753554543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6cmTk44WrbxZ0X4bw1vDDTZxTb31GhJvBzomPieJ1uw=;
        b=z7jCIRP06aZ79m68rgGkZdauMyP4bIIfd92fKB8nvHSgEf4GEP8Hqxsw+uLgL0YKYr
         qGgrk36gocTyXvdq6WjU+qe2Arez8x2IOKnYpYtxZgaKUPpxAA0cdAOAhtRgueyRc7P8
         utA9oSVO3f1ZcQD4JWwSInA0nZAlGzv2eSxNBNmy6AqiZJM9TDEKpZVt1Z0bTKZfMr5K
         eaKRIMA5Ymhks0Epf93ZmbLyQISt6HWgV9w6mtWTevH4Z7cmNmkPtvGPzULUu9kiysXa
         YPX0wNjGtaspsog+UAfic46By/yMi0RuYmE1xeGhpnlMj4z3eHyGpSf7C1xruqg4PIrj
         N6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752949743; x=1753554543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cmTk44WrbxZ0X4bw1vDDTZxTb31GhJvBzomPieJ1uw=;
        b=Ihkn3Th7V9g7RuEcVDoADf49mAWpzg2jN8ciCbSJFdivgvTXyM6a40jX0Mpx4V9VMk
         i6JvLsXHa7A7H3PhNBfRq+Emw+81es/amC8BuGc8rem0BNEac5TAfC4OXJP208KJ01sb
         gnSq2HCzCP4XbQiguy/E1ql7dmQAG94CiDvTLhVNYgsJ4qaWhPMRgZ35awIEjAZ/D4cb
         A8pVO3TuwkqCwPP6AMFwYQKln/t7L+P65nd6dqHa3DAxkyDh8hA/fDQQpwNafxicWmJt
         mpJ6T+3F7zlXj4ZDg7Va+keSzwTSOrITsDloJQUfB+noa25OG1sTJZ0OB2avPlnlJWJA
         mOfg==
X-Forwarded-Encrypted: i=1; AJvYcCV/HTYOfMQvljwz1rx0DOMe43KaLUfciWhML1xDP3Ce46t6xFbWtsPHCy3XVQ7a2PZzIuI2X2sCaXb5GWfCZ5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6XLHGZ59Vm0LwzFLODuHSKq3YJ4FSQ5JrixSJsZvG/jVfuy+c
	q+SFQF43QgtgCVyzKfks7IGwbVCpueBkRMVnf1mJHFKWWOSJ65IQVntAkc/s9WVGeFESj6yILWn
	BSgBKIA==
X-Google-Smtp-Source: AGHT+IFpR+G367NUdXqT4GjCDRW7uEBhYOCVViMZav6Hsk0eDu7mD5ualbj9xAJiOnJAq+Jb3OjyutTaGig=
X-Received: from pjbsj2.prod.google.com ([2002:a17:90b:2d82:b0:31c:15c8:4c80])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e47:b0:315:cbe0:13b3
 with SMTP id 98e67ed59e1d1-31c9f399399mr19658063a91.7.1752949743417; Sat, 19
 Jul 2025 11:29:03 -0700 (PDT)
Date: Sat, 19 Jul 2025 11:28:51 -0700
In-Reply-To: <20250719182854.3166724-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719182854.3166724-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719182854.3166724-4-surenb@google.com>
Subject: [PATCH v8 3/6] selftests/proc: extend /proc/pid/maps tearing test to
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
 tools/testing/selftests/proc/proc-maps-race.c | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 19028bd3b85c..bc614a2d944a 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -264,6 +264,35 @@ static inline bool check_shrink_result(struct line_content *mod_last_line,
 	       strcmp(mod_first_line->text, restored_first_line->text) == 0;
 }
 
+static inline bool remap_vma(FIXTURE_DATA(proc_maps_race) *self)
+{
+	/*
+	 * Remap the last page of the next vma into the middle of the vma.
+	 * This splits the current vma and the first and middle parts (the
+	 * parts at lower addresses) become the last vma objserved in the
+	 * first page and the first vma observed in the last page.
+	 */
+	return mremap(self->mod_info->next_addr + self->page_size * 2, self->page_size,
+		      self->page_size, MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
+		      self->mod_info->addr + self->page_size) != MAP_FAILED;
+}
+
+static inline bool patch_vma(FIXTURE_DATA(proc_maps_race) *self)
+{
+	return mprotect(self->mod_info->addr + self->page_size, self->page_size,
+			self->mod_info->prot) == 0;
+}
+
+static inline bool check_remap_result(struct line_content *mod_last_line,
+				      struct line_content *mod_first_line,
+				      struct line_content *restored_last_line,
+				      struct line_content *restored_first_line)
+{
+	/* Make sure vmas at the boundaries are changing */
+	return strcmp(mod_last_line->text, restored_last_line->text) != 0 &&
+	       strcmp(mod_first_line->text, restored_first_line->text) != 0;
+}
+
 FIXTURE_SETUP(proc_maps_race)
 {
 	const char *duration = getenv("DURATION");
@@ -523,4 +552,61 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 	signal_state(mod_info, TEST_DONE);
 }
 
+TEST_F(proc_maps_race, test_maps_tearing_from_remap)
+{
+	struct vma_modifier_info *mod_info = self->mod_info;
+
+	struct line_content remapped_last_line;
+	struct line_content remapped_first_line;
+	struct line_content restored_last_line;
+	struct line_content restored_first_line;
+
+	wait_for_state(mod_info, SETUP_READY);
+
+	/* re-read the file to avoid using stale data from previous test */
+	ASSERT_TRUE(read_boundary_lines(self, &self->last_line, &self->first_line));
+
+	mod_info->vma_modify = remap_vma;
+	mod_info->vma_restore = patch_vma;
+	mod_info->vma_mod_check = check_remap_result;
+
+	ASSERT_TRUE(capture_mod_pattern(self, &remapped_last_line, &remapped_first_line,
+					&restored_last_line, &restored_first_line));
+
+	/* Now start concurrent modifications for self->duration_sec */
+	signal_state(mod_info, TEST_READY);
+
+	struct line_content new_last_line;
+	struct line_content new_first_line;
+	struct timespec start_ts, end_ts;
+
+	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	do {
+		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
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
+			ASSERT_FALSE(strcmp(new_first_line.text, remapped_first_line.text) &&
+				     strcmp(new_first_line.text, restored_last_line.text));
+		} else {
+			/* The vmas should be consistent with the original/resored state */
+			ASSERT_FALSE(strcmp(new_last_line.text, restored_last_line.text));
+			ASSERT_FALSE(strcmp(new_first_line.text, restored_first_line.text));
+		}
+
+		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
+
+	/* Signal the modifyer thread to stop and wait until it exits */
+	signal_state(mod_info, TEST_DONE);
+}
+
 TEST_HARNESS_MAIN
-- 
2.50.0.727.gbf7dc18ff4-goog


