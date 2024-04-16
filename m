Return-Path: <linux-kselftest+bounces-8219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60628A7507
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 21:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC761F21445
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF071384BC;
	Tue, 16 Apr 2024 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gIPnfds+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3748613E
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713296439; cv=none; b=liJ7thDWbtcrpZnLcDpNdFy3K1cyRIlNVcgymrH7onAfn+ZrrHk+HRwHtdvQMn09CKU0dghjUPymWZDhHQsgUq973xqGh3mDMM1cgEo9VQWjun+A27HoTY6Vtaql6NzdisrWNJvjd/1QMShhzgggn38yIio91BWFcGNkrGK2VAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713296439; c=relaxed/simple;
	bh=RvR6Qs/XmUof5Nbp59FmfgdsMMPaxV8slV+aC7LWifg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KXwnm8zq/lEfdsLmrp1c9+c5ZC/pcsCcY7IfvYcwChPOxNlg9dPzN+8f0dRKeDlyvrT/+tHCP6BcTA/J0dDT3aXe8ufBApMFD9lLKgE5xw6qYETH89HME7qj6NEwKhEGHKlE2bI4WPf9MPhBfl9bWqxNg0x/irmBMjTYYQ+LjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gIPnfds+; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-233e41de0caso1551481fac.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713296437; x=1713901237; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwEv4Z/MXON03xxjjs3as0fX96oGOhkKVq/HAbUMzow=;
        b=gIPnfds+AZmqgVlPcM05vY2KMGCvBFfZX+tCc4fa3kNhn9OmFIDYBvKWgmrN9p3LWl
         KmOkk74I4nLya8fELsVfokSYibTpF0NjFRsKW9m1cKQ+qDP4smksUnQvgbp1ayHnsoBn
         OX/556GWj6ENvVZEM4uqvtskjAUpcN9ZtZSAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713296437; x=1713901237;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwEv4Z/MXON03xxjjs3as0fX96oGOhkKVq/HAbUMzow=;
        b=OKW5i8al3gmh+mfB5hjAYrpY3MoSAXXVy9o4P3ydKeWNyLNj5e+WON9VMdvSK8jb2I
         b9uq+noagjjjsHZaCB4LWIkKsHu+Xza6RnmYRDkx6Hxjh8Nj6vxHm5b1MjzYVVFxlTWW
         UMuqrMjYrGRgmvZS3LyLeF8UxbUeFt4UjmfZQFsQ2ed/xVjtjoRnQpQIGdz+vPj7qwx8
         KZPa+ZHW1RQq2xpuPoJqumMU0Z/EagHAuQkkmmleT2GTrq7Nf/fi2DNfr6qVGEaq0Sjr
         RztWQb2a/T7LXwKV/+h9jDC/YIrvfhY7/+s81oJxpkVsTKxTw/TE/7dIgS2VECzUh17L
         lE7A==
X-Forwarded-Encrypted: i=1; AJvYcCXJgZl+WTQtvCazgiGbW3PenLZRYP6gAvGAK2pLjK27aOEslsKtaILl/8qmj19i5BeRYDcelM7cxIdhor6zKNWKJYIRV6pM40H4zSk5uPvB
X-Gm-Message-State: AOJu0Yy/mWCwZLyYzvLLup2ydrH7nUROhm57UGCdzMBA0LjLfCcYpsuT
	xWZTiFMtPDHpXhmBlR9db/d8045xZU0rga73mMmsBRkbEIaw0zJ2P90q7Lr8WsYQ9keMwY07gj9
	wNVSBQOprJhMopiCOlHDcbS6hc8uzP5DCWd9q
X-Google-Smtp-Source: AGHT+IFpMnnuBnQ5Arki390SOLtA3w0Zzb02W+aYx36dAai5mD00AOXWCVWabXOS8NOrnI69HIi0pttIqRN879o1qMk=
X-Received: by 2002:a05:6870:d14d:b0:22a:4249:f409 with SMTP id
 f13-20020a056870d14d00b0022a4249f409mr16854617oac.4.1713296437395; Tue, 16
 Apr 2024 12:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <znrbeb744774vre5dkeg7kjnnt7uuifs6xw63udcyupwj3veqh@rpcqs7dmoxi6>
