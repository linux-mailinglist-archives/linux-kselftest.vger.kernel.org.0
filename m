Return-Path: <linux-kselftest+bounces-19619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7B399BF33
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 06:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150F3282D7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 04:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4582260DCF;
	Mon, 14 Oct 2024 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VlU6gPZo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2028371
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 04:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728881385; cv=none; b=PlSmsblcOc8cm0nHPZtzPtJdCoQ3BSPrUQXoKGGUIsbS8XExEPDq9uP5UHoRaxX8d+GdJW8/FEnDEPsiYKvjdwF0uq1iVxUFODETMf8YNabMjfzfErWlcr9ulxTBoxk6BKv5QpeGgjXZpcW9EKyRAEQe3a8IrZ4mv7cLJ6Jb5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728881385; c=relaxed/simple;
	bh=U2cCHdsbIOfVh5dpaXFu+9tUsMgYwBdrm8GpTJjS594=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpdpnmDEL/pYsJdNC4nNfCRiC17VP74dhoEEDI768N3TwUbiMRpO9MfnAJAQL2D8a57DpqV9pkOW1q3MmmDizomQWtZaMvg/Lxx++dmpyKSEn8/TXHAdbL+fY1ZeGcd2egUOmqGevTtoyXct+Hl/1M5da1Djr+TuxDzEgoIOuBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VlU6gPZo; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71578b0439dso242365a34.2
        for <linux-kselftest@vger.kernel.org>; Sun, 13 Oct 2024 21:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728881382; x=1729486182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXygzV2KTIZpy73JYymw8mRNeey1AWkRtD0JC+polOw=;
        b=VlU6gPZoo4H2qdi0RC9kmw5UjjcXj2anIZGU0Libb4OJadDMxQPA85FuyJynA4Q9do
         Pm7qlVL7T5RamWin10RK3rsnAxZnMP5Qn1Uf34l14Unsptllc1GNXxzf1t55uJgInAIe
         /H+9uZJDPSDA353xTBbhhX0LciQU312zbgFi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728881382; x=1729486182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXygzV2KTIZpy73JYymw8mRNeey1AWkRtD0JC+polOw=;
        b=U4CI9txmWnoNmBw/sTw2srLJfnXHFZaw1aPtFYzXjhDwVKjwQC9l1EyzZ7i15wANun
         +0BHCsKLNOsXrw9Q+T8trKVwJ1G8KrYYDKaOaDbRb1MlxNhGsMQSZuiTA9OnIFPIGE0B
         KKNdt1I9uR4YQLz+WtTDOrUtVkpo4Zebo1CvXxdLYFK6seQ1eWJxCJEG52Oszl2xGufT
         z/lU4WosFAi9f6ZJglyrxq61RCteVzGb81Wv4ftY2jlHxUuQaqF3foGEdPFr0j3eZjR4
         BdqfhUw6WZAvQjIowTM+E6WCzHHqk6tdETGwKkpU4HLDvsBfJ2SWwjN/RE+AaTzTBAYO
         gVVg==
X-Forwarded-Encrypted: i=1; AJvYcCUv6OADIX3AfnB0NGy0F059mY1KyAzkuRJgLgsGoo67eRd3UiWsw4a5e9RU/jshVvWey+7CuX4VJyYRRMKtGfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywfy8EK/aZ28kuoMAnEr+LNBL9x3xsvCAAl6Uzaoc2VZtNPNm6
	bVL4I0fj4q55N+pYwWt/3o0TtMdmo52Xro34+WYVscX6aihcftybFhN6RmsaIOnrVG0sGBE1U25
	EB76/ejn1Cgi9ibI+LajWszeVVML/V5RoZTbh
X-Google-Smtp-Source: AGHT+IEW/1AiekjBhEnn2YIPy9eT6g762PBkV5jIpTSn0H9S7U6T1VGDPofVhO6vlb2jV6yz5IwbYQWfUPh8byf/bFE=
X-Received: by 2002:a05:6870:558d:b0:27b:b2e0:6af with SMTP id
 586e51a60fabf-2886dd5a7d4mr1886468fac.2.1728881382240; Sun, 13 Oct 2024
 21:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927185211.729207-1-jeffxu@chromium.org> <20240927185211.729207-2-jeffxu@chromium.org>
 <2vkppisejac42wnawjkd7qzyybuycu667yxwmsd4pfk5rwhiqc@gszyo5lu24ge>
 <CABi2SkU62r8bLCeitzVwAW-r7L8-Lfmy8Cp73DE2HaeLzUXVXQ@mail.gmail.com>
 <2q6hzkvep2g3z6m2jrwbw2j3sbydf6tgj2obwd6hgmm7xzgsg3@ddr5ghmsia5k>
 <CABi2SkUUdbzgGkfr3YjvfUywkC7ciumwMPdLsCCHscr8uJPUeQ@mail.gmail.com> <uwwg47m4mwo3g32qavzr2mjmh4r6lcm3irr3wtlvedlylbq74z@flcq2kwvmh46>
