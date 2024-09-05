Return-Path: <linux-kselftest+bounces-17291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7769596DFF5
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FEF1F25B30
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B59319DF4F;
	Thu,  5 Sep 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSgyQT02"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD541487FF;
	Thu,  5 Sep 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554480; cv=none; b=p7Gr6fYWyI0LhgfLRi8QF7GUeS0cUnBHneTnIJ92BwpZpMjSGPuw1cSiImuA6c6bLJ602SWxj4NNRUIEEMXm27nZ2gm7XITLZnOoAnjpYdVKHR3z65pNrFa0BZH34r1jvpNKb8MidfAYObTts+gpki2WyCXrshDBgcNy8cPQe6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554480; c=relaxed/simple;
	bh=IL/3sg1cDmfKobwYW0LD8b6D5ANvT9icL5U+QNhzHvw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LPLKC9ejcGBj2jSCcCYYL6L/Y+5FMXgaSw3/L9ViZNNaROtIW1BaaTXPpbE/czKVFdGBkbIkOOJEYdtfVanwQ+Hm8jNMLT1VbrhZRPAbh7jYvePQ4rGwuWE2xF057+osJsvDFJb+9d6veVDZyU/yP4APtYmTSxlfV7eRnO5yGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSgyQT02; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4568571de47so5980191cf.3;
        Thu, 05 Sep 2024 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725554477; x=1726159277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQF16X0dHV0BPOlaSPh2+t5ILJRrMlLt855svT1Dgzw=;
        b=HSgyQT02cOTfjuUDnnlBaLnqIqdQzo+z/W4bbXTK/NedDYiuZfvNcScCLOInoj/ufW
         XJoGqMeG8YItkcjYWc0O9ngFFdS9Angp4XVYK2oRhnmkOHcSSDu7rMwmm7OAsY8A+023
         N3XgonuytPCvAd2Tzz0wMTTyR4kuILhH+21pCLRuufE0s3/TLfnXZ1ATkiarj7OCes4x
         RTzaoN+5wxWzwcc6foNAfoKxp2zjgVpkBEyOrvwN7TEuXbHosigqJpNWoQ4iJiVUAwc2
         8Cxgd3hJaUfMXhCwAuqvQs0hY3n+q8hYkVv9lC9yUKKRVG+fJb78q2M1p+w9z+af9z7C
         wKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725554477; x=1726159277;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EQF16X0dHV0BPOlaSPh2+t5ILJRrMlLt855svT1Dgzw=;
        b=u+6fHBET0ci1zdtRLf+IVw7qJLISI2eiPkAwt1qU3+zBDev0L3jqTFyryf4VRrH/OT
         0B9AHk0Vxr73EynBv0VHu0ae90h7ldkO/5To9F5GCWzOPTo9EuMwSc1fAIN4KbU+9hpD
         4lzFJf4qkjLYpXGfJ/jWS308/HPXIGN1o+QnwRuvbbnCr0ry/oknqf3JOb20YyvwCT18
         venXGHF1lhN16Ns/FuxsjIu6Wt4exVrXQmdTgT8uE7wcLDTxkhBZvVKZjU97vzmGC/Wo
         ObU92xGsKAyWvGfnUeri26ym2QPK8amTt0oPRUQpZ5XH2B1IXYSb/s+fhl6DP34R8F8t
         d/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVue1CNAeSI7/ZXtumyhnhOhHL9LMF+tsyHLZrb8raoGEe4ZIEggJ0Npd9+8m9AkI1icGNL7lISMCh3LpgWnPI=@vger.kernel.org, AJvYcCXnkNi5+qWW37BHsXfW8+nPT50WKyTlJrJmWdtrv0j5Egr/6TjISxWfW9nY/SQfDkV7EE0Mhxvk@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9lPGMWN8sDQqnrIg7nhTU0WhSFq7zmqKLOqk68TZoZcjiJpC
	emgZEcQtwgwqLgtF2PIIH2kewmGXO2EQtWn7XxFoZERcTJnOKjnK
