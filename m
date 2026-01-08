Return-Path: <linux-kselftest+bounces-48476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72778D021E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 11:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2BC1302BAB6
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210942AC69;
	Thu,  8 Jan 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EWoHWW6h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050842A577
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864007; cv=none; b=i6ZTqcGTpTMob805uNeVe5s2+O/RIsvNR8YT/30fzXLPTkDU5yAesjn4nPovtTI8PYPOJlxgvUxWcOuwc7l+/fDKtW9ztEE4x7IGr6YC8+Rr2ONQxBmzAdkWlV1aDPoWSl0v7UJMYA+KdnTtysLeTUcvoytWJ5nwhYYEDHctIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864007; c=relaxed/simple;
	bh=z5UvEG7yIk3hIRSI6lWmN/+q3tRGUV7m3XtA/IVPt/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDDpjb2bq9XD4DogM3R8JkG393qjD3xdl80q4bk6DaBdsqsxx9jz3sdXWNHNLo13Gqkjn7HD8/az0Qs83dVWS44Pj9A7qktWtJqoKwzoIryAUozBydbd4h2Gy8rY+WqYK55YFBx/uqjS7pQjNOU5Z3xfubi44JGUwkgIhEGf3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EWoHWW6h; arc=none smtp.client-ip=74.125.82.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-11bba84006dso260264c88.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863997; x=1768468797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRF9PTlw3a8gb0UkNXk8W27Ux0Z9UemKi8/DWwSUOqE=;
        b=EWoHWW6h9vLld1mamuXoTWA/yykQTXFUr95g8ZBBQlNZq8NIsqqIzJX5LlApm7h5AJ
         cNW8t34S3kMkqwFNeL5XG/TGbjYBXicaXCaUL4s2aODArbBBHkkgf9llh+lxOI8l6HGN
         dw/9XdRY5b/aIlXdQCGUdB8XB/Mws5i7NjOeAsHbQLN2ZRQ87CWvRgDGuDzViLLG0KCZ
         +ho0DmlCbw4ELLdJgovHSjXjZ0lRxXw2yr4Cp24lNcRpxb+KKIiVZJMsQNPr3ymkQ140
         jLMOSqf8epTmGNyGkjXTdHhZC8cTW3w1gTkWh0UfKdjW288kvnpSHR2MGe0dUvDzTKlg
         Q+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863997; x=1768468797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LRF9PTlw3a8gb0UkNXk8W27Ux0Z9UemKi8/DWwSUOqE=;
        b=fW+8hVZbSZ0K0b1u3/x1k+op9DjBYTJrB1s4VGWof6LxTGJUx7V8sAo6pLz/Xbr0VF
         Tb2mdTp3O1llMNyd5bdZlHdVuHmqyPWnrAoMVsnffhUyYPHtI3ahLXEUeo1I9TAmCFDe
         ZtY1/cJujkYqzTZBe6KoN9hKcPLLwk1NMru1NPfr+95BSXKIsQ14TItz8AP+nghu0SrG
         gPh5ck3RdEY6eLcCSt/wwTGAUp55jr6mE+VoS1CAIW38vvKvFATL8Od0K5iMEOycp2g5
         UAG/ji1SJIB+9egaFMYuisHAJrdfDCY+1G84a5kn018+2ITm0EIIkHxoFxhDDiBJF6iP
         M0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXzC7AHvlcNIfY/BXDyRrKVRp8KmEZoig0OmKVHsA3DbLeDwP9T8rWuegcigb8qPCMH1dCFrAQjpsxZ/c7wgQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLf25q0/S6tocU3rfteDOeLaC3Iuvb6M2iyyqBq6GZcbxTr6RJ
	93RBK8s7WYHBaM7div3zm4IMYo92B72nQczFck94kgPMXzEz3ReMsvech1u0Lhp58xNqecrR5h2
	eijCVC8Yy9zDRLzDljqghLA/74U9h4G995y2j4aelhSJpS/hMKsH2
