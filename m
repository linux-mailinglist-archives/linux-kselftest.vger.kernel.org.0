Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2330239F9C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 16:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhFHO7w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 10:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhFHO7v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 10:59:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB10C061574;
        Tue,  8 Jun 2021 07:57:58 -0700 (PDT)
Date:   Tue, 8 Jun 2021 16:57:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623164277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ql/uLWG2lo9gEF4nTk83lBLHHLk6fJHDMYjvgA8J/vk=;
        b=fQ3d4QOWLRsfZDlGVxrfxRBRd9mHeTn4TTW/ZANS6O/KFU2bl/Vn0QaBfWQPvNRo9TtxkC
        Oriqf/aQRIgIh4GGSf5WNN0pSg77AOBCkI0snkotHNPkfc/iQXBdYpicEIjCHbB2oj8EE/
        9hM3XijwSPhvjG+EhbuAS3wQlGXm/vVKOVLPm8isoSgI9UINLldQCozSg90HRXsKRk5xgB
        yjVXQh+4+MF0aZAsxJrXuI9/hw9FHmo2PfnrnYRCuy9aJzrgEBGpsFkKCJXkE5PGSPNJTL
        U6Nc1NZPjje/BeXMzaBkukOV825/dOqBbXn/5maDiXiJnQZAbpuH6Ge9iuhM+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623164277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ql/uLWG2lo9gEF4nTk83lBLHHLk6fJHDMYjvgA8J/vk=;
        b=VNLABMwUSUAtpxajK8YAQCkD+8Z3/1DdJdtzdvYOFLXDS8Tka6SQ9E3jrfhl2K2QcYg1b/
        HUUoy/O9CfF8GEAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
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
Message-ID: <20210608145755.pwfhqrqdqft47nbw@linutronix.de>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
 <20210608122622.oxf662ruaawrtyrd@linutronix.de>
 <YL99cR0H+7xgU8L1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YL99cR0H+7xgU8L1@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-06-08 16:23:45 [+0200], Peter Zijlstra wrote:
> There's more futex users than glibc, and some of them are really hurting
> because of the NUMA issue. Oracle used to (I've no idea what they do or
> do not do these days) use sysvsem because the futex hash table was a
> massive bottleneck for them.
>=20
> And as Nick said, other vendors are having the same problems.

I just wanted to do a brief summary of last events. The implementation
tglx did with the cookie resulting in a quick lookup did not have any
downsides except that the user-API had to change glibc couldn't. So if
we are back to square one why not start with that.

> And if you don't extend the futex to store the nid you put the waiter in
> (see all the problems above) you will have to do wakeups on all nodes,
> which is both slower than it is today, and scales possibly even worse.
>=20
> The whole numa-aware qspinlock saga is in part because of futex.

sure.

> That said; if we're going to do the whole futex-vector thing, we really
> do need a new interface, because the futex multiplex monster is about to
> crumble (see the fun wrt timeouts for example).

This might have been a series of unfortunate events leading to this. The
sad part is that glibc has a comment that the kernel does not support
this and nobody bother to change it (until recently).

> And if we're going to do a new interface, we ought to make one that can
> solve all these problems. Now, ideally glibc will bring forth some
> opinions, but if they don't want to play, we'll go back to the good old
> days of non-standard locking libraries.. we're halfway there already due
> to glibc not wanting to break with POSIX were we know POSIX was just
> dead wrong broken.
>=20
> See: https://github.com/dvhart/librtpi

I'm aware of that, I hacked on it, too :) This was the unfortunate
result of a ~8y old bug which was not fixed instead and part of the code
was rewritten and a bit-spinlock was added in user-land. You may
remember the discussion regarding spins in userland=E2=80=A6
That said, REQUEUE_PI is no longer used by glibc.

Sebastian
