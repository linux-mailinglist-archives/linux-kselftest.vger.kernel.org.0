Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4C22452F5
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Aug 2020 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgHOV4z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Aug 2020 17:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgHOVwL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:11 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC9BC03B3D1;
        Sat, 15 Aug 2020 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qKhiDm0m7Tdf7CCkOtiHly7+5eVkqvmSKw0X4hRAKmA=; b=tZKS8nzQ+TG+8a9eeLteyBvm+p
        FPdK1MJo0lPr1MOckxBG+oD5jagoRLTf8wXjl7xrwwdcNgzKXG6q9n4NqnIDqSbpk+i8WHrDW5hX0
        mW5sS1KdzFl3TTbCjuRIjkYW4TJYfPdmB2m3VynQzTpb6nLXFntaa1fBKC6bsKANrUfOIu1tfz+dq
        uf9kQSCG1fBFIDJoXsBhOLfgpEqXgtIqu9WkKWuY97coJOAhwn8g+o2zMhqimiSGk7Te3bv9TE0TQ
        RAy+XStU6Dz3jWln2xgvlaHh/XOtvr512uZCUsasrpXpmMrvfnQN0QG+tV5/Kb/8aWwxbU/GCEcZu
        eco4A84w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6rnx-0003xt-GR; Sat, 15 Aug 2020 08:44:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B02CB980C9E; Sat, 15 Aug 2020 10:44:43 +0200 (CEST)
Date:   Sat, 15 Aug 2020 10:44:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        brendanhiggins@google.com, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, urielguajardo@google.com,
        alan.maguire@oracle.com
Subject: Re: [PATCH v3] kunit: added lockdep support
Message-ID: <20200815084443.GO3982@worktop.programming.kicks-ass.net>
References: <20200814205527.1833459-1-urielguajardojr@gmail.com>
 <20200815083029.GA2430016@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815083029.GA2430016@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 15, 2020 at 10:30:29AM +0200, Ingo Molnar wrote:
> 
> * Uriel Guajardo <urielguajardojr@gmail.com> wrote:
> 
> > From: Uriel Guajardo <urielguajardo@google.com>
> > 
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
> > --- a/lib/kunit/Makefile
> > +++ b/lib/kunit/Makefile
> 
> > +void kunit_check_lockdep(struct kunit *test, struct kunit_lockdep *lockdep) {
> > +	int saved_preempt_count = lockdep->preempt_count;
> > +	bool saved_debug_locks = lockdep->debug_locks;
> > +
> > +	if (DEBUG_LOCKS_WARN_ON(preempt_count() != saved_preempt_count))
> > +		preempt_count_set(saved_preempt_count);
> > +
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +	if (softirq_count())
> > +		current->softirqs_enabled = 0;
> > +	else
> > +		current->softirqs_enabled = 1;
> > +#endif
> > +
> > +	if (saved_debug_locks && !debug_locks) {
> > +		kunit_set_failure(test);
> > +		kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> > +		kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> > +	}
> 
> 
> So this basically duplicates what the boot-time locking self-tests do, 
> in a poor fashion?

No, it makes sure that any kunit based self-test fails when it messes up
it's locking.
