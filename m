Return-Path: <linux-kselftest+bounces-21845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F39C4E86
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 07:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022E9B24F6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 06:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11893208961;
	Tue, 12 Nov 2024 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyBItDH0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FCD41C79;
	Tue, 12 Nov 2024 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391560; cv=none; b=RssogFSZnGWkt2RU8L0/3AvsJJG1i317ZnZ2bPlFho9n7U5rMrIYoWbjJQLBrk3FLthm14Uy5qkbVdmVioC3Qn3JlTaVwpCrTgC6ts8iXEWZxDyh1JPalcxQq09pxyIwRgYuHszTM3bQygjU9trMw1Ydla2LRmSyYEGAFsJSs/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391560; c=relaxed/simple;
	bh=ZUyCxdls+plDLqbJr2VTOOcPKUiE7MlFJOoUxZ50hOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lciBp2gIkispUNl/8qwfEMQN0dFHoyAeEN1Fuf1z1J6SOM/pKQDArYHArHJuvT5zNUiJTKXG4rFEss1pDAKWPl7BV07zbexaMQf01iCJFcTDGkZ7V1aBAg7wlesZM9Hekl1vYUqw1ti5YeNqi3TTQgZmOS3NlRMAMoPl63HAYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyBItDH0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so44670445e9.3;
        Mon, 11 Nov 2024 22:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731391556; x=1731996356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0A9lZYdUK/icJ9Zb+gIbQQ7sJjx8G7bu3RQxEihDGo=;
        b=kyBItDH0Ft8DZRzdM9W3UxRzt8LZob23sinmGpAV2FPF/Q9bvPI0eijpU9eoqPhBmn
         YEOAH3yM3imNShb61ejLj7jTLq3Zc/s3wbs9wY1voIgxMafIgEx9bsLYLEuZlGCioxvu
         8VzmCzDSQ5yzSGXCiU4Dgh+0jRTz4CtMOE6kPcvHL5u/6MUwyA5A30sHnJ+Y8WQsqYaA
         CfAd7KLrJOzOf7MHvk6Awod+eqLX6Rn8LS44je+0mNR4N84eQ09Xl5ttaA0MPO//aSdQ
         KTbvwidUU/3Zluha00b5vw76ZfG3rowF6Z+b/i23UUum6V9Y9yCIBItTOInx212Fh278
         1ZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731391556; x=1731996356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0A9lZYdUK/icJ9Zb+gIbQQ7sJjx8G7bu3RQxEihDGo=;
        b=FLV45bLB3yiYRCI9PxYvs1tDKOmQyOCWZGbMUzC6/6CsBOwgFwZqIRMQSfPSbf3eN+
         lUOk+llgdRX2aNUa3vSQtyJusBGlMc4RvB2efsW3pgPfmwE00hJyBTrqwJ1pJimKqQDu
         4yIf3PAQHxdddRhE7m0UlRMEJScai2WDNnYOSkxZTpSntynB3LJOoyqyJTz/5efLG+zg
         yXSl6vZ40J/6fCyU2KnMeWpm6WAUW24allu1/zjW1BWbR19WfVJmuzIcdh+oA48T7Al0
         Pi8+y1MHr8HF+lGw36f1Pa46u8HZ/oGwTNcCuh5CYZgejR+yMseYRaPTCCJMwOAfHOLf
         Ywcw==
X-Forwarded-Encrypted: i=1; AJvYcCV1EAwK5rjSkjcirdtd6mHixn6lQ6whvNoumJaadtZEWe/WIh0wfsHGjmjykuQQKsEz3AYPdj0o@vger.kernel.org, AJvYcCXISIK4IhEfQZYIpRbk3GpmStGR/fpUrfRxvc2KVKARuWsYsmzcYxa7eIrenED6M3mVmNrxGxksS1Bu9WAIJpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3SrpSGU+TZQxChsokygJ70RbHW/IROzaRcsJ8gxohPnlaHpy
	JBlirFZ0aG8az8tyvntbnC4x+MV+5DrvT8t+36fPdGTi1JQ9znGl5CtqaJGPQo73WLOVNnSrCxp
	yYdg1LgxJsECPOEuaBL3jv+jgJAA=
X-Google-Smtp-Source: AGHT+IGsxBlWMF34oy/9sCbY9019KjGqt9NXdiKPSdyKGY5TCOO7fTU9/a5lPDpL8oXlzBwGZJWq0KIdkTm8d1QulYw=
X-Received: by 2002:a05:600c:3b05:b0:431:3b53:105e with SMTP id
 5b1f17b1804b1-432b7503f43mr132682105e9.9.1731391556315; Mon, 11 Nov 2024
 22:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107133004.7469-1-shaw.leon@gmail.com> <20241107133004.7469-6-shaw.leon@gmail.com>
 <CANn89iLvC0H+eb1q1c9X6M1Cr296oLTWYyBhqTAyGW_BusHA_A@mail.gmail.com>
 <CABAhCOS8WUqOsPCzQFcgeJbz-mkEV92OVXaH3E1tFe7=HRiuGg@mail.gmail.com>
 <20241107075943.78bb160c@kernel.org> <CABAhCOSvhUZE_FE4xFsOimzVBQpQYLNk51uYNLw+46fibzfM2Q@mail.gmail.com>
 <20241107200410.4126cf52@kernel.org> <CABAhCOSyG6sTWfDfoYDCbiXesDbGiWYFrK4OGi+3zFgO-CZPxA@mail.gmail.com>
 <20241109165907.4e9611a9@kernel.org> <CABAhCOQPw0zR1Cn7RoabjA0P-Onmpq_4jLgmtkTYpfZbFAOoGQ@mail.gmail.com>
 <20241111154226.5d7b29bf@kernel.org>
In-Reply-To: <20241111154226.5d7b29bf@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 12 Nov 2024 14:05:19 +0800
Message-ID: <CABAhCOTFyXVw=ucjMfHbgmLF_xe+Y=By_RixEnxFh+s4raS-sA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/8] net: ip_gre: Add netns_atomic module parameter
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 7:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 11 Nov 2024 16:15:41 +0800 Xiao Liang wrote:
> > > Let's start with annotating the drivers which need the old behavior.
> > > It seems like something that was done as a workaround for old drivers=
,
> > > maybe there isn't that many of them and we can convert them all in on=
e
> > > series.
> >
> > I'd like to clarify a bit here.
> > Link netns is closely coupled with source netns, as it's passed to driv=
ers
> > as source netns. Without introducing a flag, after applying the logic i=
n
> > this patchset, drivers won't be able to distinguish the two:
> >   1) ip -n ns1 link add netns ns2 ...
> >   2) ip link add netns ns2 link-netns ns1 ...
>
> True, but the question is how many drivers actually care about the net
> parameter. Ideally we would pass both netns to the drivers, refactor
> the ->newlink callback to take a parameter struct and add both netns
> as members. Passing just one or the other will always be confusing.
>

Got it, thanks. Will work on a v3.

> > There's no problem for drivers that already handle source netns.
> > But it changes the semantics of 1) for ip tunnels silently. The effecti=
ve
> > link-netns is ns2 before, and will be changed to ns1 afterwards, which =
will
> > almost certainly affect some users. Is this acceptable?
>
> No, changing the behavior for the commands you provided is not
> acceptable. At the same time we shouldn't be adding technical debt
> of supporting both converted and unconverted drivers upstream.
>
> > On the other hand, do we need to deal with out-of-tree drivers?
>
> Nope, but again, changing the prototype of newlink would also make it
> hard to get wrong for OOT modules.

