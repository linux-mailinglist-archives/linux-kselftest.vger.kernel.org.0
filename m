Return-Path: <linux-kselftest+bounces-43984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07AC06BCF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C9614EE73E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A090731A565;
	Fri, 24 Oct 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WgQ6pcuE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB863195F4
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316647; cv=none; b=Y45p8iGUtDZuCMcR/2kfwhxOr0OQS1Kc2YXpf2EqLHbLHnnSW2rTi/7Czs9MDQZebBW0RotTnMZhJBtrTKMq2sdRNVeADp1IlX15DoStotCR9vrriRskBItI0xI4h1uNU1E4qREsSs3M/J7/mYpUWmphblVjJPq/uPeKC78VqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316647; c=relaxed/simple;
	bh=GmHMlLZ8cvGQzV1SOkvzrPxFQut2bZwdLJk1swGEGSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZyB/EoMc5R7UA/VQTt1f5J9yVAltckmD/poa/vHCVX5aMEDkrT1VwKuTt3WrTxjbh6gU0Dp8El8NTC9P2OmlDnVvrdSqjENtJ6KUyvwannqtXDTRONDP+07KGwIMpYfrfniGJFlkOP4epZvKdVCVKWRxR3iXvOYug1QnB7tpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=WgQ6pcuE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso3533306a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761316644; x=1761921444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmHMlLZ8cvGQzV1SOkvzrPxFQut2bZwdLJk1swGEGSk=;
        b=WgQ6pcuEu6V1UlzsJ5RU3AmOZ7z5W+K1X/6gxjQlnoq+yq64QgffwPlIVMrzMFM7u1
         Z2bFWTCzd0JkWbMBzHlXJpNpc30tC+xs5lsBSXRvXfMd/z4geqAJHiNHDIoQI+CEPp9k
         01+f/H1FZfm5pGmqFlOjXIOh43BI7sZHhjb77Nr1Eh5mx+Sd7m1+QsSM9liiekNnnPWR
         72vwRebMbNNDCS1tnkz/CfWY43x6lOFLyFt4K+HtCeabWNzePOzS7YHLCVrbvRVfPIDC
         R2GdcUbHr0v5gUxdo5p4dal+Gp3MH5ftWQ42Ixl1hlc6XC0W+jAK6GSDEOfRWt3ktTXC
         Mx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316644; x=1761921444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmHMlLZ8cvGQzV1SOkvzrPxFQut2bZwdLJk1swGEGSk=;
        b=rt1rsCAoY84QlPDhW2TOZ2JTCPb0l879mPeAN4HC7Fd0kNcKrqFNtc4lvd+/J8EfxU
         LoOiJT9TAoDxRoBSp/vYDuTKtaMUDVfJkvKJLWN6lGEvFf0F04PHbbUinw7lynKSdA3w
         633XtfMXZ6Ja2GpmRg6i5S7sA1a6c3bOZFSIQuGVwS5LNPCUuWi0RRvWxDOcOnf+peW+
         ReY+zZEmwHcYE4q9Izbgvo+PdNGPBZ1yy1xD9Nyo7zsBI6N323wRStIER7miWugFCbST
         T7rE0RA+eEhZsjaaf9MMhiCAYeapqPnXlyxAMHfaOEh4SymkMP5Wp7RXLspZwisfpIjU
         I1Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVO8JY2gWIeuGl3jL+zpRU+pJ92Otw9/93N3yZPD6m16qkycVqxmYUFgaGBozM2xhmmuBx4lwuisiDOM+RCT10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHeSu0ZVF14SJ7+J89IztLXfRLfCV+4umsZ6jyvJkL0PrOEbqc
	ZtIcYFaf+pXqnpWhDyXDAEf0ioJhlmMsyvvHazs5j6bSVo6dxRne5wRh4QijDVcX63dBWjcXpnn
	QWTctVX4gk5cqdo2gmGcvFQE9lZ8dEhFfGZl7bJyIoQ==
