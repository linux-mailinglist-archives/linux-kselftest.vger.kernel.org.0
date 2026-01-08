Return-Path: <linux-kselftest+bounces-48494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA27DD01D74
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 10:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB833078D91
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC3B42CD75;
	Thu,  8 Jan 2026 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gdedlbDm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F57C42A82B
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864021; cv=none; b=uOG3L7HpQGAmirkjVH55cZQC58t55d1D1+1x03ww2rbIF9LC9N1xzLI/0VW+kZ0R5OutRTGRHNIputl/E8rIAVEASnhcSgR8bqQWcCwUBU/elHrJyvQ12eod5W/qjjW3XCl4LNAlS1vNuXkQwSoPiMZ0iD7Y8qCBps/PmZYutNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864021; c=relaxed/simple;
	bh=qzsJurzlV9hUfDVcU9i4OUZ+UejCEkO4N42HNf4MzXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rqm4l8wP4qJJop9C96EvyQKS+60AYqcDM2+uaz0TggmKHwc7EEGpHCzV/olaYTXQjonL2vtUpbzvNvBc9pBcqURr6y5jlccVuMGlhXMTEiW93gVSuUFx+WGzLTwjYxIzU5v0bVzLGPZKzm7ap658FEeSOB9kZ+kcJjiTSNuJkQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gdedlbDm; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-644752b3105so315214d50.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863997; x=1768468797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6L8O7VQPCwW+Dpp1xErYdb+ZqWEFO3CxWIIuwxx/go=;
        b=gdedlbDmLcnGcXRXTUXoeDKMeNhBU1TCRV+vaiEgEjD8Hrol+fzHIexiutYmEC3v+Z
         PrJSulAlOryNDCM/cKGdTcpfqGfG5GKrHklV1gaWN8WAe5Hd1LZp2vwpKccdJ2TX7N5k
         KEBe2MraMSZPxTozqBmcjrVNY7WAF8uqIDYOnOKHsFY4RVDoeuy0RjTzCgCy4MBwtw+q
         GDuy89KUYLhllfUo1fYjkS6oLPQjrW159iJaEl07C3KJrLsunty1X0Sii/kI9lR/pIdR
         bfN3ooeT5+DUMGn+zYXDZ6Q5LbSV9hYPwgx/lagNtJgoudECuITxjR7DYPDHYCSmu6Wt
         XSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863997; x=1768468797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6L8O7VQPCwW+Dpp1xErYdb+ZqWEFO3CxWIIuwxx/go=;
        b=qra4DOQ4r9ineDxFxGa3szhg3W7sSGTLWVaWguCOGvFOFwyjoOR6QJp8UDiKy/P67Y
         atmfJJFj1gzthWLinPPPU1T0gCfmIP2svBafuTxQ7sZyZaVf946jGxdHBsotyhhtvQ20
         fTSFLVFlHMAzyBicMt0KzzP1dSHRJIea/PzxpCDe7ME3PRGRZi9wCxH/VMAco1FPNZ4K
         5DwcbMkNs3kyyyepcbvqLqqB44V9CkTYGqveuoTFeV12338cCBcJJ2PeIMTnW3f4iedA
         GaiD+/7wow9OOQvPnYXUp/9W9MYC4pFcxm06vRjWyrpZkGP1zjotLtooyadX1//1bll7
         b+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUW4BqEO+MVelqA5sh2/rlPQtKnN7oqhda48nJm2RbwLmJEQa6BXRJYtoRdNbJfE0Ofj8JRnY8CrAtbh1ufY8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHZZowHkRdC2sufKchN00OVg0Rz4GoZtqd6f1g7TXFe7AmtXh
	hJoEeC1tVfvakv3iTIiPzO3B7KPfOas3KRoXhE+4nPbucatUgmepBjm00UxbD8CmDpFNLXZ/hrC
	uUkob5Bx7TsRX5BkOAis6TrWacP5kpXJpYk8w
