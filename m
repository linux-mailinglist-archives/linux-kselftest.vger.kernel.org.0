Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD187933A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 04:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjIFCPw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 22:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjIFCPw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 22:15:52 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E714CF9;
        Tue,  5 Sep 2023 19:15:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcc331f942so5686951fa.0;
        Tue, 05 Sep 2023 19:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693966534; x=1694571334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AW5DEjMPwf/WOBjq6Yy/rxPXX4Pw+fsGwtExcVSRjU=;
        b=ejQc0UYbO2umFssYxQrKYtro5XGaKThG5D72q0QtEmcJnsweMXgD2277D2YijMNnRC
         5dq+dyavOMEXKIUFpOcdN9QVxrkHJfXe17psO4xMLCqOetxXsRFx5qlFR1YBg1/kHauA
         AV9JW5oLmys2x1gPOrvkpqkU8Yn12t7N92fEgLW+UBgNpvQaDr3Xy8az/OX0oXQcjqj9
         K/+AwuZaBjZCt7rEgugCUDOaN6oABOqDHyN6inxawZwcz9a46ko0caNLEPNVI0WEHddI
         g7R+GbyjXseOMaBJiBss2uUOQFMD91tJM1GZoJ0//z6W2w9syPvUmvWBYgCDDvf+RK7R
         V1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693966534; x=1694571334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AW5DEjMPwf/WOBjq6Yy/rxPXX4Pw+fsGwtExcVSRjU=;
        b=L1pYfj3juZxt6ReD/TRKt1Ozk0Lzaz3vw76Pkvpm5tsjmYFPm25JcyDUJr+wmVH39i
         eNanBBlbSxxe/nBQyEaeUds0kc/SLZ9kmrIDL88tsHxQFvC+EjKu16lDQz7BqcZkBW3u
         lYyLlhiB8u8FSxBwwrDLRnx+Y5KJa+w5l/FTiF0LsuIcg3LRpINYpXL3L+STH23d5MMY
         Vp4ieJGuBy9M6eRXQbqa3nPx/cmFRrhQW09ZIY57w88b+esKcg3bIgWPfoEV13VXI9cs
         KOO8FeMV0OjPlpMLFt3ozv3GWknqXfO/Y1C+M433UTZQSj9iZwF+HpzY1jKjYLB6RANh
         pUiA==
X-Gm-Message-State: AOJu0YxHbLDPnYuma5vXcq4OXXMzhpGFDKnTMi7+ykzxoXdTennL4ilQ
        KS8Jmq4l9QpxhRTim5hqPCTs58j414tRIpeQI2c=
X-Google-Smtp-Source: AGHT+IFINadRkT5OvEK7LBs75KJ/A6GYonKZM55L5Tbnd4WVkS+YBQznNFHrs/NRClyfQ2LSLrrokB+J+aTJxpaXGK4=
X-Received: by 2002:a2e:9e56:0:b0:2b6:c3f9:b86b with SMTP id
 g22-20020a2e9e56000000b002b6c3f9b86bmr501791ljk.15.1693966534248; Tue, 05 Sep
 2023 19:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <7affb0387d7272573f7093de7887872e1fb5979b.1693659382.git.haibo1.xu@intel.com>
 <20230904-ba5051a5bf17d17f2711d7dc@orel>
In-Reply-To: <20230904-ba5051a5bf17d17f2711d7dc@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 6 Sep 2023 10:15:23 +0800
Message-ID: <CAJve8ok7xny2f+J_O0SFZRAiKGMinM9C1YK=OXVpABem=KttnQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] KVM: selftests: Unify the codes for guest
 exception handling
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        wchen <waylingii@gmail.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Lei Wang <lei4.wang@intel.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Like Xu <likexu@tencent.com>, Peter Gonda <pgonda@google.com>,
        Thomas Huth <thuth@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>,
        zhang songyi <zhang.songyi@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
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

On Mon, Sep 4, 2023 at 7:16=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Sat, Sep 02, 2023 at 08:59:23PM +0800, Haibo Xu wrote:
> > Rename the vm_init_descriptor_tables() and vcpu_init_vector_tables()
>                                              ^ vcpu_init_descriptor_table=
s()
>
> > prototypes to vm_init_vector_tables() and vcpu_init_vector_tables()
> > respectively, so that we can use common names for the architectures
> > (x86/aarch64/riscv) and then put them in a common header.
> >
> > By the way, vm_install_exception_handler() prototype were also moved to
> > the common header since they are commonly used across the architectures=
.
> >
> > The patch is a preparation to share the guest exception handling codes
> > in riscv.
> >
> > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/aarch64/arch_timer.c          | 4 ++--
> >  tools/testing/selftests/kvm/aarch64/debug-exceptions.c    | 4 ++--
> >  tools/testing/selftests/kvm/aarch64/page_fault_test.c     | 4 ++--
> >  tools/testing/selftests/kvm/aarch64/vgic_irq.c            | 4 ++--
> >  tools/testing/selftests/kvm/include/aarch64/processor.h   | 8 +-------
> >  tools/testing/selftests/kvm/include/kvm_util_base.h       | 7 +++++++
> >  tools/testing/selftests/kvm/include/x86_64/processor.h    | 5 -----
> >  tools/testing/selftests/kvm/lib/aarch64/processor.c       | 6 +++---
> >  tools/testing/selftests/kvm/lib/x86_64/processor.c        | 4 ++--
> >  tools/testing/selftests/kvm/x86_64/amx_test.c             | 4 ++--
> >  tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c   | 4 ++--
> >  tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c         | 4 ++--
> >  tools/testing/selftests/kvm/x86_64/hyperv_features.c      | 8 ++++----
> >  tools/testing/selftests/kvm/x86_64/hyperv_ipi.c           | 6 +++---
> >  tools/testing/selftests/kvm/x86_64/kvm_pv_test.c          | 4 ++--
> >  tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c   | 4 ++--
> >  .../testing/selftests/kvm/x86_64/pmu_event_filter_test.c  | 8 ++++----
> >  .../kvm/x86_64/smaller_maxphyaddr_emulation_test.c        | 4 ++--
> >  tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c     | 4 ++--
> >  .../selftests/kvm/x86_64/svm_nested_shutdown_test.c       | 4 ++--
> >  .../selftests/kvm/x86_64/svm_nested_soft_inject_test.c    | 4 ++--
> >  tools/testing/selftests/kvm/x86_64/ucna_injection_test.c  | 8 ++++----
> >  .../selftests/kvm/x86_64/userspace_msr_exit_test.c        | 4 ++--
> >  .../kvm/x86_64/vmx_exception_with_invalid_guest_state.c   | 4 ++--
> >  tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c    | 4 ++--
> >  tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c       | 4 ++--
> >  tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c      | 4 ++--
> >  tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c      | 4 ++--
> >  28 files changed, 66 insertions(+), 70 deletions(-)
> >
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks for the review!