X-Gm-Gg: ASbGnctPj9Y4QGvVmMjZiDKUYNaKnCIdrdfKQMHhC9OrgH1nkaEIHxHH4Q49ZdU2IF5
	f6SqODbdUrv3u/NKGvLR/FerlrGehn3GB4dIjJm+tftoDr09Ma/l2VggOFyeRo3OsTdySV5gpcH
	mV4ZlNj9UWKwrJXk/79/zk5UDDKvzsD392BAeuTyvdR4otWu5nQndwmy7s6bAnheCc4ofXAGf5H
	lJz7o/7nAKykC6ejtQVKb6JFi75tC3sohpynhpq4po0o1gsHMSCkRh9y7WdD17rzQ8U
X-Google-Smtp-Source: AGHT+IEfOi1byJ+YLjxux8pLcP3Y0/44GAhTeTAdDPQawfljn6Do83/M7DWjU9PXB2SaCV6T+qWh3glv4Xxf9wCVO9c=
X-Received: by 2002:a05:6402:2743:b0:63b:f909:df50 with SMTP id
 4fb4d7f45d1cf-63c1f678160mr26420883a12.14.1761316643832; Fri, 24 Oct 2025
 07:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com> <mafs0v7kgjoxq.fsf@kernel.org>
 <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
 <20251024132509.GB760669@ziepe.ca> <CA+CK2bA_Qb9csWvEQb-zpxgMg7vy+gw9eh0z88QBEdiFdtopMQ@mail.gmail.com>
 <20251024142014.GC760669@ziepe.ca>
In-Reply-To: <20251024142014.GC760669@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 10:36:45 -0400
X-Gm-Features: AWmQ_bk6wACdguYPSb706om9VW_qPfXpGj3IbeoEqxd6IkOxzPID_oUmtMSi-F4
Message-ID: <CA+CK2bAmPN+v7SYsdHA+RL4kFfnoQvKqTqZ2YQ4wdq6dnFkotg@mail.gmail.com>
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

On Fri, Oct 24, 2025 at 10:20=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, Oct 24, 2025 at 09:57:24AM -0400, Pasha Tatashin wrote:
>
> > You're right the new kernel will eventually zero memory, but KHO
> > preserves at page granularity. If we preserve a single slab object,
> > the entire page is handed off. When the new kernel maps that page
> > (e.g., to userspace) to access the preserved object, it also exposes
> > the unpreserved portions of that same page. Those portions contain
> > stale data from the old kernel and won't have been zeroed yet,
> > creating an easy-to-miss data leak vector.
>
> Do we zero any of the memory on KHO? Honestly, I wouldn't worry about
> the point it zeros, slab guarentees it will be zero when it should be
> zero.

We do not zero memory on kexec/KHO/LU; instead, the next kernel zeroes
memory on demand during allocation. My point is that the KHO interface
retrieves a full page in the next kernel, not an individual slab.
Consequently, a caller might retrieve data that was preserved as a
slab in the previous kernel, expose that data to the user, and
unintentionally leak the remaining part of the page as well.

> > There's also the inefficiency. The unpreserved parts of that page are
> > unusable by the new kernel until the preserved object is freed.
>
> Thats not how I see slab preservation working. When the slab page
> is unpreserved all the free space in that page should be immediately
> available to the sucessor kernel.

This ties into the same problem. The scenario I'm worried about is:
1. A caller preserves one small slab object.
2. In the new kernel, the caller retrieves the entire page that
contains this object.
3. The caller uses the data from that slab object without freeing it.

In this case, the rest of the page, all the other slab slots, is
effectively wasted. The page can't be fully returned to the system or
used by the slab allocator until that one preserved object is freed,
which might be never. The free space isn't "immediately available"
because the page is being held by the caller, even though the caller
is using only a slab in that page.

> > As I see it, the only robust solution is to use a special GFP flag.
> > This would force these allocations to come from a dedicated pool of
> > pages that are fully preserved, with no partial/mixed-use pages and
> > also retrieved as slabs.
>
> It is certainly more efficient to preserve fewer slab pages in total
> and pooling would help get there.
>
> > That said, I'm not sure preserving individual slab objects is a high
> > priority right now. It might be simpler to avoid it altogether.
>
> I think we will need something, a lot of the structs I'm seeing in
> other patches are small and allocating a whole page is pretty wasteful
> too.

If we're going to support this, it would have to be specifically
engineered as full slab support for KHO preservation, where the
interface retrieves slab objects directly, not the pages they're on,
and I think would require using a special GFP_PRESERVED flag.

> Jason

