Return-Path: <linux-kselftest+bounces-18522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6191988CAF
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 01:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76B51C212FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 23:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052BC1B81AB;
	Fri, 27 Sep 2024 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSnjCUBp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5751B7911;
	Fri, 27 Sep 2024 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727477973; cv=none; b=Scyk3c4WytB0V/KOPtm70GeIA0I8L8iy7uPdP0moV2+4YY0CwJr6MJKP8X8OREsGnCebW8FXdnN43Fwbz3NiPp7Dha01/x+aHqo1U6MZEBTg3ANwXoqIOZsJrG98mnJJt+M18MLcOM5b0v2lqQxqaFGBx5ZXrFPTr97yH1Cj5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727477973; c=relaxed/simple;
	bh=fC6QFHclwQcTErwq3sn+VS7dM4hMIf2pFtQ9r6i/1yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCzx3RFMbgRif3bTSS+IdFpCKE1tLTbqSYujd5V/Jdi5T6oSmnGn0VmOqR8tirpH45rSzGY9gDdfwIPZXXPG2GiZRgAVIvDNblE1BVK1MUp7lIp5stlj9/pFDjtixKxanRbcnhc1OjAK1C3AqVDFm+o4CA43iFm8XEh2jccCNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSnjCUBp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so22346515e9.0;
        Fri, 27 Sep 2024 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727477970; x=1728082770; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9IqvAfv1WChqsnSxf6qk/OUoO+gjURXmnUlf+mo6cUY=;
        b=XSnjCUBpN1SYRYoWHRarDvCqnYi6Ab44GGsKuZyWiLr2jltz+pAn/9x863jlW6iyi8
         nQfjf09wnBMLiUmuZKLaKS6ZxC44AE1viWldiDa3cpc93gCCmkJj1vANaHRxnwS+mBKM
         n1tyBZWYVEvKS34Jx9NhkrsqfscscMFc7txZ6/9/n3MZqRyJE4zrqSwnZNEGvXl5jdtB
         58xDz5ZnfvDLdMgZ8HaOJp00Vz4wvJKTUo/HzGC5CXXjlIpqQvjn1VW1VzmDJIRiIgNu
         9Yg7F6WWhAO98FO3v1FvuWBfh8V4rIRt0KxIMVsO1Z+sW6IP5/Bjlb9bKmgjglDD7ial
         N8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727477970; x=1728082770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IqvAfv1WChqsnSxf6qk/OUoO+gjURXmnUlf+mo6cUY=;
        b=UAlptxOETeb5egWsRSi2RQpsDEQZ4US+yVsg89O84EimyBJ3cRPQyAcF5lL60DAS8n
         Bj0W1KMahXKC4XsFwZ35vz+dr0GqgPtaB9qMU6obrs+tfuVR4ZO8o/9H4zMwiD3mw7tm
         VPJvqnx4znsAoywU+eBI6DvDTL6F2sDf2rbuSq4iw/ST9fzlIWOOFEDsGYDpoQRAUyDv
         2ZiwoBsuRh1cfdMEwFefy+ufoWEjshhmZzeejecwBkCVW/d4NDPar/tQvIHJvvqYjVW6
         sSogqmiEB3ZOea3dPhFhSuHn5yLRJmjBW5kcZvjW2yYIViNLjnq0fAKhkkj7lYrUpDBH
         fUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBrUTeihAKZN9tjLLnfereb7My0uBgL1pcohyFziM075HwZuAr1Xes3HTi5PL2ro0LfXRR+7IOypT7pO8L@vger.kernel.org, AJvYcCXW252a5Ql/GU6Bvh4ewH61/W6UCd3/jFxqNjZ48OBp8YxIzdymC1G9Pea+08GEGpKSObny6UejcKzAAMStb2Y=@vger.kernel.org, AJvYcCXoRelp2SyAzJD76wdIhynsDtLEFHgBEN+w0gqn12ZspO0BR90qGFI9i5bDxuhyzlSPFIlun0scH70LH5lLeusc@vger.kernel.org
