Return-Path: <linux-kselftest+bounces-48478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF14D020B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 11:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A53E31430BF
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E6E42AC87;
	Thu,  8 Jan 2026 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xz9NOVdi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8242A59A
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864010; cv=none; b=rUqeK+vkgoscDZNS9bGijupxGdgARXnOeqqwa/Vfb7N+uKImhHhH5UXZ2EEVDVxGfDqBpwNYhgpAlRAoj0DHQextZgtn9MAdYxskE1xd1Cu2DrHa8wy1JvWgkJcdQlUorpKj/JJ2R+Ioh4gax/5qAYcJZQXJXWfYCRcL3Zapl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864010; c=relaxed/simple;
	bh=flmggBNU2hAB08i914C/deY3qRX3vSvGh6Sj4w2rzFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSOUaUVquMIvinuz4VymZOdGrx+J0GkefJxiB5oOnlc2hTet2YJYhv4PGoAqS0IneR7Indi2bX4Mf32NqHNZBPGfJhyRP5+G0/3KA4w8KGDlu/lrpxVVLkhJ4JOpEIaQLPh+EsiOp/mKXH//R8EasOJ9K/qjjUUJGHYQcMt9CBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xz9NOVdi; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8b1c0dcb3b3so54237785a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863997; x=1768468797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRGJRe3q+wC2wVKVj2Ep1iCX4dbPSkat0FX8kDkrXQw=;
        b=Xz9NOVdio8N5vlCIeelxt/+gpPfk4GskIpVNJI8ic8pEETiJyupVj9IT4vpWoe8Nim
         VrqcC01Yo9lc9Hn1lArx5LZ4Mt68i4aL4TqOD+mskl/fQ99Fc7YUINONG14NzHlwKaSM
         nxzI02XE6VDVgdg8wqU39NFNcCWzLkU+Xew7UAyvg2ftU3BElXuk0SAgJJ9djd7FPJsT
         Ac5o+mVU0pbpBvLbq173WZJQd9jR0VipcWnlntNLR3yTR8C3smt9oRbiJ2j6cEiMJ3DA
         rrnDHI50Y7K2opkrik0Tm/ttaanXU0Sk9UIqzu790N1aKC76pSBo74x+j5w3tzz/8WMC
         WHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863997; x=1768468797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRGJRe3q+wC2wVKVj2Ep1iCX4dbPSkat0FX8kDkrXQw=;
        b=PKOSvC8SChaT3K7QqiuZa0QKWZuczyniTq92b/9QgKEgrMdpERKidq+S39OLaLN41C
         i0pfmi3j9NmYXeihDb0UsnoVwP7y42i8NBdfjB6ShkDnubpkC/zFGF01MFRxn2+LtI12
         xw3zTT5GYS4dLevXuXdyHbCCUKSeV0sROrrnhTruL+XKSh5ZHFEYQsA2TRYGTI8Tkuns
         VqCKtcT7NG1ev6fi5aYQFLmLbr+fk0jVWokPReb2ZTLBYsWIRzKkXreLYHBs6+A85jja
         28SE4k56jbmiTF4fp03e2BfR0qOhrpm79ExCcvxyNKa6s8UksOGnIvYyEv1XlmBpp0dw
         remw==
X-Forwarded-Encrypted: i=1; AJvYcCW4CEB8fsPFMKPdDYpwwQwg2vGqkfdKEHLtQJo7e9yIiHEelYPg+Bp9jiF1qaiBfrgD9FocUsgzVYwudlL9gv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZaJKWVuIKct4un/41W9g5hXvsguKNQ5juKi5CQS8HfqEiRrox
	ur8IGdnT8C8GB6M+rzdAjrZX8eaOZZ7lBlqp7uAkIaHLHCv3A+VI9siVm3ddUnGXlDMXR8Kro4l
	hkqxENwOL0Zj4wBUZI2TKn+aWg1WcWF0TfCXNqAxQaLKBbN1Ykj9O
X-Gm-Gg: AY/fxX4lVRXDRtS+foURU1vHJ0K5Jf7GY+mcpQpB7ixroXPvZ6IUAVgu8EOSgHRUBZ4
	iBh6bpY3CpQR6OkQ3wJNl42DkC/7mpO1PpTcfh6P07oa140+v8bVaeqjxjLlt7HxXk+Z5Ia7wes
	7AAvTkSEIzSbaaLUSJ4zEiYvte640QdhLrNB+Q/eLUqyHPt0OuYD8rhELshC0d9aEt+ME37+wBi
	7DOLKcbMK1qFDmVKqUCiaZtVQam5YXQZWzCSOmHjDBNEAu11bm0Gcb7vMaMDUvmN1VY9bH2L8SK
	aya+X7cKhI4HVNB9n2Ay/VY2PCbetXc0ZXTBL1UsP0wLPn4sftVhgAMT/dlsJWmw+JFJo5qvvFX
	ZrQmnVOsKB1nlfNVfr4hDvgWOyW8=
X-Google-Smtp-Source: AGHT+IFZEqHTD1jRd6BPZWZ92EgtYzPKA4eYdLHsiPbwryg/dB7+Hp2FHML2KxtaKefC9IyFoEQAGq0IYNyQ
X-Received: by 2002:a05:6214:19c6:b0:890:6330:97b9 with SMTP id 6a1803df08f44-89084184f5dmr61349676d6.2.1767863997313;
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-890770a55bcsm9018466d6.10.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C6236342243;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C0460E42F2C; Thu,  8 Jan 2026 02:19:55 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 05/19] ublk: split out ublk_copy_user_bvec() helper
Date: Thu,  8 Jan 2026 02:19:33 -0700
Message-ID: <20260108091948.1099139-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 52 +++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7310d8761d2b..22e82bbf50ce 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1005,10 +1005,39 @@ static const struct block_device_operations ub_fops = {
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 	.report_zones =	ublk_report_zones,
 };
 
+static bool ublk_copy_user_bvec(const struct bio_vec *bv, unsigned *offset,
+				struct iov_iter *uiter, int dir, size_t *done)
+{
+	unsigned len;
+	void *bv_buf;
+	size_t copied;
+
+	if (*offset >= bv->bv_len) {
+		*offset -= bv->bv_len;
+		return true;
+	}
+
+	len = bv->bv_len - *offset;
+	bv_buf = kmap_local_page(bv->bv_page) + bv->bv_offset + *offset;
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
@@ -1017,33 +1046,12 @@ static size_t ublk_copy_user_pages(const struct request *req,
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
+		if (!ublk_copy_user_bvec(&bv, &offset, uiter, dir, &done))
 			break;
-
-		offset = 0;
 	}
 	return done;
 }
 
 static inline bool ublk_need_map_req(const struct request *req)
-- 
2.45.2


