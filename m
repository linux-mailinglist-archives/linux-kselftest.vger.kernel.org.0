Return-Path: <linux-kselftest+bounces-23707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3579F9D84
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 01:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0AF16D4C1
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA9513C9D4;
	Sat, 21 Dec 2024 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3SwcKP+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776807FBA2
	for <linux-kselftest@vger.kernel.org>; Sat, 21 Dec 2024 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734742301; cv=none; b=oAj2DUSMmSiKpKOZmWDgnMGc6RBmhkM1nTYX96koKuEK/l/EUAEAMt9MkaQFHMym/J8mMYAS3rcmqZjhxSLtY78ofRA/d51namsjHQItgfvgsM+WJI6SP5WxRJwPQ/hkRs6gHd5l124t6G6Ap7UTfZyZX2kiUWlba6fb/oPp79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734742301; c=relaxed/simple;
	bh=NJYVQtSnFpPYRXXneblkJlgbJV6+0PWgWGqywbwgTRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+VrFFkm0QIlJ7CU3UxlzXlRHqi4ERDBjFl7e3SSwHcR4ZfadZnVnYeZBrX/kJ1MFfigoT+PskqeE+NHhrZCFIaLE3XYnkcpAZv5TLmEgaHXRK89P3gts/wGrcZlUHpKhzF9V7ZyGyqTVa8vnr83DscTzVEAxUP3Or0W1pm4wZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3SwcKP+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725e4bee2b0so3507016b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 16:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734742299; x=1735347099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mBSL9yXhBVvFNjspCgCNSWimNpbAGgVhzwIwXbDDa0=;
        b=l3SwcKP+hraqfWZEcrHjlI/MPxgrJEnxc1+lWJe6hNX2LdyXvAWTM5F6+NYnN4A2kq
         /xWDD1SZtsV1dAWH0NZR6jqtDHpRSnNVM605p8gtNErcjZvJPb4HtgtsjSSIIPN3vw2b
         szeQ/rLxwSSBAGKI3ISa1o67ec+C1EEEw9mjSRmeZ6M24auv1c0wKgIApyMGr0OpfPAE
         RIHNdqbIjHBRuu6rSbcY6n6OAKAu97acn7u89Qs9jNJy4AuazD0NRZpNHlNmfC3PqJcc
         HMF5ARVWE+rWk5+OQCCgSyg8o+H+sXA+VFTpXy6DlDRT1/IzrytpfJgQwGeqoLNJ8hOW
         kPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734742299; x=1735347099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mBSL9yXhBVvFNjspCgCNSWimNpbAGgVhzwIwXbDDa0=;
        b=SFkMLtdDxALpRvooMaqc72N6NLm4DeICleVS8HxyLSmQuEojDWtC6DziRqfuTKTY4e
         p8C+4j4C0ZPqbcPOSNBF6lubTrntyjsE8+kO8CYwMEcyJgonrsr2dplTbula+OoBbLp3
         W7cQd9HVmiPNVyojlurlWvAno80dnf7c5DQYmVfIjpTUHn5iJpFHILcyVpn6sw3akweY
         2fDsoshEGJSH2rs5clDBJUNLeuIB88VkomqC3gb4/PVAMTDSZIqISQNE7z2H0yVFo0uL
         Q4KezGYtZGx+LTp6ZUK3mc/HJpURnSQGo4zc3kaDfbGaebl7Ohvgxxc4aCmj4/gxI9uX
         w6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGDiM+qU7r+OQEjdMFN++De7ubzPShCd0QcIq4oiiyjq7kPeh7rgZ8G77l6XKUc/8+gI9BuXOtx26uB0P4Hrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygwLchWl/sCDW8FIlr7vKbhMm4sXcet7M2b3TtgLaExd1kYIVr
	R9CCQnvLET4ES3NuUn/eeAjdubUQmUsQlkVuJ4nEjaVCq5tU8sD7J2B8X9IOXhRkqDCwv/wVlb4
	VmusnUSNyzIcUvkyoDkzFWg==
X-Google-Smtp-Source: AGHT+IH+J7RzJDe7NhBx4Bevu5yjGUwknofvvj4Inwv5XKnR+LfxDzqBhWN45vaZIqRemQ7zYlgZCpxoSq+gw07sAg==
X-Received: from pfbcj5.prod.google.com ([2002:a05:6a00:2985:b0:725:e2fd:dcf9])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2c86:b0:725:f4c6:6b81 with SMTP id d2e1a72fcca58-72abdd4e7a8mr8624153b3a.2.1734742298900;
 Fri, 20 Dec 2024 16:51:38 -0800 (PST)
Date: Sat, 21 Dec 2024 00:42:34 +0000
In-Reply-To: <20241221004236.2629280-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241221004236.2629280-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241221004236.2629280-4-almasrymina@google.com>
Subject: [PATCH RFC net-next v1 3/5] net: add get_netmem/put_netmem support
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"

