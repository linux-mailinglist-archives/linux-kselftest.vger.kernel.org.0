Return-Path: <linux-kselftest+bounces-21969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A526E9C7D46
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 22:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262681F23915
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 21:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D63208225;
	Wed, 13 Nov 2024 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyf4tI4R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22502076AC;
	Wed, 13 Nov 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531810; cv=none; b=LbOYXMnTew1ZLVJDRl5+10SB2HNlMjbqeP850xW9j2o48lpV/PePNynSYRg5dhFVyiCaqTSPn1uBHPcbxMAiA+PcUwkLdd7RtZcykHz8EmsKckErP7ESnOfOU7QoalhsEHXCku+d0iwV/5N5uxqBtV8uru/znYOQEcg5F6IhFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531810; c=relaxed/simple;
	bh=df8Jhjfgxmzoll9zuAh3oBx1+IrN1SraeFBEZKjpJSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TroeqlVzzm7PYYkuqGClQxlQk3wNny3W0TZvjWIjCba9kuBL/3oDHQO7+FzD7mVnxSWaI8/SF6pPM+DPqVNho3KLNxbMqWiz62fZtJS6I6Kw7xY5OE/R0JMVjhIt0rMpds7pYSsznqnveZODB9TlJ388zmIv1hzf+s1yrCa81hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eyf4tI4R; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so8556504a12.0;
        Wed, 13 Nov 2024 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731531806; x=1732136606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPZDRjkZp2UQ4v5l/V7kEPUCZovvc46WaZ2EY4B4s3o=;
        b=Eyf4tI4RV2wokt6MXNBycnTPMOBt1l+AuSxUK+b/dQu9695lhOS39+4sDXI0LWt2Ft
         PV1o6RrwNHFyD7LG4CV+OhsIZbVCVLi5pW6b6w47TFZhALxLtfntIzu7nLUdrDbHhnwJ
         K2J6917aWsTp7Gb7IMHBRWaYZDyazX2J1iBJo88FyhHZ5/+4OdbnebXIO9ly86pla0dJ
         rYGI5IU/HgxkgfY4mPI009bEi7iRLLCctS4AnsyLQHaTGjaWxBK3kGlc1qNfkEZHGIo1
         T0fhYmS8K/RXgzI1WsfnWUFmbowKImwRO0WKEyPcxQNK7kklk7xnOK94n6b3nsCLo72i
         AmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531806; x=1732136606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPZDRjkZp2UQ4v5l/V7kEPUCZovvc46WaZ2EY4B4s3o=;
        b=iyXnUK/nfmODDaauW0kHUQVz5f7xTagEL8JEdyyDhPsZFHDZEJdR9DdvY4tU4D9Pnl
         0CuhdcSs1tM9txdNmqAU7xgAcOYiLoue1+dcn/LHr3X9VUMp5J+50+hxGlUAdIBSWFP9
         r0OO+OROmy8anvNAfPFVx2qRzh4PjcrA+KlTHagAh9ZhHOjvCp8As22rvhwGr/nOxotb
         xcyXVbaYIAs+IUwwi7xaqcFCDI3V+Oa+lNUGNQVQ8FbiWg1Cb0orUk/IdInrue1UOdTg
         vBeI0iYpkidlRND3Bv+kgRe0/xb6ngneOKQ2EnFZ3Y3tkBCkl4iEKmOQN2nSaFeTAPO2
         z/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUcBm/MVSlUyt5Ku8rloplmNKI0dSETFU38NHgeARkfe987h8NHRHMzg97M5rUqEyJwlz6oySJAFVO3srflKuvy@vger.kernel.org, AJvYcCWkjtjrXjUEieyK1RpTDUSF4awwbxow28NbGvU0D9Vu7NUBtT3qwJ8izCdsPi6aAhDIOCunk5eRseXsWv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyButxUYH0vmsknfKa8fRJAA2nuqdaUbzN3UWtWBI9r9rdvPAtx
	tNFfxHuJ8UnZ1QvDPqA3JETo3VS/xidSTJJKJbZBVd6gS0ocDRFxTymZKQM6PRcFnK/J1JZuDn/
	z3ZeoOHFwJWGCWbDdvf2hzByvC5A=