In-Reply-To: <uwwg47m4mwo3g32qavzr2mjmh4r6lcm3irr3wtlvedlylbq74z@flcq2kwvmh46>
From: Jeff Xu <jeffxu@chromium.org>
Date: Sun, 13 Oct 2024 21:49:30 -0700
Message-ID: <CABi2SkW2XzuZ2-TunWOVzTEX1qc29LhjfNQ3hD4Nym8U-_f+ug@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mseal: update mseal.rst
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

On Fri, Oct 4, 2024 at 10:02=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Mon, Sep 30, 2024 at 05:24:39PM -0700, Jeff Xu wrote:
> > Hi Pedro
> >
> > On Sat, Sep 28, 2024 at 6:43=E2=80=AFAM Pedro Falcato <pedro.falcato@gm=
ail.com> wrote:
> > >
> > > On Fri, Sep 27, 2024 at 06:29:30PM GMT, Jeff Xu wrote:
> > > > Hi Pedro,
> > > >
> > > > On Fri, Sep 27, 2024 at 3:59=E2=80=AFPM Pedro Falcato <pedro.falcat=
o@gmail.com> wrote:
> > > <snip>
> > > > > > +
> > > > > > +   Blocked mm syscall:
> > > > > > +      - munmap
> > > > > > +      - mmap
> > > > > > +      - mremap
> > > > > > +      - mprotect and pkey_mprotect
> > > > > > +      - some destructive madvise behaviors: MADV_DONTNEED, MAD=
V_FREE,
> > > > > > +        MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_W=
IPEONFORK
> > > > > > +
> > > > > > +   The first set of syscall to block is munmap, mremap, mmap. =
They can
> > > > > > +   either leave an empty space in the address space, therefore=
 allow
> > > > > > +   replacement with a new mapping with new set of attributes, =
or can
> > > > > > +   overwrite the existing mapping with another mapping.
> > > > > > +
> > > > > > +   mprotect and pkey_mprotect are blocked because they changes=
 the
> > > > >                                                           change
> > > > > > +   protection bits (rwx) of the mapping.
> > > > > > +
> > > > > > +   Some destructive madvice behaviors (MADV_DONTNEED, MADV_FRE=
E,
> > > > > > +   MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEON=
FORK)
> > > > > > +   for anonymous memory, when users don't have write permissio=
n to the
> > > > > > +   memory. Those behaviors can alter region contents by discar=
ding pages,
> > > > > > +   effectively a memset(0) for anonymous memory.
> > > > >
> > > > > What's the difference between anonymous memory and MAP_PRIVATE | =
MAP_FILE?
> > > > >
> > > > MAP_FILE seems not used ?
> > > > anonymous mapping is the mapping that is not backed by a file.
> > >
> > > MAP_FILE is actually defined as 0 usually :) But I meant file-backed =
private mappings.
> > >
> > OK, we are on the same page for this.
> >
> > > > > The feature now, as is (as far as I understand!) will allow you t=
o do things like MADV_DONTNEED
> > > > > on a read-only file mapping. e.g .text. This is obviously wrong?
> > > > >
> > > > When a MADV_DONTNEED is called, pages will be freed, on file-backed
> > > > mapping,  if the process reads from the mapping again, the content
> > > > will be retrieved from the file.
> > > >
> > >
> > > Sorry, it was late and I gave you a crap example. Consider this:
> > > a file-backed MAP_PRIVATE vma is marked RW. I write to it, then RO-it=
 + mseal.
> > >
> > > The attacker later gets me to MADV_DONTNEED that VMA. You've just los=
t data.
> > >
> > > The big problem here is with anon _pages_, not anon vmas.
> > >
> > That depends on the app's threat-model. What you described seems to be
> > a case below
> > 1. The file is rw
> > 2. The process opens the file as rw
> > 3. the process mmap the fd as rw
> > 4 The process writes the memory, and the change isn't flushed to the
> > file on disk.
> > 5 The process  changes the mapping to RO
> > 6. The process seals the mapping
> > 7. The process is called MADV_DONTNEED , and because the change isn't
> > flush to file on disk, so it loses the change, (retrieve the old data
> > from disk when read from the mapped address later)
> >
> > I'm not sure this is a valid use case, the problem here seems to be
> > that the app needs to flush the change from memory to disk if the
> > expectation is writing is permanent.
> >
>
> MAP_PRIVATE never does writeback. That's not what this is about.
> I can trivially discard anonymous pages for private "file VMAs", which ar=
en't
> refilled with the exact same contents. This is a problem.
>
That is fair, I appreciate you providing the use case.

