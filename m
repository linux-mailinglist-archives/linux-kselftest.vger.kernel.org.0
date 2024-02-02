Return-Path: <linux-kselftest+bounces-4027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B684760A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 18:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D8F1C24FD2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F4314AD2A;
	Fri,  2 Feb 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="INDx6Ldv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6E14AD35
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894673; cv=none; b=O2hFNJc7Zzv5o2aWNtgkxb3NDJSlj6nUhXCWf0WyjsZj9IEn63oupJiyNMNk6o4kZ9UZbzNgh1eOeb4jR4MeAS161FIf4ReWZcPWaQboMDxYOKfS+bNkisL2///fvCUJKqCvG3M0Y2VobTXNXEnPcR+9S5aM9ACuJgIxwhKQP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894673; c=relaxed/simple;
	bh=nAy2e/D2iJVgHXwJF6yNdb54Y1630LnSzKiRJLCWPWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NM85QudwZgupJB2jSm6ZuJCVTXCLOoSatRDPuGRNRw9PLLOcZt6HzUfMMOjUpQEEaMBayPdei6WWxemwCFymiayrj8KRNd0hwE9I5EQ7oyCuGSI0l7C6tHlWaaF9hrvvqmWhWsj46RpNSPktLs/o1cV4kx6h53qjE/r1woQG5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=INDx6Ldv; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21920f89441so463129fac.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 09:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706894666; x=1707499466; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6UPWR6ndOUYDUMRqQVrkQUUePvtAQ0pg58MMEcJMl8=;
        b=INDx6LdvntKdUHzRcErb3HcFuugGJGUt4xFBSv2A4JXsvyETCmibL3MyHRrLlHXcqA
         +tr39CljSBrhdGosLlq9BmaAZufIouoT2LmQGIBNQEtjQAYAxMnYTWkM89reRjRiTap2
         qT6LCoZRBZW/n8P0bNd9KvA1fveQxW63XEOPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706894666; x=1707499466;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6UPWR6ndOUYDUMRqQVrkQUUePvtAQ0pg58MMEcJMl8=;
        b=rcDOtl1rq4uM73Gpf+tX6Psp/28QI9he+iDfeEB9+N5bULxX7eM7AlLdQluVzclqdB
         QPLbMmvnNzD+3wlQk6a/8AzsG8lfh1rjHXcLWd7ZaD04ySjafdIsSxft6xgbfMtxwfB3
         dGN6R5VA07RWicxUIUSRNHDnbHtuUnwD4Pr/T1iNDWWyW3GCzMVevcEXpOxwgL1vvY9v
         7T2gKZRBWnsfV4NBJDnl2NIeCfFZl8u+5eH6Xb/eZoOnGgeuDCr3TUT4ZW96ZEGVcaww
         07jONT14S3bLwzY+qcgvFxGYiAT8m1Gt1VbMnDFs72TWtPt449R1XQMs2mD7MKDpZeQW
         ILrQ==
X-Gm-Message-State: AOJu0YzSdU89uJDJAL6ArldzowxoE3clsYFjZxv1X2XRFpU29B7OVRhj
	Ll5L8VQbZzDVPGpvTZ/OIKYgJW6sJ+ykmo2Hlb5z3IC8DGvAOxZTlwqrOt3No9H6Z5dCkU6wMLQ
	W5GLn86/fM/y1Q8I2o2iLv7nXcv5SwZtYTDA7
X-Google-Smtp-Source: AGHT+IFcpltYRj5g1jySgZ/6GoPjgsQ0yDI/CttpZ6v/mpIaX0DPVPHCVu9NXF6WDXyu3zKUp5cLGz4fA9D1UNwgF/M=
X-Received: by 2002:a05:6871:68b:b0:210:a495:ba1f with SMTP id
 l11-20020a056871068b00b00210a495ba1fmr395060oao.15.1706894665224; Fri, 02 Feb
 2024 09:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver>
In-Reply-To: <20240202151345.kj4nhb5uog4aknsp@revolver>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 2 Feb 2024 09:24:13 -0800
Message-ID: <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@google.com>, 
	Jeff Xu <jeffxu@chromium.org>, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 7:13=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Jeff Xu <jeffxu@google.com> [240201 22:15]:
> > On Thu, Feb 1, 2024 at 12:45=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Jeff Xu <jeffxu@chromium.org> [240131 20:27]:
> > > > On Wed, Jan 31, 2024 at 11:34=E2=80=AFAM Liam R. Howlett
> > > > <Liam.Howlett@oracle.com> wrote:
> > > > >
> > >
> > > Having to opt-in to allowing mseal will probably not work well.
> > I'm leaving the opt-in discussion in Linus's thread.
> >
> > > Initial library mappings happen in one huge chunk then it's cut up in=
to
> > > smaller VMAs, at least that's what I see with my maple tree tracing. =
 If
> > > you opt-in, then the entire library will have to opt-in and so the
> > > 'discourage inadvertent sealing' argument is not very strong.
> > >
> > Regarding "The initial library mappings happen in one huge chunk then
> > it is cut up into smaller VMAS", this is not a problem.
> >
> > As example of elf loading (fs/binfmt_elf.c), there is just a few
> > places to pass in what type of memory to be allocated, e.g.
> > MAP_PRIVATE, MAP_FIXED_NOREPLACE, we can  add MAP_SEALABLE at those
> > places.
> > If glic does additional splitting on the memory range, by using
> > mprotect(), then the MAP_SEALABLE is automatically applied after
> > splitting.
> > If glic uses mmap(MAP_FIXED), then it should use mmap(MAP_FIXED|MAP_SEA=
LABLE).
>
> You are adding a flag that requires a new glibc.  When I try to point
> out how this is unnecessary and excessive, you tell me it's fine and
> probably not a whole lot of work.
>
> This isn't working with developers, you are dismissing the developers
> who are trying to help you.
>
> Can you please:
>
> Provide code that uses this feature.
>
> Provide benchmark results where you apply mseal to 1, 2, 4, 8, 16, and
> 32 VMAs.
>
I will prepare for the benchmark tests.

> Provide code that tests and checks the failure paths.  Failures at the
> start, middle, and end of the modifications.
>
Regarding, "Failures at the start, middle, and end of the modifications."

With the current implementation, e.g. it checks if the sealing is
applied before actual modification of VMAs, so partial modifications
are avoided in mprotect, mremap, munmap.

There are test cases in the selftests to cover the failure path,
including the beginning, middle and end of VMAs.
test_seal_unmapped_start
test_seal_unmapped_middle
test_seal_unmapped_end
test_seal_invalid_input
test_seal_start_mprotect
test_seal_end_mprotect
etc.

Are those what you are looking for ?

> Document what happens in those failure paths.
>
> And, most importantly: keep an open mind and allow your opinion to
> change when presented with new information.
>
> All of these things are to help you.  We need to know what needs fixing
> so you can be successful.
>
Thanks for those feedbacks.

I sincerely wish for more of those help so this syscall can be useful.

Thanks.
Best Regards,
-Jeff

>
> Thanks,
> Liam

