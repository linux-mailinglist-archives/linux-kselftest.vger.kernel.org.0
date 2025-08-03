Return-Path: <linux-kselftest+bounces-38225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D993B192A3
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Aug 2025 06:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE29517AF59
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Aug 2025 04:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A80280A35;
	Sun,  3 Aug 2025 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkOJRJtE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E546280324;
	Sun,  3 Aug 2025 04:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754193620; cv=none; b=AjQq4DlIT8jSjCla1hamFRm9fzOZpPvE/otDCq3VsZI39EU/6utne4Y3pdY4pudBIWYxcabhvBWCih8eM9sHnc7CPXYS+DZJKVE8WejixHnN55vF4XBDAWiRqgfixGICXG3CjBOlLOxsKqVnRmcbLNUkB3ljr8A2oP/l58alVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754193620; c=relaxed/simple;
	bh=EteNC2zCH8s6Nui2tGkSvg+HWmcHSY+IYyqcC7iC/FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lc7z1igCc5cRYXAt/Gcv+0J3lH33Njm/2JOVphLv5YCGhg4vil41G/87At+AknvDL9QrIGLpjWIoduvP6RDohSFdTJci/PuHUM6r+3/jW9Opheh5SpmW6nOmCrPVA1JvjTVXsItN08ANmtpYbKx6R8dB1fYAtzn1YfkcY5iJQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkOJRJtE; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e8e0c6f1707so2535770276.0;
        Sat, 02 Aug 2025 21:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754193616; x=1754798416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZIp1+m+y2eRrLKBd6Kgz8eMGEFRtl0Yt1hUsetX1Oo=;
        b=bkOJRJtE4P6KyyT6UXIT5ldnCa98wCXaepXZ094wb7dG4KIW54Oagcetf2xfYx80qx
         H/V/uhg84fKkuK6KeVjlB12GQTk2WtVTeG4st2Fdez6GsfMRcCcRMuiWeb4FtYXY4UUv
         Ur00cOLmOwflTa5KD+ineishDGn9Yvb6GVx/myrucwteLqakt5A+An/hmhyrGrTU3chf
         0CWMr5TIe+jhZRSMtbna2m/z/MhyuSnYTqywnXbQ7NBycD9RcaDEsE+SxGQkC2z3b4aO
         Q6ZPk4nj4Mbg6ocq3bXgQ/n8hhkXt8dMhAL7mdInNw14eboomCklG3s4gX7WrUGzdSPg
         hz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754193616; x=1754798416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZIp1+m+y2eRrLKBd6Kgz8eMGEFRtl0Yt1hUsetX1Oo=;
        b=vxECvoRKXSOgpYzI5FaXItOWi1kBKwaeMKbsGAVcqZfaxUG2hN9cpUank1K3T/SNcV
         qiFBHcLTZy+8Ouh2MxUiJ12Dewit98EcuxhICfUCDZGZo7O1itHsJp9fsBb0Xx/pUVb0
         NI2E1F0iEI+iUz6sJQIYdgEhngVw9yW8ucHvVg2njiIqBLpKrXai/pEH/C/piti00gHZ
         v6n+l0vCne2/6oYlAdM6wWdbaGHpNHC9cuY8DFgipiAeVk4XVTwoMvXrMH+GZy4FmvRv
         skX+2qRs0Dl03hZyeuwLziVzq6KN4suBe3Jaft4Elzt7KCCDDBIGQ1l4vV68eZyqkfCc
         qhcw==
X-Forwarded-Encrypted: i=1; AJvYcCUrSAdFa6rwfPW2qamCxB2OW3NSwrIuDJwNuwaYeZbQUIOiUlNRtVdbF+gMnFwzSfhSVz5GAhhH2XO2oolSo3RK@vger.kernel.org, AJvYcCW9/SB6MytYivJT8UhLG+Af4ZOlUd6CUGPzhSapedI2rgFZ3WmNWWogjXUMvrGBdDVzgs4CfRutbq7gT5s=@vger.kernel.org, AJvYcCWaNszCq4QqRBoMi3+FOZGrlc3LI4lXUuwynI4/2Uio0zOqLUTwpFlhiHG4vjzGlzN0GDKOQVxp@vger.kernel.org
X-Gm-Message-State: AOJu0YwGc2UH++fby8S9qsz/7/u24UcWGhP1xk6HMw81zFMES8Jz9NSF
	D8H0u1RbP6tHwQkOhOizVP+8eFhPm2vUc6EBDnMXnr3JQE7R7S94txADS3+r0wIAs7LuTQR9SiA
	50zr2Eyo3ArLyHYb+db9Ib7xUmsfKHbk=
X-Gm-Gg: ASbGnctiMnawclWGvz+EMrbbcr+fzlZEkSmAMrVJ8wnuLXAI76FoFmcE2VaH3eNsDlo
	C2CIjEe33EOBBOKXZZNJgEXtmGbdX1nFtls0dWXITKOrAaRV1e71LBlZnB4JCmMrSvA77GccfiB
	V+PJfgav/okltDxSQJfhb1Zc7H6P/Q4FEHA7pCs2X7vnoAeEqMW+jQBhQha9pBBfuob0PmuzeaA
	/PBkto=
