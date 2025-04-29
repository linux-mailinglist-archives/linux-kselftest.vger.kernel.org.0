Return-Path: <linux-kselftest+bounces-31852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565BAA0084
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 05:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277EA9233B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 03:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4B9279321;
	Tue, 29 Apr 2025 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3os2TqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D892750F6
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897226; cv=none; b=UkwEgz/UejqTNUmfJVsC6FwGOeHQoJ8i7XWzjmP2m/1xu7jzJgqs4/A7EM59jAjE8pGxnS2cP0LSCRnFqmwGkaes9Fe1rw7fGgVa0J7qbTBZv/otDwoMN+h0QdR0snEolD2Uhbue0UKQJ0LaKNTikjq/opFPZulRpUVTBlY3j1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897226; c=relaxed/simple;
	bh=A7Gqoe2REliQn3D8I8ViowlNgFS3gK0zrYxlmzIFsP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WZJuZIMacH3b7Vc22LZfToXZ+tykOsAxnbVSU8TiShBHK/ORadaoN2/aCPsF/1nYA4PZRf66ugx7fBoQKhJC2NTjmVzPXtJdZgsKCTWnsk5mH8YA7Y44RMmk2groc/UL05mC/coZZkSFbVjS5agtEjNfB67go+F+Q07/GxdGplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3os2TqV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73e0094706bso6937237b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745897222; x=1746502022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1032nSfcUejN3wnyduYVEgTSlMhJTQ/ggAvfPEjRBQ=;
        b=Q3os2TqVlL+qYULQ4sS+ZyR0q7ABt95gyDwsqItLaFSVM9u3woxI57CpI5+36agj+w
         Mp1sNhZvkiQ2Sa915ciHGtwVfNGcktOPb1ZwuqiE0Ta0N2fBF1XbpVOnAdTsloI6TkYv
         c53730JQCTlwUzM5HY8i3LQP/Y/gFZNhnqJL47g6NTRsZ29NfqMYEocnq9b/2ceCY+rg
         pobsDG4UngnRNOMcggS0ddZE5B5SgRwtptaBtu9REYO25dQxTLQemCNKSlYFVYcIKDhx
         TOH9VHuff5e/n5yA1bFNIw2IvGr5dLgWBXELg9IhPHiWPFXiFD+om1MJOnU7oNWU3r6y
         KgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745897222; x=1746502022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1032nSfcUejN3wnyduYVEgTSlMhJTQ/ggAvfPEjRBQ=;
        b=fW/oF3QNzMLk+Std5Fiw4WHef4wLaVodYyip3R22Lmtt51wnYEx5W16ugFdyG4taYu
         bClohZUtRD8k/mvVksQPSiUiEN+oR5YhKbldIK6FsGklEkTPnVu4QH5CAjc4fgj3i47+
         pJwBXhnIKXPTRI1tGYlVQhv+uztMgE/DPXhNx7cu7U/inRysCeVNTr3f6PKhsVetpo6Z
         dFaC52d6me+m5SGvVhvkrYPV0ZEKzrUXc02W18M9wB8KBOR+kzor4HT62N3bjtnPt97w
         a+imDTxNZPFThQV5rCCfoFwt4H91ocyp5B617WKiM/GyA613XjDI6JhdO1V2d7PKqVNb
         2gZg==
X-Forwarded-Encrypted: i=1; AJvYcCWjfFU619KyOLxjcuSeHpngq6qJhlMo3gjA764pqwy368bw/lu/+q+OiDwPj1kXMDoaf2466khwTk+ab8OpZo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydV4A8XmMuJc62/5m1HUXLRqvUk4rSIa3CSpTcTInrcDH4bjvB
	3vIchIJVwynYz8IBmwICn/gGqr+1LuZ/mbarCMyi1FjMmi7Vcbo5wJQNrglQgsDoSLm73lb9sPO
	M0yCLJapQurnzfK/IxFpKaQ==
X-Google-Smtp-Source: AGHT+IFmVM3YrkOhLWbCT7+b8wtIRcYElhCtGh67rI6iSh5PAx3yi8oyEgSS83P+VHq5mzTmEXYtXAkmX8xqOcB1vg==
X-Received: from pgbdo9.prod.google.com ([2002:a05:6a02:e89:b0:b0d:967f:2404])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:cfa4:b0:1f5:58b9:6d97 with SMTP id adf61e73a8af0-2093e52803amr2977856637.35.1745897221928;
 Mon, 28 Apr 2025 20:27:01 -0700 (PDT)
Date: Tue, 29 Apr 2025 03:26:44 +0000
In-Reply-To: <20250429032645.363766-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250429032645.363766-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429032645.363766-9-almasrymina@google.com>
Subject: [PATCH net-next v13 8/9] net: check for driver support in netmem TX
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
index d1a8cad0c99c4..66f0c122de80e 100644
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
index 67168aae5e5b3..919e6ed28fdcd 100644
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
index db0e9a6a4badc..119f4fbc0c944 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -982,6 +982,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
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
2.49.0.901.g37484f566f-goog


