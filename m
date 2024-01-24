Return-Path: <linux-kselftest+bounces-3477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F17483B194
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B631F22EDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20536131751;
	Wed, 24 Jan 2024 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C2aMWTug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D7101D0
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122554; cv=none; b=jxSODqQdC9KcID+ND4L29TswEG8iAMYpB5hJdJMgflda8k0nXUOJWI0Q5xEodwWKhPkdc8B5k8g4beGRWS6W5ZFwErFp8VfUF3h4u/x+PEX5XAGsDnMDGtdOfa0jmAjgzH5c0wSIY/naLsORfg+Y+W5IEI9q9gkvwH9xXqFCGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122554; c=relaxed/simple;
	bh=KLsAeDdaQS/kCf5bcjQjqAY1y7ykrEIrJ+OlMCGRNF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPGgl3hETUSh2EgREi4kzXixfW6zhPKwdV3jm6FRfpnRbmIk1JgR6Y5LcRV1ZPmJd4hIsh86UM1o6KbEzYPD9rP6RDJHayd+EnqzBcKb6qsjwwcEsAfV7pWBL0P269L/ANr/veSt7BW+u3eZG2algwNYKLV8S6UczezxAnoD40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C2aMWTug; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-206689895bfso3046981fac.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 10:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706122551; x=1706727351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzxBYWU0XLGvtFhW2j53HrOFywmcvwVn8sjJljXglm0=;
        b=C2aMWTugdu1sxHRF/ulhXhi50AoXFz1/Sk0JpaUSSnARspN4VSnHSZ4tEkl1k8C59J
         25I8EuHBtDVyiu9/iLwvSPpCMPIGk0OtBebXx3YyVP8Bku5LXvW0QEm14WXdhX7ghhhm
         B2qQmouQgprN9RG5OW1xmgJWKJ+qUawGaejCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122551; x=1706727351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzxBYWU0XLGvtFhW2j53HrOFywmcvwVn8sjJljXglm0=;
        b=KEZdg0jWVAtkTXfGk2D+tFUTE1Qj8qpxkMYp8mDj6RYtO73sBQhT6j8/uKk6olqPBX
         Mgv0Igp3PlRgmPmgSUFVN6fh+ai1gdzYbE63cUAIVGA2MzTMYD+U7EdCI51frUMpFhC+
         iqDtbweJDMbPigQZsfvG6lbosqnCqre0eAKwIyK5oBidlviy5pMv7SWfnJLwfHgD3soO
         AGSSdUZbnfs+GCeJb0RDvDyFG1sOjzN5SOKXnDQ0b2BAJHjKqnq4YI5BO81waOXqu7vP
         6zxGhJw0GFT6iyphvHtWXcqPotvpUWivWvc+S8naG90YNc0n/bOjWo7qTmmCG7F6V6Uu
         XGSA==
X-Gm-Message-State: AOJu0YxRZLEc70uvUrCDLjixnSDul1AOk3tHFJNC9zGhb0zbG2cB4KSe
	57C1h5RHKlzq5GLFb8FoyAmVIIYw/8I2Gjx8p0WGOL+Z9qiUeV2U/YTr0713B3MU0cK0XSNNaLx
	+MRaGLHSX4eHCEEzLku78QyIDso/7BztawAUl
X-Google-Smtp-Source: AGHT+IHWbZarCrd4sIhzNv9IZJE3B+OX3xjBmL88b3OOmmDhwGA+wxixbMYXHijO0HSTHdoNR/Ds7SybUvl+5K4zcno=
X-Received: by 2002:a05:6870:5490:b0:214:448f:e3e with SMTP id
 f16-20020a056870549000b00214448f0e3emr3479864oan.66.1706122551393; Wed, 24
 Jan 2024 10:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122152905.2220849-1-jeffxu@chromium.org> <726.1705938579@cvs.openbsd.org>
 <CABi2SkXrnUZsWvpqS61mHw-SqDBOodqpcfjdoTTyeeYG9tRJGA@mail.gmail.com> <86181.1705962897@cvs.openbsd.org>
In-Reply-To: <86181.1705962897@cvs.openbsd.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 24 Jan 2024 10:55:39 -0800
Message-ID: <CABi2SkXrMC_8Ew7uA=Tufyy1YJObkrFJWbJtZuONCw5XHv2LYQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Introduce mseal()
To: Theo de Raadt <deraadt@openbsd.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 2:34=E2=80=AFPM Theo de Raadt <deraadt@openbsd.org>=
 wrote:
>
> Jeff Xu <jeffxu@chromium.org> wrote:
>
> > On Mon, Jan 22, 2024 at 7:49=E2=80=AFAM Theo de Raadt <deraadt@openbsd.=
org> wrote:
> > >
> > > Regarding these pieces
> > >
> > > > The PROT_SEAL bit in prot field of mmap(). When present, it marks
> > > > the map sealed since creation.
> > >
> > > OpenBSD won't be doing this.  I had PROT_IMMUTABLE as a draft.  In my
> > > research I found basically zero circumstances when you userland does
> > > that.  The most common circumstance is you create a RW mapping, fill =
it,
> > > and then change to a more restrictve mapping, and lock it.
> > >
> > > There are a few regions in the addressspace that can be locked while =
RW.
> > > For instance, the stack.  But the kernel does that, not userland.  I
> > > found regions where the kernel wants to do this to the address space,
> > > but there is no need to export useless functionality to userland.
> > >
> > I have a feeling that most apps that need to use mmap() in their code
> > are likely using RW mappings. Adding sealing to mmap() could stop
> > those mappings from being executable. Of course, those apps would
> > need to change their code. We can't do it for them.
>
> I don't have a feeling about it.
>
> I spent a year engineering a complete system which exercises the maximum
> amount of memory you can lock.
>
> I saw nothing like what you are describing.  I had PROT_IMMUTABLE in my
> drafts, and saw it turning into a dangerous anti-pattern.
>
I'm sorry, I have never looked at one line of openBSD code, prototype
or not, nor did I install openBSD before.