X-Gm-Message-State: AOJu0YyKpOhcZcAmJVUNwho0QBwPi2kiUSumhGtXbpZbocJQLdUU25d8
	rU3yjM6EQxhYevRPnKdFLcWI+9gi+sLJ0vAqMURHGL7SlKsX4Zf/
X-Google-Smtp-Source: AGHT+IGXhQLBp+2IDSoNG/6a4mJ3jnJ1ET1yK4zMuulZ6WQEcJDYas3gjDFnxnMYDAzFnDSEVyIc9w==
X-Received: by 2002:a05:600c:46c5:b0:428:150e:4f13 with SMTP id 5b1f17b1804b1-42f5849c3b5mr35343625e9.33.1727477969641;
        Fri, 27 Sep 2024 15:59:29 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:a118:25f3:b27f:9f34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm3522902f8f.50.2024.09.27.15.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 15:59:28 -0700 (PDT)
Date: Fri, 27 Sep 2024 23:59:25 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	jannh@google.com, sroettger@google.com, linux-hardening@vger.kernel.org, 
	willy@infradead.org, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, merimus@google.com, 
	rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	enh@google.com
Subject: Re: [PATCH v1 1/1] mseal: update mseal.rst
Message-ID: <2vkppisejac42wnawjkd7qzyybuycu667yxwmsd4pfk5rwhiqc@gszyo5lu24ge>
References: <20240927185211.729207-1-jeffxu@chromium.org>
 <20240927185211.729207-2-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240927185211.729207-2-jeffxu@chromium.org>

