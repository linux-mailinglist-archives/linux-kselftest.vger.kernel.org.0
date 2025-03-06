Return-Path: <linux-kselftest+bounces-28374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B044A54397
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 08:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AE71674D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625C11C6FEC;
	Thu,  6 Mar 2025 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpcwdVY/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5FC1AAE13;
	Thu,  6 Mar 2025 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245888; cv=none; b=uoqp+riLarjZIJlBInmQecJV8NqDMt9pu5nrlEep/caEI3PL7pqhvjd1wt4b9OLYEiRm3hgNoEh9PK6PDVhzOMCeYoOZTumEHFl3S7e/O5A+UCgpVLPAUJgEVCBi8/zbM/HZLAq0sC2G06lYCidKqOQugqR8waGEgY29AYTJH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245888; c=relaxed/simple;
	bh=Z2ETR43ylZDR0RBddM+Y1lYe4yswzdRikYrd0jwrORs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V0Y/bU0tJx2o+YDdcwqis1ZlKJDSgqY5I/IB7klH5uS8vGTMN9XKKuuLqDwu6kgCf01t/y2PCsQYvoYif6C3/wk5Touqm3J+5vfAXFRddfCKyzo82kgToqO8NtrXuJwhLHbQoouF/qxY161YmFEy1L4Or3zyMbDLX9tTmxR+pQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpcwdVY/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22403cbb47fso5056685ad.0;
        Wed, 05 Mar 2025 23:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741245886; x=1741850686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQ/0erzSCMLzRBlOUFeUjQifuFitK73RY3yKfbDyQds=;
        b=FpcwdVY/e/zMEklFLrycC/N3XAtco+/eUdolSKXFHD7zGWaNd/SYNEQ9RwEUWdljMb
         TodZf8E/fl2xZdVVHIKDF6lRiSk9gXSHZX5BdSGok5HhjlF6obBhAFU46udZpc+vza6C
         3piNNz+GI88V6H1QWypY8eQHGzgynKChiWsgg3JsQZQcKKEUdqEYPVoHC17vnvpvVPks
         qMZotTbdiuw5/okgbAUJgoHD2Gu0NyyH8104jOFvqBfEvdKFcBfEOb1gsU+cvmWD+DmH
         5q15Sa6jTYpQ5Gv0CtiFfb9SpHfPsTKlqHPy35cuu54TmguNOkprg60vBr2z15g5M+D/
         DXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741245886; x=1741850686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQ/0erzSCMLzRBlOUFeUjQifuFitK73RY3yKfbDyQds=;
        b=KmwNqnMNz+mOgsZOX+qToi59FVLTAf/5eZHGFKFb6UaffvVL/wOx4PXiRo9EsxNHvC
         YRxostEBNeUJIFpCA5XRZ0Ccvifg1SFSmHcK1wjkMXd15MTbdgtt5yPYJ+wJbAtaIl6l
         yQWFcLuyP82FNg51rS3P4WtGNgboDVptE7HhOuUUx37klV3LZTaKo3h+nP6x6C5jhrtX
         8J5MdD5sGsixTcQ0Hc3IN686ZlAkZi2c6eozwwOqkmRo+kVOU2H+qYLftjqobY5bYUXH
         XE55UL3fTGDpHuhTyAdg3QGGLuyr553Rh6UUYWPbuIBFt0Rja0ephibWrFbvtvCvl+zB
         55sg==
X-Forwarded-Encrypted: i=1; AJvYcCULScgwnY27I6mLbAglZyffhnrR+drHtcgwKVsJsCs/IQ79ooZYJ9ypyF/KsQZO3LBsNVQRmAlJpFiv4YjR/Dc=@vger.kernel.org, AJvYcCXzDZkJsqOp+BGIEFsZSyLgbWL3uDPBDkMZlYYM/sI+97M2XDoP1fEV/NWfhz9xKBIGFi9HGHZB@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxLUhkNTv+E0FiJvow7ye1ttM2exIub2BbbN61wnCtOjUa6FI
	DUmEyehZfbKXkP8cXJTy17WnrDtF5v6NEkIp9tExJUv899aRjsfy
