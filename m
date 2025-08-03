Return-Path: <linux-kselftest+bounces-38224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80451B1918E
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Aug 2025 04:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341713B7516
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Aug 2025 02:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8B515B135;
	Sun,  3 Aug 2025 02:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrBZGgck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788322E36FB;
	Sun,  3 Aug 2025 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754189652; cv=none; b=RSs9Z6LonNrE1skcJNpMqJZWTJB2HzGYbrJNGBPLd35kdjSFHxPg01iWQAtq84g5RMEr6ax1fEjfF1KhK1ZQZLIL3dAu7DYamqT4B8rSN6IDiDvc97w6Av7diaie9Xq6+9Viiyw372bzFh+MPKctZYUTINygUU3AxbT6i1wHDmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754189652; c=relaxed/simple;
	bh=i5zg9dp06My2AdumU4F4XvE57b+cADMB/udKTKb4Xm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKh2hJDPMw3sAvUq4myBN5BxJp8UzcdvLcDfGKqN7glbIfPXcd2dix5GnL16XQoWumBGdQEAuDy+rjNYZShXJgZ2r9L1EYYVlCdUFwLU7OYG9DzJQH+2hcnVnNyqei8M1UAXWJgmEgkcHfRTdfrDoyYmzgz/qdM7RgAtq38c9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrBZGgck; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e406ca2d22so10860245ab.1;
        Sat, 02 Aug 2025 19:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754189649; x=1754794449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSBQOyO1YxxtrbgAFsvcnP5ub0DcWzX6cTsHlYRNPx0=;
        b=CrBZGgckP7oVRlYpFHTFsqc4opURZiLJedCl0GKq/Budrcc4vsoCXOQPurkSAVH2zD
         nODP95s5EaN1UiDTIKsC8CB91cvjdVBHqlmMrJD7WtcTJydLSFZgYC/DdtG85je2PlRg
         ooqr7qDkTjZZAMjnxvOq79GgX7lb9XUHcL3U6tNk1EIMXo3f9W/mxoOw6zvkNzvdUvDs
         Dg2wyfvLm6eV03y4LB0h+u2hx75rDaXkH7wIpjQta5Dkekmeyb4uyJq9X8QdwM84xfIU
         iFL+W3p7zCF/X75C2kkBLnd3xvF8czuV9EaK78C0LfG32n70q1xWFI+NeKXSSZtqPWFL
         n5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754189649; x=1754794449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSBQOyO1YxxtrbgAFsvcnP5ub0DcWzX6cTsHlYRNPx0=;
        b=LpIAV+gNgJypangHXsFBvhmmlaOCu8vm3irCf6lLhisTXATq9SDLtKiRdFRMzRGJS9
         ikxDdKkCuCo7vBcwRbGZKzTZhSDbkQE8JCz2qiapFNt0yCCUdBeeRQCVYIrEbt9MSRDJ
         h6Z40y3o3+O7wUVBkLn/bUpQ8lJnLmu+mCe7TIbieckB4g4zRHMYtwStnUF1aPgf+BhD
         /Ru8mbj9ZuxxJ/d61OOGzZqhIdw6Ec49MdCi/21ecnQvFzzDbcLKs/MH1/L2+ZQYDen2
         uzEud1kJiSF+CrH+pmwPS0UpW4fr3yLzs0+dtWoIv90wCjEV7JKLo1ZQD2oTguj53Wki
         0Gyg==
X-Forwarded-Encrypted: i=1; AJvYcCU45Ygpn+kzkVqhaFL0g7kgfLo3J/wAVshSyyZAx9YcsZcN8XkFAihF03d6PemFChxBjLV6shM4Jdu7PDY=@vger.kernel.org, AJvYcCX0doqY3jr4sYZFhTou7j+EmtNygh+Byr5YLKrbnOtbMp5ZKLHoQuMAUwjvOyNv9QjI12mwhurcyTDqoBrhfAKk@vger.kernel.org, AJvYcCXXrSZ+p7mZsYICC/QLyF4bTw6L+zd4JT7OmITpiQDsysrxcjPnZBIvp2woxLEiEr6Sij6RaiYU@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1L2h8YynSLyfUP2G8mKhqJiZgCeoMc5zkD3Iy7oOPmE+6cT1
	TKlpNlOhJ/PlaTKGuMuxoaxSFG/8NrhsX8hgSYJrqodbBLKEYYDs43Tfx8vTQbO7+hDADrXRZRQ
	QPMQxPawSmiLBMxwz3hsXtebkjoZkueGesVbs
X-Gm-Gg: ASbGncv6cnbczagOmcurMCTcVw7m0BzyPWGlWsVlGmnQ3C05McqoV8kZljX+RSzRt6b
	Cnj0rf9abQriA2uXYs0Fg+FVcw7wuV5eROW6XiJxNC+rMho+rURem+aNStQiebGPHnNzlSi1nmh
	pV4EoMD5eoC3RECLrp9QJ37R3fwYgwFAk6osEMpuS4rh40odC5hXptPMoHAgzOuiDmGNBpLeVGJ
	KNAWg==
