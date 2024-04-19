Return-Path: <linux-kselftest+bounces-8438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113E58AB180
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66C32848AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E10C12F583;
	Fri, 19 Apr 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AWy+8c1v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86DB12F386
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539712; cv=none; b=d8l83aBO0nue8ftGPpNj6vAgymMrPwXsxMm49L+gwIz0wrLPiZbYh+wf2ICt2hc7bKn1FCmFIohm0p2WfroOf7yVRtiEjagWomuwVL2T7BQkmbCAAYaLXGdAZkkWPi8FQReX+1OOpXFbhyp/SuPscB9tB+ewSSzvOX1XGZE3B5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539712; c=relaxed/simple;
	bh=9BwsgmRoellsSlnwHRY/L+avdeLAFGbR+E+vni+Rffk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcIi0jHxPIEHRrynm0nhNXFIqaREU5p1Winke5OKTYBLh6iBJF4xtsJ7vSdnjzfGZZTVdReEYUZro6p7OmWqKeAM4Vgk88i+YyqfXuEkMQfsQ1UqXA2uGQ1RRYGg53VXFrJpVs5B0MYw0ZMIMF1UQ9ZZ6xF49X0P0+zYGCaWBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AWy+8c1v; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c745103fb8so457758b6e.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713539710; x=1714144510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEgNKLbZoEckSudwAQVqNp3+oLRHBSm8rIiQDAC0My0=;
        b=AWy+8c1vr5cirJwdzs5hWZ8G0ld/TGgYfqUACuxQQX9Ap2ZG701JEGnZ5cnHfPa/Pw
         0FMkrwRpYUePBA3cyBHMppwspu7i/avbUH5GXdLQ3iC3kIKw2DZxAX9wO2b0LcXn5WnE
         LCl0YULWzvwfv/EHTymQJKxOXnTCrPR2Evf60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539710; x=1714144510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEgNKLbZoEckSudwAQVqNp3+oLRHBSm8rIiQDAC0My0=;
        b=v7kxEaFY1zPFoeuNYXZiKtKnzjeGvyhfqRsdsAl/ZoUJjMlvEsobZCvLCrqtxri+/m
         lh0eDT2/qHJMArVQkuO5tpujtwugsN1SPKw/DzHCaBf+ISjy/md7vSH9wHeaPcDCOmNK
         5/YhPBsnnzzi9hS5hMZc5rhMf21u5jBqI+nO58KQl3JjXHXpS5XkIZSvz79E1KbkCZrv
         WJ6t2YNtzq4wmLF1bBPh6aTSd2YUW2lWctqQ3qNutZAl4s942OI5lB9Q7icLR3KoJQ1o
         CEb8bL4JPftED6kyGMZN1dmQ8hzTJPs1aROrVfUPUJCoNeAKnjzL5B7N3rQ5pPS4dv7w
         IUzA==
X-Forwarded-Encrypted: i=1; AJvYcCXPJQ5TA1drcARNIIQlgNTyT8uS7mWFGRtxWoc9jEYQ1e+7Mow6kHPharId4OZ0PrVxSyDZqOS3eX0EnxN0/Q02WFM8dMv8ztStxSy9HTVK
X-Gm-Message-State: AOJu0Yz//I7tE6WchUOpk1ErA0Ir1FWt0wCxsYqi1GyCrS1CfCcBpzSI
	s2L/viWOHc3UTXe/S8jRKlV4hLuIuqXnRDuWaKplXwZDc0u5LN68OxGGNN6HHafp3FTKGl2nPZ0
	wv0B46S6l9T2iqnd2eL3eAprfYOMpSvA2RAI1
