Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC48F243AAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Aug 2020 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgHMNPo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Aug 2020 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMNPn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Aug 2020 09:15:43 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD73C061757
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Aug 2020 06:15:39 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j7so4956900oij.9
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Aug 2020 06:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amVDbDf/cLsaykKYWF9FuSxMbm/nBOZt2H1uNX9eFZ8=;
        b=dx3NyCqigtr2t3jtQ/IMwtuMBkhILVT1UmzPUtb4b2jCYAr+ZYn7BPmv3+YmijhshN
         P4khHU8jeFGpytrXSxxCyJfspnPyk4/VdLTgIcIsger4AhcutPrQvLAM8wc9ap3KfvTq
         IQ8RmnmQUQa+qA12npIau3fVNGq7AvSlTXJx/+Td8fIPUPs9ozva718Ag2JmCk/WuvHz
         ji+vVofQrr44BpY19X/RvLQnuTMbhVKh0Dm92Ld47aX6xHuMfh3Sj5t6ePFGP/iDQ9O5
         tRQjb11AI+GERSlmpHzmfTiYD6VUxTaB6cvV2gqu4Kw49IlrE39YWiDFUq8PGA8j/yBw
         f+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amVDbDf/cLsaykKYWF9FuSxMbm/nBOZt2H1uNX9eFZ8=;
        b=DLxMQ8HoSZk2rW+MDrM/EaA3oIRT2600JluX/QJq+56psx4yzgzpXS5KZC3a6i58nj
         P47SQNzgMUP5lxhPuAd3pdi/4J4mhc+eLmFT/T8srvbkS0U3bs2Ayzc5PCft3mODSAj2
         q3i6e8WXJQjH5SeTmrH/GQaM87dygNbVfOasKWzuadvMWi7Gkphfs3Ift5Fhs48ak6tU
         +HppQeXepZ3nwJxzswM9xOECqcWQ5CGU5oyrYqc8DmtF8TvReqzkKlanqI4pBVfzBBX+
         l+RXWaRkF4JEE2QkJ5VexjUezgXCas+WDpsnCq7vbN3kjaF5DKNooP99O+dQoW2u4iTj
         rQfw==
X-Gm-Message-State: AOAM5335O+TltSaJSaP7d7FkeezcBvLJwy0U1aMGk3UR5SiuTZvVMTi0
        AITUAXRY2m52t/e+bQ8v7HzRuwFmMQhadz8fMuLJxTZm
X-Google-Smtp-Source: ABdhPJzT91SoRH9TzoDHHDkZs8acikukFVst91Z+8KqgqXM6PYEOrqrEbVPQF8tqWyPsnWaufHxMCs0RUWuUOwzHLqk=
X-Received: by 2002:a54:480c:: with SMTP id j12mr3393250oij.85.1597324538126;
 Thu, 13 Aug 2020 06:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200812193332.954395-1-urielguajardojr@gmail.com> <20200813103615.GT2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200813103615.GT2674@hirez.programming.kicks-ass.net>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Thu, 13 Aug 2020 08:15:27 -0500
Message-ID: <CAG30Eec2w1zG7CEd=TVGoNssCZu49TBF+1xXPKrKh+d7hJZfsg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: added lockdep support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>, mingo@redhat.com,
        will@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 13, 2020 at 5:36 AM <peterz@infradead.org> wrote:
>
> On Wed, Aug 12, 2020 at 07:33:32PM +0000, Uriel Guajardo wrote:
> > KUnit will fail tests upon observing a lockdep failure. Because lockdep
> > turns itself off after its first failure, only fail the first test and
> > warn users to not expect any future failures from lockdep.
> >
> > Similar to lib/locking-selftest [1], we check if the status of
> > debug_locks has changed after the execution of a test case. However, we
> > do not reset lockdep afterwards.
> >
> > Like the locking selftests, we also fix possible preemption count
> > corruption from lock bugs.
>
> > +static void kunit_check_locking_bugs(struct kunit *test,
> > +                                  unsigned long saved_preempt_count,
> > +                                  bool saved_debug_locks)
> > +{
> > +     preempt_count_set(saved_preempt_count);
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +     if (softirq_count())
> > +             current->softirqs_enabled = 0;
> > +     else
> > +             current->softirqs_enabled = 1;
> > +#endif
>
> Urgh, don't silently change these... if they're off that's a hard fail.
>
>         if (DEBUG_LOCKS_WARN_ON(preempt_count() != saved_preempt_count))
>                 preempt_count_set(saved_preempt_count);
>
> And by using DEBUG_LOCKS_WARN_ON() it will kill IRQ tracing and trigger
> the below fail.

Hmm, I see. My original assumption was that lock related bugs that
could corrupt preempt_count would always be intervened by lockdep
(resulting in debug_locks already being off). Is this not always true?
In any case, I think it's better to explicitly show the failure
associated with preemption count as you have done, but I'm still
curious.

Also, for further clarification: the check you have made on
preempt_count also covers softirq_count, right? My understanding is
that softirqs are re-{enabled/disabled} due to the corruption of the
preemption count, so no changes should occur if the preemption count
remains the same. If it does change, we've already failed from
DEBUG_LOCKS_WARN_ON.

>
> > +     if (saved_debug_locks && !debug_locks) {
> > +             kunit_set_failure(test);
> > +             kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> > +             kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> > +     }
> > +}
