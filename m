Return-Path: <linux-kselftest+bounces-8390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F48AA685
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 03:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1741F224F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 01:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD28E1362;
	Fri, 19 Apr 2024 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMZOoymi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2943D10F9
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713489750; cv=none; b=OAjG/fO+LSO7ioPsvQ2ALUvpBJWmIna2Ruqlb5SeWfiUqK9j8m2PiPNTA4PAd3JBpVPJx3vMYHVXv6WTDHnq7Rg4Xj9Bbn4UzsCokfVkOicnsI0tsgzwJRUdlrcEwfGr/WzmM2DA5XTFMGvIG/s8msaE9QIZch5YWqorfJuu7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713489750; c=relaxed/simple;
	bh=1Pqd2IO38h18ms2DCwcvnLo4KlczMtlBA4Tg51+NUy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLhsq0iM2IyAZfUUSoK6LPIhHxbU/9UyJc7Pqe9dv2aT7XS7p4a50cjfrvlSOhYuwMFwlSyWA1C3MVsZEDlZJ9dVsI0+d1IArey5oR0DwKFsIq235/bcV2uH/c2TJaK7omr4Qim4VSbVGWMZ85GkOCJ+GSgoBl/LM0XvxXdghxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YMZOoymi; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23333ef4a02so934657fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713489748; x=1714094548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9ROGqlYMf4EWKkuF17eFEGeQPXT7Cmyk3kLJypWimE=;
        b=YMZOoymif96InqDYvEhyZ2owFZSgwVbGlfaj0tUj6o9D/gNNNwcundQXFe5IiSA+6D
         e9OyQ1DB/goPBPbm0V2Az/h/n4IJT3Wwmm+N5T8LgD8sN1aAHWum0wpGX2ANGkLdQOMO
         8l77pN9szYwi6kvHSpdL4pfhbRPb7jzTh/Wug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713489748; x=1714094548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9ROGqlYMf4EWKkuF17eFEGeQPXT7Cmyk3kLJypWimE=;
        b=nCYJztjuCugScjG7pRX0/0R5pPCsiv1s5RfHQa5hIk/dSZwsh2Ja6It//bfiSX2wZg
         fa7PgTu/SH/w8o+lcDQqC7utHQoYCfpULu9Q8kd50y0srbxf6Ut47hBV5xd2W0NRpafl
         YXH/SLntUkOfSth1cMHKhJvToC38KlbrkU9cM+6ZQN/FzLdO95UJFY8C7Ukukr1R1BSI
         COWhQW2DpDsBPY5v/T2Y9TZb5jtlO5n2bja/BmLkqcKo2j8/uyToA3/pts6ABNGqRwX6
         iJt588gf8mFsp+2VzI/70X3/V+aPihtohXi/ylZ+doLCTCh83rvA9LZCDyW9qgvgYB+P
         2S6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhiX1ngDDQy44t5X+PerFIif99ZAkfMfkUSqh8DnWKlS/iJ/k247VaMC9QZur+ypxPtHO9XHe0vNRFeaVt9IJlKUcaA3xAvX0M3id/58wm
X-Gm-Message-State: AOJu0Yw2t5WIE1m0TofygiSKEW4WH6XIsd5wsh6bT2PSB4ovTqPLFtV/
	eRgj0wGwpGb1IuEcbjrEPsx+nPDTY+stRxSpYO7FqsD10M2v6/r32eQM63QYGVM6nXWrThfNgPD
	MpCGL8wN4QNWwDrCi2PJCqcnMvlreTK1Xr4eC
X-Google-Smtp-Source: AGHT+IEIBWNW7I5IBkSSrZoL3bQdbE0EnKQ5DMsc2OrG+K8cpwjoWbHljs2kaRoC/Lt0/1+1WBv43RrQh4SZC/NgzxY=
X-Received: by 2002:a05:6870:cb8e:b0:21e:a957:efef with SMTP id
 ov14-20020a056870cb8e00b0021ea957efefmr870266oab.19.1713489748193; Thu, 18
 Apr 2024 18:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <znrbeb744774vre5dkeg7kjnnt7uuifs6xw63udcyupwj3veqh@rpcqs7dmoxi6>
 <CABi2SkU8B27O28jjTDajFpENgUHhntuRAMKFUMXr6A6AxZeyiQ@mail.gmail.com> <CAJuCfpFLwJg4n7wPpT+u9vC4XHoLE_BPPZ0tDKf7W45hGky4_Q@mail.gmail.com>
In-Reply-To: <CAJuCfpFLwJg4n7wPpT+u9vC4XHoLE_BPPZ0tDKf7W45hGky4_Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 18 Apr 2024 18:22:16 -0700
Message-ID: <CABi2SkXCC8tvuHTiZ=tYcZw0sQ2SswQqDuFuQi5bKArW9+Nbaw@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:19=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Apr 16, 2024 at 12:40=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wr=
ote:
> >
> > On Tue, Apr 16, 2024 at 8:13=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * jeffxu@chromium.org <jeffxu@chromium.org> [240415 12:35]:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > This is V10 version, it rebases v9 patch to 6.9.rc3.
> > > > We also applied and tested mseal() in chrome and chromebook.
> > > >
> > > > ------------------------------------------------------------------
> > > ...
> > >
> > > > MM perf benchmarks
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > This patch adds a loop in the mprotect/munmap/madvise(DONTNEED) to
> > > > check the VMAs=E2=80=99 sealing flag, so that no partial update can=
 be made,
