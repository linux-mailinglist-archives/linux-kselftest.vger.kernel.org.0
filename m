Return-Path: <linux-kselftest+bounces-43615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FE2BF3A03
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 23:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B3BC4FE565
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 21:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE59B2E9EAA;
	Mon, 20 Oct 2025 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMuqGiiV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DB2E370C
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994143; cv=none; b=BRoXHt1VAU6ppdmiwJ4u2EnniTFARwTgIlWOlUvylVuuBT02ghijb+0wrs3XiicmtRIK1ICu0X+tIEIN9Lzud/Q2wmlVOlvuUJLsd+sfqqoGC5Q7Q/5+Gd5UtIYTIp0ZBI9BoXbdW6oxAOdo7x0vkbcbqDs7WIEX1xE6SMQjhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994143; c=relaxed/simple;
	bh=IgYE1mZTkxVPjcoFUAJYAa4jA2ZPp6tn7R05SstSckI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxbBKpOoSJWA4SbOhQnVFDUxJQ8Shwo4ncpr0PRrAZ7aNUait/DsGO1sCAQZuC0FD6G8mOxTOSxZYgGY+MUngqIPyrXI26nnmA4c/zNVvwyjxR0mIq1vhgt4oUnmXpmP8ixdiVnJYkbCDcZEGg78alsRMd4fvQaU5xQHI+w0cG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMuqGiiV; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-430e182727dso5072825ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 14:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760994141; x=1761598941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEuxap4uXOw4PVhBkZanJl9OA3DpfYNQ9aSaoCPuf2A=;
        b=UMuqGiiVhhJ27Y3UQ5+FGE6JUilR/j/goVjwHnXsLfldvTBErq7MxbHHm+8Ja+emzj
         qllmESMNlV0eVPJAkwf9hmaMJM5OETGAx0q7EGDX6kd5IuL+pmUkL53XrQ4ZpyimtVRp
         GB+KypAuEO3rbcC2+YzL3hPSUHaP9yjCbpIXMsyq9gGpbA+0+qDWNJCinPZBCnMfRS2f
         nA1mY/G0ZPN6GcV2xEG5b04BPaz0yXqN0zVlV4erE8MqZ7180LNs1t2wCdXaTZw67LBJ
         bbr3rHBz2QCAW2fXNQP9mKSRVQpxESNrQM0br6DUmTvbxBdTpFop+PhrOs+fi4O0reA8
         x1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994141; x=1761598941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEuxap4uXOw4PVhBkZanJl9OA3DpfYNQ9aSaoCPuf2A=;
        b=Sb9MhM7EnOe7MdCcuWMv9JKX1qQx7RfgGrUEDKFL20TkQIR8dQ0jYj10EEMWZzbcXG
         YcVhKO2Bj9qkm63R7KQkWN77ULEHF4bKQHK8TTOM/6c2JeJBkFaQcj6PkFOydejoGES+
         94fgCTaEM4umuUoSyqeWfKFb61NQiqI0GFLJqU5N585fRguaIJwUg8uxMptEUDD1RFuU
         daCz9pzO85j8OUfGnePHRfERbfPuG8FUgiRavAfhKqpjYoUT0VzgFmPLdwP+R+gjGGiF
         G0Sur1zpftsvcGVji4CgtI9323yE430fmnPy1kW1Q80rFh0HFUMbwYo3eRGEadIRV6FN
         NsUA==
X-Forwarded-Encrypted: i=1; AJvYcCWeJsMnyVnM6Jf2RgFM0K2rZyDXIE5PhFV+w3DNiUNZ5GUCD58KD1HJQR4P69k5PuQh95vHTrU1vAqesH5B6cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOnH/NpJ/dhNadIVf8MordxL/CBJWG1qf2IAvixhbbIs8a2PY4
	t+p07sVQ8mLTX1CrCvUNuZ8TtaqXp2xAUReFJ84yr29NVHWb7vAqTvGybPac8a0ybAacdbcnXkS
	v3dpZG5oCRK6P+2bvviPJ/0nRf8U0bR4=
