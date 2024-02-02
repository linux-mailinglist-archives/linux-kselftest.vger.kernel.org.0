Return-Path: <linux-kselftest+bounces-4032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBFF847911
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323EF1F25106
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6AD12D746;
	Fri,  2 Feb 2024 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3rm69JN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8D712D744;
	Fri,  2 Feb 2024 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899927; cv=none; b=aRXlnxn+sfnWNqh4vFSPYZsfX8f5VeHuZUl8Z7aeSc7W574pIAaNwO8UJZf7Sh4L40Vfw6SvvYc8Ll3CWLtuZgutgy66JUJ9rKeRGmwXZqIwLcW07oAGmlbtdoXC3gOaS4X4zbVPCqcB2O5hCdFrQjEez3+fBUcXoBSv95mS1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899927; c=relaxed/simple;
	bh=Ok/UFu+vBcGlIKfmY4fxnPlqCPaUfQSbFxyVIYms/hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oL1Fjp450RJ+Klk5A2CMzsbJFfgOhupb6HEyfTESvreRcFez6CnLNST5vpWurpyie5PlkpDT2imRPWgoKaoVocyZdOI0fRkgCWfaR+f5CkCINxW7lobuCpjwC/o2fcEOHeHw4ZLotpmghLB14oVeTE0/dutGNFoB7SVht99yyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3rm69JN; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-467ed334c40so1048137137.0;
        Fri, 02 Feb 2024 10:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706899925; x=1707504725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzAQr1ap8fenb+jIdc4mT63hDIxdhoa2yYpMaLdZczw=;
        b=Z3rm69JNKI/vsFysVXxvaH6YC92YCjN7ssaKocJ/cIRTIvhORQaw5drCCZrGQWyGAF
         n46d2JKonXj3hQod/ZFwnUgS0GJ2Jau5wtzl0M5F5xO99h1hL5UkDwkuWswObyCTMLHE
         r/mkhjUY/FJny8mLweRH5Zi3hkaUqm0ZJfupoSx+7V3wMuzMKT8Beax3Dxycx91w4o1m
         KlGYIc8sClwHGpV7W81OEuYwD3uaXnoOMAGYYw4jP977br8eiV4ggCuIER/yEp0uXDYq
         tFHFg+kANvSf2ZgVh2ah1iJqmE28OZRU4DLoE73Mc6vnvNsbnn2mFoYQQUfKGQLoTsqn
         +NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706899925; x=1707504725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzAQr1ap8fenb+jIdc4mT63hDIxdhoa2yYpMaLdZczw=;
        b=dUnU3gADMyPYjL86KvUO2X2N2/ZvE7MJ7qNUGsY58+npP/J+XsSdfhEBSFYOU3xx0o
         o1vaQ/YiP6ccYqqh58csKTIi1YZxbt5+QB2BhTo32KX7PcwkL+allyLsixZlauNZ09bb
         uEbc4QoFrFIAtMMKP/DEo85QuW6gkzawSdeY0mL/qgTgROE+QbtIuNQQFVhY5rAeNqVv
         4E9H8yQ1qcKM/XcpRjmxrXFEOFi33sxaVsV+joomn2g6dg/HDrPLlLNhw+cLl5Mi0zU/
         Etqw8XQgdRtBxD+0nuj/Ga3/M40yi/bSQaGGEnFZomp59/gVGzhRs/pDxEnIm7s7OeNS
         pV4w==
X-Gm-Message-State: AOJu0Yyf4rncxW0VtjQWQ89/BxAiztTZtEn2P3ovTLydbVCPgdR7B7Yw
	XFTnYWb4rU1Ey4QnRGahnUm1l7vaPL4otunbzX5z9s9DOQJdg/dkzPJalt9q0o3WLHamhnQAprf
	JAixE6zhcpa8eYHh/9LlNYKozCyw=
X-Google-Smtp-Source: AGHT+IHpATLtM6UhFbndhKBf6EqvX2JU7kTp41znPx/PGymZrFwm9VYWH5L8GWXzPE4x5Ra7T6WPp/G2KIs4iBjH3LM=
X-Received: by 2002:a05:6102:3167:b0:46d:647:67da with SMTP id
 l7-20020a056102316700b0046d064767damr2063513vsm.13.1706899924579; Fri, 02 Feb
 2024 10:52:04 -0800 (PST)
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
 <CALmYWFtqcixi3p3Ab44wENJr+n2k2SNaCJEofNm_awnNdJZnDQ@mail.gmail.com>
 <8744.1706846710@cvs.openbsd.org> <CABi2SkWSt=UMFWe9n916ZH16wCzaipKXmEJ5VasQHMr1AxerxQ@mail.gmail.com>
 <29248.1706850035@cvs.openbsd.org> <CABi2SkXPNPKgqheuFuQ9iZApQkJm8o6bypNn0B-QDz_W9b0JBQ@mail.gmail.com>
