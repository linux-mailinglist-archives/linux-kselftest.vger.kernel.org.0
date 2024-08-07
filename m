Return-Path: <linux-kselftest+bounces-14974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0219994B1C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C411C20F0B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB39149015;
	Wed,  7 Aug 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxx1b7hA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F0B640
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723064809; cv=none; b=Vw5MkIbl4DfGyJCCRmK9P1/c30SrvNINIamG/ehrCp9oqaDdB+5uvD63U7N2xarzqJ53AofeBZ33V/ghs7CRkhGf4MyXgUhernlo8P3MPkvHpQmOVbpuV8wJxjBKVFYZTdFK9BS/Bg/BR+7PPJsBrda0vxijiZiy+xEPNVOkoiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723064809; c=relaxed/simple;
	bh=h0pLEmC0vqblEBDym0nLWJfsKVNCB2L9NrZSGq+mOqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSsQ6b6P1Ghu6cr/WKF2IYydJNx5hFgQR4/Au/tZt6hEJutJX9TxDc8lJK5zY7HuCgLabbJL1hQ2KgmfKbOI1Yc+ujpqhmte/+mHZa4xYDOtxDlA0PfKOhVGMX1YHm+3e6n7kxcEGTOXL+jlu4qRc2osPX6QezQ4tiYUtE4k1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jxx1b7hA; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db14930a1aso227339b6e.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2024 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723064807; x=1723669607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X63NZr8tY7pC/KfADa6aqK9Rl2elszIm+RXAiFKpebY=;
        b=jxx1b7hAT0O2kZr0N6aEVwG41XXoYWMdY0v/PV2Qo5GRlRcgZcEU9Sj5EEqbK/JcAH
         wtCzaSic9gGZR2hNPgP/qwqn9Cv995D3ERNYu9Kfj47ko3aNPOldVWUX1Quf9E2PFBPF
         YS8dIepaqANhmXWfIx9cFez5+WBWbxAEYdKuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723064807; x=1723669607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X63NZr8tY7pC/KfADa6aqK9Rl2elszIm+RXAiFKpebY=;
        b=RuoaMltR3PhgAUCf5kih9mbkoHXwbBE/UC2KPxN78HhsS86yTShp6KjN3hMLzhpUv1
         SvOByupXm7deUdiqIBeQ5bAwe9KbQ6IUnwA2Db/DEYZsEDq0MdPv6ZbYU6YyerX5Bp6q
         XDifAa3dtBh6Da1Y4uSje377hBE4A+NfHrv9YsJbB+s4MT7L9hPlBCpq/hzsLEEjNukp
         rDd8RS0bWfT51zf0z/0OMK6DYK9Q7xNh2hWPTMaSz1tsFixblvRFSjhys66Jn66+O+hk
         NLccRsof1SIkjuOdOajhnhDdvy9tF+2ISEJg9iIqJuVdP9+BQK3Pwlb4r/dJcJOGXVhx
         adyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuE9QYLUAP7zrDwPEOWUeG467veqbYvkU0zMCplpPCKgkdcwj4Whoja7YzEQf2Opdnuo6VOs3W+k0Rd6ZT5l4PaKXjC5Z0JJQFvX0mhr9Q
X-Gm-Message-State: AOJu0Yxt5psRdVixqPmIWegslxOSuz1SM70iSbRiiCJbHtIYS07XMW+W
	94p5s4vuBYbVoSttgTgqDMUf7W7ksGYnIBvgPx77ULLoH6MWdSJ0HngNd+ukgEjVpgqYwCaqHbf
	IjehMFSlx5QyPkVNiDbmm2veIXfuuPl+7IPs3
