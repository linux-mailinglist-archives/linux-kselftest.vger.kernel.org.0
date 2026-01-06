Return-Path: <linux-kselftest+bounces-48242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F64CF623B
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29D8D300530A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD830227E82;
	Tue,  6 Jan 2026 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lm6+4W4T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0C20C00A
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661093; cv=none; b=akW6y8gDZlXUhv2s8f2CJFc5u2Pz5Kpe1MHNN3W1c2xpbF7LU//jD7SO4KgNjsML+/ZTDMmQrdn2jQijm39uE3MfSHYoiNoCOz33DCO9lMkf3anc9vH/U10FVdZh6KZVUBfoja69QzzW39Jfsdr+MVHTToCQC93hBROU7Lauax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661093; c=relaxed/simple;
	bh=O5LwPvfpq0YjRitfoT/GodeSOREFQSeNsNbJMNj4XeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6IyYD6U0zdKWlFSE9tVwMnWrZtdLK7rQhOyli02M4uhthLSXUOff+czQ7huGREs5R3PsJ6om/s1ywBOnvnfIqGMnoky9cGWYlaNRaKd1UfXVbtpyj2WcqQN+3Rk8rfQxYEQBWGSXSLERRjW2eJ0P4vWfhSFB8QSh5qxeW8TN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lm6+4W4T; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a08ced9a36so734955ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661089; x=1768265889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bChEZ5QV1bk69mFc450SD6apMVEjUAARVBTDyWj0adc=;
        b=Lm6+4W4TK61xv2pilsDlpzNY3E1QC7x7PJUyuSLv+vQwUmV+54CPtxK2EhV1od7poi
         76KgRPtcktif04Fg66whjB7VtBXfgtwY6eIJnJe19HWroMXfyeiwIMJFMRjNsDE/2GPh
         +7pRyYdHV4/d1hkQ3k4anRdOLtITaKsj4h2ezV01+B2k28bis84Rre+82rMpP6IMScrd
         90AoZnGeCCh7NvnFq4oesboH0cfantCQcQNYX8X0uBJLYoSo1g4E+1OofoXMaep6YmgK
         Sj4YlYRFbjqDnuxMnZMNp4fN9Nq9+XwFusYFFHEipVhu/6m+cYie330Z5id4oKA7bF10
         kFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661089; x=1768265889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bChEZ5QV1bk69mFc450SD6apMVEjUAARVBTDyWj0adc=;
        b=EBStUnIrYJ8osWQDxA9OdkyApZqxlezeY6fxf/t12hUoGmbq4aotHUPFmF8KeESeiH
         H2Vc6TdWYU+C/wFFxvdyPf8LyFrAUxvgHU0Z5bvYDl4ydhZFYpR31VKqnuZar9uMbYrX
         INAGgpvibWiNIRRj60gY/PochvLj1uDeP7BvF9Hs2caCurHr+bokFJGDuXbADtxa1uUO
         lC+coq8nKHfPb9coKV1+sx3GBs9Oa2trSGQSPZABwFgY4iowMVLfL4Az6aJn9OQsuCSl
         ZF4wJs9yTW/cQIFwFejsnvKO5t61HFbwrd4No58oSL5NrwrkPKGnmOttn9Psbso0NWlO
         DC3w==
X-Forwarded-Encrypted: i=1; AJvYcCX4hPy+feuH3oCH2OzoctRAO3qoJzB5UoVgL9paCk6f3n5kRsYK+BIg6jE/ZBSSxSUGL/kpXRGru53D+xAGh5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55TH4lwnwXtB0k4hc+tFzB2x+bL3nkzZ6vj/Dq4UWmLvSn2TG
	OkGdaNPGca6SZeP8X18geoXsdBz/evdG+o/CMlHfvFk+N6n1SvvJRh1IFvJ64WwzSHu5s1CYatM
	G+HJ7dFbv4pds8hnAS5CSzLwamXFyj5nzlB6+
X-Gm-Gg: AY/fxX5tJhaoUxYkGYBGvBFWkLrJ3A1p0e0eCg+RBH4XjlTa43Bv/oyoSPyTvIfbk5y
	XffuF4rgZ80H49DpBrvV5FcVX5dHqxAHcFZtnEOjz6Sp5Zuv1mNnxYpq4DgQE4+2f/NPMR0fhWI
	1pMX2sTfHmr+jx49rp6klh425bZaJFnajZrVJjd5b+hHJIvf1tYmpuio18LwTjjcu+y6MWM3ej9
	icRG/RkdElrM1+Mmq69CF+pwNMKS8dj2Ph6aAzpTt5YRmEO2Y0TOyugd97V3bN5c5CPmbDZ9X6G
	0qkFjXOLn6hjJlpHZ57K8x4/nV8jcv5VPIh67qyVA+xZTko3EP2ekBSkH3uvJHNkPUkpeQNDFNO
	ZxTfDVLzCfKgWOkxBcSVS8LWaO88kF+nIvwX4Blf58A==
X-Google-Smtp-Source: AGHT+IEt7v5piZcP5t5FBeU95eBGQgO16vibqCKp8Tght51rRbRk0ygbQXPn5D5FjMvVvssdzo/+nh0s9KFs
X-Received: by 2002:a17:903:3204:b0:2a0:8963:c13e with SMTP id d9443c01a7336-2a3e2e402e1mr8732335ad.7.1767661089054;
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cae5cbsm842285ad.39.2026.01.05.16.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7FBDE3401CC;
	Mon,  5 Jan 2026 17:58:08 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6FAC9E44554; Mon,  5 Jan 2026 17:58:08 -0700 (MST)
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
Subject: [PATCH v3 04/19] ublk: set UBLK_IO_F_INTEGRITY in ublksrv_io_desc
Date: Mon,  5 Jan 2026 17:57:36 -0700
Message-ID: <20260106005752.3784925-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicate to the ublk server when an incoming request has integrity data
by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 3 +++
 include/uapi/linux/ublk_cmd.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 066c6ae062a0..2b0a9720921d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1120,10 +1120,13 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 		flags |= UBLK_IO_F_NOUNMAP;
 
 	if (req->cmd_flags & REQ_SWAP)
 		flags |= UBLK_IO_F_SWAP;
 
+	if (blk_integrity_rq(req))
+		flags |= UBLK_IO_F_INTEGRITY;
+
 	return flags;
 }
 
 static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a54c47832fa2..c1103ad5925b 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -412,10 +412,12 @@ struct ublksrv_ctrl_dev_info {
  *
  * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
  * passed in.
  */
 #define		UBLK_IO_F_NEED_REG_BUF		(1U << 17)
+/* Request has an integrity data buffer */
+#define		UBLK_IO_F_INTEGRITY		(1UL << 18)
 
 /*
  * io cmd is described by this structure, and stored in share memory, indexed
  * by request tag.
  *
-- 
2.45.2


