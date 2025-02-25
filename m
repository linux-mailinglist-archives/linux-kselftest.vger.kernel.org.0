Return-Path: <linux-kselftest+bounces-27404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC63A4334E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F973AAE18
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 02:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA014387B;
	Tue, 25 Feb 2025 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGV4sZEu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193B4BE65
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740452073; cv=none; b=cINUkaKAU+7xNhGzNRYsm3Dpg245uuQh+Jt7gf4FP2++xzr/3l3RHHBwOVxZ66kCAkEuiCD4IFFJtjsMus0e1GG0qaeezx0NWMEZm6DZ8qSZSs4VD6Tf49VAMwjQMhjxrqqDj7kj0lw+UdEizVobOiIL0i2eB/VBkJ6J7IQN9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740452073; c=relaxed/simple;
	bh=OWB1dt1gqCHro9D/sAJNl4JqN5R1Ps1ZVmSdsJAZ2Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djfj2rRSEKfkFN+pTXeVqh+cySA0veMhj1Wi9qHsUN2yAz16zuRQ/T0hg6OGbacoOB6ziyc3DwEWVKQdtoygmCdpxG5eiwrlNhMJsXIR7Lnm8KXS+VsIbTk+5ZK2P06359J7nCOv8MnHj87NybMkZiYy185vtiFN4KYIqIB6PMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGV4sZEu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740452070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A5rC/LF/T1Uu8wfDeqM19j6PrveBf7IFJyzhm7V9FYE=;
	b=DGV4sZEu2u4iyh0aE2tGPZ/SplggLbJ51vZfNYHMoE42LhecsDLFj2YJQnIaZZWCeLtpxc
	tnlY18unlzYp5ohkqJYQz9Rv1HTjAdT7ga4MnxcSsAhnSGC/1lxl5S6Ncl7iGN+7WeTJvD
	4qBQ1CLll/bgqyJSoJtfWO+ei+Kj770=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-Kl-S5KqAOOG5TeOYQgHJew-1; Mon, 24 Feb 2025 21:54:28 -0500
X-MC-Unique: Kl-S5KqAOOG5TeOYQgHJew-1
X-Mimecast-MFC-AGG-ID: Kl-S5KqAOOG5TeOYQgHJew_1740452067
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e08a9627d0so5642139a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 18:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740452067; x=1741056867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5rC/LF/T1Uu8wfDeqM19j6PrveBf7IFJyzhm7V9FYE=;
        b=Qvi1v9Yf93L1NUR9QA+S4VRfK8yorCOpqV/U3tKo8kfOR7NUyfUPJZyxuvtgFYnQiq
         JEyR3ue7NkcS46QM9VHx0vxZDEccTB9EG6iGIfcPuDJK//KVOEBzIIvEnPj0mTCCwxC1
         2W19ZEPhpH0T8wuLbvlnbLVg+8/dKO36PNsycSDo8/MWETHMMbY9EcnvSV8mwSKw3oFX
         ot6rLfkRC+VpozZRtjLp2dK0lo67Dj4cqXdX/rNtTHwlidqpUUCMh3rZ60e/x+CE6VZD
         +fXsXMgL/jg2KLJJdmUAiPXT28kyLRashINK6vALoiCVWy5qEaR5FHCAwRwuXpqISVzx
         4rnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtRT0N3ll9bd8Th2di+dh3polCjB6kMgV3laj4URmbqi5I1wIfZha7gTjJiQtv5iBjgkeXgHT9K1+alkygAvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/E7Bud86txyizJSKr7oJJzAGOSjBzvDpTaiAlH1ptN4kchif
	LU3sha4Z8Tp2FiD/4lO+juMHLMXgRsHRGJa7jfhtx6JQxnYLn+fniKXzKNIonDLJJZ/4sVYK7qJ
	GxGC6YbRVi7loc0tjQjvjgM6uCWUbrcq41vwRpjczLptL8jKSDeGo6rPkvw5Au3P6fKDYEsvC05
	BKVgnD8uwJI3ZQ6Aui959D7QJS7xX96IsO31QB4Dgr
X-Gm-Gg: ASbGncsyWhJFMWD9GssKTLAI0SwkPd/fshyJBskxrwMuHQdnM3k+xU5ohg9b+oDJ6Kz
	SlKATeR7YBQaXqwz0oH4oTK8lRAkpe8nTlPHKj5zqn2xd44bp9weBZGQlPfrFSnoYcVnHdFadpQ
	==
