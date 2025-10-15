Return-Path: <linux-kselftest+bounces-43204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096ACBDEFDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D871485E83
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41B921885A;
	Wed, 15 Oct 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="j7zNdEsk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B002264B9
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537988; cv=none; b=hShT9tsDTfyeEd9ilEx2addT7KdhAE4EanXVURZpYqTylQ6OEVYJKSJZ7GqxZdDoy5HuWtib6oV3neBuIl/HB1MMsKOhiMpnSf6zYKhvMtBU5U60uCmjR07irNikicUcSCE1tzGLWrCHSMwlyWFUwmkFCigZ/ClUXSTlMEGdUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537988; c=relaxed/simple;
	bh=hUApJ/d2jv5ytp4hpBk/UGF4vKaPuPbb12BM57vyuxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnBpLOyc0MjiZ8QMPcwblSl/3RYDEfaqNGXODUnJ7mKHz7pRAZMRFPvOVZVZFCGIgDzDpGY9pVgjxrZriVaMg8XzjV2SNuIUYnqQufyL150sbKzGg54pnfQCzX0kjk3t7cZfgGD0bY06z3cI8vClNgbOvTYdQcye+DmuHegZ484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=j7zNdEsk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so4624210a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760537985; x=1761142785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUApJ/d2jv5ytp4hpBk/UGF4vKaPuPbb12BM57vyuxY=;
        b=j7zNdEskECDJJH5K3ciuC1zujG7UXNwEsOLmYaie8Kc/8EWsniGZhtIYREoC3ZNxeF
         m/Kmuk+dbR2Ddq1OcDoywHeo09iwS7s5UD4/IiNwC7X7miTxiQylt0mi+hJVTcFt13DH
         rtmhugiBwSpgSszmr8PHZCd770njjL08Ajl7lk4iA2j1IPX8MRlSDhN1RVkimSm7ml0h
         ycC16MyhWEIxSDiMFozFU3gZnpUILtUSwR5sOaEDw8gkS8ssmilcx57AkdwIW+bISsoR
         B/aoBZ0YjLLgZU27FPTxzf5BeSt1ZEDAw1YQMKnEeSHWctnRE7Aqtunj2wOrnfwDyJTo
         ukgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537985; x=1761142785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUApJ/d2jv5ytp4hpBk/UGF4vKaPuPbb12BM57vyuxY=;
        b=BkD0/O/Cnv3Ai23+EwjU8cUWFowStSVPJ6uC9GAPcR176g+BPKD635OcWRSwDplbxU
         LfKzKzESLXLW6Y6KnyUmG/NWneoOJaESrgfX/rRGJIKYc8IQxQXdwpnvxaeeNqEh2CZS
         u+39XvGi4PcXm0I2ygbudAxPiWHRnHUZTTRSXOs0Dfc9XVWmH4aC4E6Eps937Wpnhp7n
         vlt2jcWlXKWCKGijhJzw60iiPWari4XWS5hKobkuEK1/8woSP/LhxmFiGSSzi+EGL4vU
         TeyWdhPRbKDskdjvtOCYSqj0yREwn+jTjy+12PQC5ELg/r7FdJLYrP1n8zSaUevSBvxW
         Fq4w==
X-Forwarded-Encrypted: i=1; AJvYcCUqAQqYwBrVTC/+OTbMYPCXpquLLC44R85FujNtk7pB2DO5jGB0wvFiWsN0qkvbWUWIhSc6ckBkgjryRCaYOt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhY6urfY9k9e1Vctp4CepOcYTrZyt/b7XAeHEkwcqxAywe6WP
	K/QVblqcCfQBU8gGa5wo9lt8Q2iiL+CKWhnUy3+W+LBWwv+AQHhBYCHcWIV6UHl6QpLy436v7bT
	nENwrTBV10mXZUo70tnH5qsvJfUb0MXXwM3OA4ipZFw==
X-Gm-Gg: ASbGnctX2yq4/poS4bnbQdoa8Ze8V+Zi5JaH8mdw7dnGTWVZOGw0cMrVmXxoZl4buoU
	tu3Tv3Uek46LcNN/63qJbW8HA+QKU5NtoBjkOrUXF6xC+WHSHN64qJlSY5JC45s4dGpsMHywqZy
	B+CrOAq1nA+oRImEP4yXgFgl8lti8quUA4v1NY5FGZ4wnQUVauF+HWfVBnHhTPt0y1w8+0YH31o
	+J7AbPiLQg2yioUntN98acQloDU3YA+QA==
X-Google-Smtp-Source: AGHT+IFgvnWABvFp2YO4aybRqOy0KXXsuvYtzVtzjFu719w6HusoLk54zzREdfAYZlsXpNluTDl3s5anm94ec20FQEM=
X-Received: by 2002:a05:6402:5244:b0:634:544b:a755 with SMTP id
 4fb4d7f45d1cf-639d5c3294cmr29350078a12.19.1760537985003; Wed, 15 Oct 2025
 07:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com> <mafs0v7kgjoxq.fsf@kernel.org>
In-Reply-To: <mafs0v7kgjoxq.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 10:19:08 -0400
X-Gm-Features: AS18NWBj8W1b8VguIoFufUrvIsQUXiGHkQ32JE7FqsyGBasY6kmjvm5a_9MOZ2k
Message-ID: <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com, 
	glider@google.com, elver@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> +Cc Marco, Alexander
>
> On Wed, Oct 15 2025, Pasha Tatashin wrote:
>
> > KHO allocates metadata for its preserved memory map using the SLUB
> > allocator via kzalloc(). This metadata is temporary and is used by the
> > next kernel during early boot to find preserved memory.
> >
> > A problem arises when KFENCE is enabled. kzalloc() calls can be
> > randomly intercepted by kfence_alloc(), which services the allocation
> > from a dedicated KFENCE memory pool. This pool is allocated early in
> > boot via memblock.
>
> At some point, we'd probably want to add support for preserving slab
> objects using KHO. That wouldn't work if the objects can land in scratch
> memory. Right now, the kfence pools are allocated right before KHO goes
> out of scratch-only and memblock frees pages to buddy.

If we do that, most likely we will add a GFP flag that goes with it,
so the slab can use a special pool of pages that are preservable.
Otherwise, we are going to be leaking memory from the old kernel in
the unpreserved parts of the pages. If we do that, kfence can ignore
allocations with that new preservable GFP flag.

Pasha