In-Reply-To: <znrbeb744774vre5dkeg7kjnnt7uuifs6xw63udcyupwj3veqh@rpcqs7dmoxi6>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 16 Apr 2024 12:40:26 -0700
Message-ID: <CABi2SkU8B27O28jjTDajFpENgUHhntuRAMKFUMXr6A6AxZeyiQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:13=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [240415 12:35]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > This is V10 version, it rebases v9 patch to 6.9.rc3.
> > We also applied and tested mseal() in chrome and chromebook.
> >
> > ------------------------------------------------------------------
> ...
>
> > MM perf benchmarks
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > This patch adds a loop in the mprotect/munmap/madvise(DONTNEED) to
> > check the VMAs=E2=80=99 sealing flag, so that no partial update can be =
made,
> > when any segment within the given memory range is sealed.
> >
> > To measure the performance impact of this loop, two tests are developed=
.
> > [8]
> >
> > The first is measuring the time taken for a particular system call,
> > by using clock_gettime(CLOCK_MONOTONIC). The second is using
> > PERF_COUNT_HW_REF_CPU_CYCLES (exclude user space). Both tests have
> > similar results.
> >
> > The tests have roughly below sequence:
> > for (i =3D 0; i < 1000, i++)
> >     create 1000 mappings (1 page per VMA)
> >     start the sampling
> >     for (j =3D 0; j < 1000, j++)
> >         mprotect one mapping
> >     stop and save the sample
> >     delete 1000 mappings
> > calculates all samples.
>
>
> Thank you for doing this performance testing.
>
> >
> > Below tests are performed on Intel(R) Pentium(R) Gold 7505 @ 2.00GHz,
> > 4G memory, Chromebook.
> >
> > Based on the latest upstream code:
> > The first test (measuring time)
> > syscall__     vmas    t       t_mseal delta_ns        per_vma %
> > munmap__      1       909     944     35      35      104%
> > munmap__      2       1398    1502    104     52      107%
> > munmap__      4       2444    2594    149     37      106%
> > munmap__      8       4029    4323    293     37      107%
> > munmap__      16      6647    6935    288     18      104%
> > munmap__      32      11811   12398   587     18      105%
> > mprotect      1       439     465     26      26      106%
> > mprotect      2       1659    1745    86      43      105%
> > mprotect      4       3747    3889    142     36      104%
> > mprotect      8       6755    6969    215     27      103%
> > mprotect      16      13748   14144   396     25      103%
> > mprotect      32      27827   28969   1142    36      104%
> > madvise_      1       240     262     22      22      109%
> > madvise_      2       366     442     76      38      121%
> > madvise_      4       623     751     128     32      121%
> > madvise_      8       1110    1324    215     27      119%
> > madvise_      16      2127    2451    324     20      115%
> > madvise_      32      4109    4642    534     17      113%
> >
> > The second test (measuring cpu cycle)
> > syscall__     vmas    cpu     cmseal  delta_cpu       per_vma %
> > munmap__      1       1790    1890    100     100     106%
> > munmap__      2       2819    3033    214     107     108%
> > munmap__      4       4959    5271    312     78      106%
> > munmap__      8       8262    8745    483     60      106%
> > munmap__      16      13099   14116   1017    64      108%
> > munmap__      32      23221   24785   1565    49      107%
> > mprotect      1       906     967     62      62      107%
> > mprotect      2       3019    3203    184     92      106%
> > mprotect      4       6149    6569    420     105     107%
> > mprotect      8       9978    10524   545     68      105%
> > mprotect      16      20448   21427   979     61      105%
> > mprotect      32      40972   42935   1963    61      105%
> > madvise_      1       434     497     63      63      115%
> > madvise_      2       752     899     147     74      120%
> > madvise_      4       1313    1513    200     50      115%
> > madvise_      8       2271    2627    356     44      116%
> > madvise_      16      4312    4883    571     36      113%
> > madvise_      32      8376    9319    943     29      111%
> >
>
> If I am reading this right, madvise() is affected more than the other
> calls?  Is that expected or do we need to have a closer look?
>
The madvise() has a bigger percentage (per_vma %), but it also has a
smaller base value (cpu).

-Jeff

