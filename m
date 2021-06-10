Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C473A3143
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhFJQsM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 12:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231534AbhFJQsK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 12:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623343574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmjeoZP2Zk9cpGLWV8EkH2NTyjrRS5zlwXdTRFtjA7s=;
        b=BddZSZm+RypfUdxixOenAmsgn5VEsyCrySA43CWkVkYRd+0b0vwKDUMRLRqqiCy+4gvuOX
        +sMLiutE9f9QRUZnZPKDR/k5wuLqdpmjSuz498mjhe8yeUVRsPsp7cI6HA6y8czTsJm1dA
        mKtWhGDywG1is1wp+tsMZ2hPAtWG3ok=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-euvQeqi4OeuIgFOdAWUPsw-1; Thu, 10 Jun 2021 12:46:12 -0400
X-MC-Unique: euvQeqi4OeuIgFOdAWUPsw-1
Received: by mail-wm1-f72.google.com with SMTP id a19-20020a1c98130000b02901960b3b5621so1388284wme.8
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 09:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pmjeoZP2Zk9cpGLWV8EkH2NTyjrRS5zlwXdTRFtjA7s=;
        b=U8+Tw/fDIIX3no76oKhk7w3Fm2vwmMJeSzoZ75bZUdJRLY3cE7cPAQivE7uh15IYN3
         8FFnA6UhFisqlMTVBFx/Dc9dF8OmPn23s/xgqz8jxmVb5vjE4L78g0MqMsfD57yDWcUW
         d8hMZwO9JHVy2gHQw0V6XOaVM3Kf12Pd6aeuBlx59dgaN8H16nRZRlVUkHGhcyJAJJI+
         Nf5WYi+RwTP8Mypd+Oq/9OvOJ0n7Dj/SWPB2Uc7dlHRFZa2HhJxy2TgnqoKUF0FpWh8v
         X2tOsUYNJomcWsOg2NgRlXQ53SfA6NrKbq2uf3SIPqiVaapHEwqh84LmqGYGptiD6rjG
         JeUw==
X-Gm-Message-State: AOAM533Td10CqFHd9VirER53SjCzM4T8ojD6CfHitjqILqjuQarOqcIC
        x47Oqv4MlxsRFy5IPGJP5ZBsm/i1+jROMz7saNB5FfTTqeBvi4b8FoQh0lD4+C4gI5I4qvWwnnH
        jR0cfajq7OG0+Ri+CLHcZ5JcNOn2C
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr6611949wro.2.1623343571740;
        Thu, 10 Jun 2021 09:46:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUfMy73RUGQtVL6eMZ0HpF2pAlTGaxCKpwYBu5GL/GZakJJNUaPWWZRvrLtTVMobB7MLHKLQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr6611916wro.2.1623343571544;
        Thu, 10 Jun 2021 09:46:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id p6sm4266126wrf.51.2021.06.10.09.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 09:46:11 -0700 (PDT)
