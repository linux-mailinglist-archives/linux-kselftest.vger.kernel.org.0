Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C62665019
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 00:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjAJX4e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 18:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjAJX4a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 18:56:30 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DCBFE
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 15:56:29 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id g7so12514978qts.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 15:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ5VzqScz6w9Ee0ucy8HcJjuj+uX9vX/90WHrjQzutM=;
        b=oDRrtDJCK5bwkHA/25RZ1YqtKwSC+zTemlJpXX0tBnEgs/1lqi+onPbwgk7BS34ORS
         4VJQeH+KWYpaaYXj5IUKWLJOMDqJ5TY2ObLt8Tve5B/ZAysn5ObDea1Vx9IhoXiRPzag
         xAV1N6Q/Vq7uHYQYv3SCTzCwS5nH8BiXcUzdD/Nx7t4tOnN/9FWL5jjHyKLp3XJZK7Fq
         gRElOsHUoAF38hHI109labephr0jWhYW7Vx1dBaooYfdRz4tqOnUhCy9D98xEzSV0B2x
         0l3HtiWL7fOf9t8PTCvJlxfluvAoGc6hFLYM2HaXOQvGz8lqaqx1cfCEkK+xxylL+gIC
         gB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ5VzqScz6w9Ee0ucy8HcJjuj+uX9vX/90WHrjQzutM=;
        b=hOgP0qQ/LJYLrComMqU5jFC/aFYUQNVBf8fjLrWa0KjtbGjcjYPwtUOkIOIjD/XEve
         hsf72p4sglAlMYRxN9GbV7Ob3vUrxcTn12yQdLdv3My/KM9dgpOHSs+88A1lLWOM8u75
         /Hlvw6BITqzboapAJS2ZAWGc6W5sSIO6n1ITg9W52f2PYuwOom9VV4EqWYp0546qbRvQ
         RSGtv1qa2bTHl5GyZ7utRYdpDM3HktHgj2GEHVSzc9IzVPtSkhYHAn2GI7I+tJk5Dtpm
         +HI8Q/sy1bTW4g0LoJYOHs8GQ3TaddvGI/Za0ptbcH6NDHtHeKIUd2AecnOoeGZEES+3
         Svyw==
X-Gm-Message-State: AFqh2kpZvOlwVmGVZ6ranclU8D86HwBPkC+1+H+QGGykjyoV27XoS1PM
        vBmvsyFvTYRH2Vk0Mv2WkMt86bopJa7oyMylwwN7MBu475aWgU6m
X-Google-Smtp-Source: AMrXdXs86mHRk/wvPfLVNPxlQhKf7hs1WZugsLCv26MQ8e4RKpJeprNIu8lxRACzIRC+2MX2+DasWzw3ZhMNic3vQdM=
X-Received: by 2002:a05:622a:5c1a:b0:3a6:ee88:63dd with SMTP id
 gd26-20020a05622a5c1a00b003a6ee8863ddmr3319956qtb.446.1673394988250; Tue, 10
 Jan 2023 15:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20221228192438.2835203-1-vannapurve@google.com>
 <20221228192438.2835203-2-vannapurve@google.com> <Y7xX6hg+YTgTrAzW@google.com>
