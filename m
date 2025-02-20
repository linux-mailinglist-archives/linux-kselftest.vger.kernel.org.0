Return-Path: <linux-kselftest+bounces-27032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 541C1A3CF04
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 03:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B07C1891349
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4021CCEE2;
	Thu, 20 Feb 2025 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNn1I4tj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBD014AD29
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017364; cv=none; b=KmhFcSTrNd9EQD3a9htkzof02zwUbxywjkp2wdbD37ZchXk7MJ9QGOU9fabNMavubrpLZam4jat2S2qdZTeF89gXuJG7XJOOBxmM8dCsB6v0aYnMkAgZqEA4dYI2l3zn5nVDsKR0lLR/lYeMEPxnRqt3TxQ7GZRZyhW0pof0ktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017364; c=relaxed/simple;
	bh=9+pwnzig8Ryj014TmqcSyfZoHtlfK55x6jfoDd/uL7Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fobKs/UZrer5yvys5Ql03XeMFPdEKW0XprmfNfxR8hprbuMnhI+2X3eAIluWZtFBhU5s5u1QO2EN3QLNe6pWDaDOSkjdRpO18jDo52GckGWBf///e/RXiMhhZfU9WAafLvM4tNoWC2l1+U8tLHDsbuHl8zCqxvvv/KQC1BshjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNn1I4tj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22109f29c99so7432765ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 18:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740017361; x=1740622161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tdFjzAT0O9Xs2ImnpdkOHyb9nGcrP4P+5nIAtEsL2Ls=;
        b=XNn1I4tjQt3sY2D6zBf54OAMDV2lLCXaCpy1WUNzJM1Q9as+g2vFtyrw8kRjWtLV0u
         QoRAi5GDW4kvpUxkf9siNiNWQxQGQYWamSmFb4tS8SvD4J9k+1gapEENmX3QxVt1rx+q
         3BB7LvOl7r0/ome2YsI9JswGwh/yw+MleKpFRlU+1+cpm1uGrCemU2h3my//XVxSfikf
         PyO8nQar2xcaV8qnqH9ncLGO2ZfgtnyzBHxakQMzJVK3DSOJwvP0KYLtDM2QIU4BCAKK
         LX79CABG3x+SGpkvZAf0tpDn82NzJjZgi4l2I/o0ZAWv3WSgSRLVHT2sjMIN2lfaxYw0
         Np2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017361; x=1740622161;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdFjzAT0O9Xs2ImnpdkOHyb9nGcrP4P+5nIAtEsL2Ls=;
        b=UHhJHK8v8pERynqVbFYP5HHXRLe5s0UFev8Y8znw3ND8cl4nU7fjwugJX+C9lt4K9S
         r3BeZ5jUX50PX6+3hiPJaPZClQMngrx4DSAZYwrys5KfAUm1T7kmB4Ou0F3i9ryw+oI/
         Kg2T1IT8t1PWgrUQuTTTkQDkncncZZWWiRLXihl/BmtXqEBWmgi4W/YseWU3Oi5aO23h
         9/e9006NdL351oHMPx/Zn5zptkNyfVwBU6r3FFEK5Z4tmQ16dspmBqFRGhoE9rTV9vzo
         s4GsA8rHNk7l9kwbSPTfjKGH1m/84Mm9E6MX8f0wGhC5t9JaadYfGDCEsU9439sZlfus
         i8dg==
X-Forwarded-Encrypted: i=1; AJvYcCXeWir7gnzejJ9q5u4TamXwEquMrwJooTt8ASPzjr/BCVBoHZ41OBKb6FBV1DJ2diy4BmxtwSz1O/Hxg34BD+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgeKHHJRAaPtWKKpahGkpi5cMFBVsvExlH12MRPGRXnOgwzj9
	+VqY4ud8LWeE6f86dBZKYTlmvjK+xeH1QU7by86a7WZhwNy51ZvBOD2Gm9zHQAXfP7Tqf8yi0ol
	qDTEIMsdPpPxiY3gXN+pNHw==
