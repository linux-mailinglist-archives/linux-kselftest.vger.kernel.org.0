Return-Path: <linux-kselftest+bounces-25241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02411A1DAE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 18:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F443A33BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E8516DC28;
	Mon, 27 Jan 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DZC0O30Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236771BF37
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997269; cv=none; b=O+5HzAcZv5jWcjFdLDK8t/s6hHSl+GOoj1Mnz9tJuy4pmTSo+LXLMAsrimlexWlOX58GBX/5D8uh4Dzaq2mYxmB3LRXxYjANsORWQ5lSgF4EnjhAa81l2F+y0oLnhFGT65dUS0HOhe2t/yJKU9l+N6Y9StSBZ3lJJDjhCy7ngS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997269; c=relaxed/simple;
	bh=fAhzmysM+4YsKoiqSmWCg5tK+AJtumU10e08VN3+5j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkrDnbh75kbz8yV7YSDS4a7MMruR5bmgWJ9xGEh7TfXBfJCirVvLfzrLMefOhHhQ38VUV+jjVpqlOhzDe9YKOTCVCaPiEAwQdS2JO+SVj3BRIa3KtaaSOWnarFruYCcj+KwJcXqXrZvCJDw96Y06hGJ2NIdPOSijlLsZ1SJyd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DZC0O30Z; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d9b6b034easo9251636a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 09:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737997264; x=1738602064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xni1YlffT6WuljU2FB11nND4ecIYRsrK1TTa/h2ikA8=;
        b=DZC0O30ZDdH4iaBfJLQQkDFkbeffppeg3PW6eICuvix4zDCooXIJ8Udgv5Fht5VNKq
         nLBLHWYdHrAe5WQE9qe+i+xzh0jw7XaI16hOJRv0ht6VQyIPoiyARZL9D66iU4i70ffC
         viYELj+jSXs7hs+tuliH2PvNksH6Ia9b14n7cp4p1WXoHY+7UUShmdxTEKjZWlvO3RVx
         tp9RDV+DmxYwsS2S+eScc+gYPvvUFOFnsgxKa9qrv6NVEK/k2ztFsTFr2aIHS7AA8HRy
         8C0oIL4HxdriSB7bwauKMYLLlKddda0oQbWJHf5JDW7MLCA4BFH+W3lnvG4HcL+2dtEP
         CeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737997264; x=1738602064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xni1YlffT6WuljU2FB11nND4ecIYRsrK1TTa/h2ikA8=;
        b=jmLl97ElnrBx+njYll0W7sQwkaXbeEtQtjCGlzBQcwPXEkVb5v4jm+yHwqRLvBscjZ
         kmV30rsbzblChGlPGLWDixc4nsLxWa3G+02hhGJpTcBmdjsT5ahwVoesOXu4nrTKMScm
         yCpcr6TMHY+D6QGv8NEj5TLKgAobtkjW6oplzh1AWKNqqnRfWKpjpca9d0GICr+3wXsk
         hwOJQ0ppz906nZirr0On0lyDRYI04G9Gx9BPuvMiBLKX/P2gsJqCsizZ2RwGVi7q/z8P
         tKrqbs2kOb4/KAQbVKhwBxMvY89FWjDUCeg9uRp6NpXF0HJe18EweuX6+8CSL+S2gMMS
         Pomg==
X-Forwarded-Encrypted: i=1; AJvYcCV33I9//+psn4HZsMvbCfhyeh2KGixDSuC3w/FtgnboxC2wM1xCEmD42620ffE0JTjHtDRQPcc6VV9YOMjnxuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8vsznWplOOwmG/slb+sNZIzSguBWmO+jowFSNx1uQccALcG3/
	uioO9zBOK4leXHL70E1YS0LwTSC+eW88uovDrYx/Kri3fjSilTzK1zYwUsH3SNnEeinst/2EQ85
	snPPJSxhJyG/Nt36fMAsaESfdYxgbuNeFY08bSA==
X-Gm-Gg: ASbGncsZQje/O2t4DgcbdoKsSt2z+UK4+0bFBcLRFOhTg9ddD5cq/eTOICkp1tyNVhN
	tC/YFCSmltBuJy6Ay3nfQ8hILOLQsfEaOASp3dSWW9//TzvZJ3nvvYqCPjecgt5SFPpN21QRLv5
	IBBTI+mpr/0XhrUA==