I think mseal should support this . In addition, after reviewing
MADV_DONTNEED, I believe we should also allow madvise(DONTNEED) when
PROT is PROT_NONE.

I will work on fixes for those, but before that,  I like to make sure
some of the existing fixes are backported to 6.10, which makes it easy
to backport future fixes.

> > In any case, the mseal currently just blocks a subset of madvise, those
> > we know with a security implication.  If there is something mseal needs
> > to block additionally, one can always extend it by using the "flags" fi=
eld.
> > I do think the bar is high though, e.g. a valid use case to support tha=
t.
>
> No, this has nothing to do with a flag. It's about providing sane semanti=
cs.
>
> >
> > > > For anonymous mapping, since  there is no file backup, if process
> > > > reads from the mapping, 0 is filled, hence equivalent to memset(0)
> > > >
> > > > > > +
> > > > > > +   Kernel will return -EPERM for blocked syscalls.
> > > > > > +
> > > > > > +   When blocked syscall return -EPERM due to sealing, the memo=
ry regions may or may not be changed, depends on the syscall being blocked:
> > > > > > +      - munmap: munmap is atomic. If one of VMAs in the given =
range is
> > > > > > +        sealed, none of VMAs are updated.
> > > > > > +      - mprotect, pkey_mprotect, madvise: partial update might=
 happen, e.g.
> > > > > > +        when mprotect over multiple VMAs, mprotect might updat=
e the beginning
> > > > > > +        VMAs before reaching the sealed VMA and return -EPERM.
> > > > > > +      - mmap and mremap: undefined behavior.
> > > > >
> > > > > mmap and mremap are actually not undefined as they use munmap sem=
antics for their unmapping.
> > > > > Whether this is something we'd want to document, I don't know hon=
estly (nor do I think is ever written down in POSIX?)
> > > > >
> > > > I'm not sure if I can declare mmap/mremap as atomic.
> > > >
> > > > Although, it might be possible to achieve this due to munmap being
> > > > atomic. I'm not sure  as I didn't test this. Would you like to find
> > > > out ?
> > >
> > > I just told you they use munmap under the hood. It's just that the re=
quirement isn't actually
> > > written down anywhere.
> > >
> > I knew about mmap/mremap calling munmap. I don't know what exactly you
> > are asking though. In your patch and its discussion, you did not mentio=
n
> > the mmap/mremap (for sealing) is or should be atomic.
> >
> > My point is: since there isn't a clear statement from your patch descri=
ption
> > or POSIX, that mremap/mmap is atomic,  and I haven't tested it myself w=
ith
> > regards to sealing, let's  leave them as "undefined" for now. (I could =
get back
> > to this later after the merging window)
> >
> > > >
> > > > > >
> > > > > >  Use cases:
> > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >  - glibc:
> > > > > >    The dynamic linker, during loading ELF executables, can appl=
y sealing to
> > > > > > -  non-writable memory segments.
> > > > > > +  mapping segments.
> > > > > >
> > > > > >  - Chrome browser: protect some security sensitive data-structu=
res.
> > > > > >
> > > > > > -Notes on which memory to seal:
> > > > > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > -
> > > > > > -It might be important to note that sealing changes the lifetim=
e of a mapping,
> > > > > > -i.e. the sealed mapping won=E2=80=99t be unmapped till the pro=
cess terminates or the
> > > > > > -exec system call is invoked. Applications can apply sealing to=
 any virtual
> > > > > > -memory region from userspace, but it is crucial to thoroughly =
analyze the
> > > > > > -mapping's lifetime prior to apply the sealing.
> > > > > > +Don't use mseal on:
> > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > +Applications can apply sealing to any virtual memory region fr=
om userspace,
> > > > > > +but it is *crucial to thoroughly analyze the mapping's lifetim=
e* prior to
> > > > > > +apply the sealing. This is because the sealed mapping *won=E2=
=80=99t be unmapped*
> > > > > > +till the process terminates or the exec system call is invoked=
.
> > > > >
> > > > > There should probably be a nice disclaimer as to how most people =
don't need this or shouldn't use this.
> > > > > At least in its current form.
> > > > >
> > > > Ya, the mseal is not for most apps. I mention the malloc example to=
 stress that.
> > > >
> > > > > <snip>
> > > > > > -
> > > > > > -
> > > > > > -Additional notes:
> > > > > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >  As Jann Horn pointed out in [3], there are still a few ways to=
 write
