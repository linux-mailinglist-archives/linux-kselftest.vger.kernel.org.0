Return-Path: <linux-kselftest+bounces-28557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF9FA58492
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 14:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34D7188D55E
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB91D9A49;
	Sun,  9 Mar 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHEUaToV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD138BE7;
	Sun,  9 Mar 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527801; cv=none; b=YUgz5QxrYnHmm7b15rYHB4EPIEo/vq339i52Sep3uxl2n8ZymvOyyGEBYdTJBSU5V3SqjEsywOfcDVK6o6FxcMLOlYq6cCsDj8LLLph2+0J4GBNLyVYRq9fAeRUTzXYuS8p1+E1vhvZxJQ+SOkkfqlyHC4XSYU5OFewtnQcmm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527801; c=relaxed/simple;
	bh=dd9nUiJrwXMv99iv7txmQUTTNpeC1ohhXLb8ePqj/Jc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoJwn6YPIuzL3n4sB7ln4Zu8DVvYgDBL01CXc7Zk0qYZU2cSgnezFSAw6FE6VipatEWx3LJ3aZ4i8TEqDneAD2wRZpKH2rC6IBowPWBFBOVEucePzRMas7EBT35eENeH2UbOnt1qrg/Qr9eUfMvyv6WjOw+JKDugnH4D6N22tY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHEUaToV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22435603572so24714045ad.1;
        Sun, 09 Mar 2025 06:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527799; x=1742132599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/ein0vWHrPHczNXpwPQ4iwCKQ6o7ZMTYQitBGnwAaU=;
        b=fHEUaToVD7Fa4dr8cCQdMMAAjJ1b9yY8WBO8jTzd9pXaloqF2tghgorJdq+blnPKfg
         nH/7eMipeeEc8csYZR7LD6HZQZheCPYjwlfcRGfaN1hUVgvwN4ExWWZwj0Uaf66P8hpP
         FR5j7zA33fHdWhRO4EOZXYkv6gSMyKUJwAcYsHqVd9IA/2GNmoNjm1Md0ha5y/GWwstk
         6DFHktFUeCepaLMwykaR1IlifexOMPkMUUtoHsTgWB3BwAGMEQJX/V1AA4K01alF1C96
         tXo4AcghbrKeqG+jrA99fqLX1URRlAenViIMZoHfo2Xw0SrW4agrzEm4c13g5LL4rcjU
         iQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527799; x=1742132599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/ein0vWHrPHczNXpwPQ4iwCKQ6o7ZMTYQitBGnwAaU=;
        b=NL73XhlKKpK78pH8C+lhzeHMA50XxpfxqaxAkzx+3uAKRTlCSxmWjfivm/9xCWxO8P
         aOc5HSbmcVSZY5M35BWLTlJYaTrongVOLYtutyAiVNhC91e69+fTMsri6obh24zTG6rI
         j+69rvgh+7hIos/O4fIVPV9F8taRVB6BLHeGtAKDO6McMVR2KqYB2x63EVEj3CQbs2wH
         TqILYio1ORmXYDJWe6QR7mMdLYeCBdFJLNYptF5OmF2ZexXzXc8lfz82amOc0KL2APc9
         CFsA44uq8bi2an+H0Vgzoy/q7q+0YIjeBVMWxicPn/l9I7BxCkO3U5Tua6iSOkw5S5yP
         hd5w==
X-Forwarded-Encrypted: i=1; AJvYcCUmetGDWr1uQxBhLMMn3QOOMVuTJJ1tcjre4uoZAFLtgmrQkinc2B0pMbmkuPU/HLvi6r2wAc1BYbtmQ3fBVJ0=@vger.kernel.org, AJvYcCWqoqoGRDOkwrAVfnnUjY4a1JTezcDVIpvYrOcYhGnWL+F4V17JdRkqJsZ6h/yAldEBhO4lKS0u@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8LgBRx7MrUxbOdDj4/kPM7k6Gg57VYa9gH/cWL2JYcWjVuCtJ
	bEdLodgS9fjdwymIW2Uxr+OxSV7dAyq/N+JZHQXxDkwla/3ojJMQ
