Return-Path: <linux-kselftest+bounces-22007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978229C8413
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 08:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7A2B2167B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629461F470D;
	Thu, 14 Nov 2024 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfUCpb85"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E6163;
	Thu, 14 Nov 2024 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569903; cv=none; b=RkZKoqRR+vhBVmjyJo5K7Y9M22vuXV+xS1pd7IuaS8XbjAX+4s1ait+OTEKplPPUDiSCW7epBoYtfSswz4PlBDIhQGJ9Z5AY6ISr/od/RwEtOdnAAuZfDNfEWJcnkDp9WWnZ4dhsqBcokt7Bljb6THV3kPtKGSC7TEcF2fz5n4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569903; c=relaxed/simple;
	bh=DoaG7L2tJks6Eu49kxFyzHbl4qBvm8TIYvOkYdGwA3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrjaKW+e6/F7Sblm5HIcTKiKkOob6YEYs/7+n2cvrw/4SPFZtyx+vzs0gQH6NlsS/CXSopdou5fkxWIHFQ9jMGuWHPBhQYbGXBy+9y+n6nsE0Z2//D64C3fhgtCoEQL5PlQit07rTRy9p4UPnDhgQxkes1aQEU2guBRTJIKw50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfUCpb85; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca388d242so2496595ad.2;
        Wed, 13 Nov 2024 23:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731569901; x=1732174701; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rtwKh/oKxpbxO979Vri1eoXyrM0hY6TaMOPO6XEnukY=;
        b=LfUCpb859mjUbVnRWWFPI4F09Y5bV8Bms+oJAWWc8IAg1UHnG6Yu7VZ/hRG1RYSsXt
         p54AyJqQ7XfbwXAVThCv+VYhUGevrVlQLeuGr3G57DBy6cHQC4VXtMbG4+vbFOeZWcQJ
         u3pz2c1VabUT4YVf0JJ3B8G1Y/Lo92+E8rGL3El0wVEULHrGy+wsUPgykQ3QqZIGYRVD
         uIsolhSgFovflRpWTeT4vcdj7NYpYQ0cSR+RV8VTo2Fv8ViSLC06TbAzCdqPb7J/6ghv
         i8cPb36E9fPY+WyBabVPZ0VzvzomjIuHSNRMn2uPjHC+5c8zSAj6lN2PZ8h0i5VRLCIr
         boRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731569901; x=1732174701;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtwKh/oKxpbxO979Vri1eoXyrM0hY6TaMOPO6XEnukY=;
        b=JBNeQHWR0KagXczMleBPLLvNES1qZV/cS49FH9Z1w1IITZWZJv9T3C+VDqfoRiN5LG
         45hHm0r7a/c7f1VFVXL3RkUjskTTl+hoMT+gL9SoC+SdmrpeOJWClgdSElPVOF0iL5Lg
         tNqwItdxgTm0/VOuxXbxJGrC1dk3gtU76dd6bDOOig+gr5duH7uUiEKCV+xp64WO9CSy
         kwqba6jl3zf9CQvTQQZYX+RNKnL9zkoKlvMq1EMPzeuX6LUIks1K+WZ5nY/UEWG58LEn
         vxljVAt7rIgmZOD5e1kC0t43Omupv51RaALtb4Pz6g6Co7kNqwayJgf31pfVqLVgPz9O
         jaHw==
X-Forwarded-Encrypted: i=1; AJvYcCW12o0Z+4VQfOPf2QFDBwxDtNx3E7O3Rufu+WVZVg6S5UwmSrnE3sOihOoRUWNGB4o5JXfjpQBQ1HHfctU=@vger.kernel.org, AJvYcCXWkuI3OPAlIFdv/YtFDnuRNEHzPBMxmoYwnW8B7V3D3vJIIogpoD+8mrBhIw3SO1+YTsJ7Q7V5PzJ+558/eIwE@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVUz4EVzHTo1tZVkgvN4RWjYB3mwhF7xHBt2n8qtQ4RHUU63w
	ycaaGZmn1tWk7n0/fmXzRGTa17b86YsFeSY1YAs/fAiUvsWhkb30
