Return-Path: <linux-kselftest+bounces-41513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E498B5826A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 18:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BAA1A207A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1092727ED;
	Mon, 15 Sep 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zV/k/JN+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4E1D516F
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954754; cv=none; b=qBd+DDOJvJF1B5zPPMS8nKP++AeaGEEi1egXDSuN4YPzpOPjCsTVCSjWBy3EblB6SDJPPM1aQHXz6XomSxR2Ag4bdbOJPG/dZ3jI7fdmbkA/h4oxTLlBj8TxIMRWvctU0Oxw/rqoSluGIjqjQeN8IRzoh8sR5Qa9fFO6JigCPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954754; c=relaxed/simple;
	bh=vPqrFhzsoS56yk34gogqjEXAKiAKcL51MnvFt/0vTxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kJ81oU1Fmdcf5696EukggPVB/j0Z1/bw/RSel0R1qIuOy6w2TgdhsnTRcZd7FiO9wDYf6mWVXq9JRU6a8RSnBCTopQ+LiKbH0CTjemvFSwom30DGyvS5qfLszHfQYr9cknmyWfG5UpN/RFgClxJlFhrVuBn8/VPI89CxBOYoohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zV/k/JN+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244570600a1so48031355ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757954752; x=1758559552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dh1IS3JVHOf86RTcG+zb9g2w/Ys+63vuY/qru+PreQ=;
        b=zV/k/JN+MEs5mTleaLd/vdGTldfkvMs9MFHiB7jKUhkcINpmK79TDVqdPin9BNv2o9
         VmNHWv406Dj7sIufglyt8C8zDiLy6lRB1+z8X869/5iTJjhJzWOfVuWbS6XBK4sgews8
         9u8DrFyTcvo6UUdgtRbWBQ26Mv6zghSrdvgX/pP/eGJnD6rObeFKl22e3foOx3Y+9LMI
         k2kwvqw+ODGe0A4rAoQ80qoiSJFar4+n+1vByHVOeso+429EXL//YmjNqu79XREIRQ9+
         bgAq4lqrkPTv8udsm19RkT16QSMiF+UZ7wUDgdnBMrOD+7rjvVUBridRM4Ef9TB4Idya
         t6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954752; x=1758559552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dh1IS3JVHOf86RTcG+zb9g2w/Ys+63vuY/qru+PreQ=;
        b=gEqiXuUSb1GBWUUhLdiFCmWyLU1ow+hRXpQEKy/HDPGVZUDcrccOdcroN6N+ZvpPqO
         59o3fLYkNyx7PcqDSi6gcFT2h1d2GPagQ6HOR3io6ryD3hTKSVWsFzqel29OBqaKzaWS
         9kt3FXCBXT6mOY4f7VYLHu/qPp/UviIKtznZemjwPHAYwbZ6xP2lTaP/tUBINwENECzX
         x3ZE+1gsDCPOP+XQ+7NpSgxlGYjwy/jyxE3GdYNmMKwbSXuelIUhHlqudIjn2LxjtZ2k
         larTeHPOsTKZ3/MzQDi95goWFbuvIQ49i9GWzleMG/HmKHCnEbNuQjyEVekeezmyiiP1
         GSKg==
X-Forwarded-Encrypted: i=1; AJvYcCXissCEUOS800G9llAspFoqXVx99ZPAGkY4RmfKARcSINv3FFjy/iRIKjz5cTjcofe1i7M9LblonxrXmaWJhzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwItIeKZGNgC7c7pr4+50hpq8MV6gK96rsplq2fWLDy8O1snST4
	z9PtXb45THWgw3NKuBkkNtMi4KNnqcRqR8eTtnZOAoWMmRU9N3RUpov/IidZxLUxoHPOjG8tQuq
	9ZgLkRNKcjOUJLjhCVXmdJ33pBA==
X-Google-Smtp-Source: AGHT+IETeFsnzxOgNLMCiDHUaYpnu2vRB/Fb66R7+b7xgDA1s+PPQqB4+bTMKY9LvQ479LuxEWFmKDI75ZPJsp8Xlg==
X-Received: from plkb5.prod.google.com ([2002:a17:903:fa5:b0:264:7b3c:4fe4])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dac2:b0:24b:1585:6350 with SMTP id d9443c01a7336-25d2ac3c545mr185756655ad.11.1757954752355;
 Mon, 15 Sep 2025 09:45:52 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:36:32 -0700
In-Reply-To: <20250915163838.631445-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915163838.631445-2-kaleshsingh@google.com>
Subject: [PATCH v2 1/7] mm: fix off-by-one error in VMA count limit checks
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The VMA count limit check in do_mmap() and do_brk_flags() uses a
strict inequality (>), which allows a process's VMA count to exceed
the configured sysctl_max_map_count limit by one.

A process with mm->map_count == sysctl_max_map_count will incorrectly
pass this check and then exceed the limit upon allocation of a new VMA
when its map_count is incremented.

Other VMA allocation paths, such as split_vma(), already use the
correct, inclusive (>=) comparison.

Fix this bug by changing the comparison to be inclusive in do_mmap()
and do_brk_flags(), bringing them in line with the correct behavior
of other allocation paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Chnages in v2:
 - Fix mmap check, per Pedro

 mm/mmap.c | 2 +-
 mm/vma.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7306253cc3b5..e5370e7fcd8f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		return -EOVERFLOW;
 
 	/* Too many mappings? */
-	if (mm->map_count > sysctl_max_map_count)
+	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
 	/*
diff --git a/mm/vma.c b/mm/vma.c
index 3b12c7579831..033a388bc4b1 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2772,7 +2772,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	if (mm->map_count > sysctl_max_map_count)
+	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
-- 
2.51.0.384.g4c02a37b29-goog


