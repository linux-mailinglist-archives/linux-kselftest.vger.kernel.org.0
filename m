Return-Path: <linux-kselftest+bounces-39472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2B4B2F45C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 11:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20925163BF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCF32EAD01;
	Thu, 21 Aug 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="dKCWu4US"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m204-227.eu.mailgun.net (m204-227.eu.mailgun.net [161.38.204.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC6F2E1755
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.38.204.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769446; cv=none; b=e6mGpfjWebyppGIM+3mNcBChqsNM39YJ3OdRLeL7RNfggDgiC5hRNTj11E/FcM7rWZW7Mt7QNrk4Ljo/f0p0jPDiHs/rzKdRFGY3ivUoKY5mwWFN4yEioXqIPWDzcQjGTi+bwrZ7LsA1YyTLvQrA2F86alSVZxUm6Iw4coYdk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769446; c=relaxed/simple;
	bh=83cihqlEqrLgv3XLmOKKTdF4Z3MSPxjYWXhdRqDwMLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TM26C7aM4GFgBZDA0gtTvVlr9lUGJvtcy8ruPFy9c183N4sqJyEmSFVXqUgyXoWuNkAIncr3W4BLncqQqyKH8yqLE9OTBaN4dqp3ThOR9Rn48ZzsjnVlo8NUr5Z0GXz74f5DfEq1XzzT3ym2+kG+C7wSXVHGEfmEl/MP1WnFDtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=dKCWu4US; arc=none smtp.client-ip=161.38.204.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1755769442; x=1755776642;
 h=Content-Type: Cc: To: To: Subject: Subject: Message-ID: Date: From: From: In-Reply-To: References: MIME-Version: Sender: Sender;
 bh=ugKEM2SyYdaO/Rg696PMdoUOugJ5ms+2fB3pFprkEgY=;
 b=dKCWu4US4AnR7LkHQPLutN7WMCKuKVo/op0tLgrrz5BZv8j13aOR38cUQJmUisil5BBl4+Chmv3NjylNNNxfkUkZsEzs7jdYHTydqQ4ljCI4sL81N6Z7RJDVRIS5k34cVKeecTXns4sB2KBwR01F0cZC7dkz5vD1lVf4Rk52lTZtaNEaT/WFW2/sbaRUA97/rVSPu3UuhNIayqlzftK88WvxiBle8/LK4a/4+g4Rb/n61u2daikat/OCQ2x/6n2j5NHVypKya0xrN7YFFw6AQMLOV4GmqG4Jn+KCBeaPxOUrl3GuQD3miC6ab4ykb4USt8UTteTxf7Kay8wlXdkObg==
X-Mailgun-Sid: WyJlMmQxMSIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI1NGVmNCJd
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182]) by
 28760c5320251e6bcfb6e02fb9fae320767aca1d74f462755b6944c89a79a453 with SMTP id
 68a6ea62ca5807a38bbc11c9 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 21 Aug 2025 09:44:02 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Sender: alessandro@0x65c.net
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e934b5476a0so779593276.3;
        Thu, 21 Aug 2025 02:44:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaTS8oklPlW0k2UaAkjrpGGYNtlU2pbM30YJSh0vvG/toHC+XBC7b9a5M88ngYvkTW8jay1r2d@vger.kernel.org, AJvYcCX+OhZfKWQ+lFj0BDMO0xqeKISZp8357D18x+uYxFCRQsbxH8FOe5lUuXoTFaf5AeD9RjHpOaUAUpb3y3BocJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2e2sqcEHmSW0QLjLMirtL0ELd3bZVns6Z9IcTE+Dr/dYn99On
	bPY1FJKikPR20C5frPwxCs0KIgAL4Mpu0YA8h3hLS61ERb2nQFV342GVZOumDCq50GHtXlaCyUv
	5q+LJWTWh9him+be9VLkZjXuJuX6LNPQ=
