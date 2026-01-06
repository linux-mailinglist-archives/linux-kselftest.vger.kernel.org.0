Return-Path: <linux-kselftest+bounces-48243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2258CCF625C
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C345D30608AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9D523183B;
	Tue,  6 Jan 2026 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gI1Z29pP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8EA20FAAB
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661093; cv=none; b=CgNt3nJZNWSpIDKWKoKXruwIoRwwfAKlj/t6RG4GpMazNbLHHoX5M8W8dYJcuy4tg+9yNRKhnFL2yF4bmkluYJnSvpHhYryjznVaxudGTMggX4jsPoj4M2Onui3EVLpwPPlU0PqWvjMOz/qJrtcOetAyD5E/nyvTh7k9NS0jYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661093; c=relaxed/simple;
	bh=jzyih9dafZ4XR2piw4ZWjyPqJoo0c71+VM6fgrf47l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIj+YmY+AkNR76vJWFqFP6N8bSqTcWHAwDExjprmhCA9aAJ70qeq5qc5ue31YGoK4oSb+dHOrd15Xjy/Y9YaUVOEFpf+5vIjPaFUwwq0HjvptO+rVyvZf868+gTmzwdPQDic41maIjFbWHnZooCnCzixHw80F7ER0/qTu5Z6FW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gI1Z29pP; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a08cb5e30eso1067845ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661089; x=1768265889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieqTxRr9zPk5de54duzCoKw16y8ifpstASg31G9cIt4=;
        b=gI1Z29pP4yAXZVJRn4QamN2Jy0wSyUYwFPSB1tS1W+rn5Puz5rbJGKEkx42meRq3bN
         JUqSUxqEocyePhUbXWGi+2L8GMF3SLTsoqxzdYmdZrVQPc6ZRFtqgd/GXu+VUcYrVvKM
         P5ntAUeiumiqZrznCOJ37C6TLaVPzcOYKf0HGflGWzQ3GnfZHiSFJK5zYpDDluuCTlqH
         jwGQBWd50yv3WzstUaYUthE/E2+UrVek+eh2zzNooo4hd3u32o+G0gBs8yqxV8PRJPnu
         SHDnm33/H5m7hwFZaytbYDHLyBg93tpIrUivECX+1C88MOXe/2fPa2me0MX4UNsCyjXy
         Hmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661089; x=1768265889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ieqTxRr9zPk5de54duzCoKw16y8ifpstASg31G9cIt4=;
        b=pd9QI73UMYlSystLoqZ6/HHsZbnpkBzeV6cQm1dCf3KYpVE/AtNwSl7GUrPfLVM0Mz
         ZJhI86eOaxb1X9K7ljzCavMqZ8Dlogp8rNjw3ttrGUgpU7ZX1IakaRCioKs9b4gOwySW
         jHTizWFzYXiXWUZgIgfHcZmpX+KAI19ateTrbp1vqw8EfGRA7qSZl8UOoxK5sLv3zWR1
         rzoqx/QIvdA0CEa60xZoV3XgwkyZKa+pUvjKvzLqhTTmxp8WmP1cSF7jn7ja/FUF2CkM
         znB4gVpf/joY2EszRZhdNbAhx7v2nOURkYq0rI34i383OQdVS0PxeCqt/AOdH4PS4wtR
         tpOg==
X-Forwarded-Encrypted: i=1; AJvYcCXXi5sPfxL5Hi1NyTmjFBQGyfWBc2T7L3uJhP5bo1ZKEsI+R8bb9/3TK/tJ9F+KVhzBonNLOhuSsiEXcH0E+5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkmk0gZSdHNKHlff95vhGhGhUtXg+wPURh4JiUkvrLi2abdsj
	nrWarjKKeYtENrUPseKbxkmE2JMykwY9tmS/w15vohOMQiG+sSYCXVCg7w8foAj5+2e0hGHS3PW
	o8pelpPSwiZ95Rkp6iv33twQ59YSk00om5S5h
X-Gm-Gg: AY/fxX6l7mg6PjxEwtSlY4HogQjFcO0rVYhZNQaGrPmyPvGCwAQUkneq0/7F7iqe8xP
	EI38aYg+ZV7pAQhy8WL2nDJXAg9cThVAi2Le4Iuz1/n6cWIM/T7mvsiSPV3gLdKgurTctIwpD9T
	kmBfz4gZlsQBkGNmtll/NC03PWTBFMwbgbGS0B2WPQOezkijRzSMa9FKSKiRE8RAmy3j7UcwcWe
	n67q+iKFf+y7BLrxe8eV2wJknyKt4qFsvrC+74XfotRU6eLmb6OtrA8/rWAA8VQOLeDHglGEd0a
	mp9gzPu0NjozL3y2sa1MP8kns1QX0e0m3frXx4R72/LNQNc5uV0nUOSQ6+md37/VtVc2O1Eo/2Q
	9Em5XTlT5El0AEs4+BE39BYuRAbLW37WEpw848kOPhQ==
X-Google-Smtp-Source: AGHT+IGUUIlq0t3uefFMiXwBaG09hS89DAoxd/gq2atTHMJ0YrjcZZdAsObR5myPEQGUUl2SKt5hQt3PWz7w
X-Received: by 2002:a17:903:2f8a:b0:2a0:992c:1ddd with SMTP id d9443c01a7336-2a3e2e22affmr8386995ad.8.1767661089556;
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc48e4sm850425ad.41.2026.01.05.16.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 202AC341D2E;
	Mon,  5 Jan 2026 17:58:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 11EC9E44554; Mon,  5 Jan 2026 17:58:09 -0700 (MST)
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
Subject: [PATCH v3 07/19] ublk: inline ublk_check_and_get_req() into ublk_user_copy()
Date: Mon,  5 Jan 2026 17:57:39 -0700
Message-ID: <20260106005752.3784925-8-csander@purestorage.com>
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
index c3832ed8cec1..abb668b460a8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2650,70 +2650,55 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
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


