Return-Path: <linux-kselftest+bounces-48246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52951CF6250
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86E3B301066C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1BF21FF47;
	Tue,  6 Jan 2026 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TWAeK7ef"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348D21ABB1
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661094; cv=none; b=jIxbQnjCVsxgbRn241nuuw1ixdE3BEWa3wTe+B8BLjNRSgQYde5HkUPet+hXZ497H6d8iySQNQY4CBpU2A9lXlxtj3W+QyOtKjB4tiq88/dC4W5SBdyQTSKUihe4bkUXZdMypruQMwtiOfodXT1ZTYGqCq5N/VFmphAPw/D94qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661094; c=relaxed/simple;
	bh=xHvrkEgz2WvZ9OoqaXDDaPWd2yWpis+tMY2RH20oDb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlgJeHW6/CzKuHGG40XUxadpM3PeEh6V29/lCwwhGE45m1O5OINPx6VFJgfRWbz4p/irTACJL+GjTbqgwOG+a5RJUIZxgLQxbIqQ+dIvu2KH9a/8OeOSuJn0yt7EbP2PmrrQJngFnPHxr1kHm9EqN4iTTdlSxGG5kpaHWqsYbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TWAeK7ef; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5595f3acf27so18683e0c.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661090; x=1768265890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHwNeWpxsuVNiAeaG97ODUX9kjPf4RtR7cZvVnbRGp0=;
        b=TWAeK7efFGCIVvCYJhoMcyQ/VNqn9FkJmvWuiac6uaPAYZo3ttMJnIdUv7b1SUGJV4
         Z8Su88R/Jp+AQOkrSziqiRRYSzOIqPwnZa7lVttm1RvPaXFzbgIn7qv9Z0k/i1Gpn+Y3
         7P7rbrdLdQ6JNV/UQMVslVouX2OEJs/fHx0VC5H8Lf+2JrSON5svS8D8Cz5LP5r7J5SV
         EXoqlQznae2TYevJ7ScWtlJukz1LPtn85ZAj7x1Tf/I7q5QJeMiYwGZkDOTcvj7I/QX/
         js0J4gfInp5NxzdtYyVVfYhTZra0NUHgSSAAYn6AdetfqGookqDboml1G/sGe0QIDZMn
         bQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661090; x=1768265890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IHwNeWpxsuVNiAeaG97ODUX9kjPf4RtR7cZvVnbRGp0=;
        b=GI0LObbJgST2wpV6MMTZi6IBrjiVnqKB+EtGihnZkZ2VDpj9ZPuxftCJ9WWXOkqjIj
         z5f9yHfPwj+umFprwvgtfk5keBPlJjWyzWbIdRrHu9L/usLA8T2dNb/TDzFEtosi7bkA
         t9H4wnaJzAChXrRtfbieExwQtbFc8QiAc72DRNxhhMzeggCw5uNbFQDdkKAMYIQCKTQ9
         ir1SOaLNzAhpHJLwQ+aNiMEGwq/SpasjdeGeRBnyuzV/GNpat4XqQts8akxW32vrvI0p
         uttN+y7Y1jW5jh+GCRSJZnfp5xa02RVYBE3bCiOVVPgDIUk0lmu4n2cA+76vX8chB2Jg
         V3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjRPeziXZTjNe7uYQyWS0sww7MZQ/vk2sM3goLL7qWhTY998NQTTQPsoTSjFLK2gV/9W9gTPLuxEjEiBusf8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpuDK5aslh6DoO4vgZEIX9Z7fwaMBaDVSWOrHsBm6kUmciayDM
	jM6YZm5CsNaTmyC/Yft4ckXlUc081jKr1+IJAb136oI2c0SCgZIGGAudT0exLmiGYJSA8bvcj+6
	U6A6g2yr0/LwQLJACn7ENktIPQt2gy8fmp8B7
