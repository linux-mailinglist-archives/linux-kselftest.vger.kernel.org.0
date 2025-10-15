Return-Path: <linux-kselftest+bounces-43189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABA0BDE887
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242D440757E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19C18FDBD;
	Wed, 15 Oct 2025 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="b6WsEk4Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A717BA6
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532428; cv=none; b=RPgJXb5oU7uBFaeZN/35jY30ri4ynX4VeTZoFAQsgyWFg5gxymIWxiPK771Jq4nvu30Kdj/stAfQ9pHZzDJqgnsRiOOPjBhY+Dssge1e4LyKItCtgFucGB8H938pUX0IP3bDdgNw+h8CdvC/FNN9/cNmmxv2onx95lIW5VD0mhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532428; c=relaxed/simple;
	bh=NRKV1T0JG8NZx8AcR0RBUF6Siah/rEqSNeRP0kpNyyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjVoFjk3daK/krGeKiVc+ZvrTpgYQt8qchsIJIWHmiv255e5dW9tAQ86fmYALg0o2FGqUHqymNJggRDA0loAMI+5Ztb0qFAB7W1oIhJq21ICX+ZAnLJwxOs2p2bCTseRDO3puU1zuQTlLGmqO2KlIDFiZC+0XIERLvrvpCVFEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=b6WsEk4Y; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63b9da76e42so6680926a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760532425; x=1761137225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2rJf2s9a/90ejKbIMoBGAX/K6G3zekU+IsWPNH59pU=;
        b=b6WsEk4YlswZcoc44I+SZ+5CHxktw14nXz+dF5xf4iebyHuYz+XDLE0ZIFyDqrW0uo
         lK/oeirRUeZJ7b4muV2uYaPcRUZoDlO88HC/x3SqNmfxinSbdHvp+47UP/ltJtLOTh5A
         0pLhWSyAYYYCGu8e4at6eWu3SbiKZDLKvnMRhuV9oeP6F5Ae/W2HpSz/VsmmOtERcHCS
         yLEkgzddUCWRlHkcTMY8g9TXq5EFKCbtLRaTU0Er6+tVkn7gtGU7P621rdHsisvcJq7F
         B2z6ykWeAxeFQ88yT4mvbLmf+5peAAnNyit+kexnH+VJ/GVujNCjgoZTRW+scW5osHO6
         nOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760532425; x=1761137225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2rJf2s9a/90ejKbIMoBGAX/K6G3zekU+IsWPNH59pU=;
        b=PXrtJWfrseyiTmK4FT1k84wpsixDtu3JYgJrU45QcZLV2kZQd1IVw5JssML0s5kBev
         MISKLu0ovt/wto4Z160mLGqE5Welh2vk7smDhJYM12mGcY9tfAU0i+eehaIY5QkIBhQt
         nX0PQRv14MU05jipkwsPt/ncUqYs4z02Pydq610E7uVtDH0+qHlQgEYKpOwdiL3UI/Xb
         /Qh/29GIWxlpRHpvvaqdlP8c5SdGoi7RZ/WMx8VKFPwZOY4ipV1NKRMi+510nkJj1nIb
         jM6YInznbJ5dUDdGjQdseITJ1CSLgGziN8GAIcsrEgQzvEKhydfN9WTtV9kbltwxClNz
         X5kA==
X-Forwarded-Encrypted: i=1; AJvYcCV9jIpo/EMWPtTiuj0PpDq2SISU4pxKz6NbRhjW0aproDZAD2xlMIyRopsqEBfUTuX1/Z4ebuu/UYq9ZEN0q88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOZ0cSUD2tK5nS23bZkR5xubq/UoM2e24UcTuzgqQkFnnP476
	FXIR01Ugd+2GNNuttwZvkjJJW6o/6z2Mn7G/iNtet9QZC11epJ9qJ3/dausD7+Sl1y4Ysmrr/S9
	0tBrQsg9lIFg64G2TwFbjttfcGuT/wi9X1ke8OsCyCw==
X-Gm-Gg: ASbGncsN7cmHTF9R/cMXPdJr1ZwozFXLbDGeSMQbeCkuyqikUOWILwyjUz0X6on0yup
	7nr+ciaYOLqfa6pyBIKjc1ihTpL5qdDC+2CtFzzFI682aWZ4r/YbP+WT4BV4B1VImpux96Hh+HF
	fVW2hjA72C1ooE22ebwphAOdMUqH9Hij9fd2GyESG4k8VYe0YAM5SIapqECj7kBzhrVAYpJ7jFP
	tp6+6p8/FrVesgYeOKMBxnH470rBXTBkg==
