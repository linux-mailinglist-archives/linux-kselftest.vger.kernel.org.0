Return-Path: <linux-kselftest+bounces-19046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8A69909D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 19:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDD128259B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 17:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FE01CACF3;
	Fri,  4 Oct 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnoLKOC0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817331741DC;
	Fri,  4 Oct 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061351; cv=none; b=q7NCirfDd7P5z0n0czhN9A03DIGf0lVphcPfPNVVHPodnrJJcPcOQ3h0z/yFIhB7eBbvhxFKq5tNgFgRQFN7biQ0mHWVgpPC9VeAquc4uJr8qGgu5rmkP5006/Ivm8eh/4eIFpK7r+IVi156hDRs735F2v7axnDegeHwgGkJw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061351; c=relaxed/simple;
	bh=Ht9t8OsVMf7Pv4CGdQOAzpuyOqLZKTrKwOVUH/bmhRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0nT8w36zp4BcPpwaZgNlPu5BkldYDolZ0VBL2Qo07tlyhp4tIX2n/LUNTZo2A0DuckVQZ3iuSSIHTpa3DedmoUz/OR2JVyn41GxO4v/xKuTj+tIrGDPr4zuDFSyU5wZYOfni9FAD+BZtDSEf8/YuBLbZWD+vhoNPfNJjVTMuSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnoLKOC0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb2191107so21442795e9.1;
        Fri, 04 Oct 2024 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728061348; x=1728666148; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JJw4/UeiRQMts5EdhkhnYEPBapPPSq1WmYpPKALcDQE=;
        b=JnoLKOC0wu1OB2wih8tyb2QKGSh+QGkNcUab7AXAR3h6bsB4O+R37+4TCov4XK0opM
         Mj2fmFZ1vnuAY3KCLMj/mAQB/4qaG42MRZeX57q80GdRnxWBPaZND6EbbLYYCtIvmlDt
         9p0V5PKJLPbdUnQaVjvGVH4KK0n8v504WXtqaPdSHCItbdI+eIVlcEF61iiIzU0qIcwQ
         OPkgZHFCEMPIFNyo6x0Qu2KjamYpfjrcxUH6i5x9uMNhJFk4fm3mn/PSui188DEcST/+
         RgaJyrmPGVYdlifrx9Pi7ByhJM/F76YIvtFTyFFoEd8XPYYknkyR0arm2pFTEUoZRjcD
         QW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728061348; x=1728666148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJw4/UeiRQMts5EdhkhnYEPBapPPSq1WmYpPKALcDQE=;
        b=JOtFwu9cFqPyOmfWFMtR+gm8Zd1V5+Wl5ExPWuE1aLyOay/xTo2cVXRFWqqgasw9NQ
         UiumlSDaYG8eQJepc6CozUtURUvXAdc1zZDFaRFxMSDe9flz3fD83F9WXtCMgKtoGf3f
         NeRuHCaGtv1AiKhmbFxAYtd60VjSPVYQtRTaRHwrPIYbJ7dnQKhaAbt5abByxWh0fnhC
         M1eYezfvPhzrR8L9DPNUt6WqgEEBbXhEv8cGo33XkhDR0WrAWXJIfQV7ob/ySmw6kPAX
         nduGHyulYQmOTj7oPacvvlWL27U/9gL5A4dd4Qv1eQ+GZ22Bb8qf5guXtglg3q7x+DqS
         E+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUWRsdzbKcgt8sF/W1YwY8Fp+WNtsabW6g8YCCXaQwAaK9/+Bxl8jiP9fgkY6S+N9m8ihZ+ahFMIGq99Dy3@vger.kernel.org, AJvYcCV2c3BTuoDJVxnVus9lDlyicrGd2Q4pS1BHbJOxO7H3FK2t40JvjSsOd13qvkmKU8LsOEF45u1LfEVHxI1OsSdu@vger.kernel.org, AJvYcCVKYg8BQB8lBTNsoRf8YX6XR8L4U2EFfeybbfmwqzobOL8YlD4Po8+3pIrAMd9RZSi+dSjYVb1K84iECvLS8e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNxhqjJJPYj5Ikl1+uEaPThAnMm9TZuhmHzP9mWkvH3/tI8mKs
	H4f8bPhOagfq/q2weHGDF6VlPdm8j3k/folEwmEB6ngoQS2PyzmS
