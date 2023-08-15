Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF9177C673
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 05:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjHODmn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 23:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjHODmH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 23:42:07 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66FEE52;
        Mon, 14 Aug 2023 20:41:21 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-5255da974c4so2666671a12.3;
        Mon, 14 Aug 2023 20:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692070880; x=1692675680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NGrWB5KOcou0erbpEXIt7BZ0L3xELVtjyeYvYlNDOE=;
        b=kw7RG2wPnj0BJtdnBFkjXJvetMx/mDARmhhX0e5j8mTwWl/JJ5kAnxxiQxNfRwu79e
         Iiir8YfjPU7aDBFVZlHTkvfopCuZs49vYAN8Ff4f5q90qR1CUErMGimy23lUrigzMc37
         ZSbzoU3sSXqopo6hsJ/rXJjpB3CH+FYAa43CnlTpBXWPJhJSFv2WSDxugxOz9pbr2I2t
         S/3ySCaSaI0AcHzuXM/mNDx0ZiCBVu/GJWaad8DI4BWNHEtqCSWLjaWulTAW7HRv6Kxc
         /3AUIjSRYD9fX6YGQIpls1eNpFo6gjGs92JSVq2ZCCdA5OEAdB9GS0m9XhwKdXntY/qA
         AJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692070880; x=1692675680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NGrWB5KOcou0erbpEXIt7BZ0L3xELVtjyeYvYlNDOE=;
        b=DB7u0CWjYYtSRTpyBJmKedOqsjdAcllgA8YQqeIAGCtwvE8PFFkbqPGF7e1tGQ7NBW
         f5RCiH0YXn80dn/LkCF60l2Xh98aVYDYT9qMirKMSa1PUIdp2T7sT9Hr4gVgD4rHFZLB
         9NRhPZ/IA3TJOFKGm+HkP1lFvAKcnFoRDvD38xXRbJT/FQd/NLrFbNQa0NsAd6gGZbGp
         i6FNoFB71NKm3hd2u9f9fn52tGnzVutZWGVGRalOYiC/R1oSXbK2I7GfEBfpmT8Xg04B
         IF3B5gNRk3zv31iKARhWTVKhQPI0b4pNxXK0B5Tw9tUWrpEdUA2Y3Tnzns8d3o5p7fWP
         4/RA==
X-Gm-Message-State: AOJu0YzcqfpLJEHyR4lTXq97xr+9p859fioANxvBHG+GM2/xadMUEehg
        CgU4bJTGk3J3fAQPPnyfMp1iUthw36SW4JFIRlk=
X-Google-Smtp-Source: AGHT+IGchufaFx/xTfpZS4VLh8iBiAmEvNeDDNJn9iKkW3MGEIc0nqdLs7t1YOOoMbK0yMyF0f1KUyOKi2ZCPAYb3KU=
X-Received: by 2002:aa7:d292:0:b0:523:b133:5c7e with SMTP id
 w18-20020aa7d292000000b00523b1335c7emr9921250edq.1.1692070880211; Mon, 14 Aug
 2023 20:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230810090945.16053-1-cloudliang@tencent.com>
 <20230810090945.16053-4-cloudliang@tencent.com> <20230814234926.GD2257301@ls.amr.corp.intel.com>
In-Reply-To: <20230814234926.GD2257301@ls.amr.corp.intel.com>
From:   Jinrong Liang <ljr.kernel@gmail.com>
Date:   Tue, 15 Aug 2023 11:41:08 +0800
Message-ID: <CAFg_LQXuBfCD6ypmOLS4NhBCPrLXTpetYWGqFDSnKgQa0R6_gA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] KVM: selftests: Introduce __kvm_pmu_event_filter
 to improved event filter settings
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Isaku Yamahata <isaku.yamahata@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=881=
5=E6=97=A5=E5=91=A8=E4=BA=8C 07:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Aug 10, 2023 at 05:09:42PM +0800,
> Jinrong Liang <ljr.kernel@gmail.com> wrote:
>
> > From: Jinrong Liang <cloudliang@tencent.com>
> >
> > Add custom "__kvm_pmu_event_filter" structure to improve pmu event
> > filter settings. Simplifies event filter setup by organizing event
> > filter parameters in a cleaner, more organized way.
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> > ---
> >  .../kvm/x86_64/pmu_event_filter_test.c        | 182 +++++++++---------
> >  1 file changed, 90 insertions(+), 92 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c=
 b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > index 5ac05e64bec9..94f5a89aac40 100644
> > --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > @@ -28,6 +28,10 @@
> >
> >  #define NUM_BRANCHES 42
> >
> > +/* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
> > +#define MAX_FILTER_EVENTS            300
>
> Can we simply use KVM_PMU_EVENT_FILTER_MAX_EVENTS and remove MAX_FILTER_E=
VENTS?

I didn't find the definition of KVM_PMU_EVENT_FILTER_MAX_EVENTS in
selftests. KVM_PMU_EVENT_FILTER_MAX_EVENTS is defined in pmu.c. To use
it, we need to define it in selftests.

>
>
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
>
> Is this same to struct kvm_pmu_event_filter?

In tools/arch/x86/include/uapi/asm/kvm.h

/* for KVM_CAP_PMU_EVENT_FILTER */
struct kvm_pmu_event_filter {
__u32 action;
__u32 nevents;
__u32 fixed_counter_bitmap;
__u32 flags;
__u32 pad[4];
__u64 events[];
};

>
> Except two trivial issue, looks good to me.
> --
> Isaku Yamahata <isaku.yamahata@gmail.com>
