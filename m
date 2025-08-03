Return-Path: <linux-kselftest+bounces-38226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF89AB1931C
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Aug 2025 10:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC80218942BE
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Aug 2025 08:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643E2853EB;
	Sun,  3 Aug 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA795Tjv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A75413BC0C;
	Sun,  3 Aug 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754209968; cv=none; b=dxd2AwgchHP0uLZzLUjiEZMipPTW2j0GXcMPVq1/ITXblackahlYUHgn0N4iSEp4hhVWS8BGg1oZtkIU4M/ctV8xMlllZKoKNdwDo64nqh26Yfrq4/TMXKEbLV1dy97SVQmy7zhwK8I8wDmTbTs0rZ7gxnuyJpd4bl/zqKz7kUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754209968; c=relaxed/simple;
	bh=L/tWs7TQXW3M8NXy5kzPNzhdoGE1PBcsCj0Fe5DMbn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHVV11I4td4JWqFVeIi0OyAdel80UDgV5J0o1PKm7XZox9wCKgAZSQIko1cD7ihfQkXMqJMG0P2nMN0RUl8w+95VlRaX5gqKw6ahm9y4suu9kKFpmXm9pg90A7vpT81qboENfe8d2eUErbX9frDIQ1/DvI3Fi/dCsU0YWwybxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA795Tjv; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e3e926fdeaso12804485ab.1;
        Sun, 03 Aug 2025 01:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754209965; x=1754814765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGptu4dlFJlN2FLleMGpytAYYl0IldOCnrxkMnkN+SY=;
        b=PA795TjvY35tE2zWbKRabrWm9Qy/WM/BKpxuGhKNeFUKXEu5SUL2xrTZ7s8DE5i8Gl
         C7g80/w8N8t3h+lJ5h95JW8ROWmFjF9sIZOkYaJm5xhiR7jNTjMqFfnOhjlkY0SDFn50
         7ozjumLh7wQmQZGQsurZI1R9HgPCpZTFU1WlAJAfhQ/myKTPfLcvZkwxCL0h5GZMiXFW
         2KnLNZRX6i9iESHKcQYmHMorwAzfoBD8V8WFozYzJsHo2BaGVWIwztupYxGRansuIrk1
         txUxaaW3+cVf3CFwjqg35biR+BqAJtPeibZb1uCFPOxb1ChP0FOMNgPkdxRzZ0KMzsBi
         00tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754209965; x=1754814765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGptu4dlFJlN2FLleMGpytAYYl0IldOCnrxkMnkN+SY=;
        b=DGyzTHkIncc6SpRhRYRKzCGqTtoAu8w8C+LT4JDcWcokifWsopABaeA31r+VFMzPlg
         +2ZJPxCsSJCNsswVVWUCUN3sqGEuc/l3MaAN3O5qmzdoRgDjzpsAwzuYc5lr/b6PBeEo
         0IwlTgeyE6YdDrWf9tfDgdgaUO1aMpDp9LkaFH9Tcep5LPXJeP9YvrnWAu+a84kyS+OB
         Y2tRWPS3ZMRMSfAhZOGsvdDZDl6gdXrYx8J+1AAEP30gdGudIUnCUCLkFjXTUyLb+UIj
         hwVjVQ0g12tdo9CB5DLcbz6D24Cul8Tx5/0N+N+qJrNWTLqEa2UTQyxhoWFTkviJGKa5
         anaw==
