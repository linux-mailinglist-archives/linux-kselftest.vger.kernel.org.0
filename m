Return-Path: <linux-kselftest+bounces-25911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D09A5A2A6FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3285188A81C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449B0228C97;
	Thu,  6 Feb 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="We8EEd3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC1226865;
	Thu,  6 Feb 2025 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738840100; cv=none; b=bl5WSlxaCq1TDuKHFBI1Jb47SZ95YVyga2AIoHAAggZbtWqdEZd2r6josXepSjgVkRTdlSiui3kFaJgh3mJlsU4dCqogcDHHQ9CJ7VWFkciEL7zUJ+DgCP2TJFAjcUPlIJzClxX9M1gvP5ISetHnW8trG3ZhADr8ivawVE07h5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738840100; c=relaxed/simple;
	bh=r08+YFVePrjR2DESEPzIzQ9ZPHAcHiFWCiN8lH5nWRU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nnoruQBTbgKkmnMyCGIDCQSazAmRefyxwp7RzOVDMEcF5EFMpDtTCdl07gcefvIfK8yqPyOfoICB34pGoh0htKKvr6eE29XhOoTNI8vXeA9O3uNSNet0aqyTJA2DyZv4go23/jyeLM7SvnjojAWBfhjn04bAooqjdqkVkGiCerI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=We8EEd3m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=UKqqouyRpRkZFe46RA14bQtyVvZtArDhuQtbwJN68Ik=; b=We8EEd3m3YMHf1ronTLetEm7Lw
	CiS1MXCW6POfbDqJ6nk5MJf+70nGt4J0OCvCx0gnQKCn31nslvmPJJNELhhuXBu0dqMBm4zEtt18u
	TFiL1RnrEhCN64CZAYCRFH7HmP69IPZ48OXGbO8R3PNesYgNIYIZZe8L/l9gp2azb0JV4GVSp/jEF
	K0RYRUzou1Tn0kq1Jz9O7cPQHklZhp5XT62jQlrLL8kHlITnKsqzX4Wdz5btKwpQFOjSCbvYGvjLY
	XnEjf+qlFB/iJLwrhX/LrwacjxTr9CQXjDArrW+AwGP0/hKZ0yH2dlkVYuGDYLjdYGul4F5iRuTKy
	gvd7fhnw==;
Received: from [216.24.213.56] (helo=[172.31.28.190])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfzjk-00000005tep-24g4;
	Thu, 06 Feb 2025 11:08:00 +0000
Message-ID: <f8030dfc5086e4e4e3709d6fcdab1e38f01fc38d.camel@infradead.org>
Subject: Re: [RFC PATCH 00/39] 1G page support for guest_memfd
From: Amit Shah <amit@infradead.org>
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
 pbonzini@redhat.com, 	zhiquan1.li@intel.com, fan.du@intel.com,
 jun.miao@intel.com, 	isaku.yamahata@intel.com, muchun.song@linux.dev,
 mike.kravetz@oracle.com, 	erdemaktas@google.com, vannapurve@google.com,
 qperret@google.com, 	jhubbard@nvidia.com, willy@infradead.org,
 shuah@kernel.org, brauner@kernel.org, 	bfoster@redhat.com,
 kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com,
 maciej.wieczor-retman@intel.com, 	pgonda@google.com,
 oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 	linux-mm@kvack.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Date: Thu, 06 Feb 2025 12:07:58 +0100
