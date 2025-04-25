Return-Path: <linux-kselftest+bounces-31655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01DA9D346
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 22:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894A11C00AF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 20:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D4224B0B;
	Fri, 25 Apr 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXl3W+C4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BEB22424E
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614070; cv=none; b=R/SHh9WhwWNa8cqkaf7u8tMQDdVMV1kf0/5fOLPQlxGVsTxEHTUg8RgZ6GtGQpsbQJ2lHnX7zr2/CqwDvB60Tw+cqTAm6iaNAjM03XqqHYODLjttJTueTStwNHdQjptINpDcyhPuEPFRvJo63hNYgf5OaRahnDWZcjVYteWOqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614070; c=relaxed/simple;
	bh=2sgrDkV1VNpZu1lPebePMNAlzGYH0QeJBb8gDZUPkf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hn6HlNhXAxbgtYTYdKamaDvecJrjOe5AwnCcLnQyt/oCDV3+YRYWW2GH64aa5BNjj6eQ8UKmbLmA8dmhWqpjGVy/hDP05mzqtrHtWz2+VSyp02nqwrGASCYvmauKh/6FOJODtIAzhd+f6PDr0krGMjkF07IxVK0ikZ6VffGinLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GXl3W+C4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af8e645a1d1so1687337a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745614068; x=1746218868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hOt6cyrWNQpClyQ4E59JTvSvFuwVRM0/49qP/qf+hY=;
        b=GXl3W+C44sjh3/JIbDTcP9yM/whvfMzdFbHEPk3Z/XCtMAj6OLG7E2hvwwiB6nDtPr
         gus/A9LbxOYbRZ5AqyXp47fALqyDlXXNeklvjkou8FarEBlTyG/QvQsttitiE+bb2V0o
         Tz3pn3WWeq6dFc30/kykyFDQuntJ/zUtStCRdULaDTxdDfabLDxfZCdVIXn6Xjjx6q/g
         Y172/jX1bYmW724gUuvnJ/mlp35AfUXD8LUh+HXO5NlD5StzBhH4ActlPmP//z8MpsKW
         IzMDkKZiK2dUpNZvqhN3Dtc/DgAyXmLrpzRlIKhiGzlJ1g97ITWLHa1ScIN0iOmX+Vxj
         xBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745614068; x=1746218868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hOt6cyrWNQpClyQ4E59JTvSvFuwVRM0/49qP/qf+hY=;
        b=h0wfiPaISrRUL7IloD3NbibSt14R4XwUBGT+c34KTQSbEFRQhq5iL2V7g3tWbQaiv8
         dwti7IDsIGxmTfzzdc2MTK02nquBgskOc1glJAC2YXrf4kDftk0bDJ6M0ULcueMTuC3T
         C6XuzJKkvS/3P0ftYhJnt8SAnsqpRm79F8XN225HZBHQ8hnP8A+cApGu1qz3ZAPZt8fB
         XIPAnRdOg/93SBTUCFGvJpHYf8JhLXSIRxYi2lMHQHjnRmhiq0yiiloLLNfq2mlHLFTI
         UM0Ih2xjP3MxbszL8kZjwzcuKphd/A5B7UvJ4GsjmfbUWlPNnP0aWkHb7jmC8PXDuF1W
         KjGg==
X-Forwarded-Encrypted: i=1; AJvYcCWlTIEATPi4u8U+M4WXwolNQDq+EfQY21CDg3ur1+ifKlPgwwn1H/D6nFZvV8CT5kBWv1CVi85xPYEg2KwpAUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTyGshI6ehy61tnE34hptTdq6hBAjm/kCjX5bEB5yaFiqbMc4l
	9wgm6sa6OI/KhOQ9IRtHKnuzkl8/owF9emzeT5qmhO5wVdy7s/GcY42URM8Ee6J+WO4br/uMotB
	v/vceWZxAan15iSRNv9nWkw==
X-Google-Smtp-Source: AGHT+IHK9jDiSJ0MHUBjIMIkp0oEg07C59pxxKzen7DKbUzHR4WHWjcocaCKA4lywJ8HpmpMjxR8ZEXL9UKUSfvy0Q==
X-Received: from pgbep5.prod.google.com ([2002:a05:6a02:2645:b0:b16:149:d36e])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c991:b0:1f5:839e:ece8 with SMTP id adf61e73a8af0-2046a3abdc1mr955257637.2.1745614067778;
 Fri, 25 Apr 2025 13:47:47 -0700 (PDT)
Date: Fri, 25 Apr 2025 20:47:35 +0000
In-Reply-To: <20250425204743.617260-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425204743.617260-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425204743.617260-2-almasrymina@google.com>
Subject: [PATCH net-next v12 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
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

v8:
- Since io_uring zcrx is now in net-next, update io_uring net_iov type
  setting and remove the NET_IOV_UNSPECIFIED type

v7:
- New patch


fix iouring

---
 include/net/netmem.h | 11 ++++++++++-
 io_uring/zcrx.c      |  1 +
 net/core/devmem.c    |  3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index c61d5b21e7b42..64af9a288c80c 100644
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
+	NET_IOV_MAX = ULONG_MAX,
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
2.49.0.850.g28803427d3-goog


