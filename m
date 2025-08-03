Return-Path: <linux-kselftest+bounces-38223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B354EB19183
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Aug 2025 03:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306FF1898DE6
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Aug 2025 02:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C85E139D0A;
	Sun,  3 Aug 2025 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="now1T+8F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625678F4F;
	Sun,  3 Aug 2025 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754186390; cv=none; b=KJ4rJ9h8TPo3vsqYkHz3X1LfF1HVFGPt+wJvIPOvdG5y8aRVD3d6dqLYrrDaj7GPR9Ge/w4K7pOOW5+Q6dfv1bzjI0MH+uIup+FO+fqaW+IO4FIWS6QVhQZiZ0APdh2P5rVc6p2hzoJQB7Y8fgkgopkM1e3RTg8fP/ClU0gOwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754186390; c=relaxed/simple;
	bh=7xxzzaIUkDZpjHvebKTMwNNXRDJHOgNvMeLcKTpohJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyXlUHfmkp37kCa/czNHVMkOSBhQnOA+BMyOTPJJztIy8VhjlSOjF5/krouflJmyMo1tjhTLshGrLJLWfXLeDMwJFESrhwHg9xgBLbykm8YwFAdtX5hdOVH0MkTUoTtS+GS2ZCyM8BERh+XFSwG/XOV9PtMr8C0NU87opRUt4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=now1T+8F; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e8fce318224so1422504276.3;
        Sat, 02 Aug 2025 18:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754186387; x=1754791187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4EBrLHzNBpyqXZsDLUIrvMpvt9RF3AvAcDj0XOR3Gg=;
        b=now1T+8FYpZVystyEdWXJwpjB81z0h7whNK7EFfVMsUjLHkha9R0Q94Mx2+H5ktS36
         IuiO+Yz+/wcsCgp5UNuqzjdaj9p01oVjC0UfxseLHaga7MQkICmifWYHdNI6z6W4sGDb
         R0uZo4eqXMpk0/ONr/35++E+1X9pH6AbLVX4V4LyzCDN62t9it6JcmwYzyC9sdLsNDQQ
         fwggOBU1bGTBGGzdvWd+QPbIHRiENg0xBpxlXXU+Vpd+2Co5EHKMg5+ku4ewCR2A6IUP
         lmnJ/i7O/kvCvalTUVLnoXX5a9OZAINjoV9CV5ygMNqYUcagh0mb3DXFYStMpmQLDJj4
         lu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754186387; x=1754791187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4EBrLHzNBpyqXZsDLUIrvMpvt9RF3AvAcDj0XOR3Gg=;
        b=cvtZqTTatoC4lUWACCWem4Mha7cZfsxjqOm5QBNyUsgq7cuN3hB1t9/BOe7uoryeOl
         uXytz2sd6KyCSisN42jcCjMO8+8ZpZWM3EmysKGjNJpOe3ovvuUasjqDX5xtnwGuaD+0
         qHsPIqruA+VXtzEtuBxg0TbqidQZdNv2/M+nepOuQW0mDjnjWLDUssSc1ksAbPzbLNS7
         qUmhb80x4+ATU2kfHu5qWbrCT2WY1HqIOdh+zNX1evPorj3O9ZyZIuzqmr9/Gorj+9D2
         UHiQ7kplR+UpWD/NPDaWmSmDPZGORzujAucuqsOmRJ0Ku332iIzfDwXwTzSQ4AGM5CA0
         fHQw==
X-Forwarded-Encrypted: i=1; AJvYcCUDxJW7QZq5U3UdrjcnKpy6INjKZURuHHv8yvJqJmvWVGHGFkAhUk5JjGNgqqJvZ/LfHNx+M2r7eF4IViOog+go@vger.kernel.org, AJvYcCVrmJW5TWYXK9CRUvNeX1jXGM+kcnqBXwUxQ3tmyU29J2hCl+bGh4HAas8Q05SL+72bobqFHgMHIuuxCbY=@vger.kernel.org, AJvYcCW91rOcnL87iZyfL35rElHkXoRtLgAM2NdGQAnx2cw+pIFzJCfW8l2OWJOANXOPL8amoNY7Vnjw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9f8fhi21ziT+jOSWT09sF5ZJ3tkL92H8ddPVpeC+uPTey/JTc
	syWRzfIRfGbASD0JJQYAZR3YCUmM2K+rxvnS0reorJbxpOpSdiUirX2W1ZilupUFHA4On8jLJoS
	4E/vG3ZhBRbyRpQ5TUdytBWdK9EtIiSk=
X-Gm-Gg: ASbGncsukK92hvFlADH8ouoQP6nJUqPUZZVq376QBadR83V4xXpcLRsX8P1ofO251C8
	/c5975EU47S/cmEydLyl2ysEWwKhD2UX4oTnzflEnJlWvKyQNF6wJmFN2vB/2oUvUpU3g7514Iu
	AXdYdKr84ZpfQ1GpS6lSJBZWyyppDuPH+5rqEIPxpJ9xnDgJMAWfoRpm/ckuCoryvmy2cTP1bR1
	7wlQNo=
