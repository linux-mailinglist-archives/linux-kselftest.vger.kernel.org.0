Return-Path: <linux-kselftest+bounces-12408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627DB911E97
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188B6281D6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E34916C6A8;
	Fri, 21 Jun 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8TjsYdi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539F127B5A
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958260; cv=none; b=CJ45ZVG3/SBUL5X5qwSJJ6OqtgE4k9yT8hDhNF6MYLL5wh2SERptXIEyqzRj2k7UneNmdCL9qFi1VXl0rv0XrWr2tkrODZ0CbYrMCgNfPNcetK40lN0mNqc8lfR7x9oVH3Rp6R39mO6dbIhJh9n7wgBbILs/b9UbyywX0f9apmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958260; c=relaxed/simple;
	bh=zNb31ljHYMVCkZLfGOU3WfbbUpuUMo7NTgMJDQTRcKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGkMv/dqaCZbOjLU2uvoYy//Vc1vmzMdZETteq7i6iJxLOiSYgvxtc1F1IzRPZY+JidTZ3OWhNPG1/9OpW6+YllgFFERcSdraURok8kfrhW6RLlS7URVWvnctwv+MN+y1vX66VP6pQ7AKBFv5EIiVpy0ZJyatFVnr6yUY7qsuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8TjsYdi; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80d6c63af28so481753241.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 01:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718958258; x=1719563058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSL4jxfV9+DvzrB5xjyOhPkA4JDFq4ANvkv63lZh6Ho=;
        b=K8TjsYdiD7kZJZbBfwTUAiUFNTHViBXFGQngxHYwrxLUpbelkzCaPX635p540o76/W
         RLOv6fibpMqPI8+oDVQN+pApxzlCIbfSTTjTei4jkvqMVEMtU3NTGtLGdP0Us0EzRN0+
         DbfKKa5Q+kY4oPkzkRiQlp7CRCzboGsY+0OsTrbxtgQPcKEgh1vwAGN6fWppy7fe4JJ7
         gsVFwySyNJKH35bCfY/HIZJUwAlVaWhrpTRcMOpYr0jbUBtDYF1cHb58tYiX1gWvROOj
         S/EKTmvvNms4fog7s0CZkNPVkvJSCod6wHPtDkpKbcCRnxKbl43xUXnPVTcJe77MfVqJ
         zoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718958258; x=1719563058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSL4jxfV9+DvzrB5xjyOhPkA4JDFq4ANvkv63lZh6Ho=;
        b=CpkKkJ37pPGCrKUADzNa4ZJWskLzHkIdhgNgbPAjVlKFF30N6je074+4Zb3aKUYQ+8
         LU7M7xXMQGIFD4hbfeIAtw3+luUsL2i7A/Bi6Srdpn4Rm7oIyq5brx9dlarEPjYRckAd
         YgF4pvTcfIMW4Eaz7fvws8FcfW2sYCEk77Dq3q9BDkorJ0Mb6AlqX/S0A1QrQlPyDEkX
         TavrUhIv8zDDbwUlSguCKAcMbkAR20UQHoMXf7+6QNt5Lyf/sbNbWDb3yPhBVE0rN0yv
         /uD3XmhEF1vhpcHao9c8B1Zc+0zqx1fFMta9c+NV+KgFbc3zTIYs2K3Gx1OWEP9bwT2O
         lpNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsopsP01MpsA6H703+Nf95RRrUWSJsgVXgy6Z2hdwY45aMWK4vAVIuRwtl66Eqp7AtoQHRB7Mgd5pJJ5MxW2TCyNAL4awd3ssq5HQOjTnu
X-Gm-Message-State: AOJu0Yxd5x99DypnqIOcmsCVcoIi8M3QGTAi6P3EKETXL/68zkbDq8Om
	MLwPxIDVOJkcXHvNAgeJWLPhhr39AVz2fIrrEOvjJAObBoPkw2dtrAWiJ5ecRn83JDaU1IPOBWg
	kP/cG5nRfoYdwhWowFYjY0KWpjU/kSe4myXmT
