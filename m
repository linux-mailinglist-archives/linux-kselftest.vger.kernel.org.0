Return-Path: <linux-kselftest+bounces-8435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997D8AB126
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE5B1C20C6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DD812F38D;
	Fri, 19 Apr 2024 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mK8j5xNf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886412E1EA
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538645; cv=none; b=ETeqFUi0pLkqS7VyzsvQLlAkQREg87yvLQAhEQv0K/UvR4cQiNVizu0sPvC0tViEm29XJa0BdsWVTfmFkhpP24frva086d6V/uJG4sKmDC9Y7e7aIcMtRDUQsxB9sf76Lo2u5K9hEs4c2COJYGzBqmOlTbM5V0oB04O+YoLFlBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538645; c=relaxed/simple;
	bh=E2/Sbo9wsFk/yubi6m+7XX4X7pYv4XkeuGVrTw/r0VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxqAatViskIMQIeG2tXb3CKBpGR99tE4aHVs6+coT0zXYwJnjHGY/C+S5szE391Z08hWSTizgX/vHgMoxz6XwHeOTDOZ6OGeBDbpCFvHtG1hM6NwLDaxu1Fi5m6yBe5V6VyrAqLew7XlrP+mlsX5IRvXSYMlDvzxgUmv1zzcwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mK8j5xNf; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de480576c3cso1197730276.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713538643; x=1714143443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anU0O+Cl/8esjZTwZGOybpvL5bNXBFd1hgsJ4evVImA=;
        b=mK8j5xNfzIHf/dYXQOnooehI9EfYLR1KO/ti9whQoJie4dKFc36BnydXI3GCA9WaEE
         lWbg3zQV3qfQhV+suiWCGgf05K0tFrxjS90jn/g/TcJItvIjgDujAorImgHcoeLF5TyV
         SMJIlr0FezMzawV1y41BUmNqwudCKAmSQ6t8YVKj8VMWnmIO/tfCNZNVTBTePvYt0wc5
         5U4LGbZfM6UcXGtCqoa0YuaV7UJcL7GRwzbJVzNxoedPNzK72KgD8emPlHiaiy3GJ+MK
         vLKZM4vm9//8/yBKXRFdeo/TfNOKJ2wQNurQ9n/Xo50cBjmu5ufuZjg+6IA9VFmsYU2c
         qOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713538643; x=1714143443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anU0O+Cl/8esjZTwZGOybpvL5bNXBFd1hgsJ4evVImA=;
        b=FM6+1XiWzG6z8i6pi1Ua38s2IElZmb6V/pRovUAXElYaJCoILdtq8xiiHyW8dLrJac
         MUE0HdhCu8krTXC3zw6rCk0QTVYiBWZpXiVDQ1jD0MI1nQoKORkiz0i5Pj3ldhBNr/ZB
         k8ie+p9UDd+Ohv0RQF0OKf34tw8lkOFLcA5E8icvGQKgdcQjHHK9Mqq+FWx6i+7zPffz
         3KxuixZEPJHmWc4bZjE2fqUrYPXIokMZyKOgCObBEEzQZ7xC8sT9fnp5PalQt8T1mf5p
         nl6S/yZ3X76pIPCai6Yu8Vx0UrBHcSR0Ex6AD2I567Qf3e1SjweX+TlQPHeKHbLwrPXE
         pKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGA41i5Yhsvng/iC7msTXfMk2jHdJKAE2ohHFuMsKoc9jIuDr5U08g8HLnWz33J9/7GADWlru+T7hN+R6Ma/kFZjkJ/M5nwpUHyxfisH2g
X-Gm-Message-State: AOJu0YwQEMN3/pUX4Y5UxarF48aHRXBs/n8KzIadj7X70aDdKUS2wI7/
	o1pny2k+1hBv5a4L8bQmIbAsRr41DWTxJVHaoNFXGW/ImYMMcZ9k9q6rd9foyf+r8ZCWbBsrzjl
	I/4vdCU33/Vt7fUqXKRwRlt0cEC+1DH2gW8Zn
