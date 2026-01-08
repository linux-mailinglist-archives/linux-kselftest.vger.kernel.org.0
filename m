Return-Path: <linux-kselftest+bounces-48477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F9D02215
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 11:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 136F5307B82A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2F742AC7E;
	Thu,  8 Jan 2026 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OJ9g9pen"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3942A574
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864009; cv=none; b=O6H89/TW+wUd9lvtb6pQA5/VnNbPWXu1+jLt1lEH+pQID4SbhD7ruCwZZ9l3yE/GCMcbQwm9e46+8SEf410N8+a6CLvYB5qKH0nb2gsjwhvq77hN2QkSWsm7i18taKKv5ifU0MhCM1ypbCtlvoLDcbhM0rnOffTgTq5gI8HreZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864009; c=relaxed/simple;
	bh=9D4GyOJD6io8F4P0S/cxnoZEefdej4J2wab8Tdm/MgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/TzcDCKI1aOfEBc0pYlOPojcgpBFgIiokJM+CZqkrbSDsE1acRG+iQ1M3gmEMDCvDp+Rqtqs4WczyDRhy7MQMXx87l4ZEIZM/MeLP9TQzlkonpmQNzBHB3kCOgr+uY0zacrotSLOlglvsf7k+lXnUhmBlLDbNerhAcprnoESGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OJ9g9pen; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-5ed0b8b171eso64217137.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863997; x=1768468797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSXckNgZ5ICG+taX3/Ya5CBeOAwOb38yMX5qmoedbkY=;
        b=OJ9g9pen93eIGDiu0Qv1KqQ7YDKu18c7oO2zRfQmiNwqiLfsnTUFNMG1OLzN3vQHx5
         WploqwnCtbm8tl6ofEMyGT2XCkvuY9Uch1egjs7tptV6qXeedsjqsHEm1RNQ98tk9XWv
         2mUs2rzCdx4EE6SrWFPOYcmTPi+CD/lBhk/n6LrjTApKqvY+JrNx063CLMpv7/QyE/hG
         0lJ7Gf8cC5tTXoAiEioioRpueKv2TFZodOL+cqkv2WA0/7GPnL59XhHOs+mmPhkW2jil
         GkTql6seuv0iAocdT+olA5THhqisrHrGjoM8QbXNIWb5nS2LyC/KY5oe4pMAMNmFLh/0
         CStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863997; x=1768468797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kSXckNgZ5ICG+taX3/Ya5CBeOAwOb38yMX5qmoedbkY=;
        b=VvIoONbelT3C1k+PUK+vTC8u3qDPij6TU13rlMtOD9f71Csr9kacOMA6kO+M81RqTi
         cJkXN01Pb7o0I469uin9dVLWoq4jnubl8GNpKOnhDNyYO04UKoaPMkpDYLC/RwIwc9D4
         7ioM/6K6UO5+cfV3/qLkSi4vVwm1NU/gpDVnvEz4EUvjp105EW4ygpcjdpc0Yk//Ri4u
         M/+aIiFguLO3D41CYtuymKvWYWm4X6ZBiSROokQYlf5Fa+sx6mceNKhyVnW9fC+lwLjL
         c3iRxvQhu6T8nd5xW2fIYUE0A0ZfQGpZMzB4LqqpCtBp33EJPoQzr3I2C9O0GTJX27Uy
         D+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyGQ5GeFsekrSNgvqA4lyI1Yn/CZVt1nojKFrfdXJaEbp6hqjIPNuNVgrWQxpbhIFupqqA/IJWidAMpgVf6pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4XJ/mJtBCTvu/xjT4CIxwKi0/M45qlmsoVSwCCfEmpjPbx/Xl
	qI42jmFIk7Rl6qZlE8cZ+82A/Jh1Sn4SXEU/lmVS+zFeOfHeF7xWf7Aw8PrEXNJOqpDHtqu8dbS
	k8j5zhWTLruekFOlo6l/4wsvqaLceecxNSjzp