X-Received: by 2002:a05:6402:3483:b0:5e0:4c2d:b81c with SMTP id 4fb4d7f45d1cf-5e44ba4022cmr1228313a12.31.1740452066755;
        Mon, 24 Feb 2025 18:54:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVOXADqL/gQRIYIX/z/HD+6zI8/JpzlQ43Tr6Axpk7z44oBjzYCHMP44EKbLocdDt9j7YAgiN2XI455MOH0WY=
X-Received: by 2002:a05:6402:3483:b0:5e0:4c2d:b81c with SMTP id
 4fb4d7f45d1cf-5e44ba4022cmr1228293a12.31.1740452066323; Mon, 24 Feb 2025
 18:54:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
In-Reply-To: <20250222191517.743530-1-almasrymina@google.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 25 Feb 2025 10:53:48 +0800
X-Gm-Features: AQ5f1Jq3r3lVEIF3rwikdNMfDLoDfCfMEh04H5AdTGtacuXS5Ty26yvkBW5M0MA
Message-ID: <CAPpAL=xvVYmiekEkQZO314JczbNK3kf_2Sw=15crgjQLfzQU4w@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/9] Device memory TCP TX
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: multipart/mixed; boundary="00000000000029bd74062eee930a"

--00000000000029bd74062eee930a
Content-Type: multipart/alternative; boundary="00000000000029bd72062eee9308"

--00000000000029bd72062eee9308
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mina

I'd like to test this series of patches because these changes are
network-related. But there was some conflict when I tried to apply this
feature. Could you please help review it.
The latest commit id which I tested is following:
# git log
commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6 (HEAD -> master, tag:
v6.14-rc4, origin/master, origin/HEAD)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Feb 23 12:32:57 2025 -0800

    Linux 6.14-rc4

About conflict content please review attachment.

Thanks
Lei


On Sun, Feb 23, 2025 at 3:15=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:

> v5:
> https://lore.kernel.org/netdev/20250220020914.895431-1-almasrymina@google=
.com/
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
> v4:
> https://lore.kernel.org/netdev/20250203223916.1064540-1-almasrymina@googl=
e.com/
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
> v3:
> https://patchwork.kernel.org/project/netdevbpf/list/?series=3D929401&stat=
e=3D*
> =3D=3D=3D
>
> Address minor comments from RFCv2 and fix a few build warnings and
> ynl-regen issues. No major changes.
>
> RFC v2:
> https://patchwork.kernel.org/project/netdevbpf/list/?series=3D920056&stat=
e=3D*
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
> 6. Add scaffolding enabling driver support for netmem_tx. Add helpers,
> driver
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
> [1]
> https://lore.kernel.org/netdev/20240909054318.1809580-1-almasrymina@googl=
e.com/
> [2]
> https://lore.kernel.org/netdev/20240913150913.1280238-2-sdf@fomichev.me/T=
/#m066dd407fbed108828e2c40ae50e3f4376ef57fd
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
> Mina Almasry (8):
>   net: add get_netmem/put_netmem support
>   net: devmem: Implement TX path
>   net: devmem: make dmabuf unbinding scheduled work
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
>  net/core/devmem.c                             | 113 ++++++-
>  net/core/devmem.h                             |  69 +++-
>  net/core/netdev-genl-gen.c                    |  13 +
>  net/core/netdev-genl-gen.h                    |   1 +
>  net/core/netdev-genl.c                        |  73 ++++-
>  net/core/skbuff.c                             |  48 ++-
>  net/core/sock.c                               |   6 +
>  net/ipv4/ip_output.c                          |   3 +-
>  net/ipv4/tcp.c                                |  46 ++-
>  net/ipv6/ip6_output.c                         |   3 +-
>  net/vmw_vsock/virtio_transport_common.c       |   5 +-
>  tools/include/uapi/linux/netdev.h             |   1 +
>  .../selftests/drivers/net/hw/devmem.py        |  26 +-
>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
>  29 files changed, 938 insertions(+), 71 deletions(-)
>
>
> base-commit: b66e19dcf684b21b6d3a1844807bd1df97ad197a
> --
> 2.48.1.601.g30ceb7b040-goog
>
>
>

--00000000000029bd72062eee9308
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mina<br><br>I&#39;d like to test this series of patches=
 because these changes are network-related. But there was some conflict whe=
