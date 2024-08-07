Return-Path: <linux-kselftest+bounces-14941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F83494AF57
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC641C213C6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 18:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5613E04B;
	Wed,  7 Aug 2024 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ufnjhZ9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7513B58E
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053819; cv=none; b=D2antU6ccZhnl7lXeJ5ZTBsz8B039T+BOgfSfS4IN/NK/nX4haKAVh9J98X9O3tEbSDUf/H9lWRvRTsneX592Iq4iE7QyL65SLUAH2f3aNArtFFqS7NOL083ngq+dPv7YNHU8a+9WyeuDyZgR8xlZcON1VIIUFH0ohRpKDKmKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053819; c=relaxed/simple;
	bh=/igLW5cGKyvrc8xeJe9spHKRE8+5cRBzFIFSVqv7Cd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+igygGBDk9VyqPrGzbBnwkRcD9tAqxzadzJ9XukoGp9OpN2QV7tZduFiNQt4T2Fh8wVQHMY+qodtHhzpF49fI4n+EKUlI9kywTlIRwaKm+3rU9iZFWpBYaovNyeHZmoVrA+w5jk5xMGJl2wbx3fSougAMn74K1IDTCT8ZRMPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ufnjhZ9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so1943a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2024 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723053815; x=1723658615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyQtOF1vxDhDuNycgpsX5NQIqDKmQIL//+OA3nFwfHM=;
        b=3ufnjhZ96PTsUkxMdHTxgQQu15Op4lb7FHtEybxD5WpVn5GmhQcEn1kUsWDFJX4U88
         riiDWEa22mlSzz5TWRygjZzgldCvz/bvfBC1U/rnmuDutm6W6KgfKqzOArEM/A8a8zv/
         gpXW/oQx0oCJn123trJX9u1HV6SC6pQC6HBPHLRLcr0oJHUhX4LDqG0lfBDyRc4hApFm
         a5ud5twZ1Gn/fH0UXgOQGnE0ac8FiOGkJA+e/B1D5OMp608nK3s5QssRwwEjhGTSi86q
         WXbSplftxr4d8fqq0olX5ypI48BzMELLigrDxK4Rwh/oezyFQ7YjPTzvcU8S0vCvUogU
         Ax3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053815; x=1723658615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyQtOF1vxDhDuNycgpsX5NQIqDKmQIL//+OA3nFwfHM=;
        b=ppgzG+K3xh61c2PsH0AD4tS3KvBV86kMh7+ZuQ8JR6I02aThi39zAs4SNgaRjS2p3D
         sGOjJQsjFfuEmuA4lL+6GU3ZpJh9aDhD6ON1FmNW8PMMu+KoPR+CSQDp7OBJdkv+QZG7
         QasAuDz7IZjSh4xCkiqTsVFaKArOuZYegB1pv/nPQLQobJVJFuYxpRQSC6It9JwiXbaI
         dHSqHXLVs7w9gxo5i5h0oKr/tuG/9tAqR9gHH6irqveQ2/qlxg9QAiS+WNp3n/3yeHnT
         cjSMm81CjHnd5E9DgJsQAnWpT6uI1vFHMHav9sp8SyA7/X4EiTSjJ2F0b6WpKTG8o6Ar
         e5lA==
X-Forwarded-Encrypted: i=1; AJvYcCW01fN+T4sJue913bCwvy3LeU/uhv4CBq4YVR7Gye14SEGMYyUnGAtQsn91A+hfM1q5V0oWwwBvGfqMSucGgLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcp6ib5zY+L1nO4rNz2YZuwu2ChEAkPL76F8y2DFv/Sm2Z4cqS
	fLBAuStCbrLpli+b13pEe4O0XlgzJ0aoNWAfNR0ETfN76sXVoTY29kbMzYp9DLLrsY2fbb12xNB
	F/rodVKogWEtQjiAJRgVlHZVBLxM+6F2U7iUU
X-Google-Smtp-Source: AGHT+IHNgXjgqrAbiQnTxyfIC4MSApJgByOFffPeEqrpJGfxkuZ/yQYeD3R3pXQSk7hIuBatYSkKH+LlCFukduDyhC8=
X-Received: by 2002:a05:6402:2751:b0:58b:93:b623 with SMTP id
 4fb4d7f45d1cf-5bbb002ac8dmr3758a12.5.1723053814540; Wed, 07 Aug 2024 11:03:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153544.2754247-1-jeffxu@chromium.org> <CAKbZUD2xDdbxOTvR3-P=636jvhG_JPO3h79tgB59dfPmv046hg@mail.gmail.com>
In-Reply-To: <CAKbZUD2xDdbxOTvR3-P=636jvhG_JPO3h79tgB59dfPmv046hg@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 7 Aug 2024 11:02:54 -0700
Message-ID: <CALmYWFvDH=8U8wsaSjMrfCg1__S66SS-9Zo0f826XJDJT7hOSQ@mail.gmail.com>
Subject: Re: [PATCH v1] selftest mm/mseal: fix test_seal_mremap_move_dontunmap_anyaddr
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, dave.hansen@intel.com, linux-hardening@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:38=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 4:35=E2=80=AFPM <jeffxu@chromium.org> wrote:
> <snip>
> >         /* shrink from 4 pages to 2 pages. */
> > -       ret2 =3D mremap(ptr, size, 2 * page_size, 0, 0);
> > +       ret2 =3D sys_mremap(ptr, size, 2 * page_size, 0, 0);
> >         if (seal) {
> > -               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +               FAIL_TEST_IF_FALSE(ret2 =3D=3D (void *) MAP_FAILED);
>
> MAP_FAILED is already void *
>
> <snip>
> > @@ -1449,18 +1457,16 @@ static void test_seal_mremap_move_dontunmap_any=
addr(bool seal)
> >         }
> >
> >         /*
> > -        * The 0xdeaddead should not have effect on dest addr
> > +        * The 0xdead0000 should not have effect on dest addr
> >          * when MREMAP_DONTUNMAP is set.
> >          */
> > -       ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUN=
MAP,
> > -                       0xdeaddead);
> > +       ret2 =3D sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DO=
NTUNMAP,
> > +                       (void *) 0xdead0000);
>
> You still didn't explain why this test is actually needed. Why are you
> testing MREMAP_DONTUNMAP's hint system?

I responded in my previous email. The test is to make sure when
sealing is applied, the call fails with correct error code. I will
update the comment in v2 to clarify that.

> This has nothing to do with mseal, you already test the
> MREMAP_DONTUNMAP and MREMAP_FIXED paths in other tests.
The remap code path is quite tricky, with many flags directing the call flo=
w.
The difference might not be that obvious:

test_seal_mremap_move_dontunmap use 0 as new_addr, 0 indicates
allocating a new memory.
test_seal_mremap_move_dontunmap_anyaddr uses any arbitrary address as
a new address.

> You also don't know if 0xdead0000 is a valid page (hexagon for
> instance seems to support 256KiB and 1MiB pages, so does ppc32, and
> this is not something that should be hardcoded).
>
usually hardcode value is not good practice, but the point of this
test is to show
mremap can really relocate the mapping to an arbitrary address.

Do you have any suggestions here ? I can think of two options to choose fro=
m:

1> use 0xd0000000
2> allocate a memory then free it, reuse the ptr.

Thanks
-Jeff

