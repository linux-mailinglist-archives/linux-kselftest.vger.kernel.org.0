Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22685758BFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 05:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjGSDVJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 23:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGSDVI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 23:21:08 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2D31BDD;
        Tue, 18 Jul 2023 20:21:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-51e99584a82so8725061a12.1;
        Tue, 18 Jul 2023 20:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689736865; x=1692328865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qio6pzOCmaXDOiQChQf7WzygxDgvq1z60uM5r+IDyqY=;
        b=Y2aUVkMBihFO9W2ebrAbF83gFoTV8pv2h0CasKOz7w2rnrjkU3q4qLMH1WffzyCDvQ
         TpW9L/jmf9/4ZK8IFVPCCZnwRVemTS1YS9+cLDpx+d3JZDYFOQvxn/QKETpqLfjAQ86X
         KvPCA9NwvoViVru65MbhLgqzE4TRz18Bd1M3dnpBvZAypWPAZdaZn0SMDBopziEFMkRo
         tGkRXXtw5KepS72fszxopa4FrxSftLvUF6spR0iTDGJp62Wb731J+4lsQJlY+H5D3J1C
         U6TOepFXm8jC0sjXeuBmyipIpXKcTMQ4Ngg3+nBeZ69usw6/lIypnvZ0qVQI08jsJWSm
         75NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689736865; x=1692328865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qio6pzOCmaXDOiQChQf7WzygxDgvq1z60uM5r+IDyqY=;
        b=R5HnbtppeGoKbQXFTl4nMX/o/kido3mVdmDm1OlZpQt5X7o/+PyBQwxp6igOFnZ91R
         eeHjBdukm/AgcmAqxCc31+CcUZMAciJfFEb1NxNusi12pmWgc/R0ENaIJDLJIlKbIVnF
         BB/OGNVZCkmx3kpcq+Pw0211KLtPdgBtH73IZtNihYMTM9KchtfW1yBzNzclWU4N5KHF
         BUbD9Dss0zPIXIUnxw5bqH4Al1Hqnd6Hucbe5oM8/7D8h7oPW4pWN17dqjkCn03MGFD+
         c30XLKih8vqi/x3L0uqdOXI37qaRcEi/+S4yp4AEdrVJMPVESmNgEj+AJXlYsk98i0/6
         sWEg==
X-Gm-Message-State: ABy/qLbpV2MS/LaqR3pUB6Gaiume1ELpe21P2lwaBlckV2F8w77xNDEL
        0TnNSYf0dZf6yzxgHaY+8w9Hvy1bGP4iHxySL5HS6wMGjdezDlBj2j0=
X-Google-Smtp-Source: APBJJlFwCKXpF3myWTSDWY2nVDhSk8KLhh0BEsHLVhIX9+VFk6oyw1eMiipLY6JReFZ+zCIuS4p/6nl3izKeExS/PEU=
X-Received: by 2002:aa7:d418:0:b0:51e:2282:e1fc with SMTP id
 z24-20020aa7d418000000b0051e2282e1fcmr1518758edq.6.1689736865579; Tue, 18 Jul
 2023 20:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230717062343.3743-1-cloudliang@tencent.com> <20230717062343.3743-5-cloudliang@tencent.com>
 <20230719011752.GD25699@ls.amr.corp.intel.com>
In-Reply-To: <20230719011752.GD25699@ls.amr.corp.intel.com>
From:   Jinrong Liang <ljr.kernel@gmail.com>
Date:   Wed, 19 Jul 2023 11:20:54 +0800
Message-ID: <CAFg_LQVA=u+WM3_xK5+KiAz5R=-nZ3jdQbX0jsBmrw7_6+ZWew@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] KVM: selftests: Add test cases for unsupported PMU
 event filter input values
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
9=E6=97=A5=E5=91=A8=E4=B8=89 09:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 17, 2023 at 02:23:41PM +0800,
> Jinrong Liang <ljr.kernel@gmail.com> wrote:
>
> > From: Jinrong Liang <cloudliang@tencent.com>
> >
> > Add test cases to verify the handling of unsupported input values for t=
he
> > PMU event filter. The tests cover unsupported "action" values, unsuppor=
ted
> > "flags" values, and unsupported "nevents" values. All these cases shoul=
d
> > return an error, as they are currently not supported by the filter.
> > Furthermore, the tests also cover the scenario where setting non-existe=
nt
> > fixed counters in the fixed bitmap does not fail.
> >
> > Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> > ---
> >  .../kvm/x86_64/pmu_event_filter_test.c        | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c=
 b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > index ffcbbf25b29b..63f85f583ef8 100644