In-Reply-To: <Y7xX6hg+YTgTrAzW@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 10 Jan 2023 15:56:17 -0800
Message-ID: <CAGtprH_zPTOPn=wJ9W58Aw5Xbe0Rfq+dz+N+6CAQ+NHwU-Z+zw@mail.gmail.com>
Subject: Re: [V4 PATCH 1/4] KVM: selftests: x86: use this_cpu_* helpers
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 9, 2023 at 10:07 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Dec 28, 2022, Vishal Annapurve wrote:
> > Use this_cpu_* helpers to query the cpu vendor.
>
> Neither the changelog nor the shortlog captures what this patch actually does,
> or rather what I inteded it to do.  Specifically, what I suggested (or intended
> to suggest) was:
>
>   KVM: selftests: Rename vendor string helpers to use "this_cpu" prefix
>
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
>
> ...
>
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > index acfa1d01e7df..a799af572f3f 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > @@ -1006,26 +1006,14 @@ void kvm_x86_state_cleanup(struct kvm_x86_state *state)
> >       free(state);
> >  }
> >
> > -static bool cpu_vendor_string_is(const char *vendor)
> > -{
> > -     const uint32_t *chunk = (const uint32_t *)vendor;
> > -     uint32_t eax, ebx, ecx, edx;
> > -
> > -     cpuid(0, &eax, &ebx, &ecx, &edx);
> > -     return (ebx == chunk[0] && edx == chunk[1] && ecx == chunk[2]);
> > -}
> > -
> >  bool is_intel_cpu(void)
>
> Drop the is_intel_cpu() and is_amd_cpu() wrappers.  The whole point of the rename
> was so that it's obvious at the call site that the function is checking the "current"
> CPU context.
>
> That obviously means dropping the is_host_cpu_amd() and is_host_cpu_intel() wrappers
> too.  IMO, the extra layer to jump through (more from a code reading perspective then
> a code generation perspective) isn't worth protecting the booleans.
>
> It's slightly more churn (in between patches, not overall), but the benefit is that
> it allows squasing patches 2 and 3 into a single patch, e.g. "KVM: selftests: Cache
> host CPU vendor (AMD vs. Intel)"
>
> ---
>  tools/testing/selftests/kvm/include/x86_64/processor.h    | 3 +++
>  tools/testing/selftests/kvm/lib/x86_64/processor.c        | 8 ++++----
>  tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c   | 4 ++--
>  tools/testing/selftests/kvm/x86_64/mmio_warning_test.c    | 2 +-
>  .../testing/selftests/kvm/x86_64/pmu_event_filter_test.c  | 4 ++--
>  .../kvm/x86_64/vmx_exception_with_invalid_guest_state.c   | 2 +-
>  6 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index fdb1af5ca611..c7885f72132a 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -19,6 +19,9 @@
>
>  #include "../kvm_util.h"
>
> +extern bool host_cpu_is_intel;
> +extern bool host_cpu_is_amd;
> +
>  #define NMI_VECTOR             0x02
>
>  #define X86_EFLAGS_FIXED        (1u << 1)
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 0b8de34aa10e..84915bc7d689 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -19,8 +19,8 @@
>  #define MAX_NR_CPUID_ENTRIES 100
>
>  vm_vaddr_t exception_handlers;
> -static bool host_cpu_is_amd;
> -static bool host_cpu_is_intel;
> +bool host_cpu_is_amd;
> +bool host_cpu_is_intel;
>
>  static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
>  {
> @@ -115,7 +115,7 @@ static void sregs_dump(FILE *stream, struct kvm_sregs *sregs, uint8_t indent)
>
>  bool kvm_is_tdp_enabled(void)
>  {
> -       if (this_cpu_is_intel())
> +       if (host_cpu_is_intel)
>                 return get_kvm_intel_param_bool("ept");
>         else
>                 return get_kvm_amd_param_bool("npt");
> @@ -1218,7 +1218,7 @@ unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
>         max_gfn = (1ULL << (vm->pa_bits - vm->page_shift)) - 1;
>
>         /* Avoid reserved HyperTransport region on AMD processors.  */
> -       if (!this_cpu_is_amd())
> +       if (!host_cpu_is_amd)
>                 return max_gfn;
>
>         /* On parts with <40 physical address bits, the area is fully hidden */
> diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
> index 5489c9836ec8..0f728f05ea82 100644
> --- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
> @@ -48,10 +48,10 @@ static void guest_main(void)
>         const uint8_t *other_hypercall_insn;
>         uint64_t ret;
>
> -       if (this_cpu_is_intel()) {
> +       if (host_cpu_is_intel) {
>                 native_hypercall_insn = vmx_vmcall;
>                 other_hypercall_insn  = svm_vmmcall;
> -       } else if (this_cpu_is_amd()) {
> +       } else if (host_cpu_is_amd) {
>                 native_hypercall_insn = svm_vmmcall;
>                 other_hypercall_insn  = vmx_vmcall;
>         } else {
> diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> index b0a2a0bae0f3..ce1ccc4c1503 100644
> --- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> @@ -93,7 +93,7 @@ int main(void)
>  {
>         int warnings_before, warnings_after;
>
> -       TEST_REQUIRE(this_cpu_is_intel());
> +       TEST_REQUIRE(host_cpu_is_intel);
>
>         TEST_REQUIRE(!vm_is_unrestricted_guest(NULL));
>
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index c728822461b2..4dbb454e1760 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> @@ -363,7 +363,7 @@ static void test_pmu_config_disable(void (*guest_code)(void))
>   */
>  static bool use_intel_pmu(void)
>  {
> -       return this_cpu_is_intel() &&
> +       return host_cpu_is_intel &&
>                kvm_cpu_property(X86_PROPERTY_PMU_VERSION) &&
>                kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS) &&
>                kvm_pmu_has(X86_PMU_FEATURE_BRANCH_INSNS_RETIRED);
> @@ -397,7 +397,7 @@ static bool use_amd_pmu(void)
>         uint32_t family = kvm_cpu_family();
>         uint32_t model = kvm_cpu_model();
>
> -       return this_cpu_is_amd() &&
> +       return host_cpu_is_amd &&
>                 (is_zen1(family, model) ||
>                  is_zen2(family, model) ||
>                  is_zen3(family, model));
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
> index 53e1ef2fc774..ccdfa5dc1a4d 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
> @@ -111,7 +111,7 @@ int main(int argc, char *argv[])
>         struct kvm_vcpu *vcpu;
>         struct kvm_vm *vm;
>
> -       TEST_REQUIRE(this_cpu_is_intel());
> +       TEST_REQUIRE(host_cpu_is_intel);
>         TEST_REQUIRE(!vm_is_unrestricted_guest(NULL));
>
>         vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>
> base-commit: 04b420511919f7b78f17f5fa6dc92975a8b2d7c4
> --
>

Ack, that makes sense. Will include this suggestion in the next version.
