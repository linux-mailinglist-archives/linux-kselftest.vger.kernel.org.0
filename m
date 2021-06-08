Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4239FEFA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhFHSZu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 14:25:50 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:35609 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhFHSZt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 14:25:49 -0400
Received: by mail-qt1-f176.google.com with SMTP id g12so3670014qtb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jun 2021 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nGNzR+o9zZcSK3DgIga4bw5mHaZMvM8bFKU8VLJam94=;
        b=YD4gTOo2PMuJlmavL/H7u9Qp8mdsQlQ7TAyzX2z4mWD2a+RWlrZ9jOLmSabQsLkUUY
         MIMhbdSX1Z9970av0crItFOwiwGbItQaDhVjd6vYKW3wchV7NNWHLjybOxFwvMvXcVWH
         HPwWZR1dCtmzye5khwI6kRA+ay/MruK9N+6/hBulWfplZSYUu00aDvGnn5Nbi34UYG7A
         V0DBDPWjJ+HzByKvG3C0GGsOCQ0WTiKIo30TEk0fMDXSSxD+3kT/9z/tK/6S8+7hUzCX
         zpnqQogpobPgrHLdHxhVKr5+UoeGHMEUitA352qwRez9YrGpBwX32LdaepbJl0ahfsq1
         HDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nGNzR+o9zZcSK3DgIga4bw5mHaZMvM8bFKU8VLJam94=;
        b=Jpxbyq+JD1wHUDsugQ5ifeQZntwMzFdqpLrE9SbAHeWuRUh4xnse/WkDxu81Y2sviJ
         ysT595jOhGf2h7ZtAFvDc/fke0DB3APHUNkPfID1d0oo5tlh32ND4UiyjuLIbAJ7Odv1
         rToI7MIi8JvpioO9LLwj7slolS1tijPHSsaClDfoT63xGTR1U+Y1oUEcTsapNJGx3utT
         ATpLgLWlFOHUqzVtPvdFZNIzxkApp/mhdDXIV7+mKeMT2YcUv9I8+CcqHPVMwk1FSWCK
         WiXDUPtMDyb7Pgm2aO2DywBA1V3/VI76NpF/7ViH9EFDAERXUtdW0ZTjWRc+al/c17Ht
         6phQ==
X-Gm-Message-State: AOAM531fSIAUKsxyBBKWdYP0e+35Rz2W2OEYmifHHWsXjSJICIi7gInT
        Edo10kxh8vGwU9oWYydJ7m60Ow==
X-Google-Smtp-Source: ABdhPJx6rJCefmbMgALRZq4VLRmbNNuDEoO3lVgsKOp/XHEZ7neGSMNeEEnuADsDxZ5MIUn+BvSu7Q==
X-Received: by 2002:ac8:7590:: with SMTP id s16mr16195230qtq.259.1623176576091;
        Tue, 08 Jun 2021 11:22:56 -0700 (PDT)
Received: from [192.168.1.4] ([177.194.59.218])
        by smtp.gmail.com with ESMTPSA id q2sm6998062qkc.77.2021.06.08.11.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 11:22:55 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Florian Weimer <fweimer@redhat.com>
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
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
 <74c7f1c1-ca15-1e86-a988-a4d349ad16ef@linaro.org>
 <878s3k9q3a.fsf@oldenburg.str.redhat.com>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
Message-ID: <ce9dc15c-593b-7b77-59ec-2413ed6e62d6@linaro.org>
Date:   Tue, 8 Jun 2021 15:22:48 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <878s3k9q3a.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 08/06/2021 15:19, Florian Weimer wrote:
> * Adhemerval Zanella:
> 
>> Also currently we don't have a specific usage.  The proposed patch to
>> add the 'pthread_mutex_lock_any' and 'pthreada_timedlock_any' [3] 
>> also did not gave much detail in realword usages or how it can be
>> leveraged.
> 
> The current rwlock implementation in glibc uses a torn 32-bit futex read
> which is part of an atomically updated 64-bit word.  That's just really,
> really ugly, and I suspect we could make that go away with futex2.

You are right, I had in the mind the multiple wait proposed by this
patch and by the glib RFC one.  Not only rwlock, but the posix
semaphore might also be simplified on 32 bits I think.