X-Google-Smtp-Source: AGHT+IFhp+C7EyfavFfz8rdUoksgW1KPXqWD5YKXj39eGN6oolxyzraCkT7Z/Djngvasr2P+508yhg+AnJf2zXsYtZQ=
X-Received: by 2002:a05:6e02:b:b0:3e2:aafc:a7f with SMTP id
 e9e14a558f8ab-3e416122d83mr105657555ab.7.1754189649367; Sat, 02 Aug 2025
 19:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802092435.288714-1-dongml2@chinatelecom.cn>
 <20250802092435.288714-2-dongml2@chinatelecom.cn> <CAL+tcoA9Lvc4Cj9zjWVx1FzEQA=d=OnvZRDWA4nE_1GNbEDaRw@mail.gmail.com>
 <CADxym3bD17eL0U0sQkuSZZgNtg7gmvzt0YAA+CiHf9Lw5-+awA@mail.gmail.com>
In-Reply-To: <CADxym3bD17eL0U0sQkuSZZgNtg7gmvzt0YAA+CiHf9Lw5-+awA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 3 Aug 2025 10:53:33 +0800
X-Gm-Features: Ac12FXyIHYBP7ll4VLREKjgO55d1UkdYoUNfR9ZfWnmxTQ6Tr3iprTEPvEgFY9k
Message-ID: <CAL+tcoD80feEhPA_1L7D55UqkRuLSnZ-Kmmdab5J2v9K6uCzTA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: tcp: lookup the best matched listen socket
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, kuniyu@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, kraig@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 9:59=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> On Sat, Aug 2, 2025 at 9:06=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > Hi Menglong,
> >
> > On Sat, Aug 2, 2025 at 5:28=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> > >
> > > For now, the tcp socket lookup will terminate if the socket is reuse =
port
> > > in inet_lhash2_lookup(), which makes the socket is not the best match=
.
> > >
> > > For example, we have socket1 and socket2 both listen on "0.0.0.0:1234=
",
> > > but socket1 bind on "eth0". We create socket1 first, and then socket2=
.
> > > Then, all connections will goto socket2, which is not expected, as so=
cket1
> > > has higher priority.
> > >
> > > This can cause unexpected behavior if TCP MD5 keys is used, as descri=
bed
> > > in Documentation/networking/vrf.rst -> Applications.
> > >
> > > Therefor, we lookup the best matched socket first, and then do the re=
use
> >
> > s/Therefor/Therefore
> >
> > > port logic. This can increase some overhead if there are many reuse p=
ort
> > > socket :/
> > >
> > > Fixes: c125e80b8868 ("soreuseport: fast reuseport TCP socket selectio=
n")
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > > v3:
> > > * use the approach in V1
> > > * add the Fixes tag
> > > ---
> > >  net/ipv4/inet_hashtables.c  | 13 +++++++------
> > >  net/ipv6/inet6_hashtables.c | 13 +++++++------
> > >  2 files changed, 14 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > > index ceeeec9b7290..51751337f394 100644
> > > --- a/net/ipv4/inet_hashtables.c
> > > +++ b/net/ipv4/inet_hashtables.c
> > > @@ -389,17 +389,18 @@ static struct sock *inet_lhash2_lookup(const st=
ruct net *net,
> > >         sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
> > >                 score =3D compute_score(sk, net, hnum, daddr, dif, sd=
if);
> > >                 if (score > hiscore) {
> > > -                       result =3D inet_lookup_reuseport(net, sk, skb=
, doff,
> > > -                                                      saddr, sport, =
daddr, hnum, inet_ehashfn);
> > > -                       if (result)
> > > -                               return result;
> > > -
> > >                         result =3D sk;
> > >                         hiscore =3D score;
> > >                 }
> > >         }
> > >
> > > -       return result;
> > > +       if (!result)
> > > +               return NULL;
> > > +
> > > +       sk =3D inet_lookup_reuseport(net, result, skb, doff,
> > > +                                  saddr, sport, daddr, hnum, inet_eh=
ashfn);
> > > +
> > > +       return sk ? sk : result;
> > >  }
> >
> > IMHO, I don't see it as a bugfix. So can you elaborate on what the exac=
t
> > side effect you're faced with is when the algorithm finally prefers
> > socket2 (without
> > this patch)?
>
> Hi, Jason. The case is that the user has several NIC,
> and there are some sockets that are binded to them,
> who listen on TCP port 6666. And a global socket doesn't
> bind any NIC and listens on TCP port 6666.
>
> In theory, the connection request from the NIC will goto
> the listen socket that is binded on it. When on socket
> is binded on the NIC, it goto the global socket. However,
> the connection request always goto the global socket, which
> is not expected.
>
> What's worse is that when TCP MD5 is used on the socket,
> the connection will fail :/

I'm trying to picture what the usage can be in the userland as you
pointed out in the MD5 case. As to the client side, it seems weird
since it cannot detect and know the priority of the other side where a
few sockets listen on the same address and port.

I'm not saying the priority problem doesn't exist, just not knowing
how severe the case could be. It doesn't look that bad at least until
now. Only the selection policy itself matters more to the server side
than to the client side.

Thanks,
Jason

