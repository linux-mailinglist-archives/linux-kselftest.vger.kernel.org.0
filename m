Return-Path: <linux-kselftest+bounces-20442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA789AC25E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035421C20D8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7378E16F0F0;
	Wed, 23 Oct 2024 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDZZebDn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737FF16130B
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673812; cv=none; b=rEpVF9f6Do++1ICqnP1PDIMDtmZTySKppciO/co2n5zlyxV/X9PEf+aPRih5xyE1dw56dYXdfk3qKQB6Q5BPCafJi4/Wr3uGlpaQ0kNTZ8tOo6HJ3Ont8mf0olfkU1q+5lx/DRibKkfTkvyBgdBDq3OH1jJigbsz/OGKTP5BRkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673812; c=relaxed/simple;
	bh=U1nlvZx2bp3P9lBcv8HcwWjukQvv1dA7SVQ4LPhJu+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXA3R399/4z4TsAyq8t4fB9zWdEZ4kkgQlZtP0OO85gIPOJsG19pmCRkSe98wyPZhY0ve5/9Pvy9bph2loIHbKU6X30f+zSOxpfOlv8IYZLk8k+oJ6GEuuArOZJ6etmiH+87W4YnyRTpBI4L1fMdtECD3CLsH3Ex7PF5lu8/r2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDZZebDn; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so5748371fa.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 01:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729673808; x=1730278608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B8CkFURLW567ianwD0kQbNa+S705JCFmVdVbQVhbttk=;
        b=dDZZebDnUlXT2LbWUgKYLuAAjxXIZWmbfkFxyWMO5VaWKlzGNl3yT+ndt/6yqjxCMn
         Hw0woKJZK3SWYzG8pL/QPnB/w20f7IjhHgwes63TaG1mpeIRYyT4d14IloowBjWJ7KCa
         X6yRs99Bjq4aG46Z4fPBUpfkHlt5ChJLAsHdFULu7KetKW+3ePe70cjwXBfUQMvBLnNB
         O9RYTfGhiRQkapH05PUjTkvBEF6jxtxf4MHXxiAyZzyyVve0dn/kYMVqK2z9/hCR8Q4z
         KU9ExfVbFvLonesW96oiCAUKYVaaVu/oigkHg2Femz3t+fdbAICPhmazOnc6viskoBR/
         Vzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729673808; x=1730278608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8CkFURLW567ianwD0kQbNa+S705JCFmVdVbQVhbttk=;
        b=nIXDuC5NvJViHrQ397H9P/u087cmhYVPwC3A9kuiBA5Zp3LTQQyG6TQ61f8gkd5u9l
         HTWg7KrwK0R+F3iqdOHWXagfuSrF71zz9b7H/Io1nwmn5UbTeWOjILJN9gKTPZ+F4DvE
         r/dbyfjEnc/HZJvFtBgbLEFmAWDV6Jjcfj9mfTZ73efNN/jo9W9ezj7f3BnAodrxknzn
         SbilPgxRHM8wBq9CL9MCnhJ5hZ4IMRXjPaxxvqCqhINgKx9zu5+05ZU74W1BZQdVtet7
         Vay8AeZvh2nRkSHHbgYoqLjUsUw5REsXXCaK184QW6uufpfhPVfY9p4hZQvcV0lNSduT
         0oTA==
X-Forwarded-Encrypted: i=1; AJvYcCUDN7jM2/82aCYlwIgQBTpsJyYxxLwwWJRkkknI/E+CNZ44+bPdJEVdbrGP1A3/7jLoQyzKjCQTcYXQVJJz7VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwahjWlAPf8eyhQBWU4w5Yb1JZF7dQFWXO+OGs0x4HVn1TZ9Stc
	w5t6FTLi36fvb7hZMwLjWfbw+X/CjE/ts6K/2Hj4agtr9zfQhdjgmHuno+WM6cR0C4oMGtZoy3Y
	mqpq0SKcJukKLFwyC94TJox6STRs4lcQC8KVH
X-Google-Smtp-Source: AGHT+IFJyix7nHZqbrcmoYi68VrxcCXIDptIBfA2F8NkNPGJDlP/PrFzgRE1M5nnfjhZx6AKFu2zdsjKTjLbclUMUq8=
X-Received: by 2002:a2e:b8c1:0:b0:2fb:4a15:6112 with SMTP id
 38308e7fff4ca-2fc9cfe7adamr7683491fa.4.1729673808345; Wed, 23 Oct 2024
 01:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a5eysmj1.fsf@mid.deneb.enyo.de> <20241023062417.3862170-1-dvyukov@google.com>
 <8471d7b1-576b-41a6-91fb-1c9baae8c540@redhat.com> <5a3d3bc8-60db-46d0-b689-9aeabcdb8eab@lucifer.local>