X-Google-Smtp-Source: AGHT+IGWbWJEvuBh86k4gtUmzPcPqBNSMv7QrE1xCU7qKWF6GTcA4iSWVlgAk3aBy7jEGNUuwfqkHYAthxVfIhyJz0A=
X-Received: by 2002:a05:6402:274a:b0:5d9:cde9:29c6 with SMTP id
 4fb4d7f45d1cf-5db7db1d4d1mr36271840a12.27.1737997264130; Mon, 27 Jan 2025
 09:01:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z5cgWh/6bRQm9vVU@debian.debian> <6797992c28a23_3f1a294d6@willemb.c.googlers.com.notmuch>
In-Reply-To: <6797992c28a23_3f1a294d6@willemb.c.googlers.com.notmuch>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 27 Jan 2025 11:00:52 -0600
X-Gm-Features: AWEUYZnM9ZWbqRdENW5W0gV6x-Roqhp81QJIdbJGE-0oE6M1aLCpGKWczeYY8Mw
Message-ID: <CAO3-Pbqx_sLxdLsTg+NX3z1rrenK=0qpvfL5h_K-RX-Yk9A4YA@mail.gmail.com>
Subject: Re: [PATCH] udp: gso: fix MTU check for small packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Josh Hunt <johunt@akamai.com>, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

Thanks for getting back to me.

On Mon, Jan 27, 2025 at 8:33=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Yan Zhai wrote:
> > Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoided GSO
> > for small packets. But the kernel currently dismisses GSO requests only
> > after checking MTU on gso_size. This means any packets, regardless of
> > their payload sizes, would be dropped when MTU is smaller than requeste=
d
> > gso_size.
>
> Is this a realistic concern? How did you encounter this in practice.
>
> It *is* a misconfiguration to configure a gso_size larger than MTU.
>
> > Meanwhile, EINVAL would be returned in this case, making it
> > very misleading to debug.
>
> Misleading is subjective. I'm not sure what is misleading here. From
> my above comment, I believe this is correctly EINVAL.
>
> That said, if this impacts a real workload we could reconsider
> relaxing the check. I.e., allowing through packets even when an
> application has clearly misconfigured UDP_SEGMENT.
>
We did encounter a painful reliability issue in production last month.

To simplify the scenario, we had these symptoms when the issue occurred:
1. QUIC connections to host A started to fail, and cannot establish new one=
s
2. User space Wireguard to the exact same host worked 100% fine

This happened rarely, like one or twice a day, lasting for a few
minutes usually, but it was quite visible since it is an office
network.

Initially this prompted something wrong at the protocol layer. But
after multiple rounds of digging, we finally figured the root cause
was:
3. Something sometimes pings host B, which shares the same IP with
host A but different ports (thanks to limited IPv4 space), and its
PMTU was reduced to 1280 occasionally. This unexpectedly affected all
traffic to that IP including traffic toward host A. Our QUIC client
set gso_size to 1350, and that's why it got hit.

I agree that configurations do matter a lot here. Given how broken the
PMTU was for the Internet, we might just turn off pmtudisc option on
our end to avoid this failure path. But for those who hasn't yet, this
could still be confusing if it ever happens, because nothing seems to
point to PMTU in the first place:
* small packets also get dropped
* error code was EINVAL from sendmsg

That said, I probably should have used PMTU in my commit message to be
more clear for our problem. But meanwhile I am also concerned about
newly added tunnels to trigger the same issue, even if it has a static
device MTU. My proposal should make the error reason more clear:
EMSGSIZE itself is a direct signal pointing to MTU/PMTU. Larger
packets getting dropped would have a similar effect.

thanks
Yan