X-Google-Smtp-Source: AGHT+IEci/VyiWTbXG7rGLqxUebtYkv2OnV0Wqvi15X+7XyZPRlkIXZ0Sb7gRR5KGjmK4XwASZ6eghotMgLv8vvXQUI=
X-Received: by 2002:a05:6870:1d0a:b0:233:abab:6d6c with SMTP id
 pa10-20020a0568701d0a00b00233abab6d6cmr2926542oab.7.1713539709864; Fri, 19
 Apr 2024 08:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <znrbeb744774vre5dkeg7kjnnt7uuifs6xw63udcyupwj3veqh@rpcqs7dmoxi6>
 <CABi2SkU8B27O28jjTDajFpENgUHhntuRAMKFUMXr6A6AxZeyiQ@mail.gmail.com>
 <CAJuCfpFLwJg4n7wPpT+u9vC4XHoLE_BPPZ0tDKf7W45hGky4_Q@mail.gmail.com>
 <CABi2SkXCC8tvuHTiZ=tYcZw0sQ2SswQqDuFuQi5bKArW9+Nbaw@mail.gmail.com> <CAJuCfpEM0b-_gCbMqcUVvKedqXsSE4di7oqzeQGofVNsHRAqCg@mail.gmail.com>
In-Reply-To: <CAJuCfpEM0b-_gCbMqcUVvKedqXsSE4di7oqzeQGofVNsHRAqCg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 19 Apr 2024 08:14:58 -0700
Message-ID: <CABi2SkVk-9gQXtWKWs-1pf=Jnm=hNC04-z7qS95sJeCVrEra1Q@mail.gmail.com>
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

On Fri, Apr 19, 2024 at 7:57=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Apr 18, 2024 at 6:22=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wro=
te:
> >
> > On Thu, Apr 18, 2024 at 1:19=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Tue, Apr 16, 2024 at 12:40=E2=80=AFPM Jeff Xu <jeffxu@chromium.org=
> wrote:
> > > >
> > > > On Tue, Apr 16, 2024 at 8:13=E2=80=AFAM Liam R. Howlett <Liam.Howle=
tt@oracle.com> wrote:
> > > > >
> > > > > * jeffxu@chromium.org <jeffxu@chromium.org> [240415 12:35]:
> > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > >
> > > > > > This is V10 version, it rebases v9 patch to 6.9.rc3.
> > > > > > We also applied and tested mseal() in chrome and chromebook.
> > > > > >
> > > > > > ---------------------------------------------------------------=
---
> > > > > ...
> > > > >
> > > > > > MM perf benchmarks
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > This patch adds a loop in the mprotect/munmap/madvise(DONTNEED)=
 to
> > > > > > check the VMAs=E2=80=99 sealing flag, so that no partial update=
 can be made,