X-Google-Smtp-Source: AGHT+IHyW5/7bNkwGxP3ivGbrp37X+DolCJeqLe9ofXaucYeQPqGUKVm7LnPENaErXYpXAowHUYHu5a3hpU54TgDVmA=
X-Received: by 2002:a05:690c:6212:b0:71f:9a36:d5c0 with SMTP id
 00721157ae682-71fc8b02ce9mr17495387b3.46.1755769441141; Thu, 21 Aug 2025
 02:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821074552.682731-1-alessandro@0x65c.net> <20250821074552.682731-2-alessandro@0x65c.net>
 <aKbX_CzxSi7T9Bcp@fedora> <CAKiXHKcLsEWbEz1EkzE942PbsMEpfj=wO7uYDb+Nxy8nGCEx1Q@mail.gmail.com>
 <aKbfzeS1QrP0dE4N@fedora>
In-Reply-To: <aKbfzeS1QrP0dE4N@fedora>
From: Alessandro Ratti <alessandro@0x65c.net>
Date: Thu, 21 Aug 2025 11:43:50 +0200
X-Gmail-Original-Message-ID: <CAKiXHKejzOAiieTxZpq8+v-vnzSEyuOuD0tYbzHL5R78iS+BMQ@mail.gmail.com>
X-Gm-Features: Ac12FXyj6ULNp4v4zjksz2jwkKV6qIhan8btkFWhOqkMdSr9nGRgg9JEdG0pdlE
Message-ID: <CAKiXHKejzOAiieTxZpq8+v-vnzSEyuOuD0tYbzHL5R78iS+BMQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: rtnetlink: add checks for ifconfig and iproute2
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Alessandro <alessandro@0x65c.net>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 10:59, Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> On Thu, Aug 21, 2025 at 10:45:19AM +0200, Alessandro wrote:
> > On Thu, 21 Aug 2025 at 10:25, Hangbin Liu <liuhangbin@gmail.com> wrote:
> > >
> > > On Thu, Aug 21, 2025 at 09:43:11AM +0200, Alessandro Ratti wrote:
> > > > On systems where `ifconfig` is not available (e.g., modern Debian), the
> > > > `kci_test_promote_secondaries` test fails. Wrap the call in a check.
> > > >
> > > > Additionally, `do_test_address_proto` fails on iproute2 versions that
> > > > lack support for `proto` in `ip address` commands. Add a minimal feature
> > > > check and skip the test with a proper message if unsupported.
> > > >
> > > > These changes allow the tests to run and report SKIP instead of FAIL on
> > > > platforms with older tools.
> > > >
> > > > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> > > > ---
> > > >  tools/testing/selftests/net/rtnetlink.sh | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> > > > index d6c00efeb664..9bff620ef595 100755
> > > > --- a/tools/testing/selftests/net/rtnetlink.sh
> > > > +++ b/tools/testing/selftests/net/rtnetlink.sh
> > > > @@ -330,7 +330,9 @@ kci_test_promote_secondaries()
> > > >       for i in $(seq 2 254);do
> > > >               IP="10.23.11.$i"
> > > >               ip -f inet addr add $IP/16 brd + dev "$devdummy"
> > > > -             ifconfig "$devdummy" $IP netmask 255.255.0.0
> > > > +             if command -v ifconfig >/dev/null 2>&1; then
> > > > +                     ifconfig "$devdummy" $IP netmask 255.255.0.0
> > > > +             fi
> > >
> > > Maybe just skip the promote_secondaries test if ifconfig is not available?
> > >
> >
> > Thank you for your review and comment.
> >
> > My takeaway here is that the test works because the IP addresses are set on the
> > $devdummy by the previous ip(8) command, and ifconfig seems a bit redundant.
>
> No, please check the git log to see why we use ifconfig here.
>

Ah! I see your point now. That said, yes, better skip the test if
ifconfig isn't installed.
I'll send out a new patch.

Thank you
Alessandro