X-Google-Smtp-Source: AGHT+IEm1sd4YrR4CIAgtE7fSvrBm4nLx/U61Dhelc0m1/BjeYnz0HtyQWDm+fs99jmx1hCldcu5rQ==
X-Received: by 2002:a05:622a:5e15:b0:44f:ddaa:c21b with SMTP id d75a77b69052e-456fd7b4d4bmr224540301cf.23.1725554477204;
        Thu, 05 Sep 2024 09:41:17 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b327edsm8545701cf.28.2024.09.05.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:41:16 -0700 (PDT)
Date: Thu, 05 Sep 2024 12:41:16 -0400
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
Message-ID: <66d9df2c33de1_1eae1a294d6@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDStC4c1XRT_xKgNJJxWC9-9zU=GEC1rbfHF7eWctQCVg@mail.gmail.com>
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-4-kerneljasonxing@gmail.com>
 <66d9b5db807aa_18ac2129468@willemb.c.googlers.com.notmuch>
 <CAL+tcoBPJCP1yUTCe3CLDjBR6rd2BphxTV0bPMdXhh7_CAfOtA@mail.gmail.com>
 <66d9c45f8b419_18de4129492@willemb.c.googlers.com.notmuch>
 <CAL+tcoDStC4c1XRT_xKgNJJxWC9-9zU=GEC1rbfHF7eWctQCVg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] net-timestamp: extend
 SOF_TIMESTAMPING_OPT_RX_FILTER for hardware use
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
> On Thu, Sep 5, 2024 at 10:46=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Thu, Sep 5, 2024 at 9:45=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > In the previous patch, we found things could happen in the rx s=
oftware
> > > > > timestamp. Here, we also noticed that, for rx hardware timestam=
p case,
> > > > > it could happen when one process enables the rx hardware timest=
amp
> > > > > generating flag first, then another process only setting
> > > > > SOF_TIMESTAMPING_RAW_HARDWARE report flag can still get the har=
dware
> > > > > timestamp.
> > > > >
> > > > > In this patch, we extend the OPT_RX_FILTER flag to filter out t=
he
> > > > > above case for hardware use.
> > > > >
> > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > > Link: https://lore.kernel.org/all/20240903121940.6390b958@kerne=
l.org/
> > > > > ---
> > > > >  Documentation/networking/timestamping.rst | 15 +++++++++------=

> > > > >  net/core/sock.c                           |  5 +++--
> > > > >  net/ipv4/tcp.c                            |  3 ++-
> > > > >  net/socket.c                              |  3 ++-
> > > > >  4 files changed, 16 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/networking/timestamping.rst b/Docume=
ntation/networking/timestamping.rst
> > > > > index ac57d9de2f11..55e79ea71f3e 100644
> > > > > --- a/Documentation/networking/timestamping.rst
> > > > > +++ b/Documentation/networking/timestamping.rst
> > > > > @@ -268,12 +268,15 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
> > > > >    each containing just one timestamp.
> > > > >
> > > > >  SOF_TIMESTAMPING_OPT_RX_FILTER:
> > > > > -  Used in the receive software timestamp. Enabling the flag al=
ong with
> > > > > -  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp t=
o the
> > > > > -  userspace so that it can filter out the case where one proce=
ss starts
> > > > > -  first which turns on netstamp_needed_key through setting gen=
eration
> > > > > -  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one on=
ly passing
> > > > > -  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx =
timestamp.
> > > > > +  Used in the receive software/hardware timestamp. Enabling th=
e flag
> > > > > +  along with SOF_TIMESTAMPING_SOFTWARE/SOF_TIMESTAMPING_RAW_HA=
RDWARE
> > > > > +  will not report the rx timestamp to the userspace so that it=
 can
> > > > > +  filter out the cases where 1) one process starts first which=
 turns
> > > > > +  on netstamp_needed_key through setting generation flags like=

> > > > > +  SOF_TIMESTAMPING_RX_SOFTWARE, or 2) similarly one process en=
ables
> > > > > +  generating the hardware timestamp already, then another one =
only
> > > > > +  passing SOF_TIMESTAMPING_SOFTWARE report flag could also get=
 the
