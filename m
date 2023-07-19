Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF99758BAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 05:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGSDAI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 23:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjGSDAG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 23:00:06 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2FF1BF7;
        Tue, 18 Jul 2023 20:00:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-51e48e1f6d1so8685458a12.1;
        Tue, 18 Jul 2023 20:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689735601; x=1692327601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyxAzC/6KM4h0zRVaEqAvajG/7zLUCUTWAHgPPygpQI=;
        b=eW2q6v8pGXaemUMU4uVtTrB3myTt/DiflqKebSFELGf/lqIS7dPNau8Kjz8aTchyyn
         LiWBxV7xsKp/APzQi9nF4L/wxzQm1Q6dvwd9oEZz90e05FGcMgGCcrgiPvCxcqd7gnuH
         SiRjXQtYO2yALLYmkVsTk2dsYleDG3w4NGge10d9/ki/lJOFQkxGYmKSRYv6m9WkQsvE
         yb9MdzDfIKVtC74p5xblqXsSNSjC60IWtEze2LUezy8GJu8icxUw7NIjWQ+yK+k+tGZD
         faODhsThJ9syUbXiEXBnRl8XKINBw/ww0j0hoFlYXS5ISotA51zkXMpsC/+ljPMUQypQ
         b91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689735601; x=1692327601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyxAzC/6KM4h0zRVaEqAvajG/7zLUCUTWAHgPPygpQI=;
        b=KuvrCDk6e+ZaSMYCICFsoVyCTy942j4cWbDdw82uW9hAXR7HMB5Hkfaq9gGgh4ySQq
         Vnk29m47y9n02rI0iyxM+siCxspuFhgX7J3jFDvv6kiy6bpeltunVPiIiPJaj7szhIgR
         REOEdxplMXgEFbk5ZOaqvblRdcWhtkGreooVlFEmjzIbkIZ3eLep+xUfkQvX6vA57870
         MAO0JC6ug878nUJn5QgFkfiTqG6r2P36Z2f13hVAZCNoEtMjFu8kFIQff4vIYpE/pZ0I
         KjqVv1E7bQD1avfrac3Qo1/XfLBFdtudNMl7+08VWz85yTQLUpDIRu4fWMoIzFU1O0he
         lO1w==
X-Gm-Message-State: ABy/qLYqYAx1hz81sDwArRm8rQ/bbYRBZmuKcft3MjLO8iopYJdb/FCr
        hHyynWtrr3ZQgZgis7OQw6IhsEnYFxNTCYfCCAFTngGm5bwma38yo4E=
X-Google-Smtp-Source: APBJJlH74W3Jr5XYXGmOp5HoyOo7KI31ZbAfqc8quP/1JIsWoMhu8uMQaFMsaSxeqnIjPColqZoE8yemRiPWgASYJUU=
X-Received: by 2002:aa7:d805:0:b0:51d:b89d:9818 with SMTP id
 v5-20020aa7d805000000b0051db89d9818mr1243020edq.12.1689735600924; Tue, 18 Jul
 2023 20:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230717062343.3743-1-cloudliang@tencent.com> <20230717062343.3743-6-cloudliang@tencent.com>
 <20230719012113.GE25699@ls.amr.corp.intel.com>
In-Reply-To: <20230719012113.GE25699@ls.amr.corp.intel.com>
From:   Jinrong Liang <ljr.kernel@gmail.com>
Date:   Wed, 19 Jul 2023 10:59:49 +0800
Message-ID: <CAFg_LQUkF6EoPo0WDQaPqyBSjprOsZxkqTQGJtjYdaqUBBeztg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] KVM: selftests: Test if event filter meets
 expectations on fixed counters
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Isaku Yamahata <isaku.yamahata@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=881=
9=E6=97=A5=E5=91=A8=E4=B8=89 09:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 17, 2023 at 02:23:42PM +0800,
> Jinrong Liang <ljr.kernel@gmail.com> wrote:
>
> > From: Jinrong Liang <cloudliang@tencent.com>
> >
> > Add tests to cover that pmu event_filter works as expected when
> > it's applied to fixed performance counters, even if there is none
> > fixed counter exists (e.g. Intel guest pmu version=3D1 or AMD guest).
> >
> > Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> > ---
> >  .../kvm/x86_64/pmu_event_filter_test.c        | 80 +++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c=
 b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > index 63f85f583ef8..1872b848f734 100644