In-Reply-To: <5a3d3bc8-60db-46d0-b689-9aeabcdb8eab@lucifer.local>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 23 Oct 2024 10:56:33 +0200
Message-ID: <CACT4Y+ZE9Zco7KaQoT50aooXCHxhz2N_psTAFtT+ZrH14Si7aw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, fw@deneb.enyo.de, 
	James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org, 
	chris@zankel.net, deller@gmx.de, hch@infradead.org, ink@jurassic.park.msu.ru, 
	jannh@google.com, jcmvbkbc@gmail.com, jeffxu@chromium.org, 
	jhubbard@nvidia.com, linux-alpha@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-parisc@vger.kernel.org, mattst88@gmail.com, 
	muchun.song@linux.dev, paulmck@kernel.org, richard.henderson@linaro.org, 
	shuah@kernel.org, sidhartha.kumar@oracle.com, surenb@google.com, 
	tsbogend@alpha.franken.de, vbabka@suse.cz, willy@infradead.org, 
	elver@google.com, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 10:12, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> +cc Linus as reference a commit of his below...
>
> On Wed, Oct 23, 2024 at 09:19:03AM +0200, David Hildenbrand wrote:
> > On 23.10.24 08:24, Dmitry Vyukov wrote:
> > > Hi Florian, Lorenzo,
> > >
> > > This looks great!
>
> Thanks!
>
> > >
> > > What I am VERY interested in is if poisoned pages cause SIGSEGV even when
> > > the access happens in the kernel. Namely, the syscall still returns EFAULT,
> > > but also SIGSEGV is queued on return to user-space.
>
> Yeah we don't in any way.
>
> I think adding something like this would be a bit of its own project.

I can totally understand this.

> The fault andler for this is in handle_pte_marker() in mm/memory.c, where
> we do the following:
>
>         /* Hitting a guard page is always a fatal condition. */
>         if (marker & PTE_MARKER_GUARD)
>                 return VM_FAULT_SIGSEGV;
>
> So basically we pass this back to whoever invoked the fault. For uaccess we
> end up in arch-specific code that eventually checks exception tables
> etc. and for x86-64 that's kernelmode_fixup_or_oops().
>
> There used to be a sig_on_uaccess_err in the x86-specific thread_struct
> that let you propagate it but Linus pulled it out in commit 02b670c1f88e
> ("x86/mm: Remove broken vsyscall emulation code from the page fault code")
> where it was presumably used for vsyscall.
>
> Of course we could just get something much higher up the stack to send the
> signal, but we'd need to be careful we weren't breaking anything doing
> it...

Can setting TIF_NOTIFY_RESUME and then doing the rest when returning
to userspace help here?

> I address GUP below.
>
> > >
> > > Catching bad accesses in system calls is currently the weak spot for
> > > all user-space bug detection tools (GWP-ASan, libefence, libefency, etc).
> > > It's almost possible with userfaultfd, but catching faults in the kernel
> > > requires admin capability, so not really an option for generic bug
> > > detection tools (+inconvinience of userfaultfd setup/handler).
> > > Intercepting all EFAULT from syscalls is not generally possible
> > > (w/o ptrace, usually not an option as well), and EFAULT does not always
> > > mean a bug.
> > >
> > > Triggering SIGSEGV even in syscalls would be not just a performance
> > > optimization, but a new useful capability that would allow it to catch
> > > more bugs.
> >
> > Right, we discussed that offline also as a possible extension to the
> > userfaultfd SIGBUS mode.
> >
> > I did not look into that yet, but I was wonder if there could be cases where
> > a different process could trigger that SIGSEGV, and how to (and if to)
> > handle that.
> >
> > For example, ptrace (access_remote_vm()) -> GUP likely can trigger that. I
> > think with userfaultfd() we will currently return -EFAULT, because we call
> > get_user_page_vma_remote() that is not prepared for dropping the mmap lock.
> > Possibly that is the right thing to do, but not sure :)

That's a good corner case.
I guess also process_vm_readv/writev.
Not triggering the signal in these cases looks like the right thing to do.

> > These "remote" faults set FOLL_REMOTE -> FAULT_FLAG_REMOTE, so we might be
> > able to distinguish them and perform different handling.
>
> So all GUP will return -EFAULT when hitting guard pages unless we change
> something.
>
> In GUP we handle this in faultin_page():
>
>         if (ret & VM_FAULT_ERROR) {
>                 int err = vm_fault_to_errno(ret, flags);
>
>                 if (err)
>                         return err;
>                 BUG();
>         }
>
> And vm_fault_to_errno() is:
>
> static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
> {
>         if (vm_fault & VM_FAULT_OOM)
>                 return -ENOMEM;
>         if (vm_fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE))
>                 return (foll_flags & FOLL_HWPOISON) ? -EHWPOISON : -EFAULT;
>         if (vm_fault & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV))
>                 return -EFAULT;
>         return 0;
> }
>
> Again, I think if we wanted special handling here we'd need to probably
> propagate that fault from higher up, but yes we'd need to for one
> definitely not do so if it's remote but I worry about other cases.
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
>
> Overall while I sympathise with this, it feels dangerous and a pretty major
> change, because there'll be something somewhere that will break because it
> expects faults to be swallowed that we no longer do swallow.
>
> So I'd say it'd be something we should defer, but of course it's a highly
> user-facing change so how easy that would be I don't know.
>
> But I definitely don't think a 'introduce the ability to do cheap PROT_NONE
> guards' series is the place to also fundmentally change how user access
> page faults are handled within the kernel :)

Will delivering signals on kernel access be a backwards compatible
change? Or will we need a different API? MADV_GUARD_POISON_KERNEL?
It's just somewhat painful to detect/update all userspace if we add
this feature in future. Can we say signal delivery on kernel accesses
is unspecified?

