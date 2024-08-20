Return-Path: <linux-kselftest+bounces-15782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE0958CD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 19:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B422834A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AA1196D9D;
	Tue, 20 Aug 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWmOKv5y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFF1BDAB6
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724173897; cv=none; b=KAq04JDTj7UHUZS7CNu49zc8Mss2p79Qui6pTTGW6c2ZdGS86KxfDXoKIHWJgZSptEQSaXNwgi/GW+dae5qV5MyiDXuz/e5Vc+/MdrQB/Eowks2y9ERZutdP9Ike9OCXB4DRkDlufixDaa4+uU2pq12PuyNeROo3hzPp0rd+QDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724173897; c=relaxed/simple;
	bh=ikTvvm8hy1BF7FARpr0gNXmT5GHf2xyQyuwgTHN+X+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0itFdT0ARSwGbhg27RxSG7sFOPwRMw2113hC4gLa2jTotczz5EnvqPbdrhzGkGq/c/+WU7dFzi527UTGlaOj/SQiaOmmjM64CCMX6Kd8PcutKNhqPy4Vz4iv9hDWqihRDH+tuEiGOQVldJhIa1ycZZWWgfEZ1v5l6HM+A+ix4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWmOKv5y; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4518d9fa2f4so15711cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724173894; x=1724778694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnG3mTCoiILr908gRTdf9mnBK5WkLmZC0rD5sCvrluY=;
        b=JWmOKv5yFFrJYd0LYbJtplkPK52qutozBVpTDlR6h+LSHVOjhg/2SljhLQIvJ2HEQT
         +NNa8SD7+iSJfKA9KL+U2Ogypc/RK9UMZq2bPTXyrSme/uujKl349EEvAT3ITGGZBK62
         tBlrIe9SgCjTtx9JmA8eROKqjtV5WeB5KjOZsjtoGmWTinqVuLhTv5O601XQi4aeYVYg
         T70IWupGYoYP44H5SD6gORN8+FMaJIM+CJWXJF38Vk1zIF6sWECLdX9yGsOKELtiPcVX
         chxzwT2WtIBUY2XO36g+aSgU5ewta39r0aoyRdar4rChdI6kBTc1HGotditr/kHFXPni
         x9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724173894; x=1724778694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnG3mTCoiILr908gRTdf9mnBK5WkLmZC0rD5sCvrluY=;
        b=Rx87Rz27wNgbIG2MATP3z+NiBcYzrm6e7xTCubVryD3QiFyH425c4mlQ0Lg3oxdimz
         10tbaNoKjN6BRj8EeRsWB8xR4ylAE1zvMK/9AWpOWpw/f85PM4xhxWhFVIeD8Vz4KapG
         vW4LrGH7m463iUTs4OzWAgYVflywmNHvZi+LEP/A5l6fAFpcbziwm7oI8PkOAhY4IwYt
         Ue6Iq9kfUxfEJyga6dDSyKtffeudTgs0m2LojFNMbEVJtrpqfdZalvKzIwFTuNEJ09v3
         fYoKHcR0B8qR5B5MSMTGVKJIVExJE8kwRvBVqFXMuxazuv7yNw+x0YR4sdknUNY41zp5
         Av5w==
X-Forwarded-Encrypted: i=1; AJvYcCXa7UDSiLixskjKtWFcRmnegBLh1Z/LOhCKtfYHZhpt6F2We2VpDPOeG5u1pLqABLwF38JNYD85wV+qpq/8Pn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQAkfKEbK4Q5aa1XyJuOl05hVovFXPRnAb+8MAnHydsHX5rIxy
	jPJdlVpBUJAf4KTUf7PokQgdidgdVChqFHWbzvjV+TIIbW4pvNQ2QIRT+g4NSilXqiI46MXavph
	Xyk7baox5T+NLmU13MZSoC/4nU3GH/DBWrTEX
X-Google-Smtp-Source: AGHT+IEBYChI7KLbhDnxhptDasxvi66SSRGAyIIecU3g/9eHhycAcmIuoWtzgGhG2Nmu+KCELaheAYpAv+Ak2asKVEA=
X-Received: by 2002:a05:622a:5297:b0:453:5f2f:d5d2 with SMTP id
 d75a77b69052e-454e852f800mr2224121cf.1.1724173894153; Tue, 20 Aug 2024
 10:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813211317.3381180-4-almasrymina@google.com>
 <CAMArcTWWxjsg_zwS6waWkLpyHhwdXDm_NJeVGm_dr+eT5QDZiA@mail.gmail.com>
 <20240819155257.1148e869@kernel.org> <CAHS8izPL4YdqFjkTpYavdxQn816=kkUv0xravQJF4Uno7Bn3ZQ@mail.gmail.com>
 <20240820081920.6630a73f@kernel.org>
In-Reply-To: <20240820081920.6630a73f@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Aug 2024 13:11:20 -0400
Message-ID: <CAHS8izO-F2qwbEEtYONOYgNFsP3jxpv0etgSKknnAQ8itA5Cdw@mail.gmail.com>
Subject: Re: [PATCH net-next v19 03/13] netdev: support binding dma-buf to netdevice
To: Jakub Kicinski <kuba@kernel.org>
Cc: Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 11:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 20 Aug 2024 00:01:02 -0400 Mina Almasry wrote:
> > Took a bit of a look here. Forgive me, I'm not that familiar with XDP
> > and virtual interfaces, so I'm a bit unsure what to do here.
> >
> > For veth, it seems, the device behind the veth is stored in
> > veth_priv->peer, so it seems maybe a dev_get_max_mp_channel() check on
> > veth_priv->peer is the way to go to disable this for veth? I think we
> > need to do this check on creation of the veth and on the ndo_bpf of
> > veth.
>
> veth is a SW device pair, it can't reasonably support netmem.
> Given all the unreasonable features it grew over time we can't
> rule out that someone will try, but that's not our problem now.
>
> > For bonding, it seems we need to add mp channel check in bond_xdp_set,
> > and bond_enslave?
>
> Sort of, I'd factor out that logic into the core first, as some
> sort of "xdp propagate" helper. Then we can add that check once.
> I don't see anything bond specific in the logic.
>
> > There are a few other drivers that define ndo_add_slave, seems a check
> > in br_add_slave is needed as well.
>
> I don't think it's that broad. Not many drivers propagate XDP:
>
> $ git grep -C 200 '\.ndo_add_slave' | grep '\.ndo_bpf'
> drivers/net/bonding/bond_main.c-        .ndo_bpf                =3D bond_=
xdp,
>
> $ git grep --files-with-matches  'ops->ndo_bpf' -- drivers/
> drivers/net/bonding/bond_main.c
> drivers/net/hyperv/netvsc_bpf.c
>

OK, got it, I'll take a deeper look and hopefully figure out something
reasonable here.

> > This seems like a potentially deep rabbit hole with a few checks to
> > add all of the place. Is this blocking the series?
>
> Protecting the stack from unreadable memory is *the* challenge
> in this series. The rest is a fairly straightforward.

Understandable. I pulled the trigger on v21 with the build fix last
night after reading your response on the other thread. If you manage
to review that and let me know of any other issues I'm going to run
into down the road, that would be great. But I read in some other
thread that you're overloaded. Sorry if I'm piling on. Feel free to cr
it if necessary, of course.

--
Thanks,
Mina