X-Gm-Gg: AY/fxX6br2jkTiMunkX3jv10a4oUANv3YQrRsAhLqHSr7Bj8kzYEolGGEo43qMrAu/D
	7L6ovmV+vKGCLPN1QeKBHt+ivljAkvGGeQIZe2dwFVft5TGHs1CZpRG/rxnRqtlKQaRK+oFcXqB
	1DyRUydi0iF78+2wR0yT1ojisM6zY4mMO4oAPGHKSt7hnWi47zCc+jU/NebyNbW2r7s/VLCqmNF
	o2SFH0mpbKWxaVmUK9+sxUjYvmMJulL/XMdzh7NZpneuFxK8pkvq7N09wxKtxw9KOOdzFxZ+XX6
	bMjtlkDI0BVvn0WIougiaYO1KZZcHoWDaE89ZpgY2hWi/nS/a04ADQcGjwocnPxgNQNKnqmMsw2
	Y57qY+YJnCn/jQ5kJ6x92N8GKzQc=
X-Google-Smtp-Source: AGHT+IF+tnZp1NPJYPMuToiP9g/0nFAnKouh8tNmhphYS8zUh1epFsXDHslCkoq5UuiMCq74MYJVWgq8pNzt
X-Received: by 2002:a05:7022:f415:b0:119:e56b:46b6 with SMTP id a92af1059eb24-121f8a30d8emr2644521c88.0.1767863996644;
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f24966f5sm1633750c88.6.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 31E5734225B;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2C8F8E42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
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
Subject: [PATCH v4 08/19] ublk: move offset check out of __ublk_check_and_get_req()
Date: Thu,  8 Jan 2026 02:19:36 -0700
Message-ID: <20260108091948.1099139-9-csander@purestorage.com>
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

__ublk_check_and_get_req() checks that the passed in offset is within
the data length of the specified ublk request. However, only user copy
(ublk_check_and_get_req()) supports accessing ublk request data at a
nonzero offset. Zero-copy buffer registration (ublk_register_io_buf())
always passes 0 for the offset, so the check is unnecessary. Move the
check from __ublk_check_and_get_req() to ublk_check_and_get_req().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e7697dc4a812..8eefb838b563 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -253,11 +253,11 @@ struct ublk_params_header {
 
 static void ublk_io_release(void *priv);
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
+		u16 q_id, u16 tag, struct ublk_io *io);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
 static void ublk_partition_scan_work(struct work_struct *work)
 {
 	struct ublk_device *ub =
@@ -2288,11 +2288,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	int ret;
 
 	if (!ublk_dev_support_zero_copy(ub))
 		return -EINVAL;
 
-	req = __ublk_check_and_get_req(ub, q_id, tag, io, 0);
+	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
@@ -2582,11 +2582,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 			__func__, cmd_op, tag, ret, io ? io->flags : 0);
 	return ret;
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		u16 q_id, u16 tag, struct ublk_io *io, size_t offset)
+		u16 q_id, u16 tag, struct ublk_io *io)
 {
 	struct request *req;
 
 	/*
 	 * can't use io->req in case of concurrent UBLK_IO_COMMIT_AND_FETCH_REQ,
@@ -2603,13 +2603,10 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		goto fail_put;
 
 	if (!ublk_rq_has_data(req))
 		goto fail_put;
 
-	if (offset > blk_rq_bytes(req))
-		goto fail_put;
-
 	return req;
 fail_put:
 	ublk_put_req_ref(io, req);
 	return NULL;
 }
@@ -2687,14 +2684,19 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
 	if (tag >= ub->dev_info.queue_depth)
 		return -EINVAL;
 
 	io = &ubq->ios[tag];
-	req = __ublk_check_and_get_req(ub, q_id, tag, io, buf_off);
+	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
+	if (buf_off > blk_rq_bytes(req)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!ublk_check_ubuf_dir(req, dir)) {
 		ret = -EACCES;
 		goto out;
 	}
 
-- 
2.45.2


