Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8503F7F83
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 02:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhHZAwq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 20:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbhHZAwp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 20:52:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FDEC061796
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 17:51:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 17so1488873pgp.4
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 17:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f3PaRj0+UK3KiHBEQ/mOLHR7LbXNTGksF7paqU+Kuls=;
        b=A6asxkjO+IhVOQFmhI2tBLQ24vNU4qbyC65KkjHK6YZEdFzhqDTuNOl/jUY0GY8BZk
         sO21CWd5euGfV+luP8orfSSY/6R8H/lyogJvRGslTcBehiRZLI6fp4wTJHAZTkWW0Luj
         236HN6iRo5IlditmnFRnNMm8X/Z+T2vuG5T/fkhA/TK8hHnA0ENvDZ7NczgztwdHw795
         FBtREj4Nfnw/RApEMCNmyqeYph9H+5+VTpFwKCsOwANy6FK0VwyT/yA9+TXDqcqo4zbp
         CBNvsaomjk9PSQ4KnFbCwLS1WZ5WBZeuC6vG5p684Rv340MRHtj/gV3n4AGPaCXS6GPY
         fWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f3PaRj0+UK3KiHBEQ/mOLHR7LbXNTGksF7paqU+Kuls=;
        b=EIskWAfivLosU5FofF5/XlXisX+EvLipk9ZryS0fcCf2jQBkptXyc0Ygcp4s5aRYaF
         yrSacHEb6I2wLjKTx6bcpY949VQ5jIF5I9w80oF+ZKz/j6WpH5xKlK4YbFDMS+7ut6Df
         P+UI50oNMsUL0wGve5lNm30PTNXRZnjpswGYv57qRcl7ygzflmCiTgAP/Lfbp3erP7jV
         amoUMY7jTvd+BSIrP5tDqvGoguApc+HD0pDbpxrEa1O6TR4lFs7kXyg8PNseP7OFGL5D
         fApqeiT3ZjEatDaDYSkjf4NK1r6D42/4VanCG05rf1VBfFNr0yFSaG8N7z6uLM/k/1E/
         K+xA==
X-Gm-Message-State: AOAM531wPg3jzpb6Sx1U7btQ0wcudqKgxjQPKO0mY0OGJYzJIu8PtYA8
        d9MYUxQs091CTK783m/nONwd6A==
X-Google-Smtp-Source: ABdhPJz66WwJdot9pOGh7Q3Z/ZxgXoc0GykrLFcpNH6VM8KC5/c4zJUQuHeGGSWtTQv/EwVGtnL95A==
X-Received: by 2002:a63:401:: with SMTP id 1mr926843pge.166.1629939118422;
        Wed, 25 Aug 2021 17:51:58 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j21sm756334pfj.66.2021.08.25.17.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 17:51:57 -0700 (PDT)
Date:   Thu, 26 Aug 2021 00:51:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, gor <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-csky <linux-csky@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v2 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to
 detect task migration bugs
Message-ID: <YSblqrrpKcORzilX@google.com>
References: <20210820225002.310652-1-seanjc@google.com>
 <20210820225002.310652-5-seanjc@google.com>
 <766990430.21713.1629731934069.JavaMail.zimbra@efficios.com>
 <282257549.21721.1629732017655.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <282257549.21721.1629732017655.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 23, 2021, Mathieu Desnoyers wrote:
