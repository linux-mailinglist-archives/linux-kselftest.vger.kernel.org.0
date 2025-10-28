Return-Path: <linux-kselftest+bounces-44161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A5C12232
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 01:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45EE54E78A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BC8B672;
	Tue, 28 Oct 2025 00:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IuG3vbJG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5E11713
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609760; cv=none; b=QZC1uFD4NPUMXzK7zmBQvoXs7znPA02OhYogluP4/wT+T9d8hIeEWg9iglGp1A1UOjQJz7e+XWvLloFmrN6AF02NnceExuEaFoBdYJVoqcfThP30IFiK0+D8jCJftQhq+NWnqEq/9wW8VGT+k1WCTdD6wuA1NBj41NQRTU+1Kmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609760; c=relaxed/simple;
	bh=6RGFmBzAto0gxAgkZvSGB80x3NIpVudmV8yLAQD96ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPnQj/Z8VUAyqXyjlQeh2ELuSdrp91STkC9p4R2MlXxxd7LagSTokFaDSmrs9fw7pLg9cvMTQnuAp3LpGaVLBhzpzSHdK/isAdahmGru6n6qzPVaOcucB6Ai/3Zg47Q6Xl40lIC5iB03ykfC1mUXVD1GtqoFXzazZFbJboU0Ti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=IuG3vbJG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so10302684a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761609757; x=1762214557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRrW1VGqQYsOj9O2IaLW2NSKFc6wcY6W7P8omZBsZSQ=;
        b=IuG3vbJG37WNlP10DvBNHoe3quMFSldH+ZFqUT9VxkN1tI8eYLPp05xlU/YiyZfBAm
         LMJT2DJGs9iwy/RisaRLANl0rQhy7CKQ0x5HHSlzfYS7fTgy7+VnG2d1478lDNZZqivx
         zqN/N5SdBOdCttnrqLjAOxeiDR7Ilb/k1yEG7RSsrrxwdVXju1/R1aSNnEQo7ozXEGUh
         W/Tn85LnK8QToysvyCyX9jT7wbGavPIv7dvPWBAbBxW/B/VrnBUeHDjSjfFwg8Owrgex
         gDAH7Qz/95XtioVzohMkJVnM/SbduplTeOzIj3Ooy7pS0rATALVlml2ZM0Yi8jjG1NlY
         1p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609757; x=1762214557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRrW1VGqQYsOj9O2IaLW2NSKFc6wcY6W7P8omZBsZSQ=;
        b=b2X2E4dAu4QkdVjHX0d88qkAQea95XKmzUCSY/9h9wmRRoLz4opzl4w1srKULP8Mq0
         WgXbCiXrYhceVLoIZjhqH/Bba6w9GMgB78k4OArs/ojcvqwRGJnkS9CQO5pi9g0wsDUE
         VE0sP++Mp47FaIEhabPeuHbKrjueOZxY5IXnt9CbUwFXdDV/d+wci1toi0g/etqUEcCa
         DC7yfMUaw14jUYHR8JFgRGkTgDEQEVisq8cs+wwDy6x77yn3n2y1aQ4B484t+zwD3mFl
         XDkPRfNgLxKf0EdbSqQSjMPhbKnjzYwm3gpA2AQiA3/ClX5S8zDOqv+yvhm0HUV6V+Gm
         Kvqg==
X-Forwarded-Encrypted: i=1; AJvYcCWsfhYj2zkkJnquxR04GV4tLfZJ610ODhcMQ6jc2hZyK8NKcUcHbmTzdgXUmqFUCP8Vc92vucwORXJGTfvLNVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5awIrJjk9sqGHMEHyWOEIOsaDFkCbrQw4O8b/aTHSUyZUMaO
	iiMJr1EziVypBwr4rQU9KJhktuir5fNJbGZ1wOPKXMXuIu8LPZa4QXXJuiM7nY/wemPv4vt/F94
	33aB2K1GpF3zTE/0+gn1aaK0DZSmVeiB5Jykhl8/5dQ==
X-Gm-Gg: ASbGncthylZGA8t8z7tkSTerjEKj9ugmH5UAJ6VXlZrmjQ7AUsDn6DCwZaEJhF/vI5J
	adCg0Qom5qFqAA53kgvvisvfFoR81tX8RmDBwnuWfYzlEy7I//+7sWzHiv5/Ga9R6/cGfDjCt8a
	Z/YzvjMDo3MfYbW69/Gk7dEf7AQMfRGZosqsGNlYN3uPaP1U2TPhF0jSImHetmY3iXHJ/nwzVK1
	73wJsGGyMNb5Tv4RgyyCNzOM08wVncKQvT5vLlPldkaHTZ+Pby+7oXtKw==
X-Google-Smtp-Source: AGHT+IE0d8IR6rsEgJJ5sEY6LIPZwkDDtyCP7uhxPzIsZylx0Ljo5I5H+E2VC1AYiZBzamjHuFflAzaW25Tk+RHARQ0=
X-Received: by 2002:a05:6402:2811:b0:62a:a4f0:7e4f with SMTP id
 4fb4d7f45d1cf-63ed849802fmr1583600a12.29.1761609757208; Mon, 27 Oct 2025
 17:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-2-pasha.tatashin@soleen.com> <CALzav=egQiF6tanYxR9Tow7TnT_UK9bNAR_4DQ2P=2EJ+H4ZJA@mail.gmail.com>
In-Reply-To: <CALzav=egQiF6tanYxR9Tow7TnT_UK9bNAR_4DQ2P=2EJ+H4ZJA@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 27 Oct 2025 20:01:59 -0400
X-Gm-Features: AWmQ_bmk9AWMUDPf-FAMZS-KNcWHzhS4VhXBKhx2xU2ISRIlSsLkq3B9EbQYovg
Message-ID: <CA+CK2bAibAPzTq+edRTXS9g7Cs0w-zCiSSrXUkoFAHe7=3C0QA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: David Matlack <dmatlack@google.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 6:29=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 5:08=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > It is invalid for KHO metadata or preserved memory regions to be locate=
d
> > within the KHO scratch area, as this area is overwritten when the next
> > kernel is loaded, and used early in boot by the next kernel. This can
> > lead to memory corruption.
> >
> > Adds checks to kho_preserve_* and KHO's internal metadata allocators
> > (xa_load_or_alloc, new_chunk) to verify that the physical address of th=
e
> > memory does not overlap with any defined scratch region. If an overlap
> > is detected, the operation will fail and a WARN_ON is triggered. To
> > avoid performance overhead in production kernels, these checks are
> > enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.
>
> How many scratch regions are there in practice? Checking
> unconditionally seems like a small price to pay to avoid possible
> memory corruption. Especially since most KHO preservation should
> happen while the VM is still running (so does not have to by
> hyper-optimized).

The debug option can be enabled on production system as well, we have
some debug options enabled, but I do not see a reason to make this a
fixed cost that can add up; the runtime cost scares me, as we might be
using KHO preserve/unpreserve often once stateless KHO + slab
preservation is implemented during some allocations paths. Let's keep
it optional.

>
> >  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, =
size_t sz)
> >  {
> > -       void *elm, *res;
> > +       void *res =3D xa_load(xa, index);
> >
> > -       elm =3D xa_load(xa, index);
> > -       if (elm)
> > -               return elm;
> > +       if (res)
> > +               return res;
> > +
> > +       void *elm __free(kfree) =3D kzalloc(sz, GFP_KERNEL);
>
> nit: This breaks the local style of always declaring variables at the
> beginning of blocks.

I think this suggestion came from Mike, to me it looks alright, as it
is only part of the clean-up path.

Pasha

