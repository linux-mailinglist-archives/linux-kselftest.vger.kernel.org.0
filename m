Return-Path: <linux-kselftest+bounces-37247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B68B03F1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B7E97A79B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853324DCEA;
	Mon, 14 Jul 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aunS1/m8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC0F134A8;
	Mon, 14 Jul 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498016; cv=none; b=bCOmjc4eCiERJ/ns8O5sVsCrYr1rr7PV7HQUwTFTlWLpT+LN0DJ0gbxaPSIFaX6Pni38vJIccut48X0t4Io5Lx8qU/oIXpZmvY1hGez1NR/JcdJiIJsfJU7whfB8ig8TrhQR6M13yt6s1D7WZJ/r3oUGD0m976FmFWLttzpMOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498016; c=relaxed/simple;
	bh=2u3fPNo1Pje+h6zL6A/5AcSTTbLpNru4v5UcLmAhVq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDvglnr1yrZDIRHFBQp8QGgia7EUA63iG+RZW6E0QJsg2QZyc3sxDG0gorKQylwqbZjuaoJa6+BgsDMECp/17MRFEdof+wsMcfO/oP2/G5l5yonJ5l6YyiIBBXDaR8C2i3m9+AMUWNUk8Nd1A4V6fT9aVb9PoYNMf3QnP0+b2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aunS1/m8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234bfe37cccso34577225ad.0;
        Mon, 14 Jul 2025 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752498013; x=1753102813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdhygjTWkYpaSFBu0DB7UKG87wxSOP/hOy49fUGZyzM=;
        b=aunS1/m8VBm9Exi7HsifvAPLK/NlXM6YapS3yejayvnUk/GsavejhFBaum1DvBHHTl
         5P6TmoGk8/oj+zSwr3y7HSr3K8LQCcMG6cnb5mm8WVn9mAJl5arwLcSxR9oJZsWyrAGy
         cPlZ4yJNZ5aSlVRXVIT7/HILvX4xPm+mNf4i88hg0704jXzDWrehNvMVfOhROMw36osA
         UELkV6bcTp3O3MiiDkID8vZ5RSRLhYmhKMFKCDARX/oeK3Pt34YaCh1/Y//5+VBrNR3v
         r3XZXhf3A+zTdTSJ5rpupRJ7X7DOJ7lqcphMIaKxqLmkXELB2cBuRKI25270z3K3yn3i
         XMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752498013; x=1753102813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdhygjTWkYpaSFBu0DB7UKG87wxSOP/hOy49fUGZyzM=;
        b=pFv73GhoppG8fJdh1BAAz9b+DhmFSsK9rygr366l+/MaCW227O6MdgLBkF5EAUP6aL
         wWHRhScCcZMlaG3JtIsr2h8rDDNJmtCccXvaHr+RvrP+EcoOU63QmlvlbYC2mEwND16f
         T9YOK7V/VLj+fnuAtP/N5zbPu+NNJPkkFXM1zYWT3bWdChOs+GX9S7XQCU9Nbpdx3ze5
         HASo0FH9D2V8DLNbhCY7LLCL7RyGXe7Zapc/0QLsFpU8zuCtYvrSnCo3vZN1oZNKyaoe
         XUHgcAnYzE0NcwUcJOqxTaC+P7i2jdzZhVoxq+7wmyJ357BGrPaGmJt5bTlwQhlOhOPy
         32HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhcZKyeP7ixi0Y+ZSb5MS3EmbiPjvshB9bnwxwWELj9wuVBfErqbVw1m0rOm/ZvgojiJi1gK4WncQWXc7lQoB/@vger.kernel.org, AJvYcCWqRG9wNyizfq7rNYxAODGczyqxR49+De5M4RI8Cg8ZwcEQwJAol0AyDQmCjKpmz9NXewlJwTGJdRIfn+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfIkDB4sXXdo6V6YMLm3klK6IqDssH6uQ+haXMHnL0mXFNxtK
	TtmBOZiv6sa/d2l3SeMqJmMKVx2sskG8Yem+ePoK/cTV80NA6GKg8TEr
