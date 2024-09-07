Return-Path: <linux-kselftest+bounces-17441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA296FF42
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 04:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E70B285224
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661AFA923;
	Sat,  7 Sep 2024 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqQ0UPAi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986D1CAAC;
	Sat,  7 Sep 2024 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725676464; cv=none; b=brubMpFgZyr4QcyEIciQzgRDCvRMlrBdwYfPEPA3jphZpS5sIjd0kuOqGzujrQkMRmdZDrwkqvjSGlC+nTIs3UhgwCgFkbFytN+jKOKOzuS9/DDiQkes6Az2JA97ZonJRqWQNCRWXk1zry9bNpHu51vK2GZvwl7iu/sSmIrwtas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725676464; c=relaxed/simple;
	bh=ffdA6a+g3V4pMBTMbEBpp2yeLzgZm3HSh4Yzd/8It48=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XpP78oA6h7XERg38Y0DW9wzGhfhS4djeHztYojMr2FLwfBTOt4czWeNBHw3GZyYAIbuo7gkwfliqdC2yeP8+sXdbUYtmEtJ7HprkUUyUd75Tq470JOPXLLibWfWJR4AbZQyYEHZ3Lt7gVxPYUwzr5QVxBAmk5RFEM5u7V/9REWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqQ0UPAi; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf7ad1ec3aso14516076d6.0;
        Fri, 06 Sep 2024 19:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725676461; x=1726281261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJ3SXJRC2SMu/cfheyyghxFS01PqyNM2ierurXAADHY=;
        b=jqQ0UPAizNhDaKcg+0EbRtgFMHgzZFtcfNqLZmEWdHmXfpH7RA6qVC3mEy+AW39Vcf
         sSvivQJ+fmFW4ZKAGpW29rTABjaLZxijJGjNfDmy9vLyt946gZvKFYN73M1/GOEfYWc2
         DZaUwVKqHBJ2Xn3i3pdc03dLdhbbem43BX5aPaTl3yHBQCHT677lKV0Ub7RmSuBE1G6j
         Bw527KOy7ugKua1VuRCaKOgmji0ousODyvZbPUypOjvoHNOgZj7KSDk+9aJwyPVJMHX6
         PD2rNawehSMfmfYLjJbMi7HuWVlvettdxd547PU6OvRcM0OsCoGJRPnfWGl8xmTYiVOU
         1g3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725676461; x=1726281261;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bJ3SXJRC2SMu/cfheyyghxFS01PqyNM2ierurXAADHY=;
        b=kFM6bJU0k5Bk4f2xD0cobjCi93ZKx0ZcEJ9PHkF/CjMBp5f0pYSeu70+Hp80NfV7kd
         BuGYSDGyuRwzwgjpZBYnOd8kVpYrXRCPsITWbNR64bocvBCnge1d9Hrtl6qM9CQ28IvD
         w6tKf3Vfsq8tLV4Sx2f767owGQT4vq7rE63SWc9cVleRM+dip0dEzBXzZSNX0fQwOblh
         4vpwtTwcO3lF0sLA45TdakNSBLONQnILUHnEA2WOV/z8Z9tTIh4n8viJFFK4ntUh+jhz
         rXYLOhWdwBXJVoyHD8q9V7zQF26VCSJaYQdUz104+tfSAbQw9qYR6Y/NQjzWsLbmqkbI
         jQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2IIM6VixBlys8LNN21QsRJF/i4RP3jy0vjm+DRvJssPJmaDRH3gF2zvWzAdp/DwzarY/aNh6h7rwdJZgrChk=@vger.kernel.org, AJvYcCUzNutt5fLFxbS/JsFygOYziiRuSm3UkZVzu2tZx5354/laVB8C1l4B+dTg7wdWbm7/btIIPBsB@vger.kernel.org
X-Gm-Message-State: AOJu0YwZc/r3Gw9bBx2DekJ/qVz/QDyWNkn/BjjHadLw6U1KWD/t2mRd
	Ac1nbCHBL8u9aW33/bvvCcwMMp60kGqyMI6KLuCKnewSoWvfPMVD
X-Google-Smtp-Source: AGHT+IE3Jg2Lm2rJxFSrhPlFKkQzTeWGDOc5DzpD/ksp2m6CYk1Vk1PcA3gnofdwugTPCm31chMtZg==
X-Received: by 2002:a05:6214:4293:b0:6c5:20c2:f33d with SMTP id 6a1803df08f44-6c532411aa5mr13261996d6.27.1725676461249;
        Fri, 06 Sep 2024 19:34:21 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474f8a2sm1062496d6.75.2024.09.06.19.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 19:34:20 -0700 (PDT)