> > > > > +  rx timestamp.
> > > >
> > > > I think this patch should be squashed into patch 1.
> > > >
> > > > Else SOF_TIMESTAMPING_OPT_RX_FILTER has two subtly different beha=
viors
> > > > across its lifetime. Even if it is only two SHA1s apart.
> > >
> > > I thought about last night as well. Like the patch [2/4] and this
> > > patch, the reason why I wanted to split is because I have to explai=
n a
> > > lot for both hw and sw in one patch. One patch mixes different thin=
gs.
> > >
> > > No strong preference. If you still think so, I definitely can squas=
h
> > > them as you said :)
> >
> > No strong preference on 2/4. See other reply.
> >
> > In this case, patch 1/4 introduces some behavior and 3/4 immediately
> > updates it. I think it makes more sense to combine them.
> =

> Roger that. Will squash this one:)
> =

> >
> > > >
> > > > It also avoids such duplicate changes to the same code/text block=
s.
> > > >
> > > > More importantly, it matters for the behavior, see below.
> > > >
> > > > >
> > > > >    SOF_TIMESTAMPING_OPT_RX_FILTER prevents the application from=
 being
> > > > >    influenced by others and let the application choose whether =
to report
> > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > index 6a93344e21cf..dc4a43cfff59 100644
> > > > > --- a/net/core/sock.c
> > > > > +++ b/net/core/sock.c
> > > > > @@ -908,8 +908,9 @@ int sock_set_timestamping(struct sock *sk, =
int optname,
> > > > >           !(val & SOF_TIMESTAMPING_OPT_ID))
> > > > >               return -EINVAL;
> > > > >
> > > > > -     if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> > > > > -         val & SOF_TIMESTAMPING_OPT_RX_FILTER)
> > > > > +     if (val & SOF_TIMESTAMPING_OPT_RX_FILTER &&
> > > > > +         (val & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > > > +          val & SOF_TIMESTAMPING_RX_HARDWARE))
> > > > >               return -EINVAL;
> > > >
> > > > There may be legitimate use cases of wanting to receive hardware
> > > > receive timestamps, plus software transmit timestamp, but
> > > > suppress spurious software timestamps (or vice versa):
> > > >
> > > >     SOF_TIMESTAMPING_RAW_HARDWARE | \
> > > >     SOF_TIMESTAMPING_RX_HARDWARE | \
> > > >     SOF_TIMESTAMPING_SOFTWARE | \
> > > >     SOF_TIMESTAMPING_TX_SOFTWARE | \
> > > >     SOF_TIMESTAMPING_OPT_RX_FILTER
> =

> Sorry, I think my initial understanding at first read is not right. I
> was thinking you want this combination to pass the check in
> sock_set_timestamping().
> =

> If the users insist on receiving "hardware receive timestamps" with
> OPT_RX_FILTER enabled in this case, I think we should implement
> another new flag, say, OPT_RX_HARDWARE_FILTER...

My interpretation of the OPT_RX_FILTER flag is:

Only return RX timestamps if the socket also has the corresponding
reporting flag set.

So it is valid to have

  SOF_TIMESTAMPING_RAW_HARDWARE |
  SOF_TIMESTAMPING_RX_HARDWARE |
  SOF_TIMESTAMPING_SOFTWARE |
  SOF_TIMESTAMPING_OPT_RX_FILTER

To filter out the software rx timestamps, but let through the
hardware rx timestamps.

> =

> > >
> > > Oh, right, it can happen! RAW_HARDWARE is a little bit different,
> > > covering both ingress and egress path.
> >
> > As said, it is a bit contrived. Feel free to disagree and keep as is
> > too.
> =

> Well, I can keep it as is. It's easy for me, saving much energy,
> but...you already pointed out/ noticed this kind of use case that is
> not invalid.
> =

> If we want to tackle it well, we need to add a new flag for the
> hardware case, then we can individually control each of them, which is
> a more fine-grained control honestly. I'm totally fine with it as long
> as it will be good for users in the long run :)
> =

> If so, adding a new patch into this series (like patch [3/4]) seems
> inevitable. It won't take much time, I feel.
> =

> Any further thoughts?
> =

> Thanks,
> Jason



