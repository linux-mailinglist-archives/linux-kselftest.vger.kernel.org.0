Return-Path: <linux-kselftest+bounces-23968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD3A03465
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 02:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D071884C9C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 01:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FA278F2D;
	Tue,  7 Jan 2025 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4AvMqQm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E83BBC9
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Jan 2025 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736212474; cv=none; b=E26q3bd0U0IdGiFuA8mmZ5Z1zLO10VXrlP2dX8lfr36FriA4nYTWn4m8Gv8dIH+Jdwf1VGP1Joy3noeyg4BXz/TyE0pohZTlqDVQ+gqeDUcVJuPUwG99Jgn2vgTaC2Sprm8Ng0UOfsL/yukdCDxxKuDMioUh5Qja0sKGUUy0R4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736212474; c=relaxed/simple;
	bh=6e1NLLK2beIG2BdtdWq3Jgj4g4QgQ9Z/+KJFK0rPGZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZH697HQKD2Z9qOqJLz9TLLcZW3Bk1NNUmIheVn++MwyeQ0+R27y+phFg3y1/W/FmoRlZrrftVFXGADNpAryQVyNwNL+RGMmVQMJcKzb1ChcpxltBu81jAskfiZZyhGLVaDKgasSeXpTeGzr5urO3nWMEIRvhObetjWna5jj+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4AvMqQm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f6ca9a81so29995ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jan 2025 17:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736212471; x=1736817271; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BzoyiTnl2dGgB3AC2EtvvuiabfTLvmlZGP6Ip0Sd1Uk=;
        b=q4AvMqQmiWtydxUHWeB0L5Z2IqGEWjKJhC37VU/Uw+u3z+FMhWPMFpkNAsoliOzUTS
         RCe5Iwt3SEtVllLX3VkD8EPh+q5kl+pJOAuJEpg3I2W9rLALNEcrHdo5La5L8muKZZ06
         v+MIje0Q9Mf4D5jiKiGwk4Kk/HDIbR+rX+aVFs+wy0uE0V/Xg2GJocdSssoF51IC45MN
         6vUuhOLbqs/pbNdmF1yeX9BvLjvsPdQ6vTveKJ5GELJE8O1REcmBWccAhmhARVPmSQgU
         kKuiWkDjV+vShwi5Tpdn4ettlLAGnVjexqYRoKk/0YLV/OzRdQfaJ0hH2Ni9IfOdpkKA
         xF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736212471; x=1736817271;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzoyiTnl2dGgB3AC2EtvvuiabfTLvmlZGP6Ip0Sd1Uk=;
        b=Bj1hytqquhaOxJvK6cFZJlAkQM+F3GttFfiR2kswM+EcGmVzI02i6tkHy8byyVnS+F
         xa861Bh9fRmL2xI16nkgbe5dToEvQyHYHcmNL8SvBskSQ9i4gknBBO9+e3Jw+6wEvE3O
         yIXwfK2EdOAtHrZiYLS8VVqj7DIocJZrOLzKZgxNKL8JFyVGu/s+KxnEqD9YRa2keXIF
         r4YtMdO990q5arbur+3WI219CuUDDGZhxLONUFtCqLW3lE9UUjHQ643gam2zeM1Lo3pd
         EbG8M1Bb578aQnMUo+qtGXEIV7KOQNVtDW5AHa03QRMreQVWApALcbajSCqmAnQA7nsc
         OUYg==
X-Forwarded-Encrypted: i=1; AJvYcCWRD95Diwf029wLSFw+o/NpMHtVQAVgCFLgfAEcNo4TQNgcM5YrtesBaymPt1DC4iR4IlqyGM4yREFLkgHsm8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQTw7HEW/dL1qW0HklkQVqdzWcSjDpFd0xPHcIgfr7OLWAI84
	sSQuQgJKVCQ4Oq8pXLWKYDsQV3k046UnqtCUayY2bhy1b+o10gT77qVWVnsSBw==
X-Gm-Gg: ASbGncuuZmm3i/+PP1MhezLgkL01jiZD/LUrbD5TtiZ7QkDpte8g+riuMOHPf7SsYYw
	yttGFQfrY/OvMrjFoy5B7BtA1b8wL8T4THvpv5DJvuyGT2EqVHzhoBlmMB0X5VZx8oZkwTZK8Ou
	tiPBs8ReKN8RoMRhyR0cbHJd+pPwyNGX6CE2jv0lNQuCFi8Oe9A65T3EHX0IpIBqulCjbblK1St
	XrTWVBGhifz2rCOBw2D+2ZcDsDVwgTEXwQCvM3EjMT5On7SKrwo6IHy
