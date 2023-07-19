Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26882758C17
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 05:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjGSD3F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 23:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjGSD2i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 23:28:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBE23ABD;
        Tue, 18 Jul 2023 20:27:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso10660287e87.0;
        Tue, 18 Jul 2023 20:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689737230; x=1692329230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T27lW/IFYnc+mInlhV3C6crQROEaMWng9NOrvyJj8Fs=;
        b=dbTKujg5aaRvV24uG6GJAeHAWBZoxmFuehuFLX4dG0r8rsQo7jhTkL2ITFC0zbseX4
         VHfZm175+zCWC5nUNl+XumC2jSqszSn7apxuVp1Z+dMv48VPvkH2q4ZYbBgp1cN7OSM6
         qdM44cgTfaE8TGUoVVjF5zUYYq8+ywMhWu/UVd7N30zxySwwrphofYlYJvE5i+xUylSl
         hPr4WnKkVcohMed2s00HHDrJVnAXr8CEkxmF9Y1Qh8G3rYDmOBeqDub1/GEeJQlsvRl+
         T6jKgnzoRo4NYM69INEv4qhltizOjMBTuVMnDMOEWlWxyUAC50yyzC7C2853sDvhclBF
         9RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689737230; x=1692329230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T27lW/IFYnc+mInlhV3C6crQROEaMWng9NOrvyJj8Fs=;
        b=OLjZuFQLXkWYo7DF3EklXRt53YrLmLVGxCxHt/1chLjpH7q97RUA2D6xBe+P6zWTiq
         4kR48uIkh0f9hRihUNTe89P4r7SpnjLLcitUywLjSgMFjjhY4sicIlNfW1wrVbrXBL3j
         iSHPxqjFOXUwGDNtA/Y/4/bljAzQINbewD3iepLjiccNlg5kK+vUV30A72TKVerNBuAm
         ah6UvVetHzWTm3AS7b/SXItnJbrbM2Czi4477TtiO6NDKq9bCA0fEiteykXV/B9rxu8N
         GhjWnGXaLuptp1dwgzJBQMIBy7sW1T457TMJcBuvdEoqGz+JLx3obUG4p8AJonT4qx5i
         8UEA==
X-Gm-Message-State: ABy/qLZDxw/PpaGDsH/YhjhdI00OvE4MCFEnW44FbXj+/a3x9BtdxjB6
        IgvU6frtJE6zBMyHfPvy67toUhRKxxjlLRJA+J/AvTVzKHT1rw==
X-Google-Smtp-Source: APBJJlHrO4H619uYtcfclW4M+aOuvvK0Bi1u13xQvN8qN/fJOz0UJSVdI1wE2UvITWIj6AeuomGGmSTv4WlDnCbc+qM=
X-Received: by 2002:a05:6512:b18:b0:4fb:52f1:9ab4 with SMTP id
 w24-20020a0565120b1800b004fb52f19ab4mr982334lfu.50.1689737229709; Tue, 18 Jul
 2023 20:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230717062343.3743-1-cloudliang@tencent.com> <20230717062343.3743-4-cloudliang@tencent.com>
 <20230719000245.GC25699@ls.amr.corp.intel.com>
In-Reply-To: <20230719000245.GC25699@ls.amr.corp.intel.com>
From:   Jinrong Liang <ljr.kernel@gmail.com>
Date:   Wed, 19 Jul 2023 11:26:58 +0800
Message-ID: <CAFg_LQXYvFdpfRfGByTOipwc7YAtyU3Lk6gmuhDuMsRwATNSgQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] KVM: selftests: Introduce __kvm_pmu_event_filter
 to improved event filter settings
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Isaku Yamahata <isaku.yamahata@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=881=
9=E6=97=A5=E5=91=A8=E4=B8=89 08:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 17, 2023 at 02:23:40PM +0800,
> Jinrong Liang <ljr.kernel@gmail.com> wrote:
>
> > From: Jinrong Liang <cloudliang@tencent.com>
> >
> > Add custom "__kvm_pmu_event_filter" structure to improve pmu event
> > filter settings. Simplifies event filter setup by organizing event
> > filter parameters in a cleaner, more organized way.
> >
> > Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> > ---
> >  .../kvm/x86_64/pmu_event_filter_test.c        | 179 +++++++++---------
> >  1 file changed, 87 insertions(+), 92 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c=
 b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > index 5ac05e64bec9..ffcbbf25b29b 100644
