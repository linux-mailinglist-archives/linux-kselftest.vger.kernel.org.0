Return-Path: <linux-kselftest+bounces-27952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4757AA4A763
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 02:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AB516AD2C
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 01:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8937B2F852;
	Sat,  1 Mar 2025 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0VaiX8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5111BC3F
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Mar 2025 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792569; cv=none; b=mhAvfzhSNSO0r4dNXRxui5P58zkixr1mS5HkYNNZ3doFZhHD4r6YEN3tWuGrypgFLl+TH18oUWADnkHDcBmVcOsBO0glPoCFO6bXNjGP8uNTs4YGHPjzZfIoQr2JB2BEe9G9vEDZzvVyBRWkmSv/WExmlr1sot7DCxOu4/5QO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792569; c=relaxed/simple;
	bh=x30Ghtnf2mwjQ7C24lb6dNTXdFIuMS5fxSzqclDeaDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcQDygfnl9/oMHxq7E42se/SEN2Z8czaJka7F/wBIqlxDO0q9YXRqGnRcK2R95hpQR+Y1Hn0ecwUnBvs/VPxbYszAmFVhVZQgh6UJ1QU6HBJJ+EJKxGfqqFvAIpXEjsIAualnXs2AhOEHGKLKMVfk+hFVyeM9woq3c6sBEDb0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0VaiX8p; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2212222d4cdso71995ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 17:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740792567; x=1741397367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc38nFBS6hSU0vji9D+YzzpAjSlnqZ5qJGUo2AO471s=;
        b=S0VaiX8p5oTZx9ICATxbmh2T98PF+gxmFdn5K7Dqs3yN7BRYfSPZcD7BpIrlV3/JWD
         g59Bpj5SyQ7kp7GDINxMbFp9sBrVu1zUYCkt5Lx0nWDgUEVBJTiCshbzOXvSvvVNLWK2
         QWOBISMETj1cm6T+hbYmPck540G8K9T5Jl/QirOuVwzeeRV96vQeKFpCZQR0sU2T2oPo
         HFPA6k+/LCZc92394kHeB0gnw3Iq3E3m+b88/NeZ/KCobUGJoSVnnqYQ1taIddl9IUlC
         ciSumnvRSAIPV8TufYdNZM1nIHMj98bEI6Y1XCO41aCpMHKTpuSMdr/C9tPGsu7QYMCX
         xH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740792567; x=1741397367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc38nFBS6hSU0vji9D+YzzpAjSlnqZ5qJGUo2AO471s=;
        b=NJMBIwAMSjk98NR9TuYVoBKMzJgHOtLtywryO/k4JparWvnWSJ+eryY6fj5D9D3sdV
         iw0tk7MOWzVP8FzfZVbtQ0G0vpdQKlwHrYZoo7veaXwxvtTSVEIixPeF65XAcCxJbXrC
         M9fO47/abgbP2x/rERbMHMVouuA8cF6m6OcCP2DcraRsVZnQpYCGBQEMulhlhlY6zw05
         8Hb2lg6lNJu+OkVNrtSDLxniDTCO1lDmMaxKuZcszU/FDZmuHIsmlWmv2Kvd+KqiYD7E
         bB/zHOfZ0gJ3JXoIbOQzpjrY9SQW5sFecooNAR0QhCc/iPIiW9qOEFSMmNbxH7iGq9U2
         ADyA==
X-Forwarded-Encrypted: i=1; AJvYcCXHkLNTL8rcs3c1jqxU3oUWAqm3qhNqtRHXJ+2C9qGS9z/6gwd436+0wtHcoWIg2DTJUha+6yuu6XdeAMURlR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwGnppLxBVsu0bBgaGjgakntdXny6K0U/FG8UkfeYotQGbWl9o
	ZqUksQKABzHiwaS4RKVjAKc4kK4+kMCgoe1/8+npbHQ2FhY1ohoui2uTB38zfU5kc69F0PMAjqn
	5bae+x20Z7xEYSSQNk4XV16AdJC8xFIzZiZUM
X-Gm-Gg: ASbGnctTPqu9J9T7itgItpJa1lpp9PLuxk36GA4v5KjA6iTFWZ8dNvevn8nD7EMpNyq
	TH8qerrfOa8LAxH/NuxRwEci6NqMJZLB7gCL45vrz/eaunkHXjx3iaNa0O7A8nyl5eQ662gOk5F
	VoJMUnu+AXo++/VGpX4lKc4rlyFQ==
X-Google-Smtp-Source: AGHT+IGncPbBhrhz7q7nYtSkG3NCU3eJmen24UIv0X8fbRWFxDMMC/F2mnfn4/23C53PdlyFhZfhFGySOLAkJbQVaoI=
X-Received: by 2002:a17:902:ccca:b0:220:c905:689f with SMTP id
 d9443c01a7336-22385a2665emr571665ad.25.1740792566772; Fri, 28 Feb 2025
 17:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-2-almasrymina@google.com> <20250228163846.0a59fb40@kernel.org>
In-Reply-To: <20250228163846.0a59fb40@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Feb 2025 17:29:13 -0800
X-Gm-Features: AQ5f1JqnucwSW-6yoUTgklaGGj9zlmp1rtei3-w0QbA66_zGizdQVdrhRtrAPr0
Message-ID: <CAHS8izNQnTW7sad_oABtxhy3cHxGR0FWJucrHTSVX7ZAA6jT3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/8] net: add get_netmem/put_netmem support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 4:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 27 Feb 2025 04:12:02 +0000 Mina Almasry wrote:
> >  static inline void __skb_frag_ref(skb_frag_t *frag)
> >  {
> > -     get_page(skb_frag_page(frag));
> > +     get_netmem(skb_frag_netmem(frag));
> >  }
>
> Silently handling types of memory the caller may not be expecting
> always worries me.

Sorry, I'm not following. What caller is not expecting netmem? Here
we're making sure __skb_frag_ref() handles netmem correctly, i.e. we
were not expecting netmem here before, and after this patch we'll
handle it correctly.

> Why do we need this?
>

The MSG_ZEROCOPY TX path takes a page reference on the passed memory
in zerocopy_fill_skb_from_iter() that kfree_skb() later drops when the
skb is sent. We need an equivalent for netmem, which only supports pp
refs today. This is my attempt at implementing a page_ref equivalent
to net_iov and generic netmem.

I think __skb_frag_[un]ref is used elsewhere in the TX path too,
tcp_mtu_probe for example calls skb_frag_ref eventually.

> In general, I'm surprised by the lack of bug reports for devmem.

I guess we did a good job making sure we don't regress the page paths.

The lack of support in any driver that qemu will run is an issue. I
wonder if also the fact that devmem needs some setup is also an issue.
We need headersplit enabled, udmabuf created, netlink API bound, and
then a connection referring to created and we don't support loopback.
I think maybe it all may make it difficult for syzbot to repro. I've
had it on my todo list to investigate this more.

> Can you think of any way we could expose this more to syzbot?
> First thing that comes to mind is a simple hack in netdevsim,
> to make it insert a netmem handle (allocated locally, not a real
> memory provider), every N packets (controllable via debugfs).
> Would that work?

Yes, great idea. I don't see why it wouldn't work.

We don't expect mixing of net_iovs and pages in the same skb, but
netdevsim could create one net_iov skb every N skbs.

I guess I'm not totally sure something is discoverable to syzbot. Is a
netdevsim hack toggleable via a debugfs sufficient for syzbot? I'll
investigate and ask.

--
Thanks,
Mina