X-Google-Smtp-Source: AGHT+IH1Q8T13M4hlauL/m5Pkd5TnVBezXcAze+EWCA7YzdT0yyJNCvvlW3g3JJs2lwePWkxRXXwW+XuTA8v02/6LA==
X-Received: from plhb12.prod.google.com ([2002:a17:903:228c:b0:221:7e04:d760])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e80b:b0:215:9d58:6f35 with SMTP id d9443c01a7336-22103eff01cmr346221075ad.1.1740017360669;
 Wed, 19 Feb 2025 18:09:20 -0800 (PST)
Date: Thu, 20 Feb 2025 02:09:05 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220020914.895431-1-almasrymina@google.com>
Subject: [PATCH net-next v4 0/9] Device memory TCP TX
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

v4: https://lore.kernel.org/netdev/20250203223916.1064540-1-almasrymina@google.com/
===

v4 mainly addresses the critical driver support issue surfaced in v3 by
Paolo and Stan. Drivers aiming to support netmem_tx should make sure not
to pass the netmem dma-addrs to the dma-mapping APIs, as these dma-addrs
may come from dma-bufs.

Additionally other feedback from v3 is addressed.

Major changes:
- Add helpers to handle netmem dma-addrs. Add GVE support for
  netmem_tx.
- Fix binding->tx_vec not being freed on error paths during the
  tx binding.
- Add a minimal devmem_tx test to devmem.py.
- Clean up everything obsolete from the cover letter (Paolo).

v3: https://patchwork.kernel.org/project/netdevbpf/list/?series=929401&state=*
===

Address minor comments from RFCv2 and fix a few build warnings and
ynl-regen issues. No major changes.

RFC v2: https://patchwork.kernel.org/project/netdevbpf/list/?series=920056&state=*
=======

RFC v2 addresses much of the feedback from RFC v1. I plan on sending
something close to this as net-next  reopens, sending it slightly early
to get feedback if any.

Major changes:
--------------

- much improved UAPI as suggested by Stan. We now interpret the iov_base
  of the passed in iov from userspace as the offset into the dmabuf to
  send from. This removes the need to set iov.iov_base = NULL which may
  be confusing to users, and enables us to send multiple iovs in the
  same sendmsg() call. ncdevmem and the docs show a sample use of that.

- Removed the duplicate dmabuf iov_iter in binding->iov_iter. I think
  this is good improvment as it was confusing to keep track of
  2 iterators for the same sendmsg, and mistracking both iterators
  caused a couple of bugs reported in the last iteration that are now
  resolved with this streamlining.

- Improved test coverage in ncdevmem. Now multiple sendmsg() are tested,
  and sending multiple iovs in the same sendmsg() is tested.

- Fixed issue where dmabuf unmapping was happening in invalid context
  (Stan).

====================================================================

The TX path had been dropped from the Device Memory TCP patch series
post RFCv1 [1], to make that series slightly easier to review. This
series rebases the implementation of the TX path on top of the
net_iov/netmem framework agreed upon and merged. The motivation for
the feature is thoroughly described in the docs & cover letter of the
original proposal, so I don't repeat the lengthy descriptions here, but
they are available in [1].

Full outline on usage of the TX path is detailed in the documentation
included with this series.

Test example is available via the kselftest included in the series as well.

The series is relatively small, as the TX path for this feature largely
piggybacks on the existing MSG_ZEROCOPY implementation.

Patch Overview:
---------------

1. Documentation & tests to give high level overview of the feature
   being added.

1. Add netmem refcounting needed for the TX path.

2. Devmem TX netlink API.

3. Devmem TX net stack implementation.

4. Make dma-buf unbinding scheduled work to handle TX cases where it gets
   freed from contexts where we can't sleep.