On Fri, Sep 27, 2024 at 06:52:09PM GMT, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Update doc after in-loop change: mprotect/madvise can have
> partially updated and munmap is atomic.
> 
> Fix indentation and clarify some sections to improve readability.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  Documentation/userspace-api/mseal.rst | 290 ++++++++++++--------------
>  1 file changed, 136 insertions(+), 154 deletions(-)
> 
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> index 4132eec995a3..68986084e191 100644
> --- a/Documentation/userspace-api/mseal.rst
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -23,177 +23,159 @@ applications can additionally seal security critical data at runtime.
>  A similar feature already exists in the XNU kernel with the
>  VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall [2].
>  
> -User API
> -========
> -mseal()
> ------------
> -The mseal() syscall has the following signature:
> -
> -``int mseal(void addr, size_t len, unsigned long flags)``
> -
> -**addr/len**: virtual memory address range.
> -
> -The address range set by ``addr``/``len`` must meet:
> -   - The start address must be in an allocated VMA.
> -   - The start address must be page aligned.
> -   - The end address (``addr`` + ``len``) must be in an allocated VMA.
> -   - no gap (unallocated memory) between start and end address.
> -
> -The ``len`` will be paged aligned implicitly by the kernel.
> -
> -**flags**: reserved for future use.
> -
> -**return values**:
> -
> -- ``0``: Success.
> -
> -- ``-EINVAL``:
> -    - Invalid input ``flags``.
> -    - The start address (``addr``) is not page aligned.
> -    - Address range (``addr`` + ``len``) overflow.
> -
> -- ``-ENOMEM``:
> -    - The start address (``addr``) is not allocated.
> -    - The end address (``addr`` + ``len``) is not allocated.
> -    - A gap (unallocated memory) between start and end address.
> -
> -- ``-EPERM``:
> -    - sealing is supported only on 64-bit CPUs, 32-bit is not supported.
> -
> -- For above error cases, users can expect the given memory range is
> -  unmodified, i.e. no partial update.
> -
> -- There might be other internal errors/cases not listed here, e.g.
> -  error during merging/splitting VMAs, or the process reaching the max
> -  number of supported VMAs. In those cases, partial updates to the given
> -  memory range could happen. However, those cases should be rare.
> -
> -**Blocked operations after sealing**:
> -    Unmapping, moving to another location, and shrinking the size,
> -    via munmap() and mremap(), can leave an empty space, therefore
> -    can be replaced with a VMA with a new set of attributes.
> -
> -    Moving or expanding a different VMA into the current location,
> -    via mremap().
> -
> -    Modifying a VMA via mmap(MAP_FIXED).
> -
> -    Size expansion, via mremap(), does not appear to pose any
> -    specific risks to sealed VMAs. It is included anyway because
> -    the use case is unclear. In any case, users can rely on
> -    merging to expand a sealed VMA.
> -
> -    mprotect() and pkey_mprotect().
> -
> -    Some destructive madvice() behaviors (e.g. MADV_DONTNEED)
> -    for anonymous memory, when users don't have write permission to the
> -    memory. Those behaviors can alter region contents by discarding pages,
> -    effectively a memset(0) for anonymous memory.
> -
> -    Kernel will return -EPERM for blocked operations.
> -
> -    For blocked operations, one can expect the given address is unmodified,
> -    i.e. no partial update. Note, this is different from existing mm
> -    system call behaviors, where partial updates are made till an error is
> -    found and returned to userspace. To give an example:
> -
> -    Assume following code sequence:
> -
> -    - ptr = mmap(null, 8192, PROT_NONE);
> -    - munmap(ptr + 4096, 4096);
> -    - ret1 = mprotect(ptr, 8192, PROT_READ);
> -    - mseal(ptr, 4096);
> -    - ret2 = mprotect(ptr, 8192, PROT_NONE);
> -
> -    ret1 will be -ENOMEM, the page from ptr is updated to PROT_READ.
> -
> -    ret2 will be -EPERM, the page remains to be PROT_READ.
> -
> -**Note**:
> -
> -- mseal() only works on 64-bit CPUs, not 32-bit CPU.
> -
> -- users can call mseal() multiple times, mseal() on an already sealed memory
> -  is a no-action (not error).
> -
> -- munseal() is not supported.
> +SYSCALL
> +=======
> +mseal syscall signature
> +-----------------------
> +   **int** mseal(**void \*** addr, **size_t** len, **unsigned long** flags)
> +
> +   **addr**/**len**: virtual memory address range.
> +      The address range set by **addr**/**len** must meet:
> +         - The start address must be in an allocated VMA.
> +         - The start address must be page aligned.
> +         - The end address (**addr** + **len**) must be in an allocated VMA.
> +         - no gap (unallocated memory) between start and end address.
> +
> +      The ``len`` will be paged aligned implicitly by the kernel.
> +
> +   **flags**: reserved for future use.
> +
> +   **Return values**:
> +      - **0**: Success.
> +      - **-EINVAL**:
> +         * Invalid input ``flags``.
> +         * The start address (``addr``) is not page aligned.
> +         * Address range (``addr`` + ``len``) overflow.
> +      - **-ENOMEM**:
> +         * The start address (``addr``) is not allocated.
> +         * The end address (``addr`` + ``len``) is not allocated.
> +         * A gap (unallocated memory) between start and end address.
> +      - **-EPERM**:
> +         * sealing is supported only on 64-bit CPUs, 32-bit is not supported.
> +
> +   **Note about error return**:
> +      - For above error cases, users can expect the given memory range is
> +        unmodified, i.e. no partial update.
> +      - There might be other internal errors/cases not listed here, e.g.
> +        error during merging/splitting VMAs, or the process reaching the max
> +        number of supported VMAs. In those cases, partial updates to the given
> +        memory range could happen. However, those cases should be rare.

How about turning the above into a man page?