X-Google-Smtp-Source: AGHT+IEwIMzkzFhlA3AzZSTu6im4YeBbAVEH1nsyS6HZ0dQae7xnIRKCzqUHYSrYjk/65jDcRZFlKw==
X-Received: by 2002:a17:902:e810:b0:216:21cb:2e06 with SMTP id d9443c01a7336-21a7bc2bcd9mr540405ad.19.1736212470822;
        Mon, 06 Jan 2025 17:14:30 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:42b3:1d33:ab4b:8279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbb70sm32176638b3a.98.2025.01.06.17.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 17:14:30 -0800 (PST)
Date: Mon, 6 Jan 2025 17:14:26 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Jann Horn <jannh@google.com>
Cc: lorenzo.stoakes@oracle.com, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, surenb@google.com,
	kaleshsingh@google.com, jstultz@google.com, aliceryhl@google.com,
	jeffxu@google.com, kees@kernel.org, kernel-team@android.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
Message-ID: <Z3x_8uFn2e0EpDqM@google.com>
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
 <20250102233255.1180524-2-isaacmanjarres@google.com>
 <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>

On Fri, Jan 03, 2025 at 04:03:44PM +0100, Jann Horn wrote:
> On Fri, Jan 3, 2025 at 12:32 AM Isaac J. Manjarres
> <isaacmanjarres@google.com> wrote:
> > Android currently uses the ashmem driver [1] for creating shared memory
> > regions between processes. Ashmem buffers can initially be mapped with
> > PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
> > ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
> > permissions that the buffer can be mapped with.
> >
> > Processes can remove the ability to map ashmem buffers as executable to
> > ensure that those buffers cannot be exploited to run unintended code.
> 
> Is there really code out there that first maps an ashmem buffer with
> PROT_EXEC, then uses the ioctl to remove execute permission for future
> mappings? I don't see why anyone would do that.

Hi Jann,

Thanks for your feedback and for taking the time to review these
patches!

Not that I'm aware of. The reason why I made this seal have semantics
where it prevents future executable mappings is because there are
existing applications that allocate an ashmem buffer (default
permissions are RWX), map the buffer as RW, and then restrict
the permissions to just R.

When the buffer is mapped as RW, do_mmap() unconditionally sets
VM_MAYEXEC on the VMA for the mapping, which means that the mapping
could later be mapped as executable via mprotect(). Therefore, having
the semantics of the seal be that it prevents any executable mappings
would break existing code that has already been released. It would
make transitioning clients to memfd difficult, because to amend that,
the ashmem users would have to first restrict the permissions of the
buffer to be RW, then map it as RW, and then restrict the permissions
again to be just R, which also means an additional system call.

> > For instance, suppose process A allocates a memfd that is meant to be
> > read and written by itself and another process, call it B.
> >
> > Process A shares the buffer with process B, but process B injects code
> > into the buffer, and compromises process A, such that it makes A map
> > the buffer with PROT_EXEC. This provides an opportunity for process A
> > to run the code that process B injected into the buffer.
> >
> > If process A had the ability to seal the buffer against future
> > executable mappings before sharing the buffer with process B, this
> > attack would not be possible.
> 
> I think if you want to enforce such restrictions in a scenario where
> the attacker can already make the target process perform
> semi-arbitrary syscalls, it would probably be more reliable to enforce
> rules on executable mappings with something like SELinux policy and/or
> F_SEAL_EXEC.
>

For SELinux policy, do you mean to not allow execmem permissions? What
about scenarios where a process wants to use JIT compilation, but
doesn't want memfd data buffers to be executable? My thought was to use
this new seal to have a finer granularity to control what buffers can
be mapped as executable. If not, could you please clarify?

Also, F_SEAL_EXEC just seals the memfd's current executable permissions,
and doesn't affect the mapping permissions at all. Are you saying that
F_SEAL_EXEC should be extended to cover mappings as well? If so, it is
not clear to me what the semantics of that would be.