> [ re-send to Darren Hart ]
> 
> ----- On Aug 23, 2021, at 11:18 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
> > ----- On Aug 20, 2021, at 6:50 PM, Sean Christopherson seanjc@google.com wrote:
> > 
> >> Add a test to verify an rseq's CPU ID is updated correctly if the task is
> >> migrated while the kernel is handling KVM_RUN.  This is a regression test
> >> for a bug introduced by commit 72c3c0fe54a3 ("x86/kvm: Use generic xfer
> >> to guest work function"), where TIF_NOTIFY_RESUME would be cleared by KVM
> >> without updating rseq, leading to a stale CPU ID and other badness.
> >> 
> > 
> > [...]
> > 
> > +#define RSEQ_SIG 0xdeadbeef
> > 
> > Is there any reason for defining a custom signature rather than including
> > tools/testing/selftests/rseq/rseq.h ? This should take care of including
> > the proper architecture header which will define the appropriate signature.
> > 
> > Arguably you don't define rseq critical sections in this test per se, but
> > I'm wondering why the custom signature here.

Partly to avoid taking a dependency on rseq.h, and partly to try to call out that
the test doesn't actually do any rseq critical sections.

> > [...]
> > 
> >> +
> >> +static void *migration_worker(void *ign)
> >> +{
> >> +	cpu_set_t allowed_mask;
> >> +	int r, i, nr_cpus, cpu;
> >> +
> >> +	CPU_ZERO(&allowed_mask);
> >> +
> >> +	nr_cpus = CPU_COUNT(&possible_mask);
> >> +
> >> +	for (i = 0; i < 20000; i++) {
> >> +		cpu = i % nr_cpus;
> >> +		if (!CPU_ISSET(cpu, &possible_mask))
> >> +			continue;
> >> +
> >> +		CPU_SET(cpu, &allowed_mask);
> >> +
> >> +		/*
> >> +		 * Bump the sequence count twice to allow the reader to detect
> >> +		 * that a migration may have occurred in between rseq and sched
> >> +		 * CPU ID reads.  An odd sequence count indicates a migration
> >> +		 * is in-progress, while a completely different count indicates
> >> +		 * a migration occurred since the count was last read.
> >> +		 */
> >> +		atomic_inc(&seq_cnt);
> > 
> > So technically this atomic_inc contains the required barriers because the
> > selftests implementation uses "__sync_add_and_fetch(&addr->val, 1)". But
> > it's rather odd that the semantic differs from the kernel implementation in
> > terms of memory barriers: the kernel implementation of atomic_inc
> > guarantees no memory barriers, but this one happens to provide full
> > barriers pretty much by accident (selftests futex/include/atomic.h
> > documents no such guarantee).

Yeah, I got quite lost trying to figure out what atomics the test would actually
end up with.

> > If this full barrier guarantee is indeed provided by the selftests atomic.h
> > header, I would really like a comment stating that in the atomic.h header
> > so the carpet is not pulled from under our feet by a future optimization.
> > 
> > 
> >> +		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
> >> +		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
> >> +			    errno, strerror(errno));
> >> +		atomic_inc(&seq_cnt);
> >> +
> >> +		CPU_CLR(cpu, &allowed_mask);
> >> +
> >> +		/*
> >> +		 * Let the read-side get back into KVM_RUN to improve the odds
> >> +		 * of task migration coinciding with KVM's run loop.
> > 
> > This comment should be about increasing the odds of letting the seqlock
> > read-side complete. Otherwise, the delay between the two back-to-back
> > atomic_inc is so small that the seqlock read-side may never have time to
> > complete the reading the rseq cpu id and the sched_getcpu() call, and can
> > retry forever.

Hmm, but that's not why there's a delay.  I'm not arguing that a livelock isn't
possible (though that syscall would have to be screaming fast), but the primary
motivation is very much to allow the read-side enough time to get back into KVM
proper.

To encounter the bug, TIF_NOTIFY_RESUME has to be recognized by KVM in its run
loop, i.e. sched_setaffinity() must induce task migration after the read-side has
invoked ioctl(KVM_RUN).

> > I'm wondering if 1 microsecond is sufficient on other architectures as
> > well.

I'm definitely wondering that as well :-)

> > One alternative way to make this depend less on the architecture's
> > implementation of sched_getcpu (whether it's a vDSO, or goes through a
> > syscall) would be to read the rseq cpu id and call sched_getcpu a few times
> > (e.g. 3 times) in the migration thread rather than use usleep, and throw
> > away the value read. This would ensure the delay is appropriate on all
> > architectures.

As above, I think an arbitrary delay is required regardless of how fast
sched_getcpu() can execute.  One thought would be to do sched_getcpu() _and_
usleep() to account for sched_getcpu() overhead and to satisfy the KVM_RUN part,
but I don't know that that adds meaningful value.

The real test is if someone could see if the bug repros on non-x86 hardware...