5. Add devmem TX documentation.

6. Add scaffolding enabling driver support for netmem_tx. Add helpers, driver
feature flag, and docs to enable drivers to declare netmem_tx support.

7. Guard netmem_tx against being enabled against drivers that don't
   support it.

8. Add devmem_tx selftests. Add TX path to ncdevmem and add a test to
   devmem.py.

Testing:
--------

Testing is very similar to devmem TCP RX path. The ncdevmem test used
for the RX path is now augemented with client functionality to test TX
path.

* Test Setup:

Kernel: net-next with this RFC and memory provider API cherry-picked
locally.

Hardware: Google Cloud A3 VMs.

NIC: GVE with header split & RSS & flow steering support.

Performance results are not included with this version, unfortunately.
I'm having issues running the dma-buf exporter driver against the
upstream kernel on my test setup. The issues are specific to that
dma-buf exporter and do not affect this patch series. I plan to follow
up this series with perf fixes if the tests point to issues once they're
up and running.

Special thanks to Stan who took a stab at rebasing the TX implementation
on top of the netmem/net_iov framework merged. Parts of his proposal [2]
that are reused as-is are forked off into their own patches to give full
credit.

[1] https://lore.kernel.org/netdev/20240909054318.1809580-1-almasrymina@google.com/
[2] https://lore.kernel.org/netdev/20240913150913.1280238-2-sdf@fomichev.me/T/#m066dd407fbed108828e2c40ae50e3f4376ef57fd

Cc: sdf@fomichev.me
Cc: asml.silence@gmail.com
Cc: dw@davidwei.uk
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>
Cc: Samiullah Khawaja <skhawaja@google.com>


Mina Almasry (8):
  net: add get_netmem/put_netmem support
  net: devmem: Implement TX path
  net: devmem: make dmabuf unbinding scheduled work
  net: add devmem TCP TX documentation
  net: enable driver support for netmem TX
  gve: add netmem TX support to GVE DQO-RDA mode
  net: check for driver support in netmem TX
  selftests: ncdevmem: Implement devmem TCP TX

Stanislav Fomichev (1):
  net: devmem: TCP tx netlink api

 Documentation/netlink/specs/netdev.yaml       |  12 +
 Documentation/networking/devmem.rst           | 150 ++++++++-
 .../networking/net_cachelines/net_device.rst  |   1 +
 Documentation/networking/netdev-features.rst  |   5 +
 Documentation/networking/netmem.rst           |  14 +-
 drivers/net/ethernet/google/gve/gve_main.c    |   4 +
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |   8 +-
 include/linux/netdevice.h                     |   2 +
 include/linux/skbuff.h                        |  17 +-
 include/linux/skbuff_ref.h                    |   4 +-
 include/net/netmem.h                          |  23 ++
 include/net/sock.h                            |   1 +
 include/uapi/linux/netdev.h                   |   1 +
 net/core/datagram.c                           |  48 ++-
 net/core/dev.c                                |   3 +
 net/core/devmem.c                             | 114 ++++++-
 net/core/devmem.h                             |  69 +++-
 net/core/netdev-genl-gen.c                    |  13 +
 net/core/netdev-genl-gen.h                    |   1 +
 net/core/netdev-genl.c                        |  73 ++++-
 net/core/skbuff.c                             |  48 ++-
 net/core/sock.c                               |   6 +
 net/ipv4/ip_output.c                          |   3 +-
 net/ipv4/tcp.c                                |  46 ++-
 net/ipv6/ip6_output.c                         |   3 +-
 net/vmw_vsock/virtio_transport_common.c       |   5 +-
 tools/include/uapi/linux/netdev.h             |   1 +
 .../selftests/drivers/net/hw/devmem.py        |  28 +-
 .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
 29 files changed, 931 insertions(+), 72 deletions(-)

-- 
2.48.1.601.g30ceb7b040-goog