X-Google-Smtp-Source: AGHT+IHgyKEVCMvFOFJlwxR71UPbgQZJ2TM5z1lsH7M0nd+dKaJ3zHAChkE2Y5QMLxyfF4CZC3zmkA==
X-Received: by 2002:a05:600c:4fcc:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-42f85aef9c7mr23760955e9.28.1728061347467;
        Fri, 04 Oct 2024 10:02:27 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:a118:25f3:b27f:9f34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec71aesm1965205e9.33.2024.10.04.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 10:02:26 -0700 (PDT)
Date: Fri, 4 Oct 2024 18:02:24 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, sroettger@google.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, deraadt@openbsd.org, usama.anjum@collabora.com, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, enh@google.com
Subject: Re: [PATCH v1 1/1] mseal: update mseal.rst
Message-ID: <uwwg47m4mwo3g32qavzr2mjmh4r6lcm3irr3wtlvedlylbq74z@flcq2kwvmh46>
References: <20240927185211.729207-1-jeffxu@chromium.org>
 <20240927185211.729207-2-jeffxu@chromium.org>
 <2vkppisejac42wnawjkd7qzyybuycu667yxwmsd4pfk5rwhiqc@gszyo5lu24ge>
 <CABi2SkU62r8bLCeitzVwAW-r7L8-Lfmy8Cp73DE2HaeLzUXVXQ@mail.gmail.com>
 <2q6hzkvep2g3z6m2jrwbw2j3sbydf6tgj2obwd6hgmm7xzgsg3@ddr5ghmsia5k>
 <CABi2SkUUdbzgGkfr3YjvfUywkC7ciumwMPdLsCCHscr8uJPUeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUUdbzgGkfr3YjvfUywkC7ciumwMPdLsCCHscr8uJPUeQ@mail.gmail.com>

On Mon, Sep 30, 2024 at 05:24:39PM -0700, Jeff Xu wrote:
> Hi Pedro
> 
> On Sat, Sep 28, 2024 at 6:43 AM Pedro Falcato <pedro.falcato@gmail.com> wrote:
> >
> > On Fri, Sep 27, 2024 at 06:29:30PM GMT, Jeff Xu wrote:
> > > Hi Pedro,
> > >
> > > On Fri, Sep 27, 2024 at 3:59 PM Pedro Falcato <pedro.falcato@gmail.com> wrote:
> > <snip>
> > > > > +
> > > > > +   Blocked mm syscall:
> > > > > +      - munmap
> > > > > +      - mmap
> > > > > +      - mremap
> > > > > +      - mprotect and pkey_mprotect
> > > > > +      - some destructive madvise behaviors: MADV_DONTNEED, MADV_FREE,
> > > > > +        MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK
> > > > > +
> > > > > +   The first set of syscall to block is munmap, mremap, mmap. They can
> > > > > +   either leave an empty space in the address space, therefore allow
> > > > > +   replacement with a new mapping with new set of attributes, or can
> > > > > +   overwrite the existing mapping with another mapping.
> > > > > +
> > > > > +   mprotect and pkey_mprotect are blocked because they changes the
> > > >                                                           change
> > > > > +   protection bits (rwx) of the mapping.
> > > > > +
> > > > > +   Some destructive madvice behaviors (MADV_DONTNEED, MADV_FREE,
> > > > > +   MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK)
> > > > > +   for anonymous memory, when users don't have write permission to the
> > > > > +   memory. Those behaviors can alter region contents by discarding pages,
> > > > > +   effectively a memset(0) for anonymous memory.
> > > >
> > > > What's the difference between anonymous memory and MAP_PRIVATE | MAP_FILE?
> > > >
> > > MAP_FILE seems not used ?
> > > anonymous mapping is the mapping that is not backed by a file.
> >
> > MAP_FILE is actually defined as 0 usually :) But I meant file-backed private mappings.
> >
> OK, we are on the same page for this.
> 
> > > > The feature now, as is (as far as I understand!) will allow you to do things like MADV_DONTNEED
> > > > on a read-only file mapping. e.g .text. This is obviously wrong?
> > > >
> > > When a MADV_DONTNEED is called, pages will be freed, on file-backed
> > > mapping,  if the process reads from the mapping again, the content
> > > will be retrieved from the file.
> > >
> >
> > Sorry, it was late and I gave you a crap example. Consider this:
> > a file-backed MAP_PRIVATE vma is marked RW. I write to it, then RO-it + mseal.
> >
> > The attacker later gets me to MADV_DONTNEED that VMA. You've just lost data.
> >
> > The big problem here is with anon _pages_, not anon vmas.
> >
> That depends on the app's threat-model. What you described seems to be
> a case below
> 1. The file is rw
> 2. The process opens the file as rw
> 3. the process mmap the fd as rw
> 4 The process writes the memory, and the change isn't flushed to the
> file on disk.
> 5 The process  changes the mapping to RO
> 6. The process seals the mapping
> 7. The process is called MADV_DONTNEED , and because the change isn't
> flush to file on disk, so it loses the change, (retrieve the old data
> from disk when read from the mapped address later)
> 
> I'm not sure this is a valid use case, the problem here seems to be
> that the app needs to flush the change from memory to disk if the
> expectation is writing is permanent.
>