X-Google-Smtp-Source: AGHT+IG1IdEuC/GDTlNvaVbmL9PdYgvIxvU86DIwT94igjJf3YtMEemSAX2PHNQ+ganrhLQMn6lZwQ==
X-Received: by 2002:a17:902:d50c:b0:20f:aee9:d8b8 with SMTP id d9443c01a7336-211c4fcd8eemr13599605ad.20.1731569900863;
        Wed, 13 Nov 2024 23:38:20 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c52643sm4823595ad.87.2024.11.13.23.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:38:20 -0800 (PST)
Date: Thu, 14 Nov 2024 07:38:13 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Xiao Ma <xiaom@google.com>
Subject: Re: [PATCH net 1/2] net/ipv6: delete temporary address if mngtmpaddr
 is removed or un-mngtmpaddr
Message-ID: <ZzWo5fJcraaDDLm_@fedora>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
 <20241113125152.752778-2-liuhangbin@gmail.com>
 <CAH5Ym4jjVFofG5J7QW=EsD00siDXtNWKt4ZDNbbUmP+Y4Jb-DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5Ym4jjVFofG5J7QW=EsD00siDXtNWKt4ZDNbbUmP+Y4Jb-DQ@mail.gmail.com>

On Wed, Nov 13, 2024 at 01:03:13PM -0800, Sam Edwards wrote:
> On Wed, Nov 13, 2024 at 4:52 AM Hangbin Liu <liuhangbin@gmail.com> wrote:
> >
> > RFC8981 section 3.4 says that existing temporary addresses must have their
> > lifetimes adjusted so that no temporary addresses should ever remain "valid"
> > or "preferred" longer than the incoming SLAAC Prefix Information. This would
> > strongly imply in Linux's case that if the "mngtmpaddr" address is deleted or
> > un-flagged as such, its corresponding temporary addresses must be cleared out
> > right away.
> >
> > But now the temporary address is renewed even after ‘mngtmpaddr’ is removed
> > or becomes unmanaged. Fix this by deleting the temporary address with this
> > situation.
> 
> Hi Hangbin,
> 
> Is it actually a new temporary, or is it just failing to purge the old
> temporaries? While trying to understand this bug on my own, I learned

1. If delete the mngtmpaddr with the mngtmpaddr flag. e.g.
`ip addr del 2001::1/64 mngtmpaddr dev dummy0`. The following code in
inet6_addr_del()

    if (!(ifp->flags & IFA_F_TEMPORARY) &&
        (ifa_flags & IFA_F_MANAGETEMPADDR))
            manage_tempaddrs(idev, ifp, 0, 0, false,
                             jiffies);

will be called and the valid_lft/prefered_lft of tempaddres will be set to 0.

2. If we using cmd `ip addr change 2001::1/64 dev dummy0`, the following code in
inet6_addr_modify():

    if (was_managetempaddr || ifp->flags & IFA_F_MANAGETEMPADDR) {
            if (was_managetempaddr &&
                !(ifp->flags & IFA_F_MANAGETEMPADDR)) {
                    cfg->valid_lft = 0;
                    cfg->preferred_lft = 0;
            }
            manage_tempaddrs(ifp->idev, ifp, cfg->valid_lft,
                             cfg->preferred_lft, !was_managetempaddr,
                             jiffies);
    }
will be called and valid_lft/prefered_lft of tempaddres will be set to 0.

