Return-Path: <linux-kselftest+bounces-28373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED2AA54395
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 08:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0794A3AFC63
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF81C6FEC;
	Thu,  6 Mar 2025 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti9ndI1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461681AAE13;
	Thu,  6 Mar 2025 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245882; cv=none; b=HRvJbV93Ju578eDBdnxPuddUpeYPJ/OUuSyXbyOfGv34d1MeNEr67K7y0ifS9N7pGJYgubQKmKOtWBibSCpquu/VgVK5s2nvMfJPuyEeTd93v+e/dOkM4HM6J+pTilQ8K1FTYJbukzmGuzO8XyH0yYQJQyo2zr7RL5dSgWSaIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245882; c=relaxed/simple;
	bh=+y2aXwV7UTJBcjzTbWApLJwHMo8fcKGd7y3+BzfQYuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBNvaJVectYybiKa+mwbXJtwqigWbImTVZQsBFk8+90EhaP5+9tyEiNRqi2UbBoFliBCQefoGNTbTaclzn2wi0zvVQ5SCp2FWDipSGBus6I8yWEvoqmQn3T/U2IYahIuJNSiMQwMghK/8aYFt8CvU3woBlJKd0pQSB2vhDX7S0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti9ndI1C; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224171d6826so1970095ad.3;
        Wed, 05 Mar 2025 23:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741245880; x=1741850680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83XMbtOL5LByRzjzK01BpeLwcGaWu+fCQ2zgxi8L7H4=;
        b=Ti9ndI1CUzXcAxlCmTEN4XWrdTq3nKh7++ZXKuHKGLKFWYEYScLtJgS8wJ0SJSQWjL
         3bHvKYpvBO9OdSuBXYZrdge5DeaEbEeZx0OTEzWyET1SpLc3x1IKMRFClogJ/dAdBRtA
         1YhmWF1usDtEJ4nKa2405MpcKHVST5WWN09qP5mMT/HW6BABW4HfafUrv4kLoX0Nxzme
         VvjRL3kesiWIz/Ltdm6ST1L+Xvf7oJZv2EznopuewN7KhqB7mYhWFqwwmqOvbPtR3DzP
         b5jE2PmXiCDvePMfvu1MYzltMFO916J/Y+mqpfiRKyfET0GZhYEaQXWWHOhAuG9xRnKj
         zgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741245880; x=1741850680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83XMbtOL5LByRzjzK01BpeLwcGaWu+fCQ2zgxi8L7H4=;
        b=DEUOTLdLIfKvxrJqKtujiyazrivQs4MPhBYZEAMBHb/KgkTlGgn/PHyF7SLi0uOrXi
         6/CxCO6sgQQo1tpgEDVNlGjBjrF8HyWwmxtxo33b5JFCp1HspqKTjMl2N1Wey3daqzRf
         154mkWHe6cyCqFvLf7ryhmctWmeSsvIWc47m68YmSO+uW6/GTYzgpWUHeqUndXIZWF4j
         5vV5pmQ8g8xUxgRbcuqOLgedPnYaFg+RDQUjZ5ToNb1y5ygm53ykKfjzSU1W+MncOUQC
         rhfQynTiozn8trE55HF+iPlOG7/thSR2VKqm+VrsSbE4M1Ki+Ttwd22bvTTzNFfC2dvA
         Cwiw==
X-Forwarded-Encrypted: i=1; AJvYcCVSikYac/fVvRDaEYXQhxqkZGyvNehelKjdGTvJS56yhKTRe4EWrwdrc+AvtggCndz0tdLsfZ/h@vger.kernel.org, AJvYcCX2rAUBih5QMpU4idUVgB0Yh9uxVTaSYvM9iCDLUqup2Q2S/3o6R4LfSZrefhSv2osuRY8Fq9TUwmLMqtLJ5os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs9UFe6MvoorwRj8nBJPPbfuClnS+78Y9GR9HfHN4CV4IuJVi8
	J8aIWeG/n0m600nmeu6epwgwrmc5JK8V3TnrmaakRS6U+heFWrx5
