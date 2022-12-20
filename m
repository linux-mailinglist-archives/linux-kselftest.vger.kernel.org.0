Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024566525CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Dec 2022 18:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiLTRwD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Dec 2022 12:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiLTRvv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Dec 2022 12:51:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F7B140D8
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Dec 2022 09:51:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk9so31042443ejc.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Dec 2022 09:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRgONfXfB/7FqR4XdC/Xkc2dAxhyGRzjwvi7G1EBGTA=;
        b=aVXzPynpu6zHW+Lah2IIFVHDNmSkg7tuOJyBpw0GMkjRkVlNgcwKmr6RqJUYvdEARq
         SCnyQLAjupkHPwIDusYDnQjeWY8W+rYBn7oVAVQou8BOmniLngC2MGhZBum3MNVByCFp
         fjasBMDxoenpRCN+JmbcWsPtflzSXwqowMCX33JkCTZN4uxGeGPDC7UtQhB/xDF5QzNa
         QXObqzWn1RApZsFHuHebRzNtDzVQNjx5FZHv29Nau61Lxmg7W/NxexcZC90EdNqdplgP
         ZyTsjmM5KTubdNfmbPIX9CNhMATHwrBMf2XBE0Ez3D6kqYkHw3VZ97/kFGbjYAcug6uO
         K0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRgONfXfB/7FqR4XdC/Xkc2dAxhyGRzjwvi7G1EBGTA=;
        b=Y447xyCXDMGb8wrjNnfvUZrdeqjwqCp4IZPruXT7BpEyLEZr+njLrc/Umj12xvzcB1
         4bpr0OfEzdED5jXrajtAvTBKgwH5MKG+RdcU8ryT4Z1DjYNHj0Ib7wiAm/9oki/336kC
         INjjlSLQndQp1C15lSLcA22L+TMS7p+GN1swMLO7HD2ncA2SJH8C7yUDJJdCC+w45b0x
         VDD+kVpcs+bRwLAiQEbaXVVFUDm6nY3w3zEPcl56ynSaHaLJeJ2l4VPXmNe1tgB0FV0Z
         hiLdftdwh4Xe4n6ewp++bvKJzQIyRsn7y2OowAqMGgHk3VqAIz++SV0Mf9PQ47oARgob
         DFhg==
X-Gm-Message-State: ANoB5pk5jChe8Xm++eDPck75jfJl3WKMgVInbH5YCf6PQkaNbvpPXGVw
        TtmfEl3yjRYkaRmdiyA0nyMaUtV2TrRc2bY7e1ub9A==
X-Google-Smtp-Source: AA0mqf6K3DgnpNq5BPEBPwiAnFimPE08LSclQ04Z2HtjgeLiG+JllJC4+1qdGRhnHawP8Cy0Ir7UCvu9HaChnF+UVhI=
X-Received: by 2002:a17:906:b0b:b0:7c1:36:8ffe with SMTP id
 u11-20020a1709060b0b00b007c100368ffemr15363825ejg.725.1671558690342; Tue, 20
 Dec 2022 09:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20221207164338.1535591-1-mclapinski@google.com>
 <20221207164338.1535591-2-mclapinski@google.com> <843af7b5-8917-e9e3-de27-cb328f53fb70@efficios.com>
 <CAAi7L5eVa-KFxG5DLrFXbEdVx-CxLLPzg_kPE9OLa3mkrV+AjQ@mail.gmail.com>
In-Reply-To: <CAAi7L5eVa-KFxG5DLrFXbEdVx-CxLLPzg_kPE9OLa3mkrV+AjQ@mail.gmail.com>
From:   =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date:   Tue, 20 Dec 2022 18:51:18 +0100
Message-ID: <CAAi7L5cRRbT=N1TmMc+SVnym7UOgD+2F=Skjzx=7CbUoyCzUhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/membarrier: Introduce MEMBARRIER_CMD_GET_REGISTRATIONS
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrei Vagin <avagin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 7, 2022 at 7:04 PM Micha=C5=82 C=C5=82api=C5=84ski <mclapinski@=
google.com> wrote:
>
> On Wed, Dec 7, 2022 at 6:07 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2022-12-07 11:43, Michal Clapinski wrote:
> > > Provide a method to query previously issued registrations.
> > >
> > > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > > ---
> > >   include/uapi/linux/membarrier.h |  4 ++++
> > >   kernel/sched/membarrier.c       | 39 ++++++++++++++++++++++++++++++=
++-
> > >   2 files changed, 42 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/mem=
barrier.h
> > > index 737605897f36..5f3ad6d5be6f 100644
> > > --- a/include/uapi/linux/membarrier.h
> > > +++ b/include/uapi/linux/membarrier.h
> > > @@ -137,6 +137,9 @@
> > >    * @MEMBARRIER_CMD_SHARED:
> > >    *                          Alias to MEMBARRIER_CMD_GLOBAL. Provide=
d for
> > >    *                          header backward compatibility.
> > > + * @MEMBARRIER_CMD_GET_REGISTRATIONS:
> > > + *                          Returns a bitmask of previously issued
> > > + *                          registration commands.
> > >    *
> > >    * Command to be passed to the membarrier system call. The commands=
 need to
