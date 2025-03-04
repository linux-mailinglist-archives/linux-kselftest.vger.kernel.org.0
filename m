Return-Path: <linux-kselftest+bounces-28109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD7A4CFDD
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75DE1895F06
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F248837;
	Tue,  4 Mar 2025 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdEJYkF+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66F33C9;
	Tue,  4 Mar 2025 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047653; cv=none; b=ggmmnjm0+TKXlJvHIs/CnsEzu+9DWAY6FPKG0ToUJX/CiYuZpfIsOXRlGJZFBo1z1J3kkbyeBcE7kaZ5Y1HN6kuXepg1fU2qR02uRJkXleQi7A7TABjVO1zMSnCphTQ0Sjr3WaUYLI2s624WqHgBXcC8NwH2ymPpJvbBV6zTzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047653; c=relaxed/simple;
	bh=LAmMGSLnzR2OYEFOo+PYZBnSaJVgzfYYZgo38RaUpuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdLlzSvwHyTIbdQkgpg7knzXNgNRbDf/uEKvaOSZ/Gh7y6MRc31i0ME0OnW9WKF/jSxGwOl3+KF68/k1IdMbC6cnJzdlmKWsX+H4P74Hd7urxtwqa60ORXq5UqbsVbJJ2DehKdXTsPGyYw/1/LxoiywQi9MKMjtu92up14UUHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdEJYkF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0518EC4CEE4;
	Tue,  4 Mar 2025 00:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741047653;
	bh=LAmMGSLnzR2OYEFOo+PYZBnSaJVgzfYYZgo38RaUpuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VdEJYkF+m3mlxf6SR3CFwP3oyKzjWYw8MAPmnO1z77oytFmcxQDBgTr+afanslctg
	 sOf01BrUaQxvUZ88qIJQ4W3m9uTFk0rn02xns4oeH7HMwGFIuo4Bz6Z0Q+YWILxkH7
	 IpqteCYfEKKPhC2ckdEIHuNElC8f/lnqy7asMBIfGqgxgJL4fiZUz0NqiCOOCBXurH
	 D/ftQR1TsqPQXoEi9Z5gsAYn6ZeZ22nSSWs2GGT7HRdqPgmxMksdPoa2vPTpWImRtu
	 5D8XYGYyKXodzmyuLdroedCpOxZLzSv6H26mQiZQ0dPCQgrfoZ+o/acjBX/N5zplWP
	 ACtePg0dD+7+Q==
Date: Mon, 3 Mar 2025 16:20:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim
 <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v6 1/8] net: add get_netmem/put_netmem support
Message-ID: <20250303162051.09ad684e@kernel.org>
In-Reply-To: <CAHS8izNQnTW7sad_oABtxhy3cHxGR0FWJucrHTSVX7ZAA6jT3Q@mail.gmail.com>
References: <20250227041209.2031104-1-almasrymina@google.com>
	<20250227041209.2031104-2-almasrymina@google.com>
	<20250228163846.0a59fb40@kernel.org>
	<CAHS8izNQnTW7sad_oABtxhy3cHxGR0FWJucrHTSVX7ZAA6jT3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 17:29:13 -0800 Mina Almasry wrote:
> On Fri, Feb 28, 2025 at 4:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Thu, 27 Feb 2025 04:12:02 +0000 Mina Almasry wrote: =20
> > >  static inline void __skb_frag_ref(skb_frag_t *frag)
> > >  {
> > > -     get_page(skb_frag_page(frag));
> > > +     get_netmem(skb_frag_netmem(frag));
> > >  } =20
> >
> > Silently handling types of memory the caller may not be expecting
> > always worries me. =20
>=20
> Sorry, I'm not following. What caller is not expecting netmem?
> Here we're making sure __skb_frag_ref() handles netmem correctly,
> i.e. we were not expecting netmem here before, and after this patch
> we'll handle it correctly.
>=20
> > Why do we need this?
> > =20
>=20
> The MSG_ZEROCOPY TX path takes a page reference on the passed memory
> in zerocopy_fill_skb_from_iter() that kfree_skb() later drops when the
> skb is sent. We need an equivalent for netmem, which only supports pp
> refs today. This is my attempt at implementing a page_ref equivalent
> to net_iov and generic netmem.
>=20
> I think __skb_frag_[un]ref is used elsewhere in the TX path too,
> tcp_mtu_probe for example calls skb_frag_ref eventually.

Any such caller must be inspected to make sure it generates
/ anticipates skbs with appropriate pp_recycle and readable settings.
It's possible that adding a set of _netmem APIs would be too much
churn, but if it's not - it'd make it clear which parts of the kernel
we have inspected.

> > In general, I'm surprised by the lack of bug reports for devmem. =20
>=20
> I guess we did a good job making sure we don't regress the page paths.

:)

> The lack of support in any driver that qemu will run is an issue. I
> wonder if also the fact that devmem needs some setup is also an issue.
> We need headersplit enabled, udmabuf created, netlink API bound, and
> then a connection referring to created and we don't support loopback.
> I think maybe it all may make it difficult for syzbot to repro. I've
> had it on my todo list to investigate this more.
>=20
> > Can you think of any way we could expose this more to syzbot?
> > First thing that comes to mind is a simple hack in netdevsim,
> > to make it insert a netmem handle (allocated locally, not a real
> > memory provider), every N packets (controllable via debugfs).
> > Would that work? =20
>=20
> Yes, great idea. I don't see why it wouldn't work.
>=20
> We don't expect mixing of net_iovs and pages in the same skb, but
> netdevsim could create one net_iov skb every N skbs.
>=20
> I guess I'm not totally sure something is discoverable to syzbot. Is a
> netdevsim hack toggleable via a debugfs sufficient for syzbot? I'll
> investigate and ask.

Yeah, my unreliable memory is that syzbot has a mixed record discovering
problems with debugfs. If you could ask Dmitry for advice that'd be
ideal.

