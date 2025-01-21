Return-Path: <linux-kselftest+bounces-24884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1FFA1803A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0381883B63
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E491F3FCD;
	Tue, 21 Jan 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/X7J33z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B521F192A;
	Tue, 21 Jan 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470680; cv=none; b=XTCxZCNFTR2yC+azCrY3iRq3Upuz8mD3S6usuwMSnsigDRqWdN1Xnp/kBxP0Jop2yFzGlXucrkuGHBEIbRKX/dvh9gPhiYg7lJf1gYnUlbsEEPfLnxO2xxU4nbNseYFrOm4xpLoA1RBJQUH+2s8X4BVElBtFs7dq6fhcESQFCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470680; c=relaxed/simple;
	bh=dzv8d4QgxaaAASlgBbRSTstXZHFvO/eJVQg5Xx7cZgw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eaufTcutWi/dQhE+nqcmjFZ32Yjs1irrDB4BloGA0qAcwW4p67stHLi2p10QHpa/htQRzh/aq8dJI8eF3Mng260Ancy6MOss9OfkaJmeEgHQThAmEYpcW9a+Dvr5l30yO/d8Q5GH8ZhAWiVo7jV5q5V+5Wn/BqyAptIfvl5q77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/X7J33z; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be6fdeee35so221337485a.1;
        Tue, 21 Jan 2025 06:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737470677; x=1738075477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyktx4GLlCScfqAq7gUKHdqOkhKWGMD1Q4f5V2suP8g=;
        b=B/X7J33zaqIVYG9Gt91PxIxru1XEuQDbEUZli/8EyIfwzFv6OKjAFshQNbLd91SMz7
         +ccIrY6pJPcDGZtIr4ic9mjJnxTiVwEZFo2pLp4oD7krm5q5WmnitbARy2R+BNaMOTAa
         /eI13BCvUvo2GQpU4jGj3YK3snwXBUDJ87mavu9+6hop7NuaDKUVh1wM3kAtxaitfsWa
         UMBT5P0gMQc6h0XrFt9rcyBFzo3wwgqI68Z9/gP75OPcTurSvwYL+WZhSZNJdbDqbfSi
         yVOm0em1gEK5Ll7kmztzMkcvjBcr3rUwxhZObBUjfcebgAG0dOrqTfVc0PU5W8YRrBTu
         HkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470677; x=1738075477;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jyktx4GLlCScfqAq7gUKHdqOkhKWGMD1Q4f5V2suP8g=;
        b=t9sf9LxyNkaZe/HR3qC12bitndWVvuu0ZVIArn6GqnX1K1cuQ2cAOvtU1gl0kgptqZ
         GbYFVmMjRHs3/ppqtU7nRgETAjcmLVYcm5vqcGQJ21eScGXnExhy5V5XqK6GPm7JfiA5
         aklErK5jmjjycwCqfaOTcXB11boiqAO3L9mF+cnTBZ2T+exmZj7SvEqsTVxIQm+BMk6E
         no1VBv/piJQ8mwVP2C3Oi+bvjVF1jvhkddvQF6nut8uQPuU2BEln4GHGJ+TSLU2qObsm
         UW/CSUCymn/hPFyJmPWxxzc0jIoXEPXhDbHkIeP+ZhluLdQURnpko61muhSxrcx7bgcf
         OgNA==
X-Forwarded-Encrypted: i=1; AJvYcCVjiZ3st9m9UumbUWIz6qBQgtSb0AsqnP6gJbR4CZPzT8SAyUYFtdK15FMx5rsHoTPb/bc=@vger.kernel.org, AJvYcCW7vUIbOQjbmJvY/8bPAaRdMxQLJFHEzxMCqElrNN9oCk6jRqNWpviSJffBLZPGr8/ukjf8TXdtrUcfpARgFEjn@vger.kernel.org, AJvYcCWpYP9b1/lZrrECrAlrbdxGCHpJY+aWLwXZ0f/qmZ+CZKOkaO2koB8OyAGqeCwAeBHmlGl1ZMzM8sH1@vger.kernel.org, AJvYcCXfTR3+zSJBUi9DxiPm1/5xOAOmtFmIVEe6eIUh9Y2NsJrkGwkUCszNbg6IjLY6usPUoNY52gxF@vger.kernel.org, AJvYcCXhHPleVlBTcOBiG8pER/7fV6gDoA6JDmaFCP7Gu5fAR+bVnTmq8f+Sm30wFFrLkgwoyE4/HFRqAm0N7mb3@vger.kernel.org
X-Gm-Message-State: AOJu0YzicXvuEfTe9RalUBQ5vQfm/3uO8Q8TJ8qE+xjKoUgP393VNhY4
	35wHgRP3sSNWZ8e2oFqIoecQWVZNEBUjCLmhQliBQpSkjsgGNtMc
X-Gm-Gg: ASbGncuM7baROEVPWcz0FE/XnrXRNLy9eD+8cAif7reAd3ClzY1WLpcJUhupIRHsFLp
	aHH5CpLDdWJrtXsysfDL89vwc50gSc+GcQXCtsTWENvGfl7qmW3F0AWfZSLCN78HHUxKE0JFioR
	TPf1PRhAMbxzqQ4yzNCmAv2cHuZusXBVAMcRjNryTePiLDbhJC67w5jt+vT58DZJlurzNnJmjss
	0gL3G0AU3e4If1FSbiSgk4geAQkX7cWvXKoPqUOWgtCysIuz2l+8y0Jv/VZTvGyP91cCDc+HVQT
	Lvo4gD6TpRVSshs/bNlMJ30wzkP8n6EnG4QD3JLbmQ==
