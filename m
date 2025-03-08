Return-Path: <linux-kselftest+bounces-28544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC2DA57EB9
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 22:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610993AB41C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E069C207A10;
	Sat,  8 Mar 2025 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kj2Q0edP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E614B96E
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Mar 2025 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741470049; cv=none; b=VEzSt0vrkGDuDq1Lc2tA3/711aVtOWegPnRkoEJT1rh78kQXwt9jDHAA/+PY5wo85rkasHCX0gdFmvcgSz/0qDTX/XWAwzwlVRZdNCFtMW62/KOja4iobzjRvWoat/0rjlCQhDuvFYv42ZsByDR4hfMCe0uspCn6Ct6Mi2SCTWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741470049; c=relaxed/simple;
	bh=MnpbY3lPqTN3N+f7uEQ/uYZPGYKjCFw9VN42wnPfzVw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FeKEGJUDZAn/UHOikwwIwSa/Wem0nGMKJaZTMkEFz6osJzCKYjPVy/PjLRgueGQCWhh6+ymsWt2ZuBVHD/k+X/TiwyBkBczx35KRTbt6E5e2S8U0NTuJWDUGmwo8U+5NCL14kCt6l9NQJ/ElX5Cbi2D3XTQuKc3jdLbHU7xev0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kj2Q0edP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224191d9228so59496945ad.3
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Mar 2025 13:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741470047; x=1742074847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uIjATFDnbxEoYc4bYwSfSu05Xu1erFBYh/t5wdETKQQ=;
        b=kj2Q0edPbtmgKs2XHCYIlGQkKinMMLsDDzXG0P2MGNHVGW+5jOervYoO8XSEQlpucZ
         dukNCcUEPBSVmmJ+Vq4NQTEUuOWWXhlwHyKssdAAALBZ/9fpNLMhUCJL/tbnn3SqS2o2
         pRJUkCNKp9WrnvwTOjziFKSJqmomvrjR0dRu72FOPwF94TPCe5wLSrSj/Tx8COvyvBnb
         jYeYEJSOUgxJxftQlCYnX6dFLv116+3FAIjWG1twYnVKZS5M6Y6PRyqplC5/sEWazsEY
         U67tbUOAaB85gEVRGCJJObBj6NodogQSA7SYkFddQ+lf3mvy5iQ83m/Hm45JYGukVHpD
         mA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741470047; x=1742074847;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uIjATFDnbxEoYc4bYwSfSu05Xu1erFBYh/t5wdETKQQ=;
        b=v7sr/FZ8dT400ynnpG2rpaYT8ATcznDOLPlCYCJhGz92KVFl4Up5dEdk5zkeoY/vOQ
         GZKTz+qCkkBAWNgrWP9nYYWG1o79gyi2UUaP27CKODHeVfUzF0g/SHH4qj65VsMmm1qi
         sChXucv9tfydLOiBshDh2QBNfyxmW1ojKKBzxz1g1RAnNLQi+KIubXYPjHIKthmuQTse
         G6lHIeu3Hk3mKnb2muPgKHqa5kh3XDltzOPBXGxqIIL2KHFmh3gEDA2EU9In8fP5fx3O
         GtzFVuIddBPkvekpld6y4V2DBCSLANgjVic5KIriCTaETNf5pBtwnoCc07TbBPVdVWdm
         ZjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzrhmtgSDsIpl5wUWKF5y8D7VFrWpFXwx1XajFIoVn56KVSGO1hTBkqa1YZTKKgIE2tr+RR5Y3xz6I+euWU0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBgu3hTW91QS0kZASNXyIzD7X2gwoaER4uAgUuQKimi9PLdBFc
	Xb+YSFd7Y8uXb7mGnhofEWR2LcXEvU/0jEm9+nx4/Lv5Ydk83czJo3mUP4aAHcTGZgEazWAcNaC
	YKoc5USCrAxnShYNzcSrdiA==
