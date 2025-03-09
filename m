Return-Path: <linux-kselftest+bounces-28561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD5A5849A
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 14:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC7D3AE586
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 13:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82B31DC98C;
	Sun,  9 Mar 2025 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/Y6BDCd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC61DB365;
	Sun,  9 Mar 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527826; cv=none; b=Ny8oxQfjIWklafmmM286Y4Z/J+XDeG7KB5aTu7WFre2W8NSLUJA+pCVdfzvOrpsL0Vwhb011N5GAL3cPQLyDCZcxjWzv8TZ1pvjD4ySM3MdrNkW19sWOZVpQcYdMkfLVX+H5A0bOd5A32+blBJTUGiW94YfPDuo04d+sKmFWwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527826; c=relaxed/simple;
	bh=SPYXJYaDcfE/gDH/liXDdOSm+iSFNtvfwFEf1d1WtcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=frHccE1Hjopf2x0fdObzjhOca1EBC0uR//xuQ/K8UKwL7N28abv6DPjLiRTd6rYGvu/RzGJkBJaCbMLcsmkTQfL0yMQMnDZXLYpnnXXYF+Yf2hJalekXSS5Q/BjzopAB01l62+EubXrMI0cIqG6W7jkYS1Jo+dtzkgTCrreurKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/Y6BDCd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2239c066347so56565305ad.2;
        Sun, 09 Mar 2025 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527824; x=1742132624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZmnphCh5t5ZmRNjQ/jjVilH899pEZQFMcfX0b+XOCk=;
        b=G/Y6BDCd2bXUq3hNC35sXJrCwMQqA3ErZlmbo2z922v9xKCFb5XgwZmUW3c/7r40dK
         2GpDKTBAGHVP9AMu5mohin55X7X2eUOMxrVnABPzVZXIyYgkvIxASR5mwd8L2ehKGusg
         TjFRW6t2V0v+NuHVBIhBhj5hfyd78/wHkLgVwfGU5gkIoCXetCURyMOR5wd0KZBXPozG
         9vqC1cd13yk7J7aMXOeUjf9WnLDvpJOOF/ncmoHWI5TcF37kfgxg6S5oQ5MwY0zwIVKh
         qZbM+anFEqSeVVNnzlb1fc5iFJpe9tjJmZyR8gQMGT6ik642O4yYZ85lwaJlG2943b7d
         XmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527824; x=1742132624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZmnphCh5t5ZmRNjQ/jjVilH899pEZQFMcfX0b+XOCk=;
        b=fKvlr9MhCi4fdlNtuzC+jM+gEdy9GJ1/Tl81ANIkcGCkpvzzF85rtPPFyAyR1spA0V
         SaOArhdVd7vHwAAFuTTmTav2gC1hXnvRCavcwvurusxri1XM/uF5usX06ZbbYw6h/4Ia
         sj7wJRFQrG5PwO/9UYeDNgskoNCElZZYIXHT8cUbtezN2+SbrxXFF0dn6bG0efKYL2u9
         W8NAc7BrPeKSSFaekUMSeLw9jqFGM8tbyTyBKawloCmcY2SsgfzrgYTtY5s8QWWiE91+
         fuuxFwbxH8bzspv0JpLuo5LwOJjKUiqwZstpr0935uXNPVYxbybVZHand9+e1en5Zc12
         1gBw==
X-Forwarded-Encrypted: i=1; AJvYcCV9yXb+cbuuvmqx6uK2THN0JW+bNP1giLUGagmdtvn7dGMeGIyRn7FyBIMOgurcveabnLL7Qj4G@vger.kernel.org, AJvYcCWRUWULjTmvNIV2/BE0SUxvlICk+wvNHRDfr9Q64Ql+DSqnhJj1FDo2FNTHYMn6c5s4Xknwr6DrJhbKeOhJ/L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8czWG4LZSNyb1qUWJ9c5TNyFOASprVvwDbXze7XHKwc/GiE/9
	l5iOVEcHM1lk7tomf9v7Rsc0xi9jQ9mEBOrPw2fIwcxjOoGI6QNr0bC/7Q==
X-Gm-Gg: ASbGncuwD4LVGgSxkPeA2aae0I+0CT8k31MMnb1IAAlTG6efhunidIsgBiweCyYRmLx
	yP+rsQVeR5V4F8JHCmjMj6OrX0Qi6fDTJ+HiGF/p3FFv0e8hWc4hF4sD4jxC2kV9yQaeXuM9fwt
	uiV8xHqTO1L2WSTx1U5W+VUrZuZDUwR7QWmfU7t5afIJfGNDK1mzIzpD2w6rCD7js9jMkKJqXKP
	mg/S+mvZ2uIxy1sjt1rcxenM2ebu2xn7D6s9yq8x5oaE4dCsfrx9pFm8/ETpM0FpnEX4/H6ckW9
	Ek9LWjvIC5V9BSUlpAFqXzwoWX13vqNEjA==
