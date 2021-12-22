Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6730F47D400
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbhLVO4a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 09:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343604AbhLVO4a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 09:56:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D8C061574;
        Wed, 22 Dec 2021 06:56:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t18so5409224wrg.11;
        Wed, 22 Dec 2021 06:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3u3RS8pKBTYBzGogI28UHQILKjCVpBLQyl45kZM0zhk=;
        b=fe6qJajbJRl/wvwRcZmyhUcAqgr2ttAHTxwyFpYf/QBAFTjJHN/bbK8cIYDkX6oIsh
         2gQsZjHGtSfL23LKG0d7d96e9PjxIbV9vV6yKWD1dY4FpZfxYN4vtgowi4LJ5wwai0oJ
         YkGPeOOQM8qttQPMF0x0kyq5RFjbA3Mebi9nu+CiGLn6jwtzD2sjvYnp7z7xGmf1IvHV
         qdN7ndCjv4R1JxvOhrW/3Y3fOFd5xG2wI4DlWXEzcUte+qxW9/a7gXqfJMfWHMkfb0xb
         homS5FtNyt6K9gJNO7lGgvxz/WO5lunApeGuYBFIfY8Nkj5xSv1Yi2L07wq5W0+zxG3B
         b35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3u3RS8pKBTYBzGogI28UHQILKjCVpBLQyl45kZM0zhk=;
        b=oSdYH0IBr1Mqxnug9L1GOmv7ecDy5wfLzhuME0a7TVVJ98vvxN/+Z5aoFSd2sUqBVm
         4HRff2o08Bj2Qz4e4ly7GXWGPzCOaWmrcTj09OaoMYxRt6r5zWf/kSiEKD3HlMLz0FO6
         1XNpXvJLSz/qznZs0Eyz9lGd38+6jx9N3djhhOXKcxZGHqR+78QAcCjreC9eifNEUfoS
         LTGzi36JRsFpqQj/ILcdfQuoF35q+3gxjBdIJ6dSJXW2GF/IPmkYyw8jy1eKKuc8lhhy
         uaTPCz91Ap9sSmvnKucdmedlbE4XlNvJ9F409jxENs//BF30oV6gvFUwGM0p+bOnpqmi
         bi3A==
X-Gm-Message-State: AOAM5323Lj50/gOu7sUNhGgcwR9wDqAyIkq/7UTkVdAT7HUm8DzPpELW
        vOmOZxxqJ/bOwbbnNM4ZIOk=
X-Google-Smtp-Source: ABdhPJylvw68mCwkOkJoeR9QZAVv/bKz1n+rqaVG1VEoHfALmZjZmRZoZXqaUMcGXzuetdFg4/fuqw==
X-Received: by 2002:a5d:65d1:: with SMTP id e17mr2352731wrw.379.1640184988257;
        Wed, 22 Dec 2021 06:56:28 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312::4fa? ([2001:b07:6468:f312::4fa])
        by smtp.googlemail.com with ESMTPSA id h27sm5776473wmc.43.2021.12.22.06.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 06:56:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <c01b0592-9d7b-601d-035b-fa2c308690aa@redhat.com>
Date:   Wed, 22 Dec 2021 15:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 00/13] KVM: selftests: Add tests for SEV and SEV-ES
 guests
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211216171358.61140-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/16/21 18:13, Michael Roth wrote:
> These patches and are also available at:
> 
>    https://github.com/mdroth/linux/commits/sev-selftests-v2
> 
> They are based on top of the recent RFC:
> 
>    "KVM: selftests: Add support for test-selectable ucall implementations"
>    https://lore.kernel.org/all/20211210164620.11636-1-michael.roth@amd.com/T/
> 
>    https://github.com/mdroth/linux/commits/sev-selftests-ucall-rfc1
> 
> which provides a new ucall implementation that this series relies on.
> Those patches were in turn based on kvm/next as of 2021-12-10.

Looks good, apart from the cleanups that Peter pointed out in patch 7.

When you send the next version, you can keep it based on the same ucall 
RFC, even if I haven't yet pushed them (which I'll do only after testing 
on s390).

Thanks,

Paolo

