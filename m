Return-Path: <linux-kselftest+bounces-27037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5DA3CF23
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 03:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FFD1891C3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA2C1DFD98;
	Thu, 20 Feb 2025 02:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+Pe0RO9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA91DC991
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017372; cv=none; b=Ahpzth683MP7/qlOSwk383H+yRXc+fNb2ictOu4ZEbpdWL02E5+hHZSnLYcNo+vqaCQ6Qo1I1PMiz/6vqQ5H1YiC12l/9jwB/SnpDkOeMm7QgKrW82pOLN3IQqu8zuvS58H1lPTH0SC8wXzraMMSNIHSBCcUs5c2fo8bufI6UBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017372; c=relaxed/simple;
	bh=q5XsmN0+qNQcTTcfaJ4MRPPi7x8kiGcH8m4E8CxyZWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FWJ0Dd/HCu0FcxukMYMIP9tcB5ZHRSUWHJ6VLiidMFQY9JMgchxm+vQA+tapJ/5Jc6lvJQZRjAmkUol3/ikIwPI/hXwsp5gYXuzfmqSAoM0VpFmFL5SxSWeLaTIKuJNfm61+n65LyAlIuDSAFjTArF7h+1/w0jmcv9Wjg0MRLGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+Pe0RO9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220ec5c16e9so11024355ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 18:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740017369; x=1740622169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9i5ITI5hsYXNkk95ANyYz00PWaNA3wxaXmmfqorxWmI=;
        b=H+Pe0RO9SXEt2yoQXi3IeYHdYopwcJsr3ByJ3xKi76c/eFSovzJjpsO4Jbi1l+BInl
         b4nPPck/EI3cCo7HQ88Ml8niXEWjoS9t1WABh7EITKGnTXJqAXiVDB89KY+hX+MVZ9Ar
         yxp37z+l9hLOlSv547GKIftyWeXfX28IcZ2jiPb51Sn6tVuUQN/ptV8ZeRdogPJiH4E0
         brkEGnaR/+ZFejIfxhUP/F9yCms9UxPXVqECTovw75kbwo6b82hGFfT6S+T8YIXP7J3p
         6LSFkVERGgLEo4Srk8QkCoPVAVk64Nd0/dAiTCnnlDXn75zk2nafzunnkGMOQwX+AmQm
         05+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017369; x=1740622169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9i5ITI5hsYXNkk95ANyYz00PWaNA3wxaXmmfqorxWmI=;
        b=baWz7uxaGNQDwCtC11IWo3UYug4NDgg6vl22VXMe7E/nBCtEmOKo3tmKCFYJBoCTl1
         dOctzx1eYJadtMo3I/U7utKxZm1Xr797XEEVKcFZLe/CJmcccHFxgglzxNORkSJbhbkj
         RzNpvo2abCpcOUGDJEnFV4u3yVQZf1n/BXOswr0+nlCzfpJkIDWXZio2yJ5IjMHGZdNG
         /61wNZVaQ5jRV4g7eHERy7imB/uVBqB9Xt8s5E0wxDRVlbdM9M0WvENgIW3d4dKZfxpB
         BDjuTz4FYak2KV6vgsOp/vJYTOjyaxUnoiVNYZZAp8o3Is7qTlTZdZGLt8DXSjJvTT6U
         W4yA==
X-Forwarded-Encrypted: i=1; AJvYcCUBkrP8KQKCi2ZiSIYNRWrI6/MjHiU+rCaEMCcPn0DPb/2JIX/iKCC58SJlZ7HI+E/BY4NFqcxMDbiQmAwM1EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3mEUdU4pPY1jdGvNsm1uUJRRNaUW/dauNzOVv6/m+/DUhR2VF
	bjv6SyMf+g8KjyEvpsO0xFCYwlq24+rA2as8NQwHM6G5jnd5r2o2gsqr8nhWOs4KW0f+Sjfz8hs
	I0kNfaA2oltCKv+o4csZkPQ==
X-Google-Smtp-Source: AGHT+IFWUpLngVjg4ZRvdMcFQlYPunbjfg+CrCWS1N/fYD0oezyFMNiTwHerTLo6whLbQg+u/NAp0xpJYUvUoObtoQ==
X-Received: from plqw12.prod.google.com ([2002:a17:902:a70c:b0:21f:4d14:8384])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e54e:b0:220:ff3f:6cc5 with SMTP id d9443c01a7336-221040bf806mr344999995ad.35.1740017369127;
 Wed, 19 Feb 2025 18:09:29 -0800 (PST)
Date: Thu, 20 Feb 2025 02:09:10 +0000
In-Reply-To: <20250220020914.895431-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220020914.895431-6-almasrymina@google.com>
Subject: [PATCH net-next v4 5/9] net: add devmem TCP TX documentation
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Add documentation outlining the usage and details of the devmem TCP TX
API.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v4:
- Mention SO_BINDTODEVICE is recommended (me/Pavel).

v2:
- Update documentation for iov_base is the dmabuf offset (Stan)

---
 Documentation/networking/devmem.rst | 150 +++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index d95363645331..10928a5f912f 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -62,15 +62,15 @@ More Info
     https://lore.kernel.org/netdev/20240831004313.3713467-1-almasrymina@google.com/
 
 
