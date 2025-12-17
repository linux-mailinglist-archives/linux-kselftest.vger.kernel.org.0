Return-Path: <linux-kselftest+bounces-47640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFFCCC60E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69756300315E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B82BD5AD;
	Wed, 17 Dec 2025 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="buAMOgLO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037923E325
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949718; cv=none; b=tJoGZuKHeHih43hAR2nFZddHBnQ92ThHu6zAHxR8IRq5+bzAzW4UX9dzMO1yYzevvSEecG5UArhHe6Vi4SC/XQtyXPM6KLhY6GsJdg70CpWZi/nDqGhT891KDF5p5Xf025f9W2/5rcdmXCj1qSN5Iy6T49a8j4uXHRG9vazJNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949718; c=relaxed/simple;
	bh=pFLON0C1oQtjJn2qiXI7MdgjCCHKt6ZzUS2gWW7cigc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTlfNLPgxDvy1wLLtuAgkNYFcbXps/lGiJ1GYEDYF2AUspcr16DZR1/tmikXTWbinzUxVHqt7rxFzqoXqICgmmxbrr1QXHvVVCJf/zSpOwBFHUT3OIQclUHd0Q+NR++Oq8DA8tlrYdAB/XDomm1JTlSo0Ya5HSOVWmbVhffxtEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=buAMOgLO; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a08cb5e30eso8918945ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949713; x=1766554513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nnWCsd7c+dSY8wBQngk2tPTTYvptZXaImBTrn5efMQ=;
        b=buAMOgLOoVGXYmYAYaKLYDeO9Am+GPjYU9O9hSlbEHV3PP0WTn4AaRHjqTDzyN1Yf2
         80TQP5nXMWsig84mlOzwIZB6tvRn1WHVrVLw56IiaS0xrfu5+rdyZrOZw0l2jhZ4gtck
         N1dk53bZ1WXyHMJT0z+rc1jvuPy6XvrbhzVYJessQjoxt3a0ecpFnnvLX/fgzCNs+6oN
         gvrV0lQkPu713+2Bp7DesvEw1RNnrsXF2NQjB3inar8u2L/KN0QsuBXBcxTaJahEZbqR
         L+GWUkZLopEU9AEUW16CPvgVUMxPCVAs0jzWlTuMJGqc11zEzuEWdAm+dwIN6sIWzsPc
         V0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949713; x=1766554513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7nnWCsd7c+dSY8wBQngk2tPTTYvptZXaImBTrn5efMQ=;
        b=U09MjjSfSUpzZi1+EiEeUE/s0tAIkW8G0Zc3Ovgl7u2MrdC1UJ3yggLz+2eMdIsDC6
         ALKw77QfrmGcBqJjK99RqN3lqHr9wEE2RT5ScL+aBAD1GgUf9KTKFvfEs8sDznzmY76I
         PUKT4MTS0vOWbQMo0qla/1Cgs17Xv7FT3Msz3LzI30Dz94X4z7i2MTHsmptLy3wVW3lL
         f2sTQUHVQ1e7c/qo5Jlt4DpA5SKwycnre6kzrrtmZSv9YjSmpfzfyxYhUx5PiFOAmNL6
         ALw1tO8QOKVLXxFwmdousUnUtSPAHENDVRglxI+k1+UisEPtQyEIAtmrlI8b0S9gWe7j
         jpcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkYQRT26FtnXmCkPoQozcWYZxHDv/BS/IfC8qN3HgWHJLbUaVpsKZblRegkuinIvoQJL0qxEQkH3XYzYbQysE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrvYP/q+JTIaFQKcyxUYxNoGUb09zaL9MYN8faUIRjuP/X6Bb/
	EMUu6PhVoCiKa7E9CxdTQvz68xfMvAAuldAApc7RQjPAy3VQroGCUTY6uj6H8VDuRcFb+adjhmf
	p6fnMGXyv6rMjR4+UinVfvG5GO1EhtiQYELbcJWmOnXEVd/j1MCyf
X-Gm-Gg: AY/fxX5eFIPePUjGJFoxL8V640hKgWxerXnZSb9Sls9fFjj3UMMzeqgCf76drLDcR9k
	SCZ0K6YYN+JeBRry7XOQ7eIf3Uvk6Vjws508fE8CRVnQ/4QtP6+Hq1NhDk1MXm6zFvLc/EndOnG
	N1Ufr6qCMuCUS5I2nfoHn6Pp781dmFmP4qxZb4/zNm62+gYNwDNTTqDMSF8/T7ux/MXQfA0oPdM
	1WTQIJgAWNmId6RDBr8sT/pNNbVfHJfnksi7Gxd9iNIXTsR3yV8+jVh2kx9p4fKrgVX+BxAxwL+
	O4Px8X7NzUMNg5859GCSKdDVqSA5eNE4HdWdbg9HdyPU92W+tRotkMBtoGsKwKu7/Hb2vqF8o9E
	WEsms9AT7m/MnT1i1+71aDgw4iGU=
X-Google-Smtp-Source: AGHT+IHMdHsws7Dly3g8BQupcQIOtlAn+95WYWkTsv2m0JLOGAKnlJx71g9i0zbiAmgrrLQ8YLltVLenV8LJ
X-Received: by 2002:a05:7300:fc0f:b0:2a4:3592:8623 with SMTP id 5a478bee46e88-2ac30187911mr4942568eec.1.1765949712815;
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-11f2e151243sm3230590c88.0.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5FBA534225B;
	Tue, 16 Dec 2025 22:35:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5DB2BE41A08; Tue, 16 Dec 2025 22:35:12 -0700 (MST)
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
Subject: [PATCH 09/20] ublk: split out ublk_user_copy() helper
Date: Tue, 16 Dec 2025 22:34:43 -0700
Message-ID: <20251217053455.281509-10-csander@purestorage.com>
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

ublk_ch_read_iter() and ublk_ch_write_iter() are nearly identical except
for the iter direction. Split out a helper function ublk_user_copy() to
reduce the code duplication as these functions are about to get larger.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0499add560b5..e39ed8a0f0ae 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2657,42 +2657,36 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 fail:
 	ublk_put_req_ref(*io, req);
 	return ERR_PTR(-EACCES);
 }
 
-static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t
+ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 {
 	struct request *req;
 	struct ublk_io *io;
 	size_t buf_off;
 	size_t ret;
 
-	req = ublk_check_and_get_req(iocb, to, &buf_off, ITER_DEST, &io);
+	req = ublk_check_and_get_req(iocb, iter, &buf_off, dir, &io);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = ublk_copy_user_pages(req, buf_off, to, ITER_DEST);
+	ret = ublk_copy_user_pages(req, buf_off, iter, dir);
 	ublk_put_req_ref(io, req);
 
 	return ret;
 }
 
-static ssize_t ublk_ch_write_iter(struct kiocb *iocb, struct iov_iter *from)
+static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct request *req;
-	struct ublk_io *io;
-	size_t buf_off;
-	size_t ret;
-
-	req = ublk_check_and_get_req(iocb, from, &buf_off, ITER_SOURCE, &io);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	ret = ublk_copy_user_pages(req, buf_off, from, ITER_SOURCE);
-	ublk_put_req_ref(io, req);
+	return ublk_user_copy(iocb, to, ITER_DEST);
+}
 
-	return ret;
+static ssize_t ublk_ch_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return ublk_user_copy(iocb, from, ITER_SOURCE);
 }
 
 static const struct file_operations ublk_ch_fops = {
 	.owner = THIS_MODULE,
 	.open = ublk_ch_open,
-- 
2.45.2


