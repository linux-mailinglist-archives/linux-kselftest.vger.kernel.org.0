Return-Path: <linux-kselftest+bounces-11680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F2903E79
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 16:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B5A1F21D82
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C3A17DE05;
	Tue, 11 Jun 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aUivzDZW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4E17D8B1
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115238; cv=none; b=eSxAKBC6NANV1yTQa2Z94Obr6Xt+V8/ly+8DBGQSkyz6KtfaMGnPMMrNDAKG5CIbK3uGcjmhMSMDvj2B8sZTxc/lgOvGpHd5/w9bnwvTwByaAVR5qocN20wKHBAoW+3SheV23tyP+hMT6Gs/Pk4exshHSvDmKGNwz6Xpk63OdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115238; c=relaxed/simple;
	bh=DenBAvY1VgHb5IE7Lt78+EUBNFqsgXe3l0GramNtKiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZ8cZ386gGoaAzv/If5g2HYcF0Jg6lGPWWkrO3Rt3RNByjUeT1dpjBPySeuY5pXzvAk2eTzbPzj4wNHVlDfEr8o0D5tc4IvsReJd+VADVgcjEUfINOlMs7S1tcicPm8QMReYBgvs1bvD118wFXQtUEnHdWVrXM8eNFNdMTXTqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aUivzDZW; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-24542b8607fso515658fac.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718115236; x=1718720036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy8oHMpwAzTnrA6hIQed17Wxd5v4cl8lNZdtIYkbZh4=;
        b=aUivzDZWNQ8SqyNsbBG3+4fNSTd21gRLOewQWkR8CmKrEEtlA5k8BTZ2V0tCo3OsNN
         1LyesWDclfUe4hEDsrXOl9FIyaWsbAXXk4Du839UG3R+QWUv2vNQX0y6SZgfewHPrb3D
         HZSy/Y6Fc25NHT2o1qnlAhs0pX+FZQvohHN+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718115236; x=1718720036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy8oHMpwAzTnrA6hIQed17Wxd5v4cl8lNZdtIYkbZh4=;
        b=OpiJ9+oF5WLwBWRpFx3i6FCX/wpAgnTGfZu9Efu1qGby4K2pQsOdFTu+d5raDzjXnC
         UJuDhr3XEwnOzfUFTDmc/8Y3T81YoE9AtmuDIhc7M9F1elzjKsrXBQfNPeuzlm5wwcc3
         XFrTsjCojWKsdx59Mpc1sfHP78OmC5zQFARClF6ci4wT139i1yEq8BCWs6fSMm8C07jh
         5eDZulTbD6DidiWf/rKbeASxx2bqqkgPbNeU8mOqd7gbssbz/NhTTn8+U5PziFBx9/ft
         8UP0YPZr5oyEy7AcQYCdVxgPu6yri8K6cFGIZRbQZ1DrL6vyq1B9rk2ci85TDdwX26w0
         A3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUXx6x6C4dYGF+1gNSDD9TNDaX4/TrO54LDhba4/tvEccofeKwhpPmoR9+6/SVFSjwjAnfq81Siv05TJQHmz3tcD4Wyfv00b6EV7Q3kWUNd
X-Gm-Message-State: AOJu0Yw8HUcMBjfodifJSDUgNIx8LhL7WU12vBxMJSX4utLZwUrApmjy
	4A3oLaDbYT8T+Zvtbn4ntvBr1xhTO0VIgPULWaFyhsGVFqTf4xhhWX/j0WA+rNgVNBBUG7LSRPz
	Y6Hflc3kzQ+tDQ2hJFN0CWup377Y8ncIoSlyH
X-Google-Smtp-Source: AGHT+IEyLXp50AVlWar+ASEL8EEFzsgHFJzCmH5iDrtEytk/RBAQaUrOjGAzA/S0A1NSW/DgR87CGNyjYAUP4RRKdUg=
X-Received: by 2002:a05:6870:ec94:b0:254:9ded:a3b7 with SMTP id
 586e51a60fabf-2549dedd4b0mr9558744fac.56.1718115236307; Tue, 11 Jun 2024
 07:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608021023.176027-1-jhubbard@nvidia.com> <CABi2SkVoNyXLrfU71gnv1qVUAADpUmFXiDoKKPc54MLb5JpB+Q@mail.gmail.com>
 <a8f9d4e2-8a12-4e5d-bd22-9c92955135f4@nvidia.com> <CABi2SkU8=tjWhD-e=OdiVr+YeU+BZZLB_vMfkNb-VWpbP2xcng@mail.gmail.com>
 <95005e7c-3705-48c5-8ee2-3d9b0688fcbc@nvidia.com>
