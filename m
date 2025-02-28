Return-Path: <linux-kselftest+bounces-27905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E611A49BFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 15:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469B61757E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A30E2702A2;
	Fri, 28 Feb 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGIA2nfy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85125F984
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752776; cv=none; b=N3GUcgWEba1FL90PEiaCxa8AkydxnyPUxE6YTY6a+3XPcgspxPZfToRwxHVB1EyxC54OhYTs/rotJYoloqsqmjPGIr6bgVEkV5+9wkKlZAl37eiJbQd14Si3sSBTeQ9bUrksys8LDQiFHj2kJuw5ad/ByoxEL4CDgWAFom7ZdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752776; c=relaxed/simple;
	bh=ZrrKLGsH5gMFEQNvKUqdIRd0RgUyxmGgBynh9J5KInw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHlxNoS9QIAHvXL2REU5qODI/mFjWyB8h5gh1Ym8mfSxX508BB2m9zateRbTcG5poq+Of2iJbdeGdo4PicMB3InN/FTg4HeXxCcBLPzm6iNom2bXh4KoAfaKjpJv/aapeRRKYwBzjha8bYV16DseMnlbu9keFxWk8qIGQRmhYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGIA2nfy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740752771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41YK/Fa93yH7WRyOoYN61ZIrQtcUxBsRdCYHbyJzOHk=;
	b=IGIA2nfyHeNh8T0eDgKcpsQAZ0fcCxI59MYo9lS9JvLNXe/sk1GxaIQAtCps9zHyPwBA/p
	6GxftEiY+/ERFKNnzJwKqE//D3m+3/dC/yzdefdDBiJ5jXTKRzydUAJpUzEF9u/5qzw20Q
	Cd1CU+ecTiRb8RwkWHThYSHkgSDakq4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-_0hWNkTnNuiQ7wPJtritPQ-1; Fri, 28 Feb 2025 09:26:10 -0500
X-MC-Unique: _0hWNkTnNuiQ7wPJtritPQ-1
X-Mimecast-MFC-AGG-ID: _0hWNkTnNuiQ7wPJtritPQ_1740752769
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab39f65dc10so227151066b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 06:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740752769; x=1741357569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41YK/Fa93yH7WRyOoYN61ZIrQtcUxBsRdCYHbyJzOHk=;
        b=HNPsqJbp0B7TaHm0MtjAtse9Q1HkC2iSuygjMVQkSUKJJPTcCMJRrk3Uq+L352TQhi
         4QJ0LwUowzdS/tJi72bEVrLldvtd/9eSIDwdvnnOa73gdI98NU+VLzvRdK3uG94bMku5
         6KySLWt4FK4R8TrL4loEhEHSbPLQAgcZVtYyblmwZrvJJgLU0LVp2dC9NF1VGAbZg1Lj
         +hvwoOOt87B4LUmpTZOFMKD6r3kn4Dkq33XeFkyonTzbQrRNB+U5gM4S2uYkeF++xycg
         JoPxh7OsShvXNPnRVVtv/kVCiL4bNqUBe29Ubolutuzr0IJtp2cZrfOkVPKVT3rQkRty
         olAA==
X-Forwarded-Encrypted: i=1; AJvYcCUi50kwS0HL68srH2ojYMFKdqSBwoO9rR8y02aCc0a8LswAWuedHaZhF0ZTTV9SSiFeHDyXxkHFcLqT8m4W7N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWTYDL/6yaHMOU1EDAeEwB2nDCJWULnfCvRoYBzAjX0G9myQn
	d+MQpuh64FoZFOAk0P/DKv7ntORHxHjqfAUfPXLKyrWi6FyD4cfZTKW4hncGOxvEoEYubQHJldY
	sO8kW5ynz1qXl1qEVm968fBmA64yJ/4+45tj1bDfnEIrIzR/l55SAiK3IQxHU6tXiDDUXnrfoSj
	I64B6UToRiAGuyd+/JPADbCFvkjPZfXtBXB2JRavL0
X-Gm-Gg: ASbGncvKRKXK8O49IwOXyeZf6znM7Q+gXsLlKGxeGKRL/ezXjkdNTR4lGDMGvtAPiQq
	QcZtnUwjK8iyqHWK0y/sDrvYmVG7hSKZkJQODbEoD/OLkvNzDZFmZDVnSP8Yv6iE4B9kZTzEDrg
	==
X-Received: by 2002:a17:907:98b:b0:ab7:e47c:b54a with SMTP id a640c23a62f3a-abf268228a5mr413409966b.37.1740752768876;
        Fri, 28 Feb 2025 06:26:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFpT+ykpXihddLwZKH4O92h96tSGJga9CaU/UUNcYwAnblX7Ug+Sy1iNG8RRYaXgdCkAh2VWhiCNg1deaC5wk=
