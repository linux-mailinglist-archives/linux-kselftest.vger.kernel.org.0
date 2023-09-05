Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C8D792687
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbjIEQHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354291AbjIEKgX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 06:36:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2049199
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Sep 2023 03:36:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-99bf3f59905so356032066b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Sep 2023 03:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693910178; x=1694514978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfqw6iJ4ruL8BEmtuLRWIN/7uvJd+Y/QPLQc2ETsH8Q=;
        b=XV9PLVD3fdr42GJfQOoeFU5sVtu/bfHdL1XWsFUlf2FdWbfasCwXtTnX+44W1A5T3P
         d3bTRGKEWOHTji+OxuC9IpAxwEGU2WK2afbvTpevUhDt7PM6efa++JBSlgr7bVAjP2Oo
         liQMt58vI8tiyOap++lHpgb1NzDsl2wdJHEpWdAIDB3OxWvJqnPl27m4HNbN7sYJJ2oo
         AUlPH9N7m2bFib6dY/qx3uNaXxZe15YkMVmZGqJrlBsmyG94YGr8jYzHeXsKFnoeAMdh
         2Kb+N8AY3V5Da/ALXQ8eTex3bhCEQALMYowlIhJBwtLVFpDBwvo0Ig2PhgB+S58ojtsO
         Ev0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693910178; x=1694514978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nfqw6iJ4ruL8BEmtuLRWIN/7uvJd+Y/QPLQc2ETsH8Q=;
        b=NLkPzPYOTJttxyHwDAvORJK/CG3TR+SRGmyZu4HNWcPL2VizBlMFIONCj8z3LgEphh
         1aWDfKVRFlCogKYXRoj2E2m6/6ETHrJkPoKfpYX/pQSAlPykfrAdt95QvZ5J3yRUidlU
         p5j2T67vms6UY5/6KzN+7hQH2NPXYhufMc0o6V4aqu99j1ust79dL64IsMGOXygyqudt
         D1RThpZG5Go3QPxjCXwaO9YRanjdsmafK9N7+U80g9hddwdKI7oNBwPi3xwCIpZJkNh5
         ZQqSA/pLlX44N3KD2OQGntEhtBrxDsHxyWq6/rbsio7EtyElHKikLbZNlYqCTgMqZFul
         z1Cg==
X-Gm-Message-State: AOJu0Yyj8BpnPmwalKks6tEnbHz5KDPFVBxNw237lfx3SWu0vmv3Y1xI
        47YViVhbtM6pww9298Xn5RjyNA==
X-Google-Smtp-Source: AGHT+IHkRyEbp0w5QIZbj1GlQvlGuscWTdMpQO8f95QsDXvDTy2lmlAWjOWJLe7UTlpwG3PDaD3ODQ==
X-Received: by 2002:a17:906:10db:b0:9a1:e395:2d10 with SMTP id v27-20020a17090610db00b009a1e3952d10mr9165785ejv.75.1693910178039;
        Tue, 05 Sep 2023 03:36:18 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906a40d00b0099bc0daf3d7sm7484299ejz.182.2023.09.05.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 03:36:17 -0700 (PDT)
Date:   Tue, 5 Sep 2023 12:36:16 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
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
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/8] RISCV: Add kvm Sstc timer selftest
Message-ID: <20230905-eb7998dbd945ed9dd12659ea@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693659382.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Haibo,

Some of your patch summaries say 'selftest' instead of 'selftests'. Please
correct those for the next version.

Thanks,
drew

