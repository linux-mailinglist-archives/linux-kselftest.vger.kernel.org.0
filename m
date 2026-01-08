Return-Path: <linux-kselftest+bounces-48483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E50AD0206D
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 11:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C952B3016DCD
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F3442B931;
	Thu,  8 Jan 2026 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EkrDFRFG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494D42A590
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864012; cv=none; b=cUaGGRZYoT8RO39xz/GTn2uQ0p1+CeMZZxAd4faQAHFQupzvC6cGNuVRZ/mJyovKwPLj+nKaEqgU7EwhsApC7Kwt2WGn6c8yCxdapPXYTQoQHPJKglmaOQGzQXqDAkUf5mcFwi7iRCoIFwMaMuszhLKvd2HRHawzz7+QLzOZsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864012; c=relaxed/simple;
	bh=MsJS7V6fpUg2zBKi42tVc5Ptl7uOMehQJ8c0G3rEClk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQXp3OEpRRg76bCfj5qCgV4v3f5qp0QywLXcTNNN8RCwTpjUgPUIIHm79Zljfa3B/FWGd5pMFRj6RN8BbgTjHnDC7+RjhaB2P66own2ysFBIfK/foKM2hBp53J6cGobs/izukNcsKss5QIPUSWIzgpi6hiDCd31OsVY91j1C4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EkrDFRFG; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a08c65fceeso5429295ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863996; x=1768468796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFGr8sSgizfUuX519DO/CGZxfXJRTiuzDWpoBuOhO+w=;
        b=EkrDFRFGn9vhCHGVI3o/5hs+jr8LHW4Lh/ZlqsU+vYvXaMHQM4/I2s1V491oX9chQz
         c7OT7DSmMA5FxEsON3BXFgp2/PED63gp2R9f1A8StaBRen3VXMPOMvWE2DQkRk/XllL/
         LJaGgPo32q4/83kM8KWxyy6PlFRfvTsFtiFIDRyOJTiG/gtgvp01eNzdQXp2mn9hokpO
         ePocZKvn5l774pVIAeEW+q+TF9QI2ts9vibcAmyPxG2M7nKFOXalhHxNO63yV6zz6oKx
         ZmCgP6jYlnBfRs+RqQN0dMao1cfj3Ns4MlfVhHWdLThC77rC8TCbe+B3Jq7T33H7RsDn
         g9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863996; x=1768468796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jFGr8sSgizfUuX519DO/CGZxfXJRTiuzDWpoBuOhO+w=;
        b=vqiexatKamq2p+Y6o4UW47xB2BjGTcH+wFhTkJ1dxWszMjUcNoBi5xAsCvWlcBTP1n
         MUtphVgKSOx2EpiRO9n4MGK8rpUDIUG/yREbJBCwwcExMNYC0AMPqH2SiibOqSefWx6V
         SXef90pqh54uE9k4cj1jLwQRDEmHLztFWbBSzxKZpOEWv5c2D0OqTPK66pL+9F+spd6/
         7A6zGsBCJ5FbxlkSLTdJ6OgTxZ0ci8Ko4fujKbHUtA70R/HFmTLd/qRqQ4p/gS6rmR+z
         UcUbkcTPW6hUzYLb3mIU413tSc8M7CDRkdsybyhVC/fxGWM2det8nN3hdLQx2Ejm7Thh
         nakQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzVzCBJ+QRyvKzE8fC4JS5UvlKQ1Jjpqj8z6VEOjthH13v0eqpDNjYYY3I7fD3gnWpsvCVGbqtDg6MPK+Reu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHK3aLDCa8FJ6EEG36vOw+pFd84eF6jY3EYhP0Lrz2gtlQlKcw
	7CqOjv+Hk03tQWtn0J5CykCzPiDsNdVnGzxRt/lvERgkGLrCJoBvLSU59PoKSXf8i87J5Jmlhrw
	qhvkfeh/iLax6ZkYhEAGGOVkY4EVZho6EHHoi
X-Gm-Gg: AY/fxX4lyuD8kxyM10Hgu73izCWr3AxUkDS40mTkIP2I9UD4LF5LiFKcql4zo8A/iR9
	2cUs6KHLMMoAhmTanA4g7KYG7SPpF2+QySnh0j1QXUxfpgxDZHnmI2pEQBv1fthRv70v/zg3AN2
	CxgwGYc/LaVyJjjzzWXDZiQqN1pfHeVtGYeDhJHn57bI+JGZ69oG3us2oyd2y+mRb/mixeKUpW+
	SEe7wPSsFtCcdE0D5t0a98MnP7YCmXsS9hwsbWvIiRLg7Ijoy+cbbB8XVlSAdTaTCxpcXMnrZos
	uQAqNLVG3kRo8XnIxVizgZC2N3h8YxHZYECQrjU+GwNxoJJAJ7v+MqVMAErsTeVQq+8C/+waQYu
	gMexObLAV6CboD2YlWBwmPDajpNt1YJ7dOjEb6hgt8w==
X-Google-Smtp-Source: AGHT+IGbE42kNiN9VAF9w3CyUfpY7emMMXpuu2bSY/RAho9b530kNluhzICcqsPKlkiWwq+LyOI3a5W7H8Xc
X-Received: by 2002:a17:902:f78b:b0:298:9a1:88e8 with SMTP id d9443c01a7336-2a3ee4b33a5mr39639025ad.5.1767863996530;
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3caea08sm8405455ad.32.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D97BE342258;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D4409E42F2C; Thu,  8 Jan 2026 02:19:55 -0700 (MST)
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
Subject: [PATCH v4 06/19] ublk: split out ublk_user_copy() helper
Date: Thu,  8 Jan 2026 02:19:34 -0700
Message-ID: <20260108091948.1099139-7-csander@purestorage.com>
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

ublk_ch_read_iter() and ublk_ch_write_iter() are nearly identical except
for the iter direction. Split out a helper function ublk_user_copy() to
reduce the code duplication as these functions are about to get larger.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 22e82bbf50ce..225372cca404 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2700,42 +2700,36 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
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