> > --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > @@ -27,6 +27,7 @@
> >  #define ARCH_PERFMON_BRANCHES_RETIRED                5
> >
> >  #define NUM_BRANCHES 42
> > +#define INTEL_PMC_IDX_FIXED          32
> >
> >  /* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
> >  #define MAX_FILTER_EVENTS            300
> > @@ -805,6 +806,84 @@ static void test_filter_ioctl(struct kvm_vcpu *vcp=
u)
> >       TEST_ASSERT(!r, "Masking non-existent fixed counters should be al=
lowed");
> >  }
> >
> > +static void intel_run_fixed_counter_guest_code(uint8_t fixed_ctr_idx)
> > +{
> > +     for (;;) {
> > +             wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> > +             wrmsr(MSR_CORE_PERF_FIXED_CTR0 + fixed_ctr_idx, 0);
> > +
> > +             /* Only OS_EN bit is enabled for fixed counter[idx]. */
> > +             wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, BIT_ULL(4 * fixed_ctr=
_idx));
> > +             wrmsr(MSR_CORE_PERF_GLOBAL_CTRL,
> > +                   BIT_ULL(INTEL_PMC_IDX_FIXED + fixed_ctr_idx));
> > +             __asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES})=
);
> > +             wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> > +
> > +             GUEST_SYNC(rdmsr(MSR_CORE_PERF_FIXED_CTR0 + fixed_ctr_idx=
));
> > +     }
> > +}
> > +
> > +static uint64_t test_with_fixed_counter_filter(struct kvm_vcpu *vcpu,
> > +                                            uint32_t action, uint32_t =
bitmap)
> > +{
> > +     struct __kvm_pmu_event_filter f =3D {
> > +             .action =3D action,
> > +             .fixed_counter_bitmap =3D bitmap,
> > +     };
> > +     do_vcpu_set_pmu_event_filter(vcpu, &f);
> > +
> > +     return run_vcpu_to_sync(vcpu);
> > +}
> > +
> > +static void __test_fixed_counter_bitmap(struct kvm_vcpu *vcpu, uint8_t=
 idx,
> > +                                     uint8_t nr_fixed_counters)
> > +{
> > +     unsigned int i;
> > +     uint32_t bitmap;
> > +     uint64_t count;
> > +
> > +     TEST_ASSERT(nr_fixed_counters < sizeof(bitmap),
>
> sizeof(bitmap) * 8?

Thank you for pointing this out. You are correct that we should
compare the number of fixed counters with the number of bits in the
bitmap variable, not its byte size. I will update the test as follows:

TEST_ASSERT(nr_fixed_counters < sizeof(bitmap) * 8,

This ensures that nr_fixed_counters does not exceed the number of bits
that the bitmap variable can represent (i.e., 32 bits).

>
> > +                 "Invalid nr_fixed_counters");
> > +
> > +     /*
> > +      * Check the fixed performance counter can count normally when KV=
M
> > +      * userspace doesn't set any pmu filter.
> > +      */
> > +     count =3D run_vcpu_to_sync(vcpu);
> > +     TEST_ASSERT(count, "Unexpected count value: %ld\n", count);
> > +
> > +     for (i =3D 0; i < BIT(nr_fixed_counters); i++) {
> > +             bitmap =3D BIT(i);
> > +             count =3D test_with_fixed_counter_filter(vcpu, KVM_PMU_EV=
ENT_ALLOW,
> > +                                                    bitmap);
> > +             ASSERT_EQ(!!count, !!(bitmap & BIT(idx)));
> > +
> > +             count =3D test_with_fixed_counter_filter(vcpu, KVM_PMU_EV=
ENT_DENY,
> > +                                                    bitmap);
> > +             ASSERT_EQ(!!count, !(bitmap & BIT(idx)));
> > +     }
> > +}
> > +
> > +static void test_fixed_counter_bitmap(void)
> > +{
> > +     uint8_t nr_fixed_counters =3D kvm_cpu_property(X86_PROPERTY_PMU_N=
R_FIXED_COUNTERS);
> > +     struct kvm_vm *vm;
> > +     struct kvm_vcpu *vcpu;
> > +     uint8_t idx;
> > +
> > +     /*
> > +      * Check that pmu_event_filter works as expected when it's applie=
d to
> > +      * fixed performance counters.
> > +      */
> > +     for (idx =3D 0; idx < nr_fixed_counters; idx++) {
> > +             vm =3D vm_create_with_one_vcpu(&vcpu,
> > +                                          intel_run_fixed_counter_gues=
t_code);
> > +             vcpu_args_set(vcpu, 1, idx);
> > +             __test_fixed_counter_bitmap(vcpu, idx, nr_fixed_counters)=
;
> > +             kvm_vm_free(vm);
> > +     }
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >       void (*guest_code)(void);
> > @@ -848,6 +927,7 @@ int main(int argc, char *argv[])
> >       kvm_vm_free(vm);
> >
> >       test_pmu_config_disable(guest_code);
> > +     test_fixed_counter_bitmap();
> >
> >       return 0;
> >  }
> > --
> > 2.39.3
> >
>
> --
> Isaku Yamahata <isaku.yamahata@gmail.com>
