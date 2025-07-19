Return-Path: <linux-kselftest+bounces-37640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E7B0B15B
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 20:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263FB56393B
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 18:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A72882C0;
	Sat, 19 Jul 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWOya/0N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A928980F
	for <linux-kselftest@vger.kernel.org>; Sat, 19 Jul 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949743; cv=none; b=KLMaoFFFwi3Gt810dF4S49Y5cIxbGqdeUm/0kUmsoYjexWMbhx6geVLxiy7tVX1mGbJnopOa5nPBGPapOLwqlDvaJEh36ilJFaR9rMOFPvdd0T4x0irE+0sE+aflOnM+m+53DT+02wz2WQLS5i08bQ3xPcPKm6iznY0/ZoYePo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949743; c=relaxed/simple;
	bh=EoONMavb9oQd28yIVVpYa/F0BisZ+1FFpf7/OKMIWio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HYJxHwHr0GmwyUVRWpdtdQSLczzhyvOagHZwp6RfcnSGYw4wUitiICo3Gai2a3vnQ3DZ+AUyKoh5pEA+h9Pt9l+20O8QeD4XHAFgSf6zSmnZ7US2bdb2L6YvrQcAfAsxPnqAQ9qVBG1WapPzoNWNY3PFAz0c9lQSY0EiKJQ1gRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cWOya/0N; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748fd21468cso2915830b3a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Jul 2025 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752949741; x=1753554541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZIfIkvrizFRlwLe+eL2JUXe03By99qwQvMdi3R4EP0=;
        b=cWOya/0N8JJeghD70tjbNmbMG/YkjV6kxcDqhe1FKJ8CRStn7JFuzZ4HH1FQAljMDt
         wh/Akl6nHPDUcW/pjlIhgcFCTscgPUo4wc/g5FofgyczbfuGADqMqkqewKzfv1dLFLN+
         HtgBzK3s9gESuxh3uPgN15pj56yfSSi0pPGquaDEDAIqKY+DV5GzjIkKu4OHaXu0npiZ
         l8rQCzKtTDshPRA3wWfswSCeILDV9dx3KfCSqKnlSaAkThPEZ5iBmDbZpP7hSy9wtLxW
         3J7lae4kEbg0H4WhiAe+X0Px07R3R9yF3tgGPofU19RD333iDRdBNdSCVi8OPQSr+onb
         /VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752949741; x=1753554541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZIfIkvrizFRlwLe+eL2JUXe03By99qwQvMdi3R4EP0=;
        b=ePhCU5eJTdH7HWvcwS5yLuxZpxPTHjkXuY72xN/o2H9CVplX1lbRO0nOlhcZ6SsP0h
         4DGUNRbukmwdGyzE3aazUBG1n29UyKBkxOE9vIUbLtBmrEhNb6WE0HT+jgTS1iK+vnmo
         MntlHYCAdoM77/iYuM/hYNg5FWyAB87meE71vCdLmfG56lv9QCmn95l2HTtnP/HQ2lAq
         iAdXyqh4wDYfFRqH3RfCg7wcU2irQpBKl9EqXM1lZyu8OTvifFNyGfwPrXy0oVG10qBw
         oUiSog5M/uR3YNR0KrbEjKO/Tni9OzUIyLfjuopVuU2SsFJdOptgJg9PQ9f4ZoVH+5AU
         F8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH8q4lldFr8yiIF7aKfyuTM1B7HDrOlAJI2hRehnvQ/Ra5E94gNY7Q3Zfj+H/0R3fN18jDah+otLeyCPqhFbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9OLkixNHPrGxSA5yNerT8JgRmTQzG07tSfPAZ9ZO9hJb89pDc
	TkbWUWe+aX0OyYv3l4SGRv8fd23AqmcpkQzJaV4bo32B5iukox5WeblSCqb3FfRbOLDg/1Ndm5V
	efdh1dA==
X-Google-Smtp-Source: AGHT+IFtvDgzrvc853iwGTNcdFPdZ36TnaM/IGuEwlU0uCtz/OmMBvPrUhcVv4vqThaoN95p4kZpK9V/M5s=
X-Received: from pgbn3.prod.google.com ([2002:a63:5903:0:b0:b2b:f469:cf78])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1fc3:b0:235:c9fe:5929
 with SMTP id adf61e73a8af0-237d7b649bbmr22450234637.42.1752949741279; Sat, 19
 Jul 2025 11:29:01 -0700 (PDT)
Date: Sat, 19 Jul 2025 11:28:50 -0700
In-Reply-To: <20250719182854.3166724-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719182854.3166724-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719182854.3166724-3-surenb@google.com>
Subject: [PATCH v8 2/6] selftests/proc: extend /proc/pid/maps tearing test to
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
 tools/testing/selftests/proc/proc-maps-race.c | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 5b28dda08b7d..19028bd3b85c 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -242,6 +242,28 @@ static inline bool check_split_result(struct line_content *mod_last_line,
 	       strcmp(mod_first_line->text, restored_first_line->text) != 0;
 }
 
+static inline bool shrink_vma(FIXTURE_DATA(proc_maps_race) *self)
+{
+	return mremap(self->mod_info->addr, self->page_size * 3,
+		      self->page_size, 0) != MAP_FAILED;
+}
+
+static inline bool expand_vma(FIXTURE_DATA(proc_maps_race) *self)
+{
+	return mremap(self->mod_info->addr, self->page_size,
+		      self->page_size * 3, 0) != MAP_FAILED;
+}
+
+static inline bool check_shrink_result(struct line_content *mod_last_line,
+				       struct line_content *mod_first_line,
+				       struct line_content *restored_last_line,
+				       struct line_content *restored_first_line)
+{
+	/* Make sure only the last vma of the first page is changing */
+	return strcmp(mod_last_line->text, restored_last_line->text) != 0 &&
+	       strcmp(mod_first_line->text, restored_first_line->text) == 0;
+}
+
 FIXTURE_SETUP(proc_maps_race)
 {
 	const char *duration = getenv("DURATION");
@@ -444,4 +466,61 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 	signal_state(mod_info, TEST_DONE);
 }
 
+TEST_F(proc_maps_race, test_maps_tearing_from_resize)
+{
+	struct vma_modifier_info *mod_info = self->mod_info;
+
+	struct line_content shrunk_last_line;
+	struct line_content shrunk_first_line;
+	struct line_content restored_last_line;
+	struct line_content restored_first_line;
+
+	wait_for_state(mod_info, SETUP_READY);
+
+	/* re-read the file to avoid using stale data from previous test */
+	ASSERT_TRUE(read_boundary_lines(self, &self->last_line, &self->first_line));
+
+	mod_info->vma_modify = shrink_vma;
+	mod_info->vma_restore = expand_vma;
+	mod_info->vma_mod_check = check_shrink_result;
+
+	ASSERT_TRUE(capture_mod_pattern(self, &shrunk_last_line, &shrunk_first_line,
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
+			ASSERT_FALSE(strcmp(new_first_line.text, shrunk_first_line.text) &&
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


