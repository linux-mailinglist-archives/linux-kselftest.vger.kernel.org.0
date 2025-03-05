Return-Path: <linux-kselftest+bounces-28339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40508A50D91
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C693AF0F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5A6200B9B;
	Wed,  5 Mar 2025 21:35:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9509D1FF1BC;
	Wed,  5 Mar 2025 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210515; cv=none; b=f2iUbED5IgzPaLYxCrZ3aBRF0DNrPD8GZuQI7rzeZBIolBodHnEkiBwQbNxT/IygtU5+XK5YDjY2zvcXZMuFTOhTVEu7u1jFvxyraBWAGei9HnntA9AxR1CjAKnQJO1BxwlrM6pNArSkW14tzqpi9s6Zdxj5726zDHv0yjV3hBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210515; c=relaxed/simple;
	bh=zlGgBAlWuOEjljzHx527vCLgLwRc8G7Otpo+WD97lwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggkKaR2FZo0sdGmVtkdOhSj1Q+AnwkPHKX/BC3zR+TmCZ9c9jXwDyhwKznhvxMxpXRODz068Me+Lxq7WTbsFqUm0UsrpCSO5HoZoN7pMKC96lPUrAjpTpt970478m2vlYsNz7emaXfc6VuYLeqS4Eymw4B9/Mfq4agUEnjADeXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO3-000K1F-0j; Wed, 05 Mar 2025 22:34:43 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO2-000MHO-0D;
	Wed, 05 Mar 2025 22:34:42 +0100
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
	marcus.wichelmann@hetzner-cloud.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf-next v5 2/6] net: tun: enable transfer of XDP metadata to skb
Date: Wed,  5 Mar 2025 21:34:34 +0000
Message-ID: <20250305213438.3863922-3-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27568/Wed Mar  5 10:48:48 2025)

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
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index cd463833a0ad..f75f912a0225 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1535,7 +1535,8 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 
 static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
 				       struct page_frag *alloc_frag, char *buf,
-				       int buflen, int len, int pad)
+				       int buflen, int len, int pad,
+				       int metasize)
 {
 	struct sk_buff *skb = build_skb(buf, buflen);
 
@@ -1544,6 +1545,8 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
 
 	skb_reserve(skb, pad);
 	skb_put(skb, len);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
 	skb_set_owner_w(skb, tfile->socket.sk);
 
 	get_page(alloc_frag->page);
@@ -1603,6 +1606,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	char *buf;
 	size_t copied;
 	int pad = TUN_RX_PAD;
+	int metasize = 0;
 	int err = 0;
 
 	rcu_read_lock();
@@ -1630,7 +1634,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
 		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
-				       pad);
+				       pad, metasize);
 	}
 
 	*skb_xdp = 0;
@@ -1665,12 +1669,18 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
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
@@ -2353,6 +2363,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	struct sk_buff_head *queue;
 	u32 rxhash = 0, act;
 	int buflen = hdr->buflen;
+	int metasize = 0;
 	int ret = 0;
 	bool skb_xdp = false;
 	struct page *page;
@@ -2407,6 +2418,14 @@ static int tun_xdp_one(struct tun_struct *tun,
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
 	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
-- 
2.43.0


