Return-Path: <linux-kselftest+bounces-31845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB0DAA004D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 05:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 029CF7B04CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 03:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A936F2741AC;
	Tue, 29 Apr 2025 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="necZaB+h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7E2638B2
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 03:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897212; cv=none; b=hl4y8NUrWnpYp1kAUUn5X4n7zG5BUMaOQJSy/ysv1we7PGJXqraAVfa73TvPr+MIV2TRj0O5FH/eohxAIDTzjWY2mVm7mO/BtK/lLcw2D0NXLJRCoYnGv0qhFAyLPvVR2X4W2r/hp3k7Zg+vAB3rXVFw8VDo+5up9bbb4T7Sxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897212; c=relaxed/simple;
	bh=B5PX9Lf3hHlAc8nT31777G6uaChSicsoUzSQ2m3f7Is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mQAZJIEpmU8e/GxIMkoXXvTJP5pq4N7PxGrK6CJ7DSxsRKu6TeM2Z+OICsQiQBpR3gjndlIAMFa2paOAs7S0DV87tjFAoN5zpmOC6nYEbyLI9RPHVca2Cw6lXTodQjdFvpCuPCObbWiH2bDdqd+uVZrR2y239MEfD4tG97AQPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=necZaB+h; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so5003215a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 20:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745897209; x=1746502009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlpbhZibP6J4Ym1z1HUBlnZxX7S6WzB4+iykVCt9EBk=;
        b=necZaB+hJzfNEki/Mw5Rb3a2HZDhCg587KrI5RfNvIjUEG84W9zVxdnrZ9d8tlILqb
         7xcQl6Po18zIjrM1LxwS8pokZFu1pCNQThl8hTcOxL9vwca0b+hXAvtgpgsB0btsikCW
         dPVCkZsapwr/RdDbFZxJ83Gb7m90lQBMLGOmtf7Mnvs7tfklx3FUBeQPrzZZwiWaD5B4
         T3nL+N3PQsaTm0SqvflXRZPhBaButtYQ2OP/TiiBp3JtL6FUaBj9nOur5AwkdYUPVlDQ
         MtWjwT5Cy5JncMCHrq1yIbIZZdMP7E+U0ovQ/Rr+ZD3m7tXAAbwUtM9m8ADNE7PYal2d
         VXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745897209; x=1746502009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlpbhZibP6J4Ym1z1HUBlnZxX7S6WzB4+iykVCt9EBk=;
        b=clAzv8SSA/0q+ZI/ZNFghZzHRp9zTcu6TnBKxWm1BZggoKE/CIWWMf91UNEH5EaWku
         GYAXv/5d21hn5L7nfL4pYW/rcD0GNtgkjjL1Y+I7kjVdsVpuWLwywnLjMYmh+g4yQN1C
         CZ2MpD8o0r4z6Vi9Q7qWSEghT8nHFdyIAas6+jtRUkrIGUtIzQw/U01+B5+P2E+yZwLd
         9pV8WwZ+aPw8n+uCPljweb3LAu8w7KVAnOJIEt0ODwKHm7KRy0HmfAgVRHW30+jGGipa
         MeBB4Wjrx2VycgnqljXwHlNNeUD28d3p9h/CNLbJ1r5rmB1YCbzTS71QTFDJpw5lldwf
         mJSg==
X-Forwarded-Encrypted: i=1; AJvYcCWQnW+f07oZ7zLdXcz2V4oarUUs3WRiMesYQ1j8mEPCV+HuqIqrxCzZHUdWNbF1zcgNoQRniawsdWp3ZJ8OPBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNUPnzf5cr8Lma8mwrwMbF2UsIV0bl443Oj+Nlb1QEaJHocJj5
	qH0J/CM4pYKa4k5enOqZXP04xC6CZrT2dLCMeXsCLsJxuJUuRJB8AGOs/dgpWDbxdZRaclSJhcP
	FQAK7r/RdueSp0ArOQEZ4EQ==
X-Google-Smtp-Source: AGHT+IFEU4uTolsX1GkreQA/P5In6m7v2jFirSteGRMuvBCJ0OIMbuFpYzKl1Jqa+aOglE1u9mh6TsXJY4aqADZhIg==
X-Received: from pjbsd12.prod.google.com ([2002:a17:90b:514c:b0:301:4260:4d23])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c4:b0:309:fac6:44f9 with SMTP id 98e67ed59e1d1-30a013bcbc8mr14918054a91.31.1745897209158;
 Mon, 28 Apr 2025 20:26:49 -0700 (PDT)
Date: Tue, 29 Apr 2025 03:26:37 +0000
In-Reply-To: <20250429032645.363766-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250429032645.363766-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429032645.363766-2-almasrymina@google.com>
Subject: [PATCH net-next v13 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
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

Later patches in the series adds TX net_iovs where there is no pp
associated, so we can't rely on niov->pp->mp_ops to tell what is the
type of the net_iov.

Add a type enum to the net_iov which tells us the net_iov type.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v13:
- Fix nit: remove trailing comma at the end of enum (Christoph).

v8:
- Since io_uring zcrx is now in net-next, update io_uring net_iov type
  setting and remove the NET_IOV_UNSPECIFIED type

v7:
- New patch

---
 include/net/netmem.h | 11 ++++++++++-
 io_uring/zcrx.c      |  1 +
 net/core/devmem.c    |  3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index c61d5b21e7b42..973fdbcfef38b 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -20,8 +20,17 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
  */
 #define NET_IOV 0x01UL
 
+enum net_iov_type {
+	NET_IOV_DMABUF,
+	NET_IOV_IOURING,
+
+	/* Force size to unsigned long to make the NET_IOV_ASSERTS below pass.
+	 */
+	NET_IOV_MAX = ULONG_MAX
+};
+
 struct net_iov {
-	unsigned long __unused_padding;
+	enum net_iov_type type;
 	unsigned long pp_magic;
 	struct page_pool *pp;
 	struct net_iov_area *owner;
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index fe86606b9f304..a07ad38935c86 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -259,6 +259,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		niov->owner = &area->nia;
 		area->freelist[i] = i;
 		atomic_set(&area->user_refs[i], 0);
+		niov->type = NET_IOV_IOURING;
 	}
 
 	area->free_count = nr_iovs;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d04935..f5c3a7e6dbb7b 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -30,7 +30,7 @@ static const struct memory_provider_ops dmabuf_devmem_ops;
 
 bool net_is_devmem_iov(struct net_iov *niov)
 {
-	return niov->pp->mp_ops == &dmabuf_devmem_ops;
+	return niov->type == NET_IOV_DMABUF;
 }
 
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
@@ -266,6 +266,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 
 		for (i = 0; i < owner->area.num_niovs; i++) {
 			niov = &owner->area.niovs[i];
+			niov->type = NET_IOV_DMABUF;
 			niov->owner = &owner->area;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
-- 
2.49.0.901.g37484f566f-goog