X-Gm-Gg: AY/fxX6LWUczsKWhpYip/L6UBEfzhM6Qzxu32vNMW22GJMhpKJLzgT+a6f5Wahy6fNK
	jJK7SGpgLGmiAbKm2gflbpWcYHBXZfoeGcigjHfLIEbU37PdIRshWbgkQcHih+qTlR/c0LnqlKK
	xEk/EP8V9dwFtgUDa8OovN0gfszFDOgl7BD9y+0QITNVUwhQ2ZVJX4rpdW9ZTlfnqS+Fl7LTHIg
	Maq3hJUAjkudCInQKljztZf98XgSNVRvNYlOFBbiPb2K+qZ8whB74d3RiQj58EjCOnoGcL/8YJR
	3oIXM2hI2+OcJ0G8FtjnxilIS2GEuQwLMtAEjFX4D/YxRt46MB3fc2JxmBhszZrMLiWRdT3fRS2
	GAJfKUve9Rr9MjvvUzmda5yExNCJjCnFb9J4ZUFk4vw==
X-Google-Smtp-Source: AGHT+IEn0bj5sNsdnfs4VN4bK7+CDV8894QghoiK47tRbebopAfq6bRnonYUqOeBux8J2mhmysQjCL2w555n
X-Received: by 2002:a05:6122:a0f:b0:559:5755:f461 with SMTP id 71dfb90a1353d-56339557d77mr266464e0c.3.1767661089999;
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5633a3ed8a0sm84762e0c.6.2026.01.05.16.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B020634173B;
	Mon,  5 Jan 2026 17:58:08 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A28FBE44554; Mon,  5 Jan 2026 17:58:08 -0700 (MST)
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
Subject: [PATCH v3 05/19] ublk: add ublk_copy_user_bvec() helper
Date: Mon,  5 Jan 2026 17:57:37 -0700
Message-ID: <20260106005752.3784925-6-csander@purestorage.com>
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

Factor a helper function ublk_copy_user_bvec() out of
ublk_copy_user_pages(). It will be used for copying integrity data too.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 52 +++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2b0a9720921d..2ce9afdecc15 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1000,10 +1000,39 @@ static const struct block_device_operations ub_fops = {
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 	.report_zones =	ublk_report_zones,
 };
 
+static bool ublk_copy_user_bvec(const struct bio_vec *bv, unsigned *offset,
+				struct iov_iter *uiter, int dir, size_t *done)
+{
+	unsigned len;
+	void *bv_buf;
+	size_t copied;
+
+	if (*offset >= bv->bv_len) {
+		*offset -= bv->bv_len;
+		return true;
+	}
+
+	len = bv->bv_len - *offset;
+	bv_buf = kmap_local_page(bv->bv_page) + bv->bv_offset + *offset;
+	if (dir == ITER_DEST)
+		copied = copy_to_iter(bv_buf, len, uiter);
+	else
+		copied = copy_from_iter(bv_buf, len, uiter);
+
+	kunmap_local(bv_buf);
+
+	*done += copied;
+	if (copied < len)
+		return false;
+
+	*offset = 0;
+	return true;
+}
+
 /*
  * Copy data between request pages and io_iter, and 'offset'
  * is the start point of linear offset of request.
  */
 static size_t ublk_copy_user_pages(const struct request *req,
@@ -1012,33 +1041,12 @@ static size_t ublk_copy_user_pages(const struct request *req,
 	struct req_iterator iter;
 	struct bio_vec bv;
 	size_t done = 0;
 
 	rq_for_each_segment(bv, req, iter) {
-		unsigned len;
-		void *bv_buf;
-		size_t copied;
-
-		if (offset >= bv.bv_len) {
-			offset -= bv.bv_len;
-			continue;
-		}
-
-		len = bv.bv_len - offset;
-		bv_buf = kmap_local_page(bv.bv_page) + bv.bv_offset + offset;
-		if (dir == ITER_DEST)
-			copied = copy_to_iter(bv_buf, len, uiter);
-		else
-			copied = copy_from_iter(bv_buf, len, uiter);
-
-		kunmap_local(bv_buf);
-
-		done += copied;
-		if (copied < len)
+		if (!ublk_copy_user_bvec(&bv, &offset, uiter, dir, &done))
 			break;
-
-		offset = 0;
 	}
 	return done;
 }
 
 static inline bool ublk_need_map_req(const struct request *req)
-- 
2.45.2