Date: Fri, 06 Sep 2024 22:34:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66dbbbac6a6df_2b0bd0294d3@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoC9NoE3ws3nA-_ANAqD1cWpv9JDzFY11ACryZgg35dQrg@mail.gmail.com>
References: <20240906095640.77533-1-kerneljasonxing@gmail.com>
 <20240906095640.77533-2-kerneljasonxing@gmail.com>
 <66db8f293dbd1_2a33ef294b3@willemb.c.googlers.com.notmuch>
 <CAL+tcoC9NoE3ws3nA-_ANAqD1cWpv9JDzFY11ACryZgg35dQrg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/2] net-timestamp: introduce
 SOF_TIMESTAMPING_OPT_RX_FILTER flag
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Sat, Sep 7, 2024 at 7:24=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the receive
> > > path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> > > out rx software timestamp report, especially after a process turns =
on
> > > netstamp_needed_key which can time stamp every incoming skb.
> > >
> > > Previously, we found out if an application starts first which turns=
 on
> > > netstamp_needed_key, then another one only passing SOF_TIMESTAMPING=
_SOFTWARE
> > > could also get rx timestamp. Now we handle this case by introducing=
 this
> > > new flag without breaking users.
> > >
> > > Quoting Willem to explain why we need the flag:
> > > "why a process would want to request software timestamp reporting, =
but
> > > not receive software timestamp generation. The only use I see is wh=
en
> > > the application does request
> > > SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."
> > >
> > > Similarly, this new flag could also be used for hardware case where=
 we
> > > can set it with SOF_TIMESTAMPING_RAW_HARDWARE, then we won't receiv=
e
> > > hardware receive timestamp.
> > >
> > > Another thing about errqueue in this patch I have a few words to sa=
y:
> > > In this case, we need to handle the egress path carefully, or else
> > > reporting the tx timestamp will fail. Egress path and ingress path =
will
> > > finally call sock_recv_timestamp(). We have to distinguish them.
> > > Errqueue is a good indicator to reflect the flow direction.
> > >
> > > Suggested-by: Willem de Bruijn <willemb@google.com>
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> > High level: where is the harm in receiving unsolicited timestamps?
> > A process can easily ignore them. I do wonder if the only use case is=

> > an overly strict testcase. Was reminded of this as I tried to write
> > a more concise paragraph for the documentation.
> =

> You raised a good question.
> =

> I think It's more of a design consideration instead of a bugfix
> actually. So it is not solving a bug which makes the apps wrong but
> gives users a hint that we can explicitly and accurately do what we
> want and we expect.
> =

> Let's assume: if we remove all the report flags design, what will
> happen? It can work of course. I don't believe that people choose to
> enable the generation flag but are not willing to report it. Of
> course, It's another thing. I'm just saying.

Let's not debate the existing API. Its design predates both of our
contributions.

> I wonder if it makes sense to you :) ?

I don't see a strong use case. I know we're on v5 while I reopen that
point, sorry.

It seems simpler to me to not read spurious fields that are not
requested, rather than to explicitly request them to be set to zero.

Adding more flags is not free. An extra option adds mental load for
casual users of this alread complex API. This may certainly sound
hypocritical coming from me, as I added my fair share. But I hope
their functionality outweighs that cost (well.. in at least one case
it was an ugly fix for a bad first attempt.. OPT_ID). =


I got to this point trying to condense the proposed documentation.
We can add this if you feel strongly.

But then my main feedback is that the doc has to be shorter and to
the point. Why would a user user this? No background on how we got
here, what they might already do accidentally.
> >
> > Otherwise implementation looks fine, only the tiniest nit.
> >
> > > @@ -946,11 +946,17 @@ void __sock_recv_timestamp(struct msghdr *msg=
, struct sock *sk,
> > >
> > >       memset(&tss, 0, sizeof(tss));
> > >       tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > -     if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> > > +     if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > +          (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > +          skb_is_err_queue(skb) ||
> > > +          !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
> >
> > Nit: these statements should all align on the inner brace, so indent
> > by one character.
> =

> I'm not that sure about the format, please help me to review here:
> =

> @@ -946,11 +946,17 @@ void __sock_recv_timestamp(struct msghdr *msg,
> struct sock *sk,
> =

>         memset(&tss, 0, sizeof(tss));
>         tsflags =3D READ_ONCE(sk->sk_tsflags);
> -       if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> +       if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> +            (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> +             skb_is_err_queue(skb) ||
> +             !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
>             ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
>                 empty =3D 0;
>         if (shhwtstamps &&
> -           (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
> +           (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
> +            (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
> +             skb_is_err_queue(skb) ||
> +             !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
>             !skb_is_swtx_tstamp(skb, false_tstamp)) {
>                 if_index =3D 0;
>                 if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)=



That's right

  (A &&
   (B ||
    C))

> >
> > >           ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
> > >               empty =3D 0;
> > >       if (shhwtstamps &&
> > > -         (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
> > > +         (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
> > > +         (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
> =

> same here and the following two statements? Should I also indent by
> one char by the way?

Same rule on all new code introduced in the patch.

> > > +         skb_is_err_queue(skb) ||
> > > +         !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
> > >           !skb_is_swtx_tstamp(skb, false_tstamp)) {
> > >               if_index =3D 0;
> > >               if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDE=
V)
> > > --
> > > 2.37.3
> > >
> >
> >



