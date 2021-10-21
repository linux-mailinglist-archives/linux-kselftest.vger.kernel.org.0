Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DCD43684E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 18:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhJUQuq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 12:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231520AbhJUQuq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 12:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634834909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VCfninvKWV47Xsp5RP9uGNnQM9wSoQBnNs6aRe8wJDY=;
        b=TNNv8OEAK0ywbmQsRdJ68Km2fOXoAcbFYdWDP49DWxkQiEaswkqChlFEDbU27qltVwH94R
        ytdkCdFPrHiN98AL0DF2XtaQ2Pb//s4AvGDQmBjuhwmrnwR1VGjSLCXBIW1tXcTlAdQo0A
        TDQKCqtWp52lEZKVFIj4U+DbVKdkje0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-LHg_tKapOMyso1AHxRDqtQ-1; Thu, 21 Oct 2021 12:48:28 -0400
X-MC-Unique: LHg_tKapOMyso1AHxRDqtQ-1
Received: by mail-ed1-f70.google.com with SMTP id s12-20020a50dacc000000b003dbf7a78e88so1006238edj.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 09:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VCfninvKWV47Xsp5RP9uGNnQM9wSoQBnNs6aRe8wJDY=;
        b=HnAZHWDgHp1Q9N5JBqDtsmaA+Eh4g6a3IQqxp8cQ1NkVqYwcnH7/eXF8feBnUAJ1Cy
         aAcWsn5WTHXQVP7DW7F7ECGg7P94w1hnnItp+nccSkSAMNtP59eveb6oQ4f+Ud94nuys
         B/+p2ZxAghNzNRPwZbeMF2V4cWeY76lh7+mk2mC/JBUDWQi+af2GceOD+HHTiUnBUkgf
         V3g1Lx/Koz7OlAbe2REdioMpyOoC5Ba6a+iKYGBB/sqf/Ao+5erQWHjSw82344uZ5Gg+
         Z0bG8imw2XIAQs7jEiU+Zp9dVomMAhOdqyQDKX7mg8DdYoYgM5/7mcS665zIit2s6e6t
         JbfQ==
X-Gm-Message-State: AOAM531sUEaX+UoDOOw7SOdLddktkEPufDBRi3KA+S3DJCc5V5Adn7dp
        lsY1w0JoBbjuk7R6j18YFghUSaIKprM5GHU9EFv7iLo8f8n6AScKbbwTisiV58dL/pcFmUa6hlX
        ZhZSsD41DOvlhuvCMAGNwpVLJynuh
X-Received: by 2002:a05:6402:1d49:: with SMTP id dz9mr8906080edb.55.1634834907135;
        Thu, 21 Oct 2021 09:48:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfUh/gwLHsLAnloHareVcoBblGeHhzpVkYSFaPuXfPlmJE71AfB3siwZaeIXtqnPns26Vmdw==
X-Received: by 2002:a05:6402:1d49:: with SMTP id dz9mr8906052edb.55.1634834906943;
        Thu, 21 Oct 2021 09:48:26 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id b2sm3206364edv.73.2021.10.21.09.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 09:48:26 -0700 (PDT)
Message-ID: <71547952-c3e7-6683-5eea-70d3003d5224@redhat.com>
Date:   Thu, 21 Oct 2021 18:48:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC 00/16] KVM: selftests: Add tests for SEV, SEV-ES, and
 SEV-SNP guests
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
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/10/21 01:44, Michael Roth wrote:
> These patches and are also available at:
> 
>    https://github.com/mdroth/linux/commits/sev-selftests-rfc1
> 
> They are based on top of v5 of Brijesh's SEV-SNP hypervisor patches[1]
> to allow for SEV-SNP testing and provide some context for the overall
> design, but the SEV/SEV-ES patches can be carved out into a separate
> series as needed.
> 
> == OVERVIEW ==
> 
> This series introduces a set of memory encryption-related parameter/hooks
> in the core kselftest library, then uses the hooks to implement a small
> library for creating/managing SEV, SEV-ES, SEV-SNP guests. This library
> is then used to implement a basic boot/memory test that's run for all
> variants of SEV/SEV-ES/SEV-SNP guest types, as well as a set of SEV-SNP
> tests that cover various permutations of pvalidate/page-state changes.
> 
> - Patches 1-7 implement SEV boot tests and should run against existing
>    kernels
> - Patch 8 is a KVM changes that's required to allow SEV-ES/SEV-SNP
>    guests to boot with an externally generated page table, and is a
>    host kernel prequisite for the remaining patches in the series.
> - Patches 9-12 extend the boot tests to cover SEV-ES
> - Patches 13-16 extend the boot testst to cover SEV-SNP, and introduce
>    an additional test for page-state changes.