MAP_PRIVATE never does writeback. That's not what this is about.
I can trivially discard anonymous pages for private "file VMAs", which aren't
refilled with the exact same contents. This is a problem.

> In any case, the mseal currently just blocks a subset of madvise, those
> we know with a security implication.  If there is something mseal needs
> to block additionally, one can always extend it by using the "flags" field.
> I do think the bar is high though, e.g. a valid use case to support that.

No, this has nothing to do with a flag. It's about providing sane semantics.

> 
> > > For anonymous mapping, since  there is no file backup, if process
> > > reads from the mapping, 0 is filled, hence equivalent to memset(0)
> > >
> > > > > +
> > > > > +   Kernel will return -EPERM for blocked syscalls.
> > > > > +
> > > > > +   When blocked syscall return -EPERM due to sealing, the memory regions may or may not be changed, depends on the syscall being blocked:
> > > > > +      - munmap: munmap is atomic. If one of VMAs in the given range is
> > > > > +        sealed, none of VMAs are updated.
> > > > > +      - mprotect, pkey_mprotect, madvise: partial update might happen, e.g.
> > > > > +        when mprotect over multiple VMAs, mprotect might update the beginning
> > > > > +        VMAs before reaching the sealed VMA and return -EPERM.
> > > > > +      - mmap and mremap: undefined behavior.
> > > >
> > > > mmap and mremap are actually not undefined as they use munmap semantics for their unmapping.
> > > > Whether this is something we'd want to document, I don't know honestly (nor do I think is ever written down in POSIX?)
> > > >
> > > I'm not sure if I can declare mmap/mremap as atomic.
> > >
> > > Although, it might be possible to achieve this due to munmap being
> > > atomic. I'm not sure  as I didn't test this. Would you like to find
> > > out ?
> >
> > I just told you they use munmap under the hood. It's just that the requirement isn't actually
> > written down anywhere.
> >
> I knew about mmap/mremap calling munmap. I don't know what exactly you
> are asking though. In your patch and its discussion, you did not mention
> the mmap/mremap (for sealing) is or should be atomic.
> 
> My point is: since there isn't a clear statement from your patch description
> or POSIX, that mremap/mmap is atomic,  and I haven't tested it myself with
> regards to sealing, let's  leave them as "undefined" for now. (I could get back
> to this later after the merging window)
> 
> > >
> > > > >
> > > > >  Use cases:
> > > > >  ==========
> > > > >  - glibc:
> > > > >    The dynamic linker, during loading ELF executables, can apply sealing to
> > > > > -  non-writable memory segments.
> > > > > +  mapping segments.
> > > > >
> > > > >  - Chrome browser: protect some security sensitive data-structures.
> > > > >
> > > > > -Notes on which memory to seal:
> > > > > -==============================
> > > > > -
> > > > > -It might be important to note that sealing changes the lifetime of a mapping,
> > > > > -i.e. the sealed mapping won’t be unmapped till the process terminates or the
> > > > > -exec system call is invoked. Applications can apply sealing to any virtual
> > > > > -memory region from userspace, but it is crucial to thoroughly analyze the
> > > > > -mapping's lifetime prior to apply the sealing.
> > > > > +Don't use mseal on:
> > > > > +===================
> > > > > +Applications can apply sealing to any virtual memory region from userspace,
> > > > > +but it is *crucial to thoroughly analyze the mapping's lifetime* prior to
> > > > > +apply the sealing. This is because the sealed mapping *won’t be unmapped*
> > > > > +till the process terminates or the exec system call is invoked.
> > > >
> > > > There should probably be a nice disclaimer as to how most people don't need this or shouldn't use this.
> > > > At least in its current form.
> > > >
> > > Ya, the mseal is not for most apps. I mention the malloc example to stress that.
> > >
> > > > <snip>
> > > > > -
> > > > > -
> > > > > -Additional notes:
> > > > > -=================
> > > > >  As Jann Horn pointed out in [3], there are still a few ways to write
> > > > > -to RO memory, which is, in a way, by design. Those cases are not covered
> > > > > -by mseal(). If applications want to block such cases, sandbox tools (such as
> > > > > -seccomp, LSM, etc) might be considered.
> > > > > +to RO memory, which is, in a way, by design. And those could be blocked
> > > > > +by different security measures.
> > > > >
> > > > >  Those cases are:
> > > > > -
> > > > > -- Write to read-only memory through /proc/self/mem interface.
> > > > > -- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> > > > > -- userfaultfd.
> > > > > +   - Write to read-only memory through /proc/self/mem interface (FOLL_FORCE).
> > > > > +   - Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> > > > > +   - userfaultfd.
> > > >
> > > > I don't understand how this is not a problem, but MADV_DONTNEED is.
> > > > To me it seems that what we have now is completely useless, because you can trivially
> > > > bypass it using /proc/self/mem, which is enabled on most Linux systems.
> > > >
> > > > Before you mention ChromeOS or Chrome, I don't care. Kernel features aren't designed
> > > > for Chrome. They need to work with every other distro and application as well.
> > > >
> > > > It seems to me that the most sensible change is blocking/somehow distinguishing between /proc/self/mem and
> > > > /proc/<pid>/mem (some other process) and ptrace. As in blocking /proc/self/mem but allowing the other FOLL_FORCE's
> > > > as the traditional UNIX permission model allows.
> > > >
> > > IMO, it is a matter of  Divide and Conquer.  In a nutshell, mseal only
> > > prevents VMA's certain attributes (such as prot bits) from changing.
> > > It doesn't mean to say that sealed RO memory is immutable. To achieve
> > > that, the system needs to apply multiple security measures.
> >
> > No, it's a matter of providing a sane API without tons of edgecases. Making a VMA immutable should make a VMA
> > immutable, and not require you to provide a crap ton of other mechanisms in order to truly make it immutable.
> > If I call mseal, I expect it to be sealed, not "sealed except when it's not, lol".
> >
> > You haven't been able to quite specify what semantics are desirable out of this whole thing. Making
> > prot flags "immutable" is completely worthless if you can simply write to a random pseudofile and
> > have it bypass the whole thing (where a write to /proc/self/mem is semantically equivalent to
> > mprotect RW + write + mprotect RO). Making the vma immutable is completely worthless
> > if I can simply wipe anon pages. There has to be some end goal here (make contents immutable?
> > make sure VMA protection can't be changed? both?) which seems to be unclear from the kernel mmap-side.
> >
> > If you insist on providing half-baked APIs (and waving off any concerns), I'm sure this would've been better
> > implemented as a random bpf program for chrome. Maybe we could revert this whole thing and give eBPF one
> > or two bits of vma flags for their own uses :)
> >

Please reply to the above. We're struggling to understand exactly what semantics you want from this.
*That* is what we want to document and get set in stone, and we'll move from there.

> > >
> > > For writing to /proc/pid/mem, it can be disabled via [1].  SELINUX and
> > > Landlock can achieve the same protection too.
> >
> > I'm not blocking /proc/pid/mem, and my distro doesn't run any of those security modules :/
> >
> It is a choice you can make :-)

Your feature needs to work without "extra choices".

-- 
Pedro

