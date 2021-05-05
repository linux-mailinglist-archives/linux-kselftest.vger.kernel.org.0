Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28040373D99
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 May 2021 16:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhEEOYu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 May 2021 10:24:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhEEOYu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 May 2021 10:24:50 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620224632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uqMX/kcgxstoPmvY8Wd/zciVA9qFnbv7Kyz4Ssl4A3I=;
        b=q+jPs/ibe1vFk14EzFP32RiEk+khuaDqb1sbvNsjnQdnLzVO9H5M/j11YHjqJZ0ugu+3mq
        7vTrifLgOeKwo0MstJ/rGJg0BN9//HwaPpFyVUY7wCuPJJC7QOd6Aa4c8ZGjl6fJtKelcS
        8XViEY7UoTcKoLhOG8ha5H4ebq/rj/6vA8k03uyp/9beMrt6OcK+RFY5+fYXTOxp8+5zPk
        dNqZr62L7G9VKFLm81KKGIDkjm0NdjRUV0k0Kj+GfpAIYnAnxGwPf2fJ9xDXx3lstQ86Mn
        1P3lsZVrSy/wRkewtUe7ki+0ZhHU8MkkdF9kXMHxo6it1o2fni9KgvR2+1dCSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620224632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uqMX/kcgxstoPmvY8Wd/zciVA9qFnbv7Kyz4Ssl4A3I=;
        b=NLPrA9n0vhFqdef38DyhJqDycsiHukl0bJ1bmOq18k3B4jnmKVYN9rHGW0uCCIAnbFOIgb
        ZvE6N0pDbcaxsfBg==
To:     Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH v3 00/13] Add futex2 syscalls
In-Reply-To: <YJKQLkHuTH3EWJoR@hirez.programming.kicks-ass.net>
References: <20210427231248.220501-1-andrealmeid@collabora.com> <YJKQLkHuTH3EWJoR@hirez.programming.kicks-ass.net>
Date:   Wed, 05 May 2021 16:23:52 +0200
Message-ID: <87bl9pi7if.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 05 2021 at 14:31, Peter Zijlstra wrote:

> On Tue, Apr 27, 2021 at 08:12:35PM -0300, Andr=C3=A9 Almeida wrote:
>> Hi,
>>=20
>> This patch series introduces the futex2 syscalls.
>
> I still utterly detest that this adds a second hash-table for no
> descernable reason.
>
> The new syscall interface does not depend on that in any way, you
> previously implemented the multi-wait thing in the current futex code.
>
> Like I said last time; I'm okay with the new interface, but I don't see
> why you need to reimplement the insides, that's all pointless code
> duplication.

The real question is whether we really need to model all of this along
the existing futex functionality. I wouldn't mind a new infrastructure
which addresses all the other known issues of futexes and makes the
overall design less horrible than what we have now.

But that needs input from futex users (libraries and other horrible
wrappers) to figure out what they really need, hate, like or do not care
about.

Without that we are bound to pile more crap on the existing pile of
horrors forever.

Thanks,

        tglx