> +   **Architecture support**:
> +      mseal only works on 64-bit CPUs, not 32-bit CPU.
> +
> +   **Idempotent**:
> +      users can call mseal multiple times, mseal on an already sealed memory
> +      is a no-action (not error).
> +
> +   **no munseal**
> +      Once mapping is sealed, it can't be unsealed. kernel should never
> +      have munseal, this is consistent with other sealing feature, e.g.
> +      F_SEAL_SEAL for file.
> +
> +Blocked mm syscall for sealed mapping
> +-------------------------------------
> +   It might be imporant to note: **once the mapping is sealed, it will
> +   stay in the process's memory till the process terminates**.
> +
> +   Example::
> +
> +         *ptr = mmap(0, 4096, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
> +         rc = mseal(ptr, 4096, 0);
> +         /* munmap will fail */
> +         rc = munmap(ptr, 4096);
> +         assert(rc < 0);
> +
> +   Blocked mm syscall:
> +      - munmap
> +      - mmap
> +      - mremap
> +      - mprotect and pkey_mprotect
> +      - some destructive madvise behaviors: MADV_DONTNEED, MADV_FREE,
> +        MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK
> +
> +   The first set of syscall to block is munmap, mremap, mmap. They can
> +   either leave an empty space in the address space, therefore allow
> +   replacement with a new mapping with new set of attributes, or can
> +   overwrite the existing mapping with another mapping.
> +
> +   mprotect and pkey_mprotect are blocked because they changes the
                                                          change
> +   protection bits (rwx) of the mapping.
> +
> +   Some destructive madvice behaviors (MADV_DONTNEED, MADV_FREE,
> +   MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK)
> +   for anonymous memory, when users don't have write permission to the
> +   memory. Those behaviors can alter region contents by discarding pages,
> +   effectively a memset(0) for anonymous memory.

What's the difference between anonymous memory and MAP_PRIVATE | MAP_FILE?

The feature now, as is (as far as I understand!) will allow you to do things like MADV_DONTNEED
on a read-only file mapping. e.g .text. This is obviously wrong?

> +
> +   Kernel will return -EPERM for blocked syscalls.
> +
> +   When blocked syscall return -EPERM due to sealing, the memory regions may or may not be changed, depends on the syscall being blocked:
> +      - munmap: munmap is atomic. If one of VMAs in the given range is
> +        sealed, none of VMAs are updated.
> +      - mprotect, pkey_mprotect, madvise: partial update might happen, e.g.
> +        when mprotect over multiple VMAs, mprotect might update the beginning
> +        VMAs before reaching the sealed VMA and return -EPERM.
> +      - mmap and mremap: undefined behavior.

mmap and mremap are actually not undefined as they use munmap semantics for their unmapping.
Whether this is something we'd want to document, I don't know honestly (nor do I think is ever written down in POSIX?)

>  
>  Use cases:
>  ==========
>  - glibc:
>    The dynamic linker, during loading ELF executables, can apply sealing to
> -  non-writable memory segments.
> +  mapping segments.
>  
>  - Chrome browser: protect some security sensitive data-structures.
>  
> -Notes on which memory to seal:
> -==============================
> -
> -It might be important to note that sealing changes the lifetime of a mapping,
> -i.e. the sealed mapping won’t be unmapped till the process terminates or the
> -exec system call is invoked. Applications can apply sealing to any virtual
> -memory region from userspace, but it is crucial to thoroughly analyze the
> -mapping's lifetime prior to apply the sealing.
> +Don't use mseal on:
> +===================
> +Applications can apply sealing to any virtual memory region from userspace,
> +but it is *crucial to thoroughly analyze the mapping's lifetime* prior to
> +apply the sealing. This is because the sealed mapping *won’t be unmapped*
> +till the process terminates or the exec system call is invoked.

There should probably be a nice disclaimer as to how most people don't need this or shouldn't use this.
At least in its current form.

<snip>
> -
> -
> -Additional notes:
> -=================
>  As Jann Horn pointed out in [3], there are still a few ways to write
> -to RO memory, which is, in a way, by design. Those cases are not covered
> -by mseal(). If applications want to block such cases, sandbox tools (such as
> -seccomp, LSM, etc) might be considered.
> +to RO memory, which is, in a way, by design. And those could be blocked
> +by different security measures.
>  
>  Those cases are:
> -
> -- Write to read-only memory through /proc/self/mem interface.
> -- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> -- userfaultfd.
> +   - Write to read-only memory through /proc/self/mem interface (FOLL_FORCE).
> +   - Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> +   - userfaultfd.

I don't understand how this is not a problem, but MADV_DONTNEED is.
To me it seems that what we have now is completely useless, because you can trivially
bypass it using /proc/self/mem, which is enabled on most Linux systems.

Before you mention ChromeOS or Chrome, I don't care. Kernel features aren't designed
for Chrome. They need to work with every other distro and application as well.

It seems to me that the most sensible change is blocking/somehow distinguishing between /proc/self/mem and
/proc/<pid>/mem (some other process) and ptrace. As in blocking /proc/self/mem but allowing the other FOLL_FORCE's
as the traditional UNIX permission model allows.

-- 
Pedro