X-Gm-Gg: ASbGncugRTgVwsmJZ7/tGVGXYXcXpSldfgyhdhG0NSrkBC8nniGJn1w/3p8lidx5+qz
	V5krkuQTCb1WZR6U0oG/70IvcIqL/XJdCvfQEtJDPcDfBzjWE1pYmpDN2MjbqYtBZ7/itFAAfvw
	/4gM5scVzEmhi6Wguzba5omFfs5y0LRlaMIO5UxvXqagY6kpS7QIwOz4LGQRMEz/JleOkvgBosK
	f4IWBN057EX8mrEl1Xa9XMMmZrZwBDYbzO6B6ChScbzGo1kJoYO7Gr+o8gfQprseGThJXVyFHns
	K7MEO4IzZQ8gdIR6BDdbQ01aj5D4tqOhmCRXEGXUuRDx
X-Google-Smtp-Source: AGHT+IG7QqRURU9bDEzB+kPspIXQCilR/msM8OTfOJpOftnOhxGf0IF3faS9zYcBOYQ7GsgXfMtGOA==
X-Received: by 2002:a05:6a00:4b4a:b0:736:6ac4:d1ff with SMTP id d2e1a72fcca58-736aa9e7154mr17732210b3a.3.1741527798829;
        Sun, 09 Mar 2025 06:43:18 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c41dda7csm2296841b3a.85.2025.03.09.06.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:43:18 -0700 (PDT)
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
Subject: [PATCH v3 net 1/8] eth: bnxt: fix truesize for mb-xdp-pass case
Date: Sun,  9 Mar 2025 13:42:12 +0000
Message-Id: <20250309134219.91670-2-ap420073@gmail.com>
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

When mb-xdp is set and return is XDP_PASS, packet is converted from
xdp_buff to sk_buff with xdp_update_skb_shared_info() in
bnxt_xdp_build_skb().
bnxt_xdp_build_skb() passes incorrect truesize argument to
xdp_update_skb_shared_info().
The truesize is calculated as BNXT_RX_PAGE_SIZE * sinfo->nr_frags but
the skb_shared_info was wiped by napi_build_skb() before.
So it stores sinfo->nr_frags before bnxt_xdp_build_skb() and use it
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

v3:
 - Copy nr_frags instead of full copy.

v2:
 - Do not use num_frags in the bnxt_xdp_build_skb().

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 8 ++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b8b5b39c7bb..6b5fe4ee7a99 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2038,6 +2038,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	struct rx_cmp_ext *rxcmp1;
 	u32 tmp_raw_cons = *raw_cons;
 	u16 cons, prod, cp_cons = RING_CMP(tmp_raw_cons);
+	struct skb_shared_info *sinfo;
 	struct bnxt_sw_rx_bd *rx_buf;
 	unsigned int len;
 	u8 *data_ptr, agg_bufs, cmp_type;
@@ -2164,6 +2165,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 							     false);
 			if (!frag_len)
 				goto oom_next_rx;
+
 		}
 		xdp_active = true;
 	}
@@ -2173,6 +2175,12 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			rc = 1;
 			goto next_rx;
 		}
+		if (xdp_buff_has_frags(&xdp)) {
+			sinfo = xdp_get_shared_info_from_buff(&xdp);
+			agg_bufs = sinfo->nr_frags;
+		} else {
+			agg_bufs = 0;
+		}
 	}
 
 	if (len <= bp->rx_copybreak) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index e6c64e4bd66c..e9b49cb5b735 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -476,7 +476,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 	}
 	xdp_update_skb_shared_info(skb, num_frags,
 				   sinfo->xdp_frags_size,
-				   BNXT_RX_PAGE_SIZE * sinfo->nr_frags,
+				   BNXT_RX_PAGE_SIZE * num_frags,
 				   xdp_buff_is_frag_pfmemalloc(xdp));
 	return skb;
 }
-- 
2.34.1


