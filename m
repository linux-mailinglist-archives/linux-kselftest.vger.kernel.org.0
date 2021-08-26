Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E0A3F9127
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Aug 2021 01:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbhHZXzp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 19:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhHZXzp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 19:55:45 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B4BC061757
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 16:54:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j2so2804809pll.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 16:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dW8gFjFomOc5wOdjLD9Dz4jaY3La87NN9K39GXWQx+E=;
        b=ItG8l0YBP+DbB+c2JE7Df+BDJmWlmM348qS2tn+o20n2CfRdWAMxuKeVWdApc9i/ph
         SXx9VY/vjBKJ3otuIt73eO92WBuq2g3EeJrPGA1j+NIfwr3rwhzUL7XKr8ulfNJkTyAs
         A/hdowTP0Ti4TQsIpZGrNAHfz/lIC0cgWPZ6lWsmT7TuDhNU3UrobkDJ2/YT8+DUskzz
         HyZQgME2+z2UW9Kqa9640Z5XVMQ6hwklS3TQ+vcyW689vKbrce53AFsKL98ApNqD/w6b
         XBODsFQkhS7SADidGdS4SqCHCuSJuloxnOtFCWTXqWXH7UgBlb+bA6idy73fwmLcWo99
         dmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dW8gFjFomOc5wOdjLD9Dz4jaY3La87NN9K39GXWQx+E=;
        b=gBph4JPSCBd/LbCz5VpGOcesvhM/3rgE2FcSgts7X3jGiG3TRY4iZFjthbzebvtbKB
         rnT3XeRCZYcFkqrfKtAfkT+lLjfeyT8IPzgd+dpD3LhLNazVRyZSBBZkQj5jI2ZL/CH/
         NzaoYPsmIDU9FFeXuGaScFObEPzo3xkxXwj9/8qPAIWW/fxbmJl1eAWhERona3omgQaH
         ahgeix0glt7RGa2jn8CsuM4icrL5vZv9/cBiyWRuCWM8Oze9SV+IiZNNp45//jXC/jTA
         A3Lk7nK8i0xyRGLAsgtU1rjet8wb8j4eYf67atMTlMhqJz/k3ubIPJ0ACKtetTwXbRTd
         m4rw==
X-Gm-Message-State: AOAM5320dqyaXMVjDEPn6b9i0WDvUzapD2PZS5olzIPq03M9fKIkwn16
        ywmE2ivSRqAXA1GPYUG2Naog5Q==
X-Google-Smtp-Source: ABdhPJwzNqdZ7nV9Pm9TbIto/bocQMQl0ruPz+G7jXml1aOfc3KfC0ZbBEbJQskaU4OTATHvb0yPjg==
X-Received: by 2002:a17:902:c643:b0:130:eab4:bd22 with SMTP id s3-20020a170902c64300b00130eab4bd22mr5672776pls.13.1630022096179;
        Thu, 26 Aug 2021 16:54:56 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r3sm3863725pff.119.2021.08.26.16.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 16:54:55 -0700 (PDT)
Date:   Thu, 26 Aug 2021 23:54:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH v2 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to
 detect task migration bugs
Message-ID: <YSgpy8iXXXUQ+b/k@google.com>
References: <20210820225002.310652-1-seanjc@google.com>
 <20210820225002.310652-5-seanjc@google.com>
 <766990430.21713.1629731934069.JavaMail.zimbra@efficios.com>
 <282257549.21721.1629732017655.JavaMail.zimbra@efficios.com>
 <YSblqrrpKcORzilX@google.com>
 <1700758714.29394.1630003332081.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700758714.29394.1630003332081.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 26, 2021, Mathieu Desnoyers wrote:
