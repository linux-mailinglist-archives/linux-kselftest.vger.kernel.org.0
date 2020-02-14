Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0E515E799
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2020 17:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgBNQyy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Feb 2020 11:54:54 -0500
Received: from mail.efficios.com ([167.114.26.124]:59858 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404925AbgBNQyx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Feb 2020 11:54:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B00CE23ACB5;
        Fri, 14 Feb 2020 11:54:50 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id b0oj3fE8KmnK; Fri, 14 Feb 2020 11:54:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3FDA723A8FB;
        Fri, 14 Feb 2020 11:54:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3FDA723A8FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581699290;
        bh=NiKdD4GMaJ2MLkmF5uW6TCLm7+mQJ4RNezaFecTBBrc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lmZfsuR8mMqnn/jkQx05Bu1jbK8vDIOmqGJaHkWup/0MlxAA/1gicJaDAkdKhB944
         GhMWtw7u4HFvMPw+aOfPYDhGY8fYj94hJSqomzcvUQBEeMBMUqkjAspJwK+hPPzp0v
         Yh3RwAaRgapqzNq2bhTAaE0Db8eNkjVBhTOlh7UHB8u3yN1mKoay4Ml35xHH1SAGRi
         vFcltsNIlMjLtOyiKmpk1D6uXX1lq+u61akr0QrigKoV9FgAuzxw+kC6GOFwsAtBFd
         5iW9l5E9ypdtJkwRrprv6leD3FA/K+deK8lIBVdDd1NFl5tzr+2MrrxQAZQUO15PkR
         TYhq6aPXyutGQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a7LVwWYzJImk; Fri, 14 Feb 2020 11:54:50 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2291D23AF8E;
        Fri, 14 Feb 2020 11:54:50 -0500 (EST)
Date:   Fri, 14 Feb 2020 11:54:50 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>, shuah <shuah@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Message-ID: <1713146428.2610.1581699290029.JavaMail.zimbra@efficios.com>
In-Reply-To: <87blql5hfb.fsf@oldenburg2.str.redhat.com>
References: <20200121160312.26545-1-mathieu.desnoyers@efficios.com> <2049164886.596497.1579641536619.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.2001212141590.1231@www.lameter.com> <1648013936.596672.1579655468604.JavaMail.zimbra@efficios.com> <ead7a565-9a23-a7d7-904d-c4860f63952a@zytor.com> <87a76efuux.fsf@oldenburg2.str.redhat.com> <134428560.600911.1580153955842.JavaMail.zimbra@efficios.com> <87blql5hfb.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system
 call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3899 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: pin_on_cpu: Introduce thread CPU pinning system call
Thread-Index: cTvqdrvCQudYKnfodFshnn5ecRABXA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Jan 30, 2020, at 6:10 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> It brings an interesting idea to the table though. Let's assume for now that
>> the only intended use of pin_on_cpu(2) would be to allow rseq(2) critical
>> sections to update per-cpu data on specific cpu number targets. In fact,
>> considering that userspace can be preempted at any point, we still need a
>> mechanism to guarantee atomicity with respect to other threads running on
>> the same runqueue, which rseq(2) provides. Therefore, that assumption does
>> not appear too far-fetched.
>>
>> There are 2 scenarios we need to consider here:
>>
>> A) pin_on_cpu(2) targets a CPU which is not part of the affinity mask.
>>
>> This case is easy: pin_on_cpu can return an error, and the caller needs to act
>> accordingly (e.g. figure out that this is a design error and report it, or
>> decide that it really did not want to touch that per-cpu data that badly and
>> make the entire process fall-back to a mechanism which does not use per-cpu
>> data at all from that point onwards)
> 
> Affinity masks currently are not like process memory: there is an
> expectation that they can be altered from outside the process.

Yes, that's my main issue.

> Given that the caller may not have any ways to recover from the
> suggested pin_on_cpu behavior, that seems problematic.

Indeed.

> 
> What I would expect is that if pin_on_cpu cannot achieve implied
> exclusion by running on the associated CPU, it acquires a lock that
> prevents others pin_on_cpu calls from entering the critical section, and
> tasks in the same task group from running on that CPU (if the CPU
> becomes available to the task group).  The second part should maintain
> exclusion of rseq sequences even if their fast path is not changed.

I try to avoid mutual exclusion over shared memory as rseq fallback whenever
I can, so we can use rseq from lock-free algorithms without losing lock-freedom.

> (On the other hand, I'm worried that per-CPU data structures are a dead
> end for user space unless we get containerized affinity masks, so that
> contains only see resources that are actually available to them.)

I'm currently implementing a prototype of the following ideas, and I'm curious to
read your thoughts on those:

I'm adding a "affinity_pinned" flag to the task struct of each thread. It can
be set and cleared only by the owner thread through pin_on_cpu syscall commands.
When the affinity is pinned by a thread, trying to change its affinity (from an
external thread, or possibly from itself) will fail.

Whenever a thread would (temporarily) pin itself on a specific CPU, it would
also pin its affinity mask as a side-effect. When a thread unpins from a CPU,
the affinity mask stays pinned. The purpose of keeping this affinity pinned
state per-thread is to ensure we don't end up with tiny race windows where
changing the thread's affinity mask "typically" works, but fails once in a
while because it's done concurrently with a 1ms long cpu pinning. This would
lead to flaky code, and I try hard to avoid that.

How changing this affinity should fail (from sched_setaffinity and cpusets) is a
big unanswered question. I see two major alternatives so far:

1) We deliver a signal to the target thread (SIGKILL ? SIGSEGV ?), considering
   that failure to be able to change its affinity mask means we need to send a
   signal. How exactly would the killed application recover (or if it should)
   is still unclear.

2) Return an error to the sched_setaffinity or cpusets caller, and let it deal
   with the error as it sees fit: ignore it, log it, or send a signal.

I think option (2) provides the most flexiblity, and moves policy outside of
the kernel, which is a good thing. However, looking at how cpusets seems to
simply ignore errors when setting a task's cpumask, I wonder if asking from
cpusets to handle any kind of error is asking too much. :-/

Thanks,

Mathieu




-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
