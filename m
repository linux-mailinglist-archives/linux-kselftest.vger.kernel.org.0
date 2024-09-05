Return-Path: <linux-kselftest+bounces-17273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6DA96DE50
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2883E2828B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCED219DF4C;
	Thu,  5 Sep 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iab3Y6Km"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B281990DB;
	Thu,  5 Sep 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550286; cv=none; b=BZiUlOf6A6fiDdNsUvWbaaIN+4bqKQ8BRO9FTMY4mq/JoGDQHaP31MLIYsHvHhOIN2H7aAlYLvaVmfiUWtw3VfDbDRqJAo6E0qfjiZaom9As5l2qaKkV8nwkGY3IvUw9QUYkNSI30eIhvVdu0wI+T++HiHgeoyrAK3KU/mP3wCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550286; c=relaxed/simple;
	bh=3qSKRNoFJeMGhzpKKdaHesShYY9WfDvB5DAa4ArKzDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfTKu4Cdkl8H7WR69aid1LSTK7HcZ+c6ZI7zqe7pY73eLRod3SjUQ56bVtnnC3ELfmMErS8/LwpuPSs6seqa+xKpukVYuCFA5Zwc+QkoUadcbbnRv1nwfIw2wNd4WjKaC0jZ+aE5uSw9Ahuk0y9cVi2/AA699kjgtz3m6FIvjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iab3Y6Km; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d47a9ffd5so3536065ab.2;
        Thu, 05 Sep 2024 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725550283; x=1726155083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQU/bvfV/xkle3dsR1YIEyCBH1XFjDOKTJC5WMjIjhU=;
        b=iab3Y6KmyGg4Z0lw+xMbnXDD9YH32oXloLSUDUFlee0R4TBIy5vFY5PjEuZgyI0npy
         VFYG7YVw08m9i3nNL/NpJs8+L7nIHK4FM5ktxkWeN6z0YPTbIHDycBLO6GNOPgT7auZ4
         wqdgyhQtMZ1XdHt/MKFgufQMbu6ybJRBQrFh/qRK6KrquTkK+x3VVoEPtehpxC+cZSzJ
         oOVEp7DgZ8jLLbJzxxOxW/5Cwm/xxDD1aJxcwr9GcVOASKDtc+h0AdPP3Zd+MpqopA0J
         US4YR7SQXv+S6GFwOE1joMTYm3xBTDhKuYkSySpw2/u+myvAdaVBQmXNcVdGMndYfofG
         Lg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725550283; x=1726155083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQU/bvfV/xkle3dsR1YIEyCBH1XFjDOKTJC5WMjIjhU=;
        b=vY28ruGcJ2ql5XnmUuoIa/Ngj0xgG3Ga+Gb2iYOiGDt7zemlburgZ2HamXj1YJMryM
         2jmG2XAuu5g85CZAhQ2VwRhS0OPC2QH3ip1hXRdxdaa5XtM7+rHeuk0CkYpQqOBvzt41
         MizPYiWJRpH23jASYd/MOCsvPFf4AOej9qaEq7PIle9TmOROYBEIJ2+UhgSv59ulQT2/
         YNnoMleAb/ECQyJSpRPeWfSP4vmiZIt8H9no70WP9k0THA2aPZwyVWGM1MRF/X3uhnZH
         vqt40/bHEpgBmxTOySbRjbG2QzpQvfwcG8nF+IeFYD0sdcn9L8FKFsUnVtFDJMS4MCkz
         tihw==
X-Forwarded-Encrypted: i=1; AJvYcCUZaeXGAPKpSEtLpNm4XX4CsNE0s6A3z4e2qyXNWAdXSm/Mou76ojGvdPaLIJhbO+LTv8P94oxJ@vger.kernel.org, AJvYcCX2sPAgTOiwLMSBS3FheTyPZY3frCkPbEGHrqo5k4IaVuv22koCb/2fTfakkBgMVrP3VEfkESdTPCIuEG/ZFdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYWZiNSOSC5oL59gKunftVVF6il7YRspH1vM4wtwporojwj7i
	1YEfJh38JstR9/7iYx6UPWpQdql8TZX2XRHrxLB2w6dkpTfmbfCZ05PVMfkQm5EDI6oFqiBm+Gl
	WX8/8Mkj4z6IhcxpVOwnsLg7xzcE=
X-Google-Smtp-Source: AGHT+IHGOcaRFW8xUbuVT2VALw2V7xO9i+fBaPNmpwqw2UBeuEogQmYiPXFYwQ7+oYFdKbw7sktv/WrWoSLY4r3kjO8=
X-Received: by 2002:a05:6e02:1a4a:b0:3a0:4382:233b with SMTP id
 e9e14a558f8ab-3a043822499mr65173695ab.23.1725550283181; Thu, 05 Sep 2024
 08:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-4-kerneljasonxing@gmail.com> <66d9b5db807aa_18ac2129468@willemb.c.googlers.com.notmuch>
 <CAL+tcoBPJCP1yUTCe3CLDjBR6rd2BphxTV0bPMdXhh7_CAfOtA@mail.gmail.com> <66d9c45f8b419_18de4129492@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d9c45f8b419_18de4129492@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 23:30:47 +0800
