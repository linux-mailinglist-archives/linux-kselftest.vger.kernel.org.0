Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23B31777AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 14:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgCCNr0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 08:47:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37472 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728877AbgCCNr0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 08:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583243245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oLbXIHNh6ajSmLz52Mx2ILZg/lbZzgtk/alq2aRbGqk=;
        b=Myt8WNsSWu7CRJtjDG1r1Ni6MsRE8bCwJyLUEyy2OnvIO0ZiV0aFQGcfHXAb11RD4RS55Z
        3TgD+LqREHJ+dCZ8dMsSCOx+ZiCCkbNfXjpcrNhnw01NQGQQsroUAyT0EfDu7SsxJA+ESC
        xxw/sdewA6yVrwi8YfCHNG62PmapJEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-yu8_6u-4Ob62cHeK20fo5w-1; Tue, 03 Mar 2020 08:47:21 -0500
X-MC-Unique: yu8_6u-4Ob62cHeK20fo5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8042A0CC0;
        Tue,  3 Mar 2020 13:47:18 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-227.str.redhat.com [10.33.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8383100164D;
        Tue,  3 Mar 2020 13:47:12 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, dvhart@infradead.org, mingo@redhat.com,
        z.figura12@gmail.com, steven@valvesoftware.com,
        steven@liquorix.net, malteskarupke@web.de, carlos@redhat.com,
        adhemerval.zanella@linaro.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org
Subject: Re: 'simple' futex interface [Was: [PATCH v3 1/4] futex: Implement mechanism to wait on any of several futexes]
References: <20200213214525.183689-1-andrealmeid@collabora.com>
        <20200213214525.183689-2-andrealmeid@collabora.com>
        <20200228190717.GM18400@hirez.programming.kicks-ass.net>
        <20200228194958.GO14946@hirez.programming.kicks-ass.net>
        <87tv3aflqm.fsf@nanos.tec.linutronix.de>
        <967d5047-2cb6-d6d8-6107-edb99a4c9696@valvesoftware.com>
        <87o8thg031.fsf@nanos.tec.linutronix.de>
        <beb82055-96fa-cb64-a06e-9d7a0946587b@valvesoftware.com>
        <20200303120050.GC2596@hirez.programming.kicks-ass.net>
        <87pndth9ur.fsf@oldenburg2.str.redhat.com>
        <20200303132150.GD2596@hirez.programming.kicks-ass.net>
Date:   Tue, 03 Mar 2020 14:47:11 +0100
In-Reply-To: <20200303132150.GD2596@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 3 Mar 2020 14:21:50 +0100")
Message-ID: <878skhh7og.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

(added missing Cc: for linux-api, better late than never I guess)

* Peter Zijlstra:

>> What's the actual type of *uaddr?  Does it vary by size (which I assume
>> is in bits?)?  Are there alignment constraints?
>
> Yeah, u8, u16, u32, u64 depending on the size specified in flags.
> Naturally aligned.

So 4-byte alignment for u32 and 8-byte alignment for u64 on all
architectures?

(I really want to nail this down, sorry.)

>> These system calls seemed to be type-polymorphic still, which is
>> problematic for defining a really nice C interface.  I would really like
>> to have a strongly typed interface for this, with a nice struct futex
>> wrapper type (even if it means that we need four of them).
>
> You mean like: futex_wait1(u8 *,...) futex_wait2(u16 *,...)
> futex_wait4(u32 *,...) etc.. ?
>
> I suppose making it 16 or so syscalls (more if we want WAKE_OP or
> requeue across size) is a bit daft, so yeah, sucks.

We could abstract this in the userspace wrapper.  It would help to have
an explicit size argument, or at least an extension-safe way to pass
this information to the kernel.  I guess if everything else fails, we
could use the flags bits for that, as long as it is clear that the
interface will only support these six types (four without NUMA, two with
NUMA).

>> Will all architectures support all sizes?  If not, how do we probe which
>> size/flags combinations are supported?
>
> Up to the native word size (long), IOW ILP32 will not support u64.

Many ILP32 targets could support atomic accesses on 8-byte storage
units, as long as there is 8-byte alignment.  But given how common
4-byte-align u64 is on 32-bit, maybe that's not such a good idea.

> Overlapping futexes are expressly forbidden, that is:
>
> {
> 	u32 var;
> 	void *addr = &var;
> }
>
> P0()
> {
> 	futex_wait4(addr,...);
> }
>
> P1()
> {
> 	futex_wait1(addr+1,...);
> }
>
> Will have one of them return something bad.

That makes sense.  A strongly typed interface would also reflect that in
the types.

>> > For NUMA I propose that when NUMA_FLAG is set, uaddr-4 will be 'int
>> > node_id', with the following semantics:
>> >
>> >  - on WAIT, node_id is read and when 0 <= node_id <= nr_nodes, is
>> >    directly used to index into per-node hash-tables. When -1, it is
>> >    replaced by the current node_id and an smp_mb() is issued before we
>> >    load and compare the @uaddr.
>> >
>> >  - on WAKE/REQUEUE, it is an immediate index.
>> 
>> Does this mean the first waiter determines the NUMA index, and all
>> future waiters use the same chain even if they are on different nodes?
>
> Every new waiter could (re)set node_id, after all, when its not actually
> waiting, nobody cares what's in that field.
>
>> I think documenting this as a node index would be a mistake.  It could
>> be an arbitrary hint for locating the corresponding kernel data
>> structures.
>
> Nah, it allows explicit placement, after all, we have set_mempolicy()
> and sched_setaffinity() and all the other NUMA crud so that programs
> that think they know what they're doing, can do explicit placement.

But I'm not sure if it makes sense to read the node ID from the
neighboring value of a futex used in this way.  Or do you think that
userspace might set the node ID to help the kernel implementation, and
not just relying on it to be set by the kernel after initializing it to
-1?

Conversely, even for non-NUMA systems, a lookup hint that allows to
reduce in-kernel futex contention might be helpful.  If it's documented
to be the NUME node ID, that wouldn't be possible.

>> > Any invalid value with result in EINVAL.
>> 
>> Using uaddr-4 is slightly tricky with a 64-bit futex value, due to the
>> need to maintain alignment and avoid padding.
>
> Yes, but it works, unlike uaddr+4 :-) Also, 1 and 2 byte futexes and
> NUMA_FLAG are incompatible due to this, but I feel short futexes and
> NUMA don't really make sense anyway, the only reason to use a short
> futex is to save space, so you don't want another 4 bytes for numa on
> top of that anyway.

I think it would be much easier to make the NUMA hint the same size of
the futex, so 4 and 8 bytes.  It could also make sense to require 8 and
16 byte alignment, to permit different implementation choices in the
future.

So we'd have:

struct futex8  { u8 value; };
struct futex16 { u16 value __attribute__ ((aligned (2))); };
struct futex32 { u32 value __attribute__ ((aligned (4))); };
struct futex64 { u64 value __attribute__ ((aligned (8))); };
struct futex32_numa { u32 value __attribute__ ((aligned (8))); u32 hint; };
struct futex64_numa { u64 value __attribute__ ((aligned (16))); u64 hint; };

Thanks,
Florian

