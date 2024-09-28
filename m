Return-Path: <linux-kselftest+bounces-18527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F49988F7A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 15:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59DA282424
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8551885B2;
	Sat, 28 Sep 2024 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2pwjq+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6481C186E56;
	Sat, 28 Sep 2024 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531020; cv=none; b=ixd1GmOP15yXhlO3uPhy7gN4ZHUC9KF9G00uCkV3a1ym+L4DgK+9Wd3yPrqFxBUsWBKRVtKYS27jmCacZXHRL4tsvTHs+M8+II4gl5LDlsj9VEH9QO27Nhf1tlcgJcPUrp/+URQjB4L30l7CuW4QwtXGqQaazsVq5nwZKUXSWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531020; c=relaxed/simple;
	bh=sLfgk5twSJOiwBgJQI3IQescTOVT51zRwUUlPqXvzv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hq7WhkUs4vk3tsOTfeoKTrnJMSoIoF2JcxCn4kxm0Ri1cKnBhhXod9REaSlxpDEmo4Xf44qMnxC1Z5IEeZu4cLXyHkXAVp1XK0Xkg1et4ElJKMExfHj1zy3Y+WNSZIDEzdPg6xF7gUn2wKCzrepChlV9HTxcWioEZsm/kSts/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2pwjq+z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so24168445e9.3;
        Sat, 28 Sep 2024 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727531017; x=1728135817; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3s38JrVlJwg1WQYaaoheQOJoYWoLobns9br/Lt2jT7o=;
        b=J2pwjq+zmH9qcbJuw6EODo2OhUzKXYtnx0bYFJFfkNpwILHRf2MJzkuZwg47IwlVeG
         3bl9r/eceCVsWR0N2+YbQ26s8PVXC64877Vhd9/TTefJxQ/HmvSrV3fJlLPreta5tHLP
         osWSBxT6rv0n64BRC3JLrupmf+DYz2Vlb73e8BBMScFCF1bUQBJg2fS6/R8S8dhkfoxC
         IeftE44Z8q+EuvJmjxNODhblxfQvl20IXVBUxvvBLdtmTVh7xSY2bPPppJPUlF3U4Rop
         1nR0M/qYmYGFlYpqUegOSPy5SkjgAlCjggVqD+qDo/QB8J+l8io59BJ9H2qJqjwF/xUq
         GCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727531017; x=1728135817;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3s38JrVlJwg1WQYaaoheQOJoYWoLobns9br/Lt2jT7o=;
        b=oLDd8RL2PDcvRLVFtjYMGE7QyK/3wg+yX5Judj/hEWAUOrXCIwQAt/N9kCaOnywMmK
         YV77shLznHigtP9ujtMTPgwqvCStnVm7CKN39RHasTqnJlH5FMiLk/r/VEAYR4Npxcgi
         OJbtEm0IXoGEluDO1sWVu/dvDDkdptTPylKI8YGEP6xi/zZU0rw8ZTkbI3in4JVLREiO
         bZwwgpdo7dZ3XS9ajWLqmHVpXA3/5zZou1k+0w9G00jVXmHM90cxQ5NLU9M9LgayjZK2
         VIUy47A8LuF3BUw+voXYa8At8kDD+6ablXogMYmPzExQpPDGbN3NsVZjwfvw7H3o1T0G
         wTyg==
X-Forwarded-Encrypted: i=1; AJvYcCUGvqpWm2lRgm5gyy3OmGGB0C9fO4CIvCwaWz1rwqG1rAQRPgDQP48HuYN6vKGfJbh7BKbtqbX88H/SQAXMkFir@vger.kernel.org, AJvYcCXMpawk90jVsz1TeEtIwwz3MJ0EpgFvKpRCLl2BPkAuN3ji5EOjhQAEMkyt/9a6nCglLBYSvcxQnciMMqE32a8=@vger.kernel.org, AJvYcCXuV7MuQOWSTQ/wIULMGf6hXfsdbP4eX0Bmb9CmnNYQ62f+2+oSV4DrXkXQhBtf4iaU0Eb+dU+frqDcuXsL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3LZcUjxWKQDM2gmNw4LsiDiZqN9kuF2EcJtjlg6VBsCgvOZPy
	2uQpsbuhoQaWiHYM9mhUThLKHGvrM2FKiidviyYcIZGixZvMc5Tn
