Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B3C177686
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 14:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgCCNAg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 08:00:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53994 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727175AbgCCNAf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 08:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583240435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQH3gFaN0+ndXt7bwldiJXwZh7UdzaebXE8uKCbRSZ4=;
        b=D0GntM6E2M5M/qEUYJeVxyQRk6WBtVx5Ry9FbrW/RbnXD/sAz8rVRVzhCsu7b7MD+X+Hef
        Js9haa/qKdFKruTVmKfhKJqfD1pFJWCkGEHdFzzSoZxN4pNjdak2uBk4igK9V6XJ2hz2MD
        9UNG1f+u43eSvolSJybKK9D8pqhQvRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-gBMWLwVAOniOuvpMzbp2MA-1; Tue, 03 Mar 2020 08:00:31 -0500
X-MC-Unique: gBMWLwVAOniOuvpMzbp2MA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1E37800D5B;
        Tue,  3 Mar 2020 13:00:28 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-227.str.redhat.com [10.33.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C17B60C80;
        Tue,  3 Mar 2020 13:00:13 +0000 (UTC)
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
        adhemerval.zanella@linaro.org, libc-alpha@sourceware.org
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
Date:   Tue, 03 Mar 2020 14:00:12 +0100
In-Reply-To: <20200303120050.GC2596@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 3 Mar 2020 13:00:50 +0100")
Message-ID: <87pndth9ur.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Peter Zijlstra:

> So how about we introduce new syscalls:
>
>   sys_futex_wait(void *uaddr, unsigned long val, unsigned long flags, ktime_t *timo);
>
>   struct futex_wait {
> 	void *uaddr;
> 	unsigned long val;
> 	unsigned long flags;
>   };
>   sys_futex_waitv(struct futex_wait *waiters, unsigned int nr_waiters,
> 		  unsigned long flags, ktime_t *timo);
>
>   sys_futex_wake(void *uaddr, unsigned int nr, unsigned long flags);
>
>   sys_futex_cmp_requeue(void *uaddr1, void *uaddr2, unsigned int nr_wake,
> 			unsigned int nr_requeue, unsigned long cmpval, unsigned long flags);
>
> Where flags:
>
>   - has 2 bits for size: 8,16,32,64
>   - has 2 more bits for size (requeue) ??
>   - has ... bits for clocks
>   - has private/shared
>   - has numa

What's the actual type of *uaddr?  Does it vary by size (which I assume
is in bits?)?  Are there alignment constraints?

These system calls seemed to be type-polymorphic still, which is
problematic for defining a really nice C interface.  I would really like
to have a strongly typed interface for this, with a nice struct futex
wrapper type (even if it means that we need four of them).

Will all architectures support all sizes?  If not, how do we probe which
size/flags combinations are supported?

> For NUMA I propose that when NUMA_FLAG is set, uaddr-4 will be 'int
> node_id', with the following semantics:
>
>  - on WAIT, node_id is read and when 0 <= node_id <= nr_nodes, is
>    directly used to index into per-node hash-tables. When -1, it is
>    replaced by the current node_id and an smp_mb() is issued before we
>    load and compare the @uaddr.
>
>  - on WAKE/REQUEUE, it is an immediate index.

Does this mean the first waiter determines the NUMA index, and all
future waiters use the same chain even if they are on different nodes?

I think documenting this as a node index would be a mistake.  It could
be an arbitrary hint for locating the corresponding kernel data
structures.

> Any invalid value with result in EINVAL.

Using uaddr-4 is slightly tricky with a 64-bit futex value, due to the
need to maintain alignment and avoid padding.

Thanks,
Florian