X-Google-Smtp-Source: AGHT+IGRKezLaBaD5lNnxjCdPo8wozwRxGnnhGXtRjSr2sORKHDDddFg1b7t1rAUAlbRZIKh51CMkaJQsKyqyWcUrJU=
X-Received: by 2002:a05:690c:6386:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-71b7ef85180mr70747847b3.32.1754193616246; Sat, 02 Aug 2025
 21:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802092435.288714-1-dongml2@chinatelecom.cn>
 <20250802092435.288714-2-dongml2@chinatelecom.cn> <CAL+tcoA9Lvc4Cj9zjWVx1FzEQA=d=OnvZRDWA4nE_1GNbEDaRw@mail.gmail.com>
 <CADxym3bD17eL0U0sQkuSZZgNtg7gmvzt0YAA+CiHf9Lw5-+awA@mail.gmail.com> <CAL+tcoD80feEhPA_1L7D55UqkRuLSnZ-Kmmdab5J2v9K6uCzTA@mail.gmail.com>
In-Reply-To: <CAL+tcoD80feEhPA_1L7D55UqkRuLSnZ-Kmmdab5J2v9K6uCzTA@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 3 Aug 2025 12:00:05 +0800
X-Gm-Features: Ac12FXwhn-RVEkWthzNOgyHXHXgTO0QeR6fL398tHcyF5igcD32LqzbCV2RjeIk
Message-ID: <CADxym3Zv9+6D0hCEx1KzvW+oAQW5oEDgSHBQPyRjHodezH9O1g@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: tcp: lookup the best matched listen socket
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuniyu@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, kraig@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 10:54=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Sun, Aug 3, 2025 at 9:59=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > On Sat, Aug 2, 2025 at 9:06=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > Hi Menglong,
> > >
> > > On Sat, Aug 2, 2025 at 5:28=E2=80=AFPM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > > >
> > > > For now, the tcp socket lookup will terminate if the socket is reus=
e port
> > > > in inet_lhash2_lookup(), which makes the socket is not the best mat=
ch.
> > > >
> > > > For example, we have socket1 and socket2 both listen on "0.0.0.0:12=
34",
> > > > but socket1 bind on "eth0". We create socket1 first, and then socke=
t2.
> > > > Then, all connections will goto socket2, which is not expected, as =
socket1
> > > > has higher priority.
> > > >
> > > > This can cause unexpected behavior if TCP MD5 keys is used, as desc=
ribed
> > > > in Documentation/networking/vrf.rst -> Applications.
> > > >
> > > > Therefor, we lookup the best matched socket first, and then do the =
reuse
> > >
> > > s/Therefor/Therefore
> > >
> > > > port logic. This can increase some overhead if there are many reuse=
 port
> > > > socket :/
> > > >
> > > > Fixes: c125e80b8868 ("soreuseport: fast reuseport TCP socket select=
ion")
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > ---
> > > > v3:
> > > > * use the approach in V1
> > > > * add the Fixes tag
> > > > ---
> > > >  net/ipv4/inet_hashtables.c  | 13 +++++++------
> > > >  net/ipv6/inet6_hashtables.c | 13 +++++++------
> > > >  2 files changed, 14 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.=
c
> > > > index ceeeec9b7290..51751337f394 100644
> > > > --- a/net/ipv4/inet_hashtables.c
> > > > +++ b/net/ipv4/inet_hashtables.c
> > > > @@ -389,17 +389,18 @@ static struct sock *inet_lhash2_lookup(const =
struct net *net,
> > > >         sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
> > > >                 score =3D compute_score(sk, net, hnum, daddr, dif, =
sdif);
> > > >                 if (score > hiscore) {
> > > > -                       result =3D inet_lookup_reuseport(net, sk, s=
kb, doff,
> > > > -                                                      saddr, sport=
, daddr, hnum, inet_ehashfn);
> > > > -                       if (result)
> > > > -                               return result;
> > > > -
> > > >                         result =3D sk;
> > > >                         hiscore =3D score;
> > > >                 }
> > > >         }
> > > >
> > > > -       return result;
> > > > +       if (!result)
> > > > +               return NULL;
> > > > +
> > > > +       sk =3D inet_lookup_reuseport(net, result, skb, doff,
> > > > +                                  saddr, sport, daddr, hnum, inet_=
ehashfn);
> > > > +
> > > > +       return sk ? sk : result;
> > > >  }
> > >
> > > IMHO, I don't see it as a bugfix. So can you elaborate on what the ex=
act
> > > side effect you're faced with is when the algorithm finally prefers
> > > socket2 (without
> > > this patch)?
> >
> > Hi, Jason. The case is that the user has several NIC,
> > and there are some sockets that are binded to them,
> > who listen on TCP port 6666. And a global socket doesn't
> > bind any NIC and listens on TCP port 6666.
> >
> > In theory, the connection request from the NIC will goto
> > the listen socket that is binded on it. When on socket
> > is binded on the NIC, it goto the global socket. However,
> > the connection request always goto the global socket, which
> > is not expected.
> >
> > What's worse is that when TCP MD5 is used on the socket,
> > the connection will fail :/
>
> I'm trying to picture what the usage can be in the userland as you
> pointed out in the MD5 case. As to the client side, it seems weird
> since it cannot detect and know the priority of the other side where a
> few sockets listen on the same address and port.

For the server side, it needs to add all the clients information
with the TCP_MD5SIG option. For socket1 that binded on the
eth0, it will add all the client addresses that come from eth0 to the
socket1 with TCP_MD5SIG. So the server knows the clients.

And in my use case, the TCP MD5 + VRF is used. The details are
a little fuzzy for me, which I need to do some recalling :/

>
> I'm not saying the priority problem doesn't exist, just not knowing
> how severe the case could be. It doesn't look that bad at least until
> now. Only the selection policy itself matters more to the server side
> than to the client side.
>
> Thanks,
> Jason

