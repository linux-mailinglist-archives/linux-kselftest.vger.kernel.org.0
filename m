Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACCA2E21A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Dec 2020 21:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgLWUkK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Dec 2020 15:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgLWUkJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Dec 2020 15:40:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FCBC061794;
        Wed, 23 Dec 2020 12:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mYnRVo2UaFr9zFPBGbjYJ7pTSAghDBkk6o+o1KQqW4w=; b=cjqdwDP8RqHsTe+zifoiAzBU0d
        Ky2JbKMUtKBrHLrjNU1VXOaev6TvR5D6fwmKI6QJWvZ4hbyql+HVBJj/vkD0+kzodZisZgvoz8GVG
        YofQpVLSqy11/eIe1zff3Jk6LiYz+yKWDVXNhRDHrz9v33W/kOAyPtypLf/39FPtSA2qg/I7yONil
        uHJmMMwsbxdXhjxUm54wv5MgbJ84o+NNUrAy58nzfedugeu3QE5VrjIymodu+jOQHiSb8EOpoJ565
        cRV4FlWyEcnmZNFe48iCIuSTFtBZBcojTMkv98L96ls/Wb/84p6a/lMGfhN9WZxpoQesY8wB23Op4
        NtWjnlyQ==;
Received: from [2601:1c0:6280:3f0::64ea]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ksAun-0000oa-A7; Wed, 23 Dec 2020 20:39:21 +0000
Subject: Re: [PATCH V3 08/10] x86/pks: Add PKS kernel API
To:     ira.weiny@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20201106232908.364581-1-ira.weiny@intel.com>
 <20201106232908.364581-9-ira.weiny@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <092ec873-b023-4cd1-6301-30a2bcd3b54a@infradead.org>
Date:   Wed, 23 Dec 2020 12:39:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106232908.364581-9-ira.weiny@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/6/20 3:29 PM, ira.weiny@intel.com wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> PKS allows kernel users to define domains of page mappings which have
> additional protections beyond the paging protections.
> 
> Add an API to allocate, use, and free a protection key which identifies
> such a domain.  Export 5 new symbols pks_key_alloc(), pks_mknoaccess(),
> pks_mkread(), pks_mkrdwr(), and pks_key_free().  Add 2 new macros;
> PAGE_KERNEL_PKEY(key) and _PAGE_PKEY(pkey).
> 
> Update the protection key documentation to cover pkeys on supervisor
> pages.
> 
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> ---
> ---
>  Documentation/core-api/protection-keys.rst | 102 +++++++++++++---
>  arch/x86/include/asm/pgtable_types.h       |  12 ++
>  arch/x86/include/asm/pkeys.h               |  11 ++
>  arch/x86/include/asm/pkeys_common.h        |   4 +
>  arch/x86/mm/pkeys.c                        | 128 +++++++++++++++++++++
>  include/linux/pgtable.h                    |   4 +
>  include/linux/pkeys.h                      |  24 ++++
>  7 files changed, 267 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
> index ec575e72d0b2..c4e6c480562f 100644
> --- a/Documentation/core-api/protection-keys.rst
> +++ b/Documentation/core-api/protection-keys.rst
> @@ -4,25 +4,33 @@
>  Memory Protection Keys
>  ======================
>  
> -Memory Protection Keys for Userspace (PKU aka PKEYs) is a feature
> -which is found on Intel's Skylake (and later) "Scalable Processor"
> -Server CPUs. It will be available in future non-server Intel parts
> -and future AMD processors.
> -
> -For anyone wishing to test or use this feature, it is available in
> -Amazon's EC2 C5 instances and is known to work there using an Ubuntu
> -17.04 image.
> -
>  Memory Protection Keys provides a mechanism for enforcing page-based

                          provide

>  protections, but without requiring modification of the page tables
> -when an application changes protection domains.  It works by
> -dedicating 4 previously ignored bits in each page table entry to a
> -"protection key", giving 16 possible keys.
> +when an application changes protection domains.
> +
> +PKeys Userspace (PKU) is a feature which is found on Intel's Skylake "Scalable
> +Processor" Server CPUs and later.  And It will be available in future

                                          it

> +non-server Intel parts and future AMD processors.
> +
> +Future Intel processors will support Protection Keys for Supervisor pages
> +(PKS).
> +
> +For anyone wishing to test or use user space pkeys, it is available in Amazon's
> +EC2 C5 instances and is known to work there using an Ubuntu 17.04 image.
> +
> +pkeys work by dedicating 4 previously Reserved bits in each page table entry to
> +a "protection key", giving 16 possible keys.  User and Supervisor pages are
> +treated separately.
> +
> +Protections for each page are controlled with per CPU registers for each type

                                                 per-CPU
 
