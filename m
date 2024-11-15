Return-Path: <linux-kselftest+bounces-22120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 094369CF657
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 21:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62921F22719
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124F1E1049;
	Fri, 15 Nov 2024 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afyWifYD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232D13FD72;
	Fri, 15 Nov 2024 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703602; cv=none; b=IS9U1eJL7GywoxvIXL1hH3dfn+M6BOJwkAkfbUf/OmZnWW3mL8FOy/XJxvWWMZwRu8LamMd8NNTbOrSQ9a84o/vY17e1QrArStCyfxVkgtrfsfR1WGP9P1l7UVZkrCUtZP+O+tvRoLiCGPsxpcbWeJDqMmnI/OL+UnBxvoLmBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703602; c=relaxed/simple;
	bh=SB6sRlYQPJX2cnmx7fApoRfkpOkQyL+KPr2/h03YT7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFixUy4wBSBjc36zRPysCHwL0DY5doC+Y+GFQSIjowJMpkfWZsDsEpzA0GVeShs/2ygc74W33V+DAuPebHchUWdzXitH4UrouBa1bcrGhlL3DoOPFsCZKXT/XvYXWkwKjcPpK34qWy4Eit7t7PTCz6O0wjaub/VvGj/bjqn+yTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afyWifYD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a850270e2so4494666b.0;
        Fri, 15 Nov 2024 12:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731703598; x=1732308398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yq6wiZr07zyT2tdDH94tcWOKQWvPr647j2FSkk0F3Q=;
        b=afyWifYDw3xNyXhNjggqMNqjRDMS8naUtXKEpV0aEz94nW4liOZqL3E/9Iu0w/biPX
         jQ+/q0GPqZthFFPy8o4GwHElOzqedJf1RIct1x6gmpd67uDcrtSPUIL+GHIZFymSTreJ
         S0Dd8iwG18xT5+6R85YCmqogtjCw1cd5YlPHUmbeXJlmWJJU/RQU9ZTXHM37yUklmebZ
         aU9B5Yg4QcK5LzAtBgfOHA69uRlaiZlWozsHiS9in8QCSvdjzCcwzdojHtNT59ou1AmC
         Vb6EAKuecHqjCUcrkfYxGmvSrC0fe0maWglgwNXGA9vMSOKIi1FxfVZPNI7C/tvnNRkv
         WWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703598; x=1732308398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yq6wiZr07zyT2tdDH94tcWOKQWvPr647j2FSkk0F3Q=;
        b=Nn6bl2vXy6K+ov8D5D6/kAl0jy4FS8m8kOZkSXkT7ruWvxJqBwDbC8d69PYwtcBp8G
         9zrF19rC/nP6seCEifECRSZMDHeN7KXk87vOJrlGUrHdnzFPoJeM0h4EL32O3neKPjXU
         WLptN7H9dsYKUFpi5CgO7eJtzCY53afch0aTBeTwOlKvtwrL6oLBIP6qOnwjTcFA/QeA
         XKMq3gTQDRQugT4NMDAY/iQZc7oX0De+EBNsKC/tdFYuD+P5hTWzNRo3OeGTDelJT5T0
         +V8L0PfkZRILGsKPEflbavo2oqokuK292lG3wiVxCIbno9mqixemT+Q/+fuCHRLWhCgn
         UUhw==
X-Forwarded-Encrypted: i=1; AJvYcCVL0zMNc1Sg0+Zx4BEac3Kj7EqgZnalpk3HU/HQbZBT8kYKO4fCgPkT9sNNcIQM3DsArzOH497jsvvaj0b2yv4X@vger.kernel.org, AJvYcCWt6BHGNhNaAzHuhCpDRGgzSmSTTArTjwlW1VSsDV24ZXxSoYmvmz2YNLXNyWkfQa7Ei5MQfcTwVr4R8Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJbOr120HknBc5njNp+ertVe8LJfjSEKbkDa/YZkz0DRnzgldE
	0HP3CJQ2yD3Kd/qyIGlM6HwxcJ9kf5x1sxWyAglw7fBVKxcrwnzxeQDT1jeZShERQyxJeLqVwhA
	t1gJxgG04AIip0MunvqDys+ilSbA=
X-Google-Smtp-Source: AGHT+IGAiWLeBjumpw7p+afqPXYyXtvqY+8Qj9zPwMiWZbrBct0RWUM5Td4x4JWHFESzzhseikcfzEyMow/meHeScdg=
X-Received: by 2002:a17:907:608a:b0:a99:6791:5449 with SMTP id
 a640c23a62f3a-aa483553e12mr348295266b.52.1731703598185; Fri, 15 Nov 2024
 12:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113125152.752778-1-liuhangbin@gmail.com> <20241113125152.752778-2-liuhangbin@gmail.com>
 <CAH5Ym4jjVFofG5J7QW=EsD00siDXtNWKt4ZDNbbUmP+Y4Jb-DQ@mail.gmail.com> <ZzWo5fJcraaDDLm_@fedora>