But these 2 setting actually not work as in addrconf_verify_rtnl():

    if ((ifp->flags&IFA_F_TEMPORARY) &&
        !(ifp->flags&IFA_F_TENTATIVE) &&
        ifp->prefered_lft != INFINITY_LIFE_TIME &&
        !ifp->regen_count && ifp->ifpub) {
            /* This is a non-regenerated temporary addr. */

            unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);

            if (age + regen_advance >= ifp->prefered_lft) {

                 ^^ this will always true since prefered_lft is 0

So later we will call ipv6_create_tempaddr(ifpub, true) to create a new
tempaddr.

3. If we delete the mngtmpaddr without the mngtmpaddr flag. e.g.
`ip addr del 2001::1/64 dev dummy0` The following code in inet6_addr_del()

    if (!(ifp->flags & IFA_F_TEMPORARY) &&
        (ifa_flags & IFA_F_MANAGETEMPADDR))
            manage_tempaddrs(idev, ifp, 0, 0, false,
                             jiffies);

Will *not* be called as ifa_flags doesn't have IFA_F_MANAGETEMPADDR.
So in addrconf_verify_rtnl(), the (age + regen_advance >= ifp->prefered_lft)
checking will be false, no new tempaddr will be created. But the later
(ifp->valid_lft != INFINITY_LIFE_TIME && age >= ifp->valid_lft) checking is
also false unless the valid_lft is just timeout. So the tempaddr will be keep
until it's life timeout.

> about a commit [1] that tried to address the former problem, and it's
> possible that the approach in that commit needs to be tightened up
> instead.
> 
> [1]: 69172f0bcb6a09 ("ipv6 addrconf: fix bug where deleting a
> mngtmpaddr can create a new temporary address")

The situation in this patch is that the user removed the temporary address
first. The temporary address is not in the addr list anymore and
addrconf_verify_rtnl() won't create a new one. But later when delete the
mngtmpaddr, the manage_tempaddrs() is called again (because the mngtmpaddr
flag in delete cmd) and a new tempaddr is created.

> 
> >
> > Fixes: 778964f2fdf0 ("ipv6/addrconf: fix timing bug in tempaddr regen")
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  net/ipv6/addrconf.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index 94dceac52884..6852dbce5a7d 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -4644,6 +4644,10 @@ static void addrconf_verify_rtnl(struct net *net)
> >                             !ifp->regen_count && ifp->ifpub) {
> >                                 /* This is a non-regenerated temporary addr. */
> >
> > +                               if ((!ifp->valid_lft && !ifp->prefered_lft) ||
> > +                                   ifp->ifpub->state == INET6_IFADDR_STATE_DEAD)
> > +                                       goto delete_ifp;
> > +
> 
> My understanding is that the kernel already calls
> `manage_tempaddrs(dev, ifp, 0, 0, false, now);` when some `ifp` needs
> its temporaries flushed out. That zeroes out the lifetimes of every
> temporary, which allows the "destructive" if/elseif/elseif/... block
> below to delete it. I believe fixing this bug properly will involve
> first understanding why *that* mechanism isn't working as designed.

Please see the up comment.

> 
> In any case, this 'if' block is for temporary addresses /which haven't
> yet begun their regeneration process/, so this won't work to purge out
> addresses that have already started trying to create their
> replacement. That'll be a rare and frustrating race for someone in the
> future to debug indeed. As well, I broke this 'if' out from the below
> if/elseif/elseif/... to establish a clear separation between the
> "constructive" parts of an address's lifecycle (currently, only
> temporary addresses needing to regenerate) and the "destructive" parts
> (the address gradually becoming less prominent as its lifetime runs
> out), so destructive/delete logic doesn't belong up here anyway.

Currently my fix is checking the tempaddr valid_lft and ifp->ifpub->state.
Maybe we can delete the tempaddr direcly in ipv6_del_addr() and
inet6_addr_modify()?

Thanks
Hangbin
> 
> What are your thoughts?
> 
> Happy Wednesday,
> Sam
> 
> >                                 unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);
> >
> >                                 if (age + regen_advance >= ifp->prefered_lft) {
> > @@ -4671,6 +4675,7 @@ static void addrconf_verify_rtnl(struct net *net)
> >
> >                         if (ifp->valid_lft != INFINITY_LIFE_TIME &&
> >                             age >= ifp->valid_lft) {
> > +delete_ifp:
> >                                 spin_unlock(&ifp->lock);
> >                                 in6_ifa_hold(ifp);
> >                                 rcu_read_unlock_bh();
> > --
> > 2.46.0
> >

