Return-Path: <linux-kselftest+bounces-28110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11370A4CFE9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3906F1894BEF
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9346115E97;
	Tue,  4 Mar 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R82tMGF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D933C9;
	Tue,  4 Mar 2025 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048144; cv=none; b=ryJrrZj14xfZ5F5/EEy1DGPKeI/8jQgvnd2/j2FZvHN01Xc/05zgTKdKf0trS9Qxzgj6exmfqjS0e5VTnl5R67vxkiCrB1iQUwuVy2Z6dDeMFcFiGamzRIWbS09DH7DKhfJXJGSx+jiwocNN+V6IklmMk3gdsvs99ZJ3qu1hjwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048144; c=relaxed/simple;
	bh=Ly2aEH0hd4Ze3/zdCTZcBlMsu86z7XE9ksQtnmTlUrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nu7iZUMiTboc5rBGB8aDrlui5fsizk1F2041EPLelZ7HYn0BWESR5Jv8Kk8+OexJ2hBYlYMSigar9t6IfPlbesKD5Wa+DiNlN0rMQKpjiYeTZhd9BIxRCR0+EmW1mvo+bGUkm7ZmqPrjkxbi61JolRaTOdAWqzAKUJi9NKnecgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R82tMGF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2500C4CEE4;
	Tue,  4 Mar 2025 00:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741048143;
	bh=Ly2aEH0hd4Ze3/zdCTZcBlMsu86z7XE9ksQtnmTlUrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R82tMGF6RdlMBIkheAdwBinAtHyfqN2atNoIWXVRziWr5F0ZEs07qV4OH9O+ckKQX
	 3by4aApVE40CcEzEWZHA33Xlg+kkNrL5+Y/vxYYYcs+n+pST9BQ53jczTLnzCigAQQ
	 cwwt12zyk0kvWvjt19YY22FFMr972kKK/5zfDkxV+/BS+r8aZXE8VT/ng1Bt6/lVeU
	 S4/7ei6UfeoCL6ZCtvbI7wg+EreIxbRjemcYBFZEVdf8zm6a5SuaJ/NVDf8ojf9Feg
	 jB6pa68SLRBmKdkElB6EzO157+b65uQkt5Ui/Wr69x7IZmjpXgUD+MrT3FWF1283AD
	 FcnaNWB2ZrZ3w==
Date: Mon, 3 Mar 2025 16:29:01 -0800
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
Subject: Re: [PATCH net-next v6 7/8] net: check for driver support in netmem
 TX
Message-ID: <20250303162901.7fa57cd0@kernel.org>
In-Reply-To: <CAHS8izO-N4maVtjhgH7CFv5D-QEtjQaYKSrHUrth=aJje4NZgg@mail.gmail.com>
References: <20250227041209.2031104-1-almasrymina@google.com>
	<20250227041209.2031104-8-almasrymina@google.com>
	<20250228164301.07af6753@kernel.org>
	<CAHS8izO-N4maVtjhgH7CFv5D-QEtjQaYKSrHUrth=aJje4NZgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 17:53:24 -0800 Mina Almasry wrote:
> On Fri, Feb 28, 2025 at 4:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Thu, 27 Feb 2025 04:12:08 +0000 Mina Almasry wrote: =20
> > > +     if (!skb_frags_readable(skb) && !dev->netmem_tx) =20
> >
> > How do you know it's for _this_ device tho? =20
>=20
> Maybe a noob question, but how do we end up here with an skb that is
> not targeted for the 'dev' device? We are checking in
> tcp_sendmsg_locked that we're targeting the appropriate device before
> creating the skb. Is this about a packet arriving on a dmabuf bound to
> a device and then being forwarded through another device that doesn't
> own the mapping, bypassing the check?

Forwarded or just redirected by nft/bpf/tc

> > The driver doesn't seem to check the DMA mapping belongs to it either.
> >
> > Remind me, how do we prevent the unreadable skbs from getting into the
> > Tx path today? =20
>=20
> I'm not sure if this is about forwarding, or if there is some other
> way for unreadable skbs to end up in the XT path that you have in
> mind. At some point in this thread[1] we had talked about preventing
> MP bound devices from being lower devices at all to side step this
> entirely but you mentioned that may not be enough, and we ended up
> sidestepping only XDP entirely.
>=20
> [1] https://lore.kernel.org/bpf/20240821153049.7dc983db@kernel.org/

Upper devices and BPF access is covered I think, by the skbuff checks.
But I think we missed adding a check in validate_xmit_skb() to protect
the xmit paths of HW|virt drivers. You can try to add a TC rule which
forwards all traffic from your devmem flow back out to the device and
see if it crashes on net-next ?