X-Google-Smtp-Source: AGHT+IGBGNkb9KnSiqgvIibYqrq7+bCTy1aTQ+U1KTdmGgWttvXCNoBoHtJYqyT8fz5rNzTVxhgPlSPvKC6ALDYnjOg=
X-Received: by 2002:a05:6870:214:b0:25e:7a1:ea8f with SMTP id
 586e51a60fabf-26891ee21d2mr23203133fac.47.1723064806694; Wed, 07 Aug 2024
 14:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153544.2754247-1-jeffxu@chromium.org> <CAKbZUD2xDdbxOTvR3-P=636jvhG_JPO3h79tgB59dfPmv046hg@mail.gmail.com>
 <CALmYWFvDH=8U8wsaSjMrfCg1__S66SS-9Zo0f826XJDJT7hOSQ@mail.gmail.com>
In-Reply-To: <CALmYWFvDH=8U8wsaSjMrfCg1__S66SS-9Zo0f826XJDJT7hOSQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 7 Aug 2024 14:06:34 -0700
Message-ID: <CABi2SkWxMqjWQWe-ZsyKVkMAr8ZwysQnkVZz55hYz-DXV0L9aw@mail.gmail.com>
Subject: Re: [PATCH v1] selftest mm/mseal: fix test_seal_mremap_move_dontunmap_anyaddr
To: Jeff Xu <jeffxu@google.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, dave.hansen@intel.com, linux-hardening@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 11:03=E2=80=AFAM Jeff Xu <jeffxu@google.com> wrote:
>
> On Wed, Aug 7, 2024 at 9:38=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
> >
> > On Wed, Aug 7, 2024 at 4:35=E2=80=AFPM <jeffxu@chromium.org> wrote:
> > <snip>
> > >         /* shrink from 4 pages to 2 pages. */
> > > -       ret2 =3D mremap(ptr, size, 2 * page_size, 0, 0);
> > > +       ret2 =3D sys_mremap(ptr, size, 2 * page_size, 0, 0);
> > >         if (seal) {
> > > -               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > > +               FAIL_TEST_IF_FALSE(ret2 =3D=3D (void *) MAP_FAILED);
> >
> > MAP_FAILED is already void *
> >
> > <snip>
> > > @@ -1449,18 +1457,16 @@ static void test_seal_mremap_move_dontunmap_a=
nyaddr(bool seal)
> > >         }
> > >
> > >         /*
> > > -        * The 0xdeaddead should not have effect on dest addr
> > > +        * The 0xdead0000 should not have effect on dest addr
> > >          * when MREMAP_DONTUNMAP is set.
> > >          */
> > > -       ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONT=
UNMAP,
> > > -                       0xdeaddead);
> > > +       ret2 =3D sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_=
DONTUNMAP,
> > > +                       (void *) 0xdead0000);
> >
> > You still didn't explain why this test is actually needed. Why are you
> > testing MREMAP_DONTUNMAP's hint system?
>
> I responded in my previous email. The test is to make sure when
> sealing is applied, the call fails with correct error code. I will
> update the comment in v2 to clarify that.
>
> > This has nothing to do with mseal, you already test the
> > MREMAP_DONTUNMAP and MREMAP_FIXED paths in other tests.
> The remap code path is quite tricky, with many flags directing the call f=
low.
> The difference might not be that obvious:
>
> test_seal_mremap_move_dontunmap use 0 as new_addr, 0 indicates
> allocating a new memory.
> test_seal_mremap_move_dontunmap_anyaddr uses any arbitrary address as
> a new address.
>
> > You also don't know if 0xdead0000 is a valid page (hexagon for
> > instance seems to support 256KiB and 1MiB pages, so does ppc32, and
> > this is not something that should be hardcoded).
> >
> usually hardcode value is not good practice, but the point of this
> test is to show
> mremap can really relocate the mapping to an arbitrary address.
>
> Do you have any suggestions here ? I can think of two options to choose f=
rom:
>
> 1> use 0xd0000000
> 2> allocate a memory then free it, reuse the ptr.
>
I will send out V2 that addresses those comments above.
Thanks