> >
> > Ideally, do not check any GSO related constraints when payload size is
> > smaller than requested gso_size, and return EMSGSIZE on MTU check
> > failure consistently for all packets to ease debugging.
> >
> > Fixes: 4094871db1d6 ("udp: only do GSO if # of segs > 1")
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> >  net/ipv4/udp.c                       | 18 ++++++++----------
> >  net/ipv6/udp.c                       | 18 ++++++++----------
> >  tools/testing/selftests/net/udpgso.c | 14 ++++++++++++++
> >  3 files changed, 30 insertions(+), 20 deletions(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index c472c9a57cf6..9aed1b4a871f 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1137,13 +1137,13 @@ static int udp_send_skb(struct sk_buff *skb, st=
ruct flowi4 *fl4,
> >       uh->len =3D htons(len);
> >       uh->check =3D 0;
> >
> > -     if (cork->gso_size) {
> > +     if (cork->gso_size && datalen > cork->gso_size) {
> >               const int hlen =3D skb_network_header_len(skb) +
> >                                sizeof(struct udphdr);
> >
> >               if (hlen + cork->gso_size > cork->fragsize) {
> >                       kfree_skb(skb);
> > -                     return -EINVAL;
> > +                     return -EMSGSIZE;
> >               }
> >               if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
> >                       kfree_skb(skb);
> > @@ -1158,15 +1158,13 @@ static int udp_send_skb(struct sk_buff *skb, st=
ruct flowi4 *fl4,
> >                       return -EIO;
> >               }
> >
> > -             if (datalen > cork->gso_size) {
> > -                     skb_shinfo(skb)->gso_size =3D cork->gso_size;
> > -                     skb_shinfo(skb)->gso_type =3D SKB_GSO_UDP_L4;
> > -                     skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(datale=
n,
> > -                                                              cork->gs=
o_size);
> > +             skb_shinfo(skb)->gso_size =3D cork->gso_size;
> > +             skb_shinfo(skb)->gso_type =3D SKB_GSO_UDP_L4;
> > +             skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(datalen,
> > +                                                      cork->gso_size);
> >
> > -                     /* Don't checksum the payload, skb will get segme=
nted */
> > -                     goto csum_partial;
> > -             }
> > +             /* Don't checksum the payload, skb will get segmented */
> > +             goto csum_partial;
> >       }
> >
> >       if (is_udplite)                                  /*     UDP-Lite =
     */
> > diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> > index 6671daa67f4f..6cdc8ce4c6f9 100644
> > --- a/net/ipv6/udp.c
> > +++ b/net/ipv6/udp.c
> > @@ -1385,13 +1385,13 @@ static int udp_v6_send_skb(struct sk_buff *skb,=
 struct flowi6 *fl6,
> >       uh->len =3D htons(len);
> >       uh->check =3D 0;
> >
> > -     if (cork->gso_size) {
> > +     if (cork->gso_size && datalen > cork->gso_size) {
> >               const int hlen =3D skb_network_header_len(skb) +
> >                                sizeof(struct udphdr);
> >
> >               if (hlen + cork->gso_size > cork->fragsize) {
> >                       kfree_skb(skb);
> > -                     return -EINVAL;
> > +                     return -EMSGSIZE;
> >               }
> >               if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
> >                       kfree_skb(skb);
> > @@ -1406,15 +1406,13 @@ static int udp_v6_send_skb(struct sk_buff *skb,=
 struct flowi6 *fl6,
> >                       return -EIO;
> >               }
> >
> > -             if (datalen > cork->gso_size) {
> > -                     skb_shinfo(skb)->gso_size =3D cork->gso_size;
> > -                     skb_shinfo(skb)->gso_type =3D SKB_GSO_UDP_L4;
> > -                     skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(datale=
n,
> > -                                                              cork->gs=
o_size);
> > +             skb_shinfo(skb)->gso_size =3D cork->gso_size;
> > +             skb_shinfo(skb)->gso_type =3D SKB_GSO_UDP_L4;
> > +             skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(datalen,
> > +                                                      cork->gso_size);
> >
> > -                     /* Don't checksum the payload, skb will get segme=
nted */
> > -                     goto csum_partial;
> > -             }
> > +             /* Don't checksum the payload, skb will get segmented */
> > +             goto csum_partial;
> >       }
> >
> >       if (is_udplite)
> > diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selft=
ests/net/udpgso.c
> > index 3f2fca02fec5..fb73f1c331fb 100644
> > --- a/tools/testing/selftests/net/udpgso.c
> > +++ b/tools/testing/selftests/net/udpgso.c
> > @@ -102,6 +102,13 @@ struct testcase testcases_v4[] =3D {
> >               .gso_len =3D CONST_MSS_V4,
> >               .r_num_mss =3D 1,
> >       },
> > +     {
> > +             /* datalen <=3D MSS < gso_len: will fall back to no GSO *=
/
> > +             .tlen =3D CONST_MSS_V4,
> > +             .gso_len =3D CONST_MSS_V4 + 1,
> > +             .r_num_mss =3D 0,
> > +             .r_len_last =3D CONST_MSS_V4,
> > +     },
> >       {
> >               /* send a single MSS + 1B */
> >               .tlen =3D CONST_MSS_V4 + 1,
> > @@ -205,6 +212,13 @@ struct testcase testcases_v6[] =3D {
> >               .gso_len =3D CONST_MSS_V6,
> >               .r_num_mss =3D 1,
> >       },
> > +     {
> > +             /* datalen <=3D MSS < gso_len: will fall back to no GSO *=
/
> > +             .tlen =3D CONST_MSS_V6,
> > +             .gso_len =3D CONST_MSS_V6 + 1,
> > +             .r_num_mss =3D 0,
> > +             .r_len_last =3D CONST_MSS_V6,
> > +     },
> >       {
> >               /* send a single MSS + 1B */
> >               .tlen =3D CONST_MSS_V6 + 1,
> > --
> > 2.30.2
> >
> >
>
>