X-Google-Smtp-Source: AGHT+IFOm3+J7HmNxfiqvxOkkiwF5vyaMcHsOCQZWMdwd3gCNyLm2HD7cdpJGLriJIJX24RcWbLSAdpJ42Ukykvu0xA=
X-Received: by 2002:a05:6102:743:b0:48f:205e:9b8 with SMTP id
 ada2fe7eead31-48f205e0aafmr5713897137.34.1718958257567; Fri, 21 Jun 2024
 01:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com> <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com> <CA+EHjTz_=J+bDpqciaMnNja4uz1Njcpg5NVh_GW2tya-suA7kQ@mail.gmail.com>
 <ZnRMn1ObU8TFrms3@google.com>
In-Reply-To: <ZnRMn1ObU8TFrms3@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 21 Jun 2024 09:23:41 +0100
Message-ID: <CA+EHjTxvOyCqWRMTS3mXHznQtAJzDJLgqdS0Er2GA9FGdxd1vA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>, maz@kernel.org, 
	kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Thu, Jun 20, 2024 at 4:37=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Jun 19, 2024, Fuad Tabba wrote:
> > Hi Jason,
> >
> > On Wed, Jun 19, 2024 at 12:51=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.co=
m> wrote:
> > >
> > > On Wed, Jun 19, 2024 at 10:11:35AM +0100, Fuad Tabba wrote:
> > >
> > > > To be honest, personally (speaking only for myself, not necessarily
> > > > for Elliot and not for anyone else in the pKVM team), I still would
> > > > prefer to use guest_memfd(). I think that having one solution for
> > > > confidential computing that rules them all would be best. But we do
> > > > need to be able to share memory in place, have a plan for supportin=
g
> > > > huge pages in the near future, and migration in the not-too-distant
> > > > future.
> > >
> > > I think using a FD to control this special lifetime stuff is
> > > dramatically better than trying to force the MM to do it with struct
> > > page hacks.
> > >
> > > If you can't agree with the guest_memfd people on how to get there
> > > then maybe you need a guest_memfd2 for this slightly different specia=
l
> > > stuff instead of intruding on the core mm so much. (though that would
> > > be sad)
> > >
> > > We really need to be thinking more about containing these special
> > > things and not just sprinkling them everywhere.
> >
> > I agree that we need to agree :) This discussion has been going on
> > since before LPC last year, and the consensus from the guest_memfd()
> > folks (if I understood it correctly) is that guest_memfd() is what it
> > is: designed for a specific type of confidential computing, in the
> > style of TDX and CCA perhaps, and that it cannot (or will not) perform
> > the role of being a general solution for all confidential computing.
>
> That isn't remotely accurate.  I have stated multiple times that I want g=
uest_memfd
> to be a vehicle for all VM types, i.e. not just CoCo VMs, and most defini=
tely not
> just TDX/SNP/CCA VMs.

I think that there might have been a slight misunderstanding between
us. I just thought that that's what you meant by:

: And I'm saying say we should stand firm in what guest_memfd _won't_
support, e.g.
: swap/reclaim and probably page migration should get a hard "no".

https://lore.kernel.org/all/Zfmpby6i3PfBEcCV@google.com/

> What I am staunchly against is piling features onto guest_memfd that will=
 cause
> it to eventually become virtually indistinguishable from any other file-b=
ased
> backing store.  I.e. while I want to make guest_memfd usable for all VM *=
types*,
> making guest_memfd the preferred backing store for all *VMs* and use case=
s is
> very much a non-goal.
>
> From an earlier conversation[1]:
>
>  : In other words, ditch the complexity for features that are well served=
 by existing
