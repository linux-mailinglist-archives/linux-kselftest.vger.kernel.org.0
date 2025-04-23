Return-Path: <linux-kselftest+bounces-31374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE9AA97D55
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 05:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E629D188BFB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 03:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247A0267F7E;
	Wed, 23 Apr 2025 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvBxu9XI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9AA2676F6
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377892; cv=none; b=uT6bgIg+WhsP6lTKgqNM/qRS/a+5SXNtYtjbHNLzQ5fGFRgVLdUCWbgDhX0P3/1wp5K8iWCk9v/YPrzz4jufe6DPWZd4G+pneUfV006U1k3zCQV+1guV752hd2gaD8RlSLs8nmFdlBjp5XyT/z18cl2Ly1lzjGfsGPS6OQdsAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377892; c=relaxed/simple;
	bh=QDLXXaueecCgO5Axw+Nyu5EgxIhVwC4DuRcRjtwAJ5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HaXcBnlO9BaddIApiA47qpAKK1nlXuQGl23tKMG+uY8DmU4PkwzyJpfbZq0UHTuHaWIqd3B6RIxSGPvAaajmXZD5Mdpq5TWbdSzPvgoDJJrPQLghmvhKDAQADRwFs8d1sCURi+tk2PgDAsqVdZUu7PyXh4Q/TzjI0kZRIRrUH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvBxu9XI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b0e6b7ea77dso4484150a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745377889; x=1745982689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8s7bJQK9mVBiBVARPJ5kkauQHM9lxUZX4qjjEP+CsW4=;
        b=uvBxu9XILrUVCB10BUOIqwPDgSwWzGhnXXLB9kdbesduM34DfoxxSriH6YyFGoigf6
         LJSqcsUJQXGKIQSh9jIGQGM4vmPRLP5aBrbBh4ZyDiey4Z2ZlcTGCMhYcBCARf0q4PSo
         20eIDVBAqZfFfiY/yIUz11ko4RXrqO9te4mGtZVj0kDxO2eEa/AcBHnkzaMRxAnq/o+N
         GjRf9N9o6mUoZebS1FqFpGvm6lynvLddz+UJeHyHBx7jZn9LqafaG8tHKJOsx1ei8tj+
         N/qlRVKvk6Sjx394PQqo5FUixetL3uoN9JtqVEMIuErFZEaK2xenSf8S7XIkaAQCC7GX
         y/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745377889; x=1745982689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8s7bJQK9mVBiBVARPJ5kkauQHM9lxUZX4qjjEP+CsW4=;
        b=bwK9CIhCAoIQ3wERKdz6uxIub5SLAZMQ0GT0ljOrQwZ/2pdt5p8ZQKQkR5y19mEbyG
         n1mnHHKleYGFIhLJImz0qIfrzC7d+m/km7OZYs+s+e9fFcx8F8jaSs+gSMrG546H9M+2
         Ik1SOjX1c9X78glQ5eqVyuhhsF57hSQdw7cOj7wZlO7qot7/m0KPy5ETj9cAvOVC+qMu
         QY1hO2tRFWK1bRiIm4Kx3QyDJg0hLsBrvRUKVs5pOpz1UEa7l6BrZGQ9EKb715zZK4CW
         JL0x51vonrEm36OuHCHaIV6w9phi14HqBnOPrA/sgQmVauvshsNz64BhVTFKZurmWnXk
         PTRg==
X-Forwarded-Encrypted: i=1; AJvYcCVZcZqN/kmwwCIHs4GlzwpKr0aIH7/FR5oKyOB7wig3Yjo5SQQjySC7XH68UFvc0z/b+AmwO4HVdRJKMNcHCLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1m4ujgSm4ynDjfwEHyReBeF6xlpb5A3QpTGxEaKnTIx1pFC+
	Jzo9OwkXR96HfY8Qw95FYWAJgl/2/1WmF3e2KZD8OBCpbNroYczAJbrEZb6OSkH1hLjmvPmJncr
	qcwqRZXEL91y7f6M0LfBnNw==
X-Google-Smtp-Source: AGHT+IF9D/yFC1AheDuGXqhz07oC2ca1PhKApJJqXPDbnBYJ1b4GaurJbnu6E/ofsvxrsu/HreJcvrY9hcCc4h3JOA==
X-Received: from pji5.prod.google.com ([2002:a17:90b:3fc5:b0:2f8:49ad:406c])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c887:b0:2ff:693a:7590 with SMTP id 98e67ed59e1d1-3087bccaec2mr27681859a91.33.1745377888795;
 Tue, 22 Apr 2025 20:11:28 -0700 (PDT)
Date: Wed, 23 Apr 2025 03:11:12 +0000
In-Reply-To: <20250423031117.907681-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250423031117.907681-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250423031117.907681-6-almasrymina@google.com>
Subject: [PATCH net-next v10 5/9] net: add devmem TCP TX documentation
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
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Add documentation outlining the usage and details of the devmem TCP TX
API.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v5:
- Address comments from Stan and Bagas

v4:
- Mention SO_BINDTODEVICE is recommended (me/Pavel).

v2:
- Update documentation for iov_base is the dmabuf offset (Stan)

---
 Documentation/networking/devmem.rst | 150 +++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index eb678ca454968..a6cd7236bfbd2 100644
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
+to the semantics of MSG_ZEROCOPY::
+
+	setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
+
+It is also recommended that the user binds the TX socket to the same interface
+the dma-buf has been bound to via SO_BINDTODEVICE::
+
+	setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname, strlen(ifname) + 1);
+
+
+Sending data
+------------
+
+Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
+
+The user should create a msghdr where,
+
+* iov_base is set to the offset into the dmabuf to start sending from
+* iov_len is set to the number of bytes to be sent from the dmabuf
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
2.49.0.805.g082f7c87e0-goog


