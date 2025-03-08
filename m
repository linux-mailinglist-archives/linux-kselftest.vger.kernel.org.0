Return-Path: <linux-kselftest+bounces-28552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22828A57EE7
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 22:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799541892CB9
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 21:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4DC218E8C;
	Sat,  8 Mar 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s4BBJbtT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9082165FD
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Mar 2025 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741470064; cv=none; b=dzY3LsnAE1/L/myzsBq9qp4x7YuXbkqI4Pf/dsB6Yb5cu/+101k/xpI9rK3njfj5L6Nyh27i6F5KzC9fvwSqinbl8SMRyoAE/wST9ewADH5hBrYg/yzA2XN7tSP3tQTzgiWbODj8Vv1eKc4RAQCaV9u604/rBiA2kZJcKsslj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741470064; c=relaxed/simple;
	bh=5hyZYxezWmmiBT1IswLrJGF/zzJLGbfExZqICWkHdIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xpcs7tyYINj7uc8SFFZNmqOagIgihaIDtrIUKnru9ZtQJh01MA8hCzD5bOphhBtEdTl6/GZ47b2PF4tMfVQaq4zb9vaweFeCeS5SsSazPok96XKQfGFv5O2pIn1ULjC6FzzpciRR/yIxoRWtZo71uWwQOGqxrbzCSgneOAR/bjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s4BBJbtT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso8524889a91.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Mar 2025 13:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741470060; x=1742074860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Wr/uTxLJd/vHEpArrWTAzyhW/+/hW24sD4ijoGNq1A=;
        b=s4BBJbtTwm6eQD36oIq9HpUkBHPKqYzkliXmWzfP98NKO6GQvFE89kNF3AudqWFO6S
         atYh4Spxz5F2R3ZuxVXOzokIF+yfytye6L8usPzMB1JlDU8GJMAhAgr5YFBNgz25KVFD
         FuEDt7UOKyE5301Dw0McpWPGmf7nudkViITkm3PlDMVRwzJS4MsMtmfCGaROAeZ+8fDK
         moy/v9x61N3pjwcnM0kXWO7s9ahIX8WExidY0+VWdBMxMxceYieBbeLzwpodxiWZXo1M
         PtTMvvJIUTyE3rF7okF8Pn3ymL2VYzkqdl+puP3XHNAcMmqCzHTFEcuzJiq01vSY2Gya
         i62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741470060; x=1742074860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Wr/uTxLJd/vHEpArrWTAzyhW/+/hW24sD4ijoGNq1A=;
        b=w8aFiolXpryPh0z+0g7c0trTohGijKj6c5ZMqUS3rJPUzkWzMA51p9go+w7foejCKV
         6ZmrER+UUvQwyHeBrNUNoZKlWydni3sBRR9ym2RuZSNl7ZobDraGdz2tmeVf2EaOicrF
         XoOzSCXodH0po6Tl+n4ObNHeyNLoM5pbPup9qkHxeFApifA/pTJBr/h2KisLziQMFjUt
         ASfYWr+FkecFh17GSuCDFCI7FZa3/Ye0gxkZ4sw7x2I6e0L45fJCzfJ1TANW811V/vMd
         zwavWV6ceceYlvxutobhjk8Fytl4kYGKCVKXdQ/YKrh4qFIy9PCc+CeGo6GpM0n0Ewl7
         gKGA==
X-Forwarded-Encrypted: i=1; AJvYcCWeWi/KaBOOuwJF/Rd4/sUolFLhFFddlYxrEqtC+7UbqvZcAeeaInZ/AM954LpbgysQCw2U+EkZaeQ0kc8u584=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRxoWg23NYTCRjD7p+Zq32Tkl0P/1wxCk74zmqbqEM1Jw40iL
	nl9IsQtnDAT2a7O5ZfG81Y2Nl1o0c++h92gEq1fjj4Mp3lxBaDOwhWCu769bknjckVenRJnGxvL
	bisDWhj5DdzIAZDtVmQjTww==
X-Google-Smtp-Source: AGHT+IGyjeNA1taw2RdrwgYQli42mPxkFOYVzCwbtW6YJ7SSHLfeooUxpgj7xkNuM+/XP23C+mt2BUcMUhn7WAB/+A==
X-Received: from pjbqn14.prod.google.com ([2002:a17:90b:3d4e:b0:2ea:9d23:79a0])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2ff7cef76acmr12864048a91.28.1741470060429;
 Sat, 08 Mar 2025 13:41:00 -0800 (PST)
Date: Sat,  8 Mar 2025 21:40:44 +0000
In-Reply-To: <20250308214045.1160445-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308214045.1160445-9-almasrymina@google.com>
Subject: [PATCH net-next v7 8/9] net: check for driver support in netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not enable netmem TX for drivers that don't declare support.

Check for driver netmem TX support during devmem TX binding and fail if
the driver does not have the functionality.

Check for driver support in validate_xmit_skb as well.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v5: https://lore.kernel.org/netdev/20250227041209.2031104-8-almasrymina@google.com/
- Check that the dmabuf mappings belongs to the specific device the TX
  is being sent from (Jakub)

v4:
- New patch

---
 net/core/dev.c         | 33 +++++++++++++++++++++++++++++++++
 net/core/devmem.h      |  6 ++++++
 net/core/netdev-genl.c |  7 +++++++
 3 files changed, 46 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1cb134ff7327..5553947123a0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3868,10 +3868,43 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);
 
+static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
+						    struct net_device *dev)
+{
+	struct skb_shared_info *shinfo;
+	struct net_iov *niov;
+
+	if (likely(skb_frags_readable(skb)))
+		goto out;
+
+	if (likely(!dev->netmem_tx))
+		goto out_free;
+
+	shinfo = skb_shinfo(skb);
+
+	if (shinfo->nr_frags > 0) {
+		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
+		if (net_is_devmem_iov(niov) &&
+		    net_devmem_iov_binding(niov)->dev != dev)
+			goto out_free;
+	}
+
+out:
+	return skb;
+
+out_free:
+	kfree_skb(skb);
+	return NULL;
+}
+
 static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device *dev, bool *again)
 {
 	netdev_features_t features;
 
+	skb = validate_xmit_unreadable_skb(skb, dev);
+	if (unlikely(!skb))
+		goto out_null;
+
 	features = netif_skb_features(skb);
 	skb = validate_xmit_vlan(skb, features);
 	if (unlikely(!skb))
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 67168aae5e5b..919e6ed28fdc 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -229,6 +229,12 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding, size_t addr,
 {
 	return NULL;
 }
+
+static inline struct net_devmem_dmabuf_binding *
+net_devmem_iov_binding(const struct net_iov *niov)
+{
+	return NULL;
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 6e7cd6a5c177..6c5d62df0d65 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -972,6 +972,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
+	if (!netdev->netmem_tx) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Driver does not support netmem TX");
+		goto err_unlock;
+	}
+
 	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
 					 info->extack);
 	if (IS_ERR(binding)) {
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