On Sat, Sep 02, 2023 at 08:59:22PM +0800, Haibo Xu wrote:
> The RISC-V arch_timer selftest is used to validate Sstc timer
> functionality in a guest, which sets up periodic timer interrupts
> and check the basic interrupt status upon its receipt.
> 
> This KVM selftest was ported from aarch64 arch_timer and tested
> with Linux v6.5-rc5 on a Qemu riscv64 virt machine.
> 
> ---
> Changed since v1:
>   * Rebase to kvm-riscv/riscv_kvm_next
>   * Cherry-pick Sean's kselftest guest printf patch set
>     https://lore.kernel.org/all/20230729003643.1053367-1-seanjc@google.com/
>   * Copy the entire csr.h verbatim
>   * Unified the function names for exception vector table setup
>     void vm_init_vector_tables(struct kvm_vm *vm);
>     void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
>   * Format the handler.S asm file per Andrew's comments
>   * Consolidate the timer test code for arm64 and riscv
>     based on Andrew's and Sean's suggestion
> 
> Haibo Xu (8):
>   KVM: selftests: Unify the codes for guest exception handling
>   KVM: arm64: selftest: Split arch_timer test code
>   tools: riscv: Add header file csr.h
>   KVM: riscv: selftests: Switch to use macro from csr.h
>   KVM: riscv: selftests: Add exception handling support
>   KVM: riscv: selftests: Add guest helper to get vcpu id
>   KVM: riscv: selftest: Change vcpu_has_ext to a common function
>   KVM: riscv: selftests: Add sstc timer test
> 
>  tools/arch/riscv/include/asm/csr.h            | 521 ++++++++++++++++++
>  tools/testing/selftests/kvm/Makefile          |  11 +-
>  .../selftests/kvm/aarch64/arch_timer.c        | 292 +---------
>  .../selftests/kvm/aarch64/debug-exceptions.c  |   4 +-
>  .../selftests/kvm/aarch64/page_fault_test.c   |   4 +-
>  .../testing/selftests/kvm/aarch64/vgic_irq.c  |   4 +-
>  tools/testing/selftests/kvm/arch_timer.c      | 261 +++++++++
>  .../selftests/kvm/include/aarch64/processor.h |  12 +-
>  .../selftests/kvm/include/kvm_util_base.h     |   9 +
>  .../selftests/kvm/include/riscv/arch_timer.h  |  80 +++
>  .../selftests/kvm/include/riscv/processor.h   |  60 +-
>  .../selftests/kvm/include/timer_test.h        |  58 ++
>  .../selftests/kvm/include/x86_64/processor.h  |   5 -
>  .../selftests/kvm/lib/aarch64/processor.c     |   6 +-
>  .../selftests/kvm/lib/riscv/handlers.S        | 101 ++++
>  .../selftests/kvm/lib/riscv/processor.c       |  86 +++
>  .../selftests/kvm/lib/x86_64/processor.c      |   4 +-
>  .../testing/selftests/kvm/riscv/arch_timer.c  | 130 +++++
>  .../selftests/kvm/riscv/get-reg-list.c        |  14 -
>  tools/testing/selftests/kvm/x86_64/amx_test.c |   4 +-
>  .../selftests/kvm/x86_64/fix_hypercall_test.c |   4 +-
>  .../selftests/kvm/x86_64/hyperv_evmcs.c       |   4 +-
>  .../selftests/kvm/x86_64/hyperv_features.c    |   8 +-
>  .../testing/selftests/kvm/x86_64/hyperv_ipi.c |   6 +-
>  .../selftests/kvm/x86_64/kvm_pv_test.c        |   4 +-
>  .../selftests/kvm/x86_64/monitor_mwait_test.c |   4 +-
>  .../kvm/x86_64/pmu_event_filter_test.c        |   8 +-
>  .../smaller_maxphyaddr_emulation_test.c       |   4 +-
>  .../selftests/kvm/x86_64/svm_int_ctl_test.c   |   4 +-
>  .../kvm/x86_64/svm_nested_shutdown_test.c     |   4 +-
>  .../kvm/x86_64/svm_nested_soft_inject_test.c  |   4 +-
>  .../kvm/x86_64/ucna_injection_test.c          |   8 +-
>  .../kvm/x86_64/userspace_msr_exit_test.c      |   4 +-
>  .../vmx_exception_with_invalid_guest_state.c  |   4 +-
>  .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |   4 +-
>  .../selftests/kvm/x86_64/xapic_ipi_test.c     |   4 +-
>  .../selftests/kvm/x86_64/xcr0_cpuid_test.c    |   4 +-
>  .../selftests/kvm/x86_64/xen_shinfo_test.c    |   4 +-
>  38 files changed, 1376 insertions(+), 376 deletions(-)
>  create mode 100644 tools/arch/riscv/include/asm/csr.h
>  create mode 100644 tools/testing/selftests/kvm/arch_timer.c
>  create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_timer.h
>  create mode 100644 tools/testing/selftests/kvm/include/timer_test.h
>  create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S
>  create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c
> 
> -- 
> 2.34.1
> 
