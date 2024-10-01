Return-Path: <linux-kselftest+bounces-18704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9050D98B16D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 02:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3691C20B3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 00:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CAA645;
	Tue,  1 Oct 2024 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ODAl5FWT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F94DF44
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742295; cv=none; b=R9GfYQOh+gLqlZEM0gxPQt42jW49Ky+dkBeUtUW2mqO7icxmTg4CTVa+LdyVfbZi+o1+cVYLZresnRlzDi4VUHfyhCdsZEEhtNruJlWfpZcFz6Y6vOdX3OI1kX8DW81q9BVCxXVMRahzQkLzudm7JrHFvtzDSzFJsmrJW7qTYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742295; c=relaxed/simple;
	bh=CzCmRVE+9q41GiS39woWM81gxTD6PlkEfZ/hZf27/JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUVb+627Y5OKdGLiJfarisHRFlOa24sksG6Q6ZMwnq9aOMer1+qWLG9QqfhD2o/E6LAuvIn7CMYMk5e6olkK/NmupMyACzikxybR5FYoM90DQlgGg1aPS5eBVXEhwOJbwwVyWdxaHb5l1MQScYvnSfUApznGAW1jzByRAShIdnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ODAl5FWT; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e03ffc29b5so455325b6e.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727742292; x=1728347092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRjyf8DNLWw+FQRgr1LU0I9O1VNiCFlWqQFNhlCICtY=;
        b=ODAl5FWTOeiJADDyQnbl1JFEhuibGgVGZl1eL59tEZKXhkFa97mUlJUyeMwcmszjeI
         G53pHAxYvx60tVOnv34p1vMGiTpsnxg7RxY/g36GGyWLzscTz42rlIIlhnoTrOd4hWN/
         ygayVcEJTaIHodh7bDW5gbyFp/fl2TDoXtuXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727742292; x=1728347092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRjyf8DNLWw+FQRgr1LU0I9O1VNiCFlWqQFNhlCICtY=;
        b=VUgSoj7kUfqJyUIhGRW9Gxp1ZggW21n6Zy1+4JsAqQr7IILerdgku30+Gl9vSqSMK6
         H6xEyf/2BLX4V1qAZJDtZCs8oM1zyhulloeov1kj9vfXefZwLkC+iZTt5hgRoxVFe1O6
         6fiFS1pkIyqfE1P4sYwCgHGlV1zz+Un6jfCCoEq6+DvfZU/268pTF8Z4BYzsxmgcETBA
         TeXbCASUp8INir+saUJUbxvipEgeXGOJO3ZuOY1Tgth0ijspPKDTPY2OxFMiv1Qsyhj6
         EDWeqp51IFMQqIeT3Eaui5cx1S2yOC+tHeTGUcaKoJwhs4Y+55vgVs/vyVAoD9cEk0Ej
         ZBLg==
X-Forwarded-Encrypted: i=1; AJvYcCVrGZA1JhQgcqhL4wv0OH6DVBIK9v/tEXY5i67igkGRd55ZQuqPsI+hp80uyF65FTTPTM+i3FgkjUbHJ3Wl9Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8RmMANzh3t98njZdGf9KJ2rtFsDt3TIPAwJofWF3bV4Xa9gm
	gMRUhNKaiUJ8e9iEIJltUEhrIhz/mXBT2eDqgHMhI9TRCSzMCJhv321NIE1AMOj0dDYvwBn05BG
	xsnMu+pzpcPoNiZyEIvDS3Kpb3ZvvdUkpljoP
X-Google-Smtp-Source: AGHT+IFCsfySBWujRZtWHM3rWdTyMvEGDNIuSvn9PACkABfd+R8ovsObosCVlzhPRk2UblrlgRoo1AHxGo6PyxdmkeM=
X-Received: by 2002:a05:6870:3112:b0:27c:df37:9e0c with SMTP id
 586e51a60fabf-2872ab08c4dmr1819194fac.8.1727742292181; Mon, 30 Sep 2024
 17:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927185211.729207-1-jeffxu@chromium.org> <20240927185211.729207-2-jeffxu@chromium.org>
 <2vkppisejac42wnawjkd7qzyybuycu667yxwmsd4pfk5rwhiqc@gszyo5lu24ge>
 <CABi2SkU62r8bLCeitzVwAW-r7L8-Lfmy8Cp73DE2HaeLzUXVXQ@mail.gmail.com> <2q6hzkvep2g3z6m2jrwbw2j3sbydf6tgj2obwd6hgmm7xzgsg3@ddr5ghmsia5k>
In-Reply-To: <2q6hzkvep2g3z6m2jrwbw2j3sbydf6tgj2obwd6hgmm7xzgsg3@ddr5ghmsia5k>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 30 Sep 2024 17:24:39 -0700
Message-ID: <CABi2SkUUdbzgGkfr3YjvfUywkC7ciumwMPdLsCCHscr8uJPUeQ@mail.gmail.com>
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

