Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789913839BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 May 2021 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbhEQQZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 May 2021 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344348AbhEQQZq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 May 2021 12:25:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EEEC030CFE
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 07:55:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f12so7641424ljp.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QUe8DOeGFSdZ193LBrJppmyu5E2kuzgS0SpFBXrhdow=;
        b=U7wtNIdm28GJ8gwv7rj2npD297B+CJPksgybK+hTA7W8lHEhapKJxMIG5HQ3HNjXTg
         rWb17bnmwUibfb6rDGPoRpsUcTBKgheHmdEsYQPVx7KYwyYWUJ/UNRkKfjb9d5ibFSFt
         v0Ow6tYwRBxOkRkqYu/DG4+zFO+zy6inj96rgHrhP8QNsj4HQXzBUbFw/rjoY9+IIM+C
         OhujAr86N4O2dvGqUDJI0zXBe8E1N459vTzNZ6MB6PKR1p/o3iIaEdbHCI2e1Ze+ICqd
         +af/XXK+6g5EVl721j8io2s5td6Cu6Uh4DS/OUMJSH13vFDYn9PvexXNAac5d0rx2akL
         Bijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QUe8DOeGFSdZ193LBrJppmyu5E2kuzgS0SpFBXrhdow=;
        b=dvMSbx2u8WV4MgTSL87WjL4zNhqIFJL2lE5aa0tVEQAKAGT3HfjV4+wEEghM6reQAk
         sYS1f8TdNxxeCiWo38tjHJWgMz9b8bBNk+v0EWgGp7m+IVUi3LzegzG7tWB3GYgjMW5C
         Pk0wMRPzTex9u/Nowm1nYsc56gdm2ZZnZLiIkBKF+HcuBeknXdqnu7vIuJUKkg5RlwFf
         /sDVFV0lZ/ewsuNxmz+Rg+wE7Jh+GaX9zhFbl+mBh0gqLd2DKOMxiGTDkDaVL2+HAuk1
         pPvnSAievVHOjqRfWIHtwTZ5n0gOyktie0epyclecFlcFIXVC9K2a04SxGwGpRu2Ldfi
         ovEQ==
X-Gm-Message-State: AOAM533D4iHg9QkHy9O6nouviu08fFyVEx902AQvVHCcRebd62OCdt5M
        mpcVd2doJhsKVgvbywpeNHcey8Wy4VGBYHdIk0is7Q==
X-Google-Smtp-Source: ABdhPJyyt3vMBNkKRAxRLZE9D6Z3kkpMMjxSYVr0MStibqeH5eOvyHWZ8uTTaM8cQ8iiN2h4w0DZq9BBNo0X0WVeHiI=
X-Received: by 2002:a05:651c:1251:: with SMTP id h17mr50489673ljh.215.1621263336866;
 Mon, 17 May 2021 07:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210517145314.157626-1-jingzhangos@google.com>
In-Reply-To: <20210517145314.157626-1-jingzhangos@google.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Mon, 17 May 2021 09:55:25 -0500
Message-ID: <CAAdAUtixWdpFvY1Vq5e+VqoFjZ9xoTyb0gi4MD9=u8rMj4NEJQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] KVM statistics data fd-based binary interface
To:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paolo,