> > > > > > -to RO memory, which is, in a way, by design. Those cases are n=
ot covered
> > > > > > -by mseal(). If applications want to block such cases, sandbox =
tools (such as
> > > > > > -seccomp, LSM, etc) might be considered.
> > > > > > +to RO memory, which is, in a way, by design. And those could b=
e blocked
> > > > > > +by different security measures.
> > > > > >
> > > > > >  Those cases are:
> > > > > > -
> > > > > > -- Write to read-only memory through /proc/self/mem interface.
> > > > > > -- Write to read-only memory through ptrace (such as PTRACE_POK=
ETEXT).
> > > > > > -- userfaultfd.
> > > > > > +   - Write to read-only memory through /proc/self/mem interfac=
e (FOLL_FORCE).
> > > > > > +   - Write to read-only memory through ptrace (such as PTRACE_=
POKETEXT).
> > > > > > +   - userfaultfd.
> > > > >
> > > > > I don't understand how this is not a problem, but MADV_DONTNEED i=
s.
> > > > > To me it seems that what we have now is completely useless, becau=
se you can trivially
> > > > > bypass it using /proc/self/mem, which is enabled on most Linux sy=
stems.
> > > > >
> > > > > Before you mention ChromeOS or Chrome, I don't care. Kernel featu=
res aren't designed
> > > > > for Chrome. They need to work with every other distro and applica=
tion as well.
> > > > >
> > > > > It seems to me that the most sensible change is blocking/somehow =
distinguishing between /proc/self/mem and
> > > > > /proc/<pid>/mem (some other process) and ptrace. As in blocking /=
proc/self/mem but allowing the other FOLL_FORCE's
> > > > > as the traditional UNIX permission model allows.
> > > > >
> > > > IMO, it is a matter of  Divide and Conquer.  In a nutshell, mseal o=
nly
> > > > prevents VMA's certain attributes (such as prot bits) from changing=
.
> > > > It doesn't mean to say that sealed RO memory is immutable. To achie=
ve
> > > > that, the system needs to apply multiple security measures.
> > >
> > > No, it's a matter of providing a sane API without tons of edgecases. =
Making a VMA immutable should make a VMA
> > > immutable, and not require you to provide a crap ton of other mechani=
sms in order to truly make it immutable.
> > > If I call mseal, I expect it to be sealed, not "sealed except when it=
's not, lol".
> > >
> > > You haven't been able to quite specify what semantics are desirable o=
ut of this whole thing. Making
> > > prot flags "immutable" is completely worthless if you can simply writ=
e to a random pseudofile and
> > > have it bypass the whole thing (where a write to /proc/self/mem is se=
mantically equivalent to
> > > mprotect RW + write + mprotect RO). Making the vma immutable is compl=
etely worthless
> > > if I can simply wipe anon pages. There has to be some end goal here (=
make contents immutable?
> > > make sure VMA protection can't be changed? both?) which seems to be u=
nclear from the kernel mmap-side.
> > >
> > > If you insist on providing half-baked APIs (and waving off any concer=
ns), I'm sure this would've been better
> > > implemented as a random bpf program for chrome. Maybe we could revert=
 this whole thing and give eBPF one
> > > or two bits of vma flags for their own uses :)
> > >
>
> Please reply to the above. We're struggling to understand exactly what se=
mantics you want from this.
> *That* is what we want to document and get set in stone, and we'll move f=
rom there.
>
If you meant to make mseal to support blocking /proc/self/mem or
ptrace or other cases, I welcome that.  Please go ahead to implement
it with a flag, the mseal already has a field for such future
extension.

The current  mseal's semantic doesn't come out from vacuum, for system
such as ChromeOS and Android, they are already relying heavily on
security mechanisms to block /proc/self/mem or ptrace, as I pointed
out previously, SELINUX/YAMA/Landlock/seccomp, and most recently
CONFIG_PROC_MEM_RESTRICT_WRITE_ALL all contributes to that, therefore
I don't have a use case or needs to make mseal to additionally block
those. But I understand others might have different choices on which
security mechanism to use, and I don't want to argue about which
requirements are correct. Security isn't a true/false binary state,
each system is different and no single security feature can achieve
the absolute "secure" state.

Thanks
-Jeff



> > > >
> > > > For writing to /proc/pid/mem, it can be disabled via [1].  SELINUX =
and
> > > > Landlock can achieve the same protection too.
> > >
> > > I'm not blocking /proc/pid/mem, and my distro doesn't run any of thos=
e security modules :/
> > >
> > It is a choice you can make :-)
>
> Your feature needs to work without "extra choices".
>
> --
> Pedro

