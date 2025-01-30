Return-Path: <linux-kselftest+bounces-25443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A06A2366A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 22:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD191671F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 21:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC91F152E;
	Thu, 30 Jan 2025 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+O6Bjj+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128381B043E
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271747; cv=none; b=EXS77O8BA+5jgVSWVNxvLg/8zjIErr1+Wc9RKpBoJGW0GRgyps9i2e3D5RPdwZ4tlydUSnFFYBjUpU8vgPBawzCwubVNE5R0RMb654hoEs0m5CfE3GN3nxCy81TnUJNAlOtIFP1aAfKlg3aD9kwhnaoGV1+KUtsCwBLctcYFw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271747; c=relaxed/simple;
	bh=3u/7jLBYe2KfRcVNNTNkFn5t4vUJKiOG+tUb7ZrbBhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mk54iT23ajV9EOQTBfG8K0BiW8lAtyvNsfCJnETMcJP9hGXHqFPzTi724+bjHKHZ7UqKwRPGMSgLmBlSfHNCDc2FGPUCW5OcEV1XRfNEMBrgw4HkOG/tL/uFG54rIOT8PESOUsdujmiUJikK5aR+KeyzJkG+/LYqvNL7A3YGv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+O6Bjj+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f780a3d6e5so2522458a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 13:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738271744; x=1738876544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kMF0lC9HmaCcCSq7dy1+BxkweYLRN4mbfBRIjXSD14=;
        b=I+O6Bjj+cNMe2s1B+u8TGCi18k/D7LFYzaR66kO1CNEwgXH7djWegR6QGkzj5JwQSJ
         Y9Qo/aIZjL8IVBGJdsO2zOwzcF3Wu55sI85G+Fe3rkcTQItm/fXUzlJZrJacmAsH43L2
         XbkNZU6/y1alUi/QKO8B5ezpeOe4EBmxmBmbFlO0yHVJQByLdNtI2OaqVrjQql3IE/UN
         ugcJYz+k8WiLHa36AWHhp0f+UFVXKpwg1ZRqhgEzUVM7QsOdYyvW3vVzTqiZ5i0cGigB
         OTOIEI8IbPWIPGgcmh6eBMGuPplbl4n+wAl5Q9nCuWCxx2B7nI2LcTN2x7tYRf4bAHFn
         a7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271744; x=1738876544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kMF0lC9HmaCcCSq7dy1+BxkweYLRN4mbfBRIjXSD14=;
        b=qHEspyjD4wRaqM2T3vXa3WzKW96GaiG0b1oa3xjw2hJmgu34yEYd3UUQQ8iFawkFJR
         AmcqCdRTeIFmthmoyGX5EmNHB+W2XbMW6GUshlwHjyEeuJ+0LWmZ6bha/NwZ7NCmLsjO
         sO8sGWr8PkstptsZqw+yiiyW1hTALxaf9P4rc2XiL8B1MMolGMB/P+kDuVVPlvIXXcfp
         6l9lYuxGk4jV//O62rjRiRsaoSgQlcGAoj/b+wk8La1FSZcAdepiEDCX/pcCcK0NrNVR
         87ISd9QSLd4Ok+BwnkfbOaF+tCMxS+qLIsfZi7+GK/JlWFb4El1MNsNbjDEYZr5G+S4m
         Rg/A==
X-Forwarded-Encrypted: i=1; AJvYcCUc29g3zYf34rN3/JBKqP34D5tYQjQ7ed6ClVbl/Fs77jDO52lghP0DJGHwgkK/2nr/Us8LTl7cg10iiqOovB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkk2ISKq+XM3WKwykCJMI1Znd6S6h9rPA2kA23qGVD4T3S04+
	s1YkMCKZSOE9S8AkbIOxrexA3Qu3VRQhH9VVJAk3TWYEluReQxGxdv340UbxLmjnr88lLR6JoTV
	thN9uyEv2FMFENZappOAGPg==
X-Google-Smtp-Source: AGHT+IHSaYi9y/zBICOD8Bg8IwjEpl0YXsgZ0bkByw1FvqGCzDUrTuYSRphV9YF7474nI+yW7N+2oAhVQjlB0p0oJA==
X-Received: from pjbsw5.prod.google.com ([2002:a17:90b:2c85:b0:2d3:d4ca:5fb0])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:258b:b0:2ee:fd53:2b17 with SMTP id 98e67ed59e1d1-2f83ac836d0mr12411031a91.29.1738271744350;
 Thu, 30 Jan 2025 13:15:44 -0800 (PST)
Date: Thu, 30 Jan 2025 21:15:34 +0000
In-Reply-To: <20250130211539.428952-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250130211539.428952-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130211539.428952-2-almasrymina@google.com>
Subject: [PATCH RFC net-next v2 1/6] net: add devmem TCP TX documentation
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"

Add documentation outlining the usage and details of the devmem TCP TX
API.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2:
- Update documentation for iov_base is the dmabuf offset (Stan)
---
 Documentation/networking/devmem.rst | 144 +++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index d95363645331..8166fe09da13 100644
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
@@ -235,6 +235,142 @@ can be less than the tokens provided by the user in case of:
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
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
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
2.48.1.362.g079036d154-goog


