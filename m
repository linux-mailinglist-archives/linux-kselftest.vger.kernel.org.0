Return-Path: <linux-kselftest+bounces-43980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD246C06976
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 875E44FE258
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 13:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6C031AF3C;
	Fri, 24 Oct 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AHRNDVf2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51845320A09
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314285; cv=none; b=DjPy5z03MdQ+kT9Ne9qEYPXl1yHqw3lAeBx+zgu+dqJKXhx8DcW2auikCYg/eOVqu6F3ApC6rLbNBD9ZdLBnyaDQgtj3QLseSprxvtIutWh7s8IWKJdFExF/tLu/DH0q0LxRX3voXlgnwojQealV6HrUvRj7Brc546jUUQ54lqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314285; c=relaxed/simple;
	bh=qb8JXmt3CN5uxM93KzjvrKeVVtejTDlP7Ge1CaHpbPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6wNTesZIQefQnBbJSs/7qYZjSsFJjTVR9qNVUb2Nd945jvKbXxk+Ga8pgnIxZYkPux/ToU7jnAspYzLaB9L9ypNhSIAhucAsSjy7v+s3Po4rU+hXZECw2hJLaqBiBfn3HLS7kz5ZZwQWH8EsFdKMjrD02n64vjhoXgpBzRUzrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=AHRNDVf2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so4018050a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761314281; x=1761919081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb8JXmt3CN5uxM93KzjvrKeVVtejTDlP7Ge1CaHpbPQ=;
        b=AHRNDVf2Y5e6ED6jZgYRSHtTQBUhniyPVHzKwvoqKxM/fUqhoQpnMC78WXDTFG8DtG
         utZO2ivVTfH0kEgeprJtzF/y+F0smM6Dew4TRDPeUeJTmMyObXKOiopvYXAHHEVtZtE0
         oDVd8hegOJDjtLo/SmwL8t3SGMWAO7w6QYUOEZtS4+/XjacknxN3Jyf2EVm4lNPs5U1s
         ocElgbPC9FO8WbyYdAbi1N5A/xjRwlzjKEcn2WmrctXQkyEItPC/6VZBO6W3mX41X5zw
         G3gXI8PBE09EVlLaf+7f0pFQ4/9AaSfUgEOLX9fch6x0N4dFE0rEkmNAZfKHsUNgsEZi
         s2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761314281; x=1761919081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qb8JXmt3CN5uxM93KzjvrKeVVtejTDlP7Ge1CaHpbPQ=;
        b=WZG6IadYqokUBhx5JvL6A3F/4+j5sfFqDuz8EeAwYolEWwHP1zdDYcGbMV9KKh/sfX
         DCm4WbJc1ERiSERMyY9b7knAkYPiKx0jeonOO0UP8r3TWSKbaE/klKNckkCrAoas+EHP
         xqq8/cKHVf14howsl61WsL33B7b8aNo71TZYW7myGldew3K9mkQlDCyIGs3hWqGW6n5b
         MPcnUTKvjSyj9xb+SMDDs0AFtatT4R3A+5kKlkMDgFQYWDvMWNlmRIJZdUSMrbMVPKF4
         6gbCvB45+6JZgpUK9fLkZlvQJN28NHh8PE7tS2AU92yQ3xBrzlogb+oi+wpAU/Jgx3bU
         kGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnGDdZAdKZuTf1sxupQo3c4aoDePm+gf+dLRlnDSEdwKqybTk2B3L5XoDH7oCeI7GX7JTmOJSae+e8DFIIV24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOg+OAOHDTO4hLq5qRC/vFXtymeRZvozYgMXIZEsBXKVnyvJBA
	EKSRghkRotxLbVValLiSPuaPQIzKL37RcgFpf6LHrIU+BtmYmeiVBPw2MLWtOdlbjaTHv85POIt
	MZ9xURPlmCAyp/Pzd6jwIzVwlhtCJsqfqTXmQwLGbfg==
X-Gm-Gg: ASbGncuoPdVd/dR8QFBpAIYDyTiYMiENtYt3aTaG2BuzMEJZxp8awjSJWF7CGDiUIXr
	VdBsEgGnw5wZvkG7SgbFW+fJonUWSTTk42NJ3P22/lT2cDy0IvrsT+DBcUtu5iy6drVdMuJnbGX
	smuKEMTinrMd6XFXGnIz4nYqhUiImxDciFVfvvAfFShIN+2h5yUBsTN0IpyJ+NEb2m15VFarPet
	i6qk2JAmAhLf6E8FPj6CkjdlkKBw+teTOarE8uv0AWixWoUoPnbSE0H0A==
