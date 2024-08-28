Return-Path: <linux-kselftest+bounces-16597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C86C96354C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 01:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DD11C21BE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 23:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6C41AD413;
	Wed, 28 Aug 2024 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzwBazdX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CD146A63
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887170; cv=none; b=qyLiZU3mnagSGZbtghw+JA1YKxTBQSEa7O0dZouYBdGJgjgR0jJVY8UAGwutPrdPbeA8hWjtc/7pmW6CLfn71dPDFnrAgotUrtZJvGWuS6Wt9QqmePSQnj4vzo2Q6Tm80DR7eRrK0eSnAsX7zuBBonrkk4WyajAE+boGK0yILDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887170; c=relaxed/simple;
	bh=hm7GZNTswuPv5GCl6lACd5JZlOhWbnypAH1lOjarlDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nd49iR7RZMe1q4H9Q9Mp2LQGMwGo8N9VtSQHni8Nil6dl1ObQPNISCDrNU6OM4y9D7gP9rlkeD4RxDrDJmqI2HZzhyFqkkhGwUGoVIWHAVhM03UbchmvfuExENdQ0Fx0Ap8XjePIYWzAfxZC2i2C5OMxKSG4zWgIY02WfQy4gHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzwBazdX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334c4d6829so9817e87.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 16:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724887166; x=1725491966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNlAkoIxnuZyyx2dmTBHnX4pvxs+uFgexikwPmFLMC0=;
        b=XzwBazdXDtqVITOuCi45Z6hOeco9xS/uZKRhxpoipdppFaewPyzM0EOqgnCECZa0yF
         P+KkN1R42tzna0QK0F1fhxt5X889OrMIvlYpanwaP7J+grahrtdBTRHUf6XLEqXqq6dO
         U49LixJTmB6gB9XRVWkvTntB8lA2MKmkw9W5OaiQ+QW+p+shRG674DHT6LPFzJTKCSLK
         fufmAh9pPu6QV8ST9egAfjpJjNsjcYxBkZwFnWD7QSVqch8Dsg/OGL/1R4QySmD0cQfT
         ms/hCx62PeBtLzP5eJm2jBkvVJgw49uqZk/gbENYFKMhYpmmt/cpYty0AAaSK6AZWy7S
         3KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887166; x=1725491966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNlAkoIxnuZyyx2dmTBHnX4pvxs+uFgexikwPmFLMC0=;
        b=MlHJJupLEdA6cO21QmtFDiN5R0wXl4tPBYaoX09Hk8DYRHHFrx/RRFlstBPATCLzdR
         qP1zmVffWHRcfYdiVBrbBYSWcavVGRHBsi1Jk7HtvPRPxzJ3TRMlYLgp4CWdyHOZTyzw
         AVmBVA4sagHKbj9+Hsmo5SKMuDmRhvH+rdUztXVXSImu8ALpBr4iSI5AZHFoP8Blresx
         +CF2BAXJG1FvVg+JyHkofLmtf0Nm5U3EiEZmJv9Gk68rMGE1X9s++jkjK9q13UQ8V1Xp
         0At5p3AB09VfJVl8JNjz4XtrghgxCJH81RlKJ8ghWCID4Uf+AZIFS7sPtTIeGU1dtyUS
         3DXg==
X-Forwarded-Encrypted: i=1; AJvYcCVxZpsfX1/a4apLBoQhJNTxiPM8ZWhRojnVa1j3pHqV7E/8pqZPAo0X2sI485IYh5c1Z+F4H3z6powoCI602s8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76DpFccDyERen+zWazkbDLvDxkrBlL/l4qb5u79wKoPfqEI5b
	ym03bg33+T2QvKo1+u/m0bADR8YFb7HtHknTch/3khBOz1Vv+Ae5YdDAAQWWN49tinE6IN/rHmo
	nZdYmoaPiXPJL7U0cp8mIJxfKRCNpj3eFPfR0
X-Google-Smtp-Source: AGHT+IFFLN/wqlx4Jz8OZ2JDMPY2RQ7DvMRY74f9HU9wYEOEtozJHKGiFY/Nd2PR0qrqhABZ4q/2QmIOww3yav9bePw=
X-Received: by 2002:a05:6512:10d1:b0:52f:c13f:23d2 with SMTP id
 2adb3069b0e04-5353e574183mr425741e87.25.1724887166175; Wed, 28 Aug 2024
 16:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zs0FLglChWqsGa6w@google.com> <gsnth6b49srd.fsf@coltonlewis-kvm.c.googlers.com>
