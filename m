Return-Path: <linux-kselftest+bounces-41953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FAEB899A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01FEE7AD846
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF57311C27;
	Fri, 19 Sep 2025 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jaVaMUFL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4E30AD18
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287220; cv=none; b=TJF6o98TjopddjnwrVDQ9P+lOcRf9J8ALNiq/eFXO2eEjGQeQ0DEMbGh7hJMPcSR96CSHaAVb+8TTdrCRR4Zy8jwRj0bDpUzB2uzltpqMl3zfmAaEfrYhPXSQDDEPzbuxmYoIcDc14CNkT/Ukzf3vrYDc/6FsL7PEgRCkKSexY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287220; c=relaxed/simple;
	bh=Gza32SKoO3l1Cxp11yE7x1EtLYd/1eQwu8OxMPOOBuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOgTtqkqEIdXk2D6O2YoXdb6KB0p+pipQOluXNmNlXzHVVhrBc0Y2+4A4pcKHTUnsHQF6o4otMxCM6pp3bhbHjcro39/z1fbPSA3aEsVELiaAT3B7ZlDMYMuotds+C9MY/qm46V1QO7XB30T+BF3GokwTpTxE9GwFpsdpkBtGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jaVaMUFL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2680cf68265so15920605ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287218; x=1758892018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urmko1apH8CcrUCNE6fCIsulid4np4tADfs+rqxRds4=;
        b=jaVaMUFLBvkQl00wFJ74x0+km4Mlw3eOfdQoUv4Y4f4TzNi0CO5fWjWfoPn6oiVtmW
         ILvZpAwzitJLNt8ytnl2dmr/wVSOt5rQsYWzzMh5nxzjfcKaj4MOI5zeGyv6MMt6mKOn
         qskiu2SVsMeJ1OmT11kGRKDSBwaiC9opIW3UKfPD1dOfaffESCNY24O+3BnQVFLLqfIw
         LexCnWDOnzBLH5uvZx36vLDwIVZCQp02thmrUetSXrkNSFZGSv2OtLULieC3UKOBe8c+
         K+RD2v2mrpjJIQPAYa6fIq1SGi57SC8dC4LJqEa5PxspNcLWVbGoIYy8/B6Yz02fguKW
         0V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287218; x=1758892018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Urmko1apH8CcrUCNE6fCIsulid4np4tADfs+rqxRds4=;
        b=jp35y8L3f00RQ3kUWJAxFllT8Nt4Ybzzek7jip2ToQN6+xngLh0XlgAdrViRdrPAE9
         1WgzjMnXdA/hvM2sMahP3b7ua0mzG2sEcpe3H4lK9/9KLQAUCsN5tVznpY89JVd4d8jU
         uCA6ryCt8Fuj6U/1oonOLCCt4bEBmk86EGGojrYaIgPIVtFwMbaTabh6pD6h9WvXMko/
         1Jo9/sXMa+980O0ObsVDlmbTdfWSRlHJH98GuhylKqv/1Jck1VQFxyDUCsXEcY9xt7vP
         el43hSyvpaAMm7VXSMqEYFkIGbNUa/JjiViGwKTtlv6kNGy7wxVNQmEHCC9eiSlrGuY5
         7VhA==
X-Forwarded-Encrypted: i=1; AJvYcCXiCnY+XY+9qGXcJI58Zp5URBibb16iyuLdD9KbiadEtuZ2Z652INAZiG+mltURhWikfnz3RHitKm9Q2/lTc9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDmJgTooHmiR+OSQgIyWiBetSkgC+PA3MRpviO2ITQcMft76+
	6LV7GfrX11mxh+zdVov3k3UCb/ME98atu0AmBSTSIO0nKzlCJ2UTkzoeqMLoCSilOdU=
X-Gm-Gg: ASbGnctFtG+giVlGS+DwZC1CI3oCsHp3FkV6IAlAWZmpwFYSHZGJMquji2OlZeeX4fj
	2DbZcZn9rLjRwuELVcu/P32GV51CsKlvCNQoZHcpaHCwz4OlShl6IsxfvaQOEPjwL6l2XmTHdjS
	AQ+2RQHXnNiCFg3AOymMMlkX2rUgcNtx1Vl32ymQipDaJfnI1K6aqAQ0LiPMXAw+vQziVZ/UFj2
	cJGngrTKsqO99ggX3PAkPsMj16p2LrGYyd3wwd2AjYTvidMi3P5UIEG1s1ECs77RN1Kad+Vr3V6
	HdmQEd3IJF+i9EF5tRto63BjqZMZePgEnD8XeBTYju9lcWOVVlE+pwHo7RUp6HiGlpHqvH0UwGv
	a9YkcEsC2M4gLJp6XcSMLxxsvImPG8+yDvAPh9oeFmXI3Gwy4FuU5we8dOg==
X-Google-Smtp-Source: AGHT+IGQm2BwTZf4DiWqvF+5ZIqZW3gwljLzK2HSeWpzsuqCCgPkWpl1dn6miiJgWhzknn4pwOCtSg==
X-Received: by 2002:a17:903:17cf:b0:264:567b:dd92 with SMTP id d9443c01a7336-269ba55253fmr48189625ad.52.1758287218434;
        Fri, 19 Sep 2025 06:06:58 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:58 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 8/8] mshare: selftests: Add test case to demostrate that mshare partly supports THP
Date: Fri, 19 Sep 2025 21:06:20 +0800
Message-Id: <20250919130620.56518-8-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250919130620.56518-1-linyongting@bytedance.com>
References: <20250919130620.56518-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, mshare doesn't support madvise(MADV_HUGEPAGE) to make pages
become THP page.

Thus we need to set /sys/kernel/mm/transparent_hugepage/shmem_enabled
to 'always', enabling mshare to acquire THP pages in a best effort way.

This case is quit simple that set up a mshare memory with 2MB size,
than use memset to fill the physical memory and verify whether THP
was allocated by reading memory.stat.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/memory.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/mshare/memory.c b/tools/testing/selftests/mshare/memory.c
index 4bb0d22b9c03..5132210b1465 100644
--- a/tools/testing/selftests/mshare/memory.c
+++ b/tools/testing/selftests/mshare/memory.c
@@ -68,4 +68,22 @@ TEST_F(memory, swap)
 	ASSERT_GT(swap_size, MB(2) * 9 / 10);
 }
 
+TEST_F(memory, thp)
+{
+	/* fill physical memory */
+	memset(self->addr, 0x01, MB(2));
+
+	size_t huge = read_huge_from_cgroup(self->cgroup);
+
+	/*
+	 * mshare only allocate in the best effort way, and
+	 * don't support madvise(MADV_HUGEPAGE) to change pages
+	 * into THP or khuged to replace pages with THP.
+	 */
+	ksft_print_msg("Tip: Please enable transparent hugepages for shmem before running this test.\n"
+			"For example: echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled\n");
+
+	ASSERT_GE(huge, MB(2));
+}
+
 TEST_HARNESS_MAIN
-- 
2.20.1


