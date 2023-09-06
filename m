Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DDD793358
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 03:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjIFBYP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 21:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbjIFBYP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 21:24:15 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B8FCC2;
        Tue,  5 Sep 2023 18:24:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso48218771fa.2;
        Tue, 05 Sep 2023 18:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693963448; x=1694568248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xfJSGXD8vBLM08q729zBD/9glpH/PWMQ0GciStqljw=;
        b=lLSRaxCep2dvaFMqkRQ6cmjICAimp5HR5WTK+xXkoqIoWVT4aCpmq42y97muDf0jMd
         j5fKxuPL/oDmUzb6FMt6fJyQuj5boina86p93/FJJP2mrqzsYvywLIs+zg8tBsdvQAvm
         uBdonLjmdZmXYeYdh2gukhy9SgEoPY30WMHQnIcm4nTXLfJhi2e+by1q2lIfLjJdFttu
         Po0Olrbq99KD+w4HKz/TCe66TmEejeOO+4Ppl/JHGR304p/AfOjFNNzVuvy2Ys/OdKlw
         KXD8vECF9otwTyhGjogb0LzdJmjl7rywIyEEXtryzjTTf6hAE9XruYhih4ryZUowldyh
         v/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693963448; x=1694568248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xfJSGXD8vBLM08q729zBD/9glpH/PWMQ0GciStqljw=;
        b=JXrqierl7+R84nkungWjbv6g6tBFozZBOzaDHZNOzpVR7B0aFabgZFBX4XML4eeyyO
         gKhkIlLOagw8MvxyYh7+0anaJ5fwclWbFATilqWFn/N2G2XVcOMPK9f9YH2w7tuSDzkS
         iGDXC3nKb4q3qLw+cOod6klpg6Ax2VjuWQW9swrtpv/spk5Ra1fbBuzR3GW25c5NacMb
         50QQ6iFlMMPYokzYJo174GUFM3nV4SQD51LqJGz9v7+Ln5suuIcdXHkCOlqMdnQ13W3Y
         ZuufFK/QLGTKEHTdUegpWwZH0D2rg/WYivDYJL71QMlhHvaVhVls+XrMQL8tqSMWdMZg
         pBUA==
X-Gm-Message-State: AOJu0YxZtZNLy8xcksMM3N+s0HbD92Ag11EUSzbK+nNyZZDNj3cdRztl
        9HzEXVXrhJZQ6y3EsKhIwZRMAWGgMgOh0cEAOjg=
X-Google-Smtp-Source: AGHT+IEZAtSdfv2O9kOnOodcd6ZENRRHvHNIg7rIlF/apuuxioXnbEufFM1mW11nwPy+FUp/gWhTnrfWfFZLNg5iXcI=
X-Received: by 2002:a2e:7204:0:b0:2bc:fb79:d165 with SMTP id
 n4-20020a2e7204000000b002bcfb79d165mr1109276ljc.39.1693963447866; Tue, 05 Sep
 2023 18:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <20230905-eb7998dbd945ed9dd12659ea@orel>
In-Reply-To: <20230905-eb7998dbd945ed9dd12659ea@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 6 Sep 2023 09:23:56 +0800
Message-ID: <CAJve8o=Oz9m_t3tZOFgxo41Ss+dz-kLHU5Y44ov=JjZs3Jyaew@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] RISCV: Add kvm Sstc timer selftest
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, wchen <waylingii@gmail.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Lei Wang <lei4.wang@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Thomas Huth <thuth@redhat.com>, Like Xu <likexu@tencent.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 5, 2023 at 6:36=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> Hi Haibo,
>
> Some of your patch summaries say 'selftest' instead of 'selftests'. Pleas=
e
> correct those for the next version.
>

Sure, thanks for pointing that out!

