Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D87437CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjF3I7Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 04:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjF3I7X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 04:59:23 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394122118;
        Fri, 30 Jun 2023 01:59:22 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-991fe70f21bso188179966b.3;
        Fri, 30 Jun 2023 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688115560; x=1690707560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XyG9hWncrHnC6M9gFUR394kLaY92tagFHZ9PMVjGOw=;
        b=GYibKrN0wEDbK/0c8BH9qnz99L8rnbH7azC9dHW1F03iQ/ZAkiOULDAlgDVoiAT3o9
         TDkk5DdokomN1jTxujVFwb4KgMP6pJq3F1B6v7TwEAzxmSBxVmYk0qvxUB5+WUP4UnBN
         BJR5XL+MpDficKPropC5unNZwytJAPb3l+UGx37q51jJx2wgvun2nxHm/2WPrUzw9HN/
         BolrZK7DUS3eZU3G8pHPeSuxWZZxe/iv0xg920KPsKwZtVgPsSTJtuj0gZDkSvmLp6xm
         HbGM1nLcmd+RnYPiHKnYa1mzBnqry3e+gtrgcBWdaR6vT3GoyWLeP462eoiG0egAp5KN
         N7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688115560; x=1690707560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XyG9hWncrHnC6M9gFUR394kLaY92tagFHZ9PMVjGOw=;
        b=JDwiqAqszL2fmhvWR6MaI6bRjlNzUvgPw9MfFPpNoTKb7Yi9xlCmeeM96nVgWwNnRF
         Vaetyl7gmsYykJm08wqRCTt6zkCGk/czqUayttllvviQHmt0cH/i3uYwrRS8iIC1N3HZ
         ESbTmdRWF5OFYE3Q8WQ7U+s03koVLH+yPX05CmNtU1LyuELS8xIjtb0c4gY40UbV/F74
         Dl8ISScTwxABxWhswitBEWBtk5fbL3THBW7fu/hMmVBu1akuyQSDRdolaNKn0UjVFUdl
         l0+OA24hza2HXXHuE6xck6P7niuEgggD170qJ7zTyTrNsfRLEm+JIw9yP9aDamtCL2lI
         7y5A==
X-Gm-Message-State: ABy/qLZY5aiONULg8uIbamW+1CmiG+d3UhIU6TVckAjK97vkd1eWTQ92
        jBtZBB8aMFgyItFzkUYo26Nxt5TVcSWnOd3hBi0=
X-Google-Smtp-Source: APBJJlEp4+UUDkOh9/yDHTg+SwOatqJkJzuotF+phusYUk/Vj2XurBYpoIEerHYEX5FwBBJoQCw0JJOjLoJc/zU9Npc=
X-Received: by 2002:a17:906:340a:b0:970:1b2d:45cc with SMTP id
 c10-20020a170906340a00b009701b2d45ccmr1217441ejb.57.1688115560344; Fri, 30
 Jun 2023 01:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230608113420.14695-1-cloudliang@tencent.com>
 <20230608113420.14695-3-cloudliang@tencent.com> <ZJysUp5Ndnecok4S@google.com>
In-Reply-To: <ZJysUp5Ndnecok4S@google.com>
From:   Jinrong Liang <ljr.kernel@gmail.com>
Date:   Fri, 30 Jun 2023 16:59:08 +0800
Message-ID: <CAFg_LQWdtWMn0HyKpBZH+fQfeBdEAq1fxDnekcw04pXFMqOJ3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Add PEBS test for MSR_IA32_PERF_CAPABILITIES
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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