X-Google-Smtp-Source: AGHT+IHtIG5gIIPDS7Z+0e7uts4N1XZIUfZImZcQSkO2xO7BtbJzbDXJHLc7zxNeNompcCwG5inecg==
X-Received: by 2002:a05:620a:4416:b0:7b6:c4c7:ece6 with SMTP id af79cd13be357-7be6324fc40mr3090213285a.40.1737470677189;
        Tue, 21 Jan 2025 06:44:37 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e258c82a6sm34065981cf.59.2025.01.21.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:44:36 -0800 (PST)
Date: Tue, 21 Jan 2025 09:44:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com
Message-ID: <678fb2d43a668_23e15a294c5@willemb.c.googlers.com.notmuch>
In-Reply-To: <92675e51-cbaf-4905-8cf8-dff741a26db9@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
 <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
 <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com>
 <CACGkMEuPXDWHErCCdEUB7+Q0NxsAjpSH9uTvOxzuBvNeyw7_Hg@mail.gmail.com>
 <CA+FuTSec1z7-8nNNc1ZXkzekDrFHPnvYKFf8PNZg89VuwhoWSw@mail.gmail.com>
 <92675e51-cbaf-4905-8cf8-dff741a26db9@daynix.com>
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Akihiko Odaki wrote:
> On 2025/01/20 20:19, Willem de Bruijn wrote:
> > On Mon, Jan 20, 2025 at 1:37=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> >>
> >> On Fri, Jan 17, 2025 at 6:35=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>
> >>> On 2025/01/17 18:23, Willem de Bruijn wrote:
> >>>> Akihiko Odaki wrote:
> >>>>> tun and tap implements the same vnet-related features so reuse th=
e code.
> >>>>>
> >>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>> ---
> >>>>>    drivers/net/Kconfig    |   1 +
> >>>>>    drivers/net/Makefile   |   6 +-
> >>>>>    drivers/net/tap.c      | 152 +++++----------------------------=
----------------
> >>>>>    drivers/net/tun_vnet.c |   5 ++
> >>>>>    4 files changed, 24 insertions(+), 140 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> >>>>> index 1fd5acdc73c6..c420418473fc 100644
> >>>>> --- a/drivers/net/Kconfig
> >>>>> +++ b/drivers/net/Kconfig
> >>>>> @@ -395,6 +395,7 @@ config TUN
> >>>>>       tristate "Universal TUN/TAP device driver support"
> >>>>>       depends on INET
> >>>>>       select CRC32
> >>>>> +    select TAP
> >>>>>       help
> >>>>>         TUN/TAP provides packet reception and transmission for us=
er space
> >>>>>         programs.  It can be viewed as a simple Point-to-Point or=
 Ethernet
> >>>>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> >>>>> index bb8eb3053772..2275309a97ee 100644
> >>>>> --- a/drivers/net/Makefile
> >>>>> +++ b/drivers/net/Makefile
> >>>>> @@ -29,9 +29,9 @@ obj-y +=3D mdio/
> >>>>>    obj-y +=3D pcs/
> >>>>>    obj-$(CONFIG_RIONET) +=3D rionet.o
> >>>>>    obj-$(CONFIG_NET_TEAM) +=3D team/
> >>>>> -obj-$(CONFIG_TUN) +=3D tun-drv.o
> >>>>> -tun-drv-y :=3D tun.o tun_vnet.o
> >>>>> -obj-$(CONFIG_TAP) +=3D tap.o
> >>>>> +obj-$(CONFIG_TUN) +=3D tun.o
> >>>>
> >>>> Is reversing the previous changes to tun.ko intentional?
> >>>>
> >>>> Perhaps the previous approach with a new CONFIG_TUN_VNET is prefer=
able
> >>>> over this. In particular over making TUN select TAP, a new depende=
ncy.
> >>>
> >>> Jason, you also commented about CONFIG_TUN_VNET for the previous
> >>> version. Do you prefer the old approach, or the new one? (Or if you=
 have
> >>> another idea, please tell me.)
> >>
> >> Ideally, if we can make TUN select TAP that would be better. But the=
re
> >> are some subtle differences in the multi queue implementation. We wi=
ll
> >> end up with some useless code for TUN unless we can unify the multi
> >> queue logic. It might not be worth it to change the TUN's multi queu=
e
> >> logic so having a new file seems to be better.
> > =

> > +1 on deduplicating further. But this series is complex enough. Let's=
 not
> > expand that.
> > =

> > The latest approach with a separate .o file may have some performance=

> > cost by converting likely inlined code into real function calls.
> > Another option is to move it all into tun_vnet.h. That also resolves
> > the Makefile issues.
> =

> I measured the size difference between the latest inlining approaches. =

> The numbers may vary depending on the system configuration of course, =

> but they should be useful for reference.
> =

> The below shows sizes when having a separate module: 106496 bytes in to=
tal
> =

> # lsmod
> Module                  Size  Used by
> tap                    28672  0
> tun                    61440  0
> tun_vnet               16384  2 tun,tap
> =

> The below shows sizes when inlining: 102400 bytes in total
> =

> # lsmod
> Module                  Size  Used by
> tap                    32768  0
> tun                    69632  0
> =

> So having a separate module costs 4096 bytes more.
> =

> These two approaches should have similar tendency for run-time and =

> compile-time performance; the code is so trivial that the overhead of =

> having one additional module is dominant.

The concern raised was not about object size, but about inlined vs
true calls in the hot path.
 =

> The only downside of having all in tun_vnet.h is that it will expose it=
s =

> internal macros and functions, which I think tolerable.

As long as only included by tun.c and tap.c, I think that's okay.
The slow path code (ioctl) could remain in a .c file. But it's
simpler to just have the header file.