> Thanks,
> drew
>
> On Sat, Sep 02, 2023 at 08:59:22PM +0800, Haibo Xu wrote:
> > The RISC-V arch_timer selftest is used to validate Sstc timer
> > functionality in a guest, which sets up periodic timer interrupts
> > and check the basic interrupt status upon its receipt.
> >
> > This KVM selftest was ported from aarch64 arch_timer and tested
> > with Linux v6.5-rc5 on a Qemu riscv64 virt machine.
> >
> > ---
> > Changed since v1:
> >   * Rebase to kvm-riscv/riscv_kvm_next
> >   * Cherry-pick Sean's kselftest guest printf patch set
> >     https://lore.kernel.org/all/20230729003643.1053367-1-seanjc@google.=
com/
> >   * Copy the entire csr.h verbatim
> >   * Unified the function names for exception vector table setup
> >     void vm_init_vector_tables(struct kvm_vm *vm);
> >     void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
> >   * Format the handler.S asm file per Andrew's comments
> >   * Consolidate the timer test code for arm64 and riscv
> >     based on Andrew's and Sean's suggestion
> >
> > Haibo Xu (8):
> >   KVM: selftests: Unify the codes for guest exception handling
> >   KVM: arm64: selftest: Split arch_timer test code
> >   tools: riscv: Add header file csr.h
> >   KVM: riscv: selftests: Switch to use macro from csr.h
> >   KVM: riscv: selftests: Add exception handling support
> >   KVM: riscv: selftests: Add guest helper to get vcpu id
> >   KVM: riscv: selftest: Change vcpu_has_ext to a common function
> >   KVM: riscv: selftests: Add sstc timer test
> >
> >  tools/arch/riscv/include/asm/csr.h            | 521 ++++++++++++++++++
> >  tools/testing/selftests/kvm/Makefile          |  11 +-
> >  .../selftests/kvm/aarch64/arch_timer.c        | 292 +---------
> >  .../selftests/kvm/aarch64/debug-exceptions.c  |   4 +-
> >  .../selftests/kvm/aarch64/page_fault_test.c   |   4 +-
> >  .../testing/selftests/kvm/aarch64/vgic_irq.c  |   4 +-
> >  tools/testing/selftests/kvm/arch_timer.c      | 261 +++++++++
> >  .../selftests/kvm/include/aarch64/processor.h |  12 +-
> >  .../selftests/kvm/include/kvm_util_base.h     |   9 +
> >  .../selftests/kvm/include/riscv/arch_timer.h  |  80 +++
> >  .../selftests/kvm/include/riscv/processor.h   |  60 +-
> >  .../selftests/kvm/include/timer_test.h        |  58 ++
> >  .../selftests/kvm/include/x86_64/processor.h  |   5 -
> >  .../selftests/kvm/lib/aarch64/processor.c     |   6 +-
> >  .../selftests/kvm/lib/riscv/handlers.S        | 101 ++++
> >  .../selftests/kvm/lib/riscv/processor.c       |  86 +++
> >  .../selftests/kvm/lib/x86_64/processor.c      |   4 +-
> >  .../testing/selftests/kvm/riscv/arch_timer.c  | 130 +++++
> >  .../selftests/kvm/riscv/get-reg-list.c        |  14 -
> >  tools/testing/selftests/kvm/x86_64/amx_test.c |   4 +-
> >  .../selftests/kvm/x86_64/fix_hypercall_test.c |   4 +-
> >  .../selftests/kvm/x86_64/hyperv_evmcs.c       |   4 +-
> >  .../selftests/kvm/x86_64/hyperv_features.c    |   8 +-
> >  .../testing/selftests/kvm/x86_64/hyperv_ipi.c |   6 +-
> >  .../selftests/kvm/x86_64/kvm_pv_test.c        |   4 +-
> >  .../selftests/kvm/x86_64/monitor_mwait_test.c |   4 +-
> >  .../kvm/x86_64/pmu_event_filter_test.c        |   8 +-
> >  .../smaller_maxphyaddr_emulation_test.c       |   4 +-
> >  .../selftests/kvm/x86_64/svm_int_ctl_test.c   |   4 +-
> >  .../kvm/x86_64/svm_nested_shutdown_test.c     |   4 +-
> >  .../kvm/x86_64/svm_nested_soft_inject_test.c  |   4 +-
> >  .../kvm/x86_64/ucna_injection_test.c          |   8 +-
> >  .../kvm/x86_64/userspace_msr_exit_test.c      |   4 +-
> >  .../vmx_exception_with_invalid_guest_state.c  |   4 +-
> >  .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |   4 +-
> >  .../selftests/kvm/x86_64/xapic_ipi_test.c     |   4 +-
> >  .../selftests/kvm/x86_64/xcr0_cpuid_test.c    |   4 +-
> >  .../selftests/kvm/x86_64/xen_shinfo_test.c    |   4 +-
> >  38 files changed, 1376 insertions(+), 376 deletions(-)
> >  create mode 100644 tools/arch/riscv/include/asm/csr.h
> >  create mode 100644 tools/testing/selftests/kvm/arch_timer.c
> >  create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_time=
r.h
> >  create mode 100644 tools/testing/selftests/kvm/include/timer_test.h
> >  create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S
> >  create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c
> >
> > --
> > 2.34.1
> >