> > > > when any segment within the given memory range is sealed.
> > > >
> > > > To measure the performance impact of this loop, two tests are devel=
oped.
> > > > [8]
> > > >
> > > > The first is measuring the time taken for a particular system call,
> > > > by using clock_gettime(CLOCK_MONOTONIC). The second is using
> > > > PERF_COUNT_HW_REF_CPU_CYCLES (exclude user space). Both tests have
> > > > similar results.
> > > >
> > > > The tests have roughly below sequence:
> > > > for (i =3D 0; i < 1000, i++)
> > > >     create 1000 mappings (1 page per VMA)
> > > >     start the sampling
> > > >     for (j =3D 0; j < 1000, j++)
> > > >         mprotect one mapping
> > > >     stop and save the sample
> > > >     delete 1000 mappings
> > > > calculates all samples.
> > >
> > >
> > > Thank you for doing this performance testing.
> > >
> > > >
> > > > Below tests are performed on Intel(R) Pentium(R) Gold 7505 @ 2.00GH=
z,
> > > > 4G memory, Chromebook.
> > > >
> > > > Based on the latest upstream code:
> > > > The first test (measuring time)
> > > > syscall__     vmas    t       t_mseal delta_ns        per_vma %
> > > > munmap__      1       909     944     35      35      104%
> > > > munmap__      2       1398    1502    104     52      107%
> > > > munmap__      4       2444    2594    149     37      106%
> > > > munmap__      8       4029    4323    293     37      107%
> > > > munmap__      16      6647    6935    288     18      104%
> > > > munmap__      32      11811   12398   587     18      105%
> > > > mprotect      1       439     465     26      26      106%
> > > > mprotect      2       1659    1745    86      43      105%
> > > > mprotect      4       3747    3889    142     36      104%
> > > > mprotect      8       6755    6969    215     27      103%
> > > > mprotect      16      13748   14144   396     25      103%
> > > > mprotect      32      27827   28969   1142    36      104%
> > > > madvise_      1       240     262     22      22      109%
> > > > madvise_      2       366     442     76      38      121%
> > > > madvise_      4       623     751     128     32      121%
> > > > madvise_      8       1110    1324    215     27      119%
> > > > madvise_      16      2127    2451    324     20      115%
> > > > madvise_      32      4109    4642    534     17      113%
> > > >
> > > > The second test (measuring cpu cycle)
> > > > syscall__     vmas    cpu     cmseal  delta_cpu       per_vma %
> > > > munmap__      1       1790    1890    100     100     106%
> > > > munmap__      2       2819    3033    214     107     108%
> > > > munmap__      4       4959    5271    312     78      106%
> > > > munmap__      8       8262    8745    483     60      106%
> > > > munmap__      16      13099   14116   1017    64      108%
> > > > munmap__      32      23221   24785   1565    49      107%
> > > > mprotect      1       906     967     62      62      107%
> > > > mprotect      2       3019    3203    184     92      106%
> > > > mprotect      4       6149    6569    420     105     107%
> > > > mprotect      8       9978    10524   545     68      105%
> > > > mprotect      16      20448   21427   979     61      105%
> > > > mprotect      32      40972   42935   1963    61      105%
> > > > madvise_      1       434     497     63      63      115%
> > > > madvise_      2       752     899     147     74      120%
> > > > madvise_      4       1313    1513    200     50      115%
> > > > madvise_      8       2271    2627    356     44      116%
> > > > madvise_      16      4312    4883    571     36      113%
> > > > madvise_      32      8376    9319    943     29      111%
> > > >
> > >
> > > If I am reading this right, madvise() is affected more than the other
> > > calls?  Is that expected or do we need to have a closer look?
> > >
> > The madvise() has a bigger percentage (per_vma %), but it also has a
> > smaller base value (cpu).
>
> Sorry, it's unclear to me what the "vmas" column denotes. Is that how
> many VMAs were created before timing the syscall? If so, then 32 is
> the max that you show here while you seem to have tested with 1000
> VMAs. What is the overhead with 1000 VMAs?

The vmas column is the number of VMA used in one call.

For example: for 32 and mprotect(ptr,size), the memory range used in
mprotect has 32 VMAs.

It also matters how many memory ranges are in-use at the time of the
test, This is where 1000 comes in. The test creates 1000 memory
ranges, each memory range has 32 vmas, then calls mprotect on the 1000
memory range. (the pseudocode was included in the original email)

> My worry is that if the overhead grows linearly with the number of
> VMAs then the effects will be quite noticeable on Android where an
> application with a few thousand VMAs is not so unusual.
>
The overhead is likely to grow linearly with the number of VMA, since
it takes time to retrieve VMA's metadata.

Let's use one data sample to look at impact:

Test: munmap 1000 memory range, each memory range has 1 VMA

syscall__       vmas    t       t_mseal delta_ns        per_vma %
munmap__        1       909     944     35      35      104%

For those 1000 munmap calls, sealing adds 35000 ns in total, or 35 ns per c=
all.

The delta seems to be insignificant. e.g. it will take about 28571
munmap call to have 1 ms difference (1000000/35=3D28571)

When I look at the data from 5.10 to 6.8, for the same munmap call,
6.8 adds 552 ns per call, which is 15 times bigger.

syscall__       vmas    t_5_10  t_6_8   delta_ns        per_vma %
munmap__        1       357     909     552     552     254%


> >
> > -Jeff

