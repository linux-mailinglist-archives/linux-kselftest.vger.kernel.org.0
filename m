Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01DA6460D9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 19:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLGSEP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 13:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLGSEO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 13:04:14 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD8C5FB81
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 10:04:12 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m18so14335058eji.5
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Dec 2022 10:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y3J9nRo6jjR898InKO9fN5El2ZHwhdxJj4gps9mW9I=;
        b=WDfEQTvSWUKR2XYWJ+dWKCVbWt+sMD2uLoCQpVaKldt8vNOkPUPgGofPbi2cUr5dSo
         zKHFf2lSksnail5LKzdEuuK/aLYdBSWUeGpsdWS6MbTRCt+8yGkLrra9BJKLi28o7cM3
         swrfzprx1QZQ6i/P7MER+Nw9SNkXCZ1CWBpfvwovKooJH9XxH0COQ9unBKlPcXSESYHK
         /MkOZWrbz8r6/prv7Oi96EXddhSvDlsx2c7To5QA/ysYAQ2hfR4ayaErKHwzKZJfeaMH
         Mrr1sOogkvfaVPZBF4mUPQONsJVuyhvBGnfIeK2t/l4Q0QIYTkMyaI29Hnf/qfxfclED
         FwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Y3J9nRo6jjR898InKO9fN5El2ZHwhdxJj4gps9mW9I=;
        b=uvnuCQDcqAU3xPZnRkBDzs+5Fbs+IIaPrDTn7cmWfYbkHO1gY7+VK6HPhBYIjihjt5
         9zr5+yquEpmGOLP9DkUCkRxOLKT7oVXnh7OaJtd6sjIlHAu1fCx6rNsf0fsU5BjbeQvx
         3mi2/e8qHir9FiWEe8uilI47lxmWPdepu0c4Yi9ioo118Gu3ZyRVRBWPDXx0PZMS+XYF
         pf5aM18dMZ8KOHW61qs23rO7+QGuFxeTyjdiyi9zqdi6ss01GFo0grNAcAJf4eHpHNX7
         /BNGz3794NFB6v1z17qzdY7szyjJlKHYCSfJFBMoBSxDC3C5mBjf7eE4nN0sSnQPlcP6
         tb5g==
X-Gm-Message-State: ANoB5pnhCd83dkgtZ4aTaBTd/cawTrJsY8kNdndlXJiarlImLmj2RkJ4
        s7QETETQUFp5ihSwhuIsGJk0MiEWJLRWzuZjP2TlUQ==
X-Google-Smtp-Source: AA0mqf4GK3fY4JRgFIXwuUYkxuecsGUZfZU67WBevfA6m3jUpRrtCEUNkJOwVT5rq9uO0O4VRrx33l1aZc3NG+wC8mw=
X-Received: by 2002:a17:906:b0b:b0:7c1:36:8ffe with SMTP id
 u11-20020a1709060b0b00b007c100368ffemr9861155ejg.725.1670436251215; Wed, 07
 Dec 2022 10:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20221207164338.1535591-1-mclapinski@google.com>
 <20221207164338.1535591-2-mclapinski@google.com> <843af7b5-8917-e9e3-de27-cb328f53fb70@efficios.com>