X-Gm-Gg: AY/fxX4mNcDOfC5YRU074GvVFX8IXNEuEvKvf3N6+XDDFBlSIGIgxzPE2PSctMCo/Qi
	V3mN/Gf3s5mKHez6G0DY9XLRShC1/olfgvMCnOPTtvCHdvhHYx0pKCXZVI1d5oPSdu4E4wKmoRO
	W+ICuVbMyMp3H0HDUi4yOhh8Whys6m1y1apy+jF+ZnylwW1EfJUmvBJJMzIIMFI816VC+z3OqVB
	dbwBIBGMvyinfCDv5ltdLac394xVvyDFcjYezt16EpslDc7JRnrcYzql7hB9pzRjs5Rh6cF58rx
	2H8RCo7dZhqF7qexYN6gaihpQaX3FOdz1kvfCQYmI8cF3+s30748hCKzduCxvAPZXnjqnF7E/ur
	eXllJgHbPYYgdn/NhS/SmEZ4XXvoRrttriq2h5D4t7Q==
X-Google-Smtp-Source: AGHT+IE7Ge1AcENQX9O/MS5JVNja68MmFbDGu7d8jgtYr1HGUxQVFEkLjbdXGKK42kA/Gk87KY6YQpwurEsq
X-Received: by 2002:a67:e701:0:b0:5db:e851:9386 with SMTP id ada2fe7eead31-5ecb1e75d6amr1271152137.2.1767863997587;
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5ec76e62f92sm1109185137.0.2026.01.08.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9BCE6340794;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 95F68E42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
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
Subject: [PATCH v4 11/19] ublk: optimize ublk_user_copy() on daemon task
Date: Thu,  8 Jan 2026 02:19:39 -0700
Message-ID: <20260108091948.1099139-12-csander@purestorage.com>
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

ublk user copy syscalls may be issued from any task, so they take a
reference count on the struct ublk_io to check whether it is owned by
the ublk server and prevent a concurrent UBLK_IO_COMMIT_AND_FETCH_REQ
from completing the request. However, if the user copy syscall is issued
on the io's daemon task, a concurrent UBLK_IO_COMMIT_AND_FETCH_REQ isn't
possible, so the atomic reference count dance is unnecessary. Check for
UBLK_IO_FLAG_OWNED_BY_SRV to ensure the request is dispatched to the
sever and obtain the request from ublk_io's req field instead of looking
it up on the tagset. Skip the reference count increment and decrement.
Commit 8a8fe42d765b ("ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon
task") made an analogous optimization for ublk zero copy buffer
registration.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 08674c29cfdc..707a74ab083a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -181,11 +181,11 @@ struct ublk_io {
 	/*
 	 * The number of uses of this I/O by the ublk server
 	 * if user copy or zero copy are enabled:
 	 * - UBLK_REFCOUNT_INIT from dispatch to the server
 	 *   until UBLK_IO_COMMIT_AND_FETCH_REQ
-	 * - 1 for each inflight ublk_ch_{read,write}_iter() call
+	 * - 1 for each inflight ublk_ch_{read,write}_iter() call not on task
 	 * - 1 for each io_uring registered buffer not registered on task
 	 * The I/O can only be completed once all references are dropped.
 	 * User copy and buffer registration operations are only permitted
 	 * if the reference count is nonzero.
 	 */
@@ -2689,10 +2689,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 	struct ublk_queue *ubq;
 	struct request *req;
 	struct ublk_io *io;
 	unsigned data_len;
 	bool is_integrity;
+	bool on_daemon;
 	size_t buf_off;
 	u16 tag, q_id;
 	ssize_t ret;
 
 	if (!user_backed_iter(iter))
@@ -2718,13 +2719,24 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
 	if (tag >= ub->dev_info.queue_depth)
 		return -EINVAL;
 
 	io = &ubq->ios[tag];
-	req = __ublk_check_and_get_req(ub, q_id, tag, io);
-	if (!req)
-		return -EINVAL;
+	on_daemon = current == READ_ONCE(io->task);
+	if (on_daemon) {
+		/* On daemon, io can't be completed concurrently, so skip ref */
+		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+			return -EINVAL;
+
+		req = io->req;
+		if (!ublk_rq_has_data(req))
+			return -EINVAL;
+	} else {
+		req = __ublk_check_and_get_req(ub, q_id, tag, io);
+		if (!req)
+			return -EINVAL;
+	}
 
 	if (is_integrity) {
 		struct blk_integrity *bi = &req->q->limits.integrity;
 
 		data_len = bio_integrity_bytes(bi, blk_rq_sectors(req));
@@ -2745,11 +2757,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 		ret = ublk_copy_user_integrity(req, buf_off, iter, dir);
 	else
 		ret = ublk_copy_user_pages(req, buf_off, iter, dir);
 
 out:
-	ublk_put_req_ref(io, req);
+	if (!on_daemon)
+		ublk_put_req_ref(io, req);
 	return ret;
 }
 
 static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-- 
2.45.2


