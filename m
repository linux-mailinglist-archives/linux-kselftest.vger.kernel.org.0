Return-Path: <linux-kselftest+bounces-28376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D5DA5439C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 08:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E2D3AFD90
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 07:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9831C861B;
	Thu,  6 Mar 2025 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ccofh3DT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5217C98;
	Thu,  6 Mar 2025 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245899; cv=none; b=qOD3WbO4PH46ZraFTwzX4bDthoHQZQQcQcBckEUwoZaYC/ny0A+lDXyBMVbqfChxtsCXkq915JpctcBpsLRxMGEf9XhL87o2+fiHnaPipTXhH0GCf2d4Y1Iw8TP+I1gljCQ8e6Rv2sAe1SNwKd8v1HTfdABqZxsgvmX32NIC0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245899; c=relaxed/simple;
	bh=vMrqLh+jKFHMAoIRCmhp69QOAPjybGa9MGF5KnhOajs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NS2GN++O2oH7skkuNHfCzU1iFth5BbQU+zgbNAZH1rJCyUkNQrUIB6ivft4pMdlffSayanDkBFa79FT14nUKlZSihXlfMNYktgRgxdmgI3KLQAU+b8P7/sU7spgRxiGSfCRxWZ4ljD2n80Mpy3LH3L3/A/d5IhXtT05Q9W8qRn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ccofh3DT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2feb9078888so772746a91.3;
        Wed, 05 Mar 2025 23:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741245897; x=1741850697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZM0yYMpenaP6tGtTGt3yQo0mTDU64awuLWDXCIaVKQ=;
        b=Ccofh3DT9gSj/vq3RgJ/N7aOYOK3pwPM6pjvD9dDcgFCo73vk+eBSC0zLrs4Y0CFzw
         Aw2gR8FwuYqmFAF8tO+H/sibip460vB/ddqxAIgZiy07QqUabIlF21+3DIOeSnRtAbg4
         UJdG5vCjSUJZdfEKENUsBlMMKvwJBwJyGjAXy9tLoRKoNTqBh/c9DofZFh+pBnxlsCYW
         /uOAiLmFvt4JZvF5HpLhoIfDulfB5FBU6vSPaLQ8xM8a9YMhBaERoMu9Jf8F0Lnx0L2K
         Q32AUsuiQiYt5zq9JM8CcWMbl3nYxrIWFKtbOe8VkJFt3E/I8pbvG0ZF5Bd4TzijNR7M
         AnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741245897; x=1741850697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZM0yYMpenaP6tGtTGt3yQo0mTDU64awuLWDXCIaVKQ=;
        b=K9OooTj0QgsgmHAw59VofzQmZTACs7MMuHoNwfrF3tS9mpAcuYMIPUq1TrvE1JTBO8
         wA50p+WGOCQlJPPp7vuv5mXojJlMaH5aZaHI82JPQ7bgtDj2Zp/E7A95V9hMCva+vmnt
         v1AyvQdATR8q01XTfo0woikihfJQGNdQbI/lmsCqs92RZ//xEw5s9UQMVy+Z8tgH8f+z
         clXTFN6L156El+ifpMa+0qn2VGJ1hS3wTbtl7CrI1iutfFsQwPcVreZAZ319WY2APElk
         2A9Kur6CGsPfqAINAkoHmB9YcHOGnvvUR0VJIlCDoHXA3wLRh3gKYwGalTD92xoMO9C5
         G+oA==
X-Forwarded-Encrypted: i=1; AJvYcCUc5Lys5RaR2AD9mjL9Auc30xoG9D+yMZjEwIP3Zw8t3d1kVlsiIqzit986ZpKmiR9oSWJIQdRrtHrL1+1csh8=@vger.kernel.org, AJvYcCUcMc9+NmZulurfsK5cWFQSaiF6h3m50sNVxSV/Dhi8NNDiKhRxKSCd4DAhdn/hsyF6xn4J1V5N@vger.kernel.org
X-Gm-Message-State: AOJu0YzOhPtVu9EUOogKxxjIcK2MRV7M2oT1Di+XWc17jtnvsBBzxSp9
	3GwvDXP0iWN3QwFO+pTAdPUdzB3X7x9sMSYQCh79YwXmbaVg1dzuLrpeFg==
X-Gm-Gg: ASbGncuGFyyxPIfwQpHMwKOyz7lnqGspgjEa4L/ubNkIOIaQ8RQzKtWeFFigm2qgGsZ
	NwLs5WniMRahABC7L2nuImDPQwDbdR/MSlHxcP0XwNygpuyNaiCBI58ABvL605DVNHrPSHlYyrM
	24rl+svYHP4bTyyXg49OKUUUGf4Qb6wz4/rusWAYbRJ7ZsP4FrSdapQQaidn7lYi75Yhh5FYcBc
	ES2YoAY4v0XnbjNilKUYOth+iXfc2CIxPNgafoAnRojNSly+ugj/c+EnGsBg5r1wa9RdETrI7H+
	ZvUt+NVZeAoCEzAhDDBQS+r3HEX5V8LIWA==
X-Google-Smtp-Source: AGHT+IGs3M/KsV5JlK2oBIFWJdTQjWH43nCdqrszgdHxElOa4qC2F+LKM0+bywK7g3PUvjaKJ6lpfQ==
X-Received: by 2002:a17:90b:248a:b0:2ff:4f04:4261 with SMTP id 98e67ed59e1d1-2ff4f044962mr6559146a91.34.1741245896783;
        Wed, 05 Mar 2025 23:24:56 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693534f8sm567196a91.17.2025.03.05.23.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:24:56 -0800 (PST)
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
Subject: [PATCH v2 net 4/6] eth: bnxt: do not update checksum in bnxt_xdp_build_skb()
Date: Thu,  6 Mar 2025 07:24:20 +0000
Message-Id: <20250306072422.3303386-5-ap420073@gmail.com>
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

