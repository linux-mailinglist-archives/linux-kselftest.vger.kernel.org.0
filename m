Return-Path: <linux-kselftest+bounces-44074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7103C0AF59
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 18:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46AE0345071
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7F123EAB6;
	Sun, 26 Oct 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="D2cUwCo3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075E209F43
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500530; cv=none; b=PbdHSOu86RJ4xVNLpwqV0hvyHOGAdRsWMvQ3ZlTrRtLxyIYIJuy13wwq8uKWojT1OC2mcfbRqVC06a6eCqPjISNXhA7Be0mdN7mrpm2PdxQ6E3PM66hbrj99Z5urL1WVtfYGGI6CCk/pepm1PD1GVUNqp5jOpi0VszXJqOH2yeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500530; c=relaxed/simple;
	bh=3a5EVCxqijKiflzPb0bXIdlFsc2ujRyl8tOzzW7onAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5UhpACyVZGIqQJkQgAgBmkGHAPCwc0NCV02DISWhD8VoFJ80esxT4KLKMrLg0lIMSpgRDdZPSFyWSAqY5ZKeyprdgHofUSWFwOqOjFIikX3W1MiownpU2O5HUU0Vvgs1/DkDa77JVePAWGjkn+T3chcYUAWa0R7NRqLJUfgREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=D2cUwCo3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b472842981fso523332866b.1
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761500527; x=1762105327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hY9TwQ1CLJJR8gD9MPjIVFMc/sVRR1dOB+4vQ75ofU=;
        b=D2cUwCo3w6HhwvlGh3ICme3mpVXJQPIL4fgtgm79wbvWaHD08/ylB9DIhsXkh0bFOY
         UqJaPgQ+729mounSbhKWI5bl1nNRKEPSqjT4KUzzGsBAds1806W/1Dex08BQNMRtsvyF
         0nTmLahq2yzaKG9vJyrL04O5RWH9WMc4GGGuCeR6KnaTZ74Sqm43t6z0AcVjV9Vq6DmB
         hHYy70409Z+3BxElAMkam+EMzqoAvmMUJSZcFOEDOaHX/v9VuegI33H5Q9NohF+fOE+l
         JtkW/EluQ6DvtUxn/kzl1lWiLxMeN8Jz0z5eTN4v9qfcvMz2h8YLKjSZJ49ap0jVsqLH
         9l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761500527; x=1762105327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hY9TwQ1CLJJR8gD9MPjIVFMc/sVRR1dOB+4vQ75ofU=;
        b=xMubdpbxZQa5CFvKv2fsP+MWiyvKjbfNLnTQYO8r79lV2gbXlQRF4W97V8upSaTGGQ
         mQ64k+BA16kJukFnKCQdTKUTE+gwapKDv7sspreZDSRkZkfbLZfKPlPeagdz38u30QfA
         tbSei6egibxPM6Sd7TTZ+W9aqPj3KfS+s+60wU94fgMkxcTSnZylEkhe7vxPiXlzAtqF
         IoD0iP/m6rZRsLtEv3KdFiLG6LXGoxEyqKa2oRC/Rjpkc1C4XGxt3/FBbvr1ASWigEd3
         YcJYV1XgrT6e4Cbgx2YXgBVNZqDPPhbaT52WfrQOUnSoGKooj02wudSLDWu6LZtLjs4v
         rWOA==
X-Forwarded-Encrypted: i=1; AJvYcCU+F/nx3C3zRESDb6ttp2p/OGhbFyy+9Zs+FngY+DYLe8xCGLDIfK7TQwNYtyBVTv1/eFv7bOVIsR9JqEkQvrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3+FVCQjerih/EROQj7SI1oHgOXuFxyzSt/1dDax8eMlUZ7jq
	kK2Mb8iYE5SJE0GeFSINiiN/XWAJYm8NG5b5zTdJqZugLWCqflUHVf9eM0fGSEdnC+XPCf7vZWT
	ocCeKtAtNYo7dEK4waYWFVdeWdSzr7bIkIJ48tcMrHQ==
X-Gm-Gg: ASbGncuDJ+Xz6J/D7rr+BZutNpoJXmWwCtpgP5Cg0p3MTTj2g32PzYYKEdUyI+eChCb
	+bh9/MrXOHAOXPrL1WnsFd3/iVkCVzEXm+YQjl1oppyG9x/vCdCvSWS1MlzXs8rPbsde4GwCDJo
	Bi5PPKrRcHGHFOdeBT1bpdh3C5F89tfLAtO3BxAQLsqsPFmzE22RFeGQ1tqXCzB8o/BW87Nz0Hk
	KabNj75LPsTujuqX97fWoecmFtVKTwltZXbl8OULg8K8uEZxLFoV7HFeY7/PsuQk/sx
