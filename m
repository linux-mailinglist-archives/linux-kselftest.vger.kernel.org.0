Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9F670092B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 15:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbjELNZu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 May 2023 09:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbjELNZu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 May 2023 09:25:50 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A571715
        for <linux-kselftest@vger.kernel.org>; Fri, 12 May 2023 06:25:48 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1010321cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 May 2023 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683897948; x=1686489948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbwZn6wbb6AWyMrRGtCopiudSvQ/zU2/r+76z+7YvMg=;
        b=eqxzVZCdywYF0MYeWxFkG9lVsVh+8ezrwXRSbPQqcbObWjSMtIbdxXAJaATeelqNO3
         kmQsm63IkVz+TmGXAIweWz3t3YM+kJY/J6jA0pysT+mIGOgHZHOyIEdUBK39F0eTkrCL
         hFpPr3ZtfpZWqov9IUJgWSm9Bg2a2JrAspjbOtvSoKaWUE5z74jecRSviQ9DGqoBVjLh
         q+Scc1LFgpxP2+vhaQcIzd0m1TNNbILCqN/jb2kyfPPveTP4yAfd9S1V8jcS7zpY8qTL
         PAjM2A0Ypu2Oz2L+QOWXiIloSg/9Vum1GEaspiTa/S8rxrOxTRnDbbQmtHZKLBvxtMLS
         8GAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683897948; x=1686489948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbwZn6wbb6AWyMrRGtCopiudSvQ/zU2/r+76z+7YvMg=;
        b=C5me64Zr9DFlJjHfQPSYLvU9aZYApwnZsnri+O9X8U8aRZQk4ndASB9f1dPznSrUvb
         PGSwLEwUQ+qWK8VNQC7wWQdJGu8uDSsDPNKqucpd8FGgIhV7o74bgvbms+1vmBdrPBCr
         npyLuTmwcMrn5CBRMDrWYm25ekyW/u2xUqQvrlr8N1JsqjOFrBq7Er3sBSbw7VDg3HuX
         dX/ilvMTOMvYRp+XzBkwYgCxEoo/IIroUWkuQ6oN1fD18R1FAEVA6Y6rH0L9ktL+MQfB
         QUTm7xPdUrt+bEZjto3g2oZHHO1wxXdm+mJSzfGl8nlUZ2m+X0ie9HtU5LTGsSlhXf9d
         olFg==
X-Gm-Message-State: AC+VfDy94+ZZUwrBQV3LVE0EXhTl17kvHov47ln7s3+EVvOCCjNBRjZJ
        RC4iE/ZnAPss+88XctZgkT4pJ7tVyurDEQLrb92wuw==
X-Google-Smtp-Source: ACHHUZ6+1Nm2+X+9izGUHhc03e9MUXIkYFVBOa4gSfMOj6ABOozZ5qNSfQ096qd3bSQHuSVeoxUnYrxbFQXx+9CMy1w=
X-Received: by 2002:a05:622a:c3:b0:3db:1c01:9d95 with SMTP id
 p3-20020a05622a00c300b003db1c019d95mr382182qtw.4.1683897947838; Fri, 12 May
 2023 06:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com> <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
In-Reply-To: <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 12 May 2023 15:25:37 +0200
Message-ID: <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com>
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

On Thu, May 11, 2023 at 11:37=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 4/21/2023 7:17 AM, Peter Newman wrote:
> > Implement resctrl_mbm_flush_cpu(), which collects a domain's current MB=
M
> > event counts into its current software RMID. The delta for each CPU is
> > determined by tracking the previous event counts in per-CPU data.  The
> > software byte counts reside in the arch-independent mbm_state
> > structures.
>
> Could you elaborate why the arch-independent mbm_state was chosen?

It largely had to do with how many soft RMIDs to implement. For our
own needs, we were mainly concerned with getting back to the number of
monitoring groups the hardware claimed to support, so there wasn't
much internal motivation to support an unbounded number of soft RMIDs.

However, breaking this artificial connection between supported HW and
SW RMIDs to support arbitrarily-many monitoring groups could make the
implementation conceptually cleaner. If you agree,  I would be happy
to give it a try in the next series.