In-Reply-To: <95005e7c-3705-48c5-8ee2-3d9b0688fcbc@nvidia.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 11 Jun 2024 07:13:44 -0700
Message-ID: <CABi2SkXN1jsnrawCwADxWB0Whj+e-m7+9c=5Lo3gY5CYVrnpkQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make headers"
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, 
	Rich Felker <dalias@libc.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:26=E2=80=AFPM John Hubbard <jhubbard@nvidia.com>=
 wrote:
>
> On 6/10/24 9:45 PM, Jeff Xu wrote:
> > On Mon, Jun 10, 2024 at 9:34=E2=80=AFPM John Hubbard <jhubbard@nvidia.c=
om> wrote:
> >> On 6/10/24 9:21 PM, Jeff Xu wrote:
> >>> Hi
> >>>
> >>>
> >>> On Fri, Jun 7, 2024 at 7:10=E2=80=AFPM John Hubbard <jhubbard@nvidia.=
com> wrote:
> >>>>
> >>>> Eventually, once the build succeeds on a sufficiently old distro, th=
e
> >>>> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and =
then
> >>>> after that, from selftests/lib.mk and all of the other selftest buil=
ds.
> >>>>
> >>>> For now, this series merely achieves a clean build of selftests/mm o=
n a
> >>>> not-so-old distro: Ubuntu 23.04:
> >>>>
> >>>> 1. Add __NR_mseal.
> >>>>
> >>>> 2. Add fs.h, taken as usual from a snapshot of ./usr/include/linux/f=
s.h
> >>>> after running "make headers". This is how we have agreed to do this =
sort
> >>>> of thing, see [1].
> >>>>
> >>> What is the "official" way to build selftests/mm ?
> >>
> >>   From Documentation/dev-tools/kselftest.rst, it is:
> >>
> >>     $ make headers
> >>     $ make -C tools/testing/selftests
> >>
> >>> I tried a few ways, but it never worked, i.e. due to head missing.
> >>
> >> You are correct. Today's rules require "make headers" first. But
> >> I'm working on getting rid of that requirement, because it causes
> >> problems for some people and situations.
> >>
> >> (Even worse is the follow-up rule, in today's documentation,
> >> that tells us to *run* the selftests from within Make! This
> >> is just madness.
> >
> > That is hilarious! :)
>
> :)
>
> >
> >>   Because the tests need to run as root in
> >> many cases. And Make will try to rebuild if necessary...thus
> >> filling your tree full of root-owned files...but that's for
> >> another time.)
> >>
> >>>
> >>> 1>
> >>> cd tools/testing/selftests/mm
> >>> make
> >>>
> >>> migration.c:10:10: fatal error: numa.h: No such file or directory
> >>>      10 | #include <numa.h>
> >>>         |          ^~~~~~~~
> >>> compilation terminated.
> >>>
> >>> 2>
> >>> make headers
> >>> make -C tools/testing/selftests
> >>>
> >>> make[1]: Entering directory
> >>> '/usr/local/google/home/jeffxu/mm/tools/testing/selftests/mm'
> >>>     CC       migration
> >>> migration.c:10:10: fatal error: numa.h: No such file or directory
> >>>      10 | #include <numa.h>
> >>>
> >>
> >> Well, actually, for these, one should install libnuma-dev and
> >> numactl (those are Ubuntu package names. Arch Linux would be:
> >> numactl).
> >>
> >> I think. The idea is: use system headers if they are there, and
> >> local kernel tree header files if the items are so new that they
> >> haven't made it to $OLDEST_DISTO_REASONABLE.
> >>
> >> Something like that.
> >>
> > But I don't want to install random packages if possible.
>
> Well...keep in mind that it's not really random. If a test program
> requires numa.h, it's typically because it also links against libnuma,
> which *must* be supplied by the distro if you want to build. Because
> it doesn't come with the kernel, of course.
>
Agreed.

> So what you're really saying is that you'd like to build and run
> whatever you can at the moment--the build should soldier on past
> failures as much as possible.
>
Yes. That is what I meant. It would be a convenient feature.

> >
> > Can makefile rule continue to the next target in case of failure though=
 ?
>
> That could be done, in general. The question is if that's really what
> we want, or should want. Maybe...
>
> > right now it stopped  at migration.c , if it continues to the next targ=
et, then
> > I don't  need to use gcc to manually build mseal_test.
>
> Let me take a peek at it in the morning.
>
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>