In-Reply-To: <gsnth6b49srd.fsf@coltonlewis-kvm.c.googlers.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Wed, 28 Aug 2024 16:18:50 -0700
Message-ID: <CAL715W+NPP+mw=_C4b-4iUhML6yVZ=G3uMqXQgY+tjqRrNQusg@mail.gmail.com>
Subject: Re: [PATCH 3/6] KVM: x86: selftests: Set up AMD VM in pmu_counters_test
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, ljr.kernel@gmail.com, jmattson@google.com, 
	aaronlewis@google.com, seanjc@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:39=E2=80=AFPM Colton Lewis <coltonlewis@google.co=
m> wrote:
>
> Hi Mingwei
>
> Mingwei Zhang <mizhang@google.com> writes:
>
> > On Tue, Aug 13, 2024, Colton Lewis wrote:
> >> Branch in main() depending on if the CPU is Intel or AMD. They are
> >> subject to vastly different requirements because the AMD PMU lacks
> >> many properties defined by the Intel PMU including the entire CPUID
> >> 0xa function where Intel stores all the PMU properties. AMD lacks this
> >> as well as any consistent notion of PMU versions as Intel does. Every
> >> feature is a separate flag and they aren't the same features as Intel.
>
> >> Set up a VM for testing core AMD counters and ensure proper CPUID
> >> features are set.
>
> >> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> >> ---
> >>   .../selftests/kvm/x86_64/pmu_counters_test.c  | 80 ++++++++++++++++-=
--
> >>   1 file changed, 68 insertions(+), 12 deletions(-)
>
> >> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> >> b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> >> index 0e305e43a93b..a11df073331a 100644
> >> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> >> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> >> @@ -33,7 +33,7 @@
> >>   static uint8_t kvm_pmu_version;
> >>   static bool kvm_has_perf_caps;
>
> >> -static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu
> >> **vcpu,
> >> +static struct kvm_vm *intel_pmu_vm_create(struct kvm_vcpu **vcpu,
> >>                                                void *guest_code,
> >>                                                uint8_t pmu_version,
> >>                                                uint64_t perf_capabilit=
ies)
> >> @@ -303,7 +303,7 @@ static void test_arch_events(uint8_t pmu_version,
> >> uint64_t perf_capabilities,
> >>      if (!pmu_version)
> >>              return;
>
> >> -    vm =3D pmu_vm_create_with_one_vcpu(&vcpu, guest_test_arch_events,
> >> +    vm =3D intel_pmu_vm_create(&vcpu, guest_test_arch_events,
> >>                                       pmu_version, perf_capabilities);
>
> >>      vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EBX_BIT_VECTOR_LEN=
GTH,
> >> @@ -463,7 +463,7 @@ static void test_gp_counters(uint8_t pmu_version,
> >> uint64_t perf_capabilities,
> >>      struct kvm_vcpu *vcpu;
> >>      struct kvm_vm *vm;
>
> >> -    vm =3D pmu_vm_create_with_one_vcpu(&vcpu, guest_test_gp_counters,
> >> +    vm =3D intel_pmu_vm_create(&vcpu, guest_test_gp_counters,
> >>                                       pmu_version, perf_capabilities);
>
> >>      vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_GP_COUNTERS,
> >> @@ -530,7 +530,7 @@ static void test_fixed_counters(uint8_t pmu_versio=
n,
> >> uint64_t perf_capabilities,
> >>      struct kvm_vcpu *vcpu;
> >>      struct kvm_vm *vm;
>
> >> -    vm =3D pmu_vm_create_with_one_vcpu(&vcpu, guest_test_fixed_counte=
rs,
> >> +    vm =3D intel_pmu_vm_create(&vcpu, guest_test_fixed_counters,
> >>                                       pmu_version, perf_capabilities);
>
> >>      vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_FIXED_COUNTERS_BIT=
MASK,
> >> @@ -627,18 +627,74 @@ static void test_intel_counters(void)
> >>      }
> >>   }
>
> >> -int main(int argc, char *argv[])
> >> +static uint8_t nr_core_counters(void)
> >>   {
> >> -    TEST_REQUIRE(kvm_is_pmu_enabled());
> >> +    const uint8_t nr_counters =3D
> >> kvm_cpu_property(X86_PROPERTY_NUM_PERF_CTR_CORE);
> >> +    const bool core_ext =3D kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE=
);
> >> +    /* The default numbers promised if the property is 0 */
> >> +    const uint8_t amd_nr_core_ext_counters =3D 6;
> >> +    const uint8_t amd_nr_core_counters =3D 4;
> >> +
> >> +    if (nr_counters !=3D 0)
> >> +            return nr_counters;
> >> +
> >> +    if (core_ext)
> >> +            return amd_nr_core_ext_counters;
> >> +
> >> +    return amd_nr_core_counters;
> >> +}
> >> +
> >> +static void guest_test_core_counters(void)
> >> +{
> >> +    GUEST_DONE();
> >> +}
>
> >> -    TEST_REQUIRE(host_cpu_is_intel);
> >> -    TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
> >> -    TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
> >> +static void test_core_counters(void)
> >> +{
> >> +    uint8_t nr_counters =3D nr_core_counters();
> >> +    bool core_ext =3D kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
> >> +    bool perf_mon_v2 =3D kvm_cpu_has(X86_FEATURE_PERF_MON_V2);
> >> +    struct kvm_vcpu *vcpu;
> >> +    struct kvm_vm *vm;
>
> >> -    kvm_pmu_version =3D kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
> >> -    kvm_has_perf_caps =3D kvm_cpu_has(X86_FEATURE_PDCM);
> >> +    vm =3D vm_create_with_one_vcpu(&vcpu, guest_test_core_counters);
>
> >> -    test_intel_counters();
> >> +    /* This property may not be there in older underlying CPUs,
> >> +     * but it simplifies the test code for it to be set
> >> +     * unconditionally.
> >> +     */
> >> +    vcpu_set_cpuid_property(vcpu, X86_PROPERTY_NUM_PERF_CTR_CORE,
> >> nr_counters);
> >> +    if (core_ext)
> >> +            vcpu_set_cpuid_feature(vcpu, X86_FEATURE_PERF_CTR_EXT_COR=
E);
> >> +    if (perf_mon_v2)
> >> +            vcpu_set_cpuid_feature(vcpu, X86_FEATURE_PERF_MON_V2);
>
> > hmm, I think this might not be enough. So, when the baremetal machine
> > supports Perfmon v2, this code is just testing v2. But we should be abl=
e
> > to test anything below v2, ie., v1, v1 without core_ext. So, three
> > cases need to be tested here: v1 with 4 counters; v1 with core_ext (6
> > counters); v2.
>
> > If, the machine running this selftest does not support v2 but it does
> > support core extension, then we fall back to test v1 with 4 counters an=
d
> > v1 with 6 counters.
>
> This should cover all cases the way I wrote it. I detect the number of
> counters in nr_core_counters(). That tells me if I am dealing with 4 or
> 6 and then I set the cpuid property based on that so I can read that
> number in later code instead of duplicating the logic.

right. in the current code, you set up the counters properly according
to the hw capability. But the test can do more on a hw with perfmon
v2, right? Because it can test multiple combinations of setup for a
VM: say v1 + 4 counters and v1 + 6 counters etc. I am just following
the style of this selftest on Intel side, in which they do a similar
kind of enumeration of PMU version + PDCM capabilities. In each
configuration, it will invoke a VM and do the test.

>
> I could always inline nr_core_counters() to make this more obvious since
> it is only called in this function. It was one of the first bits of code
> I wrote working on this series and I assumed I would need to call it a
> bunch before I decided I could just set the cpuid property after calling
> it once.
>
> >> +
> >> +    pr_info("Testing core counters: CoreExt =3D %u, PerfMonV2 =3D %u,
> >> NumCounters =3D %u\n",
> >> +            core_ext, perf_mon_v2, nr_counters);
> >> +    run_vcpu(vcpu);
> >> +
> >> +    kvm_vm_free(vm);
> >> +}
> >> +
> >> +static void test_amd_counters(void)
> >> +{
> >> +    test_core_counters();
> >> +}
> >> +
> >> +int main(int argc, char *argv[])
> >> +{
> >> +    TEST_REQUIRE(kvm_is_pmu_enabled());
> >> +
> >> +    if (host_cpu_is_intel) {
> >> +            TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
> >> +            TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) >=
 0);
> >> +            kvm_pmu_version =3D kvm_cpu_property(X86_PROPERTY_PMU_VER=
SION);
> >> +            kvm_has_perf_caps =3D kvm_cpu_has(X86_FEATURE_PDCM);
> >> +            test_intel_counters();
> >> +    } else if (host_cpu_is_amd) {
> >> +            /* AMD CPUs don't have the same properties to look at. */
> >> +            test_amd_counters();
> >> +    }
>
> >>      return 0;
> >>   }
> >> --
> >> 2.46.0.76.ge559c4bf1a-goog
>