-Interface
-=========
+RX Interface
+============
 
 
 Example
 -------
 
-tools/testing/selftests/net/ncdevmem.c:do_server shows an example of setting up
-the RX path of this API.
+./tools/testing/selftests/drivers/net/hw/ncdevmem:do_server shows an example of
+setting up the RX path of this API.
 
 
 NIC Setup
@@ -235,6 +235,148 @@ can be less than the tokens provided by the user in case of:
 (a) an internal kernel leak bug.
 (b) the user passed more than 1024 frags.
 
+TX Interface
+============
+
+
+Example
+-------
+
+./tools/testing/selftests/drivers/net/hw/ncdevmem:do_client shows an example of
+setting up the TX path of this API.
+
+
+NIC Setup
+---------
+
+The user must bind a TX dmabuf to a given NIC using the netlink API::
+
+        struct netdev_bind_tx_req *req = NULL;
+        struct netdev_bind_tx_rsp *rsp = NULL;
+        struct ynl_error yerr;
+
+        *ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+
+        req = netdev_bind_tx_req_alloc();
+        netdev_bind_tx_req_set_ifindex(req, ifindex);
+        netdev_bind_tx_req_set_fd(req, dmabuf_fd);
+
+        rsp = netdev_bind_tx(*ys, req);
+
+        tx_dmabuf_id = rsp->id;
+
+
+The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
+that has been bound.
+
+The user can unbind the dmabuf from the netdevice by closing the netlink socket
+that established the binding. We do this so that the binding is automatically
+unbound even if the userspace process crashes.
+
+Note that any reasonably well-behaved dmabuf from any exporter should work with
+devmem TCP, even if the dmabuf is not actually backed by devmem. An example of
+this is udmabuf, which wraps user memory (non-devmem) in a dmabuf.
+
+Socket Setup
+------------
+
+The user application must use MSG_ZEROCOPY flag when sending devmem TCP. Devmem
+cannot be copied by the kernel, so the semantics of the devmem TX are similar
+to the semantics of MSG_ZEROCOPY.
+
+	setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
+
+It is also recommended that the user binds the TX socket to the same interface
+the dma-buf has been bound to via SO_BINDTODEVICE.
+
+	setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname, strlen(ifname) + 1);
+
+
+Sending data
+--------------
+
+Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
+
+The user should create a msghdr where,
+
+iov_base is set to the offset into the dmabuf to start sending from.
+iov_len is set to the number of bytes to be sent from the dmabuf.
+
+The user passes the dma-buf id to send from via the dmabuf_tx_cmsg.dmabuf_id.
+
+The example below sends 1024 bytes from offset 100 into the dmabuf, and 2048
+from offset 2000 into the dmabuf. The dmabuf to send from is tx_dmabuf_id::
+
+       char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
+       struct dmabuf_tx_cmsg ddmabuf;
+       struct msghdr msg = {};
+       struct cmsghdr *cmsg;
+       struct iovec iov[2];
+
+       iov[0].iov_base = (void*)100;
+       iov[0].iov_len = 1024;
+       iov[1].iov_base = (void*)2000;
+       iov[1].iov_len = 2048;
+
+       msg.msg_iov = iov;
+       msg.msg_iovlen = 2;
+
+       msg.msg_control = ctrl_data;
+       msg.msg_controllen = sizeof(ctrl_data);
+
+       cmsg = CMSG_FIRSTHDR(&msg);
+       cmsg->cmsg_level = SOL_SOCKET;
+       cmsg->cmsg_type = SCM_DEVMEM_DMABUF;
+       cmsg->cmsg_len = CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
+
+       ddmabuf.dmabuf_id = tx_dmabuf_id;
+
+       *((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) = ddmabuf;
+
+       sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
+
+
+Reusing TX dmabufs
+------------------
+
+Similar to MSG_ZEROCOPY with regular memory, the user should not modify the
+contents of the dma-buf while a send operation is in progress. This is because
+the kernel does not keep a copy of the dmabuf contents. Instead, the kernel
+will pin and send data from the buffer available to the userspace.
+
+Just as in MSG_ZEROCOPY, the kernel notifies the userspace of send completions
+using MSG_ERRQUEUE::
+
+        int64_t tstop = gettimeofday_ms() + waittime_ms;
+        char control[CMSG_SPACE(100)] = {};
+        struct sock_extended_err *serr;
+        struct msghdr msg = {};
+        struct cmsghdr *cm;
+        int retries = 10;
+        __u32 hi, lo;
+
+        msg.msg_control = control;
+        msg.msg_controllen = sizeof(control);
+
+        while (gettimeofday_ms() < tstop) {
+                if (!do_poll(fd)) continue;
+
+                ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
+
+                for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+                        serr = (void *)CMSG_DATA(cm);
+
+                        hi = serr->ee_data;
+                        lo = serr->ee_info;
+
+                        fprintf(stdout, "tx complete [%d,%d]\n", lo, hi);
+                }
+        }
+
+After the associated sendmsg has been completed, the dmabuf can be reused by
+the userspace.
+
+
 Implementation & Caveats
 ========================
 
-- 
2.48.1.601.g30ceb7b040-goog


