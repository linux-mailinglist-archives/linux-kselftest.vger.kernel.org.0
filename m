Return-Path: <linux-kselftest+bounces-31111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD70A92E14
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BBD7AB775
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987522512F0;
	Thu, 17 Apr 2025 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPFOrQx3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260FB22CBED
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931759; cv=none; b=VEcyn8s9v7CdxmoYf1r3UGuljh+KLM3rUhdEjST99HcSaNDC6WU0VHTfswhhk2bwH0lxvGzkCR3E9j5R9As7gElTRc3m67rLwfQp4/9FA3ooCKkMlkUeC4MHWNCKIG6QKXyPCv6aylFSxwpDZsiNLkUDTn6KkGgT/6mfipN/7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931759; c=relaxed/simple;
	bh=7byv+zUvG9fGnf8k0FbZ1yDFOO2dvgSnWo6VU6i7tDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uKJvPr3cS5wAhM5gh8ClE3ddcozOiOGZ7WWSgfCFoF0PfM2p8ohASREJwANhRqJNvLJ7AABaSIMW/41ND2r6qL2GmTgSal7TLzifhCa41WbMbax32d0gSSSK3ZasbHOIMoJzH0oYVRYylCJcsSZHt+OOua5sIsQYs7R4THbBr38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPFOrQx3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af59547f55bso739591a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931756; x=1745536556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QwpjUEwFopJ2W78Zyje6DYSCKHgKSTGRi+BWAuCAZr0=;
        b=XPFOrQx3qNqaeTHpx3Zcz2+44f185AvmzH4uuYI6+tGiPZXo5xof5bCMZTUBssiPoO
         Ga8rdlkHcQuksXlajm4j09Vqn1eqsHgB92s+bFYNGaiJwvGhFl+ESTn7GMPWzVbj0ALD
         HcZUAmffn7TWfeRiLym7H5xCtFIcgPTWT0ytzanyeDoKeXqPOxQJpf3ZO1U2ZrcZKS2U
         GfmevWtfEwd+5FU/c1MVdPP3esCxMXbFkoDE1hs8/RzAA867Pwg+0/E+7VOyxN8BUPYt
         M/yydAsRGmGeX2ResIScE+zpdPr8kX+59sa/Cr3R4xN39VBYWZjrZ7eSpfzDOoFMirFI
         AjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931756; x=1745536556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwpjUEwFopJ2W78Zyje6DYSCKHgKSTGRi+BWAuCAZr0=;
        b=FXYO9l27vNoNTau/mL3R5AYtdA6dHCuAEV4GAPOUJgVCvM6x0klb4iVJAnx4SAyu5D
         yhlRYNnRQ0oiwXkbFndlqWFuTrSdDxrTwUhRsVt/Jg9JEEZExQQ4nK3wBOgN/Av6nVwg
         +xPaT7BtCxf7B4b3N4ktk6Azty2LMSFNu2XXkAlw/P53ZKvhs0rBvwhlLqmMfAogLmkY
         C2dLI/gJ2A+QqZE2emutFtOh6v1gR15Zo8nNd1V5xkcJz75v5/Svb+3TH+1zHl9vuhD2
         5S+lT5QQ7l/B+zIm4Oo27cPxxQ1llQNhCmm5Gm/uxST+PU7IoUIsK/il9k7Sjdddd/0S
         yAKg==
X-Forwarded-Encrypted: i=1; AJvYcCUmlxxtrQHtbyUBQX1j0ypnESMT1F5jxm3Lo1nfIntI/Y3JCvrmp26FU9hboy49bf+eXzXCadNjWgtEdwCCe0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAorE5Rt7e36miN80Qds0uQfACJNIIDgq7lrRgh7MAaE47hMaY
	f1rgX7fFWsJ6X3L/tCYmXbxt9RZK9vSWrSC9qyHuGsEGgG7GaJlWihARlmZ8Sr/WXh03CiFg38H
	SV2HLCOeIOyZJCICZOeeXkA==
X-Google-Smtp-Source: AGHT+IGbSpY41Gk0f2k8ImJTriyRDV0N0Eh39CVKrX5c+HnI/dX7PHa30LJHBo7qvoYPBvraFQs3AOfv4WzHMRa9Ag==
X-Received: from pfbgj7.prod.google.com ([2002:a05:6a00:8407:b0:739:56be:f58c])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9186:b0:1ee:e20f:f14e with SMTP id adf61e73a8af0-203cbd48a0cmr1121301637.38.1744931756428;
 Thu, 17 Apr 2025 16:15:56 -0700 (PDT)
Date: Thu, 17 Apr 2025 23:15:39 +0000
In-Reply-To: <20250417231540.2780723-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417231540.2780723-9-almasrymina@google.com>
Subject: [PATCH net-next v9 8/9] net: check for driver support in netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not enable netmem TX for drivers that don't declare support.

Check for driver netmem TX support during devmem TX binding and fail if
the driver does not have the functionality.

Check for driver support in validate_xmit_skb as well.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v8:
- Rebase on latest net-next and resolve conflict.
- Remove likely (Paolo)

v5: https://lore.kernel.org/netdev/20250227041209.2031104-8-almasrymina@google.com/
- Check that the dmabuf mappings belongs to the specific device the TX
  is being sent from (Jakub)

v4:
- New patch

---
 net/core/dev.c         | 34 ++++++++++++++++++++++++++++++++--
 net/core/devmem.h      |  6 ++++++
 net/core/netdev-genl.c |  7 +++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d1a8cad0c99c..66f0c122de80 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3896,12 +3896,42 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
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
+	if (!dev->netmem_tx)
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
 
-	if (!skb_frags_readable(skb))
-		goto out_kfree_skb;
+	skb = validate_xmit_unreadable_skb(skb, dev);
+	if (unlikely(!skb))
+		goto out_null;
 
 	features = netif_skb_features(skb);
 	skb = validate_xmit_vlan(skb, features);
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
index 5f44f7a3cbdb..b221fbbc5eca 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -974,6 +974,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_sock;
 	}
 
+	if (!netdev->netmem_tx) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Driver does not support netmem TX");
+		goto err_unlock_netdev;
+	}
+
 	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
 					 info->extack);
 	if (IS_ERR(binding)) {
-- 
2.49.0.805.g082f7c87e0-goog