> > --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > @@ -28,6 +28,10 @@
> >
> >  #define NUM_BRANCHES 42
> >
> > +/* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
> > +#define MAX_FILTER_EVENTS            300
> > +#define MAX_TEST_EVENTS              10
> > +
> >  /*
> >   * This is how the event selector and unit mask are stored in an AMD
> >   * core performance event-select register. Intel's format is similar,
> > @@ -69,21 +73,33 @@
> >
> >  #define INST_RETIRED EVENT(0xc0, 0)
> >
> > +struct __kvm_pmu_event_filter {
> > +     __u32 action;
> > +     __u32 nevents;
> > +     __u32 fixed_counter_bitmap;
> > +     __u32 flags;
> > +     __u32 pad[4];
> > +     __u64 events[MAX_FILTER_EVENTS];
> > +};
> > +
> >  /*
> >   * This event list comprises Intel's eight architectural events plus
> >   * AMD's "retired branch instructions" for Zen[123] (and possibly
> >   * other AMD CPUs).
> >   */
> > -static const uint64_t event_list[] =3D {
> > -     EVENT(0x3c, 0),
> > -     INST_RETIRED,
> > -     EVENT(0x3c, 1),
> > -     EVENT(0x2e, 0x4f),
> > -     EVENT(0x2e, 0x41),
> > -     EVENT(0xc4, 0),
> > -     EVENT(0xc5, 0),
> > -     EVENT(0xa4, 1),
> > -     AMD_ZEN_BR_RETIRED,
> > +static const struct __kvm_pmu_event_filter base_event_filter =3D {
> > +     .nevents =3D ARRAY_SIZE(base_event_filter.events),
> > +     .events =3D {
> > +             EVENT(0x3c, 0),
> > +             INST_RETIRED,
> > +             EVENT(0x3c, 1),
> > +             EVENT(0x2e, 0x4f),
> > +             EVENT(0x2e, 0x41),
> > +             EVENT(0xc4, 0),
> > +             EVENT(0xc5, 0),
> > +             EVENT(0xa4, 1),
> > +             AMD_ZEN_BR_RETIRED,
> > +     },
> >  };
> >
> >  struct {
> > @@ -225,47 +241,11 @@ static bool sanity_check_pmu(struct kvm_vcpu *vcp=
u)
> >       return !r;
> >  }
> >
> > -static struct kvm_pmu_event_filter *alloc_pmu_event_filter(uint32_t ne=
vents)
> > -{
> > -     struct kvm_pmu_event_filter *f;
> > -     int size =3D sizeof(*f) + nevents * sizeof(f->events[0]);
> > -
> > -     f =3D malloc(size);
> > -     TEST_ASSERT(f, "Out of memory");
> > -     memset(f, 0, size);
> > -     f->nevents =3D nevents;
> > -     return f;
> > -}
> > -
> > -
> > -static struct kvm_pmu_event_filter *
> > -create_pmu_event_filter(const uint64_t event_list[], int nevents,
> > -                     uint32_t action, uint32_t flags)
> > -{
> > -     struct kvm_pmu_event_filter *f;
> > -     int i;
> > -
> > -     f =3D alloc_pmu_event_filter(nevents);
> > -     f->action =3D action;
> > -     f->flags =3D flags;
> > -     for (i =3D 0; i < nevents; i++)
> > -             f->events[i] =3D event_list[i];
> > -
> > -     return f;
> > -}
> > -
> > -static struct kvm_pmu_event_filter *event_filter(uint32_t action)
> > -{
> > -     return create_pmu_event_filter(event_list,
> > -                                    ARRAY_SIZE(event_list),
> > -                                    action, 0);
> > -}
> > -
> >  /*
> >   * Remove the first occurrence of 'event' (if any) from the filter's
> >   * event list.
> >   */
> > -static void remove_event(struct kvm_pmu_event_filter *f, uint64_t even=
t)
> > +static void remove_event(struct __kvm_pmu_event_filter *f, uint64_t ev=
ent)
> >  {
> >       bool found =3D false;
> >       int i;
> > @@ -313,66 +293,70 @@ static void test_without_filter(struct kvm_vcpu *=
vcpu)
> >  }
> >
> >  static void test_with_filter(struct kvm_vcpu *vcpu,
> > -                          struct kvm_pmu_event_filter *f)
> > +                          struct __kvm_pmu_event_filter *__f)
> >  {
> > +     struct kvm_pmu_event_filter *f =3D (void *)__f;
> > +
> >       vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
> >       run_vcpu_and_sync_pmc_results(vcpu);
> >  }
> >
> >  static void test_amd_deny_list(struct kvm_vcpu *vcpu)
> >  {
> > -     uint64_t event =3D EVENT(0x1C2, 0);
> > -     struct kvm_pmu_event_filter *f;
> > +     struct __kvm_pmu_event_filter f =3D base_event_filter;
> >
> > -     f =3D create_pmu_event_filter(&event, 1, KVM_PMU_EVENT_DENY, 0);
> > -     test_with_filter(vcpu, f);
> > -     free(f);
> > +     f.action =3D KVM_PMU_EVENT_DENY;
> > +     f.nevents =3D 1;
> > +     f.events[0] =3D EVENT(0x1C2, 0);
> > +     test_with_filter(vcpu, &f);
>
> This overwrite all members.  We can use designated initializer.
>         struct __kvm_pmu_event_filter f =3D {
>                 .action =3D KVM_PMU_EVENT_DENY,
>                 .nevents =3D 1,
>                 .events =3D {
>                         EVENT(0x1C2, 0),
>                 },
>         };

LGTM.

>
> Except this, looks good to me.
> Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Thanks,
>
> >
> >       ASSERT_PMC_COUNTING_INSTRUCTIONS();
> >  }
> >
> >  static void test_member_deny_list(struct kvm_vcpu *vcpu)
> >  {
> > -     struct kvm_pmu_event_filter *f =3D event_filter(KVM_PMU_EVENT_DEN=
Y);
> > +     struct __kvm_pmu_event_filter f =3D base_event_filter;
> >
> > -     test_with_filter(vcpu, f);
> > -     free(f);
> > +     f.action =3D KVM_PMU_EVENT_DENY;
> > +     test_with_filter(vcpu, &f);
> >
> >       ASSERT_PMC_NOT_COUNTING_INSTRUCTIONS();
> >  }
> >
> >  static void test_member_allow_list(struct kvm_vcpu *vcpu)
> >  {
> > -     struct kvm_pmu_event_filter *f =3D event_filter(KVM_PMU_EVENT_ALL=
OW);
> > +     struct __kvm_pmu_event_filter f =3D base_event_filter;
> >
> > -     test_with_filter(vcpu, f);
> > -     free(f);
> > +     f.action =3D KVM_PMU_EVENT_ALLOW;
> > +     test_with_filter(vcpu, &f);
> >
> >       ASSERT_PMC_COUNTING_INSTRUCTIONS();
> >  }
> >
> >  static void test_not_member_deny_list(struct kvm_vcpu *vcpu)
> >  {
> > -     struct kvm_pmu_event_filter *f =3D event_filter(KVM_PMU_EVENT_DEN=
Y);
> > +     struct __kvm_pmu_event_filter f =3D base_event_filter;
> > +
> > +     f.action =3D KVM_PMU_EVENT_DENY;
> >
> > -     remove_event(f, INST_RETIRED);
> > -     remove_event(f, INTEL_BR_RETIRED);
> > -     remove_event(f, AMD_ZEN_BR_RETIRED);
> > -     test_with_filter(vcpu, f);
> > -     free(f);
> > +     remove_event(&f, INST_RETIRED);
> > +     remove_event(&f, INTEL_BR_RETIRED);
> > +     remove_event(&f, AMD_ZEN_BR_RETIRED);
> > +     test_with_filter(vcpu, &f);
> >
> >       ASSERT_PMC_COUNTING_INSTRUCTIONS();
> >  }
> >
> >  static void test_not_member_allow_list(struct kvm_vcpu *vcpu)
> >  {
> > -     struct kvm_pmu_event_filter *f =3D event_filter(KVM_PMU_EVENT_ALL=
OW);
> > +     struct __kvm_pmu_event_filter f =3D base_event_filter;
> >
> > -     remove_event(f, INST_RETIRED);
> > -     remove_event(f, INTEL_BR_RETIRED);
> > -     remove_event(f, AMD_ZEN_BR_RETIRED);
> > -     test_with_filter(vcpu, f);
> > -     free(f);
> > +     f.action =3D KVM_PMU_EVENT_ALLOW;
> > +
> > +     remove_event(&f, INST_RETIRED);
> > +     remove_event(&f, INTEL_BR_RETIRED);
> > +     remove_event(&f, AMD_ZEN_BR_RETIRED);
> > +     test_with_filter(vcpu, &f);
> >
> >       ASSERT_PMC_NOT_COUNTING_INSTRUCTIONS();
> >  }
> > @@ -567,19 +551,16 @@ static void run_masked_events_test(struct kvm_vcp=
u *vcpu,
> >                                  const uint64_t masked_events[],
> >                                  const int nmasked_events)
> >  {
> > -     struct kvm_pmu_event_filter *f;
> > +     struct __kvm_pmu_event_filter f =3D {
> > +             .nevents =3D nmasked_events,
> > +             .action =3D KVM_PMU_EVENT_ALLOW,
> > +             .flags =3D KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
> > +     };
> >
> > -     f =3D create_pmu_event_filter(masked_events, nmasked_events,
> > -                                 KVM_PMU_EVENT_ALLOW,
> > -                                 KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
> > -     test_with_filter(vcpu, f);
> > -     free(f);
> > +     memcpy(f.events, masked_events, sizeof(uint64_t) * nmasked_events=
);
> > +     test_with_filter(vcpu, &f);
> >  }
> >
> > -/* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
> > -#define MAX_FILTER_EVENTS    300
> > -#define MAX_TEST_EVENTS              10
> > -
> >  #define ALLOW_LOADS          BIT(0)
> >  #define ALLOW_STORES         BIT(1)
> >  #define ALLOW_LOADS_STORES   BIT(2)
> > @@ -751,17 +732,27 @@ static void test_masked_events(struct kvm_vcpu *v=
cpu)
> >       run_masked_events_tests(vcpu, events, nevents);
> >  }
> >
> > -static int run_filter_test(struct kvm_vcpu *vcpu, const uint64_t *even=
ts,
> > -                        int nevents, uint32_t flags)
> > +static int do_vcpu_set_pmu_event_filter(struct kvm_vcpu *vcpu,
> > +                                     struct __kvm_pmu_event_filter *__=
f)
> >  {
> > -     struct kvm_pmu_event_filter *f;
> > -     int r;
> > +     struct kvm_pmu_event_filter *f =3D (void *)__f;
> >
> > -     f =3D create_pmu_event_filter(events, nevents, KVM_PMU_EVENT_ALLO=
W, flags);
> > -     r =3D __vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
> > -     free(f);
> > +     return __vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
> > +}
> > +
> > +static int set_pmu_single_event_filter(struct kvm_vcpu *vcpu, uint64_t=
 event,
> > +                                    uint32_t flags, uint32_t action)
> > +{
> > +     struct __kvm_pmu_event_filter f =3D {
> > +             .nevents =3D 1,
> > +             .flags =3D flags,
> > +             .action =3D action,
> > +             .events =3D {
> > +                     event,
> > +             },
> > +     };
> >
> > -     return r;
> > +     return do_vcpu_set_pmu_event_filter(vcpu, &f);
> >  }
> >
> >  static void test_filter_ioctl(struct kvm_vcpu *vcpu)
> > @@ -773,14 +764,18 @@ static void test_filter_ioctl(struct kvm_vcpu *vc=
pu)
> >        * Unfortunately having invalid bits set in event data is expecte=
d to
> >        * pass when flags =3D=3D 0 (bits other than eventsel+umask).
> >        */
> > -     r =3D run_filter_test(vcpu, &e, 1, 0);
> > +     r =3D set_pmu_single_event_filter(vcpu, e, 0, KVM_PMU_EVENT_ALLOW=
);
> >       TEST_ASSERT(r =3D=3D 0, "Valid PMU Event Filter is failing");
> >
> > -     r =3D run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVEN=
TS);
> > +     r =3D set_pmu_single_event_filter(vcpu, e,
> > +                                     KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
> > +                                     KVM_PMU_EVENT_ALLOW);
> >       TEST_ASSERT(r !=3D 0, "Invalid PMU Event Filter is expected to fa=
il");
> >
> >       e =3D KVM_PMU_ENCODE_MASKED_ENTRY(0xff, 0xff, 0xff, 0xf);
> > -     r =3D run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVEN=
TS);
> > +     r =3D set_pmu_single_event_filter(vcpu, e,
> > +                                     KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
> > +                                     KVM_PMU_EVENT_ALLOW);
> >       TEST_ASSERT(r =3D=3D 0, "Valid PMU Event Filter is failing");
> >  }
> >
> > --
> > 2.39.3
> >
>
> --
> Isaku Yamahata <isaku.yamahata@gmail.com>