X-Gm-Gg: ASbGnctIwCVFl1LzJv+MeerD3icZxv7XaKTQS51zC9E4RBRef4QwixgHNUoDQJKRo9v
	+NnWlSNs8umaMbJdzmps1OXUD/BMscrzRmDnKnS8oXrFioHn7CW9PKeiWImpIun8/H1bqVBRDjO
	49shi+QbZ2oojvuu+LPmt7Ohg6PDDoA8vuQDT4pZertMn16qEItW+EOEzRnpEtHq950EkRXPoY1
	BPJIwHb3Ljv84QGDoITxwtmfWGO50/ORLgIm1/afaEMm3F2yBtxuZ/GaRUG0bxFgtxgvEE48n7l
	cb4yxSDNFLxwmJqBf2/0NYqaDz6TIIla5bsZ/djcGzUr6aEyg+I7BzwJHSXgWh8vGp3VJASFrH9
	iPdsYUxyku3HbHfrHJwEUMoPUit7WgAaTZHctg7i91QuO
X-Google-Smtp-Source: AGHT+IGkJasHX+Ton3MShtwYeiZUNwYoffEjiSeQoYX4R1hV6/KiAc5FOwj/t95fynIJKIJcLYj6Rw==
X-Received: by 2002:a17:903:46cd:b0:235:655:11aa with SMTP id d9443c01a7336-23dede92f44mr204562665ad.39.1752498012991;
        Mon, 14 Jul 2025 06:00:12 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4335c8asm99221105ad.167.2025.07.14.06.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:00:12 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	wang lian <lianux.mm@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Liam Howlett <Liam.Howlett@oracle.com>,
	Shuah Khan <shuah@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	gkwang <gkwang@linx-info.com>,
	p1ucky0923 <p1ucky0923@gmail.com>,
	ryncsn <ryncsn@gmail.com>,
	"zijing . zhang" <zijing.zhang@proton.me>,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] selftests/mm: refactor common code and improve test skipping in guard_region
Date: Mon, 14 Jul 2025 21:00:09 +0800
Message-ID: <20250714130009.14581-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the generic `FORCE_READ` macro from `guard-regions.c` to the shared
`vm_util.h` header to promote code reuse.

In `guard-regions.c`, replace `ksft_exit_skip()` with the `SKIP()` macro
to ensure only the current test is skipped on permission failure, instead
of terminating the entire test binary.

Signed-off-by: wang lian <lianux.mm@gmail.com>
---
 tools/testing/selftests/mm/guard-regions.c | 9 +--------
 tools/testing/selftests/mm/vm_util.h       | 7 +++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 93af3d3760f9..b0d42eb04e3a 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -35,13 +35,6 @@
 static volatile sig_atomic_t signal_jump_set;
 static sigjmp_buf signal_jmp_buf;
 
-/*
- * Ignore the checkpatch warning, we must read from x but don't want to do
- * anything with it in order to trigger a read page fault. We therefore must use
- * volatile to stop the compiler from optimising this away.
- */
-#define FORCE_READ(x) (*(volatile typeof(x) *)x)
-
 /*
  * How is the test backing the mapping being tested?
  */
@@ -582,7 +575,7 @@ TEST_F(guard_regions, process_madvise)
 
 	/* OK we don't have permission to do this, skip. */
 	if (count == -1 && errno == EPERM)
-		ksft_exit_skip("No process_madvise() permissions, try running as root.\n");
+		SKIP(return, "No process_madvise() permissions, try running as root.\n");
 
 	/* Returns the number of bytes advised. */
 	ASSERT_EQ(count, 6 * page_size);
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 2b154c287591..c20298ae98ea 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -18,6 +18,13 @@
 #define PM_SWAP                       BIT_ULL(62)
 #define PM_PRESENT                    BIT_ULL(63)
 
+/*
+ * Ignore the checkpatch warning, we must read from x but don't want to do
+ * anything with it in order to trigger a read page fault. We therefore must use
+ * volatile to stop the compiler from optimising this away.
+ */
+#define FORCE_READ(x) (*(volatile typeof(x) *)x)
+
 extern unsigned int __page_size;
 extern unsigned int __page_shift;
 
-- 
2.43.0