X-Google-Smtp-Source: AGHT+IGPZvY6fQtYpWdkCyVf9zr3LEiwL9z5kpvIR+uzM68lrE3k7xdjWb85Betn3HUBNcScbWokGmgQudK/7sh5h8E=
X-Received: by 2002:a05:6402:44d2:b0:63e:abe:711d with SMTP id
 4fb4d7f45d1cf-63e0abe71c6mr8941213a12.37.1761314281487; Fri, 24 Oct 2025
 06:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com> <mafs0v7kgjoxq.fsf@kernel.org>
 <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com> <20251024132509.GB760669@ziepe.ca>
In-Reply-To: <20251024132509.GB760669@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 09:57:24 -0400
X-Gm-Features: AWmQ_bmzgVBN6dVwpAuI8-pyXN2jvCTQCCKwN8AyXWnXRMNuvq3-OooS2e7d9eg
Message-ID: <CA+CK2bA_Qb9csWvEQb-zpxgMg7vy+gw9eh0z88QBEdiFdtopMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com, 
	glider@google.com, elver@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:25=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Oct 15, 2025 at 10:19:08AM -0400, Pasha Tatashin wrote:
> > On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Pratyush Yadav <pratyush@kernel=
.org> wrote:
> > >
> > > +Cc Marco, Alexander
> > >
> > > On Wed, Oct 15 2025, Pasha Tatashin wrote:
> > >
> > > > KHO allocates metadata for its preserved memory map using the SLUB
> > > > allocator via kzalloc(). This metadata is temporary and is used by =
the
> > > > next kernel during early boot to find preserved memory.
> > > >
> > > > A problem arises when KFENCE is enabled. kzalloc() calls can be
> > > > randomly intercepted by kfence_alloc(), which services the allocati=
on
> > > > from a dedicated KFENCE memory pool. This pool is allocated early i=
n
> > > > boot via memblock.
> > >
> > > At some point, we'd probably want to add support for preserving slab
> > > objects using KHO. That wouldn't work if the objects can land in scra=
tch
> > > memory. Right now, the kfence pools are allocated right before KHO go=
es
> > > out of scratch-only and memblock frees pages to buddy.
> >
> > If we do that, most likely we will add a GFP flag that goes with it,
> > so the slab can use a special pool of pages that are preservable.
> > Otherwise, we are going to be leaking memory from the old kernel in
> > the unpreserved parts of the pages.
>
> That isn't an issue. If we make slab preservable then we'd have to
> preserve the page and then somehow record what order is stored in that
> page and a bit map of which parts are allocated to restore the slab
> state on recovery.
>
> So long as the non-preserved memory comes back as freed on the
> sucessor kernel it doesn't matter what was in it in the preceeding
> kernel. The new kernel will eventually zero it. So it isn't a 'leak'.

Hi Jason,

I agree, it's not a "leak" in the traditional sense, as we trust the
successor kernel to manage its own memory.

However, my concern is that without a dedicated GFP flag, this
partial-page preservation model becomes too fragile, inefficient, and
creates a data exposure risk.

You're right the new kernel will eventually zero memory, but KHO
preserves at page granularity. If we preserve a single slab object,
the entire page is handed off. When the new kernel maps that page
(e.g., to userspace) to access the preserved object, it also exposes
the unpreserved portions of that same page. Those portions contain
stale data from the old kernel and won't have been zeroed yet,
creating an easy-to-miss data leak vector. It makes the API very
error-prone.

There's also the inefficiency. The unpreserved parts of that page are
unusable by the new kernel until the preserved object is freed.
Depending on the use case, that object might live for the entire
kernel lifetime, effectively wasting that memory. This waste could
then accumulate with each subsequent live update.

Trying to create a special KHO slab cache isn't a solution either,
since slab caches are often merged.

As I see it, the only robust solution is to use a special GFP flag.
This would force these allocations to come from a dedicated pool of
pages that are fully preserved, with no partial/mixed-use pages and
also retrieved as slabs.

That said, I'm not sure preserving individual slab objects is a high
priority right now. It might be simpler to avoid it altogether.

Pasha

