Return-Path: <linux-kselftest+bounces-48085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6EFCEF902
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BBF7300EA33
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CE623C51D;
	Sat,  3 Jan 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WpOtjxt4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D41EBA14
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401135; cv=none; b=fLkJBIme0Ev40PAqoEz24Xmy5W9Vq9kagCWBIa5/o0QI4jvyJANLhXTXsY3L3qzwCI3aqq4vxqULjFIHiOL52n57kRV6ttgbdyMMupl0sKyZ7C2vMwwe/xDbgpNNeN9UJWL2MuesvTMn5V3ah1f/1SpY7VaxuvlXU7AqucNGE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401135; c=relaxed/simple;
	bh=RgRQXPGgkBOFh+I3IU1dh10q8VHov+arOD4uOXzU9rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqA9NNmd716b4OBEvQ5IprFvNLnOyeTb7DULv+A3sTpZLxXXESYBafK0sOUnoBWvqvmYuYhSQwvevqbHxxc/z01KppKuou/Euge8o/Gbz5K006EjOlgQ53eWDLXt/+iM8/gwR+uAc/QrPvcXrlxSAeJmHPLSmMEyZDboKxvKsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WpOtjxt4; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a110548f10so44335205ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401133; x=1768005933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czj0Xu0INr5Vy2ifFNe60pRb7rtoAzjqp2XCOa9c0II=;
        b=WpOtjxt4tfrrotLRrvuCFONjo1IQG5bmSH8zbWvvOji5XxHUmTzYDDPE854qVYAb22
         hHhE0zcxYOrn1IcuW2TPhUn+p3PMFEN9yqc3J40u4ojecoIj1iwVn2khIVPBxD4s3Aq4
         pEHem79pQ+ENPGH5mSwt30RvcFcutwFI52wwxePrIU472inoknlMZKycSW7ZixykkkTv
         mxlFx0QFmDyMf7wXr2qvp5Vtv0dhwXFVIdTLC9psUTS5qsHNa1ji7YsCF+SQRnmG/GPn
         nCaNJA3E7+wzrcVBM9pYEGv/Q6pJKQxcfH2BSCQt1fJchb+6ma8aYzCvuH3IyHGxSzT7
         tRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401133; x=1768005933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=czj0Xu0INr5Vy2ifFNe60pRb7rtoAzjqp2XCOa9c0II=;
        b=lKfLXnNtHyV2S1267PNV2XeXH5Ew74Z7QWnm0oEqm/9oYJFodZtlGAPvCulEGtVS14
         0+CYZiwBhqUv6ZYDuIpi9EHFeUjgLx+N9MYaGmdvD/Xth6KctYM2CO9fODLoiXp8dsLZ
         ZacgpwHQQhfmDYbXAJXoKl2nv02nmu+LStYg/8CZVhWaMAOoFHUzoluAqiD9URKB6xUC
         uBNnPuCBfR9LKxVXfsaJQS2zGIjNfahGJpBZgwGtxvvF5yPqKmX7xkbiMf5KwOaLYZmR
         POx29gaVGYtQ12lffOVgfkXMFOPepNcGe4075Vh6lMB6Be4OXs2BDooPZq4yhPajVBbW
         +ldg==
X-Forwarded-Encrypted: i=1; AJvYcCWyAznF/wywyAHNNL+WkuFHpIkWoh1mBaslu902ri1JHqQo+q8gzG+49XmHmEJHez14Nu2V4MWCMYdrX3E0FXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDsH+DO3L3vdJ5Y7OKy+IuC/Qpzl2aTAJN9r6VknVecP2aH4BA
	wB5jH82i5yV4HvcjVaxbpZAs+xmaiqHSG9paqoQc5IIR97CV0dbBcH3RdE3q4fG3C/IimH9Rzj6
	nteqoFfUEdwaTu9W7ZrjIJCSBCtpK9F94dhnW
X-Gm-Gg: AY/fxX5HUm+2NCz3aFbfBuRHrX4sZA5rFLw2LblbdSyqnj4fJrv66Pzg0jIx0kEMPyq
	B/EVqUuley8ugjby3hxwxUT1ZdU8vtl3JTD/LmD6WbxAZblpW5oIae5X0J10Cga8K7l0/M7Cox7
	QavDueLF2R8OnMMghdRvLiWbB1aFvb6JAIwCDi1+SlXHZch/gJ/tHJTNpk2znT41ARO0513WLZo
	fFOKaLSI943UOHgY4u6ERhEiMM/6NHvB6Q9ljuj76Ynl1Fpr/oYdPgT7fbPh8QsxdrOk/sb0qky
	lg+XpDZYnWdn9QUB25Os/xTZU/uwkYBBp1FX35pRzxTUD+1k7cP+0C79noF84sbefSKlC4Bdetw
	sblGx65Cnq2zVM9X6RlouBYon/8K8XF8ZWBXRgMBRng==
X-Google-Smtp-Source: AGHT+IEzI2YDnQAtUpCUAyA6e8pluyG9Ja7Ny0SdrKIl/+tDZsFmLNITLlBY3bzENXifGoIeFNQS6g468aAz
X-Received: by 2002:a05:7022:264a:b0:11b:862d:8031 with SMTP id a92af1059eb24-121721380fcmr16129506c88.0.1767401133187;
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1217253e933sm9026569c88.8.2026.01.02.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B920C3402DF;
	Fri,  2 Jan 2026 17:45:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B47DAE4426F; Fri,  2 Jan 2026 17:45:32 -0700 (MST)
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
Subject: [PATCH v2 05/19] ublk: add ublk_copy_user_bvec() helper
Date: Fri,  2 Jan 2026 17:45:15 -0700
Message-ID: <20260103004529.1582405-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
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
index 51469e0627ff..811a125a5b04 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1025,10 +1025,39 @@ static const struct block_device_operations ub_fops = {
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
@@ -1037,33 +1066,12 @@ static size_t ublk_copy_user_pages(const struct request *req,
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