X-Google-Smtp-Source: AGHT+IF7adSkE8wdnmiPyn4mVpG1NnzdXX/L7t8LedIMavDd8o7JUrBILI8u9VoVAMm7bza+xIeN6iKCZv+uvX8mkfQ=
X-Received: by 2002:a25:2f87:0:b0:dc6:57d0:ac9 with SMTP id
 v129-20020a252f87000000b00dc657d00ac9mr2225865ybv.6.1713538642865; Fri, 19
 Apr 2024 07:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <znrbeb744774vre5dkeg7kjnnt7uuifs6xw63udcyupwj3veqh@rpcqs7dmoxi6>
 <CABi2SkU8B27O28jjTDajFpENgUHhntuRAMKFUMXr6A6AxZeyiQ@mail.gmail.com>
 <CAJuCfpFLwJg4n7wPpT+u9vC4XHoLE_BPPZ0tDKf7W45hGky4_Q@mail.gmail.com> <CABi2SkXCC8tvuHTiZ=tYcZw0sQ2SswQqDuFuQi5bKArW9+Nbaw@mail.gmail.com>
In-Reply-To: <CABi2SkXCC8tvuHTiZ=tYcZw0sQ2SswQqDuFuQi5bKArW9+Nbaw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 19 Apr 2024 07:57:08 -0700
Message-ID: <CAJuCfpEM0b-_gCbMqcUVvKedqXsSE4di7oqzeQGofVNsHRAqCg@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Jeff Xu <jeffxu@chromium.org>
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

On Thu, Apr 18, 2024 at 6:22=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Thu, Apr 18, 2024 at 1:19=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Tue, Apr 16, 2024 at 12:40=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> =
wrote:
> > >
> > > On Tue, Apr 16, 2024 at 8:13=E2=80=AFAM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > >
> > > > * jeffxu@chromium.org <jeffxu@chromium.org> [240415 12:35]:
> > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > >
> > > > > This is V10 version, it rebases v9 patch to 6.9.rc3.
> > > > > We also applied and tested mseal() in chrome and chromebook.
> > > > >
> > > > > -----------------------------------------------------------------=
-
> > > > ...
> > > >
> > > > > MM perf benchmarks
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > This patch adds a loop in the mprotect/munmap/madvise(DONTNEED) t=
o
> > > > > check the VMAs=E2=80=99 sealing flag, so that no partial update c=
an be made,
> > > > > when any segment within the given memory range is sealed.
> > > > >
> > > > > To measure the performance impact of this loop, two tests are dev=
eloped.
> > > > > [8]
> > > > >
> > > > > The first is measuring the time taken for a particular system cal=
l,
> > > > > by using clock_gettime(CLOCK_MONOTONIC). The second is using
> > > > > PERF_COUNT_HW_REF_CPU_CYCLES (exclude user space). Both tests hav=
e
> > > > > similar results.
> > > > >
> > > > > The tests have roughly below sequence:
> > > > > for (i =3D 0; i < 1000, i++)
> > > > >     create 1000 mappings (1 page per VMA)
> > > > >     start the sampling
> > > > >     for (j =3D 0; j < 1000, j++)
> > > > >         mprotect one mapping
> > > > >     stop and save the sample
> > > > >     delete 1000 mappings
> > > > > calculates all samples.
> > > >
> > > >
> > > > Thank you for doing this performance testing.
> > > >
> > > > >
> > > > > Below tests are performed on Intel(R) Pentium(R) Gold 7505 @ 2.00=
GHz,
> > > > > 4G memory, Chromebook.
> > > > >
> > > > > Based on the latest upstream code:
> > > > > The first test (measuring time)
> > > > > syscall__     vmas    t       t_mseal delta_ns        per_vma %
> > > > > munmap__      1       909     944     35      35      104%
> > > > > munmap__      2       1398    1502    104     52      107%
> > > > > munmap__      4       2444    2594    149     37      106%
> > > > > munmap__      8       4029    4323    293     37      107%
> > > > > munmap__      16      6647    6935    288     18      104%
> > > > > munmap__      32      11811   12398   587     18      105%
> > > > > mprotect      1       439     465     26      26      106%
> > > > > mprotect      2       1659    1745    86      43      105%
> > > > > mprotect      4       3747    3889    142     36      104%
> > > > > mprotect      8       6755    6969    215     27      103%
> > > > > mprotect      16      13748   14144   396     25      103%
> > > > > mprotect      32      27827   28969   1142    36      104%
> > > > > madvise_      1       240     262     22      22      109%
> > > > > madvise_      2       366     442     76      38      121%
> > > > > madvise_      4       623     751     128     32      121%
> > > > > madvise_      8       1110    1324    215     27      119%
> > > > > madvise_      16      2127    2451    324     20      115%
> > > > > madvise_      32      4109    4642    534     17      113%
> > > > >
> > > > > The second test (measuring cpu cycle)
> > > > > syscall__     vmas    cpu     cmseal  delta_cpu       per_vma %
> > > > > munmap__      1       1790    1890    100     100     106%
> > > > > munmap__      2       2819    3033    214     107     108%
> > > > > munmap__      4       4959    5271    312     78      106%
> > > > > munmap__      8       8262    8745    483     60      106%
> > > > > munmap__      16      13099   14116   1017    64      108%
> > > > > munmap__      32      23221   24785   1565    49      107%
> > > > > mprotect      1       906     967     62      62      107%
> > > > > mprotect      2       3019    3203    184     92      106%
> > > > > mprotect      4       6149    6569    420     105     107%
> > > > > mprotect      8       9978    10524   545     68      105%
> > > > > mprotect      16      20448   21427   979     61      105%
> > > > > mprotect      32      40972   42935   1963    61      105%
> > > > > madvise_      1       434     497     63      63      115%
> > > > > madvise_      2       752     899     147     74      120%
> > > > > madvise_      4       1313    1513    200     50      115%
> > > > > madvise_      8       2271    2627    356     44      116%
> > > > > madvise_      16      4312    4883    571     36      113%
> > > > > madvise_      32      8376    9319    943     29      111%
> > > > >
> > > >
> > > > If I am reading this right, madvise() is affected more than the oth=
er
> > > > calls?  Is that expected or do we need to have a closer look?
> > > >
> > > The madvise() has a bigger percentage (per_vma %), but it also has a
> > > smaller base value (cpu).
> >
> > Sorry, it's unclear to me what the "vmas" column denotes. Is that how
> > many VMAs were created before timing the syscall? If so, then 32 is
> > the max that you show here while you seem to have tested with 1000
> > VMAs. What is the overhead with 1000 VMAs?
>
> The vmas column is the number of VMA used in one call.
>
> For example: for 32 and mprotect(ptr,size), the memory range used in
> mprotect has 32 VMAs.