Subject: Re: [PATCH v7 0/4] KVM statistics data fd-based binary interface
To:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
References: <20210603211426.790093-1-jingzhangos@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <873a0398-09fc-0278-3f0c-884b73dad3aa@redhat.com>
Date:   Thu, 10 Jun 2021 18:46:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603211426.790093-1-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/06/21 23:14, Jing Zhang wrote:
> This patchset provides a file descriptor for every VM and VCPU to read
> KVM statistics data in binary format.
> It is meant to provide a lightweight, flexible, scalable and efficient
> lock-free solution for user space telemetry applications to pull the
> statistics data periodically for large scale systems. The pulling
> frequency could be as high as a few times per second.
> In this patchset, every statistics data are treated to have some
> attributes as below:
>    * architecture dependent or generic
>    * VM statistics data or VCPU statistics data
>    * type: cumulative, instantaneous,
>    * unit: none for simple counter, nanosecond, microsecond,
>      millisecond, second, Byte, KiByte, MiByte, GiByte. Clock Cycles
> Since no lock/synchronization is used, the consistency between all
> the statistics data is not guaranteed. That means not all statistics
> data are read out at the exact same time, since the statistics date
> are still being updated by KVM subsystems while they are read out.
> 
> ---
> 
> * v6 -> v7
>    - Improve file descriptor allocation function by Krish suggestion
>    - Use "generic stats" instead of "common stats" as Krish suggested
>    - Addressed some other nits from Krish and David Matlack
> 
> * v5 -> v6
>    - Use designated initializers for STATS_DESC
>    - Change KVM_STATS_SCALE... to KVM_STATS_BASE...
>    - Use a common function for kvm_[vm|vcpu]_stats_read
>    - Fix some documentation errors/missings
>    - Use TEST_ASSERT in selftest
>    - Use a common function for [vm|vcpu]_stats_test in selftest
> 
> * v4 -> v5
>    - Rebase to kvm/queue, commit a4345a7cecfb ("Merge tag
>      'kvmarm-fixes-5.13-1'")
>    - Change maximum stats name length to 48
>    - Replace VM_STATS_COMMON/VCPU_STATS_COMMON macros with stats
>      descriptor definition macros.
>    - Fixed some errors/warnings reported by checkpatch.pl
> 
> * v3 -> v4
>    - Rebase to kvm/queue, commit 9f242010c3b4 ("KVM: avoid "deadlock"
>      between install_new_memslots and MMU notifier")
>    - Use C-stype comments in the whole patch
>    - Fix wrong count for x86 VCPU stats descriptors
>    - Fix KVM stats data size counting and validity check in selftest
> 
> * v2 -> v3
>    - Rebase to kvm/queue, commit edf408f5257b ("KVM: avoid "deadlock"
>      between install_new_memslots and MMU notifier")
>    - Resolve some nitpicks about format
> 
> * v1 -> v2
>    - Use ARRAY_SIZE to count the number of stats descriptors
>    - Fix missing `size` field initialization in macro STATS_DESC
> 
> [1] https://lore.kernel.org/kvm/20210402224359.2297157-1-jingzhangos@google.com
> [2] https://lore.kernel.org/kvm/20210415151741.1607806-1-jingzhangos@google.com
> [3] https://lore.kernel.org/kvm/20210423181727.596466-1-jingzhangos@google.com
> [4] https://lore.kernel.org/kvm/20210429203740.1935629-1-jingzhangos@google.com
> [5] https://lore.kernel.org/kvm/20210517145314.157626-1-jingzhangos@google.com
> [6] https://lore.kernel.org/kvm/20210524151828.4113777-1-jingzhangos@google.com
> 
> ---
> 
> Jing Zhang (4):
>    KVM: stats: Separate generic stats from architecture specific ones
>    KVM: stats: Add fd-based API to read binary stats data
>    KVM: stats: Add documentation for statistics data binary interface
>    KVM: selftests: Add selftest for KVM statistics data binary interface
> 
>   Documentation/virt/kvm/api.rst                | 180 +++++++++++++++
>   arch/arm64/include/asm/kvm_host.h             |   9 +-
>   arch/arm64/kvm/guest.c                        |  38 +++-
>   arch/mips/include/asm/kvm_host.h              |   9 +-
>   arch/mips/kvm/mips.c                          |  64 +++++-
>   arch/powerpc/include/asm/kvm_host.h           |   9 +-
>   arch/powerpc/kvm/book3s.c                     |  64 +++++-
>   arch/powerpc/kvm/book3s_hv.c                  |  12 +-
>   arch/powerpc/kvm/book3s_pr.c                  |   2 +-
>   arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
>   arch/powerpc/kvm/booke.c                      |  59 ++++-
>   arch/s390/include/asm/kvm_host.h              |   9 +-
>   arch/s390/kvm/kvm-s390.c                      | 129 ++++++++++-
>   arch/x86/include/asm/kvm_host.h               |   9 +-
>   arch/x86/kvm/x86.c                            |  67 +++++-
>   include/linux/kvm_host.h                      | 141 +++++++++++-
>   include/linux/kvm_types.h                     |  12 +
>   include/uapi/linux/kvm.h                      |  50 ++++
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   3 +
>   .../testing/selftests/kvm/include/kvm_util.h  |   3 +
>   .../selftests/kvm/kvm_binary_stats_test.c     | 215 ++++++++++++++++++
>   tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
>   virt/kvm/kvm_main.c                           | 169 +++++++++++++-
>   24 files changed, 1178 insertions(+), 90 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/kvm_binary_stats_test.c
> 
> 
> base-commit: a4345a7cecfb91ae78cd43d26b0c6a956420761a
> 

I had a few remarks, but it looks very nice overall.

Thanks!

Paolo

