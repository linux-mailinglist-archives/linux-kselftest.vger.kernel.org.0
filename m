Return-Path: <linux-kselftest+bounces-27359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9985FA42672
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 16:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAC61899D2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F852580E7;
	Mon, 24 Feb 2025 15:29:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF534252904;
	Mon, 24 Feb 2025 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410986; cv=none; b=bm9LAYTrCAUL4RWJQGKel0emEqFNbX7RWA5e0U33G4e6kyp2OuvNAjXc3LVbVBmeDwfM7wDFkQFtNhmNjaRTDY8Vmhfmgj5AIcSlMOIey6nZATAhqtkNwhzBS4uAGzkImHOZTusz/eQzj0wNU5eoTL2LWwqy8aNjPU5TObFgJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410986; c=relaxed/simple;
	bh=wA0QDO5QFIXhbuPjzvdXu3rzZQMwOqOZCdOKUbUiaTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbmieAczA+FCx4ZBJwcZz33bH4cnq7zw9Y9jW/XCJSjR3Fbmr1pvaoeFwst7zWuk0/zV5qrqu4kVCtEyjslTkhgNjRuNM8ReeR0e72RLRjBH3BRd9xqUipiSC5Y/tX3N9UK1ubATeYc93PL+/exb8loG9gB8hwVeb2eKD+EQsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tmaOQ-000A2B-OB; Mon, 24 Feb 2025 16:29:14 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tmaOQ-0005Hj-1e;
	Mon, 24 Feb 2025 16:29:14 +0100
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de
Subject: [PATCH bpf-next v3 2/6] net: tun: enable transfer of XDP metadata to skb
Date: Mon, 24 Feb 2025 15:29:05 +0000
Message-ID: <20250224152909.3911544-3-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27559/Mon Feb 24 10:44:14 2025)

When the XDP metadata area was used, it is expected that the same
metadata can also be accessed from TC, as can be read in the description
of the bpf_xdp_adjust_meta helper function. In the tun driver, this was
not yet implemented.

To make this work, the skb that is being built on XDP_PASS should know
of the current size of the metadata area. This is ensured by adding
calls to skb_metadata_set. For the tun_xdp_one code path, an additional
check is necessary to handle the case where the externally initialized
xdp_buff has no metadata support (xdp->data_meta == xdp->data + 1).

More information about this feature can be found in the commit message
of commit de8f3a83b0a0 ("bpf: add meta pointer for direct access").

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
---
 drivers/net/tun.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 4ec8fbd93c8d..70208b3a2e93 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1600,7 +1600,8 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 
 static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
 				       struct page_frag *alloc_frag, char *buf,
-				       int buflen, int len, int pad)
+				       int buflen, int len, int pad,
+				       int metasize)
 {
 	struct sk_buff *skb = build_skb(buf, buflen);
 
@@ -1609,6 +1610,8 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
 
 	skb_reserve(skb, pad);
 	skb_put(skb, len);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
 	skb_set_owner_w(skb, tfile->socket.sk);
 
 	get_page(alloc_frag->page);
@@ -1668,6 +1671,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	char *buf;
 	size_t copied;
 	int pad = TUN_RX_PAD;
+	int metasize = 0;
 	int err = 0;
 
 	rcu_read_lock();
@@ -1695,7 +1699,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
 		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
-				       pad);
+				       pad, metasize);
 	}
 
 	*skb_xdp = 0;
@@ -1730,12 +1734,18 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 		pad = xdp.data - xdp.data_hard_start;
 		len = xdp.data_end - xdp.data;
+
+		/* It is known that the xdp_buff was prepared with metadata
+		 * support, so the metasize will never be negative.
+		 */
+		metasize = xdp.data - xdp.data_meta;
 	}
 	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
 
-	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
+	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad,
+			       metasize);
 
 out:
 	bpf_net_ctx_clear(bpf_net_ctx);
@@ -2452,6 +2462,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	struct sk_buff_head *queue;
 	u32 rxhash = 0, act;
 	int buflen = hdr->buflen;
+	int metasize = 0;
 	int ret = 0;
 	bool skb_xdp = false;
 	struct page *page;
@@ -2506,6 +2517,14 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	skb_put(skb, xdp->data_end - xdp->data);
 
+	/* The externally provided xdp_buff may have no metadata support, which
+	 * is marked by xdp->data_meta being xdp->data + 1. This will lead to a
+	 * metasize of -1 and is the reason why the condition checks for > 0.
+	 */
+	metasize = xdp->data - xdp->data_meta;
+	if (metasize > 0)
+		skb_metadata_set(skb, metasize);
+
 	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
-- 
2.43.0