X-Google-Smtp-Source: AGHT+IFGUKO5013Sb8JyGdP0f2V1TKX6TsoTcMpl4IW5QI8cJKrtpoajVcXdij2ZYEOxA9/r2P3PyA==
X-Received: by 2002:a05:600c:4f96:b0:42c:b22e:fc23 with SMTP id 5b1f17b1804b1-42f58439301mr48708085e9.15.1727531016260;
        Sat, 28 Sep 2024 06:43:36 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:a118:25f3:b27f:9f34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5730fc6sm4875210f8f.76.2024.09.28.06.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 06:43:35 -0700 (PDT)
Date: Sat, 28 Sep 2024 14:43:33 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	jannh@google.com, sroettger@google.com, linux-hardening@vger.kernel.org, 
	willy@infradead.org, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, merimus@google.com, 
	rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	enh@google.com
Subject: Re: [PATCH v1 1/1] mseal: update mseal.rst
Message-ID: <2q6hzkvep2g3z6m2jrwbw2j3sbydf6tgj2obwd6hgmm7xzgsg3@ddr5ghmsia5k>
References: <20240927185211.729207-1-jeffxu@chromium.org>
 <20240927185211.729207-2-jeffxu@chromium.org>
 <2vkppisejac42wnawjkd7qzyybuycu667yxwmsd4pfk5rwhiqc@gszyo5lu24ge>
 <CABi2SkU62r8bLCeitzVwAW-r7L8-Lfmy8Cp73DE2HaeLzUXVXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkU62r8bLCeitzVwAW-r7L8-Lfmy8Cp73DE2HaeLzUXVXQ@mail.gmail.com>

On Fri, Sep 27, 2024 at 06:29:30PM GMT, Jeff Xu wrote:
> Hi Pedro,
> 
> On Fri, Sep 27, 2024 at 3:59 PM Pedro Falcato <pedro.falcato@gmail.com> wrote:
<snip>
> > > +
> > > +   Blocked mm syscall:
> > > +      - munmap
> > > +      - mmap
> > > +      - mremap
> > > +      - mprotect and pkey_mprotect
> > > +      - some destructive madvise behaviors: MADV_DONTNEED, MADV_FREE,
> > > +        MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK
> > > +
> > > +   The first set of syscall to block is munmap, mremap, mmap. They can
> > > +   either leave an empty space in the address space, therefore allow
> > > +   replacement with a new mapping with new set of attributes, or can
> > > +   overwrite the existing mapping with another mapping.
> > > +
> > > +   mprotect and pkey_mprotect are blocked because they changes the
> >                                                           change
> > > +   protection bits (rwx) of the mapping.
> > > +
> > > +   Some destructive madvice behaviors (MADV_DONTNEED, MADV_FREE,
> > > +   MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK)
> > > +   for anonymous memory, when users don't have write permission to the
> > > +   memory. Those behaviors can alter region contents by discarding pages,
> > > +   effectively a memset(0) for anonymous memory.
> >
> > What's the difference between anonymous memory and MAP_PRIVATE | MAP_FILE?
> >
> MAP_FILE seems not used ?
> anonymous mapping is the mapping that is not backed by a file.

MAP_FILE is actually defined as 0 usually :) But I meant file-backed private mappings.

> > The feature now, as is (as far as I understand!) will allow you to do things like MADV_DONTNEED
> > on a read-only file mapping. e.g .text. This is obviously wrong?
> >
> When a MADV_DONTNEED is called, pages will be freed, on file-backed
> mapping,  if the process reads from the mapping again, the content
> will be retrieved from the file.
> 

Sorry, it was late and I gave you a crap example. Consider this:
a file-backed MAP_PRIVATE vma is marked RW. I write to it, then RO-it + mseal.

The attacker later gets me to MADV_DONTNEED that VMA. You've just lost data.

The big problem here is with anon _pages_, not anon vmas.

> For anonymous mapping, since  there is no file backup, if process
> reads from the mapping, 0 is filled, hence equivalent to memset(0)
> 
> > > +
> > > +   Kernel will return -EPERM for blocked syscalls.
> > > +
> > > +   When blocked syscall return -EPERM due to sealing, the memory regions may or may not be changed, depends on the syscall being blocked:
> > > +      - munmap: munmap is atomic. If one of VMAs in the given range is
> > > +        sealed, none of VMAs are updated.
> > > +      - mprotect, pkey_mprotect, madvise: partial update might happen, e.g.
> > > +        when mprotect over multiple VMAs, mprotect might update the beginning
> > > +        VMAs before reaching the sealed VMA and return -EPERM.
> > > +      - mmap and mremap: undefined behavior.
> >
> > mmap and mremap are actually not undefined as they use munmap semantics for their unmapping.
> > Whether this is something we'd want to document, I don't know honestly (nor do I think is ever written down in POSIX?)
> >
> I'm not sure if I can declare mmap/mremap as atomic.
> 
> Although, it might be possible to achieve this due to munmap being
> atomic. I'm not sure  as I didn't test this. Would you like to find
> out ?