X-Gm-Gg: ASbGncvfeI4u2zT1D7/fsmaTcsN7A8O9L/x6CW6nEiLWzdQPtHtPoWp1assjicHZDS5
	EinaYMMbtbayZCD+hX7Sgwn+ve0FGzDcspvbgC4ec3blr92PQ+jP/JpSBAkKqlGiTutdi6UkjKu
	GpQXygBGlwd3n4JmmXtxMvPfFL7DvqYWQM7AQxxUijCNK6TVjM0CljonleT0YoU10/mucKbYHyu
	jPu3McuIIEE5/ZYy8nCMYvfoiP1pYWoNCQOQmUhQXxKIc3ZOlMpVgeMRvxIAsSAbeWAkS+9oDnn
	Fu+JusHM4T3UhHqXvR/GjpD4URhmO9phmA==
X-Google-Smtp-Source: AGHT+IH30tdh1mFBoNOaWnm5OHmx7GCo8DHs3aF70WDcbZYLFc0l9o+eLfxY0MIfVYzmLCdauVYZpA==
X-Received: by 2002:a17:903:230a:b0:21f:bd66:cafa with SMTP id d9443c01a7336-223f1c805fcmr100512355ad.17.1741245885896;
        Wed, 05 Mar 2025 23:24:45 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693534f8sm567196a91.17.2025.03.05.23.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:24:45 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: almasrymina@google.com,
	asml.silence@gmail.com,
	willemb@google.com,
	kaiyuanz@google.com,
	skhawaja@google.com,
	sdf@fomichev.me,
	gospo@broadcom.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	ap420073@gmail.com
Subject: [PATCH v2 net 2/6] eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
Date: Thu,  6 Mar 2025 07:24:18 +0000
Message-Id: <20250306072422.3303386-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306072422.3303386-1-ap420073@gmail.com>
References: <20250306072422.3303386-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bnxt_queue_mem_alloc() is called to allocate new queue memory when
a queue is restarted.
It internally accesses rx buffer descriptor corresponding to the index.
The rx buffer descriptor is allocated and set when the interface is up
and it's freed when the interface is down.
So, if queue is restarted if interface is down, kernel panic occurs.

Splat looks like:
 BUG: unable to handle page fault for address: 000000000000b240
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 3 UID: 0 PID: 1563 Comm: ncdevmem2 Not tainted 6.14.0-rc2+ #9 844ddba6e7c459cafd0bf4db9a3198e
 Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
 RIP: 0010:bnxt_queue_mem_alloc+0x3f/0x4e0 [bnxt_en]
 Code: 41 54 4d 89 c4 4d 69 c0 c0 05 00 00 55 48 89 f5 53 48 89 fb 4c 8d b5 40 05 00 00 48 83 ec 15
 RSP: 0018:ffff9dcc83fef9e8 EFLAGS: 00010202
 RAX: ffffffffc0457720 RBX: ffff934ed8d40000 RCX: 0000000000000000
 RDX: 000000000000001f RSI: ffff934ea508f800 RDI: ffff934ea508f808
 RBP: ffff934ea508f800 R08: 000000000000b240 R09: ffff934e84f4b000
 R10: ffff9dcc83fefa30 R11: ffff934e84f4b000 R12: 000000000000001f
 R13: ffff934ed8d40ac0 R14: ffff934ea508fd40 R15: ffff934e84f4b000
 FS:  00007fa73888c740(0000) GS:ffff93559f780000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000b240 CR3: 0000000145a2e000 CR4: 00000000007506f0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __die+0x20/0x70
  ? page_fault_oops+0x15a/0x460
  ? exc_page_fault+0x6e/0x180
  ? asm_exc_page_fault+0x22/0x30
  ? __pfx_bnxt_queue_mem_alloc+0x10/0x10 [bnxt_en 7f85e76f4d724ba07471d7e39d9e773aea6597b7]
  ? bnxt_queue_mem_alloc+0x3f/0x4e0 [bnxt_en 7f85e76f4d724ba07471d7e39d9e773aea6597b7]
  netdev_rx_queue_restart+0xc5/0x240
  net_devmem_bind_dmabuf_to_queue+0xf8/0x200
  netdev_nl_bind_rx_doit+0x3a7/0x450
  genl_family_rcv_msg_doit+0xd9/0x130
  genl_rcv_msg+0x184/0x2b0
  ? __pfx_netdev_nl_bind_rx_doit+0x10/0x10
  ? __pfx_genl_rcv_msg+0x10/0x10
  netlink_rcv_skb+0x54/0x100
  genl_rcv+0x24/0x40
...

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Add Review tags from Somnath and Jakub.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 13c9be49216a..d09986308582 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15439,6 +15439,9 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_ring_struct *ring;
 	int rc;
 
+	if (!bp->rx_ring)
+		return -ENETDOWN;
+
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 	memcpy(clone, rxr, sizeof(*rxr));
-- 
2.34.1