On Sat, Sep 28, 2024 at 6:43=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Fri, Sep 27, 2024 at 06:29:30PM GMT, Jeff Xu wrote:
> > Hi Pedro,
> >
> > On Fri, Sep 27, 2024 at 3:59=E2=80=AFPM Pedro Falcato <pedro.falcato@gm=
ail.com> wrote:
> <snip>
> > > > +
> > > > +   Blocked mm syscall:
> > > > +      - munmap
> > > > +      - mmap
> > > > +      - mremap
> > > > +      - mprotect and pkey_mprotect
> > > > +      - some destructive madvise behaviors: MADV_DONTNEED, MADV_FR=
EE,
> > > > +        MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEO=
NFORK
> > > > +
> > > > +   The first set of syscall to block is munmap, mremap, mmap. They=
 can
> > > > +   either leave an empty space in the address space, therefore all=
ow
> > > > +   replacement with a new mapping with new set of attributes, or c=
an
> > > > +   overwrite the existing mapping with another mapping.
> > > > +
> > > > +   mprotect and pkey_mprotect are blocked because they changes the
> > >                                                           change
> > > > +   protection bits (rwx) of the mapping.
> > > > +
> > > > +   Some destructive madvice behaviors (MADV_DONTNEED, MADV_FREE,
> > > > +   MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK=
)
> > > > +   for anonymous memory, when users don't have write permission to=
 the
> > > > +   memory. Those behaviors can alter region contents by discarding=
 pages,
> > > > +   effectively a memset(0) for anonymous memory.
> > >
> > > What's the difference between anonymous memory and MAP_PRIVATE | MAP_=
FILE?
> > >
> > MAP_FILE seems not used ?
> > anonymous mapping is the mapping that is not backed by a file.
>
> MAP_FILE is actually defined as 0 usually :) But I meant file-backed priv=
ate mappings.
>
OK, we are on the same page for this.

> > > The feature now, as is (as far as I understand!) will allow you to do=
 things like MADV_DONTNEED
> > > on a read-only file mapping. e.g .text. This is obviously wrong?
> > >
> > When a MADV_DONTNEED is called, pages will be freed, on file-backed
> > mapping,  if the process reads from the mapping again, the content
> > will be retrieved from the file.
> >
>
> Sorry, it was late and I gave you a crap example. Consider this:
> a file-backed MAP_PRIVATE vma is marked RW. I write to it, then RO-it + m=
seal.
>
> The attacker later gets me to MADV_DONTNEED that VMA. You've just lost da=
ta.
>
> The big problem here is with anon _pages_, not anon vmas.
>
That depends on the app's threat-model. What you described seems to be
a case below
1. The file is rw
2. The process opens the file as rw
3. the process mmap the fd as rw
4 The process writes the memory, and the change isn't flushed to the
file on disk.
5 The process  changes the mapping to RO
6. The process seals the mapping
7. The process is called MADV_DONTNEED , and because the change isn't
flush to file on disk, so it loses the change, (retrieve the old data
from disk when read from the mapped address later)

I'm not sure this is a valid use case, the problem here seems to be
that the app needs to flush the change from memory to disk if the
expectation is writing is permanent.

In any case, the mseal currently just blocks a subset of madvise, those
we know with a security implication.  If there is something mseal needs
to block additionally, one can always extend it by using the "flags" field.
I do think the bar is high though, e.g. a valid use case to support that.

> > For anonymous mapping, since  there is no file backup, if process
> > reads from the mapping, 0 is filled, hence equivalent to memset(0)
> >
> > > > +
> > > > +   Kernel will return -EPERM for blocked syscalls.
> > > > +
> > > > +   When blocked syscall return -EPERM due to sealing, the memory r=
egions may or may not be changed, depends on the syscall being blocked:
> > > > +      - munmap: munmap is atomic. If one of VMAs in the given rang=
e is
> > > > +        sealed, none of VMAs are updated.
> > > > +      - mprotect, pkey_mprotect, madvise: partial update might hap=
pen, e.g.
> > > > +        when mprotect over multiple VMAs, mprotect might update th=
e beginning
> > > > +        VMAs before reaching the sealed VMA and return -EPERM.
> > > > +      - mmap and mremap: undefined behavior.
> > >
> > > mmap and mremap are actually not undefined as they use munmap semanti=
cs for their unmapping.
> > > Whether this is something we'd want to document, I don't know honestl=
y (nor do I think is ever written down in POSIX?)
> > >
> > I'm not sure if I can declare mmap/mremap as atomic.
> >
> > Although, it might be possible to achieve this due to munmap being
> > atomic. I'm not sure  as I didn't test this. Would you like to find
> > out ?
>
> I just told you they use munmap under the hood. It's just that the requir=
ement isn't actually
> written down anywhere.
>
I knew about mmap/mremap calling munmap. I don't know what exactly you
are asking though. In your patch and its discussion, you did not mention
the mmap/mremap (for sealing) is or should be atomic.

My point is: since there isn't a clear statement from your patch descriptio=
n
or POSIX, that mremap/mmap is atomic,  and I haven't tested it myself with
regards to sealing, let's  leave them as "undefined" for now. (I could get =
back
to this later after the merging window)