Message-ID: <CAL+tcoDStC4c1XRT_xKgNJJxWC9-9zU=GEC1rbfHF7eWctQCVg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] net-timestamp: extend SOF_TIMESTAMPING_OPT_RX_FILTER
 for hardware use
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:46=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Thu, Sep 5, 2024 at 9:45=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > In the previous patch, we found things could happen in the rx softw=
are
> > > > timestamp. Here, we also noticed that, for rx hardware timestamp ca=
se,
> > > > it could happen when one process enables the rx hardware timestamp
> > > > generating flag first, then another process only setting
> > > > SOF_TIMESTAMPING_RAW_HARDWARE report flag can still get the hardwar=
e
> > > > timestamp.
> > > >
> > > > In this patch, we extend the OPT_RX_FILTER flag to filter out the
> > > > above case for hardware use.
> > > >
> > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > > Link: https://lore.kernel.org/all/20240903121940.6390b958@kernel.or=
g/
> > > > ---
> > > >  Documentation/networking/timestamping.rst | 15 +++++++++------
> > > >  net/core/sock.c                           |  5 +++--
> > > >  net/ipv4/tcp.c                            |  3 ++-
> > > >  net/socket.c                              |  3 ++-
> > > >  4 files changed, 16 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/Documentation/networking/timestamping.rst b/Documentat=
ion/networking/timestamping.rst
> > > > index ac57d9de2f11..55e79ea71f3e 100644
> > > > --- a/Documentation/networking/timestamping.rst
> > > > +++ b/Documentation/networking/timestamping.rst
> > > > @@ -268,12 +268,15 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
> > > >    each containing just one timestamp.
> > > >
> > > >  SOF_TIMESTAMPING_OPT_RX_FILTER:
> > > > -  Used in the receive software timestamp. Enabling the flag along =
with
> > > > -  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp to th=
e
> > > > -  userspace so that it can filter out the case where one process s=
tarts
> > > > -  first which turns on netstamp_needed_key through setting generat=
ion
> > > > -  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one only p=
assing
> > > > -  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx time=
stamp.
> > > > +  Used in the receive software/hardware timestamp. Enabling the fl=
ag
> > > > +  along with SOF_TIMESTAMPING_SOFTWARE/SOF_TIMESTAMPING_RAW_HARDWA=
RE
> > > > +  will not report the rx timestamp to the userspace so that it can
> > > > +  filter out the cases where 1) one process starts first which tur=
ns
> > > > +  on netstamp_needed_key through setting generation flags like
> > > > +  SOF_TIMESTAMPING_RX_SOFTWARE, or 2) similarly one process enable=
s
> > > > +  generating the hardware timestamp already, then another one only
> > > > +  passing SOF_TIMESTAMPING_SOFTWARE report flag could also get the
> > > > +  rx timestamp.
> > >
> > > I think this patch should be squashed into patch 1.
> > >
> > > Else SOF_TIMESTAMPING_OPT_RX_FILTER has two subtly different behavior=
s
> > > across its lifetime. Even if it is only two SHA1s apart.
> >
> > I thought about last night as well. Like the patch [2/4] and this
> > patch, the reason why I wanted to split is because I have to explain a
> > lot for both hw and sw in one patch. One patch mixes different things.
> >
> > No strong preference. If you still think so, I definitely can squash
> > them as you said :)
>
> No strong preference on 2/4. See other reply.
>
> In this case, patch 1/4 introduces some behavior and 3/4 immediately
> updates it. I think it makes more sense to combine them.

Roger that. Will squash this one:)

>
> > >
> > > It also avoids such duplicate changes to the same code/text blocks.
> > >
> > > More importantly, it matters for the behavior, see below.
> > >
> > > >
> > > >    SOF_TIMESTAMPING_OPT_RX_FILTER prevents the application from bei=
ng
> > > >    influenced by others and let the application choose whether to r=
eport
> > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > index 6a93344e21cf..dc4a43cfff59 100644
> > > > --- a/net/core/sock.c
> > > > +++ b/net/core/sock.c
> > > > @@ -908,8 +908,9 @@ int sock_set_timestamping(struct sock *sk, int =
optname,
> > > >           !(val & SOF_TIMESTAMPING_OPT_ID))
> > > >               return -EINVAL;
> > > >
> > > > -     if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> > > > -         val & SOF_TIMESTAMPING_OPT_RX_FILTER)
> > > > +     if (val & SOF_TIMESTAMPING_OPT_RX_FILTER &&
> > > > +         (val & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > > +          val & SOF_TIMESTAMPING_RX_HARDWARE))
> > > >               return -EINVAL;
> > >
> > > There may be legitimate use cases of wanting to receive hardware
> > > receive timestamps, plus software transmit timestamp, but
> > > suppress spurious software timestamps (or vice versa):
> > >
> > >     SOF_TIMESTAMPING_RAW_HARDWARE | \
> > >     SOF_TIMESTAMPING_RX_HARDWARE | \
> > >     SOF_TIMESTAMPING_SOFTWARE | \
> > >     SOF_TIMESTAMPING_TX_SOFTWARE | \
> > >     SOF_TIMESTAMPING_OPT_RX_FILTER

Sorry, I think my initial understanding at first read is not right. I
was thinking you want this combination to pass the check in
sock_set_timestamping().

If the users insist on receiving "hardware receive timestamps" with
OPT_RX_FILTER enabled in this case, I think we should implement
another new flag, say, OPT_RX_HARDWARE_FILTER...

> >
> > Oh, right, it can happen! RAW_HARDWARE is a little bit different,
> > covering both ingress and egress path.
>
> As said, it is a bit contrived. Feel free to disagree and keep as is
> too.

Well, I can keep it as is. It's easy for me, saving much energy,
but...you already pointed out/ noticed this kind of use case that is
not invalid.

If we want to tackle it well, we need to add a new flag for the
hardware case, then we can individually control each of them, which is
a more fine-grained control honestly. I'm totally fine with it as long
as it will be good for users in the long run :)

If so, adding a new patch into this series (like patch [3/4]) seems
inevitable. It won't take much time, I feel.

Any further thoughts?

Thanks,
Jason

