Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD8077FEEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 22:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349742AbjHQUR1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 16:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354817AbjHQURS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 16:17:18 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431FC30DF
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 13:17:16 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563ab574cb5so322699a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692303436; x=1692908236;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KU+yygDiyP0ELbBFxmC0szeJUfwpE0TiBmbPQ8YXVAs=;
        b=zNA3vpDDz1KyBjk9Ob5BUHexoZIGyPiAf/jYnuCLTrIqL4j8d6uRJul5dmw74Bh5Hq
         SeyuGFaDDWqXuIHXDZA8/MCkbxdNniW3sClCvGAJwf+6uB9P9YBYZucziWA+uHZ9V3aQ
         ry1zwBbNsGxEkazo8EH9jBDiVKZ6gZuLtJp6BpHlGyFW2+HSz0J3LwOKAJBm5+Sbpzzh
         1dOvxxvTnzFRJ0DUIV9Np2zj6Wx5KXBVohTo0UHZTaxclJriOTeM0q8Ral8VlimAaMPU
         HI0tbM5WA3rH/97lmAIvs2Vj+Px3wTzwhMfDsgg9wXUriOKOFynRHp9VmuR+kHhQtls9
         snsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692303436; x=1692908236;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KU+yygDiyP0ELbBFxmC0szeJUfwpE0TiBmbPQ8YXVAs=;
        b=M2P9eBCA0Qy3cbErT/Kb/IxMsJLzDavp2Q1UHcN2OdWIUfjOeDlJtJNcELn6MuJtuc
         zLGkdJ/uFwwzwEVESwXK/3iz/kCiCazDRgju+SPwbElFmikjfaQbaMUpY5oSJPSCuhAN
         WclWjfObDbYacxBxcPyVX4aKrkQKuFDiGfViLVU3wqB6f0/QvC1KIhEFpDsjY+nlqIKO
         jB1fKMYSPPL6BmRIVr1TesvVbAseffLJsfqtWZMsXNr4a3jAvx8DF6X6mf2594ePsWdG
         ukOOJqCMh0pVPGEVO5SINJw4ZiDcJUdLmFcdj/NW6VOTBOfmZOeEjZow6BeD9GZKu9wo
         Z2dA==
X-Gm-Message-State: AOJu0YzJF3kN3aQeYPNBkAlDZNiZXBILocbf8SIHsHfb8akSYiZMnscu
        KaKb0a/H8aTZzOXIMPS46p43n3KMBWQ=
X-Google-Smtp-Source: AGHT+IFijHumwatVu7On9K+vpmmEsXcAinTeAqe7rw5Domph+e00oHTgIyy4LP9oPODs9OGpTVBlFLzjQh0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:b00f:0:b0:565:dddd:1f65 with SMTP id
 h15-20020a63b00f000000b00565dddd1f65mr61039pgf.7.1692303435763; Thu, 17 Aug
 2023 13:17:15 -0700 (PDT)
Date:   Thu, 17 Aug 2023 13:17:14 -0700
In-Reply-To: <CAFg_LQXuBfCD6ypmOLS4NhBCPrLXTpetYWGqFDSnKgQa0R6_gA@mail.gmail.com>
Mime-Version: 1.0
References: <20230810090945.16053-1-cloudliang@tencent.com>
 <20230810090945.16053-4-cloudliang@tencent.com> <20230814234926.GD2257301@ls.amr.corp.intel.com>
 <CAFg_LQXuBfCD6ypmOLS4NhBCPrLXTpetYWGqFDSnKgQa0R6_gA@mail.gmail.com>
Message-ID: <ZN6ASsmAO2007KJM@google.com>
Subject: Re: [PATCH v6 3/6] KVM: selftests: Introduce __kvm_pmu_event_filter
 to improved event filter settings
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023, Jinrong Liang wrote:
> Isaku Yamahata <isaku.yamahata@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=
=8815=E6=97=A5=E5=91=A8=E4=BA=8C 07:49=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Aug 10, 2023 at 05:09:42PM +0800,
> > Jinrong Liang <ljr.kernel@gmail.com> wrote:
> >
> > > From: Jinrong Liang <cloudliang@tencent.com>
> > >
> > > Add custom "__kvm_pmu_event_filter" structure to improve pmu event
> > > filter settings. Simplifies event filter setup by organizing event
> > > filter parameters in a cleaner, more organized way.
> > >
> > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> > > ---
> > >  .../kvm/x86_64/pmu_event_filter_test.c        | 182 +++++++++-------=
--
> > >  1 file changed, 90 insertions(+), 92 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test=
.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > > index 5ac05e64bec9..94f5a89aac40 100644
> > > --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > > +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > > @@ -28,6 +28,10 @@
> > >
> > >  #define NUM_BRANCHES 42
> > >
> > > +/* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
> > > +#define MAX_FILTER_EVENTS            300
> >
> > Can we simply use KVM_PMU_EVENT_FILTER_MAX_EVENTS and remove MAX_FILTER=
_EVENTS?
>=20
> I didn't find the definition of KVM_PMU_EVENT_FILTER_MAX_EVENTS in
> selftests. KVM_PMU_EVENT_FILTER_MAX_EVENTS is defined in pmu.c. To use
> it, we need to define it in selftests.

Huh.  That seems like something that should be enumerated to userspace.

> > > +#define MAX_TEST_EVENTS              10
> > > +
> > >  /*
> > >   * This is how the event selector and unit mask are stored in an AMD
> > >   * core performance event-select register. Intel's format is similar=
,
> > > @@ -69,21 +73,33 @@
> > >
> > >  #define INST_RETIRED EVENT(0xc0, 0)
> > >
> > > +struct __kvm_pmu_event_filter {
> > > +     __u32 action;
> > > +     __u32 nevents;
> > > +     __u32 fixed_counter_bitmap;
> > > +     __u32 flags;
> > > +     __u32 pad[4];
> > > +     __u64 events[MAX_FILTER_EVENTS];
> > > +};
> > > +
> >
> > Is this same to struct kvm_pmu_event_filter?
>=20
> In tools/arch/x86/include/uapi/asm/kvm.h
>=20
> /* for KVM_CAP_PMU_EVENT_FILTER */
> struct kvm_pmu_event_filter {
> __u32 action;
> __u32 nevents;
> __u32 fixed_counter_bitmap;
> __u32 flags;
> __u32 pad[4];
> __u64 events[];
> };

To more directly answer Isaku's question:

They're *basically* the same, and have an identical layout, but the struct =
defined
by KVM uses a flexible array because the number of events comes from usersp=
ace
and forcing userspace to create an 1KiB+ object just to define a single eve=
nt
filter would be obnoxious.

There are alternatives, e.g. using an struct overlay to set a single entry:

	struct {
		struct kvm_msrs header;
		struct kvm_msr_entry entry;
	} buffer =3D {};

	memset(&buffer, 0, sizeof(buffer));
	buffer.header.nmsrs =3D 1;
	buffer.entry.index =3D msr_index;
	buffer.entry.data =3D msr_value;

but that gets annoying (and IMO confusing) because of the nested structs.

I'll massage the changelog to callout the alternative, and why it's undesir=
able.