X-Google-Smtp-Source: AGHT+IHkkJOaYv2HGCEzIrvtooW3L04AMRAiYxB2URyJ2E16APOy6jFlUW/An/cuiAToF+V+1Z5ix8knXmujTvv0Zg==
X-Received: from plbld3.prod.google.com ([2002:a17:902:fac3:b0:220:e7dc:350d])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e543:b0:223:28a8:6101 with SMTP id d9443c01a7336-22428a9fe42mr101910595ad.29.1741470047048;
 Sat, 08 Mar 2025 13:40:47 -0800 (PST)
Date: Sat,  8 Mar 2025 21:40:36 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308214045.1160445-1-almasrymina@google.com>
Subject: [PATCH net-next v7 0/9] Device memory TCP TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

v7: https://lore.kernel.org/netdev/20250227041209.2031104-1-almasrymina@google.com/
===

Changelog:
- Check the dmabuf net_iov binding belongs to the device the TX is going
  out on. (Jakub)
- Provide detailed inspection of callsites of
  __skb_frag_ref/skb_page_unref in patch 2's changelog (Jakub)

v6: https://lore.kernel.org/netdev/20250222191517.743530-1-almasrymina@google.com/
===

v6 has no major changes. Addressed a few issues from Paolo and David,
and collected Acks from Stan. Thank you everyone for the review!

Changes:
- retain behavior to process MSG_FASTOPEN even if the provided cmsg is
  invalid (Paolo).
- Rework the freeing of tx_vec slightly (it now has its own err label).
  (Paolo).
- Squash the commit that makes dmabuf unbinding scheduled work into the
  same one which implements the TX path so we don't run into future
  errors on bisecting (Paolo).
- Fix/add comments to explain how dmabuf binding refcounting works
  (David).

v5: https://lore.kernel.org/netdev/20250220020914.895431-1-almasrymina@google.com/
===

v5 has no major changes; it clears up the relatively minor issues
pointed out to in v4, and rebases the series on top of net-next to
resolve the conflict with a patch that raced to the tree. It also
collects the review tags from v4.

Changes:
- Rebase to net-next
- Fix issues in selftest (Stan).
- Address comments in the devmem and netmem driver docs (Stan and Bagas)
- Fix zerocopy_fill_skb_from_devmem return error code (Stan).

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
  netmem: add niov->type attribute to distinguish different net_iov
    types
  net: add get_netmem/put_netmem support
  net: devmem: Implement TX path
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
 Documentation/networking/netmem.rst           |  23 +-
 drivers/net/ethernet/google/gve/gve_main.c    |   4 +
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |   8 +-
 include/linux/netdevice.h                     |   2 +
 include/linux/skbuff.h                        |  17 +-
 include/linux/skbuff_ref.h                    |   4 +-
 include/net/netmem.h                          |  38 ++-
 include/net/sock.h                            |   1 +
 include/uapi/linux/netdev.h                   |   1 +
 net/core/datagram.c                           |  48 ++-
 net/core/dev.c                                |  33 ++
 net/core/devmem.c                             | 118 ++++++-
 net/core/devmem.h                             |  83 ++++-
 net/core/netdev-genl-gen.c                    |  13 +
 net/core/netdev-genl-gen.h                    |   1 +
 net/core/netdev-genl.c                        |  73 ++++-
 net/core/skbuff.c                             |  48 ++-
 net/core/sock.c                               |   6 +
 net/ipv4/ip_output.c                          |   3 +-
 net/ipv4/tcp.c                                |  50 ++-
 net/ipv6/ip6_output.c                         |   3 +-
 net/vmw_vsock/virtio_transport_common.c       |   5 +-
 tools/include/uapi/linux/netdev.h             |   1 +
 .../selftests/drivers/net/hw/devmem.py        |  26 +-
 .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
 29 files changed, 1002 insertions(+), 75 deletions(-)


base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