n I tried to apply this feature. Could you please help review it.<br>The la=
test commit id which I tested is following:<br># git log<br>commit d082ecbc=
71e9e0bf49883ee4afd435a77a5101b6 (HEAD -&gt; master, tag: v6.14-rc4, origin=
/master, origin/HEAD)<br>Author: Linus Torvalds &lt;<a href=3D"mailto:torva=
lds@linux-foundation.org">torvalds@linux-foundation.org</a>&gt;<br>Date: =
=C2=A0 Sun Feb 23 12:32:57 2025 -0800<br><br>=C2=A0 =C2=A0 Linux 6.14-rc4<b=
r><div><br></div><div>About conflict content please review attachment.=C2=
=A0</div><div><br></div><div>Thanks<br>Lei</div></div><br><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Sun, Feb 23, 2025 at 3:15=E2=80=AFAM Mina Almasry &lt;<a href=3D"mailto:a=
lmasrymina@google.com">almasrymina@google.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">v5: <a href=3D"https://lore.ke=
rnel.org/netdev/20250220020914.895431-1-almasrymina@google.com/" rel=3D"nor=
eferrer" target=3D"_blank">https://lore.kernel.org/netdev/20250220020914.89=
5431-1-almasrymina@google.com/</a><br>
=3D=3D=3D<br>
<br>
v5 has no major changes; it clears up the relatively minor issues<br>
pointed out to in v4, and rebases the series on top of net-next to<br>
resolve the conflict with a patch that raced to the tree. It also<br>
collects the review tags from v4.<br>
<br>
Changes:<br>
- Rebase to net-next<br>
- Fix issues in selftest (Stan).<br>
- Address comments in the devmem and netmem driver docs (Stan and Bagas)<br=
>
- Fix zerocopy_fill_skb_from_devmem return error code (Stan).<br>
<br>
v4: <a href=3D"https://lore.kernel.org/netdev/20250203223916.1064540-1-alma=
srymina@google.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kern=
el.org/netdev/20250203223916.1064540-1-almasrymina@google.com/</a><br>
=3D=3D=3D<br>
<br>
v4 mainly addresses the critical driver support issue surfaced in v3 by<br>
Paolo and Stan. Drivers aiming to support netmem_tx should make sure not<br=
>
to pass the netmem dma-addrs to the dma-mapping APIs, as these dma-addrs<br=
>
may come from dma-bufs.<br>
<br>
Additionally other feedback from v3 is addressed.<br>
<br>
Major changes:<br>
- Add helpers to handle netmem dma-addrs. Add GVE support for<br>
=C2=A0 netmem_tx.<br>
- Fix binding-&gt;tx_vec not being freed on error paths during the<br>
=C2=A0 tx binding.<br>
- Add a minimal devmem_tx test to devmem.py.<br>
- Clean up everything obsolete from the cover letter (Paolo).<br>
<br>
v3: <a href=3D"https://patchwork.kernel.org/project/netdevbpf/list/?series=
=3D929401&amp;state=3D*" rel=3D"noreferrer" target=3D"_blank">https://patch=
work.kernel.org/project/netdevbpf/list/?series=3D929401&amp;state=3D*</a><b=
r>
=3D=3D=3D<br>
<br>
Address minor comments from RFCv2 and fix a few build warnings and<br>
ynl-regen issues. No major changes.<br>
<br>
RFC v2: <a href=3D"https://patchwork.kernel.org/project/netdevbpf/list/?ser=
ies=3D920056&amp;state=3D*" rel=3D"noreferrer" target=3D"_blank">https://pa=
tchwork.kernel.org/project/netdevbpf/list/?series=3D920056&amp;state=3D*</a=
><br>
=3D=3D=3D=3D=3D=3D=3D<br>
<br>
RFC v2 addresses much of the feedback from RFC v1. I plan on sending<br>
something close to this as net-next=C2=A0 reopens, sending it slightly earl=
y<br>
to get feedback if any.<br>
<br>
Major changes:<br>
--------------<br>
<br>
- much improved UAPI as suggested by Stan. We now interpret the iov_base<br=
>
=C2=A0 of the passed in iov from userspace as the offset into the dmabuf to=
<br>
=C2=A0 send from. This removes the need to set iov.iov_base =3D NULL which =
may<br>
=C2=A0 be confusing to users, and enables us to send multiple iovs in the<b=
r>
=C2=A0 same sendmsg() call. ncdevmem and the docs show a sample use of that=
.<br>
<br>
- Removed the duplicate dmabuf iov_iter in binding-&gt;iov_iter. I think<br=
>
=C2=A0 this is good improvment as it was confusing to keep track of<br>
=C2=A0 2 iterators for the same sendmsg, and mistracking both iterators<br>
=C2=A0 caused a couple of bugs reported in the last iteration that are now<=
br>
=C2=A0 resolved with this streamlining.<br>
<br>
- Improved test coverage in ncdevmem. Now multiple sendmsg() are tested,<br=
>
=C2=A0 and sending multiple iovs in the same sendmsg() is tested.<br>
<br>
- Fixed issue where dmabuf unmapping was happening in invalid context<br>
=C2=A0 (Stan).<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
The TX path had been dropped from the Device Memory TCP patch series<br>
post RFCv1 [1], to make that series slightly easier to review. This<br>
series rebases the implementation of the TX path on top of the<br>
net_iov/netmem framework agreed upon and merged. The motivation for<br>
the feature is thoroughly described in the docs &amp; cover letter of the<b=
r>
original proposal, so I don&#39;t repeat the lengthy descriptions here, but=
<br>
they are available in [1].<br>
<br>
Full outline on usage of the TX path is detailed in the documentation<br>
included with this series.<br>
<br>
Test example is available via the kselftest included in the series as well.=
<br>
<br>
The series is relatively small, as the TX path for this feature largely<br>
piggybacks on the existing MSG_ZEROCOPY implementation.<br>
<br>
Patch Overview:<br>
---------------<br>
<br>
1. Documentation &amp; tests to give high level overview of the feature<br>
=C2=A0 =C2=A0being added.<br>
<br>
1. Add netmem refcounting needed for the TX path.<br>
<br>
2. Devmem TX netlink API.<br>
<br>
3. Devmem TX net stack implementation.<br>
<br>
4. Make dma-buf unbinding scheduled work to handle TX cases where it gets<b=
r>
=C2=A0 =C2=A0freed from contexts where we can&#39;t sleep.<br>
<br>
5. Add devmem TX documentation.<br>
<br>
6. Add scaffolding enabling driver support for netmem_tx. Add helpers, driv=
er<br>
feature flag, and docs to enable drivers to declare netmem_tx support.<br>
<br>
7. Guard netmem_tx against being enabled against drivers that don&#39;t<br>
=C2=A0 =C2=A0support it.<br>
<br>
8. Add devmem_tx selftests. Add TX path to ncdevmem and add a test to<br>
=C2=A0 =C2=A0devmem.py.<br>
<br>
Testing:<br>
--------<br>
<br>
Testing is very similar to devmem TCP RX path. The ncdevmem test used<br>
for the RX path is now augemented with client functionality to test TX<br>
path.<br>
<br>
* Test Setup:<br>
<br>
Kernel: net-next with this RFC and memory provider API cherry-picked<br>
locally.<br>
<br>
Hardware: Google Cloud A3 VMs.<br>
<br>
NIC: GVE with header split &amp; RSS &amp; flow steering support.<br>
<br>
Performance results are not included with this version, unfortunately.<br>
I&#39;m having issues running the dma-buf exporter driver against the<br>
upstream kernel on my test setup. The issues are specific to that<br>
dma-buf exporter and do not affect this patch series. I plan to follow<br>
up this series with perf fixes if the tests point to issues once they&#39;r=
e<br>
up and running.<br>
<br>
Special thanks to Stan who took a stab at rebasing the TX implementation<br=
>
on top of the netmem/net_iov framework merged. Parts of his proposal [2]<br=
>
that are reused as-is are forked off into their own patches to give full<br=
>
credit.<br>
<br>
[1] <a href=3D"https://lore.kernel.org/netdev/20240909054318.1809580-1-alma=
srymina@google.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kern=
el.org/netdev/20240909054318.1809580-1-almasrymina@google.com/</a><br>
[2] <a href=3D"https://lore.kernel.org/netdev/20240913150913.1280238-2-sdf@=
fomichev.me/T/#m066dd407fbed108828e2c40ae50e3f4376ef57fd" rel=3D"noreferrer=
" target=3D"_blank">https://lore.kernel.org/netdev/20240913150913.1280238-2=
-sdf@fomichev.me/T/#m066dd407fbed108828e2c40ae50e3f4376ef57fd</a><br>
<br>
Cc: <a href=3D"mailto:sdf@fomichev.me" target=3D"_blank">sdf@fomichev.me</a=
><br>
Cc: <a href=3D"mailto:asml.silence@gmail.com" target=3D"_blank">asml.silenc=
e@gmail.com</a><br>
Cc: <a href=3D"mailto:dw@davidwei.uk" target=3D"_blank">dw@davidwei.uk</a><=
br>
Cc: Jamal Hadi Salim &lt;<a href=3D"mailto:jhs@mojatatu.com" target=3D"_bla=
nk">jhs@mojatatu.com</a>&gt;<br>
Cc: Victor Nogueira &lt;<a href=3D"mailto:victor@mojatatu.com" target=3D"_b=
lank">victor@mojatatu.com</a>&gt;<br>
Cc: Pedro Tammela &lt;<a href=3D"mailto:pctammela@mojatatu.com" target=3D"_=
blank">pctammela@mojatatu.com</a>&gt;<br>
Cc: Samiullah Khawaja &lt;<a href=3D"mailto:skhawaja@google.com" target=3D"=
_blank">skhawaja@google.com</a>&gt;<br>
<br>
<br>
Mina Almasry (8):<br>
=C2=A0 net: add get_netmem/put_netmem support<br>
=C2=A0 net: devmem: Implement TX path<br>
=C2=A0 net: devmem: make dmabuf unbinding scheduled work<br>
=C2=A0 net: add devmem TCP TX documentation<br>
=C2=A0 net: enable driver support for netmem TX<br>
=C2=A0 gve: add netmem TX support to GVE DQO-RDA mode<br>
=C2=A0 net: check for driver support in netmem TX<br>
=C2=A0 selftests: ncdevmem: Implement devmem TCP TX<br>
<br>
Stanislav Fomichev (1):<br>
=C2=A0 net: devmem: TCP tx netlink api<br>
<br>
=C2=A0Documentation/netlink/specs/netdev.yaml=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 12 +<br>
=C2=A0Documentation/networking/devmem.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 150 ++++++++-<br>
=C2=A0.../networking/net_cachelines/net_device.rst=C2=A0 |=C2=A0 =C2=A01 +<=
br>
=C2=A0Documentation/networking/netdev-features.rst=C2=A0 |=C2=A0 =C2=A05 +<=
br>
=C2=A0Documentation/networking/netmem.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 23 +-<br>
=C2=A0drivers/net/ethernet/google/gve/gve_main.c=C2=A0 =C2=A0 |=C2=A0 =C2=
=A04 +<br>
=C2=A0drivers/net/ethernet/google/gve/gve_tx_dqo.c=C2=A0 |=C2=A0 =C2=A08 +-=
<br>
=C2=A0include/linux/netdevice.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0include/linux/skbuff.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 17 +-<br>
=C2=A0include/linux/skbuff_ref.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0include/net/netmem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 23 ++<br>
=C2=A0include/net/sock.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0include/uapi/linux/netdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0net/core/datagram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 48 ++-<br>
=C2=A0net/core/dev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<=
br>
=C2=A0net/core/devmem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 113 ++++++-<br>
=C2=A0net/core/devmem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 69 +++-<br>
=C2=A0net/core/netdev-genl-gen.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 13 +<br>
=C2=A0net/core/netdev-genl-gen.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0net/core/netdev-genl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 73 ++++-<br>
=C2=A0net/core/skbuff.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 48 ++-<br>
=C2=A0net/core/sock.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 =
+<br>
=C2=A0net/ipv4/ip_output.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0net/ipv4/tcp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 46 ++-<br>
=C2=A0net/ipv6/ip6_output.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
=C2=A0net/vmw_vsock/virtio_transport_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A05 +-<br>
=C2=A0tools/include/uapi/linux/netdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0.../selftests/drivers/net/hw/devmem.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 26 +-<br>
=C2=A0.../selftests/drivers/net/hw/ncdevmem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 3=
00 +++++++++++++++++-<br>
=C2=A029 files changed, 938 insertions(+), 71 deletions(-)<br>
<br>
<br>
base-commit: b66e19dcf684b21b6d3a1844807bd1df97ad197a<br>
-- <br>
2.48.1.601.g30ceb7b040-goog<br>
<br>
<br>
</blockquote></div>

