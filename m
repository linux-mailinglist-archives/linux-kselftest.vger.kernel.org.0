Return-Path: <linux-kselftest+bounces-25261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AEFA2012B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE597A287A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 22:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62EB1DDA34;
	Mon, 27 Jan 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0TJpbO3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7081DC747
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738018373; cv=none; b=hFQtnAtscutcOshdSkOEHS/93AaMGmwKSoJXBM1RY7tSbELNZyjh+Gq7PY6ANSQs7bmSErb793fSESbH+1fOCtKb9wUST+LPu3bxnnG5xhnWvgzT2AfVjeTWQD17eZbUxaByuS/ZjZBtN9o/JWwQeunqNZX7fbIlw7BfYQl8AQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738018373; c=relaxed/simple;
	bh=68yT7ctj8bEjZRs1enf6Riz6YgvO2oWyLb6AjHmiCg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghfvgxIlM1X74EJVECRx2wmhHiZ80o2pfLk7vTEJvdlwxPn9itUckYqG2dhf97jhTuKqh13cYYHP3/hj4jFHiSx/WsdV9aQX2+q80ObwMBR7xwMG7WSQqzDuoCoqUNGXFrp3+ZIpCnvOJ2PsDxu+chu5L8EtxclxHh9cKcLC7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0TJpbO3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21625b4f978so45745ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 14:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738018370; x=1738623170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt046zC8q+cHCBSEV8Sb8uhTY9mqKP4r1voWC0exUjg=;
        b=Y0TJpbO3biG+g4b/vJL9wfJsQaG2MMdu980k6DnglOuFtXkuCWli1Y44Dn9Qa5mXca
         /Ik7u5caS9UF9m2AiEycEwDU1aJBZBjAFhNal5oB5wvTCNWqDq/VOR7t4Qtapo7DJFAR
         c2iWvtoezqeZSgOWIoZWVLZE+sqL53Rwl14wuawYWCzAZDF1E8ApWz6an6AaLV+G82Ow
         w3mxMkK1yBTyq0GPc6jZrhPavB5ZyXTn3sh0/RJdz3twPnoVQGFfhFigLtfhex8h1wiP
         Fwn/7ZSvKu6VHgkUhpffOf7fj5ih2VM9xzwIulT+Fw+q7zgJpLDUeGnjmo8IeTTd2K8g
         kE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738018370; x=1738623170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt046zC8q+cHCBSEV8Sb8uhTY9mqKP4r1voWC0exUjg=;
        b=lzrMluCG3HJ3pV1d/xCuVHATFUJC2IHFFXP1oP+A97fZZ+bXdQnVRBb/BDogdTj+Ed
         7mQ0cEM8sAWVgeuXhjcUrDEviBxRI0s98rNTwZJ1PNMJ6RR0TozW7RunVe6mRrVzpt31
         MZdzOEVCJr7u9KQb6V8K1oabhf+eNqu9tdat8PIEjV0FG/6jAntpGGe8YP3TBV+Sbg75
         CkW2hMqQI0LhGIDzlPaMf8ePExNDCk/SKkUEYi/XxLw/VeXyuUdRiN665bvNRuxS9c+g
         H1qnq2PLncUNnYYZFk5VrSulyAi3gqaizb8DL8mfWLkAsrfgJSKVTai2d6Vxpgy9uMA+
         ZdgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU06Rnx0td7OxW/dWUGGxWlWGfoaS4Ff5NQH/6XUW7DWU1NYX7caUAwlVgqBlR5hZz2+XVR2a76lHF3RmsbxyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3yxC9QndmerfIOvKoczI1vno6ytAejC7voqRJRhYU8LCBNjN
	HYGhtRmrhlfvuc77+6N1Adjv6XvHT1a/k0VXLBA1peA/+BPiNAL5gEiKZ3B5UHZba+bqPQyMhXv
	8bDYUbVLMv3zvaH5jbOgmGN9lh2M4QkCev9W2