> > >    * be a single bit each, except for MEMBARRIER_CMD_QUERY which is a=
ssigned to
> > > @@ -153,6 +156,7 @@ enum membarrier_cmd {
> > >       MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE     =3D (1 =
<< 6),
> > >       MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ                   =3D (1 =
<< 7),
> > >       MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ          =3D (1 =
<< 8),
> > > +     MEMBARRIER_CMD_GET_REGISTRATIONS                        =3D (1 =
<< 9),
>
> Btw. I could do this as a flag to MEMBARRIER_CMD_QUERY instead of a
> separate command. Would that be preferable?
>
>
> > >
> > >       /* Alias for header backward compatibility. */
> > >       MEMBARRIER_CMD_SHARED                   =3D MEMBARRIER_CMD_GLOB=
AL,
> > > diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> > > index 0c5be7ebb1dc..2ad881d07752 100644
> > > --- a/kernel/sched/membarrier.c
> > > +++ b/kernel/sched/membarrier.c
> > > @@ -159,7 +159,8 @@
> > >       | MEMBARRIER_CMD_PRIVATE_EXPEDITED                             =
 \
> > >       | MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED                    =
 \
> > >       | MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK               =
 \
> > > -     | MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
> > > +     | MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK                    =
 \
> > > +     | MEMBARRIER_CMD_GET_REGISTRATIONS)
> > >
> > >   static void ipi_mb(void *info)
> > >   {
> > > @@ -540,6 +541,40 @@ static int membarrier_register_private_expedited=
(int flags)
> > >       return 0;
> > >   }
> > >
> > > +static int membarrier_get_registrations(void)
> > > +{
> > > +     struct task_struct *p =3D current;
> > > +     struct mm_struct *mm =3D p->mm;
> > > +     int registrations_mask =3D 0, membarrier_state, i;
> > > +     static const int states[] =3D {
> > > +             MEMBARRIER_STATE_GLOBAL_EXPEDITED |
> > > +                     MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
> >
> > What is the purpose of checking for the _READY state flag as well here =
?
>
> Answered below.
>
>
> >
> >
> > > +             MEMBARRIER_STATE_PRIVATE_EXPEDITED |
> > > +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
> > > +             MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE |
> > > +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_RE=
ADY,
> > > +             MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ |
> > > +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY
> > > +     };
> > > +     static const int registration_cmds[] =3D {
> > > +             MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
> > > +             MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
> > > +             MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
> > > +             MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
> > > +     };
> > > +     BUILD_BUG_ON(ARRAY_SIZE(states) !=3D ARRAY_SIZE(registration_cm=
ds));
> > > +
> > > +     membarrier_state =3D atomic_read(&mm->membarrier_state);
> > > +     for (i =3D 0; i < ARRAY_SIZE(states); ++i) {
> > > +             if (membarrier_state & states[i]) {
> >
> > The mask will match if either of the flags to match are set. Is that
> > your intent ?
>
> Kind of, it was just the easiest to write. As explained in the cover
> letter, I don't really care much about the result of this while the
> process is running. And when the process is frozen, either state and
> state_ready are set or none of them.
>
>
> >
> >
> > > +                     registrations_mask |=3D registration_cmds[i];
> > > +                     membarrier_state &=3D ~states[i];
> >
> > So I understand that those _READY flags are there purely for making sur=
e
> > we clear the membarrier_state for validation that they have all been
> > checked with the following WARN_ON_ONCE(). Am I on the right track ?
>
> Yes, exactly. It wastes time but I'm worried about people adding new
> states and not updating this function. A suggestion on how to do this
> better (especially at compile time) would be greatly appreciated.
>
>
> >
> > > +             }
> > > +     }
> > > +     WARN_ON_ONCE(membarrier_state !=3D 0);
> >
> > Thanks,
> >
> > Mathieu
> >
> > > +     return registrations_mask;
> > > +}
> > > +
> > >   /**
> > >    * sys_membarrier - issue memory barriers on a set of threads
> > >    * @cmd:    Takes command values defined in enum membarrier_cmd.
> > > @@ -623,6 +658,8 @@ SYSCALL_DEFINE3(membarrier, int, cmd, unsigned in=
t, flags, int, cpu_id)
> > >               return membarrier_private_expedited(MEMBARRIER_FLAG_RSE=
Q, cpu_id);
> > >       case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
> > >               return membarrier_register_private_expedited(MEMBARRIER=
_FLAG_RSEQ);
> > > +     case MEMBARRIER_CMD_GET_REGISTRATIONS:
> > > +             return membarrier_get_registrations();
> > >       default:
> > >               return -EINVAL;
> > >       }
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > https://www.efficios.com
> >

Hi Mathieu,
is there anything more you need from my side?
