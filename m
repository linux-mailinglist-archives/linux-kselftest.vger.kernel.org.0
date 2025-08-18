Return-Path: <linux-kselftest+bounces-39243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707E9B2B127
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 21:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B723AA377
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC2F273D83;
	Mon, 18 Aug 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5YbiUJ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2440273D6C
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543616; cv=none; b=TfI6U6AWhXU7PkgEbd0zJoTTLFH1uBZfzm2JQSvca58eU/JmJadmnkPYyJqrM3z6nX5CV/Ng+zhbspjMoQM2oNtC6YD+YtvIqtcBchteppDng9Rtlk784j1mS/zO/tP+n4rgmvawZ/OQo2iXeZrlq6XtUHN3H4mq756gvv0b/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543616; c=relaxed/simple;
	bh=vQomRZshu2lk8+zD/OL/vg9fFnYpAUrpAgtNsWCVKZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPeDGcWr6a+wXTHReW6XhEg9v8QbLlAmE4TScqjtYQXJpZDNyuFDLxK1xup1q+Sxr85c2blnRiqjYZMW3Ekf1BkHH19/fwkn0BNC814WO0ziBJ6fuG16WWHeR0FwHyHES9/3fQyPBzDI9F3Co97Yox6VaaWHnCrQJRoEMJXx81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5YbiUJ8; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-89021b2569cso930545241.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755543612; x=1756148412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQomRZshu2lk8+zD/OL/vg9fFnYpAUrpAgtNsWCVKZc=;
        b=q5YbiUJ8zHnKB6hxl6k/k/Z5zCdyipunm8J/NdI9g3wbjnVfcK9B7wkXjROEb6UFON
         XQ/0B+DJdVE3hK3VMPbdF1P5GxD49TIAv/dq9pNbIBbHI4lho+a9Jv+GdslJMtR4R9wm
         dsG5qP2O6KYpJNCYNLmr/zX+a0EY07PFpalPAHd6ahXzUJ1ApLQjPVgsNoTmD83/klaq
         +Crc/QtCp+NfP/IQEXFnqi+uJDmnD0CLQVv1RG3F+oy+N61LBuzi7FPT4pOBgPIx1A4p
         lNYUzHILM/3F1bwzcHd/9xB3qhoBzoeOvYJnRsua1bID7D4p8+qurLtXA5Ke+ggb+HcG
         KGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543612; x=1756148412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQomRZshu2lk8+zD/OL/vg9fFnYpAUrpAgtNsWCVKZc=;
        b=NM7ScL6bOtrmoJ/j915ZdS5gDzmEfrySU7aXjU5Ux5seu4qZwUxFqIfOQZfPzf5Agl
         h+0IABRsx2VqkcwkLG8Dyg6nLbDGqpmx97muBpm3EV0K6xVM4dzbCSHdsL/4TfnmC7Ff
         mkopOXlEjAfBEcfWDovtT5qewfLP+zqfci9rIUPGdBf5nq42r06sJy3HFl31cgHNonlh
         5pT3EI9L8CsFz2qFKG3lVlZwx8lhUbb9TBidFIKoYaYht4fjTiMEBjbEFMIJsfWVkeGC
         hp75gOvCTZKATeo+ZCbDALo/PkP2uQDO9IflA/jr2xZtaYIgWsNhxAIduWpYnrZEcI8e
         KokQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMkfgIzairH73/RZoTu/V9xYI41Zi2ykqDtzZnm/bEg0dFsabKIsPqmtNe20UamjU5TSvOkGCsRnaIEBERUwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJ1LNXebxPuxWR2qemd7zefkOFaD7sTHfuX8ZC/kwssfLvtf3
	ftELHEBMczcjuu40/Wv0zqRDIDbksvTUVRPFjhreRU/D6jQAXHo9BrdABcgZ21SsYU6U+2J1qnY
	JKE9DB0A+jBpPz+ZQSyVV1lXb+YVfiPC9wEHBTlDL