Because of this situation on my side, I failed to understand why you
have such a strong opinion on PROC_SEAL in mmap() in linux kernel,
based on your own OpenBSD's experience ?

For PROT_SEAL in mmap(), I see it as a good and reasonable suggestion
raised during the RFC process, and incorporate it into the patch set,
there is nothing more and nothing less.

If openBSD doesn't want it, that is fine to me, it is not that I'm
trying to force this into openBSD's kernel, I understand it is a
different code base.

> > Also, I believe adding this to mmap() has no downsides, only
> > performance gain, as Pedro Falcato pointed out in [1].
> >
> > [1] https://lore.kernel.org/lkml/CAKbZUD2A+=3Dbp_sd+Q0Yif7NJqMu8p__eb4y=
guq0agEcmLH8SDQ@mail.gmail.com/
>
> Are you joking?  You don't have any code doing that today.  More feelings=
?
>
> OpenBSD userland has zero places it can use mmap() MAP_IMMUTABLE.
>
> It has two places where it has mprotect() + mimmutable() adjacent to each
> other, two codepaths for late mprotect() of RELRO, and then make the RELR=
O
> immutable.
>
> I think this idea is a premature optimization, and intentionally incompat=
ible.
>
> Like I say, I had a similar MAP_ flag for mprotect() and mmap() in my
> development trees, and I recognized it was pointless, distracting develop=
ers
> into the wrong patterns, and I threw it out.
>
> > > OpenBSD now uses this for a high percent of the address space.  It mi=
ght
> > > be worth re-reading a description of the split of responsibility rega=
rding
> > > who locks different types of memory in a process;
> > > - kernel (the majority, based upon what ELF layout tell us),
> > > - shared library linker (the next majority, dealing with shared
> > >   library mappings and left-overs not determinable at kernel time),
> > > - libc (a small minority, mostly regarding forced mutable objects)
> > > - and the applications themselves (only 1 application today)
> > >
> > >     https://lwn.net/Articles/915662/
> > >
> > > > The MAP_SEALABLE bit in the flags field of mmap(). When present, it=
 marks
> > > > the map as sealable. A map created without MAP_SEALABLE will not su=
pport
> > > > sealing, i.e. mseal() will fail.
> > >
> > > We definately won't be doing this.  We allow a process to lock any an=
d all
> > > it's memory that isn't locked already, even if it means it is shootin=
g
> > > itself in the foot.
> > >
> > > I think you are going to severely hurt the power of this mechanism,
> > > because you won't be able to lock memory that has been allocated by a
> > > different callsite not under your source-code control which lacks the
> > > MAP_SEALABLE flag.  (Which is extremely common with the system-parts =
of
> > > a process, meaning not just libc but kernel allocated objects).
> > >
> > MAP_SEALABLE was an open discussion item called out on V3 [2] and V4 [3=
].
> >
> > I acknowledge that additional coordination would be required if
> > mapping were to be allocated by one software component and sealed in
> > another. However, this is feasible.
> >
> > Considering the side effect of not having this flag (as discussed in
> > V3/V4) and the significant implications of altering the lifetime of
> > the mapping (since unmapping would not be possible), I believe it is
> > reasonable to expect developers to exercise additional care and
> > caution when utilizing memory sealing.
> >
> > [2] https://lore.kernel.org/linux-mm/20231212231706.2680890-2-jeffxu@ch=
romium.org/
> > [3] https://lore.kernel.org/all/20240104185138.169307-1-jeffxu@chromium=
.org/
>
> I disagree *strongly*.  Developers need to exercise additional care on
> memory, period.  Memory sealing issues is the least of their worries.
>
> (Except for handling RELRO, but only the ld.so developers will lose
> their hair).
>
>
> OK, so mseal and mimmutable are very different.
>
> mimmutable can be used by any developer on the address space easily.
>
> mseal requires control of the whole stack between allocation and consumpt=
ion.
>
> I'm sorry, but I don't think you understand how dangerous this MAP_SEALAB=
LE
> proposal is because of the difficulties it will create for use.
>
> The immutable memory management we have today in OpenBSD would completely
> impossible with such a flag.  Seperation between allocator (that doesn't =
know
> what is going to happen), and consumer (that does know), is completely co=
mmon
> in the systems environment (meaning the interaction between DSO, libc, ot=
her
> libraries, and the underside of applications).
>
> This is not not like an application where you can simply sprinkle the fla=
g
> into the mmap() calls that cause you problems.  That mmap() call is now i=
n
> someone else's code, and you CANNOT gain security advantage unless you
> convince them to gain an understanding of what that flag means -- and it =
is
> a flag that other Linux variants don't have, not even in their #include
> files.
>
I respect your reasoning with OpenBSD, but do you have a real example
that this will be problematic for linux ?

In my opinion, the extra communication part with mmap()'s owner has
its pros and cons.

The cons is what you mentioned: extra time for convincing and approval.

The pro is that there won't be unexpected behavior from the code owner
point of view, once this communication process is completed. It can
reduce the possibility of introducing bugs.

So far, I do not have enough information to say this is a bad idea.
if you can provide a real example in the context of linux, e.g. DSO
and libc you mentioned with details, that will be helpful.

