Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF9239C6E8
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jun 2021 10:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFEI7F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Jun 2021 04:59:05 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:40610 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFEI7E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Jun 2021 04:59:04 -0400
Received: by mail-lf1-f47.google.com with SMTP id w33so17683653lfu.7;
        Sat, 05 Jun 2021 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILIrHKLM5BATuWgmLULRPhKcib+qBSgE3U9c4pZR14s=;
        b=RiwZtZPeZhwwYgIgC/GkXLmhtvgvgrh0N/jKd1lSZ9HORyyqpqn+72ZB0I5yiH4Siw
         oE8m1I0Ruyg9qcXIDATzY/eRlYG2CvxuTnxOKITwSpY+5j7Du0R4Z3ypMONwR+WlV9Ot
         dLE+7vvw5PKn0mpTYThbZiN6+Hn6m+1o2YkIBCjBVkb261IS78bmFug5lyw9F773m+AA
         P3qWPXjCZ9CTPJgPcjoq6akIjVvdDqQWqMZX+j2uobC41/oIml1A/wQyvZx+aEQaO6vy
         ESb0klZdtN/lYbue9AA6Xxg8wLq+mxZ0/sW4c/3lLpfMr692tpfAE1FYzz2MzGvlzmg9
         oJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILIrHKLM5BATuWgmLULRPhKcib+qBSgE3U9c4pZR14s=;
        b=T2eztqpPsJtAVJaFzS8XmBFhGnS0D6F5tPhccZbtAIw+p8981eBfXAtjfY7bZJuwes
         enhCYhx2w2pWVwqAq/8CtnCpPb+6JsptYabhbxZiub9YC0LLksoXSLvBN0UfoRKSytzo
         pcDBy6H3pU42GtZ0hJvd13dyhTrUSqWN6ZbLhZkg71E+lfS0Wgb9HrPDpOyVZR6S+toP
         4qHzkQthuuX/YxzByppJE4KM+FOwRVyS2o3AP+KV2AFUxDKyue2A5yYXEoM1mrOqvvex
         cMgPKwnId2eklEu91hywBSRmTMH5X7OS4ujwtRIBlSlt0wit6toCcOsDRzHcXcXTuyWp
         6U6Q==
X-Gm-Message-State: AOAM533k+ygC0k8ONli5NR1QKGymsrGczvv9VQLcPY6uJQkvWRSy/StX
        +qrZHANURRHZU4HcRM4xNwU=
X-Google-Smtp-Source: ABdhPJwJD/KAhhiahlwsu+Y5RAnyMZPeqS9CtG0MMkcIB/o8rGlXMpg3PJ28VLkZscUzvQbPsxVDXQ==
X-Received: by 2002:ac2:52b3:: with SMTP id r19mr5598865lfm.525.1622883375992;
        Sat, 05 Jun 2021 01:56:15 -0700 (PDT)
Received: from [192.168.1.2] (broadband-5-228-51-184.ip.moscow.rt.ru. [5.228.51.184])
        by smtp.gmail.com with ESMTPSA id a20sm978035ljk.29.2021.06.05.01.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 01:56:14 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Cc:     acme@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Davidlohr Bueso <dave@stgolabs.net>,
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
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Message-ID: <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
Date:   Sat, 5 Jun 2021 11:56:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1622853816.mokf23xgnt.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/5/21 4:09 AM, Nicholas Piggin wrote:
> Excerpts from André Almeida's message of June 5, 2021 6:01 am:
>> Às 08:36 de 04/06/21, Nicholas Piggin escreveu:
> 
>>> I'll be burned at the stake for suggesting it but it would be great if
>>> we could use file descriptors. At least for the shared futex, maybe
>>> private could use a per-process futex allocator. It solves all of the
>>> above, although I'm sure has many of its own problem. It may not play
>>> so nicely with the pthread mutex API because of the whole static
>>> initialiser problem, but the first futex proposal did use fds. But it's
>>> an example of an alternate API.
>>>
>>
>> FDs and futex doesn't play well, because for futex_wait() you need to
>> tell the kernel the expected value in the futex address to avoid
>> sleeping in a free lock. FD operations (poll, select) don't have this
>> `value` argument, so they could sleep forever, but I'm not sure if you
>> had taken this in consideration.
> 
> I had. The futex wait API would take a fd additional. The only
> difference is the waitqueue that is used when a sleep or wake is
> required is derived from the fd, not from an address.
> 
> I think the bigger sticking points would be if it's too heavyweight an
> object to use (which could be somewhat mitigated with a simpler ida
> allocator although that's difficult to do with shared), and whether libc
> could sanely use them due to the static initialiser problem of pthread
> mutexes.

The static initialization feature is not the only benefit of the current 
futex design, and probably not the most important one. You can work 
around the static initialization in userspace, e.g. by initializing fd 
to an invalid value and creating a valid fd upon the first use. Although 
that would still incur a performance penalty and add a new source of 
failure.

What is more important is that waiting on fd always requires a kernel 
call. This will be terrible for performance of uncontended locks, which 
is the majority of time.

Another important point is that a futex that is not being waited on 
consumes zero kernel resources while fd is a limited resource even when 
not used. You can have millions futexes in userspace and you are 
guaranteed not to exhaust any limit as long as you have memory. That is 
an important feature, and the current userspace is relying on it by 
assuming that creating mutexes and condition variables is cheap.

Having futex fd would be useful in some cases to be able to integrate 
futexes with IO. I did have use cases where I would have liked to have 
FUTEX_FD in the past. These cases arise when you already have a thread 
that operates on fds and you want to avoid having a separate thread that 
blocks on futexes in a similar fashion. But, IMO, that should be an 
optional opt-in feature. By far, not every futex needs to have an fd. 
For just waiting on multiple futexes, the native support that futex2 
provides is superior.

PS: I'm not asking FUTEX_FD to be implemented as part of futex2 API. 
futex2 would be great even without it.
