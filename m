Return-Path: <linux-kselftest+bounces-38123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7521DB17777
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 22:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BF87AB19B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 20:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFA7218ADC;
	Thu, 31 Jul 2025 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zrGRmvsn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423C481B6
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995389; cv=none; b=J5apeA6oz2yy0NmvX58YWXnWLKbBJqMvC3+Xh6spHeRfNN+y8XBlZv6hYrpGeSSvshYOIl+ZRfWBaaXQ/vC7h/f0ja0sXiAhXMkISzwd6ipFJQ2HX31R6qQhtPG97uyPXXZDZe9YhWBWqPPhM+W6meSbaSZm/QHX+mNWDwcraNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995389; c=relaxed/simple;
	bh=nFeKFStsvXn3Aqtmlpsg37D6CgVeR2E7Vx8uku6RlmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtlV8/36ac7VHrvU9Ve2+v42FJjTEBXcyVZgikqRaNnDxIZXUdr7FG1Vq3ZEJXoxwd27K9Dliw4E5590MS2Ffg6oBjrX2TLU4BrfoMef4pc4yiXZqQba4PSC63SPwmq5amAzqaN5s/9PemWc7YsXugfQQtjbKycA78TMVeDM+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zrGRmvsn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b8b8e00caso906632e87.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753995385; x=1754600185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCtuQkDVjUEa/FtZ6Tb1pgyFSFVXDIid7hFEgrtgAWc=;
        b=zrGRmvsnaE/nYvXtI6aqQDpELOdpekJQnFTR3UK0l6t61sSmooSebewd1f53FNIwrA
         AQOeAFE6nedMM5bifDivabwj4kCJTneKV00WTWEinGQ+3XXxHpY3tUrjaETcp5BxdTKE
         zORVLfaew3niRQo6lW/NM9oSHf842+yKvQOKtpfb7uHi18ri7hr1oYEl8EUPd5PTo6lO
         bVrUg49rMNfRWguPngV/SQealldkER/UnamSK8+yL9uNj7Rty7SU0wIlLTcSV2IbeX4S
         FXTZIoIQdudEKUejD7/Cdpogn0j+ZxPzits8oBp98hymU0RiZhs4FA+B5P0QNHNtXF2m
         /VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995385; x=1754600185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCtuQkDVjUEa/FtZ6Tb1pgyFSFVXDIid7hFEgrtgAWc=;
        b=pP+MJbyxrrajU98Mx5lmt0fr7icmnkiPGiK5hDMKmRXQTMcvee6TzsE8dr3PZfbipf
         OOLf0hQiKC/bZieb7OAqZLdGW2RkKjkx2puszMJ2s/8DAWqHvGVWeqAZXiImhZDBjrqA
         znhrrNx59NdUBi2skXOgt0j1zBx8L1byu8ef9P278isun0mQWuhtigSjn1sIuUKRgRff
         p4qUYkGLlLa/459iMQem1SQDv2/vGHB26e38GdgTmP4Dwk0QYcB7Zd43fuRtjmtor7sJ
         3/rIHHo+wN9vGb8fthCMmsXiopfKdd+d0+H7n/6h0WVtg249VVbSpa4+WeZXFF7xOyFn
         f/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrZr64YqmHcfncFEwO93+csrIoGnmbsrTukq5V2Ye3OYcgmUIqA68FjASd2r7AdLMH0603W7zT+uRxpd3uIlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmHcCDiw/pKzfnd8c51vL06FV6zt/aoE5OFtjDpZu65RZkmoM
	xcH7Wjt7/LOvxKGmm5pNjqntOhKl05qEPu5SaQaahXNeJl2sYfK0k+hQr1V0bOpWr2cBJZYPvrQ
	sNA/QVhGSKXSAIICioJdeDKtE4H995fzhJb4hXV10
X-Gm-Gg: ASbGncuZjSyI2/QetMeNeHhovW4zQpbdkj8mz3CnvqfiE2fAcmFfuskvLF/Iwlha30i
	7RoG8q786bZ4sZ56mtrbWrwWX5uuVPaquzrGq3NKDdmd/DX4axg7PlgMVOKQjMISJ0pw+WvqAx/
	aVYq3vsBWxcNnI/8NVsz2XWJcW1EuvrRr3YSMBgt+sstaNPrUP4bYvACxIqMwfToDXpQu9rZF+G
	nsdHHaUUl7XRMT5TQ==