For instance, if a memfd is non-executable and F_SEAL_EXEC is applied,
we can also prevent any executable mappings at that point. I'm not sure
if that's the right thing to do though. For instance, there are shared
object files that don't have executable permissions, but their code
sections should be mapped as executable. So, drawing from that, I'm not
sure if it makes sense to tie the file execution permissions to the
mapping permissions.

There's also the case where F_SEAL_EXEC is invoked on an executable
memfd. In that case, there doesn't seem to be anything to do from a
mapping perspective since memfds can be mapped as executable by
default?

> > Android is currently trying to replace ashmem with memfd. However, memfd
> > does not have a provision to permanently remove the ability to map a
> > buffer as executable, and leaves itself open to the type of attack
> > described earlier. However, this should be something that can be
> > achieved via a new file seal.
> >
> > There are known usecases (e.g. CursorWindow [2]) where a process
> > maps a buffer with read/write permissions before restricting the buffer
> > to being mapped as read-only for future mappings.
> 
> Here you're talking about write permission, but the patch is about
> execute permission?
> 

Sorry, I used this example about write permission to show why I implemented
the seal with support for preventing future mappings, since the writable
mappings that get created can become executable in the future, as
described later in the commit text.

> > The resulting VMA from the writable mapping has VM_MAYEXEC set, meaning
> > that mprotect() can change the mapping to be executable. Therefore,
> > implementing the seal similar to F_SEAL_WRITE would not be appropriate,
> > since it would not work with the CursorWindow usecase. This is because
> > the CursorWindow process restricts the mapping permissions to read-only
> > after the writable mapping is created. So, adding a file seal for
> > executable mappings that operates like F_SEAL_WRITE would fail.
> >
> > Therefore, add support for F_SEAL_FUTURE_EXEC, which is handled
> > similarly to F_SEAL_FUTURE_WRITE. This ensures that CursorWindow can
> > continue to create a writable mapping initially, and then restrict the
> > permissions on the buffer to be mappable as read-only by using both
> > F_SEAL_FUTURE_WRITE and F_SEAL_FUTURE_EXEC. After the seal is
> > applied, any calls to mmap() with PROT_EXEC will fail.
> >
> > [1] https://cs.android.com/android/kernel/superproject/+/common-android-mainline:common/drivers/staging/android/ashmem.c
> > [2] https://developer.android.com/reference/android/database/CursorWindow
> >
> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > ---
> >  include/uapi/linux/fcntl.h |  1 +
> >  mm/memfd.c                 | 39 +++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > index 6e6907e63bfc..ef066e524777 100644
> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -49,6 +49,7 @@
> >  #define F_SEAL_WRITE   0x0008  /* prevent writes */
> >  #define F_SEAL_FUTURE_WRITE    0x0010  /* prevent future writes while mapped */
> >  #define F_SEAL_EXEC    0x0020  /* prevent chmod modifying exec bits */
> > +#define F_SEAL_FUTURE_EXEC     0x0040 /* prevent future executable mappings */
> >  /* (1U << 31) is reserved for signed error codes */
> >
> >  /*
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 5f5a23c9051d..cfd62454df5e 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -184,6 +184,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
> >  }
> >
> >  #define F_ALL_SEALS (F_SEAL_SEAL | \
> > +                    F_SEAL_FUTURE_EXEC |\
> >                      F_SEAL_EXEC | \
> >                      F_SEAL_SHRINK | \
> >                      F_SEAL_GROW | \
> > @@ -357,14 +358,50 @@ static int check_write_seal(unsigned long *vm_flags_ptr)
> >         return 0;
> >  }
> >
> > +static inline bool is_exec_sealed(unsigned int seals)
> > +{
> > +       return seals & F_SEAL_FUTURE_EXEC;
> > +}
> > +
> > +static int check_exec_seal(unsigned long *vm_flags_ptr)
> > +{
> > +       unsigned long vm_flags = *vm_flags_ptr;
> > +       unsigned long mask = vm_flags & (VM_SHARED | VM_EXEC);
> > +
> > +       /* Executability is not a concern for private mappings. */
> > +       if (!(mask & VM_SHARED))
> > +               return 0;
> 
> Why is it not a concern for private mappings?
>
I didn't consider private mappings since it wasn't clear as to how
they could be a threat to another process. A process can copy the
contents of the buffer into another executable region of memory
and just run it from there? Or are you saying that because it
can do that, is there any value in differentiating between
shared and private mappings?

Thanks,
Isaac