Hi Mike,

this SEV/SEV-ES testing (both your series and kvm-unit-tests) is good 
stuff. :)  If you fix up patches 1-12, I will commit them pretty much 
straight away.  The only thing that possibly needs some thought is the 
integration with ucall.

Thanks,

Paolo

> Any review/comments are greatly appreciated!
> 
> [1] https://lore.kernel.org/linux-mm/20210820155918.7518-1-brijesh.singh@amd.com/
> 
> ----------------------------------------------------------------
> Michael Roth (16):
>        KVM: selftests: move vm_phy_pages_alloc() earlier in file
>        KVM: selftests: add hooks for managing encrypted guest memory
>        KVM: selftests: handle encryption bits in page tables
>        KVM: selftests: set CPUID before setting sregs in vcpu creation
>        KVM: selftests: add support for encrypted vm_vaddr_* allocations
>        KVM: selftests: add library for creating/interacting with SEV guests
>        KVM: selftests: add SEV boot tests
>        KVM: SVM: include CR3 in initial VMSA state for SEV-ES guests
>        KVM: selftests: account for error code in #VC exception frame
>        KVM: selftests: add support for creating SEV-ES guests
>        KVM: selftests: add library for handling SEV-ES-related exits
>        KVM: selftests: add SEV-ES boot tests
>        KVM: selftests: add support for creating SEV-SNP guests
>        KVM: selftests: add helpers for SEV-SNP-related instructions/exits
>        KVM: selftests: add SEV-SNP boot tests
>        KVM: selftests: add SEV-SNP tests for page-state changes
> 
>   arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
>   arch/x86/include/asm/kvm_host.h                    |   1 +
>   arch/x86/kvm/svm/svm.c                             |  22 ++
>   arch/x86/kvm/vmx/vmx.c                             |   8 +
>   arch/x86/kvm/x86.c                                 |   3 +-
>   tools/testing/selftests/kvm/.gitignore             |   2 +
>   tools/testing/selftests/kvm/Makefile               |   3 +
>   tools/testing/selftests/kvm/include/kvm_util.h     |   8 +
>   tools/testing/selftests/kvm/include/x86_64/sev.h   |  70 ++++
>   .../selftests/kvm/include/x86_64/sev_exitlib.h     |  20 ++
>   tools/testing/selftests/kvm/include/x86_64/svm.h   |  35 ++
>   .../selftests/kvm/include/x86_64/svm_util.h        |   2 +
>   tools/testing/selftests/kvm/lib/kvm_util.c         | 249 +++++++++-----
>   .../testing/selftests/kvm/lib/kvm_util_internal.h  |  10 +
>   tools/testing/selftests/kvm/lib/x86_64/handlers.S  |   4 +-
>   tools/testing/selftests/kvm/lib/x86_64/processor.c |  30 +-
>   tools/testing/selftests/kvm/lib/x86_64/sev.c       | 381 +++++++++++++++++++++
>   .../testing/selftests/kvm/lib/x86_64/sev_exitlib.c | 326 ++++++++++++++++++
>   .../selftests/kvm/x86_64/sev_all_boot_test.c       | 367 ++++++++++++++++++++
>   .../selftests/kvm/x86_64/sev_snp_psc_test.c        | 378 ++++++++++++++++++++
>   20 files changed, 1820 insertions(+), 100 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
>   create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
>   create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
>   create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
>   create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
>   create mode 100644 tools/testing/selftests/kvm/x86_64/sev_snp_psc_test.c
> 
> 
> 