X-Gm-Gg: ASbGncswLaxkh0xT6ZNAojucA1qQyaXmZnG9zO1aPtCsPzgASa0/oL6q3/ueTBueHWD
	keL/BFevbzTPj/P6bwQnJJU/VNT39ce11LoIsEhog8gvavlbxty7AhZiNi5l+UBg1pyVPRKYqAp
	4uU0JctxOm4cGxZ4dCeKHoQ3pj9bU=
X-Google-Smtp-Source: AGHT+IGnMwtsrtnKydiBNAxNPRr5z5y9ziqP6BqEtfZ64TIOYQJqCWiD2gAFKLfpOjZiYf94dEFeLv3VKxqstm1f4LE=
X-Received: by 2002:a17:902:f611:b0:215:44af:313b with SMTP id
 d9443c01a7336-21dccd2833dmr925035ad.0.1738018370394; Mon, 27 Jan 2025
 14:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-6-almasrymina@google.com> <Z2ZNlGCbQXMondI7@mini-arch>
 <Z22qCznFSWWyjyyq@mini-arch>
In-Reply-To: <Z22qCznFSWWyjyyq@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Jan 2025 14:52:36 -0800
X-Gm-Features: AWEUYZnm6s4cike1pxqq6gw1uBcZE5P6ce8F2RNXnwtoS-1NKohoiPC1TO6Djb0
Message-ID: <CAHS8izNQYj4z-8vjMk8ttv85Q0HbdTrguLZewUt=4K8+5=6g_g@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 11:10=E2=80=AFAM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 12/20, Stanislav Fomichev wrote:
> > On 12/21, Mina Almasry wrote:
> > >  void netdev_nl_sock_priv_init(struct list_head *priv)
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index 815245d5c36b..eb6b41a32524 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -1882,8 +1882,10 @@ EXPORT_SYMBOL_GPL(msg_zerocopy_ubuf_ops);
> > >
> > >  int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
> > >                          struct msghdr *msg, int len,
> > > -                        struct ubuf_info *uarg)
> > > +                        struct ubuf_info *uarg,
> > > +                        struct net_devmem_dmabuf_binding *binding)
> > >  {
> > > +   struct iov_iter *from =3D binding ? &binding->tx_iter : &msg->msg=
_iter;
> >
> > For tx, I feel like this needs a copy of binding->tx_iter:
> >
> >       struct iov_iter tx_iter =3D binding->tx_iter;
> >       struct iov_iter *from =3D binding ? &tx_iter : &msg->msg_iter;
> >
> > Or something similar (rewind?). The tx_iter is advanced in
> > zerocopy_fill_skb_from_devmem but never reset back it seems (or I'm
> > missing something). In you case, if you call sendmsg twice with the sam=
e
> > offset, the second one will copy from 2*offset.
>
> Can confirm that it's broken. We should probably have a mode in ncdevmem
> to call sendmsg with the fixed sized chunks, something like this:
>

Thanks for catching. Yes, I've been able to repro and I believe I
fixed it locally and will include a fix with the next iteration.

I also agree using a binding->tx_iter here is not necessary, and it
makes the code a bit confusing as there is an iteration in msg and
another one in binding and we have to be careful which to
advance/revert etc. I've prototyped implementation without
binding->tx_iter with help from your series on github and seems to
work fine in my tests.

> @@ -912,7 +916,11 @@ static int do_client(struct memory_buffer *mem)
>                                 line_size, off);
>
>                         iov.iov_base =3D NULL;
> -                       iov.iov_len =3D line_size;
> +                       iov.iov_len =3D line_size <=3D 4096 ?: 4096;
>
>                         msg.msg_iov =3D &iov;
>                         msg.msg_iovlen =3D 1;
> @@ -933,6 +941,8 @@ static int do_client(struct memory_buffer *mem)
>                         ret =3D sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
>                         if (ret < 0)
>                                 error(1, errno, "Failed sendmsg");
> +                       if (ret =3D=3D 0)
> +                               break;
>
>                         fprintf(stderr, "sendmsg_ret=3D%d\n", ret);
>
> I can put it on my todo to extend the selftests..

FWIW I've been able to repro this and extended the tests to catch
this; those changes should come with the next iteration.

--=20
Thanks,
Mina

