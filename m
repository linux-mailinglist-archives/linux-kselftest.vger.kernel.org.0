Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3850839FEE3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 20:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhFHSVc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 14:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233736AbhFHSV1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 14:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623176373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U5VkwIvxnbWpvc1/0iPLy1KO47p1rlWOYHzaaUg7B9s=;
        b=ejaP8U8dCU/GuBQkq9o1pz31iT8gfjeD+oyiKnrWvkr0Jz9QgInvSVHuXLCTzeXk35CBsP
        0/50/NPkyX6S038rve4OWSxRpLjUZ63ZO2AWGnoGVw6brtHLq/AJ2YaJ+tEo0x+nTQennA
        2PoeG81XVoyoqbEAipId7KhllqbBUH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-tcovvUVQM5arXn3eX-mMOA-1; Tue, 08 Jun 2021 14:19:32 -0400
X-MC-Unique: tcovvUVQM5arXn3eX-mMOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 360561009446;
        Tue,  8 Jun 2021 18:19:29 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4933160853;
        Tue,  8 Jun 2021 18:19:23 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kselftest@vger.kernel.org, joel@joelfernandes.org,
        Andrey Semashev <andrey.semashev@gmail.com>,
        kernel@collabora.com, shuah@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Oskolkov <posk@posk.io>, corbet@lwn.net,
        krisman@collabora.com, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>, acme@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        z.figura12@gmail.com, Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, pgriffais@valvesoftware.com
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
References: <20210603195924.361327-1-andrealmeid@collabora.com>
        <1622799088.hsuspipe84.astroid@bobo.none>
        <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
        <1622853816.mokf23xgnt.astroid@bobo.none>
        <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
        <20210608122622.oxf662ruaawrtyrd@linutronix.de>
        <YL99cR0H+7xgU8L1@hirez.programming.kicks-ass.net>
        <74c7f1c1-ca15-1e86-a988-a4d349ad16ef@linaro.org>
Date:   Tue, 08 Jun 2021 20:19:21 +0200
In-Reply-To: <74c7f1c1-ca15-1e86-a988-a4d349ad16ef@linaro.org> (Adhemerval
        Zanella's message of "Tue, 8 Jun 2021 15:08:44 -0300")
Message-ID: <878s3k9q3a.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Adhemerval Zanella:

> Also currently we don't have a specific usage.  The proposed patch to
> add the 'pthread_mutex_lock_any' and 'pthreada_timedlock_any' [3] 
> also did not gave much detail in realword usages or how it can be
> leveraged.

The current rwlock implementation in glibc uses a torn 32-bit futex read
which is part of an atomically updated 64-bit word.  That's just really,
really ugly, and I suspect we could make that go away with futex2.

Thanks,
Florian

