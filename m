Return-Path: <linux-kselftest+bounces-29890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5DAA750F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 20:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5F43A8BA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97571E3DCD;
	Fri, 28 Mar 2025 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dcPP/t60"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C81E2821
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190963; cv=none; b=K0su6MpTrlkdIoZ23yC8mRM4YpK/wGroMdjPx/nwFtwg5ngXePneB+GsAm9XyQo46lCBU5nD+gYMAkrEZnr0KFQht8HWf2krwfuJJNU1Y9UsZcU9CBOAXZqkH6MJd+N+HKMI9NTtFdmD7Zmgvv3TaKdb/kCIKmAEUGFqox6dlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190963; c=relaxed/simple;
	bh=IIFz4j2C2Eh7fAQD0vF3myZwWOH3MPOPveM/pvRkH1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOyMsqfvrQGZJS5rGUC00roqZ09k0rOiV6soIzmuMt2q1YG5mLKr06udzldNgoSvxv3rzwV9/vza3CUpGrUwwlNmCPNgPX9Y5QdaaF+i121OP/YonxuMtGEPHhI0ZtrpUyzKHxw2w6QaeKTQ+qKET9wt/Q+34X9aK7ut6CBRlCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dcPP/t60; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6eaf348103cso4078716d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743190961; x=1743795761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLazX2sR1QiGKeTx3lHr1mcmdxpFqxEOFWM2x5oC3Fg=;
        b=dcPP/t60EJ04nWA4KNJSsA28QsWcIhbE+btJeaFWjL8RBB9EWMcwDo7Jrw3pJ0a6Uy
         OUhC42H5kJO3/3DtTC+OXjC963gJ5P3BfRtSvJ9BVfZdq4EIToMyLzU1MClaCAhc10qp
         xpNSJ3Cq59ANj2a+VWs4SM18EBFgaM35wCrAB1PG1XZxXOpEPWt3iJ2aXGneAIiwhqrJ
         z3FJA8V4LTgpMvSjhokkSeZYcTaM6eamUnAwMZRf/nkOnNjcfUb2KmXip3e12QRLtfSG
         YMJ7LFo+ZE6aTGjH+xqiRcMq47/kYEOogqoLH+sTsIuP/xHQgktgLq+s3usLAuVQwJdS
         PlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743190961; x=1743795761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLazX2sR1QiGKeTx3lHr1mcmdxpFqxEOFWM2x5oC3Fg=;
        b=l8xoZ2V5DFf2Cwlh3WjLQbQqON1h59obxn6fJLzqNpFqUUZSs4K5jh5uFDb5tOHGFO
         /MuxDpVzXALxiCc/HfEe+eXvVTpVFNGuZme9Wd3fhSCtmSr5U5nVHwNvPBXHr63CAk54
         UmTf8aMlF7bKR8sjZhMZLsvQNbhyh19VGxQgVHGREfiqARQ7+rb9QMPqeCTL5c82e39C
         TaUw5XPYW/v9qAtLg7qerKOdmawCrCctZJZyiyn6FV/voRy+9FskFHPJ21VrDYFkR+Rq
         VpOaS4pnilcCNXqWTEFyCaVT2233WzRozy1bEha1JxElSYgRzX46R06aDhZB3c5S0yli
         w2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbv4k1sWKLBmiRNyIH54kWzs1byTogwCS0HEQl6wWwFK8T+g+J58NuF/A7wQTaJhrVVB3mm7wOMsx0OQGP9zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQb0Ohbt5xY9IS9B7kZ0kyKxkRKbYeLToSF56ajiwF+WuRFqy
	4/cwju5RF68bbSHnAOyO2+xhav3fsojnMSZ9W4hQAJ1+EasPGSpbCOdZUYKOtcaaaDlSgWfd8R0
	tkDJe4zSZxXgBVaJ1rD2GMmZifvHQtU8V
X-Gm-Gg: ASbGncsvj4XK/C8fWPNIEY6NjtBdJdb4ez8DeVpXghfZdiZev/weOQojoLiyHfaDRJS
	LeWIQ/uB9lKgwccMeMx43e710KSJebFut50gZ78SDnJmwfXCndMhgqe7HtOrjy+ZLlwfmMiVGjI
	8IcLFy7zPT+tMVys+AeVa6oCmCe99Xx7+YPri2wrWMuQYQO1g1/dSGTzgPSGsYZAoSX8j+0P1YA
	7C58OGbLxDpKduZK+xMzcLflnA/ryMk14ePNed7ytbzEeh68KRnRvV1Hf8uyR3szANBP4UzI6j/
	oYMFJKfO3bsJu+Kusg9wZZVYU3m8D1ZxvO9M39KXQIoUAzfU
X-Google-Smtp-Source: AGHT+IGTVuJ9wsa8D0YOPf/IR0bLXPoK/A+oaStmp2cHkFUKuudrLMCf9S4wmCfByWcdBV5jz2al3JueEfox
X-Received: by 2002:a05:622a:110f:b0:474:e996:197a with SMTP id d75a77b69052e-477ed7b2291mr3086091cf.10.1743190960620;
        Fri, 28 Mar 2025 12:42:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-47782a2849asm2198541cf.6.2025.03.28.12.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 12:42:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8A3F73402DD;
	Fri, 28 Mar 2025 13:42:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8669BE40DF3; Fri, 28 Mar 2025 13:42:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/2] ublk: specify io_cmd_buf pointer type
Date: Fri, 28 Mar 2025 13:42:29 -0600
Message-ID: <20250328194230.2726862-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328194230.2726862-1-csander@purestorage.com>
References: <20250328194230.2726862-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_cmd_buf points to an array of ublksrv_io_desc structs but its type is
char *. Indexing the array requires an explicit multiplication and cast.
The compiler also can't check the pointer types.

Change io_cmd_buf's type to struct ublksrv_io_desc * so it can be
indexed directly and the compiler can type-check the code.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 355a59c78539..ed73e2ffdf09 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -153,11 +153,11 @@ struct ublk_queue {
 	int q_id;
 	int q_depth;
 
 	unsigned long flags;
 	struct task_struct	*ubq_daemon;
-	char *io_cmd_buf;
+	struct ublksrv_io_desc *io_cmd_buf;
 
 	bool force_abort;
 	bool timeout;
 	bool canceling;
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
@@ -701,15 +701,15 @@ static inline bool ublk_rq_has_data(const struct request *rq)
 }
 
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
 		int tag)
 {
-	return (struct ublksrv_io_desc *)
-		&(ubq->io_cmd_buf[tag * sizeof(struct ublksrv_io_desc)]);
+	return &ubq->io_cmd_buf[tag];
 }
 
-static inline char *ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
+static inline struct ublksrv_io_desc *
+ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
 {
 	return ublk_get_queue(ub, q_id)->io_cmd_buf;
 }
 
 static inline int __ublk_queue_cmd_buf_size(int depth)
-- 
2.45.2


