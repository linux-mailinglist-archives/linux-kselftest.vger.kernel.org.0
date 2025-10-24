Return-Path: <linux-kselftest+bounces-43986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA3C06DE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 17:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEA194E649C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6D31D740;
	Fri, 24 Oct 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JyKei+8U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556C2D29C7
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318410; cv=none; b=mdg2sEQ+J4xQ613zlGM8bz/ysqOoLv9lAXhqdf6gCj0Q7Voa9ck77GFQajtd4EgjDFjvl5454plsVdbfmOguGIPJopo5mLpc8SDq57YaFRntml7VC2Nz1/AFE6y0pFRXVeqrrjnYQECWQBjya3qL4gUfxjpD1RTBRQkRPRRpTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318410; c=relaxed/simple;
	bh=vjCUowAAckOMTIv3A075oLnvlkvKQazUfP1rThqFm0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZBnxJwMbBVdsGpU2LTPwt3zf8l09essbIQy8JjYU+YY5w4EbpwD232PnGiaQOQ1V9d3v5a4NsrKk7M5+k0bDAQ7U5LI7isXiGB3vU4CUHnfKNmjk1hzp3PCBxLjr5p3WlBpqtU6XM0PPij5AgWsanE6f+kdqcxj2V++UTvVNY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=JyKei+8U; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso4062585a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761318406; x=1761923206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAggPenHEekpw1xsWjUuRRKCQ64Rzgw+ORJ7ssWDMm4=;
        b=JyKei+8U7052ZEy7vU91P2dSPphhBbTZIqEqiYBejaYMW8LmTrURHmBXUnU43LI3Ht
         6Ky230ph44A8orMhYV4ikaPqijn1sK/bx3qwbvV3iK7ucckZlNkGUC24JDzrzvwZvGg5
         kAVvd9nhTuBda87ENakxAW3E/B5vaI5C/edfePx7csqswf8usUc66KhY2JVpI++9SywZ
         skxWaaJvHcnpWEw2kL4Cet/+X5aowoMBf+G+5RbOiiN7fdzsjh2zusJ5RmkHq0f9i7wl
         H3yguuOWtiKJ1dB/8/VUX6WZYgcrUgbkvxP1/wfgfIMxovAgq1xECY3/vkPm5LS6oXXK
         jqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318406; x=1761923206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAggPenHEekpw1xsWjUuRRKCQ64Rzgw+ORJ7ssWDMm4=;
        b=NSuc6QXnpJl6OSKwHMBtj1ezXIBvvY3ptPZelX1lC384IhhZxIE5eb8ODWDDK1MCme
         OLNqRB9eCKLj8+00bn7PZh8UaXucuGFgrNfZC4QHen5CzeA2pK6EUzR0XOTXeYfxXu8b
         kZw3dHuaPiJUQuovot00SbyP+g6H45lx5GjfRDOqxZbbmC3ztUjrMVuNOg6yN+DNHiga
         Mqq3a6z8SyeUYRXp7PAnsf9qsa7ZlfDTiRtnbraU2clqD/Lz9MMRXqbu1OG8d9xatIzJ
         3X1CtPxMN2XO9WeAqGspfgg6if2Knwhlrx4WTQmWduYtmZaVuqpQNEUEXh9RuxChG1+I
         ymBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAFLpNYEZxaXKhnbdnPX0lhBv7EwvTx9matr/knZUJrncLur1XJXWoDzqqnKP/RRlRpXcYglAuS5tgcyBbgys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWbGL3TL+frq0briOs44bMk/6AFoXVDZd6sajuB7JyKXd0sWGk
	hzBVfF7oL+i6PtQAjdGK7HgadoBy5Nky8y+tlwzDAXHNWby7WqUR0Ya+6jTKbtXQ4L5xSpiszZp
	1FNgtEsn5FMIK7aqtF7CVCpMlooLXx9BaN35YPGvw/Q==
X-Gm-Gg: ASbGncsjCJXnM04cKDgeu3ld5cjRPW4jf+Nq5xj8qwmRl9xNn5FUGjkQZKMSsYuUTNe
	ZqIpF3ctCcvxALmZ7FvPKHU0OoK9x8A/r6CVa4VCDjBi52xoJz4Q2WZjDECx2YpppBfOKiZy9fM
	FgagOfe9A1nXPOeMT4hos2M4kjOCz0RREoVUaDxJ1KgsD6/m8PWJ2qdzJyXr8IQioybsb0PhHm2
	CgJ8ant03iiOJALChO76ATPFX91Vtyuofn7BelmcgF2IeU3fu5mh+Xeow7H7WUfm2fORNQdD8T+
	Wg0=
X-Google-Smtp-Source: AGHT+IGJ6GxYCa8q7rSrU/U7gWUFVxG4yyZcVGPe6x/UkHon/1sZO0bVqDFGJeZ2B7N9o//bnwlEJ/gsM5ocEkK4Mlk=
X-Received: by 2002:a05:6402:13cc:b0:63b:f67b:3781 with SMTP id
 4fb4d7f45d1cf-63e6007d032mr2315279a12.18.1761318406399; Fri, 24 Oct 2025
 08:06:46 -0700 (PDT)
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
 <20251024142014.GC760669@ziepe.ca> <CA+CK2bAmPN+v7SYsdHA+RL4kFfnoQvKqTqZ2YQ4wdq6dnFkotg@mail.gmail.com>
 <20251024145508.GD760669@ziepe.ca>
In-Reply-To: <20251024145508.GD760669@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 11:06:08 -0400
X-Gm-Features: AWmQ_blMLbNOm0uoJKs5bR4RSgG2ejq2gkg9FwwwkGNR7IXB5OE5p-7PHsMu37Q
Message-ID: <CA+CK2bC2XNKDd497_+mXxQ=3YaA0QwjxjPzQ95WG6O4nhjeoLA@mail.gmail.com>
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

On Fri, Oct 24, 2025 at 10:55=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, Oct 24, 2025 at 10:36:45AM -0400, Pasha Tatashin wrote:
>
> > We do not zero memory on kexec/KHO/LU; instead, the next kernel zeroes
> > memory on demand during allocation. My point is that the KHO interface
> > retrieves a full page in the next kernel, not an individual slab.
> > Consequently, a caller might retrieve data that was preserved as a
> > slab in the previous kernel, expose that data to the user, and
> > unintentionally leak the remaining part of the page as well.
>
> I don't think preventing that is part of the kho threat model..
>
> >
> > > > There's also the inefficiency. The unpreserved parts of that page a=
re
> > > > unusable by the new kernel until the preserved object is freed.
> > >
> > > Thats not how I see slab preservation working. When the slab page
> > > is unpreserved all the free space in that page should be immediately
> > > available to the sucessor kernel.
> >
> > This ties into the same problem. The scenario I'm worried about is:
> > 1. A caller preserves one small slab object.
> > 2. In the new kernel, the caller retrieves the entire page that
> > contains this object.
> > 3. The caller uses the data from that slab object without freeing it.
>
> 4. When slab restores the page it immediately makes all the free slots
>   available on its free list.

Right, we do not have this functionality.

>
> > > other patches are small and allocating a whole page is pretty wastefu=
l
> > > too.
> >
> > If we're going to support this, it would have to be specifically
> > engineered as full slab support for KHO preservation, where the
> > interface retrieves slab objects directly, not the pages they're on,
>
> Yes
>
> > and I think would require using a special GFP_PRESERVED flag.
>
> Maybe so, I was hoping not..
>
> Jason