Currently net_iovs support only pp ref counts, and do not support a
page ref equivalent.

This is fine for the RX path as net_iovs are used exclusively with the
pp and only pp refcounting is needed there. The TX path however does not
use pp ref counts, thus, support for get_page/put_page equivalent is
needed for netmem.

Support get_netmem/put_netmem. Check the type of the netmem before
passing it to page or net_iov specific code to obtain a page ref
equivalent.

For dmabuf net_iovs, we obtain a ref on the underlying binding. This
ensures the entire binding doesn't disappear until all the net_iovs have
been put_netmem'ed. We do not need to track the refcount of individual
dmabuf net_iovs as we don't allocate/free them from a pool similar to
what the buddy allocator does for pages.

This code is written to be extensible by other net_iov implementers.
get_netmem/put_netmem will check the type of the netmem and route it to
the correct helper:

pages -> [get|put]_page()
dmabuf net_iovs -> net_devmem_[get|put]_net_iov()
new net_iovs ->	new helpers

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/skbuff_ref.h |  4 ++--
 include/net/netmem.h       |  3 +++
 net/core/devmem.c          | 10 ++++++++++
 net/core/devmem.h          | 11 +++++++++++
 net/core/skbuff.c          | 30 ++++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index 0f3c58007488..9e49372ef1a0 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -17,7 +17,7 @@
  */
 static inline void __skb_frag_ref(skb_frag_t *frag)
 {
-	get_page(skb_frag_page(frag));
+	get_netmem(skb_frag_netmem(frag));
 }
 
 /**
@@ -40,7 +40,7 @@ static inline void skb_page_unref(netmem_ref netmem, bool recycle)
 	if (recycle && napi_pp_put_page(netmem))
 		return;
 #endif
-	put_page(netmem_to_page(netmem));
+	put_netmem(netmem);
 }
 
 /**
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 1b58faa4f20f..d30f31878a09 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -245,4 +245,7 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 	return __netmem_clear_lsb(netmem)->dma_addr;
 }
 
+void get_netmem(netmem_ref netmem);
+void put_netmem(netmem_ref netmem);
+
 #endif /* _NET_NETMEM_H */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 0b6ed7525b22..f7e06a8cba01 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -322,6 +322,16 @@ void dev_dmabuf_uninstall(struct net_device *dev)
 	}
 }
 
+void net_devmem_get_net_iov(struct net_iov *niov)
+{
+	net_devmem_dmabuf_binding_get(niov->owner->binding);
+}
+
+void net_devmem_put_net_iov(struct net_iov *niov)
+{
+	net_devmem_dmabuf_binding_put(niov->owner->binding);
+}
+
 /*** "Dmabuf devmem memory provider" ***/
 
 int mp_dmabuf_devmem_init(struct page_pool *pool)
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 76099ef9c482..54e30fea80b3 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -119,6 +119,9 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 	__net_devmem_dmabuf_binding_free(binding);
 }
 
+void net_devmem_get_net_iov(struct net_iov *niov);
+void net_devmem_put_net_iov(struct net_iov *niov);
+
 struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
@@ -126,6 +129,14 @@ void net_devmem_free_dmabuf(struct net_iov *ppiov);
 #else
 struct net_devmem_dmabuf_binding;
 
+static inline void net_devmem_get_net_iov(struct net_iov *niov)
+{
+}
+
+static inline void net_devmem_put_net_iov(struct net_iov *niov)
+{
+}
+
 static inline void
 __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..815245d5c36b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -88,6 +88,7 @@
 #include <linux/textsearch.h>
 
 #include "dev.h"
+#include "devmem.h"
 #include "netmem_priv.h"
 #include "sock_destructor.h"
 
@@ -7290,3 +7291,32 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
 	return false;
 }
 EXPORT_SYMBOL(csum_and_copy_from_iter_full);
+
+void get_netmem(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem)) {
+		/* Assume any net_iov is devmem and route it to
+		 * net_devmem_get_net_iov. As new net_iov types are added they
+		 * need to be checked here.
+		 */
+		net_devmem_get_net_iov(netmem_to_net_iov(netmem));
+		return;
+	}
+	get_page(netmem_to_page(netmem));
+}
+EXPORT_SYMBOL(get_netmem);
+
+void put_netmem(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem)) {
+		/* Assume any net_iov is devmem and route it to
+		 * net_devmem_put_net_iov. As new net_iov types are added they
+		 * need to be checked here.
+		 */
+		net_devmem_put_net_iov(netmem_to_net_iov(netmem));
+		return;
+	}
+
+	put_page(netmem_to_page(netmem));
+}
+EXPORT_SYMBOL(put_netmem);
-- 
2.47.1.613.gc27f4b7a9f-goog