In-Reply-To: <CABi2SkXPNPKgqheuFuQ9iZApQkJm8o6bypNn0B-QDz_W9b0JBQ@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 2 Feb 2024 18:51:53 +0000
Message-ID: <CAKbZUD1EsAVupRotYV-ed4PQ3sL5wM4M=f4n-6rF+QNp7C1m4g@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Jeff Xu <jeffxu@chromium.org>
Cc: Theo de Raadt <deraadt@openbsd.org>, Jeff Xu <jeffxu@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, rdunlap@infradead.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:59=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote:
>
> On Thu, Feb 1, 2024 at 9:00=E2=80=AFPM Theo de Raadt <deraadt@openbsd.org=
> wrote:
> >
> > Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > > Even without free.
> > > I personally do not like the heap getting sealed like that.
> > >
> > > Component A.
> > > p=3Dmalloc(4096);
> > > writing something to p.
> > >
> > > Compohave nent B:
> > > mprotect(p,4096, RO)
> > > mseal(p,4096)
> > >
> > > This will split the heap VMA, and prevent the heap from shrinking, if
> > > this is in a frequent code path, then it might hurt the process's
> > > memory usage.
> > >
> > > The existing code is more likely to use malloc than mmap(), so it is
> > > easier for dev to seal a piece of data belonging to another component=
.
> > > I hope this pattern is not wide-spreading.
> > >
> > > The ideal way will be just changing the library A to use mmap.
> >
> > I think you are lacking some test programs to see how it actually
> > behaves; the effect is worse than you think, and the impact is immediat=
ely
> > visible to the programmer, and the lesson is clear:
> >
> >         you can only seal objects which you gaurantee never get recycle=
d.
> >
> >         Pushing a sealed object back into reuse is a disasterous bug.
> >
> >         Noone should call this interface, unless they understand that.
> >
> > I'll say again, you don't have a test program for various allocators to
> > understand how it behaves.  The failure modes described in your docuemn=
ts
> > are not correct.
> >
> I understand what you mean: I will add that part to the document:
> Try to recycle a sealed memory is disastrous, e.g.
> p=3Dmalloc(4096);
> mprotect(p,4096,RO)
> mseal(p,4096)
> free(p);
>
> My point is:
> I think sealing an object from the heap is a bad pattern in general,
> even dev doesn't free it. That was one of the reasons for the sealable
> flag, I hope saying this doesn't be perceived as looking for excuses.

The point you're missing is that adding MAP_SEALABLE reduces
composability. With MAP_SEALABLE, everything that mmaps some part of
the address space that may ever be sealed will need to be modified to
know about MAP_SEALABLE.

Say you did the same thing for mprotect. MAP_PROTECT would control the
mprotectability of the map. You'd stop:

p =3D malloc(4096);
mprotect(p, 4096, PROT_READ);
free(p);

! But you'd need to change every spot that mmap()'s something to know
about and use MAP_PROTECT: all "producers" of mmap memory would need
to know about the consumers doing mprotect(). So now either all mmap()
callers mindlessly add MAP_PROTECT out of fear the consumers do
mprotect (and you gain nothing from MAP_PROTECT), or the mmap()
callers need to know the consumers call mprotect(), and thus you
introduce a huge layering violation (and you actually lose from having
MAP_PROTECT).

Hopefully you can map the above to MAP_SEALABLE. Or to any other m*()
operation. For example, if chrome runs on an older glibc that does not
know about MAP_SEALABLE, it will not be able to mseal() its own shared
libraries' .text (even if, yes, that should ideally be left to ld.so).

IMO, UNIX API design has historically mostly been "play stupid games,
win stupid prizes", which is e.g: why things like close(STDOUT_FILENO)
work. If you close stdout (and don't dup/reopen something to stdout)
and printf(), things will break, and you get to keep both pieces.
There's no O_CLOSEABLE, just as there's no O_DUPABLE.

--=20
Pedro