> > > > > > when any segment within the given memory range is sealed.
> > > > > >
> > > > > > To measure the performance impact of this loop, two tests are d=
eveloped.
> > > > > > [8]
> > > > > >
> > > > > > The first is measuring the time taken for a particular system c=
all,
> > > > > > by using clock_gettime(CLOCK_MONOTONIC). The second is using
> > > > > > PERF_COUNT_HW_REF_CPU_CYCLES (exclude user space). Both tests h=
ave
> > > > > > similar results.
> > > > > >
> > > > > > The tests have roughly below sequence:
> > > > > > for (i =3D 0; i < 1000, i++)
> > > > > >     create 1000 mappings (1 page per VMA)
> > > > > >     start the sampling
> > > > > >     for (j =3D 0; j < 1000, j++)
> > > > > >         mprotect one mapping
> > > > > >     stop and save the sample
> > > > > >     delete 1000 mappings
> > > > > > calculates all samples.
> > > > >
> > > > >
> > > > > Thank you for doing this performance testing.
> > > > >
> > > > > >
> > > > > > Below tests are performed on Intel(R) Pentium(R) Gold 7505 @ 2.=
00GHz,
> > > > > > 4G memory, Chromebook.
> > > > > >
> > > > > > Based on the latest upstream code:
> > > > > > The first test (measuring time)
> > > > > > syscall__     vmas    t       t_mseal delta_ns        per_vma %
> > > > > > munmap__      1       909     944     35      35      104%
> > > > > > munmap__      2       1398    1502    104     52      107%
> > > > > > munmap__      4       2444    2594    149     37      106%
> > > > > > munmap__      8       4029    4323    293     37      107%
> > > > > > munmap__      16      6647    6935    288     18      104%
> > > > > > munmap__      32      11811   12398   587     18      105%
> > > > > > mprotect      1       439     465     26      26      106%
> > > > > > mprotect      2       1659    1745    86      43      105%
> > > > > > mprotect      4       3747    3889    142     36      104%
> > > > > > mprotect      8       6755    6969    215     27      103%
> > > > > > mprotect      16      13748   14144   396     25      103%
> > > > > > mprotect      32      27827   28969   1142    36      104%
> > > > > > madvise_      1       240     262     22      22      109%
> > > > > > madvise_      2       366     442     76      38      121%
> > > > > > madvise_      4       623     751     128     32      121%
> > > > > > madvise_      8       1110    1324    215     27      119%
> > > > > > madvise_      16      2127    2451    324     20      115%
> > > > > > madvise_      32      4109    4642    534     17      113%
> > > > > >
> > > > > > The second test (measuring cpu cycle)
> > > > > > syscall__     vmas    cpu     cmseal  delta_cpu       per_vma %
> > > > > > munmap__      1       1790    1890    100     100     106%
> > > > > > munmap__      2       2819    3033    214     107     108%
> > > > > > munmap__      4       4959    5271    312     78      106%
> > > > > > munmap__      8       8262    8745    483     60      106%
> > > > > > munmap__      16      13099   14116   1017    64      108%
> > > > > > munmap__      32      23221   24785   1565    49      107%
> > > > > > mprotect      1       906     967     62      62      107%
> > > > > > mprotect      2       3019    3203    184     92      106%
> > > > > > mprotect      4       6149    6569    420     105     107%
> > > > > > mprotect      8       9978    10524   545     68      105%
> > > > > > mprotect      16      20448   21427   979     61      105%
> > > > > > mprotect      32      40972   42935   1963    61      105%
> > > > > > madvise_      1       434     497     63      63      115%
> > > > > > madvise_      2       752     899     147     74      120%
> > > > > > madvise_      4       1313    1513    200     50      115%
> > > > > > madvise_      8       2271    2627    356     44      116%
> > > > > > madvise_      16      4312    4883    571     36      113%
> > > > > > madvise_      32      8376    9319    943     29      111%
> > > > > >
> > > > >
> > > > > If I am reading this right, madvise() is affected more than the o=
ther
> > > > > calls?  Is that expected or do we need to have a closer look?
> > > > >
> > > > The madvise() has a bigger percentage (per_vma %), but it also has =
a
> > > > smaller base value (cpu).
> > >
> > > Sorry, it's unclear to me what the "vmas" column denotes. Is that how
> > > many VMAs were created before timing the syscall? If so, then 32 is
> > > the max that you show here while you seem to have tested with 1000
> > > VMAs. What is the overhead with 1000 VMAs?
> >
> > The vmas column is the number of VMA used in one call.
> >
> > For example: for 32 and mprotect(ptr,size), the memory range used in
> > mprotect has 32 VMAs.
>
> Ok, so the 32 here denotes how many VMAs one mprotect() call spans?
>
Yes.

> >
> > It also matters how many memory ranges are in-use at the time of the
> > test, This is where 1000 comes in. The test creates 1000 memory
> > ranges, each memory range has 32 vmas, then calls mprotect on the 1000
> > memory range. (the pseudocode was included in the original email)
>
> So, if each range has 32 vmas and you have 1000 ranges then you are
> creating 32000 vmas? Sorry, your pseudocode does not clarify that. My
> current understanding is this:
>
> for (i =3D 0; i < 1000, i++)
>     mmap N*1000 areas (N=3D[1-32])
>     start the sampling
>     for (j =3D 0; j < 1000, j++)
>         mprotect N areas with one syscall
>     stop and save the sample
>     munmap N*1000 areas
> calculates all samples.
>
> Is that correct?
>
Yes, There will be 32000 VMA in the system.

The pseudocode is correct in concept.
The test implementation is slightly different, it uses mprotect to
split the memory and make sure the VMAs  doesn't merge. For detail,
the reference [8]  of the original email link to the test code.

-Jeff