X-Forwarded-Encrypted: i=1; AJvYcCVHVQsoFdCkBNdWqzlhMBhNu9ART2DtSIUrjzQX9+4EC3sjsO7+0UKRNs/ZTHq7gtqRQbOyZowzaeCNIvM=@vger.kernel.org, AJvYcCX4X122g+cE7yrwmtkPhvxnAj3ODynBD3EI/61vOjjkO4MV+U0CjSecrypIsbIT5JMUhT75gzj20YY4fiGjnh3T@vger.kernel.org, AJvYcCXARrOAKPVMJcgFNftCx1nP5OIp+6esa1ula/W8aDTzD2/k7hF6zdwPinWzi20PID3fxQpiwFXh@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzZ2fH7SvAdcHZqiOHbywHfbHPacGTaj4qsPfmnJeGPpDywo+
	LGceV6SJCLFyzVl2kJ5loqj/tJOdmvaOzSaiVPhHfXjxN+OLIe0KkbOk9BCpuLZZN4TvUU9XzY8
	JRDFRd7von9vTrFZKJJzc8FzFHUZn3+c=
X-Gm-Gg: ASbGncsf9CFsdTMnOcqtVfysFp55DQXKV79GZcYchTqc2r5N8uJJAfFY00Aob6V48fL
	vvZm0D7fWkz74PRcVw146vj8fasArXt3qaBufVbKuBAG5zPn25XSvdZz3W5qE3676o/YDcxEUzH
	xmNkCnlTxESwnnvBCFOg2oBBBfZV1MrrYaJk2+kvIwMIMaGTRGCCXAMNtgGhCsHwCpy3Fto01Io
	r7V/A==
X-Google-Smtp-Source: AGHT+IFhTkU7l2UqVGfqwF7nCUg1UKwPFl8Nan4P7yDxdVMZoT9FDfcoRochlQjN0/ueyGMb9s6CkkLANpHMO7BH9Vo=
X-Received: by 2002:a05:6e02:e46:b0:3e3:cc1b:2b5e with SMTP id
 e9e14a558f8ab-3e4161b0466mr75236065ab.15.1754209965117; Sun, 03 Aug 2025
 01:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802092435.288714-1-dongml2@chinatelecom.cn>
 <20250802092435.288714-2-dongml2@chinatelecom.cn> <CAL+tcoA9Lvc4Cj9zjWVx1FzEQA=d=OnvZRDWA4nE_1GNbEDaRw@mail.gmail.com>
 <CADxym3bD17eL0U0sQkuSZZgNtg7gmvzt0YAA+CiHf9Lw5-+awA@mail.gmail.com>
 <CAL+tcoD80feEhPA_1L7D55UqkRuLSnZ-Kmmdab5J2v9K6uCzTA@mail.gmail.com> <CADxym3Zv9+6D0hCEx1KzvW+oAQW5oEDgSHBQPyRjHodezH9O1g@mail.gmail.com>
