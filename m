Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388AA39F68B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhFHM2U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhFHM2T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 08:28:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F012FC061574;
        Tue,  8 Jun 2021 05:26:26 -0700 (PDT)
Date:   Tue, 8 Jun 2021 14:26:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623155184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2C0ZxDmj4y+qo/KAldcLkbqVHh+XJhK9DBsclh/JeLg=;
        b=G9HlKQgsvslffXm92n4hMUFjESQIUDawfWhCs0FOIJrzymxNDE84c2FE3rRmRGaj7tu7gH
        aFUJFqddFMlSpPdU0gpAEeV/MVHPss7rBfi47o23RCOGu9TrlOghOmIwfqsp2jU4Zy3pNX
        0zTXrRiPU7YuoMRkQ+f2IUht/NHdreF/fxYV3uVlDaczMf0yKPeyLGJiKkYrdZRGBIlPKA
        tmJwoOjss2kVpnb480oAP/0drS9F16V5ApkILNVzFCDzHcC6/B5Yb6+FajhuXtJpk55CBp
        R37rj1YwrosQaUjvsbMUMzT9I2uhXGhtM/quWNKhxAIS0DwmT77Z/kPDmbDiQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623155184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2C0ZxDmj4y+qo/KAldcLkbqVHh+XJhK9DBsclh/JeLg=;
        b=mbWLkmH0sMwhmLYzk0rP81HAzRoiwiTTp/pMPft53Zrlyelf39tNRhFj7Gi4vkQrchR1Sm
        oQEWq2gaiibPmzDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, acme@kernel.org,
        Andrey Semashev <andrey.semashev@gmail.com>, corbet@lwn.net,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        pgriffais@valvesoftware.com, Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
Message-ID: <20210608122622.oxf662ruaawrtyrd@linutronix.de>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-06-07 12:40:54 [-0300], Andr=C3=A9 Almeida wrote:
>=20
> When I first read Thomas proposal for per table process, I thought that
> the main goal there was to solve NUMA locality issues, not RT latency,
> but I think you are right. However, re-reading the thread at [0], it
> seems that the RT problems where not completely solved in that
> interface, maybe the people involved with that patchset can help to shed
> some light on it.
>=20
> Otherwise, this same proposal could be integrated in futex2, given that
> we would only need to provide to userland some extra flags and add some
> `if`s around the hash table code (in a very similar way the NUMA code
> will be implemented in futex2).

There are slides at [0] describing some attempts and the kernel tree [1]
=66rom that time.

The process-table solves the problem to some degree that two random
process don't collide on the same hash bucket. But as Peter Zijlstra
pointed out back then two threads from the same task could collide on
the same hash bucket (and with ASLR not always). So the collision is
there but limited and this was not perfect.

All the attempts with API extensions didn't go well because glibc did
not want to change a bit. This starts with a mutex that has a static
initializer which has to work (I don't remember why the first
pthread_mutex_lock() could not fail with -ENOMEM but there was
something) and ends with glibc's struct mutex which is full and has no
room for additional data storage.

The additional data in user's struct mutex + init would have the benefit
that instead uaddr (which is hashed for the in-kernel lookup) a cookie
could be used for the hash-less lookup (and NUMA pointer where memory
should be stored).

So. We couldn't change a thing back then so nothing did happen. We
didn't want to create a new interface and a library implementing it plus
all the functionality around it (like pthread_cond, phtread_barrier, =E2=80=
=A6).
Not to mention that if glibc continues to use the "old" locking
internally then the application is still affected by the hash-collision
locking (or the NUMA problem) should it block on the lock.

[0] https://linutronix.de/PDF/2016_futex_Siewior.pdf
[1] https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/linux-futex.git/

Sebastian
