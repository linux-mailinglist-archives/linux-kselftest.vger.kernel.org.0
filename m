Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F6B414B7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Sep 2021 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhIVOOS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Sep 2021 10:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235927AbhIVOOO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Sep 2021 10:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632319964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZMdBUFCcEro44m/VYQjrdo8tgcAaj3vpqrRJk30Xe4=;
        b=AfPwWbF8yLhbvlx4DgIh/0v6SBEVJG8wr1TRBpKZz9hAUT7+td02E7C1DbrWdaQwPNMfLq
        YkYJORZmIpKPKtsTaskMCRnc2MC9vhPV3HIa79JkkQtPf5vgmxfDI2ZlD/1+Q6X+N1Andl
        7cCs11/Uek2WDmmT8VDNq2zCYNr75Mo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-3472CWghM32nnhTMbbqlOg-1; Wed, 22 Sep 2021 10:12:43 -0400
X-MC-Unique: 3472CWghM32nnhTMbbqlOg-1
Received: by mail-ed1-f69.google.com with SMTP id s12-20020a05640217cc00b003cde58450f1so3237877edy.9
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Sep 2021 07:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZMdBUFCcEro44m/VYQjrdo8tgcAaj3vpqrRJk30Xe4=;
        b=fUhcvL/6oD239v/dQ+1JTSYHBmHdWLBLu72Yg1elKmxvvJpiSaLYX8/UiKk06Qpmz9
         kL8b20+2gsjyC+aFRCw+bCUztYS2sseOnjgCoto0ukgCdIp6KwH/AMfawg49Xd34dR4Z
         r7rLsGJFrC9O4Dvta/fV04jcNK/eIN1ScXYV1bR7ZoMJ2T2Jk0Giej2H3Bdily2kPIKs
         oApeVAJhGcWbSb4saJ2KyMsFMvnbWY6flbY1wJB1wojmRWD1uPDMSU0vfZc99IeYTzXE
         +kWfXgM0gCxBUw7EJlFOrtxO/QSbIJCIW+CQdNDYQO7Ru5OXLoTpDBy8E+MxDP/CKZlq
         Ze5g==
X-Gm-Message-State: AOAM532ePuSN0V7M7u7wLMPJxWOsUIKDmNpzQB9FndhLiqi6jV8y29lN
        y8g0YyQmPEReM6sBdcgz+fIJ0Xi+jcge2/h739Z4IvFvPbnFM0QSrJADiEx03MA3q4bwCw6W5WS
        79JAAyGW7mtdf3qS3JfRttx2DU5xR
X-Received: by 2002:a17:906:b183:: with SMTP id w3mr41217058ejy.394.1632319961898;
        Wed, 22 Sep 2021 07:12:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDM/LAO92AMI8uC+ZsdL5tg3HWsAwfnbY471GXtr9Lv9ROvDMZHXi9azcQssuJ/zXZcmQ7Nw==
X-Received: by 2002:a17:906:b183:: with SMTP id w3mr41217031ejy.394.1632319961680;
        Wed, 22 Sep 2021 07:12:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n23sm393858edw.75.2021.09.22.07.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 07:12:41 -0700 (PDT)
Subject: Re: [PATCH 0/5] KVM: rseq: Fix and a test for a KVM+rseq bug
To:     Sean Christopherson <seanjc@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Ben Gardon <bgardon@google.com>
References: <20210818001210.4073390-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <430684f9-1b35-b6f1-f243-6298e892bc7a@redhat.com>
Date:   Wed, 22 Sep 2021 16:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818001210.4073390-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18/08/21 02:12, Sean Christopherson wrote:
> Patch 1 fixes a KVM+rseq bug where KVM's handling of TIF_NOTIFY_RESUME,
> e.g. for task migration, clears the flag without informing rseq and leads
> to stale data in userspace's rseq struct.
> 
> Patch 2 is a cleanup to try and make future bugs less likely.  It's also
> a baby step towards moving and renaming tracehook_notify_resume() since
> it has nothing to do with tracing.  It kills me to not do the move/rename
> as part of this series, but having a dedicated series/discussion seems
> more appropriate given the sheer number of architectures that call
> tracehook_notify_resume() and the lack of an obvious home for the code.
> 
> Patch 3 is a fix/cleanup to stop overriding x86's unistd_{32,64}.h when
> the include path (intentionally) omits tools' uapi headers.  KVM's
> selftests do exactly that so that they can pick up the uapi headers from
> the installed kernel headers, and still use various tools/ headers that
> mirror kernel code, e.g. linux/types.h.  This allows the new test in
> patch 4 to reference __NR_rseq without having to manually define it.
> 
> Patch 4 is a regression test for the KVM+rseq bug.
> 
> Patch 5 is a cleanup made possible by patch 3.
> 
> 
> Sean Christopherson (5):
>    KVM: rseq: Update rseq when processing NOTIFY_RESUME on xfer to KVM
>      guest
>    entry: rseq: Call rseq_handle_notify_resume() in
>      tracehook_notify_resume()
>    tools: Move x86 syscall number fallbacks to .../uapi/
>    KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration
>      bugs
>    KVM: selftests: Remove __NR_userfaultfd syscall fallback
> 
>   arch/arm/kernel/signal.c                      |   1 -
>   arch/arm64/kernel/signal.c                    |   1 -
>   arch/csky/kernel/signal.c                     |   4 +-
>   arch/mips/kernel/signal.c                     |   4 +-
>   arch/powerpc/kernel/signal.c                  |   4 +-
>   arch/s390/kernel/signal.c                     |   1 -
>   include/linux/tracehook.h                     |   2 +
>   kernel/entry/common.c                         |   4 +-
>   kernel/rseq.c                                 |   4 +-
>   .../x86/include/{ => uapi}/asm/unistd_32.h    |   0
>   .../x86/include/{ => uapi}/asm/unistd_64.h    |   3 -
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   3 +
>   tools/testing/selftests/kvm/rseq_test.c       | 131 ++++++++++++++++++
>   14 files changed, 143 insertions(+), 20 deletions(-)
>   rename tools/arch/x86/include/{ => uapi}/asm/unistd_32.h (100%)
>   rename tools/arch/x86/include/{ => uapi}/asm/unistd_64.h (83%)
>   create mode 100644 tools/testing/selftests/kvm/rseq_test.c
> 

Queued v3, thanks.  I'll send it in a separate pull request to Linus 
since it touches stuff outside my usual turf.

Thanks,

Paolo