The bnxt_rx_pkt() updates ip_summed value at the end if checksum offload
is enabled.
When the XDP-MB program is attached and it returns XDP_PASS, the
bnxt_xdp_build_skb() is called to update skb_shared_info.
The main purpose of bnxt_xdp_build_skb() is to update skb_shared_info,
but it updates ip_summed value too if checksum offload is enabled.
This is actually duplicate work.

When the bnxt_rx_pkt() updates ip_summed value, it checks if ip_summed
is CHECKSUM_NONE or not.
It means that ip_summed should be CHECKSUM_NONE at this moment.
But ip_summed may already be updated to CHECKSUM_UNNECESSARY in the
XDP-MB-PASS path.
So the by skb_checksum_none_assert() WARNS about it.

This is duplicate work and updating ip_summed in the
bnxt_xdp_build_skb() is not needed.

Splat looks like:
WARNING: CPU: 3 PID: 5782 at ./include/linux/skbuff.h:5155 bnxt_rx_pkt+0x479b/0x7610 [bnxt_en]
Modules linked in: bnxt_re bnxt_en rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs veth xt_nat xt_tcpudp xt_conntrack nft_chain_nat xt_MASQUERADE nf_]
CPU: 3 UID: 0 PID: 5782 Comm: socat Tainted: G        W          6.14.0-rc4+ #27
Tainted: [W]=WARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
RIP: 0010:bnxt_rx_pkt+0x479b/0x7610 [bnxt_en]
Code: 54 24 0c 4c 89 f1 4c 89 ff c1 ea 1f ff d3 0f 1f 00 49 89 c6 48 85 c0 0f 84 4c e5 ff ff 48 89 c7 e8 ca 3d a0 c8 e9 8f f4 ff ff <0f> 0b f
RSP: 0018:ffff88881ba09928 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 00000000c7590303 RCX: 0000000000000000
RDX: 1ffff1104e7d1610 RSI: 0000000000000001 RDI: ffff8881c91300b8
RBP: ffff88881ba09b28 R08: ffff888273e8b0d0 R09: ffff888273e8b070
R10: ffff888273e8b010 R11: ffff888278b0f000 R12: ffff888273e8b080
R13: ffff8881c9130e00 R14: ffff8881505d3800 R15: ffff888273e8b000
FS:  00007f5a2e7be080(0000) GS:ffff88881ba00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff2e708ff8 CR3: 000000013e3b0000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
 <IRQ>
 ? __warn+0xcd/0x2f0
 ? bnxt_rx_pkt+0x479b/0x7610
 ? report_bug+0x326/0x3c0
 ? handle_bug+0x53/0xa0
 ? exc_invalid_op+0x14/0x50
 ? asm_exc_invalid_op+0x16/0x20
 ? bnxt_rx_pkt+0x479b/0x7610
 ? bnxt_rx_pkt+0x3e41/0x7610
 ? __pfx_bnxt_rx_pkt+0x10/0x10
 ? napi_complete_done+0x2cf/0x7d0
 __bnxt_poll_work+0x4e8/0x1220
 ? __pfx___bnxt_poll_work+0x10/0x10
 ? __pfx_mark_lock.part.0+0x10/0x10
 bnxt_poll_p5+0x36a/0xfa0
 ? __pfx_bnxt_poll_p5+0x10/0x10
 __napi_poll.constprop.0+0xa0/0x440
 net_rx_action+0x899/0xd00
...

Following ping.py patch adds xdp-mb-pass case. so ping.py is going
to be able to reproduce this issue.

Fixes: 1dc4c557bfed ("bnxt: adding bnxt_xdp_build_skb to build skb from multibuffer xdp_buff")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Patch added.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  3 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 11 ++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  4 ++--
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c9d37fea5d32..f8bea233ef63 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2210,8 +2210,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		if (!skb)
 			goto oom_next_rx;
 	} else if (xdp_active && xdp_buff_has_frags(&xdp)) {
-		skb = bnxt_xdp_build_skb(bp, skb, &sinfo, rxr->page_pool, &xdp,
-					 rxcmp1);
+		skb = bnxt_xdp_build_skb(bp, skb, &sinfo, rxr->page_pool, &xdp);
 		if (!skb) {
 			/* we should be able to free the old skb here */
 			bnxt_xdp_buff_frags_free(rxr, &xdp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 77860848e4f9..e88c6f77522c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -461,18 +461,11 @@ int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 struct sk_buff *
 bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
 		   struct skb_shared_info *sinfo,
-		   struct page_pool *pool, struct xdp_buff *xdp,
-		   struct rx_cmp_ext *rxcmp1)
+		   struct page_pool *pool, struct xdp_buff *xdp)
 {
 	if (!skb)
 		return NULL;
-	skb_checksum_none_assert(skb);
-	if (RX_CMP_L4_CS_OK(rxcmp1)) {
-		if (bp->dev->features & NETIF_F_RXCSUM) {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb->csum_level = RX_CMP_ENCAP(rxcmp1);
-		}
-	}
+
 	xdp_update_skb_shared_info(skb, sinfo->nr_frags,
 				   sinfo->xdp_frags_size,
 				   BNXT_RX_PAGE_SIZE * sinfo->nr_frags,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index c1974bffafe5..51c4255dffef 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -33,6 +33,6 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 			      struct xdp_buff *xdp);
 struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
 				   struct skb_shared_info *sinfo,
-				   struct page_pool *pool, struct xdp_buff *xdp,
-				   struct rx_cmp_ext *rxcmp1);
+				   struct page_pool *pool,
+				   struct xdp_buff *xdp);
 #endif
-- 
2.34.1


