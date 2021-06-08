Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164D039F8F5
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 16:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhFHO0S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhFHO0N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 10:26:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B2C061574;
        Tue,  8 Jun 2021 07:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zX96ZCzY0JGSNUdiiISobh0w3iM3b3UNKsSwCK2HxCg=; b=M38agAJKM8aiWMzD70AXWY3S8U
        W5wMAqOSDFjpolL3ie5PXgz6XDfW/wRTD6gmGSLi1Yhlrmh9ea7S9vP3tIFWKwc/rgJqt0dCT2Bh/
        b31OlbNmT0wkihlkkWmFS56ImyhPYLyWIoL0deuSVF1j7fV4/qR7dU91QTNfMPJmnxhp0LzBzBaIp
        Wf5Hs4oSz8OW1UwhVApSybo0beem1fbvXS/LOmSH/+z8cwq8nCiTvdpOGhu6jPDDkLbU5mE99XfFk
        zl+DuddP0VPWOvr4tvF6B7bMRWfGqKLlA8+MT9fmWqzPA+6fNGnCPezNhIkqNQoUni/ywbHMT5mHy
        hfvKwNFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqcdp-004m6Q-07; Tue, 08 Jun 2021 14:23:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E64A830015A;
        Tue,  8 Jun 2021 16:23:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5D9D201DE6E9; Tue,  8 Jun 2021 16:23:45 +0200 (CEST)
Date:   Tue, 8 Jun 2021 16:23:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Nicholas Piggin <npiggin@gmail.com>, acme@kernel.org,
        Andrey Semashev <andrey.semashev@gmail.com>, corbet@lwn.net,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>, pgriffais@valvesoftware.com,
        Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
Message-ID: <YL99cR0H+7xgU8L1@hirez.programming.kicks-ass.net>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
 <20210608122622.oxf662ruaawrtyrd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210608122622.oxf662ruaawrtyrd@linutronix.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 08, 2021 at 02:26:22PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-06-07 12:40:54 [-0300], André Almeida wrote:
> > 
> > When I first read Thomas proposal for per table process, I thought that
> > the main goal there was to solve NUMA locality issues, not RT latency,
> > but I think you are right. However, re-reading the thread at [0], it
> > seems that the RT problems where not completely solved in that
> > interface, maybe the people involved with that patchset can help to shed
> > some light on it.
> > 
> > Otherwise, this same proposal could be integrated in futex2, given that
> > we would only need to provide to userland some extra flags and add some
> > `if`s around the hash table code (in a very similar way the NUMA code
> > will be implemented in futex2).
> 
> There are slides at [0] describing some attempts and the kernel tree [1]
> from that time.
> 
> The process-table solves the problem to some degree that two random
> process don't collide on the same hash bucket. But as Peter Zijlstra
> pointed out back then two threads from the same task could collide on
> the same hash bucket (and with ASLR not always). So the collision is
> there but limited and this was not perfect.
> 
> All the attempts with API extensions didn't go well because glibc did
> not want to change a bit. This starts with a mutex that has a static
> initializer which has to work (I don't remember why the first
> pthread_mutex_lock() could not fail with -ENOMEM but there was
> something) and ends with glibc's struct mutex which is full and has no
> room for additional data storage.
> 
> The additional data in user's struct mutex + init would have the benefit
> that instead uaddr (which is hashed for the in-kernel lookup) a cookie
> could be used for the hash-less lookup (and NUMA pointer where memory
> should be stored).
> 
> So. We couldn't change a thing back then so nothing did happen. We
> didn't want to create a new interface and a library implementing it plus
> all the functionality around it (like pthread_cond, phtread_barrier, …).
> Not to mention that if glibc continues to use the "old" locking
> internally then the application is still affected by the hash-collision
> locking (or the NUMA problem) should it block on the lock.

There's more futex users than glibc, and some of them are really hurting
because of the NUMA issue. Oracle used to (I've no idea what they do or
do not do these days) use sysvsem because the futex hash table was a
massive bottleneck for them.

And as Nick said, other vendors are having the same problems.

And if you don't extend the futex to store the nid you put the waiter in
(see all the problems above) you will have to do wakeups on all nodes,
which is both slower than it is today, and scales possibly even worse.

The whole numa-aware qspinlock saga is in part because of futex.


That said; if we're going to do the whole futex-vector thing, we really
do need a new interface, because the futex multiplex monster is about to
crumble (see the fun wrt timeouts for example).

And if we're going to do a new interface, we ought to make one that can
solve all these problems. Now, ideally glibc will bring forth some
opinions, but if they don't want to play, we'll go back to the good old
days of non-standard locking libraries.. we're halfway there already due
to glibc not wanting to break with POSIX were we know POSIX was just
dead wrong broken.

See: https://github.com/dvhart/librtpi


