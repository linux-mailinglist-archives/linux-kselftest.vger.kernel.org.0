Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C1E705063
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjEPOTM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 10:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjEPOTG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 10:19:06 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B77A7AB8
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 07:18:53 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f38a9918d1so1780731cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684246732; x=1686838732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABaiiANU88bGvckBvXgI3VuNlV8cLVjijeK5jkg4/ck=;
        b=g/dTGVKrnOyAW6gQtWR48XtNN3aHkA70cOuV96/xgC4m2jxOg20sqbyg3ZV6myFbXD
         eE+WCXyYweDzgJhlXEhbKTEwWGwxMz8v4deX3BAfcPPlD2Zcg+E1CJvCzjeiFyrnJRNf
         eniT/4O0IozDFdeQyW4Flh0fZ9ufwCAzk3VgVT2F7TRuIWpcp/zmKrjU7YBaaXBPxHfM
         Ub9SFGP/e447BbJzqe2d/qcQpW99RbefsiAg32q61XDlUH3yRZ7MWXijymLQVyNa7uuY
         1sj7VCSN2S8MZ0ZqXuOTIr1gsUHo2nxt2sEoLfb8hsoQhatHGjrqxqvk95y23Fac4Y2/
         eY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684246732; x=1686838732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABaiiANU88bGvckBvXgI3VuNlV8cLVjijeK5jkg4/ck=;
        b=VWx0rKg0fB+uJjfyzIE+xjeoxYjozMLp6jvulZlPYFgOn0wIawVWZqlCvkVN+TE3gM
         YnMaQnSoI5yWTCS5kh6QwLTMpG0MaQx220uCRcT1udzlyZk0uqMiVnw/n1uY7maebQ/Y
         IScMqgiO3NOLS10liTXDi2f3EFhgrspia4WnzcSzTAU97gMUAN/1j6/+Ocu6M0ZpszXv
         HDh6BCLPCbpDQn8fnjjjltJMJRkpXtTQ23urS4dxbJUz8d3Dh5w9f4C2Oj8hOnXMUYYv
         RWurZ8hUTsWgojWCCS7EbVJxlsxHGdi0kq0hrCaiewJY8lqJHJq/aw5mEPD4BZKPvIEf
         gr+g==
X-Gm-Message-State: AC+VfDw/tuiMuJ+KfrzMfT3/dLvIj3coybODc36VBJvEy7CS2s8+CBD4
        hEHjxKH66dAI97BcgDW+KA6sfTyOByN6W/VwxpN/oQ==
X-Google-Smtp-Source: ACHHUZ4gmQgTk/vLfBBaKbZtx8qpjqztGsRpYmVK6fqToFwjVIqjeLlhjGhg3v6sVcBq/hxz6cEvnCuEoGgzaeT1PKU=
X-Received: by 2002:a05:622a:182a:b0:3f5:49b6:f196 with SMTP id
 t42-20020a05622a182a00b003f549b6f196mr102474qtc.9.1684246732310; Tue, 16 May
 2023 07:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com> <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
 <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com>
In-Reply-To: <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 16 May 2023 16:18:40 +0200
Message-ID: <CALPaoCgknY0pWkXaCayPx28otcA5=v5a5FFoLFx3At0cGvAykg@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On Fri, May 12, 2023 at 3:25=E2=80=AFPM Peter Newman <peternewman@google.co=
m> wrote:
> On Thu, May 11, 2023 at 11:37=E2=80=AFPM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
> > On 4/21/2023 7:17 AM, Peter Newman wrote:
> > > +
> > > +     if (evtid =3D=3D QOS_L3_MBM_LOCAL_EVENT_ID) {
> > > +             counter =3D &state->local;
> > > +     } else {
> > > +             WARN_ON(evtid !=3D QOS_L3_MBM_TOTAL_EVENT_ID);
> > > +             counter =3D &state->total;
> > > +     }
> > > +
> > > +     /*
> > > +      * Propagate the value read from the hw_rmid assigned to the cu=
rrent CPU
> > > +      * into the "soft" rmid associated with the current task or CPU=
.
> > > +      */
> > > +     m =3D get_mbm_state(d, soft_rmid, evtid);
> > > +     if (!m)
> > > +             return;
> > > +
> > > +     if (resctrl_arch_rmid_read(r, d, hw_rmid, evtid, &val))
> > > +             return;
> > > +
> >
> > This all seems unsafe to run without protection. The code relies on
> > the rdt_domain but a CPU hotplug event could result in the domain
> > disappearing underneath this code. The accesses to the data structures
> > also appear unsafe to me. Note that resctrl_arch_rmid_read() updates
> > the architectural MBM state and this same state can be updated concurre=
ntly
> > in other code paths without appropriate locking.
>
> The domain is supposed to always be the current one, but I see that
> even a get_domain_from_cpu(smp_processor_id(), ...) call needs to walk
> a resource's domain list to find a matching entry, which could be
> concurrently modified when other domains are added/removed.
>
> Similarly, when soft RMIDs are enabled, it should not be possible to
> call resctrl_arch_rmid_read() outside of on the current CPU's HW RMID.
>
> I'll need to confirm whether it's safe to access the current CPU's
> rdt_domain in an atomic context. If it isn't, I assume I would have to
> arrange all of the state used during flush to be per-CPU.
>
> I expect the constraints on what data can be safely accessed where is
> going to constrain how the state is ultimately arranged, so I will
> need to settle this before I can come back to the other questions
> about mbm_state.

According to cpu_hotplug.rst, the startup callbacks are called before
a CPU is started and the teardown callbacks are called after the CPU
has become dysfunctional, so it should always be safe for a CPU to
access its own data, so all I need to do here is avoid walking domain
lists in resctrl_mbm_flush_cpu().

However, this also means that resctrl_{on,off}line_cpu() call
clear_closid_rmid() on a different CPU, so whichever CPU executes
these will zap its own pqr_state struct and PQR_ASSOC MSR.

-Peter
