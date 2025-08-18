Return-Path: <linux-kselftest+bounces-39254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE69CB2B275
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 22:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E8A1BA2575
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CED2222D0;
	Mon, 18 Aug 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrS1K8f+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9C1F76A8
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549265; cv=none; b=ubFHa+jhOf6CFaqLnjgHPjRwGZSiVbkmvGh0kKm1wChBJnLAR6Z4RiIM+CFmMqP8KmDN7GOEWO/UyOehq8fkTVbzyhxk0DHF3jGzq9D8EOvY3sS5shn3lme7p+168lVmfzZAZtY+3Mlw67yFg4bd03le+Y/oas4Oo2aVMzSPcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549265; c=relaxed/simple;
	bh=vEU1DhK/0zgNT8JWZLGDWnWbNMj0+ZSO11M2ZhDRAFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMbIHTHlcd1wYIabZcgh7cHjwhhRmuoMZ4nLkzmuWg//Xpec8litkeEpLzReM0I4+JJX6a3ME/OEk546wISJYXnOql4hy2cv6IVpDo3B4jCMW4E5ROBWvBHL9WyME3sXJYAb81ODLVR+Ro4ohBK7FLu39d3SUycZ1nhppHmL+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FrS1K8f+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55ce5287a47so4158630e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755549261; x=1756154061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUZu6/RFeyBiHuWjtq2Q11oy5SbsMtdXFQAhlB7E6FM=;
        b=FrS1K8f+0yw+Bjz5v+Sxs8Tcb1nTC//pEgPY1zWE6yyQRakfWFXc2LpNaExRxQlXJN
         MIKqoVaQrYyG8xq40HiLFtTg02cLnjm166+5OWq7DDQ6eOFdmwuVfIzTdRk1F42cxji+
         KgC2aTtZBkIbwsZ1D7ojjN2N7TuC7jPGYPRkdSxYhkSxQA0lJVjjHlSoGgx0Q9QZyAHW
         nYpqZfntpxYY4oZXTmiBwV9bIeDQ3ZaTdXJAB5w3s8xGwgUsGMJQuiQFQOQMshZObje8
         FUN/wyEJePcwGoTZaN4/B3DoJPfA4I6X27brmLj0+sLln3Lmu4ssQwuaYsEqUFMWMjLV
         Urdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755549261; x=1756154061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUZu6/RFeyBiHuWjtq2Q11oy5SbsMtdXFQAhlB7E6FM=;
        b=ckTC5wie8nsGNrsANZ1/L20AcefB+K6wNhrt3k/6J5223v87hSYr40IlvkQ/qDZrhz
         gXEDaQ8x2wpZYkPH8iiL550B+vtqDCcGKxtxjdUzhPXUdUFmjV7VeeEWnU0aOdPi0hB9
         PffO4+LEdDTjkN/WOzjvnATN3cgyLcRdLvHUVboU5wEDSrvchu9T3xTgMrilnAU3Usa1
         FvcD7v2nCyWAh4QfJ4iyDn0rWFEJZUZG4lNSwDJjoW2pWsC1z19p6Qv4Dzu7JqPSGUjE
         QE7+MkjteTEUqXZ5ItUEI3wUqxHh+E7ytkD793qI/4iHrrzMB8J9EMfzuCI87W5AhAy0
         6ivw==
X-Forwarded-Encrypted: i=1; AJvYcCUnx/2OtxvpDaTZ4W1BNv5mgH9Zbi/rjX/8PpbfD88GaEJE3NOsVCaYOBn+8XSBcEsYTAPSeLiGOFMhse1fhQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmNWFKZJF46zVxMkHLn2jA/3kHt3WzuwWLRrM7yN0RBgBBw348
	0bh1W8cmIQ8DlPtSvrqrIGAY/lhuJGVx31ZW2l6V5Xi5fB2oQFicm5xKOZuNTftuQmrVSO+bnBm
	I0StQtiUTMf2QyURon55Od39sdHYi1XpInaozSZz9
X-Gm-Gg: ASbGnctdLh2IOn1A8jSBA33gWIzpzZXvTfREOB4tPH9nW6qkzCEBCvo5mBqQeQ5YK7+
	Xsrtn+j2W5uiOP8oxgVAkA91uZMx+NSbeYJXhyU/VrJQ+Jv/KJh9fqNUpu8CYlTqcwzS9JELtXG
	MWLkqHi/rVD4VwlOy4qKgqpIBmM6Ep8O1euV/pS3j7EdTteKDHbx01v9QneCeyO4Of6uXsSzhUz
	AYWPg0aWHDj1VtHWdJuOceu
