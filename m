Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023B7244F6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Aug 2020 23:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgHNVAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Aug 2020 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHNVAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Aug 2020 17:00:24 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A92C061385
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Aug 2020 14:00:23 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a65so8628103otc.8
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Aug 2020 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haVemazZULiuV36dwHAxcpTW0ExGKvnYAP0Q5f9mtxc=;
        b=rd4LiSgSzKcMgxiLxmC4FkMLT4vR4LskdS9LN40oqwDp5zCfYM3cMwmiE6LXyV/FfF
         2MKNoH1LqWAV0mPP3drJzJX+zhLFtP6t27pQxXwhV9cPPJ1nJIMCOtmDG3Y/MjGJiZ4W
         o/qD5N6MnExM2PWMHLzc68daMulh/RwXY2PK6+VFnoRWLNQEFW4fAKkPB46/kBffRg0G
         cN2cNmUyMTe2AQVzS3iQvmEHJhB0TzIaJA6BUX78Ztq2Psi5iunQe6N+OSwJYA9XcsJJ
         O55Nyj4EZwxXTu475z5J0nYRYts+cVNGk3tiTE5yPS/t84R8EVd7+/ubObm5V/pxJMK8
         Tnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haVemazZULiuV36dwHAxcpTW0ExGKvnYAP0Q5f9mtxc=;
        b=gKepLHjKyFApTGccnB1RwwjyecPu3YgWcbNZAZEcfoe/G8xL/9vNYBJFwQRlnB4Cah
         WWhaBjgGz+k0bofuo94ITGDt/yFAl18JT0pNjygNVK/rdvkf6btDR/6Qx+G3jZKhdYM8
         kiQm1mF+AueHMnL12YrJbwIMoXMzN4/h0bGKlcA/zblCJC7XK6vrWZ7dypeNXnuMzvc/
         ICptHaPjZ7wlueNyW50gsGAufFxvk20fKQGD331Pi8teWOiudrWrBkNczyTixgVLzo9K
         dolJZ9TCGAwXOI+UZS3ZY7CGTVNb6RriqJcxhpDROaUqq/1xffdtCuk7euHKrU3coZok
         Ejng==
X-Gm-Message-State: AOAM532qmg2TTFkE6og+m4DQ2Xc5ZQQIXZ1Ih2pB6+frzc8B8ZrYkB5Q
        s3hhMQAdCjGnc1iHDLRPb61wVo+WUdYIB3Ei0ecipg==
X-Google-Smtp-Source: ABdhPJwpi1ZJeltZCR6iWWHFOtFiO3feGfWwUEX0ttWIkeBTtDt86+kDGXHO0+Pof/Xs1U8Q3v/11pmj6vVxtUb/JPE=
X-Received: by 2002:a9d:774d:: with SMTP id t13mr3154237otl.108.1597438817570;
 Fri, 14 Aug 2020 14:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200814205527.1833459-1-urielguajardojr@gmail.com> <20200814205847.GK3982@worktop.programming.kicks-ass.net>
In-Reply-To: <20200814205847.GK3982@worktop.programming.kicks-ass.net>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Fri, 14 Aug 2020 16:00:06 -0500
Message-ID: <CAG30Eef1RBj07_=KCJ5G2J0k3_pgL-hM6PiYba0Vf6O16WhnUQ@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: added lockdep support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>, mingo@redhat.com,
        will@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 14, 2020 at 3:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Aug 14, 2020 at 08:55:27PM +0000, Uriel Guajardo wrote:
> > +
> > +void kunit_check_lockdep(struct kunit *test, struct kunit_lockdep *lockdep) {
> > +     int saved_preempt_count = lockdep->preempt_count;
> > +     bool saved_debug_locks = lockdep->debug_locks;
> > +
> > +     if (DEBUG_LOCKS_WARN_ON(preempt_count() != saved_preempt_count))
> > +             preempt_count_set(saved_preempt_count);
> > +
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +     if (softirq_count())
> > +             current->softirqs_enabled = 0;
> > +     else
> > +             current->softirqs_enabled = 1;
> > +#endif
>
> This block is pointless. The only way to get softirq tracing out of sync
> is an unbalanced local_bh_disable(), but then the above preempt_count()
> test will trigger and kill IRQ tracing.

Ahh I see. Thank you.

>
> > +
> > +     if (saved_debug_locks && !debug_locks) {
> > +             kunit_set_failure(test);
> > +             kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> > +             kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> > +     }
> > +}