> > +     /* cache occupancy events are disabled in this mode */
> > +     WARN_ON(!is_mbm_event(evtid));
>
> If this is hit it would trigger a lot, perhaps WARN_ON_ONCE?

Ok

>
> > +
> > +     if (evtid =3D=3D QOS_L3_MBM_LOCAL_EVENT_ID) {
> > +             counter =3D &state->local;
> > +     } else {
> > +             WARN_ON(evtid !=3D QOS_L3_MBM_TOTAL_EVENT_ID);
> > +             counter =3D &state->total;
> > +     }
> > +
> > +     /*
> > +      * Propagate the value read from the hw_rmid assigned to the curr=
ent CPU
> > +      * into the "soft" rmid associated with the current task or CPU.
> > +      */
> > +     m =3D get_mbm_state(d, soft_rmid, evtid);
> > +     if (!m)
> > +             return;
> > +
> > +     if (resctrl_arch_rmid_read(r, d, hw_rmid, evtid, &val))
> > +             return;
> > +
>
> This all seems unsafe to run without protection. The code relies on
> the rdt_domain but a CPU hotplug event could result in the domain
> disappearing underneath this code. The accesses to the data structures
> also appear unsafe to me. Note that resctrl_arch_rmid_read() updates
> the architectural MBM state and this same state can be updated concurrent=
ly
> in other code paths without appropriate locking.

The domain is supposed to always be the current one, but I see that
even a get_domain_from_cpu(smp_processor_id(), ...) call needs to walk
a resource's domain list to find a matching entry, which could be
concurrently modified when other domains are added/removed.

Similarly, when soft RMIDs are enabled, it should not be possible to
call resctrl_arch_rmid_read() outside of on the current CPU's HW RMID.

I'll need to confirm whether it's safe to access the current CPU's
rdt_domain in an atomic context. If it isn't, I assume I would have to
arrange all of the state used during flush to be per-CPU.

I expect the constraints on what data can be safely accessed where is
going to constrain how the state is ultimately arranged, so I will
need to settle this before I can come back to the other questions
about mbm_state.

>
> > +     /* Count bandwidth after the first successful counter read. */
> > +     if (counter->initialized) {
> > +             /* Assume that mbm_update() will prevent double-overflows=
. */
> > +             if (val !=3D counter->prev_bytes)
> > +                     atomic64_add(val - counter->prev_bytes,
> > +                                  &m->soft_rmid_bytes);
> > +     } else {
> > +             counter->initialized =3D true;
> > +     }
> > +
> > +     counter->prev_bytes =3D val;
>
> I notice a lot of similarities between the above and the software control=
ler,
> see mbm_bw_count().

Thanks for pointing this out, I'll take a look.

>
> > +}
> > +
> > +/*
> > + * Called from context switch code __resctrl_sched_in() when the curre=
nt soft
> > + * RMID is changing or before reporting event counts to user space.
> > + */
> > +void resctrl_mbm_flush_cpu(void)
> > +{
> > +     struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_=
resctrl;
> > +     int cpu =3D smp_processor_id();
> > +     struct rdt_domain *d;
> > +
> > +     d =3D get_domain_from_cpu(cpu, r);
> > +     if (!d)
> > +             return;
> > +
> > +     if (is_mbm_local_enabled())
> > +             __mbm_flush(QOS_L3_MBM_LOCAL_EVENT_ID, r, d);
> > +     if (is_mbm_total_enabled())
> > +             __mbm_flush(QOS_L3_MBM_TOTAL_EVENT_ID, r, d);
> > +}
>
> This (potentially) adds two MSR writes and two MSR reads to what could po=
ssibly
> be quite slow MSRs if it was not designed to be used in context switch. D=
o you
> perhaps have data on how long these MSR reads/writes take on these system=
s to get
> an idea about the impact on context switch? I think this data should feat=
ure
> prominently in the changelog.

I can probably use ftrace to determine the cost of an __rmid_read()
call on a few implementations.

To understand the overall impact to context switch, I can put together
a scenario where I can control whether the context switches being
measured result in change of soft RMID to prevent the data from being
diluted by non-flushing switches.


Thank you for looking over these changes!

-Peter