>  : general purpose solutions, so that guest_memfd can take on a bit of co=
mplexity to
>  : serve use cases that are unique to KVM guests, without becoming an unm=
aintainble
>  : mess due to cross-products.
> > > > Also, since pin is already overloading the refcount, having the
> > > > exclusive pin there helps in ensuring atomic accesses and avoiding
> > > > races.
> > >
> > > Yeah, but every time someone does this and then links it to a uAPI it
> > > becomes utterly baked in concrete for the MM forever.
> >
> > I agree. But if we can't modify guest_memfd() to fit our needs (pKVM,
> > Gunyah), then we don't really have that many other options.
>
> What _are_ your needs?  There are multiple unanswered questions from our =
last
> conversation[2].  And by "needs" I don't mean "what changes do you want t=
o make
> to guest_memfd?", I mean "what are the use cases, patterns, and scenarios=
 that
> you want to support?".

I think Quentin's reply in this thread outlines what it is pKVM would
like to do, and why it's different from, e.g., TDX:
https://lore.kernel.org/all/ZnUsmFFslBWZxGIq@google.com/

To summarize, our requirements are the same as other CC
implementations, except that we don't want to pay a penalty for
operations that pKVM (and Gunyah) can do more efficiently than
encryption-based CC, e.g., in-place conversion of private -> shared.

Apart from that, we are happy to use an interface that can support our
needs, or at least that we can extend in the (near) future to do that.
Whether it's guest_memfd() or something else.

>  : What's "hypervisor-assisted page migration"?  More specifically, what'=
s the
>  : mechanism that drives it?

I believe what Will specifically meant by this is that, we can add
hypervisor support for migration in pKVM for the stage 2 page tables.

We don't have a detailed implementation for this yet, of course, since
there's no point yet until we know whether we're going with
guest_memfd(), or another alternative.

>  : Do you happen to have a list of exactly what you mean by "normal mm st=
uff"?  I
>  : am not at all opposed to supporting .mmap(), because long term I also =
want to
>  : use guest_memfd for non-CoCo VMs.  But I want to be very conservative =
with respect
>  : to what is allowed for guest_memfd.   E.g. host userspace can map gues=
t_memfd,
>  : and do operations that are directly related to its mapping, but that's=
 about it.
>
> That distinction matters, because as I have stated in that thread, I am n=
ot
> opposed to page migration itself:
>
>  : I am not opposed to page migration itself, what I am opposed to is add=
ing deep
>  : integration with core MM to do some of the fancy/complex things that l=
ead to page
>  : migration.

So it's not a "hard no"? :)

> I am generally aware of the core pKVM use cases, but I AFAIK I haven't se=
en a
> complete picture of everything you want to do, and _why_.
> E.g. if one of your requirements is that guest memory is managed by core-=
mm the
> same as all other memory in the system, then yeah, guest_memfd isn't for =
you.
> Integrating guest_memfd deeply into core-mm simply isn't realistic, at le=
ast not
> without *massive* changes to core-mm, as the whole point of guest_memfd i=
s that
> it is guest-first memory, i.e. it is NOT memory that is managed by core-m=
m (primary
> MMU) and optionally mapped into KVM (secondary MMU).

It's not a requirement that guest memory is managed by the core-mm.
But, like we mentioned, support for in-place conversion from
shared->private, huge pages, and eventually migration are.

> Again from that thread, one of most important aspects guest_memfd is that=
 VMAs
> are not required.  Stating the obvious, lack of VMAs makes it really hard=
 to drive
> swap, reclaim, migration, etc. from code that fundamentally operates on V=
MAs.
>
>  : More broadly, no VMAs are required.  The lack of stage-1 page tables a=
re nice to
>  : have; the lack of VMAs means that guest_memfd isn't playing second fid=
dle, e.g.
>  : it's not subject to VMA protections, isn't restricted to host mapping =
size, etc.
>
> [1] https://lore.kernel.org/all/Zfmpby6i3PfBEcCV@google.com
> [2] https://lore.kernel.org/all/Zg3xF7dTtx6hbmZj@google.com

I wonder if it might be more productive to also discuss this in one of
the PUCKs, ahead of LPC, in addition to trying to go over this in LPC.

Cheers,
/fuad