In-Reply-To: <CADxym3Zv9+6D0hCEx1KzvW+oAQW5oEDgSHBQPyRjHodezH9O1g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 3 Aug 2025 16:32:08 +0800
X-Gm-Features: Ac12FXyvH1wDoI1PwTpkmNtbVXYnUCXDWNJtN74YGyKTIhg8liV-Ucw0p-QDGAc
Message-ID: <CAL+tcoCCq8Hc3R0_75wZxHUiZrjhfS-q65XFWM69F8pcoJPdyw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: tcp: lookup the best matched listen socket
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, kuniyu@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, kraig@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 12:00=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Sun, Aug 3, 2025 at 10:54=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Sun, Aug 3, 2025 at 9:59=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> > >
> > > On Sat, Aug 2, 2025 at 9:06=E2=80=AFPM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > > >
> > > > Hi Menglong,
> > > >
> > > > On Sat, Aug 2, 2025 at 5:28=E2=80=AFPM Menglong Dong <menglong8.don=
g@gmail.com> wrote:
> > > > >
> > > > > For now, the tcp socket lookup will terminate if the socket is re=
use port
> > > > > in inet_lhash2_lookup(), which makes the socket is not the best m=
atch.
> > > > >
> > > > > For example, we have socket1 and socket2 both listen on "0.0.0.0:=
1234",
> > > > > but socket1 bind on "eth0". We create socket1 first, and then soc=
ket2.
> > > > > Then, all connections will goto socket2, which is not expected, a=
s socket1
> > > > > has higher priority.
> > > > >
> > > > > This can cause unexpected behavior if TCP MD5 keys is used, as de=
scribed
> > > > > in Documentation/networking/vrf.rst -> Applications.
> > > > >
> > > > > Therefor, we lookup the best matched socket first, and then do th=
e reuse
> > > >
> > > > s/Therefor/Therefore
> > > >
> > > > > port logic. This can increase some overhead if there are many reu=
se port
> > > > > socket :/
> > > > >
> > > > > Fixes: c125e80b8868 ("soreuseport: fast reuseport TCP socket sele=
ction")
> > > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > > ---
> > > > > v3:
> > > > > * use the approach in V1
> > > > > * add the Fixes tag
> > > > > ---
> > > > >  net/ipv4/inet_hashtables.c  | 13 +++++++------
> > > > >  net/ipv6/inet6_hashtables.c | 13 +++++++------
> > > > >  2 files changed, 14 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtable=
s.c
> > > > > index ceeeec9b7290..51751337f394 100644
> > > > > --- a/net/ipv4/inet_hashtables.c
> > > > > +++ b/net/ipv4/inet_hashtables.c
> > > > > @@ -389,17 +389,18 @@ static struct sock *inet_lhash2_lookup(cons=
t struct net *net,
> > > > >         sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
> > > > >                 score =3D compute_score(sk, net, hnum, daddr, dif=
, sdif);
> > > > >                 if (score > hiscore) {
> > > > > -                       result =3D inet_lookup_reuseport(net, sk,=
 skb, doff,
> > > > > -                                                      saddr, spo=
rt, daddr, hnum, inet_ehashfn);
> > > > > -                       if (result)
> > > > > -                               return result;
> > > > > -
> > > > >                         result =3D sk;
> > > > >                         hiscore =3D score;
> > > > >                 }
> > > > >         }
> > > > >
> > > > > -       return result;
> > > > > +       if (!result)
> > > > > +               return NULL;
> > > > > +
> > > > > +       sk =3D inet_lookup_reuseport(net, result, skb, doff,
> > > > > +                                  saddr, sport, daddr, hnum, ine=
t_ehashfn);
> > > > > +
> > > > > +       return sk ? sk : result;
> > > > >  }
> > > >
> > > > IMHO, I don't see it as a bugfix. So can you elaborate on what the =
exact
> > > > side effect you're faced with is when the algorithm finally prefers
> > > > socket2 (without
> > > > this patch)?
> > >
> > > Hi, Jason. The case is that the user has several NIC,
> > > and there are some sockets that are binded to them,
> > > who listen on TCP port 6666. And a global socket doesn't
> > > bind any NIC and listens on TCP port 6666.
> > >
> > > In theory, the connection request from the NIC will goto
> > > the listen socket that is binded on it. When on socket
> > > is binded on the NIC, it goto the global socket. However,
> > > the connection request always goto the global socket, which
> > > is not expected.
> > >
> > > What's worse is that when TCP MD5 is used on the socket,
> > > the connection will fail :/
> >
> > I'm trying to picture what the usage can be in the userland as you
> > pointed out in the MD5 case. As to the client side, it seems weird
> > since it cannot detect and know the priority of the other side where a
> > few sockets listen on the same address and port.
>
> For the server side, it needs to add all the clients information
> with the TCP_MD5SIG option. For socket1 that binded on the
> eth0, it will add all the client addresses that come from eth0 to the
> socket1 with TCP_MD5SIG. So the server knows the clients.

Right, but I meant the _client_ side doesn't know the details of the
other side, that is to say, the server side needs to keep sure the
client server easily connects to your preferred listener regardless of
what the selection algorithm looks like. In terms of what you
depicted, I see your point. One question is if the kernel or API
provides any rules and instructions to the users that on the server
side the sk1 must be selected in your case? Is it possible for other
cases where the sk2 is the preferable/ideal one? I'm not sure if it's
worth 'fixing' it in the kernel.

Thanks,
Jason