X-Google-Smtp-Source: AGHT+IGMYQHc+QtLVmvA7os9F85G0u4mwOkY2J9B5HgYV06yTtzgLD6rVVFLheL/l73DP6ksZ1kk9yBrQqMrLKFZEvU=
X-Received: by 2002:a17:907:c2a:b0:a9e:c4df:e3c5 with SMTP id
 a640c23a62f3a-aa1f813b2fdmr406313866b.54.1731531805782; Wed, 13 Nov 2024
 13:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113125152.752778-1-liuhangbin@gmail.com> <20241113125152.752778-2-liuhangbin@gmail.com>
In-Reply-To: <20241113125152.752778-2-liuhangbin@gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 13 Nov 2024 13:03:13 -0800
Message-ID: <CAH5Ym4jjVFofG5J7QW=EsD00siDXtNWKt4ZDNbbUmP+Y4Jb-DQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/ipv6: delete temporary address if mngtmpaddr
 is removed or un-mngtmpaddr
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:52=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> RFC8981 section 3.4 says that existing temporary addresses must have thei=
r
> lifetimes adjusted so that no temporary addresses should ever remain "val=
id"
> or "preferred" longer than the incoming SLAAC Prefix Information. This wo=
uld
> strongly imply in Linux's case that if the "mngtmpaddr" address is delete=
d or
> un-flagged as such, its corresponding temporary addresses must be cleared=
 out
> right away.
>
> But now the temporary address is renewed even after =E2=80=98mngtmpaddr=
=E2=80=99 is removed
> or becomes unmanaged. Fix this by deleting the temporary address with thi=
s
> situation.

Hi Hangbin,

Is it actually a new temporary, or is it just failing to purge the old
temporaries? While trying to understand this bug on my own, I learned
about a commit [1] that tried to address the former problem, and it's
possible that the approach in that commit needs to be tightened up
instead.

[1]: 69172f0bcb6a09 ("ipv6 addrconf: fix bug where deleting a
mngtmpaddr can create a new temporary address")

>
> Fixes: 778964f2fdf0 ("ipv6/addrconf: fix timing bug in tempaddr regen")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/ipv6/addrconf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 94dceac52884..6852dbce5a7d 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -4644,6 +4644,10 @@ static void addrconf_verify_rtnl(struct net *net)
>                             !ifp->regen_count && ifp->ifpub) {
>                                 /* This is a non-regenerated temporary ad=
dr. */
>
> +                               if ((!ifp->valid_lft && !ifp->prefered_lf=
t) ||
> +                                   ifp->ifpub->state =3D=3D INET6_IFADDR=
_STATE_DEAD)
> +                                       goto delete_ifp;
> +

My understanding is that the kernel already calls
`manage_tempaddrs(dev, ifp, 0, 0, false, now);` when some `ifp` needs
its temporaries flushed out. That zeroes out the lifetimes of every
temporary, which allows the "destructive" if/elseif/elseif/... block
below to delete it. I believe fixing this bug properly will involve
first understanding why *that* mechanism isn't working as designed.

In any case, this 'if' block is for temporary addresses /which haven't
yet begun their regeneration process/, so this won't work to purge out
addresses that have already started trying to create their
replacement. That'll be a rare and frustrating race for someone in the
future to debug indeed. As well, I broke this 'if' out from the below
if/elseif/elseif/... to establish a clear separation between the
"constructive" parts of an address's lifecycle (currently, only
temporary addresses needing to regenerate) and the "destructive" parts
(the address gradually becoming less prominent as its lifetime runs
out), so destructive/delete logic doesn't belong up here anyway.

What are your thoughts?

Happy Wednesday,
Sam

>                                 unsigned long regen_advance =3D ipv6_get_=
regen_advance(ifp->idev);
>
>                                 if (age + regen_advance >=3D ifp->prefere=
d_lft) {
> @@ -4671,6 +4675,7 @@ static void addrconf_verify_rtnl(struct net *net)
>
>                         if (ifp->valid_lft !=3D INFINITY_LIFE_TIME &&
>                             age >=3D ifp->valid_lft) {
> +delete_ifp:
>                                 spin_unlock(&ifp->lock);
>                                 in6_ifa_hold(ifp);
>                                 rcu_read_unlock_bh();
> --
> 2.46.0
>