In-Reply-To: <ZzWo5fJcraaDDLm_@fedora>
From: Sam Edwards <cfsworks@gmail.com>
Date: Fri, 15 Nov 2024 12:46:27 -0800
Message-ID: <CAH5Ym4hcguhXvJvVuANns7Q9VTOWR-SxHSdD55rR5BWhWeg2Ow@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/ipv6: delete temporary address if mngtmpaddr
 is removed or un-mngtmpaddr
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Xiao Ma <xiaom@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 11:38=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com>=
 wrote:
>
> On Wed, Nov 13, 2024 at 01:03:13PM -0800, Sam Edwards wrote:
> > On Wed, Nov 13, 2024 at 4:52=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.c=
om> wrote:
> > >
> > > RFC8981 section 3.4 says that existing temporary addresses must have =
their
> > > lifetimes adjusted so that no temporary addresses should ever remain =
"valid"
> > > or "preferred" longer than the incoming SLAAC Prefix Information. Thi=
s would
> > > strongly imply in Linux's case that if the "mngtmpaddr" address is de=
leted or
> > > un-flagged as such, its corresponding temporary addresses must be cle=
ared out
> > > right away.
> > >
> > > But now the temporary address is renewed even after =E2=80=98mngtmpad=
dr=E2=80=99 is removed
> > > or becomes unmanaged. Fix this by deleting the temporary address with=
 this
