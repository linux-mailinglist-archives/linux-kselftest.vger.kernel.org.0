Return-Path: <linux-kselftest+bounces-4050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C41847B71
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 22:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB58A1F253CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 21:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E381746;
	Fri,  2 Feb 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gs399+XR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A480639
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706908842; cv=none; b=uicbNg3bhgLb1yL9xNtr4INauulhg3ad9v6q0zHXpNplsJUqG+Mq5KcOvQ9HZ4JPjQvC6K9oSNUMF4HZqaCMpGQnOkTx18mW+dIQ9mgJ56cTOG8NkeGVDHJc748c7k+okR9zl4DrdTlVFc8XuajTNNGHbesT1BD1gGpFCyp6iX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706908842; c=relaxed/simple;
	bh=jUs3FOiHURQSbndNpw9eAyjunPGYP6jiGaFCC4A3PYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeuAjPueSbpH/+JJUrdrhaDuCjZ6azjAPTJMY5WouppqfYDDdykNdBUqGnrnFS+I6af2ZHx39pRP25CHRhKgmFAXbgL72Cg2cr+BxmVxGMwrtoWrPjwB0w2jDZaL7sA31oHNSHSZfNwPsEF6r5fXOTDXSpKm9WpVRwyMnKzYVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gs399+XR; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-20503dc09adso1582859fac.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 13:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706908839; x=1707513639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92wvK0QB22DZGV3tUKA8OrcYGB+w2iD/0d4E9vYXy90=;
        b=gs399+XRn/XEHp3VeqU9F0bZepjNpgScajG42mi9KKlHfLQYJHWJbw9bQF8gZCyPgu
         uar9/rjfPaaX6rFIBJISVFSUXQAghjut/sFem3P8J1chBk9dea7cKYTQ1vP9zAIRFk6V
         Bf7YzZlQLTA1UCLMhvrREH+4k6Wc5OQsd1UyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706908839; x=1707513639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92wvK0QB22DZGV3tUKA8OrcYGB+w2iD/0d4E9vYXy90=;
        b=ZPwYzmWv8MgxjLAsb3KkHzY4UJsULztO4roihCLxqDT3p91kbwuzPjpauWpCPiCstc
         e2SGUCSqbPRNtry4N0OvDTVKArrTu81BSrrtzLRyo13dc17CH/DR78yD1/p6s1tp1OI3
         POKcFGOCwrT3x0mA+cCpIzHRXbm+FYn9i+K7ZZjFfUd4UaUDw6nqt1jEf6AcR6jAq+Uf
         x7r9hbKVgmUZ7YYe6ZyYzjDMZ0ZIO+k4ZL4uEJ49kNxMZlvHvs2Nxb48+J9gnmCzlTBg
         2jbnp1nRqm4AxKDHxoh3TompEuSDhITzGyt4/VwNKX4bCl6QvXbHPXsNGrXWBZLu8RXH
         HakQ==
X-Gm-Message-State: AOJu0YyBLMHiJJafanbJQWGhJsD46wVM94+Y0POs13bNmioFrN63RsQN
	FSjumqNel20yohL2fjwFGkmk5H0Lz2ziBUozstfKLBmsWqzuQ0xz1KOWJjlpnG6uzSvFN1mqV/s
	XmwdKeMRqflTBJQ4ekwcixjs7Sg9K8dPzoawh
X-Google-Smtp-Source: AGHT+IEHFQyrtYpxn0tuAlfC9rwX/+nRhQdpjBGjKESQj1UnpUByy5Y6kofBq7OGl00pybgPooaYvuinpoC8QXzQhJg=
X-Received: by 2002:a05:6870:7024:b0:214:9ecd:56e8 with SMTP id
 u36-20020a056870702400b002149ecd56e8mr932493oae.33.1706908839487; Fri, 02 Feb
 2024 13:20:39 -0800 (PST)
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
 <CAKbZUD1EsAVupRotYV-ed4PQ3sL5wM4M=f4n-6rF+QNp7C1m4g@mail.gmail.com>
In-Reply-To: <CAKbZUD1EsAVupRotYV-ed4PQ3sL5wM4M=f4n-6rF+QNp7C1m4g@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 2 Feb 2024 13:20:27 -0800
Message-ID: <CABi2SkXB8A-k6ZxgL79irHQDAxMXvVKnUzu3xpH7SJsmhBCfQQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Pedro Falcato <pedro.falcato@gmail.com>
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