> +of page User and Supervisor.  Each of these 32 bit register stores two separate

                                               32-bit registers


> +bits (Access Disable and Write Disable) for each key.
>  
> -There is also a new user-accessible register (PKRU) with two separate
> -bits (Access Disable and Write Disable) for each key.  Being a CPU
> -register, PKRU is inherently thread-local, potentially giving each
> -thread a different set of protections from every other thread.
> +For Userspace the register is user-accessible (rdpkru/wrpkru).  For
> +Supervisor, the register (MSR_IA32_PKRS) is accessible only to the kernel.
> +
> +Being a CPU register, pkeys are inherently thread-local, potentially giving
> +each thread an independent set of protections from every other thread.
>  
>  There are two new instructions (RDPKRU/WRPKRU) for reading and writing
>  to the new register.  The feature is only available in 64-bit mode,
> @@ -30,8 +38,11 @@ even though there is theoretically space in the PAE PTEs.  These
>  permissions are enforced on data access only and have no effect on
>  instruction fetches.
>  
> -Syscalls
> -========
> +For kernel space rdmsr/wrmsr are used to access the kernel MSRs.
> +
> +
> +Syscalls for user space keys
> +============================
>  
>  There are 3 system calls which directly interact with pkeys::
>  
> @@ -98,3 +109,58 @@ with a read()::
>  The kernel will send a SIGSEGV in both cases, but si_code will be set
>  to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
>  the plain mprotect() permissions are violated.
> +
> +
> +Kernel API for PKS support
> +==========================
> +
> +The following interface is used to allocate, use, and free a pkey which defines
> +a 'protection domain' within the kernel.  Setting a pkey value in a supervisor
> +mapping adds that mapping to the protection domain.
> +
> +        int pks_key_alloc(const char * const pkey_user, int flags);
> +        #define PAGE_KERNEL_PKEY(pkey)
> +        #define _PAGE_KEY(pkey)
> +        void pks_mk_noaccess(int pkey);
> +        void pks_mk_readonly(int pkey);
> +        void pks_mk_readwrite(int pkey);
> +        void pks_key_free(int pkey);
> +
> +pks_key_alloc() allocates keys dynamically to allow better use of the limited
> +key space.  'flags' alter the allocation based on the users need.  Currently

                                                         user's
or maybe                                                 users'

> +they can request an exclusive key.
> +
> +Callers of pks_key_alloc() _must_ be prepared for it to fail and take
> +appropriate action.  This is due mainly to the fact that PKS may not be
> +available on all arch's.  Failure to check the return of pks_key_alloc() and
> +using any of the rest of the API is undefined.
> +
> +Kernel users must set the PTE permissions in the page table entries for the
> +mappings they want to protect.  This can be done with PAGE_KERNEL_PKEY() or
> +_PAGE_KEY().
> +
> +The pks_mk*() family of calls allows kernel users the ability to change the
> +protections for the domain identified by the pkey specified.  3 states are
> +available pks_mk_noaccess(), pks_mk_readonly(), and pks_mk_readwrite() which

   available:

> +set the access to none, read, and read/write respectively.
> +
> +Finally, pks_key_free() allows a user to return the key to the allocator for
> +use by others.
> +
> +The interface maintains pks_mk_noaccess() (Access Disabled (AD=1)) for all keys
> +not currently allocated.  Therefore, the user can depend on access being
> +disabled when pks_key_alloc() returns a key and the user should remove mappings
> +from the domain (remove the pkey from the PTE) prior to calling pks_key_free().
> +
> +It should be noted that the underlying WRMSR(MSR_IA32_PKRS) is not serializing
> +but still maintains ordering properties similar to WRPKRU.  Thus it is safe to
> +immediately use a mapping when the pks_mk*() functions returns.

                                                          return.

> +
> +The current SDM section on PKRS needs updating but should be the same as that
> +of WRPKRU.  So to quote from the WRPKRU text:
> +
> +	WRPKRU will never execute transiently. Memory accesses
> +	affected by PKRU register will not execute (even transiently)
> +	until all prior executions of WRPKRU have completed execution
> +	and updated the PKRU register.
> +


-- 
~Randy

