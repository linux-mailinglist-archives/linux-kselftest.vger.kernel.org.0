Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AFA3F8E05
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 20:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbhHZSnG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 14:43:06 -0400
Received: from mail.efficios.com ([167.114.26.124]:39244 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243354AbhHZSnF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 14:43:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 074BB37A06D;
        Thu, 26 Aug 2021 14:42:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hyX1F_x0infM; Thu, 26 Aug 2021 14:42:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6C19237A436;
        Thu, 26 Aug 2021 14:42:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6C19237A436
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1630003332;
        bh=MHHcFtZedk5dfBxVUbSOnkW6LP6W2tP2mrVDcSXqhw8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=k1F7XJGKCycLJ8+hy0uElUJQUfXIoFIlQhvVyEMy0Z6EgL3dHeMXWBPIY3wy0QmQF
         1pd+brzQueTHV8L6NrVCIChphOnuSThyO35g/pTOpMRyeOgWiVev/+/2hACIUBh45T
         v9rZBZw+QeLwCR+0SLJvKhSCnAupnSaA+37NUYHJF3xahjuqyuVIGoshV5Vj/TyeMK
         7RF+8KVS1osPynBZdXF5qnP4TGEtI+DqI8Xyz5WouRSxvk8E/WhbtfxSrVI5GDb7AL
         qq0IoZGDzzFGeJDZTDgfoeiSbA/KdKomuNYUeohR40Fux8jYBNItpxiSW7dR1FfV3l
         +TrK9KA3zsW1g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lVLwZn_2C8lo; Thu, 26 Aug 2021 14:42:12 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 39CBB37A1FC;
        Thu, 26 Aug 2021 14:42:12 -0400 (EDT)
Date:   Thu, 26 Aug 2021 14:42:12 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     dvhart <dvhart@infradead.org>,
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
Message-ID: <1700758714.29394.1630003332081.JavaMail.zimbra@efficios.com>
In-Reply-To: <YSblqrrpKcORzilX@google.com>
References: <20210820225002.310652-1-seanjc@google.com> <20210820225002.310652-5-seanjc@google.com> <766990430.21713.1629731934069.JavaMail.zimbra@efficios.com> <282257549.21721.1629732017655.JavaMail.zimbra@efficios.com> <YSblqrrpKcORzilX@google.com>
Subject: Re: [PATCH v2 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to
 detect task migration bugs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4101 (ZimbraWebClient - FF91 (Linux)/8.8.15_GA_4059)
Thread-Topic: selftests: Add a test for KVM_RUN+rseq to detect task migration bugs
Thread-Index: JTQ3Sjskf2jZ9hZQxbhtvyInF90Pow==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Aug 25, 2021, at 8:51 PM, Sean Christopherson seanjc@google.com wrote:

> On Mon, Aug 23, 2021, Mathieu Desnoyers wrote:
>> [ re-send to Darren Hart ]
>> 
>> ----- On Aug 23, 2021, at 11:18 AM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>> > ----- On Aug 20, 2021, at 6:50 PM, Sean Christopherson seanjc@google.com wrote:
>> > 
>> >> Add a test to verify an rseq's CPU ID is updated correctly if the task is
>> >> migrated while the kernel is handling KVM_RUN.  This is a regression test
>> >> for a bug introduced by commit 72c3c0fe54a3 ("x86/kvm: Use generic xfer
>> >> to guest work function"), where TIF_NOTIFY_RESUME would be cleared by KVM
>> >> without updating rseq, leading to a stale CPU ID and other badness.
>> >> 
>> > 
>> > [...]
>> > 
>> > +#define RSEQ_SIG 0xdeadbeef
>> > 
>> > Is there any reason for defining a custom signature rather than including
>> > tools/testing/selftests/rseq/rseq.h ? This should take care of including
>> > the proper architecture header which will define the appropriate signature.
>> > 
>> > Arguably you don't define rseq critical sections in this test per se, but
>> > I'm wondering why the custom signature here.
> 
> Partly to avoid taking a dependency on rseq.h, and partly to try to call out
> that
> the test doesn't actually do any rseq critical sections.

It might be good to add a comment near this define stating this then, so nobody
attempts to copy this as an example.

> 
>> > [...]
>> > 
>> >> +
>> >> +static void *migration_worker(void *ign)
>> >> +{
>> >> +	cpu_set_t allowed_mask;
>> >> +	int r, i, nr_cpus, cpu;
>> >> +
>> >> +	CPU_ZERO(&allowed_mask);
>> >> +
>> >> +	nr_cpus = CPU_COUNT(&possible_mask);
>> >> +
>> >> +	for (i = 0; i < 20000; i++) {
>> >> +		cpu = i % nr_cpus;
>> >> +		if (!CPU_ISSET(cpu, &possible_mask))
>> >> +			continue;
>> >> +
>> >> +		CPU_SET(cpu, &allowed_mask);
>> >> +
>> >> +		/*
>> >> +		 * Bump the sequence count twice to allow the reader to detect
>> >> +		 * that a migration may have occurred in between rseq and sched
>> >> +		 * CPU ID reads.  An odd sequence count indicates a migration
>> >> +		 * is in-progress, while a completely different count indicates
>> >> +		 * a migration occurred since the count was last read.
>> >> +		 */
>> >> +		atomic_inc(&seq_cnt);
>> > 
>> > So technically this atomic_inc contains the required barriers because the
>> > selftests implementation uses "__sync_add_and_fetch(&addr->val, 1)". But
>> > it's rather odd that the semantic differs from the kernel implementation in
>> > terms of memory barriers: the kernel implementation of atomic_inc
>> > guarantees no memory barriers, but this one happens to provide full
>> > barriers pretty much by accident (selftests futex/include/atomic.h
>> > documents no such guarantee).
> 
> Yeah, I got quite lost trying to figure out what atomics the test would actually
> end up with.

At the very least, until things are clarified in the selftests atomic header, I would
recommend adding a comment stating which memory barriers are required alongside each
use of atomic_inc here. I would even prefer that we add extra (currently unneeded)
write barriers to make extra sure that this stays documented. Performance of the write-side
does not matter much here.

> 
>> > If this full barrier guarantee is indeed provided by the selftests atomic.h
>> > header, I would really like a comment stating that in the atomic.h header
>> > so the carpet is not pulled from under our feet by a future optimization.
>> > 
>> > 
>> >> +		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
>> >> +		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
>> >> +			    errno, strerror(errno));
>> >> +		atomic_inc(&seq_cnt);
>> >> +
>> >> +		CPU_CLR(cpu, &allowed_mask);
>> >> +
>> >> +		/*
>> >> +		 * Let the read-side get back into KVM_RUN to improve the odds
>> >> +		 * of task migration coinciding with KVM's run loop.
>> > 
>> > This comment should be about increasing the odds of letting the seqlock
>> > read-side complete. Otherwise, the delay between the two back-to-back
>> > atomic_inc is so small that the seqlock read-side may never have time to
>> > complete the reading the rseq cpu id and the sched_getcpu() call, and can
>> > retry forever.
> 
> Hmm, but that's not why there's a delay.  I'm not arguing that a livelock isn't
> possible (though that syscall would have to be screaming fast),

I don't think we have the same understanding of the livelock scenario. AFAIU the livelock
would be caused by a too-small delay between the two consecutive atomic_inc() from one
loop iteration to the next compared to the time it takes to perform a read-side critical
section of the seqlock. Back-to-back atomic_inc can be performed very quickly, so I
doubt that the sched_getcpu implementation have good odds to be fast enough to complete
in that narrow window, leading to lots of read seqlock retry.

> but the primary
> motivation is very much to allow the read-side enough time to get back into KVM
> proper.

I'm puzzled by your statement. AFAIU, let's say we don't have the delay, then we
have:

migration thread                             KVM_RUN/read-side thread
-----------------------------------------------------------------------------------
                                             - ioctl(KVM_RUN)
- atomic_inc_seq_cst(&seqcnt)
- sched_setaffinity
- atomic_inc_seq_cst(&seqcnt)
                                             - a = atomic_load(&seqcnt) & ~1
                                             - smp_rmb()
                                             - b = LOAD_ONCE(__rseq_abi->cpu_id);
                                             - sched_getcpu()
                                             - smp_rmb()
                                             - re-load seqcnt/compare (succeeds)
                                               - Can only succeed if entire read-side happens while the seqcnt
                                                 is in an even numbered state.
                                             - if (a != b) abort()
  /* no delay. Even counter state is very
     short. */
- atomic_inc_seq_cst(&seqcnt)
  /* Let's suppose the lack of delay causes the
     setaffinity to complete too early compared
     with KVM_RUN ioctl */
- sched_setaffinity
- atomic_inc_seq_cst(&seqcnt)

  /* no delay. Even counter state is very
     short. */
- atomic_inc_seq_cst(&seqcnt)
  /* Then a setaffinity from a following
     migration thread loop will run
     concurrently with KVM_RUN */
                                             - ioctl(KVM_RUN)
- sched_setaffinity
- atomic_inc_seq_cst(&seqcnt)

As pointed out here, if the first setaffinity runs too early compared with KVM_RUN,
a following setaffinity will run concurrently with it. However, the fact that 
the even counter state is very short may very well hurt progress of the read seqlock.

> 
> To encounter the bug, TIF_NOTIFY_RESUME has to be recognized by KVM in its run
> loop, i.e. sched_setaffinity() must induce task migration after the read-side
> has
> invoked ioctl(KVM_RUN).

No argument here.

> 
>> > I'm wondering if 1 microsecond is sufficient on other architectures as
>> > well.
> 
> I'm definitely wondering that as well :-)
> 
>> > One alternative way to make this depend less on the architecture's
>> > implementation of sched_getcpu (whether it's a vDSO, or goes through a
>> > syscall) would be to read the rseq cpu id and call sched_getcpu a few times
>> > (e.g. 3 times) in the migration thread rather than use usleep, and throw
>> > away the value read. This would ensure the delay is appropriate on all
>> > architectures.
> 
> As above, I think an arbitrary delay is required regardless of how fast
> sched_getcpu() can execute.  One thought would be to do sched_getcpu() _and_
> usleep() to account for sched_getcpu() overhead and to satisfy the KVM_RUN part,
> but I don't know that that adds meaningful value.
> 
> The real test is if someone could see if the bug repros on non-x86 hardware...

As I explain in the scenario above, I don't think we agree on the reason why the
delay is required. One way to confirm this would be to run the code without delay,
and count how many seqcnt read-side succeed vs fail. We can then compare that with
a run with a 1us delay between the migration thread loops. This data should help us
come to a common understanding of the delay's role.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
