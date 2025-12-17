Return-Path: <linux-kselftest+bounces-47642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 639E4CC60DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 507B330150F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2FD2BE02C;
	Wed, 17 Dec 2025 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AjwV1PEY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f230.google.com (mail-qk1-f230.google.com [209.85.222.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122C02749D6
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949718; cv=none; b=R0Z64nmyXBXr6N+3J2v9oRgIE56+MZeltc6H0utt9mZ3PMPPtdt18He2jZsUpYSzvEbWuKWc1Y2Rl1xIwZ6IyUjWut39awtJu+S0ZuJszMcLrkrPDKXFCyOLK9w8TIzgw8TdFE6rcCOrqlYthghy7Gu7QbQTZd43wlIJdb+kXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949718; c=relaxed/simple;
	bh=1m8EvyXDwfnBtO4rKSJxv1p1kVYtxq+BhiSXNiIuIFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hfp67HRLnrKAIxrgA0DVGYNz0NeL7ZELQPQKKJr0tBuk0PfGGiHlNdmM3CW67/ow/KiXctfqlrUM+RgQojKcpHH0J5Dda6sCDBjXHAX1pwIUvvqRZnXBRuwkpHlIe16coKYH85JQln1yrAdagb55g94jJ+ESjR/Dc+LQfDla3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AjwV1PEY; arc=none smtp.client-ip=209.85.222.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f230.google.com with SMTP id af79cd13be357-8b1c0dcb3b3so119573785a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949713; x=1766554513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLmTlnuPqHH6b8/uqO7lFBozYXk9kulItImdN914sps=;
        b=AjwV1PEYCUMrcRrMXXX7CSjXLyq/7Cj2m+OKXHjC7fIObSwcRE2fTS4xCpQ8BuGWZe
         f0yJ7PgQPrUKTWa62gKHUls9dWJvqFXKXnDizP4GeU0h7xHnXbvKuHI+K7RV8XFfjjWm
         2EKnutONnce/D54HoRPLUMc0NqIj3JOqiLnhzl8ww1a5ownoLwmbuys9nfXRBr0dWX1y
         X1rfdVWrVZ7vB3Bq3keRB7vA6WwXsLhW6+kmS/y5kLCdu3Ciw8ae2OE0sSIzmC7WMS9s
         ATRh9fI8/rhS6Or07I+6Ne1xcrS1nFvJwCAmr1fusfjKTRYpi/YPjaNhO5yEpwlStKPK
         AbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949713; x=1766554513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLmTlnuPqHH6b8/uqO7lFBozYXk9kulItImdN914sps=;
        b=b5RYKnfl2LHYo94bNe/5mAepU1HBqfdfXE9kJp5zq5thb1Wfn6OJ4AJ2NzBCo8kblQ
         9c8U19uvt4tB+//M3bV9u6sKgFB6UltDcGB1kWlUdacOvQ4cqavmTtpXlGTKlcikns3k
         nliWuS8GVfgjEvS9Rkdxwr/O+0V9jAXTlBe5s60z357lnZ5uTU8QE8Tal+N0yB52vCU5
         mAQyLXiCBFgjMXfow6LJjosbpfW9xJMdD90NgCEYjxNCYosGN2hWXaprmOpb4RipIIU6
         VOmLthNFRIpTMQHCalCFprods1Np2LSZH5nMn0SijcXOGuT5QIZQRNnIVc//OT9bLTQD
         W4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCW5BKfrsFi5OMwP8b6akpm+oUNQC5oG1q24ksSKauJ9YpDOw2WJ+bBYkYrxivtxgWyDB7E6OiDSN8H/W3sQmas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL88sjyBPwOCgEjoE9Ih1m/HjQ6ea6i6T7t2tjBizCw8BfOys+
	rxGxjHxZcOGWAG3mgWntZLAt8qE/bL+Q5UeWG8GKmYzXCsa51Uszx38jElDBngzqadF842tkhI7
	59ZGWtt5TlQZjElQq1oNA2R4vELMp8kOxJxHCFems2YaD3l0rOslA
X-Gm-Gg: AY/fxX5IttwQ3CWJvg1I1aijYpfeZTZKc0gCyM/Sznnnq5IMfvzFEv6PfYBHMZU1LTx
	jLLdOwJnhz04Z3Yz2TP1jKK8idaleo8hydZDFnDfmetw7jR9lgagL9g07aQ20vO6VdXFjF7+7uy
	RUYHa9HPt5b/Drc+aPbwmJRQY8i40pZvPDP/52s5nW6pfZSQ73GAOJkVj8Id9+zLSdZOLzsNoq1
	kdDRWzz3TfsniGe7oWnJ678Lj8NVCftTA9YIyYLi2+yYhMilEObwiUOoC4C14+75XE60jJwN445
	OAmCFsq2M2/jz4k5adegi31liaxKHEmk3LawbcF/VV96yII57s0GDm98jGodeTMgHNz9SynZwSc
	LiwuWieKRXomSz5q3OW6Cbxm+9gU=
X-Google-Smtp-Source: AGHT+IEww8Xn6us3eOELOJf2dWwwlAwsZJ+WOpO1sBLgJOCvWnuS6p6k5sw8+fQPVGcQ83L4wdZsBp1KT178
X-Received: by 2002:a05:6214:3009:b0:880:6fa4:f55c with SMTP id 6a1803df08f44-8887e15808fmr208544136d6.6.1765949713446;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88993b13d22sm19235286d6.4.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 486FF3401D2;
	Tue, 16 Dec 2025 22:35:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 45A06E41A08; Tue, 16 Dec 2025 22:35:12 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 08/20] ublk: add ublk_copy_user_bvec() helper
Date: Tue, 16 Dec 2025 22:34:42 -0700
Message-ID: <20251217053455.281509-9-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor a helper function ublk_copy_user_bvec() out of
ublk_copy_user_pages(). It will be used for copying integrity data too.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 52 +++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d3652ceba96d..0499add560b5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -987,10 +987,39 @@ static const struct block_device_operations ub_fops = {
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 	.report_zones =	ublk_report_zones,
 };
 
+static bool ublk_copy_user_bvec(struct bio_vec bv, unsigned *offset,
+				struct iov_iter *uiter, int dir, size_t *done)
+{
+	unsigned len;
+	void *bv_buf;
+	size_t copied;
+
+	if (*offset >= bv.bv_len) {
+		*offset -= bv.bv_len;
+		return true;
+	}
+
+	len = bv.bv_len - *offset;
+	bv_buf = kmap_local_page(bv.bv_page) + bv.bv_offset + *offset;
+	if (dir == ITER_DEST)
+		copied = copy_to_iter(bv_buf, len, uiter);
+	else
+		copied = copy_from_iter(bv_buf, len, uiter);
+
+	kunmap_local(bv_buf);
+
+	*done += copied;
+	if (copied < len)
+		return false;
+
+	*offset = 0;
+	return true;
+}
+
 /*
  * Copy data between request pages and io_iter, and 'offset'
  * is the start point of linear offset of request.
  */
 static size_t ublk_copy_user_pages(const struct request *req,
@@ -999,33 +1028,12 @@ static size_t ublk_copy_user_pages(const struct request *req,
 	struct req_iterator iter;
 	struct bio_vec bv;
 	size_t done = 0;
 
 	rq_for_each_segment(bv, req, iter) {
-		unsigned len;
-		void *bv_buf;
-		size_t copied;
-
-		if (offset >= bv.bv_len) {
-			offset -= bv.bv_len;
-			continue;
-		}
-
-		len = bv.bv_len - offset;
-		bv_buf = kmap_local_page(bv.bv_page) + bv.bv_offset + offset;
-		if (dir == ITER_DEST)
-			copied = copy_to_iter(bv_buf, len, uiter);
-		else
-			copied = copy_from_iter(bv_buf, len, uiter);
-
-		kunmap_local(bv_buf);
-
-		done += copied;
-		if (copied < len)
+		if (!ublk_copy_user_bvec(bv, &offset, uiter, dir, &done))
 			break;
-
-		offset = 0;
 	}
 	return done;
 }
 
 static inline bool ublk_need_map_req(const struct request *req)
-- 
2.45.2


