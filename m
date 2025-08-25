Return-Path: <linux-kselftest+bounces-39850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D0B344F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FB51A82429
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5FC2FDC2F;
	Mon, 25 Aug 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QGsFtqFh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA12FDC31
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133913; cv=none; b=SfqhUQHL9UFvhdXi3KxJMMMf1ix/wzORWiBE5iueQRkUs7NJ3SuNjIGZ2WEdiO+gLVahfhNL9plBsIXWiKqvEfpbL1Uz/ZQ8j6N8WFW/KTLZZp4DZBBfQDTSfmGvMyrnXD62oHJj8hwjby0VmlzwzYPciVW57GRnnyxr3CQfxW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133913; c=relaxed/simple;
	bh=Uo8Uq5CGd42i/IUZX2QiGqJ9jwcLrhXXcAVNfr2ZqI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/OyhPAdOdf8n7bxgzASWCm0ZQDnYmXWzos3jX58chLHUAx0+XN2TvKsBhLGXAG6dvy2/5SjqVkg4tipCpW+bLAUD9G6Oi58s+l6GQi4oDrKfSdQgxE6JCuGYsHO1oijqGShTjzj+9O8g3/84exLDGpFN3L8PwZb5UrSvzepGWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QGsFtqFh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7704799d798so1233634b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133911; x=1756738711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KNNjy6jnCK8i9cBT6PGrQfVqxJIthxv9ctwdRDGY9o=;
        b=QGsFtqFhAsWiT5DHzRrcZIkFseotRWf0ZyUGuG1gpt/scQNOJ+LDowbCSjIYiL7lvD
         ZVgQOwQBKqUcJ5sZRALrxQTSjMuZzrLaZQ08wElEmd6BulKiYlPXP9WiKFhw3ZiAus8v
         7j+vLjeuuckQYq2/oBkC9N5vPR5jNVmuLw4GxDJDSVPQ84AcBaUngr73nzaTo2Hq64Od
         8+hpxSGuT/qzEnkGCDBy5zhH8XGFWoZ7oy60E6BomNQiYca0bpGKiv+5Ouq45LljLJ+j
         0iIBGNy2voplCvJrZbROQsAP9jAE2Za9ppwmGVAY6b44VjLxn5zXq1gQQXbPQAOOMgC2
         8RlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133911; x=1756738711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KNNjy6jnCK8i9cBT6PGrQfVqxJIthxv9ctwdRDGY9o=;
        b=RAe/82dV41xLNVLJddOiBenZ99X6YRYMB/nmMXlZy+HN4d8do9S/zWaYqPPAuiQVmu
         v9MkqhFaqUoDC1Fy/5wAkxYTMgvMlyyopqpEg3gaT3lUmpswiX4fltLlQw8iwLcUxKGB
         eRJVhIgqfLLlOt8GKs5+K0zMqRYcgnJWOpl/yypUWeX68aBiUuF37aaTM0jefpFkJC06
         j3NG/sMu+lTn/8d4DV67iOXdZX7ecPtrphfSAJU7NLKftLciHqTtZv1LLljQlzF5JMZA
         yYhxxhswgaFR4cKbUXc9KWtyxDNGhdjyfiGzmmsaZhDeAUqLZnMGLk5DN08cphPpVtgi
         q/9g==
X-Forwarded-Encrypted: i=1; AJvYcCXW2zHO89r4lMLhJf8uASKr9ma7MbHKgJkq4ykTsakQS4X+2Ji0G41unmLaTVc2baoqcoISX038YyNU193AA3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsSwXevqEIXGbX+aURVDneU7nAiIj1BQJRtekByf3S7+dtntU
	nXkapa+ez78vcMC3COktHPdLA4SxLUFBa1D+jcXaSPly1SxYUsxcJ6sZr/U/pt51YTQ=
X-Gm-Gg: ASbGncviAGfr9Ib5ijy0P/ta4sJdNIvG53OlD6gZAGRtErOnWul0yRpJv7bch18Mr1V
	tzpR08h8+6kKje3MCQ/PBfSK7AgOXk+eD4YoFmX0tJWjcpPF4o/Ojbnz199I8a1IDc79fAtpyyj
	OBkvvWaqSkjeN6UcCE8zCMSYMuOFBywsLl5EbDSdvlf0HDCHFzoVmhDCVjPfn+d+pQL7Tjm4AGG
	GliRrYYKcaMY1qNPliwlPt2b7jq4Z7M/j18FqtG2KOYKmsL7My8o7jok7lv4C7jpDwTnx4p98Sp
	p0YIpdDKC79N5BrPvLntRnIfpIUUe6Qsbd1KD2XCvwXqHy3IWQH7vVnIuQirzqH9fzkx2ewR3lU
	3jrMjOUK561EzPUHeQjfyaWWLnGiRGFuARYbCeilApd+4r4es9hh8C1gedOAh
X-Google-Smtp-Source: AGHT+IFUi1/2GefYrlbJCoIFczVXEJy1x3XUrow95S+g3t2wLpPX4iH95FuGRMW+srrK0U8C6BeQcg==
X-Received: by 2002:a05:6a00:10d1:b0:76e:7aee:35f2 with SMTP id d2e1a72fcca58-7702fc15031mr13371786b3a.30.1756133911092;
        Mon, 25 Aug 2025 07:58:31 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:30 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] mshare: selftests: Add test case to demostrate that mshare doesn't support THP
Date: Mon, 25 Aug 2025 22:57:19 +0800
Message-Id: <20250825145719.29455-17-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This case is quit simple by using madvise(MADV_HUGEPAGE), but for verifying
the size of THP memory, we need to setup the memcg and attach test
process to this memcg before perform the test.

Because mshare doesn't support THP feature, the size of THP memory should
be 0 even though we use madivse.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/mshare/memory.c b/tools/testing/selftests/mshare/memory.c
index 7754c0e33506..2a415ce7bc01 100644
--- a/tools/testing/selftests/mshare/memory.c
+++ b/tools/testing/selftests/mshare/memory.c
@@ -68,4 +68,15 @@ TEST_F(memory, swap)
 	ASSERT_GT(swap_size, GB(1) * 9 / 10);
 }
 
+TEST_F(memory, thp)
+{
+	ASSERT_NE(madvise(self->addr, self->allocate_size, MADV_HUGEPAGE), -1);
+	/* touch 1G */
+	memset(self->addr, 0x01, GB(1));
+
+	size_t huge = read_huge_from_cgroup(self->cgroup);
+	/* mshare don't support THP now */
+	ASSERT_EQ(huge, 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.20.1