X-Gm-Gg: ASbGncu1myKWvP8ejLkedKO/M0ww9sk0JWLUd8XMn+oC/nvxz8tkUX6SXNdRXElFiUj
	cXraWSpAxlZuZhifVxDyj8JscFxDzOn1c8FyEhEGevobYkrC5cWKUf3c0Yrvo+t6HEPqA/uy0ZY
	aeJW0vSW/wzaSn2KiZ6QaCeFJY+J7dkSuUaR0YH71vpN615njb1MEXYvxROM7SgTdjDMXeJtcF6
	81UrHEAtd8IoDXaw1pCGL3O7IK3skB9m1NJPBbyjk4b+VY3Ks6l9oypWxKVGqpFJBllR3w3Vsik
	HkeSntLsAJ+60MxINpz9O9RxGJjGXIv6Dg==
X-Google-Smtp-Source: AGHT+IHcAFmtseJ/CR4dBSepFD7CYRdnRxAf3W5T5D6eVMux0uUQpSgt+8KiKqJj5iJbYZG+ea3wrg==
X-Received: by 2002:a17:902:ec82:b0:223:5c33:56a8 with SMTP id d9443c01a7336-223f1d26109mr106987765ad.35.1741245880494;
        Wed, 05 Mar 2025 23:24:40 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693534f8sm567196a91.17.2025.03.05.23.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:24:39 -0800 (PST)
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
Subject: [PATCH v2 net 1/6] eth: bnxt: fix truesize for mb-xdp-pass case
Date: Thu,  6 Mar 2025 07:24:17 +0000
Message-Id: <20250306072422.3303386-2-ap420073@gmail.com>
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

When mb-xdp is set and return is XDP_PASS, packet is converted from
xdp_buff to sk_buff with xdp_update_skb_shared_info() in
bnxt_xdp_build_skb().
bnxt_xdp_build_skb() passes incorrect truesize argument to
xdp_update_skb_shared_info().
The truesize is calculated as BNXT_RX_PAGE_SIZE * sinfo->nr_frags but
the skb_shared_info was wiped by napi_build_skb() before.
So it stores skb_shared_info before bnxt_xdp_build_skb() and use it
instead of getting skb_shared_info from xdp_get_shared_info_from_buff().

Splat looks like:
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 0 at net/core/skbuff.c:6072 skb_try_coalesce+0x504/0x590
 Modules linked in: xt_nat xt_tcpudp veth af_packet xt_conntrack nft_chain_nat xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_coms
 CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 6.14.0-rc2+ #3
 RIP: 0010:skb_try_coalesce+0x504/0x590
 Code: 4b fd ff ff 49 8b 34 24 40 80 e6 40 0f 84 3d fd ff ff 49 8b 74 24 48 40 f6 c6 01 0f 84 2e fd ff ff 48 8d 4e ff e9 25 fd ff ff <0f> 0b e99
 RSP: 0018:ffffb62c4120caa8 EFLAGS: 00010287
 RAX: 0000000000000003 RBX: ffffb62c4120cb14 RCX: 0000000000000ec0
 RDX: 0000000000001000 RSI: ffffa06e5d7dc000 RDI: 0000000000000003
 RBP: ffffa06e5d7ddec0 R08: ffffa06e6120a800 R09: ffffa06e7a119900
 R10: 0000000000002310 R11: ffffa06e5d7dcec0 R12: ffffe4360575f740
 R13: ffffe43600000000 R14: 0000000000000002 R15: 0000000000000002
 FS:  0000000000000000(0000) GS:ffffa0755f700000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f147b76b0f8 CR3: 00000001615d4000 CR4: 00000000007506f0
 PKRU: 55555554
 Call Trace:
  <IRQ>
  ? __warn+0x84/0x130
  ? skb_try_coalesce+0x504/0x590
  ? report_bug+0x18a/0x1a0
  ? handle_bug+0x53/0x90
  ? exc_invalid_op+0x14/0x70
  ? asm_exc_invalid_op+0x16/0x20
  ? skb_try_coalesce+0x504/0x590
  inet_frag_reasm_finish+0x11f/0x2e0
  ip_defrag+0x37a/0x900
  ip_local_deliver+0x51/0x120
  ip_sublist_rcv_finish+0x64/0x70
  ip_sublist_rcv+0x179/0x210
  ip_list_rcv+0xf9/0x130

