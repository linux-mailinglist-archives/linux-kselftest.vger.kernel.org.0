Return-Path: <linux-kselftest+bounces-28560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E505A58498
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 14:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503687A2CE6
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 13:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B31DBB19;
	Sun,  9 Mar 2025 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSsNE4zL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B408BE7;
	Sun,  9 Mar 2025 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527820; cv=none; b=QBWS8+FiRBhBuinu7dk241CmScwhqrkFF1tMIjokhkxh/m0e2eUE/jKflNOhHopskLSFS00e4hbOLZMOSuWx9iP9Hx6z+SNA0FOobNro7Ijg92BK2p0gtjxgHUcdcQEgWm2Fxlno8HgL6LAvfOKP2zNbAyL++tkdTJySao/Lw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527820; c=relaxed/simple;
	bh=HHfGcuNfeh82DaSgGhwUkGB2Fa2krOjRb0WcWENzAws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gwcx2EXnmRPqEtVBu92MABVs3LEtilB1SRPERh6e+kiwEElWSxoNWr6AEBt5+7kQJKjMBmX8r8f9CcjgRW2nhKWPHAM9pkGMhFrEsZQRRPR3IrzNebn7QqzInyA4w7EvoWjQyJKPhOUsjwcxJYwlEl1G/DcAnjA+r8L3UCgCKtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSsNE4zL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22423adf751so45123405ad.2;
        Sun, 09 Mar 2025 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527818; x=1742132618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpGCFg056YTTUeBKmVNip9/4yVXTyllNRkgbKXRAVZU=;
        b=GSsNE4zLSbi8OloGzLaJxMOxiAziVQcT5yOVdqM01iY4ULLuGoq6GsekQTA8MPhrNf
         fyDxIB7u09Da0OHfHklKizrq5D187rWvaSNbvSp7OD7BbQ636w/jP5Qp3hioaxKJjH2M
         6/uHdoc1Lj9qDJvBlIrKSrMaI6pP0Nz2u7IC9k6o4yJ8WSllCfO0wcM/X5jJpkkPOLzE
         jtu+/q1sRb8k7QJUPjoRRk//UqhTbDj/1cTBL2lik6oeKxYkGfqIdTFPsA/PAkeNnQf2
         SaRUZY00TsQBxR4uAQPrzYzEa2vDq/DdYTAletqbVFw1P78jKvqh/m2a8q4yEpbJHcFD
         aMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527818; x=1742132618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpGCFg056YTTUeBKmVNip9/4yVXTyllNRkgbKXRAVZU=;
        b=F2uqLBRb1bWk4ODVGDie4Swi+yPBBiRMPeBspxls4jyOW6Hlo52DGe/HERj86rSyUX
         eK9y/Wzl7J63uMqi7E7q0Yj5TZyqjd539pOOzMnyb35Hh91XKEt4B6ACY2WGQOQ6al8b
         YLxd8FgFKtV0XwbXgfFDohWT8aNue+HoF8xnwxb2VzowSfJzbeyUgZ6oB1ek2jLqOS/l
         MUomR0S9biN+6z2bP1zshKq07hsGteINGfrMHdDZHArmkrL9L8haciJeRVPK4qsyyIoK
         CUfI5C6R9o1vSWH0X28cmTkbwtg1T2aye2EIm2XIvlqWcg1z+eEd5kN4QjSaLyAP4glG
         WA8A==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZzBeszW/+xJbvHWZIooG9XR7hNbH6rtGhQFGRL3Ie48aRX/nI8ESJYLoKyPqvoJYMZt8/VfL4FyGUsjZaAo=@vger.kernel.org, AJvYcCV/eW/7nigaK5avdDADfbCBj71EhO0BD3NE4aVYmJF7mJ7flwD8s0O+01MHTYhEzGB/zm4SXaxc@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqUIsKpzDP0OkUqzvPkJI0HWFRBt9eDbeyef7yq9cf+Nj4e84
	RLZQShv6zwtFoEmF4tdb6m69nE+aICgkDO4NlCWIAaOFyI58eC0U
X-Gm-Gg: ASbGncvc7YAIJ+5v+poNEhywcQ+4tIH5KVihk9MHta2lpBsFidLwUHtRRyQI4y4ZpO/
	cglDot9FU5EtQeXcCu2bXPmhKmt6fNhTqF5umE320wG83EVyHxIbzpJQyLTocGNBM1BM552Qkxl
	XUL5wtpR2GUOvpI+DJGywX2g5E5X4ZAfY+kWeRbyiRhYDr3eqmdU9v+VOpqx8Fi7V7Fve3bfAXW
	LA3EEVoueAdXYb481ISxzYzKJIRE2Zrxnsvpjjr5YJ+R1UZVZvZ+GMurW9LR3wSY+TJJHYTmyPS
	MKM21aqj9XHlnVCcJT4F80/Ze9YmahrkDQ==
X-Google-Smtp-Source: AGHT+IG3/NdAI5DYHYau8C9yaSQiH7uNB+fO6np3wZ1kmqgKQWDDK1Yi8/Ov4LIGaxROGSNb7hTgbg==
X-Received: by 2002:a05:6a00:2351:b0:736:65c9:9187 with SMTP id d2e1a72fcca58-736aa9db600mr13699394b3a.9.1741527818256;
        Sun, 09 Mar 2025 06:43:38 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c41dda7csm2296841b3a.85.2025.03.09.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:43:37 -0700 (PDT)
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
Subject: [PATCH v3 net 4/8] eth: bnxt: do not update checksum in bnxt_xdp_build_skb()
Date: Sun,  9 Mar 2025 13:42:15 +0000
Message-Id: <20250309134219.91670-5-ap420073@gmail.com>
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

v3:
 - No changes.

v2:
 - Patch added.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 11 ++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 +--
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 218109ee1c23..9afb2c5072b1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2218,7 +2218,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			if (!skb)
 				goto oom_next_rx;
 		} else {
-			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr->page_pool, &xdp, rxcmp1);
+			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
+						 rxr->page_pool, &xdp);
 			if (!skb) {
 				/* we should be able to free the old skb here */
 				bnxt_xdp_buff_frags_free(rxr, &xdp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index e9b49cb5b735..299822cacca4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -460,20 +460,13 @@ int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 
 struct sk_buff *
 bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
-		   struct page_pool *pool, struct xdp_buff *xdp,
-		   struct rx_cmp_ext *rxcmp1)
+		   struct page_pool *pool, struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 
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
 	xdp_update_skb_shared_info(skb, num_frags,
 				   sinfo->xdp_frags_size,
 				   BNXT_RX_PAGE_SIZE * num_frags,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 0122782400b8..220285e190fc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -33,6 +33,5 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 			      struct xdp_buff *xdp);
 struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
 				   u8 num_frags, struct page_pool *pool,
-				   struct xdp_buff *xdp,
-				   struct rx_cmp_ext *rxcmp1);
+				   struct xdp_buff *xdp);
 #endif
-- 
2.34.1


