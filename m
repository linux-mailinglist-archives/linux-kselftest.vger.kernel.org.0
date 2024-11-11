Return-Path: <linux-kselftest+bounces-21762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081439C3989
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 09:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9091F211B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 08:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482C15625A;
	Mon, 11 Nov 2024 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVkaXjWN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC4A34CDD;
	Mon, 11 Nov 2024 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312983; cv=none; b=rEs74APCOnLJJeEiPpU3O8Ad+vm3Ah1GmhHm1jJ1Ed+dI7E3PAHFFNAhmeazpdN7xybLGbEIUgejKUnr+d0gXEuNPkHh3FAh3OZcX3BXqPucXxKuFuR7shcGbLCqCj1SrZVp4cqRF1U+eqkJub/N6gccjzVtawd63dHhYBOFjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312983; c=relaxed/simple;
	bh=CvWuTSrzn1MYiRXo4HHv/pu9OJZmr6o+cAVIp71XLSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egYvqhApFLsgvPQIDt+BjGWzNNIaKqtC7ddF4XueObiO6ca0qgoNccJIWDhutcG6gbxalsvWqblIzRvYd/yeGsCX5vhYqCPE/5Nlb3hoymVJJQA/hHEw5JT+tCYlRBZmEMYiWYmYiUGa4dLofHN61TUkpNRaSPvgXSFAqFcEL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVkaXjWN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e13375d3so4863770e87.3;
        Mon, 11 Nov 2024 00:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731312978; x=1731917778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUbsh5lk9ORk5a6JhzsZTbSIaemwBssH+oPBfubemEs=;
        b=KVkaXjWNIHXDPmc/q1Pa5wP/J1tGRvSzvzHY3Ecdc26wJChb3+nmX/Em4JH5qx5y1Y
         oUCOmTQBQQve7iTDI0dxtcRyG5RF2NWckWgj6M3D3ccowAK6HW0BHXsr0y6thjlUjCVI
         lL5ALN0HkErb+jCc04THKiifrkLor5V6NJzobvkpQID69PDPBVs9Et28Z7dMyoBpeJGL
         ouOXpVvbI05M9R7yXVMBegsqFIemTU8ppEzddvLRRM8RZLcrWQVfqXnmCakOFE0QdkLY
         goxFu9uRXvTIreskToctdExWEJsyLH57jNSbhMCZgAs3BDBJ6fL77G9Dw+Rq5GZBs8dk
         WCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731312978; x=1731917778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUbsh5lk9ORk5a6JhzsZTbSIaemwBssH+oPBfubemEs=;
        b=jnrvzndRJJGyt0Pqj22YSDti8PGmgwFXUeDdcDPDhRDsg/u8OhZDvNdIKpQ3iOrssI
         l7yKkuqpIO3osudxb5E/PeU0Q3+0EAU6uhONnA1Nw26cPQ+9Lh+Gs5/FPU46jCya42Pj
         8ZneLcfMcOHEbyneyf+qV6/Lqs1TMgCR1SlOSBxcPOD9r3Xa0SN9L+6SnpZI+E8pi7a4
         ph/zj11xI9gjvIyo5onMQ35Wp2VkfVpv1IiKBkVYeRlGm8KeDMbw35fUdE7Zm7Jsyat7
         BwhyKO01ISDFeLFKGEFeRzmLA9cZVPnBTv0/pJiETEGYW+0cW/S4pQNXs/mKqMyIGhCs
         FN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWB2sx1K2Hps30QOFpXG6shqofSdZQRwcnxl0JYtbOuvu9j9SRz8a3N3gyiRIAxfhNW9sw0dhx@vger.kernel.org, AJvYcCWI/jdrS42YHnJ6DwH3FGxPmAmmhdq+Dsl+RlyYKLe34RiesZnofWYGJTF9xuxqIVw0K6jPLAgODnZXi11hCUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2LSqpta73bbj6Lpf98hLGfSnZIEza9insNSfmtYMM3W7wEY8
	D1G67vocR3hVVwjgoFzRYajBKr8kw3wRLthm+uQSAGuVWjK70/mMgN8cr5iqSWIS6/AeWX9KauJ
	k7tWVEQg3zSdIWwQ59xTyYm21uAf+TMdxJoo=
X-Google-Smtp-Source: AGHT+IHsi6r0iqEhQb55qi+2O8RG/ybRgrSltax4PAwOp8HAL/yo2xqASaatijpdeTQ0Dq8FmUe9cshOcu+y+zzn8VU=
X-Received: by 2002:a05:6512:3f16:b0:539:d9e2:9d15 with SMTP id
 2adb3069b0e04-53d8623fffcmr4855226e87.29.1731312978149; Mon, 11 Nov 2024
 00:16:18 -0800 (PST)
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
 <20241109165907.4e9611a9@kernel.org>
In-Reply-To: <20241109165907.4e9611a9@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 11 Nov 2024 16:15:41 +0800
Message-ID: <CABAhCOQPw0zR1Cn7RoabjA0P-Onmpq_4jLgmtkTYpfZbFAOoGQ@mail.gmail.com>
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

On Sun, Nov 10, 2024 at 8:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 8 Nov 2024 14:44:37 +0800 Xiao Liang wrote:
> > > On Fri, 8 Nov 2024 00:53:55 +0800 Xiao Liang wrote:
> > > > IMO, this is about driver capability, not about user requests.
> > >
> > > The bit is a driver capability, that's fine. But the question was how
> > > to achieve backward compatibility. A flag in user request shifts the
> > > responsibility of ensuring all services are compatible to whoever
> > > spawns the interfaces. Which will probably be some network management
> > > daemon.
> >
> > OK. So I think we can change the driver capability indicator in rtnl_op=
s
> > to a tristate field, say, "linkns_support".
> > If it is
> >   - not supported, then keep the old behavior
> >   - supported (vlan, macvlan, etc.), then change to the new behavior
> >   - compat-mode (ip_tunnel), default to old behavior and can be changed
> >     via an IFLA flag.
> > Is this reasonable?
>
> Let's start with annotating the drivers which need the old behavior.
> It seems like something that was done as a workaround for old drivers,
> maybe there isn't that many of them and we can convert them all in one
> series.

I'd like to clarify a bit here.
Link netns is closely coupled with source netns, as it's passed to drivers
as source netns. Without introducing a flag, after applying the logic in
this patchset, drivers won't be able to distinguish the two:
  1) ip -n ns1 link add netns ns2 ...
  2) ip link add netns ns2 link-netns ns1 ...

There's no problem for drivers that already handle source netns.
But it changes the semantics of 1) for ip tunnels silently. The effective
link-netns is ns2 before, and will be changed to ns1 afterwards, which will
almost certainly affect some users. Is this acceptable? On the other hand,
do we need to deal with out-of-tree drivers?