X-Google-Smtp-Source: AGHT+IG/okCLiEMnTbEAuvgIc+GfOEaMV4Ktqhv/RQf6BYRPRMuCIwvQNW5SPCUa5fwVMmY/BHmCrdmWZrmWrMGMPKA=
X-Received: by 2002:a05:6512:1597:b0:55c:c937:111d with SMTP id
 2adb3069b0e04-55e0076824fmr61707e87.13.1755549261092; Mon, 18 Aug 2025
 13:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com> <CALzav=dVYqS8oQNbygVjgA69EQMBBP4CyzydyUoAjnN2mb_yUQ@mail.gmail.com>
 <20250728102737.5b51e9da.alex.williamson@redhat.com> <20250729222635.GU36037@nvidia.com>
 <CALzav=d0vPMw26f-vzCJnjRFL+Uc6sObihqJ0jnJRpi-SxtSSw@mail.gmail.com>
 <CALzav=fdT+NJDO+jWyty+tKqxqum4RVkHZmUocz4MDQkPgG4Bg@mail.gmail.com> <20250818133721.32b660e3.alex.williamson@redhat.com>
In-Reply-To: <20250818133721.32b660e3.alex.williamson@redhat.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 18 Aug 2025 13:33:52 -0700
X-Gm-Features: Ac12FXzA9RSmzacYT5nDWeSXLLoZk1b9VAVMv04nR2qdBzwPjNGQjuMMNBDam8Q
Message-ID: <CALzav=eOz+Gf8XawvaSSBHj=8gQg3O9T9dJcN6q4eqh7_MEPDw@mail.gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Joel Granados <joel.granados@kernel.org>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 12:37=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 18 Aug 2025 11:59:39 -0700
> David Matlack <dmatlack@google.com> wrote:
>
> > On Thu, Jul 31, 2025 at 1:55=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On Tue, Jul 29, 2025 at 3:26=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.c=
om> wrote:
> > > >
> > > > On Mon, Jul 28, 2025 at 10:27:37AM -0600, Alex Williamson wrote:
> > > > > On Fri, 25 Jul 2025 09:47:48 -0700
> > > > > David Matlack <dmatlack@google.com> wrote:
> > > > > > I also was curious about your thoughts on maintenance of VFIO
> > > > > > selftests, since I don't think we discussed that in the RFC. I =
am
> > > > > > happy to help maintain VFIO selftests in whatever way makes the=
 most
> > > > > > sense. For now I added tools/testing/selftests/vfio under the
> > > > > > top-level VFIO section in MAINTAINERS (so you would be the main=
tainer)
> > > > > > and then also added a separate section for VFIO selftests with =
myself
> > > > > > as a Reviewer (see PATCH 01). Reviewer felt like a better choic=
e than
> > > > > > Maintainer for myself since I am new to VFIO upstream (I've pri=
marily
> > > > > > worked on KVM in the past).
> > > > >
> > > > > Hi David,
> > > > >
> > > > > There's a lot of potential here and I'd like to see it proceed.
> > > >
> > > > +1 too, I really lack time at the moment to do much with this but I=
'm
> > > > half inclined to suggest Alex should say it should be merged in 6
> > > > weeks (to motivate any reviewing) and we can continue to work on it
> > > > in-tree.
> > > >
> > > > As they are self tests I think there is alot more value in having t=
he
> > > > tests than having perfect tests.
> > >
> > > They have been quite useful already within Google. Internally we have
> > > something almost identical to the RFC and have been using that for
> > > testing our 6.6-based kernel continuously since March. Already they
> > > have caught one (self-inflicted) regression where 1GiB HugeTLB pages
> > > started getting mapped with 2MiB mappings in the IOMMU, and have been
> > > very helpful with new development (e.g. Aaron's work, and Live Update
> > > support).
> > >
> > > So I agree, it's probably net positive to merge early and then iterat=
e
> > > in-tree. Especially since these are only tests and not e.g.
> > > load-bearing kernel code (although I still want to hold a high bar fo=
r
> > > the selftests code).
> > >
> > > The only patches to hold off merging would be 31-33, since those
> > > should probably go through the KVM tree? And of course we need Acks
> > > for the drivers/dma/{ioat,idxd} changes, but the changes there are
> > > pretty minor.
> >
> > Alex, how would you like to proceed?
>
> I think we need an ack from Shuah for the overall inclusion in
> tools/testing/selftests/
>
> AFAICT the tools include files don't seem to have any central
> authority, so maybe we just need to chase those ioat/idxd acks, along
> with Shuah's and we can get this rolling and follow-up with the latter
> KVM patches once the base is merged.  Thanks,

Sounds good.

And yeah, I also don't see any maintainers listed for tools/include/
or tools/arch/x86/include/. Jason left some comments on the RFC that
reduced the delta in v1, but that's the only feedback I've gotten so
far there.

I will try emailing Shuah and the ioat/idxd maintainers directly as a
next step, since it has been about 2 months since I posted this series
and we haven't heard anything yet.

Thanks for the help.