In-Reply-To: <843af7b5-8917-e9e3-de27-cb328f53fb70@efficios.com>
From:   =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date:   Wed, 7 Dec 2022 19:04:00 +0100
Message-ID: <CAAi7L5eVa-KFxG5DLrFXbEdVx-CxLLPzg_kPE9OLa3mkrV+AjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/membarrier: Introduce MEMBARRIER_CMD_GET_REGISTRATIONS
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrei Vagin <avagin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Dec 7, 2022 at 6:07 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2022-12-07 11:43, Michal Clapinski wrote:
> > Provide a method to query previously issued registrations.
> >
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > ---
> >   include/uapi/linux/membarrier.h |  4 ++++
> >   kernel/sched/membarrier.c       | 39 ++++++++++++++++++++++++++++++++-
> >   2 files changed, 42 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
> > index 737605897f36..5f3ad6d5be6f 100644
> > --- a/include/uapi/linux/membarrier.h
> > +++ b/include/uapi/linux/membarrier.h
> > @@ -137,6 +137,9 @@
> >    * @MEMBARRIER_CMD_SHARED:
> >    *                          Alias to MEMBARRIER_CMD_GLOBAL. Provided for
> >    *                          header backward compatibility.
> > + * @MEMBARRIER_CMD_GET_REGISTRATIONS:
> > + *                          Returns a bitmask of previously issued
> > + *                          registration commands.
> >    *
> >    * Command to be passed to the membarrier system call. The commands need to
> >    * be a single bit each, except for MEMBARRIER_CMD_QUERY which is assigned to
> > @@ -153,6 +156,7 @@ enum membarrier_cmd {
> >       MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE     = (1 << 6),
> >       MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ                   = (1 << 7),
> >       MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ          = (1 << 8),
> > +     MEMBARRIER_CMD_GET_REGISTRATIONS                        = (1 << 9),

Btw. I could do this as a flag to MEMBARRIER_CMD_QUERY instead of a
separate command. Would that be preferable?


> >
> >       /* Alias for header backward compatibility. */
> >       MEMBARRIER_CMD_SHARED                   = MEMBARRIER_CMD_GLOBAL,
> > diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> > index 0c5be7ebb1dc..2ad881d07752 100644
> > --- a/kernel/sched/membarrier.c
> > +++ b/kernel/sched/membarrier.c
> > @@ -159,7 +159,8 @@
> >       | MEMBARRIER_CMD_PRIVATE_EXPEDITED                              \
> >       | MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED                     \
> >       | MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK                \
> > -     | MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
> > +     | MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK                     \
> > +     | MEMBARRIER_CMD_GET_REGISTRATIONS)
> >
> >   static void ipi_mb(void *info)
> >   {
> > @@ -540,6 +541,40 @@ static int membarrier_register_private_expedited(int flags)
> >       return 0;
> >   }
> >
> > +static int membarrier_get_registrations(void)
> > +{
> > +     struct task_struct *p = current;
> > +     struct mm_struct *mm = p->mm;
> > +     int registrations_mask = 0, membarrier_state, i;
> > +     static const int states[] = {
> > +             MEMBARRIER_STATE_GLOBAL_EXPEDITED |
> > +                     MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
>
> What is the purpose of checking for the _READY state flag as well here ?

Answered below.


>
>
> > +             MEMBARRIER_STATE_PRIVATE_EXPEDITED |
> > +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
> > +             MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE |
> > +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY,
> > +             MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ |
> > +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY
> > +     };
> > +     static const int registration_cmds[] = {
> > +             MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
> > +             MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
> > +             MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
> > +             MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
> > +     };
> > +     BUILD_BUG_ON(ARRAY_SIZE(states) != ARRAY_SIZE(registration_cmds));
> > +
> > +     membarrier_state = atomic_read(&mm->membarrier_state);
> > +     for (i = 0; i < ARRAY_SIZE(states); ++i) {
> > +             if (membarrier_state & states[i]) {
>
> The mask will match if either of the flags to match are set. Is that
> your intent ?

Kind of, it was just the easiest to write. As explained in the cover
letter, I don't really care much about the result of this while the
process is running. And when the process is frozen, either state and
state_ready are set or none of them.


>
>
> > +                     registrations_mask |= registration_cmds[i];
> > +                     membarrier_state &= ~states[i];
>
> So I understand that those _READY flags are there purely for making sure
> we clear the membarrier_state for validation that they have all been
> checked with the following WARN_ON_ONCE(). Am I on the right track ?

Yes, exactly. It wastes time but I'm worried about people adding new
states and not updating this function. A suggestion on how to do this
better (especially at compile time) would be greatly appreciated.


>
> > +             }
> > +     }
> > +     WARN_ON_ONCE(membarrier_state != 0);
>
> Thanks,
>
> Mathieu
>
> > +     return registrations_mask;
> > +}
> > +
> >   /**
> >    * sys_membarrier - issue memory barriers on a set of threads
> >    * @cmd:    Takes command values defined in enum membarrier_cmd.
> > @@ -623,6 +658,8 @@ SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
> >               return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, cpu_id);
> >       case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
> >               return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
> > +     case MEMBARRIER_CMD_GET_REGISTRATIONS:
> > +             return membarrier_get_registrations();
> >       default:
> >               return -EINVAL;
> >       }
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