> == OVERVIEW ==
> 
> This series introduces a set of memory encryption-related parameter/hooks
> in the core kselftest library, then uses the hooks to implement a small
> library for creating/managing SEV, SEV-ES, and (eventually) SEV-SNP guests.
> This library is then used to implement a basic boot/memory test that's run
> for variants of SEV/SEV-ES guests.
> 
> - Patches 1-8 implement SEV boot tests and should run against existing
>    kernels
> - Patch 9 is a KVM changes that's required to allow SEV-ES/SEV-SNP
>    guests to boot with an externally generated page table, and is a
>    host kernel prequisite for the remaining patches in the series.
> - Patches 10-13 extend the boot tests to cover SEV-ES
> 
> Any review/comments are greatly appreciated!
> 
> v2:
> - rebased on ucall_ops patchset (which is based on kvm/next 2021-12-10)
> - remove SEV-SNP support for now
> - provide encryption bitmap as const* to original rather than as a copy
>    (Mingwei, Paolo)
> - drop SEV-specific synchronization helpers in favor of ucall_ops_halt (Paolo)
> - don't pass around addresses with c-bit included, add them as-needed via
>    addr_gpa2raw() (e.g. when adding PTEs, or initializing initial
>    cr3/vm->pgd) (Paolo)
> - rename lib/sev.c functions for better consistency (Krish)
> - move more test setup code out of main test function and into
>    setup_test_common() (Krish)
> - suppress compiler warnings due to -Waddress-of-packed-member like kernel
>    does
> - don't require SNP support in minimum firmware version detection (Marc)
> - allow SEV device path to be configured via make SEV_PATH= (Marc)
> 
> ----------------------------------------------------------------
> Michael Roth (13):
>        KVM: selftests: move vm_phy_pages_alloc() earlier in file
>        KVM: selftests: sparsebit: add const where appropriate
>        KVM: selftests: add hooks for managing encrypted guest memory
>        KVM: selftests: handle encryption bits in page tables
>        KVM: selftests: add support for encrypted vm_vaddr_* allocations
>        KVM: selftests: ensure ucall_shared_alloc() allocates shared memory
>        KVM: selftests: add library for creating/interacting with SEV guests
>        KVM: selftests: add SEV boot tests
>        KVM: SVM: include CR3 in initial VMSA state for SEV-ES guests
>        KVM: selftests: account for error code in #VC exception frame
>        KVM: selftests: add support for creating SEV-ES guests
>        KVM: selftests: add library for handling SEV-ES-related exits
>        KVM: selftests: add SEV-ES boot tests
> 
>   arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
>   arch/x86/include/asm/kvm_host.h                    |   1 +
>   arch/x86/kvm/svm/svm.c                             |  19 ++
>   arch/x86/kvm/vmx/vmx.c                             |   6 +
>   arch/x86/kvm/x86.c                                 |   1 +
>   tools/testing/selftests/kvm/.gitignore             |   1 +
>   tools/testing/selftests/kvm/Makefile               |  10 +-
>   .../testing/selftests/kvm/include/kvm_util_base.h  |  10 +
>   tools/testing/selftests/kvm/include/sparsebit.h    |  36 +--
>   tools/testing/selftests/kvm/include/x86_64/sev.h   |  44 +++
>   .../selftests/kvm/include/x86_64/sev_exitlib.h     |  14 +
>   tools/testing/selftests/kvm/include/x86_64/svm.h   |  35 +++
>   .../selftests/kvm/include/x86_64/svm_util.h        |   1 +
>   tools/testing/selftests/kvm/lib/kvm_util.c         | 270 ++++++++++++------
>   .../testing/selftests/kvm/lib/kvm_util_internal.h  |  10 +
>   tools/testing/selftests/kvm/lib/sparsebit.c        |  48 ++--
>   tools/testing/selftests/kvm/lib/ucall_common.c     |   4 +-
>   tools/testing/selftests/kvm/lib/x86_64/handlers.S  |   4 +-
>   tools/testing/selftests/kvm/lib/x86_64/processor.c |  16 +-
>   tools/testing/selftests/kvm/lib/x86_64/sev.c       | 252 ++++++++++++++++
>   .../testing/selftests/kvm/lib/x86_64/sev_exitlib.c | 249 ++++++++++++++++
>   .../selftests/kvm/x86_64/sev_all_boot_test.c       | 316 +++++++++++++++++++++
>   22 files changed, 1215 insertions(+), 133 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
>   create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
>   create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
>   create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
>   create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> 
> 

