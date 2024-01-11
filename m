Return-Path: <linux-kselftest+bounces-2822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EFB82A662
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 04:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402F11C22CF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 03:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C603DEBF;
	Thu, 11 Jan 2024 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CJUMkKgF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27570EBB;
	Thu, 11 Jan 2024 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+bgLMnAh3AxE4ybjtwDAdb2BasfGFtXoxAbLC+24rwE=; b=CJUMkKgFvD4rF5Swuljph5wfy+
	EInSctdIFvLm10RLh1n/isb9Pccw1hhCs2p99KgHtpGLB59QgXw1RlZq+hmhdMILe+UfI8CtRXXqR
	A7U3C6EUtyiezAm9BdJUBQBniawzaqE+HzAUFYsd8FCwitTz0AYPxW7hErzQ+zG76jU9mZHdeBwNj
	LqPI2GPI7+3SQe9IvAXDy61b0Fi1M7YHoCGfbHx4vEQeDqKSqOcuB+InV0hpxj3EpdyRXuItZYgon
	39Irm/omrsImOnOlP8+8XzRpqsp0Nr58daPvIHehBE5Q9O4MclE4O3UxjG65qwupGel7ls6BPkgMj
	9z/Z+RSg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNlYY-00Fadl-3B;
	Thu, 11 Jan 2024 03:16:35 +0000
Message-ID: <e580030f-9d2e-485c-b62e-ada59f639ef7@infradead.org>
Date: Wed, 10 Jan 2024 19:16:34 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 4/4] mseal:add documentation
Content-Language: en-US
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
 jannh@google.com, sroettger@google.com, willy@infradead.org,
 gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
 usama.anjum@collabora.com
Cc: jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240109154547.1839886-1-jeffxu@chromium.org>
 <20240109154547.1839886-5-jeffxu@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240109154547.1839886-5-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/9/24 07:45, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add documentation for mseal().
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  Documentation/userspace-api/mseal.rst | 181 ++++++++++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 Documentation/userspace-api/mseal.rst
> 
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> new file mode 100644
> index 000000000000..1700ce5af218
> --- /dev/null
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -0,0 +1,181 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Introduction of mseal
> +=====================
> +
> +:Author: Jeff Xu <jeffxu@chromium.org>
> +
> +Modern CPUs support memory permissions such as RW and NX bits. The memory
> +permission feature improves security stance on memory corruption bugs, i.e.
> +the attacker can’t just write to arbitrary memory and point the code to it,
> +the memory has to be marked with X bit, or else an exception will happen.
> +
> +Memory sealing additionally protects the mapping itself against
> +modifications. This is useful to mitigate memory corruption issues where a
> +corrupted pointer is passed to a memory management system. For example,
> +such an attacker primitive can break control-flow integrity guarantees
> +since read-only memory that is supposed to be trusted can become writable
> +or .text pages can get remapped. Memory sealing can automatically be
> +applied by the runtime loader to seal .text and .rodata pages and
> +applications can additionally seal security critical data at runtime.
> +
> +A similar feature already exists in the XNU kernel with the
> +VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall [2].
> +
> +User API
> +========
> +Two system calls are involved in virtual memory sealing, mseal() and mmap().
> +
> +mseal()
> +-----------
> +The mseal() syscall has following signature:

                       has the following signature:

> +
> +``int mseal(void addr, size_t len, unsigned long flags)``
> +
> +**addr/len**: virtual memory address range.
> +
> +The address range set by ``addr``/``len`` must meet:
> +   - The start address must be in an allocated VMA.
> +   - The start address must be page aligned.
> +   - The end address (``addr`` + ``len``) must be in an allocated VMA.
> +   - no gap (unallocated memory) between start and end address.
> +
> +The ``len`` will be paged aligned implicitly by the kernel.
> +
> +**flags**: reserved for future use.
> +
> +**return values**:
> +
> +- ``0``: Success.
> +
> +- ``-EINVAL``:
> +    - Invalid input ``flags``.
> +    - The start address (``addr``) is not page aligned.
> +    - Address range (``addr`` + ``len``) overflow.
> +
> +- ``-ENOMEM``:
> +    - The start address (``addr``) is not allocated.
> +    - The end address (``addr`` + ``len``) is not allocated.
> +    - A gap (unallocated memory) between start and end address.
> +
> +- ``-EACCES``:
> +    - ``MAP_SEALABLE`` is not set during mmap().
> +
> +- ``-EPERM``:
> +    - sealing is supported only on 64 bit CPUs, 32-bit is not supported.

                                      64-bit