X-Received: by 2002:a17:907:98b:b0:ab7:e47c:b54a with SMTP id
 a640c23a62f3a-abf268228a5mr413404166b.37.1740752768319; Fri, 28 Feb 2025
 06:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
In-Reply-To: <20250227041209.2031104-1-almasrymina@google.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 28 Feb 2025 22:25:30 +0800
X-Gm-Features: AQ5f1JqVhDb-cZIWt74rFAUUwiHQfWAkkWi2rweLejB6ipoz1DdzdbSrPZJ_seg
Message-ID: <CAPpAL=wzN2L_OOLG6b_D+pVvVnTu4N9X4knfgePtrtLMX7vQww@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/8] Device memory TCP TX
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I re-tested this series of patches v6 with virtio-net regression
tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Feb 27, 2025 at 12:13=E2=80=AFPM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> v6: https://lore.kernel.org/netdev/20250222191517.743530-1-almasrymina@go=
ogle.com/
> =3D=3D=3D
>
> v6 has no major changes. Addressed a few issues from Paolo and David,
> and collected Acks from Stan. Thank you everyone for the review!
>
> Changes:
> - retain behavior to process MSG_FASTOPEN even if the provided cmsg is
>   invalid (Paolo).
> - Rework the freeing of tx_vec slightly (it now has its own err label).
>   (Paolo).
> - Squash the commit that makes dmabuf unbinding scheduled work into the
>   same one which implements the TX path so we don't run into future
>   errors on bisecting (Paolo).
> - Fix/add comments to explain how dmabuf binding refcounting works
>   (David).
>
> v5: https://lore.kernel.org/netdev/20250220020914.895431-1-almasrymina@go=
ogle.com/
> =3D=3D=3D
>
> v5 has no major changes; it clears up the relatively minor issues
> pointed out to in v4, and rebases the series on top of net-next to
> resolve the conflict with a patch that raced to the tree. It also
> collects the review tags from v4.
>
> Changes:
> - Rebase to net-next
> - Fix issues in selftest (Stan).
> - Address comments in the devmem and netmem driver docs (Stan and Bagas)
> - Fix zerocopy_fill_skb_from_devmem return error code (Stan).
>
> v4: https://lore.kernel.org/netdev/20250203223916.1064540-1-almasrymina@g=
oogle.com/
> =3D=3D=3D
>
> v4 mainly addresses the critical driver support issue surfaced in v3 by
> Paolo and Stan. Drivers aiming to support netmem_tx should make sure not
> to pass the netmem dma-addrs to the dma-mapping APIs, as these dma-addrs
> may come from dma-bufs.
>
> Additionally other feedback from v3 is addressed.
>
> Major changes:
> - Add helpers to handle netmem dma-addrs. Add GVE support for
>   netmem_tx.
> - Fix binding->tx_vec not being freed on error paths during the
>   tx binding.
> - Add a minimal devmem_tx test to devmem.py.
> - Clean up everything obsolete from the cover letter (Paolo).
>
> v3: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D929401&=
state=3D*
> =3D=3D=3D
>
> Address minor comments from RFCv2 and fix a few build warnings and
> ynl-regen issues. No major changes.
>
> RFC v2: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D920=
056&state=3D*
> =3D=3D=3D=3D=3D=3D=3D
>
> RFC v2 addresses much of the feedback from RFC v1. I plan on sending
> something close to this as net-next  reopens, sending it slightly early
> to get feedback if any.
>
> Major changes:
> --------------
>
> - much improved UAPI as suggested by Stan. We now interpret the iov_base
>   of the passed in iov from userspace as the offset into the dmabuf to
>   send from. This removes the need to set iov.iov_base =3D NULL which may
>   be confusing to users, and enables us to send multiple iovs in the
>   same sendmsg() call. ncdevmem and the docs show a sample use of that.
>
> - Removed the duplicate dmabuf iov_iter in binding->iov_iter. I think
>   this is good improvment as it was confusing to keep track of
>   2 iterators for the same sendmsg, and mistracking both iterators
>   caused a couple of bugs reported in the last iteration that are now
>   resolved with this streamlining.
>
> - Improved test coverage in ncdevmem. Now multiple sendmsg() are tested,
>   and sending multiple iovs in the same sendmsg() is tested.
>
> - Fixed issue where dmabuf unmapping was happening in invalid context
>   (Stan).
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The TX path had been dropped from the Device Memory TCP patch series
> post RFCv1 [1], to make that series slightly easier to review. This
> series rebases the implementation of the TX path on top of the
> net_iov/netmem framework agreed upon and merged. The motivation for
> the feature is thoroughly described in the docs & cover letter of the
> original proposal, so I don't repeat the lengthy descriptions here, but
> they are available in [1].
>
> Full outline on usage of the TX path is detailed in the documentation
> included with this series.
>
> Test example is available via the kselftest included in the series as wel=
l.
>
> The series is relatively small, as the TX path for this feature largely
> piggybacks on the existing MSG_ZEROCOPY implementation.
>
> Patch Overview:
> ---------------
>
> 1. Documentation & tests to give high level overview of the feature
>    being added.
>
> 1. Add netmem refcounting needed for the TX path.
>
> 2. Devmem TX netlink API.
>
> 3. Devmem TX net stack implementation.
>
> 4. Make dma-buf unbinding scheduled work to handle TX cases where it gets
>    freed from contexts where we can't sleep.
>
> 5. Add devmem TX documentation.
>
> 6. Add scaffolding enabling driver support for netmem_tx. Add helpers, dr=
iver
> feature flag, and docs to enable drivers to declare netmem_tx support.
>
> 7. Guard netmem_tx against being enabled against drivers that don't
>    support it.
>
> 8. Add devmem_tx selftests. Add TX path to ncdevmem and add a test to
>    devmem.py.
>
> Testing:
> --------
>
> Testing is very similar to devmem TCP RX path. The ncdevmem test used
> for the RX path is now augemented with client functionality to test TX
> path.
>
> * Test Setup:
>
> Kernel: net-next with this RFC and memory provider API cherry-picked
> locally.
>
> Hardware: Google Cloud A3 VMs.
>
> NIC: GVE with header split & RSS & flow steering support.
>
> Performance results are not included with this version, unfortunately.
> I'm having issues running the dma-buf exporter driver against the
> upstream kernel on my test setup. The issues are specific to that
> dma-buf exporter and do not affect this patch series. I plan to follow
> up this series with perf fixes if the tests point to issues once they're
> up and running.
>
> Special thanks to Stan who took a stab at rebasing the TX implementation
> on top of the netmem/net_iov framework merged. Parts of his proposal [2]
> that are reused as-is are forked off into their own patches to give full
> credit.
>
> [1] https://lore.kernel.org/netdev/20240909054318.1809580-1-almasrymina@g=
oogle.com/
> [2] https://lore.kernel.org/netdev/20240913150913.1280238-2-sdf@fomichev.=
me/T/#m066dd407fbed108828e2c40ae50e3f4376ef57fd
>
> Cc: sdf@fomichev.me
> Cc: asml.silence@gmail.com
> Cc: dw@davidwei.uk
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Victor Nogueira <victor@mojatatu.com>
> Cc: Pedro Tammela <pctammela@mojatatu.com>
> Cc: Samiullah Khawaja <skhawaja@google.com>
>
>
> Mina Almasry (7):
>   net: add get_netmem/put_netmem support
>   net: devmem: Implement TX path
>   net: add devmem TCP TX documentation
>   net: enable driver support for netmem TX
>   gve: add netmem TX support to GVE DQO-RDA mode
>   net: check for driver support in netmem TX
>   selftests: ncdevmem: Implement devmem TCP TX
>
> Stanislav Fomichev (1):
>   net: devmem: TCP tx netlink api
>
>  Documentation/netlink/specs/netdev.yaml       |  12 +
>  Documentation/networking/devmem.rst           | 150 ++++++++-
>  .../networking/net_cachelines/net_device.rst  |   1 +
>  Documentation/networking/netdev-features.rst  |   5 +
>  Documentation/networking/netmem.rst           |  23 +-
>  drivers/net/ethernet/google/gve/gve_main.c    |   4 +
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c  |   8 +-
>  include/linux/netdevice.h                     |   2 +
>  include/linux/skbuff.h                        |  17 +-
>  include/linux/skbuff_ref.h                    |   4 +-
>  include/net/netmem.h                          |  23 ++
>  include/net/sock.h                            |   1 +
>  include/uapi/linux/netdev.h                   |   1 +
>  net/core/datagram.c                           |  48 ++-
>  net/core/dev.c                                |   3 +
>  net/core/devmem.c                             | 115 ++++++-
>  net/core/devmem.h                             |  77 ++++-
>  net/core/netdev-genl-gen.c                    |  13 +
>  net/core/netdev-genl-gen.h                    |   1 +
>  net/core/netdev-genl.c                        |  73 ++++-
>  net/core/skbuff.c                             |  48 ++-
>  net/core/sock.c                               |   6 +
>  net/ipv4/ip_output.c                          |   3 +-
>  net/ipv4/tcp.c                                |  50 ++-
>  net/ipv6/ip6_output.c                         |   3 +-
>  net/vmw_vsock/virtio_transport_common.c       |   5 +-
>  tools/include/uapi/linux/netdev.h             |   1 +
>  .../selftests/drivers/net/hw/devmem.py        |  26 +-
>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
>  29 files changed, 950 insertions(+), 73 deletions(-)
>
>
> base-commit: 80c4a0015ce249cf0917a04dbb3cc652a6811079
> --
> 2.48.1.658.g4767266eb4-goog
>
>


