Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6424703032
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbjEOOmP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjEOOmO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:42:14 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D8E55
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 07:42:13 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f38a9918d1so1441301cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684161732; x=1686753732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xivJhdpQaweyzm6nbX3Ea6ei977VI1nEaj15dJjfUJY=;
        b=LfuJOEaIB58sGTFfv23yzuCJolheVTJXvLkYJ1qK1oPHaLr1UvzuZuRtTRvqpID3N6
         jL5AV5D0cs/N9+U8AOpCLdWjAWZHCLaPvfYJcggpTqRZAEtz1N6nejos4oP2mwv74SUc
         KCO0kiKYYL2d7MZqUZYVw0fepdUctVAE6/x7j0VnOVU7atm1aGQDKvK59K3fTJHLf+Nk
         z98Pt572j6TiPVUf4g1nc0dOxUeUBrLF9i7xjR8TUPNTbkApLSQqFbmRINRkWHbGHqDJ
         hVKMCCqHmM0LkmqjyWa+vIrmukdOJHQNq5oP1ZonuU2lRL5V4enNf44uWTocN9vr1lna
         Y6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161732; x=1686753732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xivJhdpQaweyzm6nbX3Ea6ei977VI1nEaj15dJjfUJY=;
        b=az1l5T146dcD3cVSB0E+zxU1XSLK/huGcvo9W2RuDhkKK7NmN6ASlyYaA6Aayl3GsL
         l0Sy9SLmZ5H7f2de6f2DX7EJErC3QGEOoK06d4znbY/BZ+0qhl9rgSroxHyY4ImZFtTo
         TDppWkLYQfbDzvCjtlMMXfsy+wCfntjwx9ssNoWFbgHgoWEBY8vo4YQyF53uCyjg8I1F
         xwKS0QkGPoEUrVnXwlUuHFYhHlTYR9VGqRewd5CcdABU9+8YFaHLV9to7khlJp37aBIx
         UmlXFy+IuzgwYb+cFiU0u05iRtBHt62fB5D/B7MbPa0EN/X252Sbsw6vZgVwaQpKQYGJ
         /oSg==
X-Gm-Message-State: AC+VfDzpBT0IrIhmj8DrGqp0A7Y0myP1OKYYYVrgoXykgcgWLJjLkJXE
        5dWuiBYL/ixjOOqhXbxd1ptC2Ey0BJE25+n2twK9ew==
X-Google-Smtp-Source: ACHHUZ6afn6VrL2MCyAGl7ShdiUs37uFwI48FL1gg0fFLy7/ADtJp4aFqUMoAc4tT7/DiotY9KrN8q9Cy9n517Cb7KY=
X-Received: by 2002:a05:622a:d5:b0:3f2:2c89:f1ef with SMTP id
 p21-20020a05622a00d500b003f22c89f1efmr7073qtw.5.1684161732039; Mon, 15 May
 2023 07:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com> <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
 <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com> <31993ea8-97e5-b8d5-b344-48db212bc9cf@intel.com>
In-Reply-To: <31993ea8-97e5-b8d5-b344-48db212bc9cf@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 15 May 2023 16:42:01 +0200
Message-ID: <CALPaoCiPCxUeGKjZytxmse2oNs=qDBbRY9kH7AZGG6iXf1qtJw@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to
 collect CPUs' MBM events
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On Fri, May 12, 2023 at 5:26=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 5/12/2023 6:25 AM, Peter Newman wrote:
> > On Thu, May 11, 2023 at 11:37=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >> On 4/21/2023 7:17 AM, Peter Newman wrote:
> >>> Implement resctrl_mbm_flush_cpu(), which collects a domain's current =
MBM
> >>> event counts into its current software RMID. The delta for each CPU i=
s
> >>> determined by tracking the previous event counts in per-CPU data.  Th=
e
> >>> software byte counts reside in the arch-independent mbm_state
> >>> structures.
> >>
> >> Could you elaborate why the arch-independent mbm_state was chosen?
> >
> > It largely had to do with how many soft RMIDs to implement. For our
> > own needs, we were mainly concerned with getting back to the number of
> > monitoring groups the hardware claimed to support, so there wasn't
> > much internal motivation to support an unbounded number of soft RMIDs.
>
> Apologies for not being explicit, I was actually curious why the
> arch-independent mbm_state, as opposed to the arch-dependent state, was
> chosen.
>
> I think the lines are getting a bit blurry here with the software RMID
> feature added as a resctrl filesystem feature (and thus non architectural=
),
> but it is specific to AMD architecture.