X-Gm-Gg: ASbGncsI+OpC9OPCgRJUbOROsP/7hEVPdVz7ryaDam8H0lybJ86PMzbywI/PrKYDpQE
	CXTspl1cGe3y1v+N+wljEwlAfw0hPS04nmyWn/sEUPb4xT7fI30rzTHjm15Gjo/dINceDtcPS7Q
	iXafl40szyfuiB8zzDLhhkqHMvKVNxBpNrB4KDD4R02z2RQb5xKl/EFkTm5P0mhlKnXjDHl9Dyy
	Q++FLLR4OF0OBOfEOilbcIvj7yPzPkBw+j/b5tO3Op4OLXvBNKH3sG7XiUSNEy2SttuNV3ACW4e
	VqF/yBHKe24crFWvkzMWyVIRqXJdg72uN8e1hvaj7eCiXhZZrOVyv9IrOrbnWXvetF4p1o3g73B
	TlO0WjRObwCfIBZo3HyWVIa85j+xAJ72T3ETvTm1zWeW7yio/OIrqdVTl
X-Google-Smtp-Source: AGHT+IGAeJGAQIBM2nto3h7wo4Ux1j4JQv5kFnMFKMPjSOsA8laTc7KGJRta+EANCOydZnJICpXKfizFw0bVF/vJHG0=
X-Received: by 2002:a05:6e02:1fc5:b0:430:e9d2:8f3b with SMTP id
 e9e14a558f8ab-430e9d28f40mr20917205ab.27.1760994140614; Mon, 20 Oct 2025
 14:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <20250910170000.6475-2-gpaoloni@redhat.com>
 <878qifgxbj.fsf@trenco.lwn.net> <85166a8a-ad54-42d0-a09f-43e0044cf4f4@redhat.com>
In-Reply-To: <85166a8a-ad54-42d0-a09f-43e0044cf4f4@redhat.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Mon, 20 Oct 2025 21:02:02 +0000
X-Gm-Features: AS18NWAdMqoSfNFq5XutKr0MnkgQ82Rnk3fUSUQqpBl0J3sT2E2MC5yWctws4W4
Message-ID: <CAB=6tBQP3aCDWch4ZcEYMqFsJ4OKXSyC_hb9V9hA7ZZty7vFeQ@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 1/3] Documentation: add guidelines for writing
 testable code specifications
To: David Hildenbrand <david@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Gabriele Paoloni <gpaoloni@redhat.com>, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	safety-architecture@lists.elisa.tech, acarmina@redhat.com, 
	kstewart@linuxfoundation.org, chuck@wolber.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Reposting with apologies for the dup and those inflicted by the broken Gma=
il
defaults. I have migrated away from Gmail, but some threads are still stuck
there.]

On Mon, Oct 20, 2025 at 7:35=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> +------------
> >> +The Documentation/doc-guide/kernel-doc.rst chapter describes how to d=
ocument the code using the kernel-doc format, however it does not specify t=
he criteria to be followed for writing testable specifications; i.e. specif=
ications that can be used to for the semantic description of low level requ=
irements.
> >
> > Please, for any future versions, stick to the 80-column limit; this is
> > especially important for text files that you want humans to read.
> >
> > As a nit, you don't need to start by saying what other documents don't
> > do, just describe the purpose of *this* document.
> >
> > More substantially ... I got a way into this document before realizing
> > that you were describing an addition to the format of kerneldoc
> > comments.  That would be good to make clear from the outset.
> >
> > What I still don't really understand is what is the *purpose* of this
> > formalized text?  What will be consuming it?  You're asking for a fair
> > amount of effort to write and maintain these descriptions; what's in it
> > for the people who do that work?
>
> I might be wrong, but sounds to me like someone intends to feed this to
> AI to generate tests or code.

Absolutely not the intent. This is about the lossy process of converting hu=
man
ideas to code. Reliably going from code to test requires an understanding o=
f
what was lost in translation. This project is about filling that gap.


> In that case, no thanks.
>
> I'm pretty sure we don't want this.

Nor I. If you find any references in our work that amount to a validation o=
f
your concerns, please bring them to our attention.


..Ch:W..