X-Google-Smtp-Source: AGHT+IFJAqpY/Sj1GY1CdZ1JSZWZDxA7iqjdHseliH9UljNa62GLbYll8OXsWemDYxTy88s7miJZSL9cWjxUzUEcS/I=
X-Received: by 2002:a17:907:6d20:b0:b6d:6a35:99a0 with SMTP id
 a640c23a62f3a-b6d6a359c49mr1075496866b.33.1761500526636; Sun, 26 Oct 2025
 10:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
 <20251024161002.747372-9-pasha.tatashin@soleen.com> <aP5Mcr9WCt5CHon6@kernel.org>
In-Reply-To: <aP5Mcr9WCt5CHon6@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 26 Oct 2025 13:41:30 -0400
X-Gm-Features: AWmQ_blYAsXcjKX5BaK9UiO_G89LuikSynb9OAbAPmAuzXQ2h68_P6Ww_dBxOQA
Message-ID: <CA+CK2bCUc5Q5PxCy3jGN9CC48Zz_evq51d7Hps7=r9g28z7tig@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] memblock: Unpreserve memory in case of error
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 12:29=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Fri, Oct 24, 2025 at 12:10:02PM -0400, Pasha Tatashin wrote:
> > If there is an error half way through KHO memory preservation, we shoul=
d
> > rollback and unpreserve everything that is partially preserved.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> > ---
> >  mm/memblock.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index e3bef9b35d63..5ceaa02af7d6 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2447,6 +2447,7 @@ int reserve_mem_release_by_name(const char *name)
> >
> >  static int __init prepare_kho_fdt(void)
> >  {
> > +     bool fdt_folio_preserved =3D false;
>
> fdt_preserved is enough IMHO.
>
> >       int err =3D 0, i;
> >       struct page *fdt_page;
> >       void *fdt;
> > @@ -2462,12 +2463,14 @@ static int __init prepare_kho_fdt(void)
> >
> >       err |=3D fdt_begin_node(fdt, "");
> >       err |=3D fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE=
_COMPATIBLE);
> > -     for (i =3D 0; i < reserved_mem_count; i++) {
> > +     for (i =3D 0; !err && i < reserved_mem_count; i++) {
> >               struct reserve_mem_table *map =3D &reserved_mem_table[i];
> >               struct page *page =3D phys_to_page(map->start);
> >               unsigned int nr_pages =3D map->size >> PAGE_SHIFT;
> >
> > -             err |=3D kho_preserve_pages(page, nr_pages);
> > +             err =3D kho_preserve_pages(page, nr_pages);
> > +             if (err)
> > +                     break;
>
> Please
>
>         goto err_unpreserve;

While we can do that, we loose some symmetry of not performing
fdt_end_node() and fdt_finish() if fdt lib ever adds some debugging
facility to make sure that open nodes/trees are properly clodes, this
is going to flag that. I prefer my current implementation.

>
> >               err |=3D fdt_begin_node(fdt, map->name);
> >               err |=3D fdt_property_string(fdt, "compatible", RESERVE_M=
EM_KHO_NODE_COMPATIBLE);
> >               err |=3D fdt_property(fdt, "start", &map->start, sizeof(m=
ap->start));
>
>         if (err)
>                 goto err_unpreserve;
>
> and drop !err from the loop condition.

That is going to miss one 'nr_preserved++' . We cannot do that, we
could move it to the beginning of the loop, but I prefer keeping err
right in the condition.

>
> > @@ -2477,12 +2480,27 @@ static int __init prepare_kho_fdt(void)
> >       err |=3D fdt_end_node(fdt);
> >       err |=3D fdt_finish(fdt);
> >
> > -     err |=3D kho_preserve_folio(page_folio(fdt_page));
> > -
> >       if (!err)
> > +             err =3D kho_preserve_folio(page_folio(fdt_page));
> > +
> > +     if (!err) {
> > +             fdt_folio_preserved =3D true;
> >               err =3D kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
> > +     }
> >
> >       if (err) {
> > +             int nr_reserve_map_preserved =3D i;
>
> nr_preserved is clear enough.

Sure.

> Also let's declare it before the preservation loop and count it there. Th=
an
> we can make loop variable local which makes it safer against certain side
> channel attacks. I.e the loop that preserves the memory would be

Sure.

>
>         for (unsigned int i =3D 0; i < reserve_mem_count; i++ nr_preserve=
d++)
>
> > +
> > +             for (i =3D 0; i < nr_reserve_map_preserved; i++) {
> > +                     struct reserve_mem_table *map =3D &reserved_mem_t=
able[i];
> > +                     struct page *page =3D phys_to_page(map->start);
> > +                     unsigned int nr_pages =3D map->size >> PAGE_SHIFT=
;
> > +
> > +                     kho_unpreserve_pages(page, nr_pages);
> > +             }
> > +             if (fdt_folio_preserved)
> > +                     kho_unpreserve_folio(page_folio(fdt_page));
> > +
> >               pr_err("failed to prepare memblock FDT for KHO: %d\n", er=
r);
> >               put_page(fdt_page);
> >       }
> > --
> > 2.51.1.821.gb6fe4d2222-goog
> >
>
> --
> Sincerely yours,
> Mike.