X-Google-Smtp-Source: AGHT+IG5n8X+GoZig+npW6fkHFuu9QaxrrCfyPOAyObS6oOX5VI8mw3mOyMwnie+EdiPKNibMSfQ7N6Jylcw+Bgvsg4=
X-Received: by 2002:a05:6512:6d1:b0:553:2450:58a6 with SMTP id
 2adb3069b0e04-55b7c00bb74mr2485809e87.1.1753995385134; Thu, 31 Jul 2025
 13:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com> <CALzav=dVYqS8oQNbygVjgA69EQMBBP4CyzydyUoAjnN2mb_yUQ@mail.gmail.com>
 <20250728102737.5b51e9da.alex.williamson@redhat.com> <20250729222635.GU36037@nvidia.com>
In-Reply-To: <20250729222635.GU36037@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 31 Jul 2025 13:55:57 -0700
X-Gm-Features: Ac12FXxPsO99W-i-2FIZsnLyILWDPQlQQ0kWEDj72No2ZsrYL7nf_a3cvIf3gtU
Message-ID: <CALzav=d0vPMw26f-vzCJnjRFL+Uc6sObihqJ0jnJRpi-SxtSSw@mail.gmail.com>
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

On Tue, Jul 29, 2025 at 3:26=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Jul 28, 2025 at 10:27:37AM -0600, Alex Williamson wrote:
> > On Fri, 25 Jul 2025 09:47:48 -0700
> > David Matlack <dmatlack@google.com> wrote:
> > > I also was curious about your thoughts on maintenance of VFIO
> > > selftests, since I don't think we discussed that in the RFC. I am
> > > happy to help maintain VFIO selftests in whatever way makes the most
> > > sense. For now I added tools/testing/selftests/vfio under the
> > > top-level VFIO section in MAINTAINERS (so you would be the maintainer=
)
> > > and then also added a separate section for VFIO selftests with myself
> > > as a Reviewer (see PATCH 01). Reviewer felt like a better choice than
> > > Maintainer for myself since I am new to VFIO upstream (I've primarily
> > > worked on KVM in the past).
> >
> > Hi David,
> >
> > There's a lot of potential here and I'd like to see it proceed.
>
> +1 too, I really lack time at the moment to do much with this but I'm
> half inclined to suggest Alex should say it should be merged in 6
> weeks (to motivate any reviewing) and we can continue to work on it
> in-tree.
>
> As they are self tests I think there is alot more value in having the
> tests than having perfect tests.

They have been quite useful already within Google. Internally we have
something almost identical to the RFC and have been using that for
testing our 6.6-based kernel continuously since March. Already they
have caught one (self-inflicted) regression where 1GiB HugeTLB pages
started getting mapped with 2MiB mappings in the IOMMU, and have been
very helpful with new development (e.g. Aaron's work, and Live Update
support).

So I agree, it's probably net positive to merge early and then iterate
in-tree. Especially since these are only tests and not e.g.
load-bearing kernel code (although I still want to hold a high bar for
the selftests code).

The only patches to hold off merging would be 31-33, since those
should probably go through the KVM tree? And of course we need Acks
for the drivers/dma/{ioat,idxd} changes, but the changes there are
pretty minor.

> > Something that we should continue to try to improve is the automation.
> > These tests are often targeting a specific feature, so matching a
> > device to a unit test becomes a barrier to automated runs.  I wonder if
> > we might be able to reach a point where the test runner can select
> > appropriate devices from a pool of devices specified via environment
> > variables.

Yes, I'd like to improve on this as well. Within Google we've recently
split up run.sh into separate setup.sh and cleanup.sh scripts, and now
store metadata about what devices are set up for VFIO selftests in
files. Storing metadata in files has been especially useful for
testing Live Updates, since we need the automation to remember what
devices are in use across a kexec.

For now we still pass in the BDFs to tests via command line, but we
could have tests themselves look and see what devices are available
for use and then pick one or multiple as needed. The location of the
metadata files can have some reasonable default path and with an
option to override with a custom path via environment variable.

There's lots of directions we could go in, and it really depends on
how folks want to use/run VFIO selftests, so I would like to learn
more about that as well.

>
> Makes a lot of sense to me!
>
> I'd just put Dave as the VFIO selftest co-maintainer though - a
> pennance for doing so much work :)

Hah! I will accept my penance if necessary. :)

>
> Jason