Ok, so the 32 here denotes how many VMAs one mprotect() call spans?

>
> It also matters how many memory ranges are in-use at the time of the
> test, This is where 1000 comes in. The test creates 1000 memory
> ranges, each memory range has 32 vmas, then calls mprotect on the 1000
> memory range. (the pseudocode was included in the original email)

So, if each range has 32 vmas and you have 1000 ranges then you are
creating 32000 vmas? Sorry, your pseudocode does not clarify that. My
current understanding is this:

for (i =3D 0; i < 1000, i++)
    mmap N*1000 areas (N=3D[1-32])
    start the sampling
    for (j =3D 0; j < 1000, j++)
        mprotect N areas with one syscall
    stop and save the sample
    munmap N*1000 areas
calculates all samples.

Is that correct?

>
> > My worry is that if the overhead grows linearly with the number of
> > VMAs then the effects will be quite noticeable on Android where an
> > application with a few thousand VMAs is not so unusual.
> >
> The overhead is likely to grow linearly with the number of VMA, since
> it takes time to retrieve VMA's metadata.
>
> Let's use one data sample to look at impact:
>
> Test: munmap 1000 memory range, each memory range has 1 VMA
>
> syscall__       vmas    t       t_mseal delta_ns        per_vma %
> munmap__        1       909     944     35      35      104%
>
> For those 1000 munmap calls, sealing adds 35000 ns in total, or 35 ns per=
 call.
>
> The delta seems to be insignificant. e.g. it will take about 28571
> munmap call to have 1 ms difference (1000000/35=3D28571)
>
> When I look at the data from 5.10 to 6.8, for the same munmap call,
> 6.8 adds 552 ns per call, which is 15 times bigger.
>
> syscall__       vmas    t_5_10  t_6_8   delta_ns        per_vma %
> munmap__        1       357     909     552     552     254%

I'm not yet claiming the overhead is too high. I want to understand
first what is being measured here.
Thanks,
Suren.

>
>
> > >
> > > -Jeff