> >
> > > >
> > > >  Use cases:
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >  - glibc:
> > > >    The dynamic linker, during loading ELF executables, can apply se=
aling to
> > > > -  non-writable memory segments.
> > > > +  mapping segments.
> > > >
> > > >  - Chrome browser: protect some security sensitive data-structures.
> > > >
> > > > -Notes on which memory to seal:
> > > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > -
> > > > -It might be important to note that sealing changes the lifetime of=
 a mapping,
> > > > -i.e. the sealed mapping won=E2=80=99t be unmapped till the process=
 terminates or the
> > > > -exec system call is invoked. Applications can apply sealing to any=
 virtual
> > > > -memory region from userspace, but it is crucial to thoroughly anal=
yze the
> > > > -mapping's lifetime prior to apply the sealing.
> > > > +Don't use mseal on:
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +Applications can apply sealing to any virtual memory region from u=
serspace,
> > > > +but it is *crucial to thoroughly analyze the mapping's lifetime* p=
rior to
> > > > +apply the sealing. This is because the sealed mapping *won=E2=80=
=99t be unmapped*
> > > > +till the process terminates or the exec system call is invoked.
> > >
> > > There should probably be a nice disclaimer as to how most people don'=
t need this or shouldn't use this.
> > > At least in its current form.
> > >
> > Ya, the mseal is not for most apps. I mention the malloc example to str=
ess that.
> >
> > > <snip>
> > > > -
> > > > -
> > > > -Additional notes:
> > > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >  As Jann Horn pointed out in [3], there are still a few ways to wri=
te
> > > > -to RO memory, which is, in a way, by design. Those cases are not c=
overed
> > > > -by mseal(). If applications want to block such cases, sandbox tool=
s (such as
> > > > -seccomp, LSM, etc) might be considered.
> > > > +to RO memory, which is, in a way, by design. And those could be bl=
ocked
> > > > +by different security measures.
> > > >
> > > >  Those cases are:
> > > > -
> > > > -- Write to read-only memory through /proc/self/mem interface.
> > > > -- Write to read-only memory through ptrace (such as PTRACE_POKETEX=
T).
> > > > -- userfaultfd.
> > > > +   - Write to read-only memory through /proc/self/mem interface (F=
OLL_FORCE).
> > > > +   - Write to read-only memory through ptrace (such as PTRACE_POKE=
TEXT).
> > > > +   - userfaultfd.
> > >
> > > I don't understand how this is not a problem, but MADV_DONTNEED is.
> > > To me it seems that what we have now is completely useless, because y=
ou can trivially
> > > bypass it using /proc/self/mem, which is enabled on most Linux system=
s.
> > >
> > > Before you mention ChromeOS or Chrome, I don't care. Kernel features =
aren't designed
> > > for Chrome. They need to work with every other distro and application=
 as well.
> > >
> > > It seems to me that the most sensible change is blocking/somehow dist=
inguishing between /proc/self/mem and
> > > /proc/<pid>/mem (some other process) and ptrace. As in blocking /proc=
/self/mem but allowing the other FOLL_FORCE's
> > > as the traditional UNIX permission model allows.
> > >
> > IMO, it is a matter of  Divide and Conquer.  In a nutshell, mseal only
> > prevents VMA's certain attributes (such as prot bits) from changing.
> > It doesn't mean to say that sealed RO memory is immutable. To achieve
> > that, the system needs to apply multiple security measures.
>
> No, it's a matter of providing a sane API without tons of edgecases. Maki=
ng a VMA immutable should make a VMA
> immutable, and not require you to provide a crap ton of other mechanisms =
in order to truly make it immutable.
> If I call mseal, I expect it to be sealed, not "sealed except when it's n=
ot, lol".
>
> You haven't been able to quite specify what semantics are desirable out o=
f this whole thing. Making
> prot flags "immutable" is completely worthless if you can simply write to=
 a random pseudofile and
> have it bypass the whole thing (where a write to /proc/self/mem is semant=
ically equivalent to
> mprotect RW + write + mprotect RO). Making the vma immutable is completel=
y worthless
> if I can simply wipe anon pages. There has to be some end goal here (make=
 contents immutable?
> make sure VMA protection can't be changed? both?) which seems to be uncle=
ar from the kernel mmap-side.
>
> If you insist on providing half-baked APIs (and waving off any concerns),=
 I'm sure this would've been better
> implemented as a random bpf program for chrome. Maybe we could revert thi=
s whole thing and give eBPF one
> or two bits of vma flags for their own uses :)
>
> >
> > For writing to /proc/pid/mem, it can be disabled via [1].  SELINUX and
> > Landlock can achieve the same protection too.
>
> I'm not blocking /proc/pid/mem, and my distro doesn't run any of those se=
curity modules :/
>
It is a choice you can make :-)

Linux is diverse, from desktop to mobile to cloud hosting to embedded syste=
ms.
For a safe-by-default system, some of them might like those security
enhancements.

Thanks
-Jeff


-Jeff

> --
> Pedro