> > > situation.
> >
> > Hi Hangbin,
> >
> > Is it actually a new temporary, or is it just failing to purge the old
> > temporaries? While trying to understand this bug on my own, I learned
>
> 1. If delete the mngtmpaddr with the mngtmpaddr flag. e.g.
> `ip addr del 2001::1/64 mngtmpaddr dev dummy0`. The following code in
> inet6_addr_del()
>
>     if (!(ifp->flags & IFA_F_TEMPORARY) &&
>         (ifa_flags & IFA_F_MANAGETEMPADDR))
>             manage_tempaddrs(idev, ifp, 0, 0, false,
>                              jiffies);
>
> will be called and the valid_lft/prefered_lft of tempaddres will be set t=
o 0.
>
> 2. If we using cmd `ip addr change 2001::1/64 dev dummy0`, the following =
code in
> inet6_addr_modify():
>
>     if (was_managetempaddr || ifp->flags & IFA_F_MANAGETEMPADDR) {
>             if (was_managetempaddr &&
>                 !(ifp->flags & IFA_F_MANAGETEMPADDR)) {
>                     cfg->valid_lft =3D 0;
>                     cfg->preferred_lft =3D 0;
>             }
>             manage_tempaddrs(ifp->idev, ifp, cfg->valid_lft,
>                              cfg->preferred_lft, !was_managetempaddr,
>                              jiffies);
>     }
> will be called and valid_lft/prefered_lft of tempaddres will be set to 0.
>
> But these 2 setting actually not work as in addrconf_verify_rtnl():
>
>     if ((ifp->flags&IFA_F_TEMPORARY) &&
>         !(ifp->flags&IFA_F_TENTATIVE) &&
>         ifp->prefered_lft !=3D INFINITY_LIFE_TIME &&
>         !ifp->regen_count && ifp->ifpub) {
>             /* This is a non-regenerated temporary addr. */
>
>             unsigned long regen_advance =3D ipv6_get_regen_advance(ifp->i=
dev);
>
>             if (age + regen_advance >=3D ifp->prefered_lft) {
>
>                  ^^ this will always true since prefered_lft is 0
>
> So later we will call ipv6_create_tempaddr(ifpub, true) to create a new
> tempaddr.
>
> 3. If we delete the mngtmpaddr without the mngtmpaddr flag. e.g.
> `ip addr del 2001::1/64 dev dummy0` The following code in inet6_addr_del(=
)
>
>     if (!(ifp->flags & IFA_F_TEMPORARY) &&
>         (ifa_flags & IFA_F_MANAGETEMPADDR))
>             manage_tempaddrs(idev, ifp, 0, 0, false,
>                              jiffies);
>
> Will *not* be called as ifa_flags doesn't have IFA_F_MANAGETEMPADDR.
> So in addrconf_verify_rtnl(), the (age + regen_advance >=3D ifp->prefered=
_lft)
> checking will be false, no new tempaddr will be created. But the later
> (ifp->valid_lft !=3D INFINITY_LIFE_TIME && age >=3D ifp->valid_lft) check=
ing is
> also false unless the valid_lft is just timeout. So the tempaddr will be =
keep
> until it's life timeout.
>
> > about a commit [1] that tried to address the former problem, and it's
> > possible that the approach in that commit needs to be tightened up
> > instead.
> >
> > [1]: 69172f0bcb6a09 ("ipv6 addrconf: fix bug where deleting a
> > mngtmpaddr can create a new temporary address")
>
> The situation in this patch is that the user removed the temporary addres=
s
> first. The temporary address is not in the addr list anymore and
> addrconf_verify_rtnl() won't create a new one. But later when delete the
> mngtmpaddr, the manage_tempaddrs() is called again (because the mngtmpadd=
r
> flag in delete cmd) and a new tempaddr is created.
>
> >
> > >
> > > Fixes: 778964f2fdf0 ("ipv6/addrconf: fix timing bug in tempaddr regen=
")
> > > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > > ---
> > >  net/ipv6/addrconf.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > > index 94dceac52884..6852dbce5a7d 100644
> > > --- a/net/ipv6/addrconf.c
> > > +++ b/net/ipv6/addrconf.c
> > > @@ -4644,6 +4644,10 @@ static void addrconf_verify_rtnl(struct net *n=
et)
> > >                             !ifp->regen_count && ifp->ifpub) {
> > >                                 /* This is a non-regenerated temporar=
y addr. */
> > >
> > > +                               if ((!ifp->valid_lft && !ifp->prefere=
d_lft) ||
> > > +                                   ifp->ifpub->state =3D=3D INET6_IF=
ADDR_STATE_DEAD)
> > > +                                       goto delete_ifp;
> > > +
> >
> > My understanding is that the kernel already calls
> > `manage_tempaddrs(dev, ifp, 0, 0, false, now);` when some `ifp` needs
> > its temporaries flushed out. That zeroes out the lifetimes of every
> > temporary, which allows the "destructive" if/elseif/elseif/... block
> > below to delete it. I believe fixing this bug properly will involve
> > first understanding why *that* mechanism isn't working as designed.
>
> Please see the up comment.
>
> >
> > In any case, this 'if' block is for temporary addresses /which haven't
> > yet begun their regeneration process/, so this won't work to purge out
> > addresses that have already started trying to create their
> > replacement. That'll be a rare and frustrating race for someone in the
> > future to debug indeed. As well, I broke this 'if' out from the below
> > if/elseif/elseif/... to establish a clear separation between the
> > "constructive" parts of an address's lifecycle (currently, only
> > temporary addresses needing to regenerate) and the "destructive" parts
> > (the address gradually becoming less prominent as its lifetime runs
> > out), so destructive/delete logic doesn't belong up here anyway.
>
> Currently my fix is checking the tempaddr valid_lft and ifp->ifpub->state=
.
> Maybe we can delete the tempaddr direcly in ipv6_del_addr() and
> inet6_addr_modify()?

Hi Hangbin,

It took me a while to grasp but the problem seems to be a confusion
about what it means to set a temporary's lifetimes to 0/0:
1) "The mngtmpaddrs has gone away; this temporary is slated for
deletion by addrconf_verify_rtnl()"
2) "This temporary address itself shall no longer be used, regenerate
it immediately."

The existing behavior makes sense for the #2 case, but not for the #1
case. It seems sensible to me to keep the #2 behavior as-is, because
userspace might be setting a 0/0 lifetime to forcibly rotate the
temporary.

So it sounds like (at least) one of three fixes is in order:
a) Make ipv6_create_tempaddr() verify that the `ifp` is (still)
alive+mngtmpaddrs, returning with an error code if not.
b) Look at the 3 callsites for ipv6_create_tempaddr() and add the
above verifications before calling.
c) Add a function that calls ipv6_del_addr(temp) for every temporary
with a specified ifpub, and use it instead of manage_tempaddrs(..., 0,
0, false, ...) when deleting/unflagging a mngtmpaddrs.

Personally I like option C the best. What are your thoughts?

Cheers,
Sam

>
> Thanks
> Hangbin
> >
> > What are your thoughts?
> >
> > Happy Wednesday,
> > Sam
> >
> > >                                 unsigned long regen_advance =3D ipv6_=
get_regen_advance(ifp->idev);
> > >
> > >                                 if (age + regen_advance >=3D ifp->pre=
fered_lft) {
> > > @@ -4671,6 +4675,7 @@ static void addrconf_verify_rtnl(struct net *ne=
t)
> > >
> > >                         if (ifp->valid_lft !=3D INFINITY_LIFE_TIME &&
> > >                             age >=3D ifp->valid_lft) {
> > > +delete_ifp:
> > >                                 spin_unlock(&ifp->lock);
> > >                                 in6_ifa_hold(ifp);
> > >                                 rcu_read_unlock_bh();
> > > --
> > > 2.46.0
> > >

