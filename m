Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3034439FEB7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 20:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhFHSMC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 14:12:02 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]:43698 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhFHSMC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 14:12:02 -0400
Received: by mail-qv1-f53.google.com with SMTP id e18so11289607qvm.10
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jun 2021 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SzY5mAzb8iAAncNXCHh5zNAEVzbO39nRlIsEjy7/kj4=;
        b=yP1M9TwVufAhZhzjKMz4aXj5vc2/bthnQJnbC+4WdSfV+iBjkqH4wKJpiecqQ/eP8g
         hBDLDWr0z6h+d218Lmsm1mjnb8XAh/r5jZhaHZYTv447YW5yFi8n0fl/p8XWGpr4U6tb
         ym/nrKyOaJQcyxf1gk8nwJBCsTm8hr4GauoWtyKAVkx/pJGSe1P1h966OMxnD+OJp1V0
         7nG9F97aKotXZ+nrrp4yfZ6Trq/o0rJwmlZs+WtiRFHjDu3kxnLxw9A3XxG3/IKQc/xO
         1ctEGT0Yjl99/hnPpVyeM3+yfa9oQMUgpW3Cb8elFblEIYuU7fw6dO9OQwr5dhYA+M3R
         Hz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SzY5mAzb8iAAncNXCHh5zNAEVzbO39nRlIsEjy7/kj4=;
        b=jU6hiOTEhvSbJrQU5Hpr3mzprFZgCly4adC8J361Gr3kyb4vjhxOwiSDBbDW+VVO+M
         hzeJKA5YLg8mp1PHVHXwLsQFmhmP6rBhUD1hdOK/cJC2bb3yIbzr5l2eeX+M3Ojns4bP
         lp6nEgN9hr4waSwspn0c6yY+BZ8ayb3k/x41GPIADlXvGjZFbssgR2sI3sGpFurBcBPr
         EyWOjFswXkkKhJo6a80AN8gb5X2BY02mJ9z9Tkiz0TdmZWcyjnptOsfG385SF9A+AWCY
         /xKUoIjsNyGoEW65IZ968UHAMtdI4OkZlyzw+0/I41ZjfSJVu+Z7tk+c3yOVLqMYYlUB
         s+5Q==
X-Gm-Message-State: AOAM530kY1+3z+vzEtXTvrksEfkdiB9/L385ZqUjusl7JTDyhSufVyMA
        T4jm2h72lItBDL8AlwJmdK9A6g==
X-Google-Smtp-Source: ABdhPJzq29VJTnN5Q6aeV8Pg0HAuE5CchMgl31X1oKLF8UNjqTft6fNXk8EmKW6Qk8X9KRpEuN1lFQ==
X-Received: by 2002:a05:6214:d41:: with SMTP id 1mr1468950qvr.6.1623175732347;
        Tue, 08 Jun 2021 11:08:52 -0700 (PDT)
Received: from [192.168.1.4] ([177.194.59.218])
        by smtp.gmail.com with ESMTPSA id h12sm11987725qkj.52.2021.06.08.11.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 11:08:52 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kselftest@vger.kernel.org, joel@joelfernandes.org,
        Andrey Semashev <andrey.semashev@gmail.com>,
        kernel@collabora.com, shuah@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Oskolkov <posk@posk.io>, corbet@lwn.net,
        krisman@collabora.com, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>, acme@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        z.figura12@gmail.com, Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, pgriffais@valvesoftware.com
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
 <20210608122622.oxf662ruaawrtyrd@linutronix.de>
 <YL99cR0H+7xgU8L1@hirez.programming.kicks-ass.net>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
Message-ID: <74c7f1c1-ca15-1e86-a988-a4d349ad16ef@linaro.org>
Date:   Tue, 8 Jun 2021 15:08:44 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL99cR0H+7xgU8L1@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> All the attempts with API extensions didn't go well because glibc did
> not want to change a bit. This starts with a mutex that has a static
> initializer which has to work (I don't remember why the first
> pthread_mutex_lock() could not fail with -ENOMEM but there was
> something) and ends with glibc's struct mutex which is full and has no
> room for additional data storage.

Yes, we have binary compatibility constraints that prevents us to simply
broken old binaries.  This is quite true for static initialization,
which imposes even harder constraints, different than the pthread_mutex_t
size where we can workaround with symbols versioning. But even then we hear
from users that out pthread_mutex_t is still way larger, specially for
fine grained locking so I am not sure if we do want to extend it.

> That said; if we're going to do the whole futex-vector thing, we really
> do need a new interface, because the futex multiplex monster is about to
> crumble (see the fun wrt timeouts for example).
> 
> And if we're going to do a new interface, we ought to make one that can
> solve all these problems. Now, ideally glibc will bring forth some
> opinions, but if they don't want to play, we'll go back to the good old
> days of non-standard locking libraries.. we're halfway there already due
> to glibc not wanting to break with POSIX were we know POSIX was just
> dead wrong broken.
> 
> See: https://github.com/dvhart/librtpi

You are right, we don't really want to break POSIX requirements in this
regard because users constantly come with scenarios where they do expect
our implementation to be conformant [1].  And even now, there are case we 
don't get it fully right [2] and it is really hard to fix such issues.

If I recall correctly from a recent plumber couple of years ago about 
the librtpi, the presents stated their implement do not follow POSIX
standard by design.  It suits then for their required work, but it is 
not what we really aim for glibc.  We *might* try to provide as an 
extension, but even then I am not if it would be fully possible due 
API constraints.

So, regarding the futex2 we might try to support it eventually; but if
this newer interface is not a really a superset of futex1 we won't 
put much effort. Supporting newer syscall requires an extra effort from
glibc, we need to keep fallback for older ones in case the kernel is
too old and it also imposes runtime costs.

Also currently we don't have a specific usage.  The proposed patch to
add the 'pthread_mutex_lock_any' and 'pthreada_timedlock_any' [3] 
also did not gave much detail in realword usages or how it can be
leveraged.

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=13165
[2] https://sourceware.org/bugzilla/show_bug.cgi?id=25847
[3] https://sourceware.org/pipermail/libc-alpha/2019-July/105422.html