X-Gm-Gg: AY/fxX6luYuTn5wcVqYYNKMldC3mz4grwR9Q4499RgnKp0cYMcwNZ6vi0b+Me5KoyKJ
	LgG/jh1r7QLubabdQtZoVQPPUwhM1lWwYKi1cm5bRyp2mW7Nt6NTf2L/zyaxEgvoGQsNw/c4r9Y
	hxisPlvZGG6LwH8kLQ6fcLLHqTnn7x+6nguTyZNObGxECCs3AXWJX73Hgawpdree7OBlOrV7cL5
	StmVl5kB1RJkKjL+cqsViMuw174sZM5mdjjY2PNwkGdFvQLzAi9ps8n4zh/tFxmUXa6nLgRSF+o
	WMM7Kd/o1/MoGNlgIISXb6/ZZFSuTRwDCn3o+gAMNg7K3HTNrqg7RZlMWXC/vhZOoiRtlTELQyJ
	o6H1y3bfUXXT4Wg4FxHfC6nAsmG5b2GQG6Qz6+k4hBA==
X-Google-Smtp-Source: AGHT+IGzstdvk99AUHsnHlUESoV5UXHeI/e7ommP+XsKGXPgaR0u1lkbQBwz8eafd13Iz7pLe/WMMqJtieFI
X-Received: by 2002:a05:690c:fc8:b0:78f:c09e:9ad5 with SMTP id 00721157ae682-790b57caf50mr52170977b3.7.1767863996888;
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa563f37sm5687287b3.7.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0A113342170;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 04E81E42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
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
Subject: [PATCH v4 07/19] ublk: inline ublk_check_and_get_req() into ublk_user_copy()
Date: Thu,  8 Jan 2026 02:19:35 -0700
Message-ID: <20260108091948.1099139-8-csander@purestorage.com>
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

ublk_check_and_get_req() has a single callsite in ublk_user_copy(). It
takes a ton of arguments in order to pass local variables from
ublk_user_copy() to ublk_check_and_get_req() and vice versa. And more
are about to be added. Combine the functions to reduce the argument
passing noise.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 51 ++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 225372cca404..e7697dc4a812 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2655,70 +2655,55 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
 		return true;
 
 	return false;
 }
 
-static struct request *ublk_check_and_get_req(struct kiocb *iocb,
-		struct iov_iter *iter, size_t *off, int dir,
-		struct ublk_io **io)
+static ssize_t
+ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 {
 	struct ublk_device *ub = iocb->ki_filp->private_data;
 	struct ublk_queue *ubq;
 	struct request *req;
+	struct ublk_io *io;
 	size_t buf_off;
 	u16 tag, q_id;
+	ssize_t ret;
 
 	if (!user_backed_iter(iter))
-		return ERR_PTR(-EACCES);
+		return -EACCES;
 
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
-		return ERR_PTR(-EACCES);
+		return -EACCES;
 
 	tag = ublk_pos_to_tag(iocb->ki_pos);
 	q_id = ublk_pos_to_hwq(iocb->ki_pos);
 	buf_off = ublk_pos_to_buf_off(iocb->ki_pos);
 
 	if (q_id >= ub->dev_info.nr_hw_queues)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	ubq = ublk_get_queue(ub, q_id);
 	if (!ublk_dev_support_user_copy(ub))
-		return ERR_PTR(-EACCES);
+		return -EACCES;
 
 	if (tag >= ub->dev_info.queue_depth)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
-	*io = &ubq->ios[tag];
-	req = __ublk_check_and_get_req(ub, q_id, tag, *io, buf_off);
+	io = &ubq->ios[tag];
+	req = __ublk_check_and_get_req(ub, q_id, tag, io, buf_off);
 	if (!req)
-		return ERR_PTR(-EINVAL);
-
-	if (!ublk_check_ubuf_dir(req, dir))
-		goto fail;
-
-	*off = buf_off;
-	return req;
-fail:
-	ublk_put_req_ref(*io, req);
-	return ERR_PTR(-EACCES);
-}
-
-static ssize_t
-ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
-{
-	struct request *req;
-	struct ublk_io *io;
-	size_t buf_off;
-	size_t ret;
+		return -EINVAL;
 
-	req = ublk_check_and_get_req(iocb, iter, &buf_off, dir, &io);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
+	if (!ublk_check_ubuf_dir(req, dir)) {
+		ret = -EACCES;
+		goto out;
+	}
 
 	ret = ublk_copy_user_pages(req, buf_off, iter, dir);
-	ublk_put_req_ref(io, req);
 
+out:
+	ublk_put_req_ref(io, req);
 	return ret;
 }
 
 static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-- 
2.45.2


