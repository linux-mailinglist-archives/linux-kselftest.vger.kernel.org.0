Return-Path: <linux-kselftest+bounces-27766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E8A48190
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645A9189E222
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC56723645F;
	Thu, 27 Feb 2025 14:23:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C07234963;
	Thu, 27 Feb 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666232; cv=none; b=gAJDtSAhZi1u0nOuuPQbv5y5prO9Jqc+1VE/fuZSfIuSDmrpNYJFUdoZjD95DuFGj9Zm3ZFRa8Pnu3ROKBLDLNSemikZNXPXk2hTj5HtlTkardlpTl7jqlmgayehxLLyVAyhoVdKLzzXzuT6kjEwAMr9gxHPdUUq1iUw3729DKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666232; c=relaxed/simple;
	bh=/PkCCY2n6jbevMLpPVHjAtStFnJ9orAEV5+1QC6kVFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foFcSBo5p9RY7N9tBE9dS4xehsEeCG3FOKvl9XqGpkz2HXSPJlAjhW7M2JYPRXnR4vg5LiTMc0R+bjZ/Vkl8HE6pGfGorxZ1s+XW3CoPxHIFYC/kIPzPeOVAwp1ACTLD4NzAp+PG3csaB/zuCd/N2aOcMH/Z37e9O/RmO5ePnt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tnenV-0005ET-Qz; Thu, 27 Feb 2025 15:23:33 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tnenV-000B1d-39;
	Thu, 27 Feb 2025 15:23:33 +0100
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
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf-next v4 2/6] net: tun: enable transfer of XDP metadata to skb
Date: Thu, 27 Feb 2025 14:23:26 +0000
Message-ID: <20250227142330.1605996-3-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27562/Thu Feb 27 10:48:50 2025)

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