> ----- On Aug 25, 2021, at 8:51 PM, Sean Christopherson seanjc@google.com wrote:
> >> >> +		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
> >> >> +		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
> >> >> +			    errno, strerror(errno));
> >> >> +		atomic_inc(&seq_cnt);
> >> >> +
> >> >> +		CPU_CLR(cpu, &allowed_mask);
> >> >> +
> >> >> +		/*
> >> >> +		 * Let the read-side get back into KVM_RUN to improve the odds
> >> >> +		 * of task migration coinciding with KVM's run loop.
> >> > 
> >> > This comment should be about increasing the odds of letting the seqlock
> >> > read-side complete. Otherwise, the delay between the two back-to-back
> >> > atomic_inc is so small that the seqlock read-side may never have time to
> >> > complete the reading the rseq cpu id and the sched_getcpu() call, and can
> >> > retry forever.
> > 
> > Hmm, but that's not why there's a delay.  I'm not arguing that a livelock isn't
> > possible (though that syscall would have to be screaming fast),
> 
> I don't think we have the same understanding of the livelock scenario. AFAIU the livelock
> would be caused by a too-small delay between the two consecutive atomic_inc() from one
> loop iteration to the next compared to the time it takes to perform a read-side critical
> section of the seqlock. Back-to-back atomic_inc can be performed very quickly, so I
> doubt that the sched_getcpu implementation have good odds to be fast enough to complete
> in that narrow window, leading to lots of read seqlock retry.

Ooooh, yeah, brain fart on my side.  I was thinking of the two atomic_inc() in the
same loop iteration and completely ignoring the next iteration.  Yes, I 100% agree
that a delay to ensure forward progress is needed.  An assertion in main() that the
reader complete at least some reasonable number of KVM_RUNs is also probably a good
idea, e.g. to rule out a false pass due to the reader never making forward progress.

FWIW, the do-while loop does make forward progress without a delay, but at ~50% 
throughput, give or take.

> > but the primary motivation is very much to allow the read-side enough time
> > to get back into KVM proper.
> 
> I'm puzzled by your statement. AFAIU, let's say we don't have the delay, then we
> have:
> 
> migration thread                             KVM_RUN/read-side thread
> -----------------------------------------------------------------------------------
>                                              - ioctl(KVM_RUN)
> - atomic_inc_seq_cst(&seqcnt)
> - sched_setaffinity
> - atomic_inc_seq_cst(&seqcnt)
>                                              - a = atomic_load(&seqcnt) & ~1
>                                              - smp_rmb()
>                                              - b = LOAD_ONCE(__rseq_abi->cpu_id);
>                                              - sched_getcpu()
>                                              - smp_rmb()
>                                              - re-load seqcnt/compare (succeeds)
>                                                - Can only succeed if entire read-side happens while the seqcnt
>                                                  is in an even numbered state.
>                                              - if (a != b) abort()
>   /* no delay. Even counter state is very
>      short. */
> - atomic_inc_seq_cst(&seqcnt)
>   /* Let's suppose the lack of delay causes the
>      setaffinity to complete too early compared
>      with KVM_RUN ioctl */
> - sched_setaffinity
> - atomic_inc_seq_cst(&seqcnt)
> 
>   /* no delay. Even counter state is very
>      short. */
> - atomic_inc_seq_cst(&seqcnt)
>   /* Then a setaffinity from a following
>      migration thread loop will run
>      concurrently with KVM_RUN */
>                                              - ioctl(KVM_RUN)
> - sched_setaffinity
> - atomic_inc_seq_cst(&seqcnt)
> 
> As pointed out here, if the first setaffinity runs too early compared with KVM_RUN,
> a following setaffinity will run concurrently with it. However, the fact that 
> the even counter state is very short may very well hurt progress of the read seqlock.

*sigh*

Several hours later, I think I finally have my head wrapped around everything.

Due to the way the test is written and because of how KVM's run loop works,
TIF_NOTIFY_RESUME or TIF_NEED_RESCHED effectively has to be set before KVM actually
enters the guest, otherwise KVM will exit to userspace without touching the flag,
i.e. it will be handled by the normal exit_to_user_mode_loop().

Where I got lost was trying to figure out why I couldn't make the bug reproduce by
causing the guest to exit to KVM, but not userspace, in which case KVM should
easily trigger the problematic flow as the window for sched_getcpu() to collide
with KVM would be enormous.  The reason I didn't go down this route for the
"official" test is that, unless there's something clever I'm overlooking, it
requires arch specific guest code, and ialso I don't know that forcing an exit
would even be necessary/sufficient on other architectures.

Anyways, I was trying to confirm that the bug was being hit without a delay, while
still retaining the sequence retry in the test.  The test doesn't fail because the
back-to-back atomic_inc() changes seqcnt too fast.  The read-side makes forward
progress, but it never observes failure because the do-while loop only ever
completes after another sched_setaffinity(), never after the one that collides
with KVM because it takes too long to get out of ioctl(KVM_RUN) and back to the
test.  I.e. the atomic_inc() in the next loop iteration (makes seq_cnt odd) always
completes before the check, and so the check ends up spinning until another
migration, which correctly updates rseq.  This was expected and didn't confuse me.

What confused me is that I was trying to confirm the bug was being hit from within
the kernel by confirming KVM observed TIF_NOTIFY_RESUME, but I misunderstood when
TIF_NOTIFY_RESUME would get set.  KVM can observe TIF_NOTIFY_RESUME directly, but
it's rare, and I suspect happens iff sched_setaffinity() hits the small window where
it collides with KVM_RUN before KVM enters the guest.

More commonly, the bug occurs when KVM sees TIF_NEED_RESCHED.  In that case, KVM
calls xfer_to_guest_mode_work(), which does schedule() and _that_ sets
TIF_NOTIFY_RESUME.  xfer_to_guest_mode_work() then mishandles TIF_NOTIFY_RESUME
and the bug is hit, but my confirmation logic in KVM never fired.

So there are effectively three reasons we want a delay:

  1. To allow sched_setaffinity() to coincide with ioctl(KVM_RUN) before KVM can
     enter the guest so that the guest doesn't need an arch-specific VM-Exit source.

  2. To let ioctl(KVM_RUN) make its way back to the test before the next round
     of migration.

  3. To ensure the read-side can make forward progress, e.g. if sched_getcpu()
     involves a syscall.


After looking at KVM for arm64 and s390, #1 is a bit tenuous because x86 is the
only arch that currently uses xfer_to_guest_mode_work(), i.e. the test could be
tweaked to be overtly x86-specific.  But since a delay is needed for #2 and #3,
I'd prefer to rely on it for #1 as well in the hopes that this test provides
coverage for arm64 and/or s390 if they're ever converted to use the common
xfer_to_guest_mode_work().
