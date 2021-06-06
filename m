Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4769939CF4B
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jun 2021 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhFFNSW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Jun 2021 09:18:22 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:46937 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFFNSV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Jun 2021 09:18:21 -0400
Received: by mail-lj1-f172.google.com with SMTP id e11so18121580ljn.13;
        Sun, 06 Jun 2021 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UyJmePmvAT8ujnkHGmMymmbI4mYpRcN4GEU/l9qlfiY=;
        b=Cw98LNPcknNmGwGC8P9szo5eN68fYbOt6dmIN2aQVcvwc1rDgwFXFro1RA38NSy/Ie
         U6WKUNPRrv2uHUYp6hCwXR8u84/G8QhwWtfGCHoOSt3G4l7nEmxfTVpd5MFKnK65qDq1
         7yLFWFbk2G2pZ4jTRxx4bBXuPo/WAfSek1RNu7E6N5Fi8q51sfEIoJEYALs5ckvUaAIr
         JptX+0Ue0MWIGR5VE2ZtQ4pKDgLTBkf2suLIlMFsZqYeu+pffaC4TkK3e4QILGxOVUJi
         jH1mvQ44vparDOfC2N0VYTSl1wyhxGQzYBqSaTjSeWAUvIKr+Uma6dKfrEZr+JTyX+J9
         Texw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UyJmePmvAT8ujnkHGmMymmbI4mYpRcN4GEU/l9qlfiY=;
        b=dhWJjjiMvVXObOVinWK6Uu2YNv+tRilTeZhW6qRlv/jasJZJ1h0NkKMJv7INP0dcjo
         Z/87Z2TZJbo7RzCcf63catPUj54z5+aF58JAJi+fd0E47++M5OIFaeNCtVLDo+HHS3ZP
         6PdhC+9lJ5a6KnOWnHKsHrPYs40B+fxY8C1OczT1yoQfPaK2Dj+sVB/w15PSbabIdQmk
         ZDp2Z5Ihk3ZvRfcjBRNET2VvzWS37h+PTMtEg43Idq0kNPNj5p2baOKnSTAqOCPrP8jS
         tpAplpD10mG24G8K3PEbqqbWRMqZAp4V6A3kL9umqnLi7n1pkjyuXtpSArrHiP5f/63I
         bQyA==
X-Gm-Message-State: AOAM531nyTWW4ugLV2BTf7fn9/ZcRfUkUa+ugJbbIqNZ9AanoIpW7UzP
        EBiB+NBuElyr98+LI9LtPeM=
X-Google-Smtp-Source: ABdhPJx+zE3g3ByP+HyPd8ppcEeXLxyAbBoJNbCSFuZnfTb6sieO0lsY7gJBhoeZ1l2VubSZ13jh+Q==
X-Received: by 2002:a2e:b819:: with SMTP id u25mr10849232ljo.182.1622985330956;
        Sun, 06 Jun 2021 06:15:30 -0700 (PDT)
Received: from [192.168.1.2] (broadband-5-228-51-184.ip.moscow.rt.ru. [5.228.51.184])
        by smtp.gmail.com with ESMTPSA id u10sm1450879lji.16.2021.06.06.06.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 06:15:29 -0700 (PDT)
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
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Message-ID: <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
Date:   Sun, 6 Jun 2021 16:15:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1622980258.cfsuodze38.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/6/21 2:57 PM, Nicholas Piggin wrote:
> Excerpts from Andrey Semashev's message of June 5, 2021 6:56 pm:
>> On 6/5/21 4:09 AM, Nicholas Piggin wrote:
>>> Excerpts from André Almeida's message of June 5, 2021 6:01 am:
>>>> Às 08:36 de 04/06/21, Nicholas Piggin escreveu:
>>>
>>>>> I'll be burned at the stake for suggesting it but it would be great if
>>>>> we could use file descriptors. At least for the shared futex, maybe
>>>>> private could use a per-process futex allocator. It solves all of the
>>>>> above, although I'm sure has many of its own problem. It may not play
>>>>> so nicely with the pthread mutex API because of the whole static
>>>>> initialiser problem, but the first futex proposal did use fds. But it's
>>>>> an example of an alternate API.
>>>>>
>>>>
>>>> FDs and futex doesn't play well, because for futex_wait() you need to
>>>> tell the kernel the expected value in the futex address to avoid
>>>> sleeping in a free lock. FD operations (poll, select) don't have this
>>>> `value` argument, so they could sleep forever, but I'm not sure if you
>>>> had taken this in consideration.
>>>
>>> I had. The futex wait API would take a fd additional. The only
>>> difference is the waitqueue that is used when a sleep or wake is
>>> required is derived from the fd, not from an address.
>>>
>>> I think the bigger sticking points would be if it's too heavyweight an
>>> object to use (which could be somewhat mitigated with a simpler ida
>>> allocator although that's difficult to do with shared), and whether libc
>>> could sanely use them due to the static initialiser problem of pthread
>>> mutexes.
>>
>> The static initialization feature is not the only benefit of the current
>> futex design, and probably not the most important one. You can work
>> around the static initialization in userspace, e.g. by initializing fd
>> to an invalid value and creating a valid fd upon the first use. Although
>> that would still incur a performance penalty and add a new source of
>> failure.
> 
> Sounds like a serious problem, but maybe it isn't. On the other hand,
> maybe we don't have to support pthread mutexes as they are anyway
> because futex already does that fairly well.
> 
>> What is more important is that waiting on fd always requires a kernel
>> call. This will be terrible for performance of uncontended locks, which
>> is the majority of time.
> 
> No. As I said just before, it would be the same except the waitqueue is
> derived from fd rather than address.

Sorry, in that case I'm not sure I understand how that would work. You 
do need to allocate a fd, do you?

>> Another important point is that a futex that is not being waited on
>> consumes zero kernel resources while fd is a limited resource even when
>> not used. You can have millions futexes in userspace and you are
>> guaranteed not to exhaust any limit as long as you have memory. That is
>> an important feature, and the current userspace is relying on it by
>> assuming that creating mutexes and condition variables is cheap.
> 
> Is it an important feture? Would 1 byte of kernel memory per uncontended
> futex be okay? 10? 100?
> 
> I do see it's very nice the current design that requires no
> initialization for uncontended, I'm just asking questions to get an idea
> of what constraints we're working with. We have a pretty good API
> already which can support unlimited uncontended futexes, so I'm
> wondering do we really need another very very similar API that doesn't
> fix the really difficult problems of the existing one?

It does provide the very much needed features that are missing in the 
current futex. Namely, more futex sizes and wait for multiple. So the 
argument of "why have two similar APIs" is not quite fair. It would be, 
if there was feature parity with futex.

I believe, the low cost of a futex is an important feature, and was one 
of the reasons for its original design and introduction. Otherwise we 
would be using eventfds in mutexes.

One other feature that I didn't mention earlier and which follows from 
its "address in memory" design is the ability to use futexes in 
process-shared memory. This is important for process-shared pthread 
components, too, but has its own value even without this, if you use 
futexes directly. With fds, you can't place the fd in a shared memory 
since every process needs to have its own fd referring to the same 
kernel object, and passing fds cannot be done without a UNIX socket. 
This is incompatible with pthreads API design and would require 
non-trivial design changes to the applications using futexes directly.
