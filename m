Return-Path: <linux-kselftest+bounces-3992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F839846727
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 05:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29FE1F27A66
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B51F4FD;
	Fri,  2 Feb 2024 04:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O5oZtABQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC2F51E
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 04:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706849683; cv=none; b=GTVxjqXWkDAIPoPNgwPhWMgCwmCkttMR9lmGSDd74/nalmkBSMvs/BLPt+gmG7q/V8o/359cSz4C+fUHJQS5ff3ctbtsRTOfz9MuiEBPBWYRPJqd/4PoyuqQ3BXC+viY5HMiKPsY8Ek+JiVz3UxubOxPHRO2IUOoZcwvhq8Or3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706849683; c=relaxed/simple;
	bh=x8IkhLJ044kI8YEAW8C7T9nLAz6NPq0zHq4wb5YSigc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doC2hgIQMY9zOi4URSqJAukq5wM4jPJGpQb7H2Nl5Wsb0PsDdaVbdb7ejMGlDiKxeS+q+2o+JvDaWl+RF8PgNafvTRM1Oohvxgc+Ff3uYLyVZSMu4PZQsnf6/14M1UA7QG51/lPexECgRApZQSn7PSV/gH5CE+tHH3HfMUJAV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O5oZtABQ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-218eea4f1a7so674890fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 20:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706849681; x=1707454481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jPypSiuNIqXZVdy7vjTfUkB5jafh5E5WelADJcP20Y=;
        b=O5oZtABQLzKq+IzQGIlzxeW+avLxaCK1hcDQO8g/uPKeX5LvYqh7WGZPBMYwB+PEXY
         QFRIvqIfLrjnrYksvWaJE4eb8N1wcymvOrZGqB789atRPi9H53o7LP2DSuHCMLOy3f4q
         1iH2z6ctqfCwdLTwvNGZEUm93sxDnQz93cq/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706849681; x=1707454481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jPypSiuNIqXZVdy7vjTfUkB5jafh5E5WelADJcP20Y=;
        b=VIxtnlnqTnx7CFKO+HXVZvOzQ1nB+Ervt4vMLmnRal6KET8OdBKbPHs5extFzSvtDk
         MzImAU+dLFJbKS2HRPVQgYAHMN83dzbG0YycG6gZr43Cf4Os8TsvTMlwL1JVgi6HR+2k
         ac4rnhOrVzKalG0b0QtWpwDnaE6JtDaej2yUASJf8HccqfYnG8XO7iT+ub1mH5AkE/21
         hKdt+wLUHnV+2q8+0ZyI0n5OQ6T6NEE4lII3PG9EY7OGU2AZ6QOzq/6PPkEvWX7jc3ee
         EbogCa5XsxzCtNtjdqKBzWlywkcM3xQitD1fBeO4vEVkSodhyjDwwQB7dVRGCwaGjFXw
         vChg==
X-Gm-Message-State: AOJu0YxFasJMOeP3UQpeHWlRbB7CXXsQ6TlvevCB1RE1Ajugpmdb9y3X
	rfhRY0IszjJdWXmFGXJi/AIQCpiTbIQ2FPODkrA6OwWExLfjvJkXBKsLtK5cr42lKd9BL7iSTHa
	+8fx2Cgtvd7LMNPeBo1GoEIXfTsyem35Q1PG/
X-Google-Smtp-Source: AGHT+IETMLjCNrTRYoa0VeDG6wd6AFck2DJoBNuvFjOIwCUuNl9PVphg7/W5mrUeXG09syiT5/uFJ0c6tpug37IVmNo=
X-Received: by 2002:a05:6870:82a9:b0:219:1a50:2973 with SMTP id
 q41-20020a05687082a900b002191a502973mr663108oae.27.1706849681226; Thu, 01 Feb
 2024 20:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com>
 <58408.1706828083@cvs.openbsd.org> <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
 <CALmYWFtqcixi3p3Ab44wENJr+n2k2SNaCJEofNm_awnNdJZnDQ@mail.gmail.com> <8744.1706846710@cvs.openbsd.org>
In-Reply-To: <8744.1706846710@cvs.openbsd.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 1 Feb 2024 20:54:28 -0800
Message-ID: <CABi2SkWSt=UMFWe9n916ZH16wCzaipKXmEJ5VasQHMr1AxerxQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Jeff Xu <jeffxu@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:05=E2=80=AFPM Theo de Raadt <deraadt@openbsd.org> =
wrote:
>
> Jeff Xu <jeffxu@google.com> wrote:
>
> > To me, the most important thing is to deliver a feature that's easy to
> > use and works well. I don't want users to mess things up, so if I'm
> > the one giving them the tools, I'm going to make sure they have all
> > the information they need and that there are safeguards in place.
> >
> > e.g. considering the following user case:
> > 1> a security sensitive data is allocated from heap, using malloc,
> > from the software component A, and filled with information.
> > 2> software component B then uses mprotect to change it to RO, and
> > seal it using mseal().
>
>   p =3D malloc(80);
>   mprotect(p & ~4095, 4096, PROT_NONE);
>   free(p);
>
> Will you save such a developer also?  No.
>
> Since the same problem you describe already exists with mprotect() what
> does mseal() even have to do with your proposal?
>
> What about this?
>
>   p =3D malloc(80);
>   munmap(p & ~4095, 4096);
>   free(p);
>
> And since it is not sealed, how about madvise operations on a proper
> non-malloc memory allocation?  Well, the process smashes it's own
> memory.  And why is it not sealed?  You make it harder to seal memory!
>
> How about this?
>
>   p =3D malloc(80);
>   bzero(p, 100000;
>
> Yes it is a buffer overflow.  But this is all the same class of software
> problem:
>
> Memory belongs to processes, which belongs to the program, which is coded
> by the programmer, who has to learn to be careful and handle the memory c=
orrectly.
>
> mseal() / mimmutable() add *no new expectation* to a careful programmer,
> because they expected to only use it on memory that they *promise will ne=
ver
> be de-allocated or re-permissioned*.
>
> What you are proposing is not a "mitigation", it entirely cripples the
> proposed subsystem because you are afraid of it; because you have cloned =
a
> memory subsystem primitive you don't fully understand; and this is becaus=
e
> you've not seen a complete operating system using it.
>
> When was the last time you developed outside of Chrome?
>
> This is systems programming.  The kernel supports all the programs, not
> just the one holy program from god.
>
Even without free.
I personally do not like the heap getting sealed like that.

Component A.
p=3Dmalloc(4096);
writing something to p.

Component B:
mprotect(p,4096, RO)
mseal(p,4096)

This will split the heap VMA, and prevent the heap from shrinking, if
this is in a frequent code path, then it might hurt the process's
memory usage.

The existing code is more likely to use malloc than mmap(), so it is
easier for dev to seal a piece of data belonging to another component.
I hope this pattern is not wide-spreading.

The ideal way will be just changing the library A to use mmap.