In-Reply-To: <diqzr04fpgsf.fsf@ackerleytng-ctop-specialist.c.googlers.com>
References: <diqzr04fpgsf.fsf@ackerleytng-ctop-specialist.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-03 at 08:35 +0000, Ackerley Tng wrote:
> Amit Shah <amit@infradead.org> writes:
>=20
> > Hey Ackerley,
>=20
> Hi Amit,
>=20
> > On Tue, 2024-09-10 at 23:43 +0000, Ackerley Tng wrote:
> > > Hello,
> > >=20
> > > This patchset is our exploration of how to support 1G pages in
> > > guest_memfd, and
> > > how the pages will be used in Confidential VMs.
> >=20
> > We've discussed this patchset at LPC and in the guest-memfd calls.=C2=
=A0
> > Can
> > you please summarise the discussions here as a follow-up, so we can
> > also continue discussing on-list, and not repeat things that are
> > already discussed?
>=20
> Thanks for this question! Since LPC, Vishal and I have been tied up
> with
> some Google internal work, which slowed down progress on 1G page
> support
> for guest_memfd. We will have progress this quarter and the next few
> quarters on 1G page support for guest_memfd.
>=20
> The related updates are
>=20
> 1. No objections on using hugetlb as the source of 1G pages.
>=20
> 2. Prerequisite hugetlb changes.
>=20
> + I've separated some of the prerequisite hugetlb changes into
> another
> =C2=A0 patch series hoping to have them merged ahead of and separately
> from
> =C2=A0 this patchset [1].
> + Peter Xu contributed a better patchset, including a bugfix [2].
> + I have an alternative [3].
> + The next revision of this series (1G page support for guest_memfd)
> =C2=A0 will be based on alternative [3]. I think there should be no issue=
s
> =C2=A0 there.
> + I believe Peter is also waiting on the next revision before we make
> =C2=A0 further progress/decide on [2] or [3].
>=20
> 3. No objections for allowing mmap()-ing of guest_memfd physical
> memory
> =C2=A0=C2=A0 when memory is marked shared to avoid double-allocation.
>=20
> 4. No objections for splitting pages when marked shared.
>=20
> 5. folio_put() callback for guest_memfd folio cleanup/merging.
>=20
> + In Fuad's series [4], Fuad used the callback to reset the folio's
> =C2=A0 mappability status.
> + The catch is that the callback is only invoked when folio-
> >page_type
> =C2=A0 =3D=3D PGTY_guest_memfd, and folio->page_type is a union with foli=
o's
> =C2=A0 mapcount, so any folio with a non-zero mapcount cannot have a vali=
d
> =C2=A0 page_type.
> + I was concerned that we might not get a callback, and hence
> =C2=A0 unintentionally skip merging pages and not correctly restore
> hugetlb
> =C2=A0 pages
> + This was discussed at the last guest_memfd upstream call (2025-01-
> 23
> =C2=A0 07:58 PST), and the conclusion is that using folio->page_type
> works,
> =C2=A0 because
> =C2=A0=C2=A0=C2=A0 + We only merge folios in two cases: (1) when converti=
ng to
> private
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (2) when truncating folios (removing from =
filemap).
> =C2=A0=C2=A0=C2=A0 + When converting to private, in (1), we can forcibly =
unmap all
> the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 converted pages or check if the mapcount i=
s 0, and once
> mapcount
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is 0 we can install the callback by settin=
g folio->page_type =3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PGTY_guest_memfd
> =C2=A0=C2=A0=C2=A0 + When truncating, we will be unmapping the folios any=
way, so
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapcount is also 0 and we can install the =
callback.
>=20
> Hope that covers the points that you're referring to. If there are
> other
> parts that you'd like to know the status on, please let me know which
> aspects those are!

Thank you for the nice summary!

> > Also - as mentioned in those meetings, we at AMD are interested in
> > this
> > series along with SEV-SNP support - and I'm also interested in
> > figuring
> > out how we collaborate on the evolution of this series.
>=20
> Thanks all your help and comments during the guest_memfd upstream
> calls,
> and thanks for the help from AMD.
>=20
> Extending mmap() support from Fuad with 1G page support introduces
> more
> states that made it more complicated (at least for me).
>=20
> I'm modeling the states in python so I can iterate more quickly. I
> also
> have usage flows (e.g. allocate, guest_use, host_use,
> transient_folio_get, close, transient_folio_put) as test cases.
>=20
> I'm almost done with the model and my next steps are to write up a
> state
> machine (like Fuad's [5]) and share that.
>=20
> I'd be happy to share the python model too but I have to work through
> some internal open-sourcing processes first, so if you think this
> will
> be useful, let me know!

No problem.  Yes, I'm interested in this - it'll be helpful!

The other thing of note is that while we have the kernel patches, a
userspace to drive them and exercise them is currently missing.

> Then, I'll code it all up in a new revision of this series (target:
> March 2025), which will be accompanied by source code on GitHub.
>=20
> I'm happy to collaborate more closely, let me know if you have ideas
> for
> collaboration!

Thank you.  I think currently the bigger problem we have is allocation
of hugepages -- which is also blocking a lot of the follow-on work.=20
Vishal briefly mentioned isolating pages from Linux entirely last time
- that's also what I'm interested in to figure out if we can completely
bypass the allocation problem by not allocating struct pages for non-
host use pages entirely.  The guest_memfs/KHO/kexec/live-update patches
also take this approach on AWS (for how their VMs are launched).  If we
work with those patches together, allocation of 1G hugepages is
simplified.  I'd like to discuss more on these themes to see if this is
an approach that helps as well.


		Amit

