Return-Path: <linux-kselftest+bounces-48087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F1CCEF915
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9C343013E83
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A0D24DD15;
	Sat,  3 Jan 2026 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cOgDs9t5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2C2327A3
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401137; cv=none; b=DQANPebTq4JjBvM1eLhKfUCodGHoCnu7L/JyW9v9xZHEqsd77nunY5+UupXCZCDWqkY+JKnAMp7x0SizzG68gkIxFPAOcQ8knfEZDG/IovBQJNgzsnAGqU1Xv36oiVHrlSeGqq28u4aDR/GtjyGNSuo/oIVCYTVUv+oInOwJQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401137; c=relaxed/simple;
	bh=5miXCM+/LRoHoro59T+z+kk+Lnrwb+6jT45GlYIcY/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2tD0oWKrzam3A2QtHEdew/nUJxhrF9+ToKUnvx9XFVhGC6nnnKR6flxoV4x9Q7kGuHOKQRDGpYashtmRJYtq9uToYLxd4wAGQAG/EmtTVK3VNeHg9Ua4M+0vGIZN1l/TOlfbG95FSziI6jBiWqW9+1bMXOW5buaUyq78n+Cw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cOgDs9t5; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a08ced9a36so28581265ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401134; x=1768005934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p1lVHFdfrJVwcqNN1Ki9cbLGf4AMYaFBS/YOLtQ7ow=;
        b=cOgDs9t515MUNFKkFh3u1OsUX6W22RI2o6cDtXm71uJnVDtd/dcwQKzCiE/qwwhd1q
         tal4757Yg9EJn3hqVZMSJeXvWp084F06CYyw+lePbATcb6LkgP++CZjuN3dfvg0NLjte
         V2o6tOeX6PCumaDBL/gb5CIi3JdpbhC1iGloTezxKmLlVseBmWoHQ2ROcYCVANEnvlqn
         SVvi+dewPEjZ26j7c0t4dIBZbHY327GOWFIh+MXgSpfCyOOJA4iJ04JOOassLkahWMaU
         OhboYg2yroTpWrlk8t1do0vo4EsNYjoeocPlArhG7tS3hl35OI7REKpqCoF0kTdBk+HQ
         4FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401134; x=1768005934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1p1lVHFdfrJVwcqNN1Ki9cbLGf4AMYaFBS/YOLtQ7ow=;
        b=Nr1es5FOlQCeBNEQh9IxLhCj5sq9r4ErTk4COev7UY00GxfraNf+SMpU2yJv9EIjQt
         4H7rcjfuSBpHFvS6WqyPlNmVkQ1suc0/WHxfd80qKfXBjFIKuVBHvMJ3OE20tk9sKWX+
         a5ZyEjlXeRWP4OqNgD7bRX+ii6touichsawRUwJMf0fQOCqlFNQrwZD1zP/jTXATk1cS
         8gvkDf4p46Pz5WnB9p6/kR9/0jfRb6gUWawwoF+onavJDqkCLUQaACQ7rdMgPshlqiuZ
         QB19NrNUTuqef7sylYuZhCRqQ7Tj7OxCB8X/E/x0Muh/pVTkvAb/LkhQy1lXmKWVy7ts
         Cq3A==
X-Forwarded-Encrypted: i=1; AJvYcCWHbULSSDaMfgbdR/tJQUGfHqAS59DYkaBQw2jHrQth5dojVodS50hJb2HFIglCNqqj9t5g2ac/1GHVQec29PY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QLxWcgKhJUftbqHJZX8REhTp8Gy63fO2rbTLhaAP2TFIOvAH
	oVqlIciTKHB347UdvgFD4tH8Cvqehcon9D7pyDiCplIwN7C35ee3qIDnaUxUY9HvLE44faSqe9e
	rz5orcItlb69doFPQpZqG2tsVJw7rYnLdhhARxqLDgq2VhnoV97t3
X-Gm-Gg: AY/fxX7lv8vMYvehHPEinrlyVh2jsaVKld0uXtwBdGce9Bee9VCwsjVtRr4jzj+X1Mm
	IM3i5OR8400jchUnOC6QD14EAHSk0i8MOTWp4cZxpWXyKsWQ4iY0zH06HghxA2gm9dtxUvBa7oE
	OdtgEXlkC+gB3a4T4/34Na3mZr7hCxSGS8cZqbo+2ZDw06MxfQ5HDVp7X1l+ZvbpiZaAiswyc1+
	gT3WtWVqARVvgIrMhTAyUV8DRYnCG/aU/8a6GhUHPt64m2jYxc4BRs+bTIjw1MxTzcKdAiymCMu
	5pSS4JTWNvU0EeX7Z8zzXPkawT0ya+kKpWNRrHTeWW7mnVTbJZiCD5rD2ypj5Usc4XvcVPW01pP
	4IHqkyxkb0nYEo+oXFyLkIJ1f148=
X-Google-Smtp-Source: AGHT+IEwudaVuvqRly7l0IRDlqEmKMwk/cSbKTNqZ6zXG9WgrlcQ8cTYpnhco7okGJPfRp9k59cr+7f7Cz0/
X-Received: by 2002:a17:902:da4b:b0:2a0:d662:7283 with SMTP id d9443c01a7336-2a2f2216199mr286221655ad.3.1767401133671;
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3c64bd9sm8170985ad.7.2026.01.02.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1AA0F341FB6;
	Fri,  2 Jan 2026 17:45:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 183DFE4426F; Fri,  2 Jan 2026 17:45:33 -0700 (MST)
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
Subject: [PATCH v2 07/19] ublk: inline ublk_check_and_get_req() into ublk_user_copy()
Date: Fri,  2 Jan 2026 17:45:17 -0700
Message-ID: <20260103004529.1582405-8-csander@purestorage.com>
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
index 73547ecf14cd..a4f95a0f1223 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2682,70 +2682,55 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
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