> +
> +- For above error cases, users can expect the given memory range is
> +  unmodified, i.e. no partial update.
> +
> +- There might be other internal errors/cases not listed here, e.g.
> +  error during merging/splitting VMAs, or the process reaching the max
> +  number of supported VMAs. In those cases, partial updates to the given
> +  memory range could happen. However, those cases shall be rare.

s/shall/should/
unless you are predicting the future.

> +
> +**Blocked operations after sealing**:
> +    Unmapping, moving to another location, and shrinking the size,
> +    via munmap() and mremap(), can leave an empty space, therefore
> +    can be replaced with a VMA with a new set of attributes.
> +
> +    Moving or expanding a different VMA into the current location,
> +    via mremap().
> +
> +    Modifying a VMA via mmap(MAP_FIXED).
> +
> +    Size expansion, via mremap(), does not appear to pose any
> +    specific risks to sealed VMAs. It is included anyway because
> +    the use case is unclear. In any case, users can rely on
> +    merging to expand a sealed VMA.
> +
> +    mprotect() and pkey_mprotect().
> +
> +    Some destructive madvice() behaviors (e.g. MADV_DONTNEED)
> +    for anonymous memory, when users don't have write permission to the
> +    memory. Those behaviors can alter region contents by discarding pages,
> +    effectively a memset(0) for anonymous memory.
> +
> +**Note**:
> +
> +- mseal() only works on 64-bit CPUs, not 32-bit CPU.
> +
> +- users can call mseal() multiple times, mseal() on an already sealed memory
> +  is a no-action (not error).
> +
> +- munseal() is not supported.
> +
> +mmap()
> +----------
> +``void *mmap(void* addr, size_t length, int prot, int flags, int fd,
> +off_t offset);``
> +
> +We add two changes in ``prot`` and ``flags`` of  mmap() related to
> +memory sealing.
> +
> +**prot**
> +
> +The ``PROT_SEAL`` bit in ``prot`` field of mmap().
> +
> +When present, it marks the memory is sealed since creation.
> +
> +This is useful as optimization because it avoids having to make two
> +system calls: one for mmap() and one for mseal().
> +
> +It's worth noting that even though the sealing is set via the
> +``prot`` field in mmap(), it can't be set in the ``prot``
> +field in later mprotect(). This is unlike the ``PROT_READ``,
> +``PROT_WRITE``, ``PROT_EXEC`` bits, e.g. if ``PROT_WRITE`` is not set in
> +mprotect(), it means that the region is not writable.
> +
> +Setting ``PROT_SEAL`` implies setting ``MAP_SEALABLE`` below.
> +
> +**flags**
> +
> +The ``MAP_SEALABLE`` bit in the ``flags`` field of mmap().
> +
> +When present, it marks the map as sealable. A map created
> +without ``MAP_SEALABLE`` will not support sealing; In other words,

                                             sealing. In

> +mseal() will fail for such a map.
> +
> +
> +Applications that don't care about sealing will expect their
> +behavior unchanged. For those that need sealing support, opt-in

                                                            opt in

> +by adding ``MAP_SEALABLE`` in mmap().
> +
> +Note: for a map created without ``MAP_SEALABLE`` or a map created
> +with ``MAP_SEALABLE`` but not sealed yet, mmap(MAP_FIXED) can
> +change the sealable or sealing bit.
> +
> +Use Case:
> +=========
> +- glibc:
> +  The dynamic linker, during loading ELF executables, can apply sealing to
> +  non-writable memory segments.
> +
> +- Chrome browser: protect some security sensitive data-structures.
> +
> +Additional notes:
> +=================
> +As Jann Horn pointed out in [3], there are still a few ways to write
> +to RO memory, which is, in a way, by design. Those cases are not covered
> +by mseal(). If applications want to block such cases, sandbox tools (such as
> +seccomp, LSM, etc) might be considered.
> +
> +Those cases are:
> +
> +- Write to read-only memory through /proc/self/mem interface.
> +- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> +- userfaultfd.
> +
> +The idea that inspired this patch comes from Stephen Röttger’s work in V8
> +CFI [4]. Chrome browser in ChromeOS will be the first user of this API.
> +
> +Reference:
> +==========
> +[1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
> +
> +[2] https://man.openbsd.org/mimmutable.2
> +
> +[3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com
> +
> +[4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc

-- 
#Randy