X-Gm-Gg: ASbGncv5IPaWF9tTLVnSspYsmEPRteXsH+ai6d/EYxX6y1/xkIXICcpW8jJzqQFFPVx
	nAPF8tv784s1jQT8vXuMjH1x1hY6bbxKiTQE7DlIk629P7sdlQYzaM43/Di4nxFc8mvcuDVpnkT
	uhpefBNANz634uvgdPT5bTeuhjQma14ptHXmysz/cWmkRSQP9rvV2N0kIud3rSaZzj82lyopbDI
	4fcMD3vMUCimLdV1WVzgbWX
X-Google-Smtp-Source: AGHT+IHKuVR6yCJ91jJq7ugyNm/ro83W16ukMXy6TNeyjS+8s1HiMV5A8fVG7olzaJbCAnCu8c3YSbxdEle29VD3uGs=
X-Received: by 2002:a67:f1cc:0:b0:4fb:f836:5a8b with SMTP id
 ada2fe7eead31-5126b10c782mr3995547137.12.1755543611478; Mon, 18 Aug 2025
 12:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com> <CALzav=dVYqS8oQNbygVjgA69EQMBBP4CyzydyUoAjnN2mb_yUQ@mail.gmail.com>
 <20250728102737.5b51e9da.alex.williamson@redhat.com> <20250729222635.GU36037@nvidia.com>
 <CALzav=d0vPMw26f-vzCJnjRFL+Uc6sObihqJ0jnJRpi-SxtSSw@mail.gmail.com>
In-Reply-To: <CALzav=d0vPMw26f-vzCJnjRFL+Uc6sObihqJ0jnJRpi-SxtSSw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 18 Aug 2025 11:59:39 -0700
X-Gm-Features: Ac12FXzjq18NMEcti3WnxAnstzv3oZ53HMDVa30Ie_aUdIryOd1wCtUV8wzYufY
Message-ID: <CALzav=fdT+NJDO+jWyty+tKqxqum4RVkHZmUocz4MDQkPgG4Bg@mail.gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Aaron Lewis <aaronlewis@google.com>, 
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

On Thu, Jul 31, 2025 at 1:55=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Tue, Jul 29, 2025 at 3:26=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
> >
> > On Mon, Jul 28, 2025 at 10:27:37AM -0600, Alex Williamson wrote:
> > > On Fri, 25 Jul 2025 09:47:48 -0700
> > > David Matlack <dmatlack@google.com> wrote:
> > > > I also was curious about your thoughts on maintenance of VFIO
> > > > selftests, since I don't think we discussed that in the RFC. I am
> > > > happy to help maintain VFIO selftests in whatever way makes the mos=
t
> > > > sense. For now I added tools/testing/selftests/vfio under the
> > > > top-level VFIO section in MAINTAINERS (so you would be the maintain=
er)
> > > > and then also added a separate section for VFIO selftests with myse=
lf
> > > > as a Reviewer (see PATCH 01). Reviewer felt like a better choice th=
an
> > > > Maintainer for myself since I am new to VFIO upstream (I've primari=
ly
> > > > worked on KVM in the past).
> > >
> > > Hi David,
> > >
> > > There's a lot of potential here and I'd like to see it proceed.
> >
> > +1 too, I really lack time at the moment to do much with this but I'm
> > half inclined to suggest Alex should say it should be merged in 6
> > weeks (to motivate any reviewing) and we can continue to work on it
> > in-tree.
> >
> > As they are self tests I think there is alot more value in having the
> > tests than having perfect tests.
>
> They have been quite useful already within Google. Internally we have
> something almost identical to the RFC and have been using that for
> testing our 6.6-based kernel continuously since March. Already they
> have caught one (self-inflicted) regression where 1GiB HugeTLB pages
> started getting mapped with 2MiB mappings in the IOMMU, and have been
> very helpful with new development (e.g. Aaron's work, and Live Update
> support).
>
> So I agree, it's probably net positive to merge early and then iterate
> in-tree. Especially since these are only tests and not e.g.
> load-bearing kernel code (although I still want to hold a high bar for
> the selftests code).
>
> The only patches to hold off merging would be 31-33, since those
> should probably go through the KVM tree? And of course we need Acks
> for the drivers/dma/{ioat,idxd} changes, but the changes there are
> pretty minor.

Alex, how would you like to proceed?