On Mon, May 17, 2021 at 9:53 AM Jing Zhang <jingzhangos@google.com> wrote:
>
> This patchset provides a file descriptor for every VM and VCPU to read
> KVM statistics data in binary format.
> It is meant to provide a lightweight, flexible, scalable and efficient
> lock-free solution for user space telemetry applications to pull the
> statistics data periodically for large scale systems. The pulling
> frequency could be as high as a few times per second.
> In this patchset, every statistics data are treated to have some
> attributes as below:
>   * architecture dependent or common
>   * VM statistics data or VCPU statistics data
>   * type: cumulative, instantaneous,
>   * unit: none for simple counter, nanosecond, microsecond,
>     millisecond, second, Byte, KiByte, MiByte, GiByte. Clock Cycles
> Since no lock/synchronization is used, the consistency between all
> the statistics data is not guaranteed. That means not all statistics
> data are read out at the exact same time, since the statistics date
> are still being updated by KVM subsystems while they are read out.
>
> ---
>
> * v4 -> v5
>   - Rebase to kvm/queue, commit a4345a7cecfb ("Merge tag
>     'kvmarm-fixes-5.13-1'")
>   - Change maximum stats name length to 48
>   - Replace VM_STATS_COMMON/VCPU_STATS_COMMON macros with stats
>     descriptor definition macros.
>   - Fixed some errors/warnings reported by checkpatch.pl
>
> * v3 -> v4
>   - Rebase to kvm/queue, commit 9f242010c3b4 ("KVM: avoid "deadlock"
>     between install_new_memslots and MMU notifier")
>   - Use C-stype comments in the whole patch
>   - Fix wrong count for x86 VCPU stats descriptors
>   - Fix KVM stats data size counting and validity check in selftest
>
> * v2 -> v3
>   - Rebase to kvm/queue, commit edf408f5257b ("KVM: avoid "deadlock"
>     between install_new_memslots and MMU notifier")
>   - Resolve some nitpicks about format
>
> * v1 -> v2
>   - Use ARRAY_SIZE to count the number of stats descriptors
>   - Fix missing `size` field initialization in macro STATS_DESC
>
> [1] https://lore.kernel.org/kvm/20210402224359.2297157-1-jingzhangos@google.com
> [2] https://lore.kernel.org/kvm/20210415151741.1607806-1-jingzhangos@google.com
> [3] https://lore.kernel.org/kvm/20210423181727.596466-1-jingzhangos@google.com
> [4] https://lore.kernel.org/kvm/20210429203740.1935629-1-jingzhangos@google.com
>
> ---
>
> Jing Zhang (4):
>   KVM: stats: Separate common stats from architecture specific ones
>   KVM: stats: Add fd-based API to read binary stats data
>   KVM: stats: Add documentation for statistics data binary interface
>   KVM: selftests: Add selftest for KVM statistics data binary interface
>
>  Documentation/virt/kvm/api.rst                | 171 ++++++++
>  arch/arm64/include/asm/kvm_host.h             |   9 +-
>  arch/arm64/kvm/guest.c                        |  38 +-
>  arch/mips/include/asm/kvm_host.h              |   9 +-
>  arch/mips/kvm/mips.c                          |  64 ++-
>  arch/powerpc/include/asm/kvm_host.h           |   9 +-
>  arch/powerpc/kvm/book3s.c                     |  64 ++-
>  arch/powerpc/kvm/book3s_hv.c                  |  12 +-
>  arch/powerpc/kvm/book3s_pr.c                  |   2 +-
>  arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
>  arch/powerpc/kvm/booke.c                      |  59 ++-
>  arch/s390/include/asm/kvm_host.h              |   9 +-
>  arch/s390/kvm/kvm-s390.c                      | 129 +++++-
>  arch/x86/include/asm/kvm_host.h               |   9 +-
>  arch/x86/kvm/x86.c                            |  67 +++-
>  include/linux/kvm_host.h                      | 136 ++++++-
>  include/linux/kvm_types.h                     |  12 +
>  include/uapi/linux/kvm.h                      |  50 +++
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   3 +
>  .../testing/selftests/kvm/include/kvm_util.h  |   3 +
>  .../selftests/kvm/kvm_bin_form_stats.c        | 379 ++++++++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
>  virt/kvm/kvm_main.c                           | 237 ++++++++++-
>  24 files changed, 1396 insertions(+), 90 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c
>
>
> base-commit: a4345a7cecfb91ae78cd43d26b0c6a956420761a
> --
> 2.31.1.751.gd2f1c929bd-goog
>
Please use this patchset which has some nontrivial changes and improvements.

Thanks,
Jing