> > --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > @@ -32,6 +32,10 @@
> >  #define MAX_FILTER_EVENTS            300
> >  #define MAX_TEST_EVENTS              10
> >
> > +#define PMU_EVENT_FILTER_INVALID_ACTION              (KVM_PMU_EVENT_DE=
NY + 1)
> > +#define PMU_EVENT_FILTER_INVALID_FLAGS                       (KVM_PMU_=
EVENT_FLAG_MASKED_EVENTS + 1)
>
> flag is a bit mask. Not number. So +1 sounds weird.
> As KVM_PMU_EVENT_FLAGS_VALID_MASK =3D 1,  this happens to get wanted resu=
lt, though.

We need an invalid flags, KVM_PMU_EVENT_FLAGS_VALID_MASK is actually
equal to KVM_PMU_EVENT_FLAG_MASKED_EVENTS.

In kvm.h:

#define KVM_PMU_EVENT_FLAG_MASKED_EVENTS BIT(0)
#define KVM_PMU_EVENT_FLAGS_VALID_MASK (KVM_PMU_EVENT_FLAG_MASKED_EVENTS)

How about this modification:

#define PMU_EVENT_FILTER_INVALID_FLAGS
(KVM_PMU_EVENT_FLAGS_VALID_MASK << 1)

>
>
> > +#define PMU_EVENT_FILTER_INVALID_NEVENTS             (MAX_FILTER_EVENT=
S + 1)
> > +
> >  /*
> >   * This is how the event selector and unit mask are stored in an AMD
> >   * core performance event-select register. Intel's format is similar,
> > @@ -757,6 +761,8 @@ static int set_pmu_single_event_filter(struct kvm_v=
cpu *vcpu, uint64_t event,
> >
> >  static void test_filter_ioctl(struct kvm_vcpu *vcpu)
> >  {
> > +     uint8_t nr_fixed_counters =3D kvm_cpu_property(X86_PROPERTY_PMU_N=
R_FIXED_COUNTERS);
> > +     struct __kvm_pmu_event_filter f;
> >       uint64_t e =3D ~0ul;
> >       int r;
> >
> > @@ -777,6 +783,26 @@ static void test_filter_ioctl(struct kvm_vcpu *vcp=
u)
> >                                       KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
> >                                       KVM_PMU_EVENT_ALLOW);
> >       TEST_ASSERT(r =3D=3D 0, "Valid PMU Event Filter is failing");
> > +
> > +     f =3D base_event_filter;
> > +     f.action =3D PMU_EVENT_FILTER_INVALID_ACTION;
> > +     r =3D do_vcpu_set_pmu_event_filter(vcpu, &f);
> > +     TEST_ASSERT(r, "Set invalid action is expected to fail");
> > +
> > +     f =3D base_event_filter;
> > +     f.flags =3D PMU_EVENT_FILTER_INVALID_FLAGS;
> > +     r =3D do_vcpu_set_pmu_event_filter(vcpu, &f);
> > +     TEST_ASSERT(r, "Set invalid flags is expected to fail");
> > +
> > +     f =3D base_event_filter;
> > +     f.nevents =3D PMU_EVENT_FILTER_INVALID_NEVENTS;
> > +     r =3D do_vcpu_set_pmu_event_filter(vcpu, &f);
> > +     TEST_ASSERT(r, "Exceeding the max number of filter events should =
fail");
> > +
> > +     f =3D base_event_filter;
> > +     f.fixed_counter_bitmap =3D ~GENMASK_ULL(nr_fixed_counters, 0);
> > +     r =3D do_vcpu_set_pmu_event_filter(vcpu, &f);
> > +     TEST_ASSERT(!r, "Masking non-existent fixed counters should be al=
lowed");
> >  }
> >
> >  int main(int argc, char *argv[])
> > --
> > 2.39.3
> >
>
> --
> Isaku Yamahata <isaku.yamahata@gmail.com>
