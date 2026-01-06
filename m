Return-Path: <linux-kselftest+bounces-48244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2126CF626B
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7656F303E0E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F6E22172C;
	Tue,  6 Jan 2026 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Grk2hLNa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DF21772A
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661094; cv=none; b=Gi6LDJzbVjr074yQjiRziTbP/CDadjhhRlAHBae/LjSKqaWRNTYWhfX72k36VWz+ynR5hSqoQLWjL0vZ1cFD9rVkNyluGpLBPRjVOYlRr+mu5D3ks6qoS6VHz+Pd4sfCKOmwF3BmvSyiGbUjhHG/7C/zKoPnkPWkQn3erPkpREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661094; c=relaxed/simple;
	bh=h2X1ZWO1y4UUJFzrWl61pBJcNiTBynvwTGaZHdcC50o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uY3XzGBLbBgmxlmodsNGiuuYDbNZWL8nZS+/1+tEupO7in5bmUzHbRYDYULdXnHHkQOjUJUgLgomF8mg0NsnHxO9AfLUHj07SK4aWyMcBCI6mSXahR6iHDyYqtI5I3RmmWciUJ7qO0ONDpLefJB0C6yjpHqOMaKUa4rEO0Gk+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Grk2hLNa; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-6470d549e10so48893d50.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661090; x=1768265890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slGh8Pjkarq3D8VYCdEWTgiawZdNotszyBup3yDWJ94=;
        b=Grk2hLNaEV7yrCWug6KF3ZVe1mLxzbOur7BpKSC6b0aXtbvgr+tzRfwcTSfrfTwy0Q
         WFMgvxCoLCrXUjxHPKM/vJY1zmUlBEfrjapNFmbNG889MGofaOYfaejCj+mZh/zTfsFy
         Px4AU2MF+SVVEwCwEBOePogYXY5XcDaJIEEZnT0UAxS+pDn6aFuhCrQq8FixEl67IiZd
         36/GHHKrG7SdAwUJ+oWpDZ3c0xSwlgOqBMlNi4e0X0XN1XW+mAVzxjjQ6Qj9uMf2s4Mr
         M3j/CEIsZAqJZO3oOVa2rtDQpN2iSNbUwQCCQFu4gYax0qSB5A/ydRd2mCyijcJE4eAT
         DXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661090; x=1768265890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slGh8Pjkarq3D8VYCdEWTgiawZdNotszyBup3yDWJ94=;
        b=uyN7CTJX+afOYbc3EAOvEk+4cCG1UMpZPjzX1315sJR4VFXbY2qwIvrD9jAsoHjQUq
         hnFIwxFZJwoDbxdiOngH1qdytq6yqQa+RDjsnU5nvUoSmtqquXBhxTydYKHcIycZ+dZQ
         cXhrfhahT2lVyE2AzeWBtdMUBOHZgnyT44O8K3d8fRZwmmC4/3svZH56yi6nFECuS+3L
         7Kb5AchkaNLn2PsQe7cz63rIDlutNDe6m5YaXTfzKr4X7TOf6inrQK2/qwqqudu9MyvL
         e3eH9CFyn2WOjR7vw2uJYXJSed5ZY7+TLjn75PnyJpsqjqOceM5gfACC8WN457uSxM32
         KhMA==
X-Forwarded-Encrypted: i=1; AJvYcCVDR28mvhWFCC3dZOx8jtZrjTZHHRDlrwNdTe0b6w/n+uiKgjSgXnQjR3yJFyhSPlEJipNo6KkmeIjHNkF6naw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+CsY2gPH6rLJfws0idxhVcST5kafxnbaNz/8QFPczqUdKxJ8N
	6SUUt5b8hnC/ar9w5g19pS4v3Xje25h1zv/cC7J0g84abUZwPd+lMF3dyLmBNI5/2qzEOwaXMbE
	kS8/uxXgsv2GojRSzq7+Nw1BXYGeVBfzJFw3kLfL3pK7+scbS59OV
X-Gm-Gg: AY/fxX63ZeTv/fmi2BnsK68ewvHBX/vkJHSXInueYbAW2GEYLp2/TttZETVzphdkpmy
	SR4+Rq8oFOYsxvnFkbzyaTNJfhxVAh4G2V0YNNPR7D7zPfC3lMUITuQ9KvU4rOCSZEJ9gEc0DLk
	7MtZRIUTvLQ+JVbjzc6sQjyyARc5J114rjgIzl5TCmfMQACa+nz7g15LAYKZXEJEHT+MuY63lzd
	YZuSjRCP/dNAogTcxLLX0JEDtIRMMHr0Creys7Fjyav3UY1p3DYCVULEx/UYZ8NcgmnvtcWzwAi
	hgNg6FxElNnthCA4Acvrs4O6fEx6doH7wJYxvDn35nmHcGuSao59eZa0ul08EcvBwSE1INPTVMi
	SDLlG8PCSwd1zmyjSbcKtui6nCCE=
X-Google-Smtp-Source: AGHT+IGGt5rJUjZMWpNtDxleRmkLfQrCcatBCgXXwQ9lzfw8U+88G65krAcdFvyhL5DbzEgyenmVPsTejlPO
X-Received: by 2002:a05:690e:b4a:b0:644:7182:dab3 with SMTP id 956f58d0204a3-6470c8413dbmr1146154d50.2.1767661089760;
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6470d8c4d07sm70913d50.13.2026.01.05.16.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E6802340960;
	Mon,  5 Jan 2026 17:58:08 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D8B53E44554; Mon,  5 Jan 2026 17:58:08 -0700 (MST)
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
Subject: [PATCH v3 06/19] ublk: split out ublk_user_copy() helper
Date: Mon,  5 Jan 2026 17:57:38 -0700
Message-ID: <20260106005752.3784925-7-csander@purestorage.com>
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

ublk_ch_read_iter() and ublk_ch_write_iter() are nearly identical except
for the iter direction. Split out a helper function ublk_user_copy() to
reduce the code duplication as these functions are about to get larger.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2ce9afdecc15..c3832ed8cec1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2695,42 +2695,36 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
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


