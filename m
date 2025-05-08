Return-Path: <linux-kselftest+bounces-32629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907DAAF014
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 02:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0664C18EC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 00:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6C17B418;
	Thu,  8 May 2025 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJIjSXy+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BDC13D8A3
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746665316; cv=none; b=MSGHBzw5XVRvlan11q3ZQQd4x9LuNOYVearLAEtOwTw+kABgMr1c7WraWqwwFG50wUYromceP3ctNCeF1IJq6i1zfdl5wLJTwQi+weWKtDrsX3PpzpAeP2OSQ5tqx+yNW79jmGyTN157aTckw33zRDWt8j4XtBhIh687j+vEyQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746665316; c=relaxed/simple;
	bh=RZeLmmQWcyKgZgOUNE77jrEQFJNlTgf1SJsa5Zp5JbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hUZuvuXPH4M347xO0Ppe90Iq7FOdtnQ5k9KvI9ruBxe97xnNdLPUCfM2tXfEYvU6C6lufKw7z30YU+6XZ0mdnA+4EWvryCLIukjqOJKmdApI+sZjAR39M4FWn0jVZM1Q+2P/ivO19sWeL9kVfL8GvLVl/UYFuGW2QoQcl6mn9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJIjSXy+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22aa75e6653so3438525ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 May 2025 17:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746665314; x=1747270114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4n1yygGO3c5V65vtgzQcyACv081IAHCxx4oigLjX+4=;
        b=lJIjSXy+XcrbGgUc6R45QWEC6TMJzlwM7sBf5XW00vN7N40Lgk7xjXfTaFMKYfh6fH
         PaTCDlrIL+6jG+ilsslYHmglSqqmEPpnytttaWQcSWiym9Mtwu3jCyP5P8Su4aFn+tDy
         3Rb8+45/OUeiI5LimhaIQSTBMJvcCUY57EMSX4a4hHVzU44jqIOk9IcQ3Bd1d8x8y5Uu
         mW6f1oNZ035DBCijeqn/8U66U6M0a7FUXOLqkQoGQib9eZxQSIlDpxUBF4k/REHZoTua
         WP0bYq1XXX27vJKwR3DsLLPB3grtpFbQGiblF2Dm4Mfjotujp0tpPmMg71pkfGLc6qm1
         rwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746665314; x=1747270114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4n1yygGO3c5V65vtgzQcyACv081IAHCxx4oigLjX+4=;
        b=tGWSvAqdCYlSLXGdyvI/xsqla8MbQe5EaauavsAXSq2CzsDed5tBUqileqxdXJ13VQ
         nJ84gH+pOSSm7WFd7xxo1+R4NN6NqvAE6hvpWRJKrL/7t4L0wxNDu3nR4VeiAAs1lB6t
         LEjy7PSfMf6Mmv2f2oBvRtLdexDCzOHV7JF8J7dAsQn9OHKmmkmQhjNl8egZyIX23Dud
         z1fsT+a/hWgr1ZGO8k4MOYa8CAdK4yWCygAM/PfPGpLwSHjVBOVyynoNaQoCWCKILj/G
         zfFrR/sN1KJ3Rv927rS2aEPhEi5pz52Rkc4AQXUpyFw1kF5CepesXkWijXNtMJRC2rzS
         2lKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3EV/IJt+98olaMWHWZMeN+1ygSB3s/6y/eHIGGgPX3pnVkc2y394zM3U4CBFweKQIRz+b/v5u1Jjo2vQR+Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHHHTBhx4aJqM4PHghkweT9Wanq4HwyDiY+gd72Ea0xPyAe2Ci
	NUd5oUoTajgf3dfAJ2l16ammFI3q5WWx6qNcksYXmMAcO6pn5cr2gjvIqNaBrGlRNHK/Xh7C0Qn
	o2Gt2FVl0REvW6BFZzckC+A==
X-Google-Smtp-Source: AGHT+IHORj/7E7KoEzjJ5v3tg0tS+tStTjlckawrbhrARnrvWcdHVByn9OBu5V30L9l89YW5VD7WZsI8Gy0V2jmDsg==
X-Received: from plry22.prod.google.com ([2002:a17:902:b496:b0:225:e051:fe46])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d582:b0:220:e9f5:4b7c with SMTP id d9443c01a7336-22e85ae41b2mr19587285ad.17.1746665314159;
 Wed, 07 May 2025 17:48:34 -0700 (PDT)
Date: Thu,  8 May 2025 00:48:21 +0000
In-Reply-To: <20250508004830.4100853-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508004830.4100853-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250508004830.4100853-2-almasrymina@google.com>
Subject: [PATCH net-next v14 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
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
2.49.0.987.g0cc8ee98dc-goog


