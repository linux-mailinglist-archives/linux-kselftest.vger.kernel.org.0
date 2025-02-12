Return-Path: <linux-kselftest+bounces-26486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB122A32F75
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 20:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2027C168079
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 19:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C2D2627ED;
	Wed, 12 Feb 2025 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2MkxcnLA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B18261387
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387946; cv=none; b=VFUWZsF3XE/WlUxsNl3i0A0m/3QTnNIpzmAFNEH0lmXiMZwYCkn3S2ZfFEtNKfGIRAyW2EApCcBHf1FXX1Z7/SxhA+v/rwV09M3Jl/0z9uPYGNRG2dUuRCBfIwAKVUANwGHhHuNKh9LXgxzXziVT5I1wrUbKOjscgRWqRq+zM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387946; c=relaxed/simple;
	bh=11Hy8cODuSDFHaJcx2Ju8aoOiOQIkeBngDRvi40dN6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/xOM2rTK2rcEEf7rJ55pC08H/v9VmYeleR184npkgHHqR+OvoS/fYeBy5YaSLG/6zGRNAxqNzVhlt6iUGPaMMI0CevbxlmSYz5krkA0OTtkmNhcHjSVnKCOugprxFis4fXvWQB4ZXtv8LODalcZ/LPdVv3DwS8FHQtMkAdOdBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2MkxcnLA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f6ca9a81so166655ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 11:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739387943; x=1739992743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlrqapFW6dtOfJ+Ygfgx6q2yFRXVAGv+WlcsEV5abYE=;
        b=2MkxcnLAUPXAmn6iVq6G7LjRpB2DVfCpBkoGsv1oQLuv0V10UKsX9AqwEPrAiyMZvk
         u6WPrTaRh2gGUDrAiINczu56xBOX1k+dldrJx7HOHhUdDBphRcbojmIADe/tw4xLNVUI
         IExvhTnzh2cebFC3pk+MU+HN2BeJKY2qefsYQG2upMMcCGkjptiqA7FtF1hbkY0F3O/5
         JGdnEzS8zmkSINyS80JpYbMvjI93gDJxz+8SiexlpcGKoFNZpUWkC5YUFZriSM39/Ddm
         ABlZ0ykyH6IwgFu1psVd8jR5DadisFg/MD30Ye4nSRSZCs6Y2aPEl3oq2xB6g4Cdoa51
         TfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739387943; x=1739992743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlrqapFW6dtOfJ+Ygfgx6q2yFRXVAGv+WlcsEV5abYE=;
        b=V9m+KoCiNvWZwVHIFjlkHOjl4f15RHYOWGaFVvxVQEvz6FoPx+guzYStY4RTuJH3YZ
         wrnlLATh2vpNyDtW5FTkmXGeVjwkSZVaF1v9SXedo48FZznCbcol02g/iL1abkjSz8Qa
         c0kxbmyHwU53K+bcVjpSlsismQOLakU54T1khcBCQcetZIxCvUIthpWwniPI9eRehkbh
         usXxwUFNS0sknBvc2d4c131EWNtl7UOglQP1tkoNu7AoC0qwCjIgsL24KjTiqcKDSesV
         DKJKr0gKkjdsHW1fh/nvd8zYF4BqXfs+IMtqNC/e/a/7ZDX4aHdE2vYTYshxaPLuyiOX
         Xtpg==
X-Forwarded-Encrypted: i=1; AJvYcCWFFzf2NGLFLQh2q9nMj17W8xA1dGWEGw8F+uwJd88zo6Shw+5BbsttyoTM7W2qnuuttXt2SpotZCqfnZXaZys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzZLdkeZWBXb5TInQcDPBQyltZv+tOCOgaMMM4c+kskb6jcjI
	18pTKLg70AoZylY/JwM+W1pJX5K4DOBAPxlTYAwx8GNarO/kK4/mdWxEdRuZ//MFaDzDkHvDdCR
	jxCcY7Z4yCI1ASEU0ufPeSbJgxtnw7ugvJWWXjpUnwK0rLot70XOb
X-Gm-Gg: ASbGncuxktG33tCTbIGlortvKUeHqnrxJJcAgVDDJRKvv0J7UuDqd4GPtnf3dSRhGvq
	UuKqPGy/dFdSxNOuy3I7vWK1tfBmNLZUdCDNUSa6LX0hDd/t7uQSy4VthsBUI9OREdkjsnkJb
X-Google-Smtp-Source: AGHT+IGNugfx084SHply3CA0xWFW/29cP7ySkyiWEViy+SHvFCJOsIGeBkPN0hXf2z66fZ8oH82mGcxNE9IZpDD7YNc=
X-Received: by 2002:a17:902:f708:b0:215:7ced:9d66 with SMTP id
 d9443c01a7336-220d33f6b21mr172265ad.10.1739387942876; Wed, 12 Feb 2025
 11:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-6-almasrymina@google.com> <abc22620-d509-4b12-80ac-0c36b08b36d9@gmail.com>
 <CAHS8izNOqaFe_40gFh09vdBz6-deWdeGu9Aky-e7E+Wu2qtfdw@mail.gmail.com> <28343e83-6d93-4002-a691-f8273d4d24a8@gmail.com>