X-Google-Smtp-Source: AGHT+IGAFTqJVPwHxcA0ShT3fW/qoKauowy5jUJdRfRhyaAyJD7junVZzX8Qqs0XlApvrohmQUMYJX1KeVDcUbjxRvs=
X-Received: by 2002:a05:6402:210d:b0:639:e9a4:a5f1 with SMTP id
 4fb4d7f45d1cf-639e9a4c39amr26557075a12.27.1760532425223; Wed, 15 Oct 2025
 05:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com> <aO9dSizvhyTznMHZ@kernel.org>
In-Reply-To: <aO9dSizvhyTznMHZ@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 08:46:28 -0400
X-Gm-Features: AS18NWDCS4lqUlJea3J3apqOO7D5fdtAUaxHwzBnnNw5P6AFHB0NDa_9X__oGwk
Message-ID: <CA+CK2bB6GiivEhHYUg8roSug_cAnPBHJTc=J13nS+7iRJD7rTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:37=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Wed, Oct 15, 2025 at 01:31:21AM -0400, Pasha Tatashin wrote:
> > KHO allocates metadata for its preserved memory map using the SLUB
> > allocator via kzalloc(). This metadata is temporary and is used by the
> > next kernel during early boot to find preserved memory.
> >
> > A problem arises when KFENCE is enabled. kzalloc() calls can be
> > randomly intercepted by kfence_alloc(), which services the allocation
> > from a dedicated KFENCE memory pool. This pool is allocated early in
> > boot via memblock.
> >
> > When booting via KHO, the memblock allocator is restricted to a "scratc=
h
> > area", forcing the KFENCE pool to be allocated within it. This creates =
a
> > conflict, as the scratch area is expected to be ephemeral and
> > overwriteable by a subsequent kexec. If KHO metadata is placed in this
> > KFENCE pool, it leads to memory corruption when the next kernel is
> > loaded.
> >
> > To fix this, modify KHO to allocate its metadata directly from the budd=
y
> > allocator instead of SLUB.
> >
> > As part of this change, the metadata bitmap size is increased from 512
> > bytes to PAGE_SIZE to align with the page-based allocations from the
> > buddy system.
> >
> > Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation=
")
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index ef1e6f7a234b..519de6d68b27 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -66,10 +66,10 @@ early_param("kho", kho_parse_enable);
> >   * Keep track of memory that is to be preserved across KHO.
> >   *
> >   * The serializing side uses two levels of xarrays to manage chunks of=
 per-order
> > - * 512 byte bitmaps. For instance if PAGE_SIZE =3D 4096, the entire 1G=
 order of a
> > - * 1TB system would fit inside a single 512 byte bitmap. For order 0 a=
llocations
> > - * each bitmap will cover 16M of address space. Thus, for 16G of memor=
y at most
> > - * 512K of bitmap memory will be needed for order 0.
> > + * PAGE_SIZE byte bitmaps. For instance if PAGE_SIZE =3D 4096, the ent=
ire 1G order
> > + * of a 8TB system would fit inside a single 4096 byte bitmap. For ord=
er 0
> > + * allocations each bitmap will cover 128M of address space. Thus, for=
 16G of
> > + * memory at most 512K of bitmap memory will be needed for order 0.
> >   *
> >   * This approach is fully incremental, as the serialization progresses=
 folios
> >   * can continue be aggregated to the tracker. The final step, immediat=
ely prior
> > @@ -77,7 +77,7 @@ early_param("kho", kho_parse_enable);
> >   * successor kernel to parse.
> >   */
> >
> > -#define PRESERVE_BITS (512 * 8)
> > +#define PRESERVE_BITS (PAGE_SIZE * 8)
> >
> >  struct kho_mem_phys_bits {
> >       DECLARE_BITMAP(preserve, PRESERVE_BITS);
> > @@ -131,18 +131,21 @@ static struct kho_out kho_out =3D {
> >
> >  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, =
size_t sz)
>
> The name 'xa_load_or_alloc' is confusing now that we only use this functi=
on

Indeed, but this is not something that is done by this patch

> to allocate bitmaps. I think it should be renamed to reflect that and it'=
s
> return type should be 'struct kho_mem_phys_bits'. Then it wouldn't need s=
z
> parameter and the size calculations below become redundant.

I am thinking of splitting from this patch increase of bitmap size to
PAGE_SIZE, and after that re-name this function, and remove size_t
argument in another patch, and finally the fix patch that replaces
slub with buddy.

>
> >  {
> > +     unsigned int order;
> >       void *elm, *res;
> >
> >       elm =3D xa_load(xa, index);
> >       if (elm)
> >               return elm;
> >
> > -     elm =3D kzalloc(sz, GFP_KERNEL);
> > +     order =3D get_order(sz);
> > +     elm =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> >       if (!elm)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz))) {
> > -             kfree(elm);
> > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm),
> > +                                     PAGE_SIZE << order))) {
> > +             free_pages((unsigned long)elm, order);
> >               return ERR_PTR(-EINVAL);
> >       }
> >
>
> --
> Sincerely yours,
> Mike.

