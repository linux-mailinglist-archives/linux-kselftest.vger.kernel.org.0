Return-Path: <linux-kselftest+bounces-47643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78328CC60D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68F753019E05
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F82BDC03;
	Wed, 17 Dec 2025 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z8THq8hs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A22857FA
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949719; cv=none; b=qmdjeGYtzr/TzGws4z4Sc6q6ZvOx36SF9aSrJq3/Y0X7KjYbsVm8axdx+s+MssvYyPjCW9MDFcNtKJP+7ha5UbxvcGJCw1d4PyKjner0daeMS22Z9geWSu1UfVjxhEhLUOdGhSfoexGJcOHj915t2S5JOzH9vBy1Qpt63TY0Ig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949719; c=relaxed/simple;
	bh=GHoPeIBMgfFtWJ8ncdyC6wl5P7hl0IaKfGFtCbYkhNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DztEFOHmcF+fokDX+RzTH4pKSdjKaX8dI/BEAoe+ab1b6GrAgnbP74MhcUx0xJuaVUy6SBKqcXGLXJC/IDSGVYssWTQAqjio8IBbC2IYHWf23+b+mm41xjqIAkanAg3HRVlsfScdZbqPM1pRgWjBq6LzDu70gBKkelhhxIpNO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z8THq8hs; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-5dfd3eb9eedso259681137.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949714; x=1766554514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3mOq9Y+rhC9S4U+IJUmG6OBz92i+diStuHtdFNS8Qs=;
        b=Z8THq8hs2puTbEwt2aaqEUl21ZZRJTpYdT607oKOeEnP5LyMHRmf7Rd1GgCYUQgp0W
         H5okYgYOUQkkmo//Tc0F3i81JOmhrWCtehdLX07tvhcu4VDdnYwDx416oERRt0xYFCuF
         5rfHmMw8sK3EID0bzVyr7sg7S+YhbKdyhyWhfMOq7sR2HFiHfjrA4w1LYq433+O4Hrt7
         0AA00qJ3ja65XrzfP+uYfjtbgx7EGwU8cQvnVLqUzag42Z0reufCybARHehC2bMJtCjH
         KKrWdMXH75sepahy7tPBkp8wCt9O5/0LJgzI08oD5uTJhxVNeKwWdjCBvEUQVrRHMSn8
         +AFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949714; x=1766554514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3mOq9Y+rhC9S4U+IJUmG6OBz92i+diStuHtdFNS8Qs=;
        b=L0gG1sqQPUmNBo/HSQBa/5+sS/HDxpNhGtaxeb0D+GChtAikO3IlZ0v3cjIJNgXcAK
         jUNpqZylZG1fGVQJUyQ7NPjNUqJjdG1WbF1Nm5bxSsVfibzevbS+0seIC95n05gtTZ3m
         /8r5NdwXbsr8t9TceaWTB1ede7Co6qubjs+zqFzZWJD4n/uqjJsaDVhkTCKTBo7Pmkbt
         x4PFM4/flp6fZcP/WWJSLbUQofh+2pGuB6SmXVuRRN4E3SatKkn7YmTB29zIExakHbIC
         5uOtT7sn9XUNg7aBLf5aACoS0jdWgOhw9gvhgIJLmt3MuIZVIJpkno7ETR3l08uIMWDd
         gwTA==
X-Forwarded-Encrypted: i=1; AJvYcCVRLzFtmLNb+uiJVADzf15a/xhn6Ose5QfZkoiDG7XptIjYTOQy18kg9sMGGxjWc9HN0q1DPS11Yn1I50JbKz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQPl5jqgNSm8SW8VGqKN7gAUhsbCLMk9OCNhVDJ9GGV8CkV/O
	rOv+mtEB5fyyg8DupirBky6SBIX5Q/xdW7pEXSqPyHoZAlFgPsIIj8XSp8aKcJt+WLPK4UlTGY9
	2NdAgxx73q4r+U4ocnjx9qkoNXk2qiJ1XZIWT9W6S9FctrPE0ZYoi
X-Gm-Gg: AY/fxX6RrP9eqLY3TerBQEJkNW2qjHfY1S5jf72Xdns6bXt0w4UFCqw1CLiflYVsCf/
	x2D6+c1PLM8Azbhg7YX2TikUX0YzLABjfVVG6hzKX6gK+niYwZ2iav2MaeSRiTT7NRdTIhcbgYB
	eDBdhDRz7YWgNVZMO0Rf5M4kZHB8ygnvBigD0UtkjFqaCJbhizY3q6jVUoH+v4mZbycY9lmiBYT
	fzY5zRxExQ8HmfxtKfJtziozLU/aTQ6d6cb/E5o2bJ9Zx/YhHblhCPFrZ6ceFFNVMNIDJXnp2zO
	hAYf0PJzvchcXfZ3sj5TQO6OrtGh4EXbFanmglq1y/Z5v+XQrfr8beGUMRKXOzLAygUL9yf+n/1
	p8/kEKP3TodZpWCodR9skGsqLEj0=
X-Google-Smtp-Source: AGHT+IEdiu/wz3LFaYfCFvm/xPf9JRqbDWXdAzTEtw+g7b1hcvx8k1bBanbe2UHRij72QmFAixdEIBRJ1PFo
X-Received: by 2002:a67:c585:0:b0:5db:e851:9386 with SMTP id ada2fe7eead31-5e827470360mr3060384137.2.1765949713752;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5e81e5a1d6bsm2447945137.1.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7FF503404B4;
	Tue, 16 Dec 2025 22:35:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7C0C1E41A08; Tue, 16 Dec 2025 22:35:12 -0700 (MST)
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
Subject: [PATCH 10/20] ublk: inline ublk_check_and_get_req() into ublk_user_copy()
Date: Tue, 16 Dec 2025 22:34:44 -0700
Message-ID: <20251217053455.281509-11-csander@purestorage.com>
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

ublk_check_and_get_req() has a single callsite in ublk_user_copy(). It
takes a ton of arguments in order to pass local variables from
ublk_user_copy() to ublk_check_and_get_req() and vice versa. And more
are about to be added. Combine the functions to reduce the argument
passing noise.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 51 ++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e39ed8a0f0ae..273d580ddc46 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2612,70 +2612,55 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
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