How to reproduce:
<Node A>
ip link set $interface1 xdp obj xdp_pass.o
ip link set $interface1 mtu 9000 up
ip a a 10.0.0.1/24 dev $interface1
<Node B>
ip link set $interfac2 mtu 9000 up
ip a a 10.0.0.2/24 dev $interface2
ping 10.0.0.1 -s 65000

Following ping.py patch adds xdp-mb-pass case. so ping.py is going to be
able to reproduce this issue.

Fixes: 1dc4c557bfed ("bnxt: adding bnxt_xdp_build_skb to build skb from multibuffer xdp_buff")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Do not use num_frags in the bnxt_xdp_build_skb().

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 30 +++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  7 ++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  4 +--
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b8b5b39c7bb..13c9be49216a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2040,6 +2040,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	u16 cons, prod, cp_cons = RING_CMP(tmp_raw_cons);
 	struct bnxt_sw_rx_bd *rx_buf;
 	unsigned int len;
+	struct skb_shared_info sinfo = {0};
 	u8 *data_ptr, agg_bufs, cmp_type;
 	bool xdp_active = false;
 	dma_addr_t dma_addr;
@@ -2166,13 +2167,12 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 				goto oom_next_rx;
 		}
 		xdp_active = true;
-	}
-
-	if (xdp_active) {
 		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
 			rc = 1;
 			goto next_rx;
 		}
+		memcpy(&sinfo, xdp_get_shared_info_from_buff(&xdp),
+		       sizeof(struct skb_shared_info));
 	}
 
 	if (len <= bp->rx_copybreak) {
@@ -2204,18 +2204,18 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			goto oom_next_rx;
 	}
 
-	if (agg_bufs) {
-		if (!xdp_active) {
-			skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, cp_cons, agg_bufs, false);
-			if (!skb)
-				goto oom_next_rx;
-		} else {
-			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr->page_pool, &xdp, rxcmp1);
-			if (!skb) {
-				/* we should be able to free the old skb here */
-				bnxt_xdp_buff_frags_free(rxr, &xdp);
-				goto oom_next_rx;
-			}
+	if (!xdp_active && agg_bufs) {
+		skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, cp_cons, agg_bufs,
+					    false);
+		if (!skb)
+			goto oom_next_rx;
+	} else if (xdp_active && xdp_buff_has_frags(&xdp)) {
+		skb = bnxt_xdp_build_skb(bp, skb, &sinfo, rxr->page_pool, &xdp,
+					 rxcmp1);
+		if (!skb) {
+			/* we should be able to free the old skb here */
+			bnxt_xdp_buff_frags_free(rxr, &xdp);
+			goto oom_next_rx;
 		}
 	}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index e6c64e4bd66c..77860848e4f9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -459,12 +459,11 @@ int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 }
 
 struct sk_buff *
-bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
+bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
+		   struct skb_shared_info *sinfo,
 		   struct page_pool *pool, struct xdp_buff *xdp,
 		   struct rx_cmp_ext *rxcmp1)
 {
-	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
-
 	if (!skb)
 		return NULL;
 	skb_checksum_none_assert(skb);
@@ -474,7 +473,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 			skb->csum_level = RX_CMP_ENCAP(rxcmp1);
 		}
 	}
-	xdp_update_skb_shared_info(skb, num_frags,
+	xdp_update_skb_shared_info(skb, sinfo->nr_frags,
 				   sinfo->xdp_frags_size,
 				   BNXT_RX_PAGE_SIZE * sinfo->nr_frags,
 				   xdp_buff_is_frag_pfmemalloc(xdp));
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 0122782400b8..c1974bffafe5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -32,7 +32,7 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 			      struct xdp_buff *xdp);
 struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
-				   u8 num_frags, struct page_pool *pool,
-				   struct xdp_buff *xdp,
+				   struct skb_shared_info *sinfo,
+				   struct page_pool *pool, struct xdp_buff *xdp,
 				   struct rx_cmp_ext *rxcmp1);
 #endif
-- 
2.34.1