X-Google-Smtp-Source: AGHT+IHdMArb5oY9+SbjkTyXx4Mi/+rR7KyxQCHfm18aG8shu/+6xhhDXqpMqp6eLdOwH9ejKXu8H0D7q9G+OO6K+Z8=
X-Received: by 2002:a05:690c:dd4:b0:719:6608:f488 with SMTP id
 00721157ae682-71b7f563da8mr65310027b3.38.1754186386612; Sat, 02 Aug 2025
 18:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802092435.288714-1-dongml2@chinatelecom.cn>
 <20250802092435.288714-2-dongml2@chinatelecom.cn> <CAL+tcoA9Lvc4Cj9zjWVx1FzEQA=d=OnvZRDWA4nE_1GNbEDaRw@mail.gmail.com>
In-Reply-To: <CAL+tcoA9Lvc4Cj9zjWVx1FzEQA=d=OnvZRDWA4nE_1GNbEDaRw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 3 Aug 2025 09:59:35 +0800
X-Gm-Features: Ac12FXwY7h6DUvCmyuv9kcdYwQeTgr2z-ladmjm0FPu_YVHOZUv8zUeUKrJzIo4
Message-ID: <CADxym3bD17eL0U0sQkuSZZgNtg7gmvzt0YAA+CiHf9Lw5-+awA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: tcp: lookup the best matched listen socket
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuniyu@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, kraig@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 9:06=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> Hi Menglong,
>
> On Sat, Aug 2, 2025 at 5:28=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > For now, the tcp socket lookup will terminate if the socket is reuse po=
rt
> > in inet_lhash2_lookup(), which makes the socket is not the best match.
> >
> > For example, we have socket1 and socket2 both listen on "0.0.0.0:1234",
> > but socket1 bind on "eth0". We create socket1 first, and then socket2.
> > Then, all connections will goto socket2, which is not expected, as sock=
et1
> > has higher priority.
> >
> > This can cause unexpected behavior if TCP MD5 keys is used, as describe=
d
> > in Documentation/networking/vrf.rst -> Applications.
> >
> > Therefor, we lookup the best matched socket first, and then do the reus=
e
>
> s/Therefor/Therefore
>
> > port logic. This can increase some overhead if there are many reuse por=
t
> > socket :/
> >
> > Fixes: c125e80b8868 ("soreuseport: fast reuseport TCP socket selection"=
)
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v3:
> > * use the approach in V1
> > * add the Fixes tag
> > ---
> >  net/ipv4/inet_hashtables.c  | 13 +++++++------
> >  net/ipv6/inet6_hashtables.c | 13 +++++++------
> >  2 files changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index ceeeec9b7290..51751337f394 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -389,17 +389,18 @@ static struct sock *inet_lhash2_lookup(const stru=
ct net *net,
> >         sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
> >                 score =3D compute_score(sk, net, hnum, daddr, dif, sdif=
);
> >                 if (score > hiscore) {
> > -                       result =3D inet_lookup_reuseport(net, sk, skb, =
doff,
> > -                                                      saddr, sport, da=
ddr, hnum, inet_ehashfn);
> > -                       if (result)
> > -                               return result;
> > -
> >                         result =3D sk;
> >                         hiscore =3D score;
> >                 }
> >         }
> >
> > -       return result;
> > +       if (!result)
> > +               return NULL;
> > +
> > +       sk =3D inet_lookup_reuseport(net, result, skb, doff,
> > +                                  saddr, sport, daddr, hnum, inet_ehas=
hfn);
> > +
> > +       return sk ? sk : result;
> >  }
>
> IMHO, I don't see it as a bugfix. So can you elaborate on what the exact
> side effect you're faced with is when the algorithm finally prefers
> socket2 (without
> this patch)?

Hi, Jason. The case is that the user has several NIC,
and there are some sockets that are binded to them,
who listen on TCP port 6666. And a global socket doesn't
bind any NIC and listens on TCP port 6666.

In theory, the connection request from the NIC will goto
the listen socket that is binded on it. When on socket
is binded on the NIC, it goto the global socket. However,
the connection request always goto the global socket, which
is not expected.

What's worse is that when TCP MD5 is used on the socket,
the connection will fail :/

More discussion can be found here:
https://lore.kernel.org/netdev/20250801090949.129941-1-dongml2@chinatelecom=
.cn/
https://lore.kernel.org/netdev/20250731123309.184496-1-dongml2@chinatelecom=
.cn/

>
> AFAIK, the current approach breaks the initial design and might make
> the whole lookup process take a longer time in certain cases like you men=
tioned.

Kuniyuki said he will post some patch when the net-next is
open, which reorder the socket in __inet_hash() to make
the reuseport socket lookup keep O(1).

So this patch is more like a temporary solution :/

Thanks!
Menglong Dong

>
> Thanks,
> Jason

