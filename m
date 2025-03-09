Return-Path: <linux-kselftest+bounces-28558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA43A58494
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 14:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9D1188D54C
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B61DA2E5;
	Sun,  9 Mar 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFoyQc8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E268BE7;
	Sun,  9 Mar 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527807; cv=none; b=mP0Amhg5Y5xkdiN+nXlVzlOmFwPDhawMYvgt+MpTt5ywOD5kKt/sicpFGSmJcIvWAVfGlCljbTaFJkb9UgCMVaKub1kKgNo1VolGX/31denTVMviKXLAofAFfZczVvDxUY9kjPSyJTtx16SCWgiFY0xf66zdLCmqTIv7iy/Elxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527807; c=relaxed/simple;
	bh=IiW1z7QIbJGiddiyv1XCRJoFgacKOPi9vD/2PdL89ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gI4FnqzVWOR8CKhzOpp0V5PfRORPLTzjxyuaH51xB5RIz2OTW51zDao5TwQ0tIXBW2AMXeDLrsijsvoYFvD8J0wiKRHjsZQdzLYauZit1i9ALeiFFNPLjvsoEJTdYEillWtpDMx8kT9ks0GtJqIvkPHhLFQuENiL6Tmy7ztD7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFoyQc8p; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225477548e1so14246125ad.0;
        Sun, 09 Mar 2025 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527805; x=1742132605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwGeHRAjPCpS0+2BXKkB+qb7ndcH4Z9OT1hF9NTi3r0=;
        b=FFoyQc8p3r2yl+6Dzdmrp/jcsDLzzqE3YTlxXSOSvN7YC5dRLzRcSDGqsScEGYLrou
         rSdEfo7TKdzgJe9Du4myA0esFH9/seqG5+tmcZsN8U4F7kXVP40oIiZJac26wnOWUZxH
         UmV7aXxWoRQCKmscNgZa48igPxztUPfmn6VxMKX8ofidATmplTwj8+piYViWaS9j6pCb
         94b7ai7ZRalGuqvBP5vDs4BSCP9NQB2m+xOavVjrf25Z+9X9+c/Fquy5Vt7BwoMv8ZLQ
         EpGQ4Cy+v6qt+M6i9P1VtqoXX9/q60SjiV3TRlRU0WN9pMogKaFvZNcTp/Y/jlVGWAUQ
         56BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527805; x=1742132605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwGeHRAjPCpS0+2BXKkB+qb7ndcH4Z9OT1hF9NTi3r0=;
        b=TC4N01+c0JvGwbJcr9Art3NXhvv1sJvpRbWSEL8aY3VIfI9NsBE1RPZvd/kRDLHhqt
         Q7+QrZGsV+qdbBsW15vf1nfAiziBd+ff9qYJDk8qv6UtWeuSm0eH2iLm2uFCR2DVUnTU
         pVZYPsy4LzkGDz3B/kM0gKAmyaT5Zn5LRG3Hdv3Zoz8wkBOSwpNMI44IOSJB5+oRqH4b
         w+lqiLREgVJsfsBMvFLRB3QTO0/dO+MYoG5+3XqFTK3CRcXwVgvrP8rTVoJ+UgcEWEj7
         JTaSUtH7RrIkNJwT+sRvgmAaQKwOf130vgOzhfKzTFEG9vk98iWStnbGIgN1EdlUmNZ3
         7K0w==
X-Forwarded-Encrypted: i=1; AJvYcCWq4UeuRwCEqq7jKrvkykDH5yZR9KyQgd1AebSvnbWkqQCYQlwTkZ6wbhDRmk8HYbX7nkFShMq5bofvXUEh6Vo=@vger.kernel.org, AJvYcCX48SQNINumVXHMhXJXQtCI3oN4Q9SzMIHXyMX9a+L/R4J2lC++BghQNOXsJnLtu3P6bJj0oOu5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DT2IGdGwZBmjW0YXYXuGiwxnQyUpKJ3KiKyYvSu3dMxu6o0K
	D1nZFjaEwa/Cm+tsD5spfWjxHhk0Ol4YNQ2fAz6hAbRDJ+qVlum+
X-Gm-Gg: ASbGncv535bMSQniLL5VoOV8Aawi0h2Osu/fEJen/kROkGsKZEaEctp6K/sd7USeVIl
	nT3hdI1rX/lC4+z1vuLunZ2TIlz4/xz3xGf3aQiLQn/5SrfiKESrFPn85WrddZ9HPyooNUYK6sI
	4MJkMsnisNjrlylo+RRjAl5M/ZzoKnpLO0iKUU0SrKkK3LDwFdM+m132JXX1vbBHikY012wF/Q0
	29GCFWAyeS9509CWCeXB20dPmITl8JJ5vtfxR5D6CohvQZcZ51w6c+QwZamY31URiJ87UcUYzJT
	8nsT8uflnJ+BFqwH9My9I15zqb+YzmA3kS38EjsJfWxY
X-Google-Smtp-Source: AGHT+IH8pAQtlrAoAQZ36dI09v94pbr/gAMN2+yP7tYnyKFdRQNRkudn08eaHyFDBHixE8PbbiBZPQ==
X-Received: by 2002:a05:6a20:2d24:b0:1f5:7007:9eb7 with SMTP id adf61e73a8af0-1f57008366dmr3561369637.37.1741527805362;
        Sun, 09 Mar 2025 06:43:25 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c41dda7csm2296841b3a.85.2025.03.09.06.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:43:24 -0700 (PDT)
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
	amritha.nambiar@intel.com,
	xuanzhuo@linux.alibaba.com,
	ap420073@gmail.com
Subject: [PATCH v3 net 2/8] eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
Date: Sun,  9 Mar 2025 13:42:13 +0000
Message-Id: <20250309134219.91670-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309134219.91670-1-ap420073@gmail.com>
References: <20250309134219.91670-1-ap420073@gmail.com>
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

v3:
 - No changes.

v2:
 - Add Review tags from Somnath and Jakub.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6b5fe4ee7a99..acb9500ef930 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15447,6 +15447,9 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
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