X-Google-Smtp-Source: AGHT+IHyM5RQmi/EN5Fxa1FlYPGzoqpy0+4i5nNLxytR2bQRBq5YHh5VtnGGzO5WGp8wpAY0nKlTsw==
X-Received: by 2002:a05:6a00:218f:b0:736:62a8:e52d with SMTP id d2e1a72fcca58-736aaa1b77bmr13841332b3a.12.1741527824566;
        Sun, 09 Mar 2025 06:43:44 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c41dda7csm2296841b3a.85.2025.03.09.06.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:43:43 -0700 (PDT)
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
Subject: [PATCH v3 net 5/8] eth: bnxt: fix kernel panic in the bnxt_get_queue_stats{rx | tx}
Date: Sun,  9 Mar 2025 13:42:16 +0000
Message-Id: <20250309134219.91670-6-ap420073@gmail.com>
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

When qstats-get operation is executed, callbacks of netdev_stats_ops
are called. The bnxt_get_queue_stats{rx | tx} collect per-queue stats
from sw_stats in the rings.
But {rx | tx | cp}_ring are allocated when the interface is up.
So, these rings are not allocated when the interface is down.

The qstats-get is allowed even if the interface is down. However,
the bnxt_get_queue_stats{rx | tx}() accesses cp_ring and tx_ring
without null check.
So, it needs to avoid accessing rings if the interface is down.

Reproducer:
 ip link set $interface down
 ./cli.py --spec netdev.yaml --dump qstats-get
OR
 ip link set $interface down
 python ./stats.py

Splat looks like:
 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 1680fa067 P4D 1680fa067 PUD 16be3b067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 0 UID: 0 PID: 1495 Comm: python3 Not tainted 6.14.0-rc4+ #32 5cd0f999d5a15c574ac72b3e4b907341
 Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
 RIP: 0010:bnxt_get_queue_stats_rx+0xf/0x70 [bnxt_en]
 Code: c6 87 b5 18 00 00 02 eb a2 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 01
 RSP: 0018:ffffabef43cdb7e0 EFLAGS: 00010282
 RAX: 0000000000000000 RBX: ffffffffc04c8710 RCX: 0000000000000000
 RDX: ffffabef43cdb858 RSI: 0000000000000000 RDI: ffff8d504e850000
 RBP: ffff8d506c9f9c00 R08: 0000000000000004 R09: ffff8d506bcd901c
 R10: 0000000000000015 R11: ffff8d506bcd9000 R12: 0000000000000000
 R13: ffffabef43cdb8c0 R14: ffff8d504e850000 R15: 0000000000000000
 FS:  00007f2c5462b080(0000) GS:ffff8d575f600000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000167fd0000 CR4: 00000000007506f0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __die+0x20/0x70
  ? page_fault_oops+0x15a/0x460
  ? sched_balance_find_src_group+0x58d/0xd10
  ? exc_page_fault+0x6e/0x180
  ? asm_exc_page_fault+0x22/0x30
  ? bnxt_get_queue_stats_rx+0xf/0x70 [bnxt_en cdd546fd48563c280cfd30e9647efa420db07bf1]
  netdev_nl_stats_by_netdev+0x2b1/0x4e0
  ? xas_load+0x9/0xb0
  ? xas_find+0x183/0x1d0
  ? xa_find+0x8b/0xe0
  netdev_nl_qstats_get_dumpit+0xbf/0x1e0
  genl_dumpit+0x31/0x90
  netlink_dump+0x1a8/0x360

Fixes: af7b3b4adda5 ("eth: bnxt: support per-queue statistics")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - Patch added.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9afb2c5072b1..bee12d9b57ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15384,6 +15384,9 @@ static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 	struct bnxt_cp_ring_info *cpr;
 	u64 *sw;
 
+	if (!bp->bnapi)
+		return;
+
 	cpr = &bp->bnapi[i]->cp_ring;
 	sw = cpr->stats.sw_stats;
 
@@ -15407,6 +15410,9 @@ static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
 	struct bnxt_napi *bnapi;
 	u64 *sw;
 
+	if (!bp->tx_ring)
+		return;
+
 	bnapi = bp->tx_ring[bp->tx_ring_map[i]].bnapi;
 	sw = bnapi->cp_ring.stats.sw_stats;
 
-- 
2.34.1