Sean Christopherson <seanjc@google.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8829=
=E6=97=A5=E5=91=A8=E5=9B=9B 05:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 08, 2023, Jinrong Liang wrote:
> > From: Jinrong Liang <cloudliang@tencent.com>
> >
> > This commit adds a PEBS test that verifies all possible combinations
> > of PEBS-related bits in MSR_IA32_PERF_CAPABILITIES. This comprehensive
> > test ensures the accuracy of the PEBS feature.
> >
> > Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> > ---
> >  .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/t=
ools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> > index 02903084598f..c1b1ba44bc26 100644
> > --- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> > @@ -21,6 +21,12 @@
> >
> >  #define MAX_LINEAR_ADDR_MASK         GENMASK_ULL(15, 8)
> >  #define ADDR_OFS_BIT                 8
> > +#define PMU_CAP_LBR_FMT              0x3f
> > +#define PMU_CAP_SMM_FREEZE           BIT_ULL(12)
> > +#define PMU_CAP_FW_WRITES            BIT_ULL(13)
> > +#define PMU_CAP_PERF_METRICS_AVAILABLE       BIT_ULL(PERF_CAP_METRICS_=
IDX)
> > +#define PMU_CAP_PEBS_OUTPUT_PT_AVAIL BIT_ULL(PERF_CAP_PT_IDX)
> > +#define PMU_CAP_PEBS_ALL             (PERF_CAP_PEBS_MASK | PMU_CAP_PEB=
S_OUTPUT_PT_AVAIL)
> >
> >  union perf_capabilities {
> >       struct {
> > @@ -331,6 +337,70 @@ static void test_ds_area_noncanonical_address(unio=
n perf_capabilities host_cap)
> >       kvm_vm_free(vm);
> >  }
> >
> > +static void test_pebs_bit_combinations(union perf_capabilities host_ca=
p)
> > +{
> > +     int ret;
>
> Reverse xmas tree.
>
> > +     uint64_t pebs_val, val;
> > +     struct kvm_vcpu *vcpu;
> > +     struct kvm_vm *vm =3D vm_create_with_one_vcpu(&vcpu, NULL);
>
> It's kinda silly, but I think it makes sense to wait until after all of t=
he
> TEST_REQUIRE()s to create the VM+vCPU.
>
> > +
> > +     TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 1);
> > +     TEST_REQUIRE(host_cap.capabilities & PERF_CAP_PEBS_FORMAT);
> > +     TEST_REQUIRE(vcpu_get_msr(vcpu, MSR_IA32_MISC_ENABLE) &
> > +                  MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL);
> > +
> > +     /*
> > +      * Test if PEBS_REC_FMT is set and the value is the same as host,
> > +      * the other PEBS bits are allowed to be set only if they are the
> > +      * same as host.
> > +      */
> > +     pebs_val =3D host_cap.capabilities & PMU_CAP_PEBS_ALL;
> > +
> > +     vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, pebs_val);
> > +     ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES),
> > +               (u64)pebs_val);
>
> This cast shouldn't be necessary.  And if you're going to split lines...
>
>         ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES),
>                   host_cap.capabilities & PMU_CAP_PEBS_ALL);
>
> Though isn't that flawed?  E.g. will fail if MSR_IA32_PERF_CAPABILITIES h=
as
> non-PEBS bits set.  I think what you want is something like:
>
>         guest_perf_caps =3D vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES=
);
>
>         ASSERT_EQ(guest_perf_caps & PMU_CAP_PEBS_ALL,
>                   host_cap.capabilities & PMU_CAP_PEBS_ALL);
>
> > +
> > +     /* Test all PEBS bit combinations. */
> > +     for (val =3D 0x0; val <=3D (~0ul & PMU_CAP_PEBS_ALL); val++) {
> > +             /* Skips values that are not related to PEBS. */
> > +             if (val & (PMU_CAP_LBR_FMT | PMU_CAP_SMM_FREEZE |
> > +                 PMU_CAP_FW_WRITES | PMU_CAP_PERF_METRICS_AVAILABLE))
>
> Align things by their scope, i.e.
>
>                 if (val & (PMU_CAP_LBR_FMT | PMU_CAP_SMM_FREEZE
>                            PMU_CAP_FW_WRITES | PMU_CAP_PERF_METRICS_AVAIL=
ABLE))
>
> But even better would be to look for !PEBS, not some other values where i=
t's not
> clear they exhaustively cover all !PEBS value.  E.g. can't this be?
>
>                 if (val & ~PMU_CAP_PEBS_ALL)
>                         continue;
>
> > +                     continue;
> > +
> > +             /*
> > +              * Test that value of PEBS is rejected when the KVM doesn=
't
>
> Just "KVM", not "the KVM".
>
> > +              * supports Intel PT.
> > +              */
> > +             if ((val & PMU_CAP_PEBS_OUTPUT_PT_AVAIL) &&
> > +                 (!(host_cap.capabilities & PMU_CAP_PEBS_OUTPUT_PT_AVA=
IL))) {
> > +                     ret =3D _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABIL=
ITIES, val);
> > +                     TEST_ASSERT(!ret, "Bad PEBS auxiliary bits =3D 0x=
%lx didn't fail", val);
> > +
> > +                     continue;
> > +             }
> > +
> > +             /*
> > +              * Test that value of PEBS is rejected when carrying
>
> I don't quite follow what you mean by "carrying".  Do you mean a non-zero=
 value?

I apologize for the confusion. Yes, by "carrying" I meant a non-zero
value. I will revise the comment to clarify the meaning and make it
more precise.

>
> > +              * PEBS_REC_FMT if the value of PEBS is not equal to host=
.
> > +              */
> > +             if ((val & PERF_CAP_PEBS_FORMAT) && val !=3D pebs_val) {
> > +                     ret =3D _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABIL=
ITIES, val);
> > +                     TEST_ASSERT(!ret, "Bad PEBS auxiliary bits =3D 0x=
%lx didn't fail", val);
> > +
> > +                     continue;
> > +             }
> > +
> > +             /*
> > +              * Test that PEBS bits can be written simultaneously or
> > +              * independently if PEBS_REC_FMT is not carried.
> > +              */
> > +             vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, val);
> > +             ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES),=
 val);
> > +     }
> > +
> > +     kvm_vm_free(vm);
> > +}

Thank you for all your valuable feedback and suggestions. Your
guidance has been extremely helpful in improving the quality of the
code.