In-Reply-To: <28343e83-6d93-4002-a691-f8273d4d24a8@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 12 Feb 2025 11:18:50 -0800
X-Gm-Features: AWEUYZmMxO-D8gV-SzbNdeRwFeAQ7660IIm2vAphoidLeu_O5bDpvj8HGIH7jIY
Message-ID: <CAHS8izOE-JzMszieHEXtYBs7_6D-ngVx2kJyMwp8eCWLK-c0cQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/6] net: devmem: Implement TX path
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:52=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/10/25 21:09, Mina Almasry wrote:
> > On Wed, Feb 5, 2025 at 4:20=E2=80=AFAM Pavel Begunkov <asml.silence@gma=
il.com> wrote:
> >>
> >> On 2/3/25 22:39, Mina Almasry wrote:
> >> ...
> >>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >>> index bb2b751d274a..3ff8f568c382 100644
> >>> --- a/include/linux/skbuff.h
> >>> +++ b/include/linux/skbuff.h
> >>> @@ -1711,9 +1711,12 @@ struct ubuf_info *msg_zerocopy_realloc(struct =
sock *sk, size_t size,
> >> ...
> >>>    int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
> >>>                                struct iov_iter *from, size_t length);
> >>> @@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buf=
f *skb,
> >>>    static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
> >>>                                          struct msghdr *msg, int len)
> >>>    {
> >>> -     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_ite=
r, len);
> >>> +     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_ite=
r, len,
> >>> +                                    NULL);
> >>
> >> Instead of propagating it all the way down and carving a new path, why
> >> not reuse the existing infra? You already hook into where ubuf is
> >> allocated, you can stash the binding in there. And
> >
> > It looks like it's not possible to increase the side of ubuf_info at
> > all, otherwise the BUILD_BUG_ON in msg_zerocopy_alloc() fires.
> >
> > It's asserting that sizeof(ubuf_info_msgzc) <=3D sizeof(skb->cb), and
> > I'm guessing increasing skb->cb size is not really the way to go.
> >
> > What I may be able to do here is stash the binding somewhere in
> > ubuf_info_msgzc via union with fields we don't need for devmem, and/or
>
> It doesn't need to account the memory against the user, and you
> actually don't want that because dmabuf should take care of that.
> So, it should be fine to reuse ->mmp.
>
> It's also not a real sk_buff, so maybe maintainers wouldn't mind
> reusing some more space out of it, if that would even be needed.
>

netmem skb are real sk_buff, with the modification that frags are not
readable, only in the case that the netmem is unreadable. I would not
approve of considering netmem/devmem skbs "not real skbs", and start
messing with the semantics of skb fields for devmem skbs, and having
to start adding skb_is_devmem() checks through all code in the skb
handlers that touch the fields being overwritten in the devmem case.
No, I don't think we can re-use random fields in the skb for devmem.

> > stashing the binding in ubuf_info_ops (very hacky). Neither approach
> > seems ideal, but the former may work and may be cleaner.
> >
> > I'll take a deeper look here. I had looked before and concluded that
> > we're piggybacking devmem TX on MSG_ZEROCOPY path, because we need
> > almost all of the functionality there (no copying, send complete
> > notifications, etc), with one minor change in the skb filling. I had
> > concluded that if MSG_ZEROCOPY was never updated to use the existing
> > infra, then it's appropriate for devmem TX piggybacking on top of it
>
> MSG_ZEROCOPY does use the common infra, i.e. passing ubuf_info,
> but doesn't need ->sg_from_iter as zerocopy_fill_skb_from_iter()
> and it's what was there first.
>

But MSG_ZEROCOPY doesn't set msg->msg_ubuf. And not setting
msg->msg_ubuf fails to trigger msg->sg_from_iter altogether.

And also currently sg_from_iter isn't set up to take in a ubuf_info.
We'd need that if we stash the binding in the ubuf_info.

All in all I think I wanna prototype an msg->sg_from_iter approach and
make a judgement call on whether it's cleaner than just passing the
binding through a couple of helpers just as I'm doing here. My feeling
is that the implementation in this patch may be cleaner than
refactoring the entire msg_ubuf/sg_from_iter flows so we can sort of
use it for MSG_ZEROCOPY with devmem when it currently doesn't use it.

> > to follow that. I would not want to get into a refactor of
> > MSG_ZEROCOPY for no real reason.
> >
> > But I'll take a deeper look here and see if I can make something
> > slightly cleaner work.
> >
> >> zerocopy_fill_skb_from_devmem can implement ->sg_from_iter,
> >> see __zerocopy_sg_from_iter().
> >>
> >> ...
> >>> diff --git a/net/core/datagram.c b/net/core/datagram.c
> >>> index f0693707aece..c989606ff58d 100644
> >>> --- a/net/core/datagram.c
> >>> +++ b/net/core/datagram.c
> >>> @@ -63,6 +63,8 @@
> >>> +static int
> >>> +zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *=
from,
> >>> +                           int length,
> >>> +                           struct net_devmem_dmabuf_binding *binding=
)
> >>> +{
> >>> +     int i =3D skb_shinfo(skb)->nr_frags;
> >>> +     size_t virt_addr, size, off;
> >>> +     struct net_iov *niov;
> >>> +
> >>> +     while (length && iov_iter_count(from)) {
> >>> +             if (i =3D=3D MAX_SKB_FRAGS)
> >>> +                     return -EMSGSIZE;
> >>> +
> >>> +             virt_addr =3D (size_t)iter_iov_addr(from);
> >>
> >> Unless I missed it somewhere it needs to check that the iter
> >> is iovec based.
> >>
> >
> > How do we end up here with an iterator that is not iovec based? Is the
> > user able to trigger that somehow and I missed it?
>
> Hopefully not, but for example io_uring passes bvecs for a number of
> requests that can end up in tcp_sendmsg_locked(). Those probably
> would work with the current patch, but check the order of some of the
> checks it will break. And once io_uring starts passing bvecs for
> normal send[msg] requests, it'd definitely be possible. And there
> are other in kernel users apart from send(2) path, so who knows.
>
> The api allows it and therefore should be checked, it's better to
> avoid quite possible latent bugs.
>

Sounds good.

--=20
Thanks,
Mina