On Fri, Feb 2, 2024 at 10:52=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Fri, Feb 2, 2024 at 5:59=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrot=
e:
> >
> > On Thu, Feb 1, 2024 at 9:00=E2=80=AFPM Theo de Raadt <deraadt@openbsd.o=
rg> wrote:
> > >
> > > Jeff Xu <jeffxu@chromium.org> wrote:
> > >
> > > > Even without free.
> > > > I personally do not like the heap getting sealed like that.
> > > >
> > > > Component A.
> > > > p=3Dmalloc(4096);
> > > > writing something to p.
> > > >
> > > > Compohave nent B:
> > > > mprotect(p,4096, RO)
> > > > mseal(p,4096)
> > > >
> > > > This will split the heap VMA, and prevent the heap from shrinking, =
if
> > > > this is in a frequent code path, then it might hurt the process's
> > > > memory usage.
> > > >
> > > > The existing code is more likely to use malloc than mmap(), so it i=
s
> > > > easier for dev to seal a piece of data belonging to another compone=
nt.
> > > > I hope this pattern is not wide-spreading.
> > > >
> > > > The ideal way will be just changing the library A to use mmap.
> > >
> > > I think you are lacking some test programs to see how it actually
> > > behaves; the effect is worse than you think, and the impact is immedi=
ately
> > > visible to the programmer, and the lesson is clear:
> > >
> > >         you can only seal objects which you gaurantee never get recyc=
led.
> > >
> > >         Pushing a sealed object back into reuse is a disasterous bug.
> > >
> > >         Noone should call this interface, unless they understand that=
.
> > >
> > > I'll say again, you don't have a test program for various allocators =
to
> > > understand how it behaves.  The failure modes described in your docue=
mnts
> > > are not correct.
> > >
> > I understand what you mean: I will add that part to the document:
> > Try to recycle a sealed memory is disastrous, e.g.
> > p=3Dmalloc(4096);
> > mprotect(p,4096,RO)
> > mseal(p,4096)
> > free(p);
> >
> > My point is:
> > I think sealing an object from the heap is a bad pattern in general,
> > even dev doesn't free it. That was one of the reasons for the sealable
> > flag, I hope saying this doesn't be perceived as looking for excuses.
>
> The point you're missing is that adding MAP_SEALABLE reduces
> composability. With MAP_SEALABLE, everything that mmaps some part of
> the address space that may ever be sealed will need to be modified to
> know about MAP_SEALABLE.
>
> Say you did the same thing for mprotect. MAP_PROTECT would control the
> mprotectability of the map. You'd stop:
>
> p =3D malloc(4096);
> mprotect(p, 4096, PROT_READ);
> free(p);
>
> ! But you'd need to change every spot that mmap()'s something to know
> about and use MAP_PROTECT: all "producers" of mmap memory would need
> to know about the consumers doing mprotect(). So now either all mmap()
> callers mindlessly add MAP_PROTECT out of fear the consumers do
> mprotect (and you gain nothing from MAP_PROTECT), or the mmap()
> callers need to know the consumers call mprotect(), and thus you
> introduce a huge layering violation (and you actually lose from having
> MAP_PROTECT).
>
> Hopefully you can map the above to MAP_SEALABLE. Or to any other m*()
> operation. For example, if chrome runs on an older glibc that does not
> know about MAP_SEALABLE, it will not be able to mseal() its own shared
> libraries' .text (even if, yes, that should ideally be left to ld.so).
>
I think I have heard enough complaints about MAP_SEALABLE from Linux
developers and Linus in the last two days to convince myself that it
is a bad idea :)

For the last time, I was trying to limit the scope of mseal() limited
to two known cases. And MAP_SEALABLE is a reversible decision, a
system ctrl can turn it off, or we can obsolete it in future. (this
was mentioned in the document of V8).

I will rest my case. Obviously from the feedback,  it is loud and
clear that we want to be able to seal all the memory.

> IMO, UNIX API design has historically mostly been "play stupid games,
> win stupid prizes", which is e.g: why things like close(STDOUT_FILENO)
> work. If you close stdout (and don't dup/reopen something to stdout)
> and printf(), things will break, and you get to keep both pieces.
> There's no O_CLOSEABLE, just as there's no O_DUPABLE.
>
> --
> Pedro