The soft RMID solution applies conceptually to any system where the
number of hardware counters is smaller than the number of desired
monitoring groups, but at least as large as the number of CPUs. It's a
solution we may need to rely on more in the future as it's easier for
monitoring hardware to scale to the number of CPUs than (CPUs *
mbm_domains). I believed the counts in bytes would apply to the user
interface universally.

However, I did recently rebase these changes onto one of James's MPAM
snapshot branches and __mbm_flush() did end up fitting better on the
arch-dependent side, so I was forced to move the counters over to
arch_mbm_state because on the snapshot branch the arch-dependent code
cannot see the arch-independent mbm_state structure. I then created
resctrl_arch-() helpers for __mon_event_count() to read the counts
from the arch_mbm_state.

In hindsight, despite generic-looking code being able to retrieve the
CPU counts with resctrl_arch_rmid_read(), the permanent assignment of
a HW RMID to a CPU is an implementation-detail specific to the
RDT/PQoS interface and would probably not align to a theoretical MPAM
implementation.

>
> > However, breaking this artificial connection between supported HW and
> > SW RMIDs to support arbitrarily-many monitoring groups could make the
> > implementation conceptually cleaner. If you agree,  I would be happy
> > to give it a try in the next series.
>
> I have not actually considered this. At first glance I think this would
> add more tentacles into the core where currently the number of RMIDs
> supported are queried from the device and supporting an arbitrary number
> would impact that. At this time the RMID state is also pre-allocated
> and thus not possible to support an "arbitrarily-many".

Yes, this was the part that made me want to just leave the RMID count alone=
.


>
> >>> +/*
> >>> + * Called from context switch code __resctrl_sched_in() when the cur=
rent soft
> >>> + * RMID is changing or before reporting event counts to user space.
> >>> + */
> >>> +void resctrl_mbm_flush_cpu(void)
> >>> +{
> >>> +     struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].=
r_resctrl;
> >>> +     int cpu =3D smp_processor_id();
> >>> +     struct rdt_domain *d;
> >>> +
> >>> +     d =3D get_domain_from_cpu(cpu, r);
> >>> +     if (!d)
> >>> +             return;
> >>> +
> >>> +     if (is_mbm_local_enabled())
> >>> +             __mbm_flush(QOS_L3_MBM_LOCAL_EVENT_ID, r, d);
> >>> +     if (is_mbm_total_enabled())
> >>> +             __mbm_flush(QOS_L3_MBM_TOTAL_EVENT_ID, r, d);
> >>> +}
> >>
> >> This (potentially) adds two MSR writes and two MSR reads to what could=
 possibly
> >> be quite slow MSRs if it was not designed to be used in context switch=
. Do you
> >> perhaps have data on how long these MSR reads/writes take on these sys=
tems to get
> >> an idea about the impact on context switch? I think this data should f=
eature
> >> prominently in the changelog.
> >
> > I can probably use ftrace to determine the cost of an __rmid_read()
> > call on a few implementations.
>
> On a lower level I think it may be interesting to measure more closely
> just how long a wrmsr and rdmsr take on these registers. It may be intere=
sting
> if you, for example, use rdtsc_ordered() before and after these calls, an=
d then
> compare it to how long it takes to write the PQR register that has been
> designed to be used in context switch.
>
> > To understand the overall impact to context switch, I can put together
> > a scenario where I can control whether the context switches being
> > measured result in change of soft RMID to prevent the data from being
> > diluted by non-flushing switches.
>
> This sounds great. Thank you very much.

I used a simple parent-child pipe loop benchmark with the parent in
one monitoring group and the child in another to trigger 2M
context-switches on the same CPU and compared the sample-based
profiles on an AMD and Intel implementation. I used perf diff to
compare the samples between hard and soft RMID switches.

Intel(R) Xeon(R) Platinum 8173M CPU @ 2.00GHz:

              +44.80%  [kernel.kallsyms]  [k] __rmid_read
    10.43%     -9.52%  [kernel.kallsyms]  [k] __switch_to

AMD EPYC 7B12 64-Core Processor:

              +28.27%  [kernel.kallsyms]  [k] __rmid_read
    13.45%    -13.44%  [kernel.kallsyms]  [k] __switch_to

Note that a soft RMID switch that doesn't change CLOSID skips the
PQR_ASSOC write completely, so from this data I can roughly say that
__rmid_read() is a little over 2x the length of a PQR_ASSOC write that
changes the current RMID on the AMD implementation and about 4.5x
longer on Intel.

Let me know if this clarifies the cost enough or if you'd like to also
see instrumented measurements on the individual WRMSR/RDMSR
instructions.

Thanks!
-Peter