I just told you they use munmap under the hood. It's just that the requirement isn't actually
written down anywhere.

> 
> > >
> > >  Use cases:
> > >  ==========
> > >  - glibc:
> > >    The dynamic linker, during loading ELF executables, can apply sealing to
> > > -  non-writable memory segments.
> > > +  mapping segments.
> > >
> > >  - Chrome browser: protect some security sensitive data-structures.
> > >
> > > -Notes on which memory to seal:
> > > -==============================
> > > -
> > > -It might be important to note that sealing changes the lifetime of a mapping,
> > > -i.e. the sealed mapping won’t be unmapped till the process terminates or the
> > > -exec system call is invoked. Applications can apply sealing to any virtual
> > > -memory region from userspace, but it is crucial to thoroughly analyze the
> > > -mapping's lifetime prior to apply the sealing.
> > > +Don't use mseal on:
> > > +===================
> > > +Applications can apply sealing to any virtual memory region from userspace,
> > > +but it is *crucial to thoroughly analyze the mapping's lifetime* prior to
> > > +apply the sealing. This is because the sealed mapping *won’t be unmapped*
> > > +till the process terminates or the exec system call is invoked.
> >
> > There should probably be a nice disclaimer as to how most people don't need this or shouldn't use this.
> > At least in its current form.
> >
> Ya, the mseal is not for most apps. I mention the malloc example to stress that.
> 
> > <snip>
> > > -
> > > -
> > > -Additional notes:
> > > -=================
> > >  As Jann Horn pointed out in [3], there are still a few ways to write
> > > -to RO memory, which is, in a way, by design. Those cases are not covered
> > > -by mseal(). If applications want to block such cases, sandbox tools (such as
> > > -seccomp, LSM, etc) might be considered.
> > > +to RO memory, which is, in a way, by design. And those could be blocked
> > > +by different security measures.
> > >
> > >  Those cases are:
> > > -
> > > -- Write to read-only memory through /proc/self/mem interface.
> > > -- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> > > -- userfaultfd.
> > > +   - Write to read-only memory through /proc/self/mem interface (FOLL_FORCE).
> > > +   - Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> > > +   - userfaultfd.
> >
> > I don't understand how this is not a problem, but MADV_DONTNEED is.
> > To me it seems that what we have now is completely useless, because you can trivially
> > bypass it using /proc/self/mem, which is enabled on most Linux systems.
> >
> > Before you mention ChromeOS or Chrome, I don't care. Kernel features aren't designed
> > for Chrome. They need to work with every other distro and application as well.
> >
> > It seems to me that the most sensible change is blocking/somehow distinguishing between /proc/self/mem and
> > /proc/<pid>/mem (some other process) and ptrace. As in blocking /proc/self/mem but allowing the other FOLL_FORCE's
> > as the traditional UNIX permission model allows.
> >
> IMO, it is a matter of  Divide and Conquer.  In a nutshell, mseal only
> prevents VMA's certain attributes (such as prot bits) from changing.
> It doesn't mean to say that sealed RO memory is immutable. To achieve
> that, the system needs to apply multiple security measures.

No, it's a matter of providing a sane API without tons of edgecases. Making a VMA immutable should make a VMA
immutable, and not require you to provide a crap ton of other mechanisms in order to truly make it immutable.
If I call mseal, I expect it to be sealed, not "sealed except when it's not, lol".

You haven't been able to quite specify what semantics are desirable out of this whole thing. Making
prot flags "immutable" is completely worthless if you can simply write to a random pseudofile and
have it bypass the whole thing (where a write to /proc/self/mem is semantically equivalent to
mprotect RW + write + mprotect RO). Making the vma immutable is completely worthless
if I can simply wipe anon pages. There has to be some end goal here (make contents immutable?
make sure VMA protection can't be changed? both?) which seems to be unclear from the kernel mmap-side.

If you insist on providing half-baked APIs (and waving off any concerns), I'm sure this would've been better
implemented as a random bpf program for chrome. Maybe we could revert this whole thing and give eBPF one
or two bits of vma flags for their own uses :)

> 
> For writing to /proc/pid/mem, it can be disabled via [1].  SELINUX and
> Landlock can achieve the same protection too.

I'm not blocking /proc/pid/mem, and my distro doesn't run any of those security modules :/

-- 
Pedro