--00000000000029bd72062eee9308--
--00000000000029bd74062eee930a
Content-Type: application/octet-stream; name=log
Content-Disposition: attachment; filename=log
Content-Transfer-Encoding: base64
Content-ID: <f_m7jw6ldb0>
X-Attachment-Id: f_m7jw6ldb0

LS0tCnYyOgotIEFkZCBjb21tZW50IG9uIHRvcCBvZiByZWZjb3VudF90IHJlZiBleHBsYWluaW5n
IHRoZSB1c2FnZSBpbiB0aGUgWFQKICBwYXRoLgotIEZpeCBtaXNzaW5nIGRlZmluaXRpb24gb2Yg
bmV0X2Rldm1lbV9kbWFidWZfYmluZGluZ19wdXQgaW4gdGhpcyBwYXRjaC4KCi0tLQogaW5jbHVk
ZS9saW51eC9za2J1ZmZfcmVmLmggfCAgNCArKy0tCiBpbmNsdWRlL25ldC9uZXRtZW0uaCAgICAg
ICB8ICAzICsrKwogbmV0L2NvcmUvZGV2bWVtLmMgICAgICAgICAgfCAxMCArKysrKysrKysrCiBu
ZXQvY29yZS9kZXZtZW0uaCAgICAgICAgICB8IDIwICsrKysrKysrKysrKysrKysrKysrCiBuZXQv
Y29yZS9za2J1ZmYuYyAgICAgICAgICB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogNSBmaWxlcyBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2tidWZmX3JlZi5oIGIvaW5jbHVkZS9saW51eC9za2J1
ZmZfcmVmLmgKaW5kZXggMGYzYzU4MDA3NDg4Li45ZTQ5MzcyZWYxYTAgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgvc2tidWZmX3JlZi5oCisrKyBiL2luY2x1ZGUvbGludXgvc2tidWZmX3JlZi5o
CkBAIC0xNyw3ICsxNyw3IEBACiAgKi8KIHN0YXRpYyBpbmxpbmUgdm9pZCBfX3NrYl9mcmFnX3Jl
Zihza2JfZnJhZ190ICpmcmFnKQogewotCWdldF9wYWdlKHNrYl9mcmFnX3BhZ2UoZnJhZykpOwor
CWdldF9uZXRtZW0oc2tiX2ZyYWdfbmV0bWVtKGZyYWcpKTsKIH0KIAogLyoqCkBAIC00MCw3ICs0
MCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBza2JfcGFnZV91bnJlZihuZXRtZW1fcmVmIG5ldG1l
bSwgYm9vbCByZWN5Y2xlKQogCWlmIChyZWN5Y2xlICYmIG5hcGlfcHBfcHV0X3BhZ2UobmV0bWVt
KSkKIAkJcmV0dXJuOwogI2VuZGlmCi0JcHV0X3BhZ2UobmV0bWVtX3RvX3BhZ2UobmV0bWVtKSk7
CisJcHV0X25ldG1lbShuZXRtZW0pOwogfQogCiAvKioKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0
L25ldG1lbS5oIGIvaW5jbHVkZS9uZXQvbmV0bWVtLmgKaW5kZXggYzYxZDViMjFlN2I0Li5hMjE0
OGZmYjIwM2QgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbmV0L25ldG1lbS5oCisrKyBiL2luY2x1ZGUv
bmV0L25ldG1lbS5oCkBAIC0yNjQsNCArMjY0LDcgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBs
b25nIG5ldG1lbV9nZXRfZG1hX2FkZHIobmV0bWVtX3JlZiBuZXRtZW0pCiAJcmV0dXJuIF9fbmV0
bWVtX2NsZWFyX2xzYihuZXRtZW0pLT5kbWFfYWRkcjsKIH0KIAordm9pZCBnZXRfbmV0bWVtKG5l
dG1lbV9yZWYgbmV0bWVtKTsKK3ZvaWQgcHV0X25ldG1lbShuZXRtZW1fcmVmIG5ldG1lbSk7CisK
ICNlbmRpZiAvKiBfTkVUX05FVE1FTV9IICovCmRpZmYgLS1naXQgYS9uZXQvY29yZS9kZXZtZW0u
YyBiL25ldC9jb3JlL2Rldm1lbS5jCmluZGV4IDdjNmUwYjViNmFjYi4uYjFhYWZjNjZlYmI3IDEw
MDY0NAotLS0gYS9uZXQvY29yZS9kZXZtZW0uYworKysgYi9uZXQvY29yZS9kZXZtZW0uYwpAQCAt
MzI1LDYgKzMyNSwxNiBAQCBuZXRfZGV2bWVtX2JpbmRfZG1hYnVmKHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYsIHVuc2lnbmVkIGludCBkbWFidWZfZmQsCiAJcmV0dXJuIEVSUl9QVFIoZXJyKTsKIH0K
IAordm9pZCBuZXRfZGV2bWVtX2dldF9uZXRfaW92KHN0cnVjdCBuZXRfaW92ICpuaW92KQorewor
CW5ldF9kZXZtZW1fZG1hYnVmX2JpbmRpbmdfZ2V0KG5ldF9kZXZtZW1faW92X2JpbmRpbmcobmlv
dikpOworfQorCit2b2lkIG5ldF9kZXZtZW1fcHV0X25ldF9pb3Yoc3RydWN0IG5ldF9pb3YgKm5p
b3YpCit7CisJbmV0X2Rldm1lbV9kbWFidWZfYmluZGluZ19wdXQobmV0X2Rldm1lbV9pb3ZfYmlu
ZGluZyhuaW92KSk7Cit9CisKIC8qKiogIkRtYWJ1ZiBkZXZtZW0gbWVtb3J5IHByb3ZpZGVyIiAq
KiovCiAKIGludCBtcF9kbWFidWZfZGV2bWVtX2luaXQoc3RydWN0IHBhZ2VfcG9vbCAqcG9vbCkK
ZGlmZiAtLWdpdCBhL25ldC9jb3JlL2Rldm1lbS5oIGIvbmV0L2NvcmUvZGV2bWVtLmgKaW5kZXgg
N2ZjMTU4ZDUyNzI5Li45NDZmMmUwMTU3NDYgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL2Rldm1lbS5o
CisrKyBiL25ldC9jb3JlL2Rldm1lbS5oCkBAIC0yOSw2ICsyOSwxMCBAQCBzdHJ1Y3QgbmV0X2Rl
dm1lbV9kbWFidWZfYmluZGluZyB7CiAJICogVGhlIGJpbmRpbmcgdW5kb3MgaXRzZWxmIGFuZCB1
bm1hcHMgdGhlIHVuZGVybHlpbmcgZG1hYnVmIG9uY2UgYWxsCiAJICogdGhvc2UgcmVmcyBhcmUg
ZHJvcHBlZCBhbmQgdGhlIGJpbmRpbmcgaXMgbm8gbG9uZ2VyIGRlc2lyZWQgb3IgaW4KIAkgKiB1
c2UuCisJICoKKwkgKiBuZXRfZGV2bWVtX2dldF9uZXRfaW92KCkgb24gZG1hYnVmIG5ldF9pb3Zz
IHdpbGwgaW5jcmVtZW50IHRoaXMKKwkgKiByZWZlcmVuY2UsIG1ha2luZyBzdXJlIHRoYXQgdGhl
IGJpbmRpbmcgcmVtYWlucyBhbGl2ZSB1bnRpbCBhbGwgdGhlCisJICogbmV0X2lvdnMgYXJlIG5v
IGxvbmdlciB1c2VkLgogCSAqLwogCXJlZmNvdW50X3QgcmVmOwogCkBAIC0xMTEsNiArMTE1LDkg
QEAgbmV0X2Rldm1lbV9kbWFidWZfYmluZGluZ19wdXQoc3RydWN0IG5ldF9kZXZtZW1fZG1hYnVm
X2JpbmRpbmcgKmJpbmRpbmcpCiAJX19uZXRfZGV2bWVtX2RtYWJ1Zl9iaW5kaW5nX2ZyZWUoYmlu
ZGluZyk7CiB9CiAKK3ZvaWQgbmV0X2Rldm1lbV9nZXRfbmV0X2lvdihzdHJ1Y3QgbmV0X2lvdiAq
bmlvdik7Cit2b2lkIG5ldF9kZXZtZW1fcHV0X25ldF9pb3Yoc3RydWN0IG5ldF9pb3YgKm5pb3Yp
OworCiBzdHJ1Y3QgbmV0X2lvdiAqCiBuZXRfZGV2bWVtX2FsbG9jX2RtYWJ1ZihzdHJ1Y3QgbmV0
X2Rldm1lbV9kbWFidWZfYmluZGluZyAqYmluZGluZyk7CiB2b2lkIG5ldF9kZXZtZW1fZnJlZV9k
bWFidWYoc3RydWN0IG5ldF9pb3YgKnBwaW92KTsKQEAgLTEyMCw2ICsxMjcsMTkgQEAgYm9vbCBu
ZXRfaXNfZGV2bWVtX2lvdihzdHJ1Y3QgbmV0X2lvdiAqbmlvdik7CiAjZWxzZQogc3RydWN0IG5l
dF9kZXZtZW1fZG1hYnVmX2JpbmRpbmc7CiAKK3N0YXRpYyBpbmxpbmUgdm9pZAorbmV0X2Rldm1l
bV9kbWFidWZfYmluZGluZ19wdXQoc3RydWN0IG5ldF9kZXZtZW1fZG1hYnVmX2JpbmRpbmcgKmJp
bmRpbmcpCit7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBuZXRfZGV2bWVtX2dldF9uZXRfaW92
KHN0cnVjdCBuZXRfaW92ICpuaW92KQoreworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgbmV0X2Rl
dm1lbV9wdXRfbmV0X2lvdihzdHJ1Y3QgbmV0X2lvdiAqbmlvdikKK3sKK30KKwogc3RhdGljIGlu
bGluZSB2b2lkCiBfX25ldF9kZXZtZW1fZG1hYnVmX2JpbmRpbmdfZnJlZShzdHJ1Y3QgbmV0X2Rl
dm1lbV9kbWFidWZfYmluZGluZyAqYmluZGluZykKIHsKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3Nr
YnVmZi5jIGIvbmV0L2NvcmUvc2tidWZmLmMKaW5kZXggNWIyNDFjOWU2ZjM4Li42ZTg1M2Q1NWEz
ZTggMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3NrYnVmZi5jCisrKyBiL25ldC9jb3JlL3NrYnVmZi5j
CkBAIC04OSw2ICs4OSw3IEBACiAjaW5jbHVkZSA8bGludXgvdGV4dHNlYXJjaC5oPgogCiAjaW5j
bHVkZSAiZGV2LmgiCisjaW5jbHVkZSAiZGV2bWVtLmgiCiAjaW5jbHVkZSAibmV0bWVtX3ByaXYu
aCIKICNpbmNsdWRlICJzb2NrX2Rlc3RydWN0b3IuaCIKIApAQCAtNzI1MywzICs3MjU0LDMyIEBA
IGJvb2wgY3N1bV9hbmRfY29weV9mcm9tX2l0ZXJfZnVsbCh2b2lkICphZGRyLCBzaXplX3QgYnl0
ZXMsCiAJcmV0dXJuIGZhbHNlOwogfQogRVhQT1JUX1NZTUJPTChjc3VtX2FuZF9jb3B5X2Zyb21f
aXRlcl9mdWxsKTsKKwordm9pZCBnZXRfbmV0bWVtKG5ldG1lbV9yZWYgbmV0bWVtKQoreworCWlm
IChuZXRtZW1faXNfbmV0X2lvdihuZXRtZW0pKSB7CisJCS8qIEFzc3VtZSBhbnkgbmV0X2lvdiBp
cyBkZXZtZW0gYW5kIHJvdXRlIGl0IHRvCisJCSAqIG5ldF9kZXZtZW1fZ2V0X25ldF9pb3YuIEFz
IG5ldyBuZXRfaW92IHR5cGVzIGFyZSBhZGRlZCB0aGV5CisJCSAqIG5lZWQgdG8gYmUgY2hlY2tl
ZCBoZXJlLgorCQkgKi8KKwkJbmV0X2Rldm1lbV9nZXRfbmV0X2lvdihuZXRtZW1fdG9fbmV0X2lv
dihuZXRtZW0pKTsKKwkJcmV0dXJuOworCX0KKwlnZXRfcGFnZShuZXRtZW1fdG9fcGFnZShuZXRt
ZW0pKTsKK30KK0VYUE9SVF9TWU1CT0woZ2V0X25ldG1lbSk7CisKK3ZvaWQgcHV0X25ldG1lbShu
ZXRtZW1fcmVmIG5ldG1lbSkKK3sKKwlpZiAobmV0bWVtX2lzX25ldF9pb3YobmV0bWVtKSkgewor
CQkvKiBBc3N1bWUgYW55IG5ldF9pb3YgaXMgZGV2bWVtIGFuZCByb3V0ZSBpdCB0bworCQkgKiBu
ZXRfZGV2bWVtX3B1dF9uZXRfaW92LiBBcyBuZXcgbmV0X2lvdiB0eXBlcyBhcmUgYWRkZWQgdGhl
eQorCQkgKiBuZWVkIHRvIGJlIGNoZWNrZWQgaGVyZS4KKwkJICovCisJCW5ldF9kZXZtZW1fcHV0
X25ldF9pb3YobmV0bWVtX3RvX25ldF9pb3YobmV0bWVtKSk7CisJCXJldHVybjsKKwl9CisKKwlw
dXRfcGFnZShuZXRtZW1fdG9fcGFnZShuZXRtZW0pKTsKK30KK0VYUE9SVF9TWU1CT0wocHV0X25l
dG1lbSk7Ci0tIAoyLjQ4LjEuNjAxLmczMGNlYjdiMDQwLWdvb2cKCg==
--00000000000029bd74062eee930a--


