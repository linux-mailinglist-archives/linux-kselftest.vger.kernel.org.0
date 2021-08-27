Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C493F9FA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Aug 2021 21:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhH0TKZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Aug 2021 15:10:25 -0400
Received: from mail.efficios.com ([167.114.26.124]:53444 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhH0TKZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Aug 2021 15:10:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 35CF8381D4D;
        Fri, 27 Aug 2021 15:09:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bdpbmavpTcDf; Fri, 27 Aug 2021 15:09:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 70AB2381CCB;
        Fri, 27 Aug 2021 15:09:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 70AB2381CCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1630091374;
        bh=a+xsJEpOCH31ksEHBk6kwF1tUR+tILdkL5tisWRdxI0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cZCl7fQ/RTUAu0JMKb52619qhmst5OKPbEtnktbVMX/PIHufPwNIz98Ws9VY3/hy4
         tL/OEN4pzYr3Qp9c6LsakEcVPL42DmIBvwb0DHeXYpf+36mtzHghXaDhPpzwd132KK
         hEGDyCXfz7EzVSVP6SPQEDmeEGlUwzPCYdoSc1QaK5k5qgXsewClns9NDZ5b/ANSk9
         QAIBXoJdR3MOeo9N8iFtFpTi7L41mC/UV6LCTb8bhnUV6jRlXRnwh3eKkShIA/awvz
         X6y/j+YsW2oArKIqHNlYlgPu+EvmE4w8fkZeC4LXw6VXW0bGAFOxuNvAsFq0SA9oq1
         ckDQ0iaaY4cpQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nRsCb8Qy1cNv; Fri, 27 Aug 2021 15:09:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3381D381E39;
        Fri, 27 Aug 2021 15:09:34 -0400 (EDT)
Date:   Fri, 27 Aug 2021 15:09:34 -0400 (EDT)
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
Message-ID: <339641531.29941.1630091374065.JavaMail.zimbra@efficios.com>
In-Reply-To: <YSgpy8iXXXUQ+b/k@google.com>
References: <20210820225002.310652-1-seanjc@google.com> <20210820225002.310652-5-seanjc@google.com> <766990430.21713.1629731934069.JavaMail.zimbra@efficios.com> <282257549.21721.1629732017655.JavaMail.zimbra@efficios.com> <YSblqrrpKcORzilX@google.com> <1700758714.29394.1630003332081.JavaMail.zimbra@efficios.com> <YSgpy8iXXXUQ+b/k@google.com>
Subject: Re: [PATCH v2 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to
 detect task migration bugs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4101 (ZimbraWebClient - FF91 (Linux)/8.8.15_GA_4059)
Thread-Topic: selftests: Add a test for KVM_RUN+rseq to detect task migration bugs
Thread-Index: Cat4/nZnF/JdYT0CBeoaNK9t7xzyjQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



----- On Aug 26, 2021, at 7:54 PM, Sean Christopherson seanjc@google.com wrote:

> On Thu, Aug 26, 2021, Mathieu Desnoyers wrote:
>> ----- On Aug 25, 2021, at 8:51 PM, Sean Christopherson seanjc@google.com wrote:
>> >> >> +		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
>> >> >> +		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
>> >> >> +			    errno, strerror(errno));
>> >> >> +		atomic_inc(&seq_cnt);
>> >> >> +
>> >> >> +		CPU_CLR(cpu, &allowed_mask);
>> >> >> +
>> >> >> +		/*
>> >> >> +		 * Let the read-side get back into KVM_RUN to improve the odds
>> >> >> +		 * of task migration coinciding with KVM's run loop.
>> >> > 
>> >> > This comment should be about increasing the odds of letting the seqlock
>> >> > read-side complete. Otherwise, the delay between the two back-to-back
>> >> > atomic_inc is so small that the seqlock read-side may never have time to
>> >> > complete the reading the rseq cpu id and the sched_getcpu() call, and can
>> >> > retry forever.
>> > 
>> > Hmm, but that's not why there's a delay.  I'm not arguing that a livelock isn't
>> > possible (though that syscall would have to be screaming fast),
>> 
>> I don't think we have the same understanding of the livelock scenario. AFAIU the
>> livelock
>> would be caused by a too-small delay between the two consecutive atomic_inc()
>> from one
>> loop iteration to the next compared to the time it takes to perform a read-side
>> critical
>> section of the seqlock. Back-to-back atomic_inc can be performed very quickly,
>> so I
>> doubt that the sched_getcpu implementation have good odds to be fast enough to
>> complete
>> in that narrow window, leading to lots of read seqlock retry.
> 
> Ooooh, yeah, brain fart on my side.  I was thinking of the two atomic_inc() in
> the
> same loop iteration and completely ignoring the next iteration.  Yes, I 100%
> agree
> that a delay to ensure forward progress is needed.  An assertion in main() that
> the
> reader complete at least some reasonable number of KVM_RUNs is also probably a
> good
> idea, e.g. to rule out a false pass due to the reader never making forward
> progress.

Agreed.

> 
> FWIW, the do-while loop does make forward progress without a delay, but at ~50%
> throughput, give or take.

I did not expect absolutely no progress, but a significant slow down of
the read-side.

> 
>> > but the primary motivation is very much to allow the read-side enough time
>> > to get back into KVM proper.
>> 
>> I'm puzzled by your statement. AFAIU, let's say we don't have the delay, then we
>> have:
>> 
>> migration thread                             KVM_RUN/read-side thread
>> -----------------------------------------------------------------------------------
>>                                              - ioctl(KVM_RUN)
>> - atomic_inc_seq_cst(&seqcnt)
>> - sched_setaffinity
>> - atomic_inc_seq_cst(&seqcnt)
>>                                              - a = atomic_load(&seqcnt) & ~1
>>                                              - smp_rmb()
>>                                              - b = LOAD_ONCE(__rseq_abi->cpu_id);
>>                                              - sched_getcpu()
>>                                              - smp_rmb()
>>                                              - re-load seqcnt/compare (succeeds)
>>                                                - Can only succeed if entire read-side happens while the seqcnt
>>                                                  is in an even numbered state.
>>                                              - if (a != b) abort()
>>   /* no delay. Even counter state is very
>>      short. */
>> - atomic_inc_seq_cst(&seqcnt)
>>   /* Let's suppose the lack of delay causes the
>>      setaffinity to complete too early compared
>>      with KVM_RUN ioctl */
>> - sched_setaffinity
>> - atomic_inc_seq_cst(&seqcnt)
>> 
>>   /* no delay. Even counter state is very
>>      short. */
>> - atomic_inc_seq_cst(&seqcnt)
>>   /* Then a setaffinity from a following
>>      migration thread loop will run
>>      concurrently with KVM_RUN */
>>                                              - ioctl(KVM_RUN)
>> - sched_setaffinity
>> - atomic_inc_seq_cst(&seqcnt)
>> 
>> As pointed out here, if the first setaffinity runs too early compared with
>> KVM_RUN,
>> a following setaffinity will run concurrently with it. However, the fact that
>> the even counter state is very short may very well hurt progress of the read
>> seqlock.
> 
> *sigh*
> 
> Several hours later, I think I finally have my head wrapped around everything.
> 
> Due to the way the test is written and because of how KVM's run loop works,
> TIF_NOTIFY_RESUME or TIF_NEED_RESCHED effectively has to be set before KVM
> actually
> enters the guest, otherwise KVM will exit to userspace without touching the
> flag,
> i.e. it will be handled by the normal exit_to_user_mode_loop().
> 
> Where I got lost was trying to figure out why I couldn't make the bug reproduce
> by
> causing the guest to exit to KVM, but not userspace, in which case KVM should
> easily trigger the problematic flow as the window for sched_getcpu() to collide
> with KVM would be enormous.  The reason I didn't go down this route for the
> "official" test is that, unless there's something clever I'm overlooking, it
> requires arch specific guest code, and ialso I don't know that forcing an exit
> would even be necessary/sufficient on other architectures.
> 
> Anyways, I was trying to confirm that the bug was being hit without a delay,
> while
> still retaining the sequence retry in the test.  The test doesn't fail because
> the
> back-to-back atomic_inc() changes seqcnt too fast.  The read-side makes forward
> progress, but it never observes failure because the do-while loop only ever
> completes after another sched_setaffinity(), never after the one that collides
> with KVM because it takes too long to get out of ioctl(KVM_RUN) and back to the
> test.  I.e. the atomic_inc() in the next loop iteration (makes seq_cnt odd)
> always
> completes before the check, and so the check ends up spinning until another
> migration, which correctly updates rseq.  This was expected and didn't confuse
> me.
> 
> What confused me is that I was trying to confirm the bug was being hit from
> within
> the kernel by confirming KVM observed TIF_NOTIFY_RESUME, but I misunderstood
> when
> TIF_NOTIFY_RESUME would get set.  KVM can observe TIF_NOTIFY_RESUME directly,
> but
> it's rare, and I suspect happens iff sched_setaffinity() hits the small window
> where
> it collides with KVM_RUN before KVM enters the guest.
> 
> More commonly, the bug occurs when KVM sees TIF_NEED_RESCHED.  In that case, KVM
> calls xfer_to_guest_mode_work(), which does schedule() and _that_ sets
> TIF_NOTIFY_RESUME.  xfer_to_guest_mode_work() then mishandles TIF_NOTIFY_RESUME
> and the bug is hit, but my confirmation logic in KVM never fired.
> 
> So there are effectively three reasons we want a delay:
> 
>  1. To allow sched_setaffinity() to coincide with ioctl(KVM_RUN) before KVM can
>     enter the guest so that the guest doesn't need an arch-specific VM-Exit source.
> 
>  2. To let ioctl(KVM_RUN) make its way back to the test before the next round
>     of migration.
> 
>  3. To ensure the read-side can make forward progress, e.g. if sched_getcpu()
>     involves a syscall.
> 
> 
> After looking at KVM for arm64 and s390, #1 is a bit tenuous because x86 is the
> only arch that currently uses xfer_to_guest_mode_work(), i.e. the test could be
> tweaked to be overtly x86-specific.  But since a delay is needed for #2 and #3,
> I'd prefer to rely on it for #1 as well in the hopes that this test provides
> coverage for arm64 and/or s390 if they're ever converted to use the common
> xfer_to_guest_mode_work().

Now that we have this understanding of why we need the delay, it would be good to
write this down in a comment within the test.

Does it reproduce if we randomize the delay to have it picked randomly from 0us
to 100us (with 1us step) ? It would remove a lot of the needs for arch-specific
magic delay value.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
