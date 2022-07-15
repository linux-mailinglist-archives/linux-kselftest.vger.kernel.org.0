Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA925763AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jul 2022 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiGOOcr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Jul 2022 10:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGOOco (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Jul 2022 10:32:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DFF6D9D0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jul 2022 07:32:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso8189100pjb.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jul 2022 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KGDc8EbuqC0PvAxCnIwTKvxHYhgAZfQOE+/RAi143ug=;
        b=JCgSYiRX6HA4YO0cyySvx4Bzs0RhBJGyDuDQdzypDWRq6F+EUrMezPWwe6pBZ73dAd
         RIil1PTT1JVXwkO/GPq8J7pKkkIlUqXw66FyY+PFbO2HMF6uHZW1wMwMhjtAB6PhjkEv
         0qii89D5ckU+mD87QNqOlWnP6SLyUNb9gs8XVHiMXJpuul1mKMa/inhbicja9fNM8h6Q
         0oHBLCdQVMZrvJnVVDP9dE9xdiO6LgxvXAG67eued3ZtvkhbkAJyKCyXO7K2BPkIc6x3
         23HcMu1gMWtTgfRsduOFKcOmxZTgjRlkd9Qrid0PSb5xRXusMzxkNShxTgSyBr3vrndt
         wluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KGDc8EbuqC0PvAxCnIwTKvxHYhgAZfQOE+/RAi143ug=;
        b=QEdivA1sQx0Z9xRWsymFvzwHA3tnfnqN4ZCLKWQZTsuJ7VKLl4SwXvE0OTNwS6M8ii
         Wf4sWCpH4L+LIz6LZ/pEyVNB/WKMmn5oeZTItrXyuXbY8LJ6MEprm0t9j5H8ybvtzEqy
         f1cGhN6CLL6K5Ftf6yn1l48huTuasjIZmuGap46O/XUPRh9tdlxY+CnOV0v1F/uIq9Na
         ORaU2Cl4J2T/pMdKAk/8he7AYljFQ77Zeze8oQNICCj9K5YeDbFMXLrZZJLtyIdXJrei
         Ivk4jCY4nb9H3z7ifH86W36z8WV4QkA24V1VwFzc6/rNp7cxsEvT6l/xvgXWBwZxYOWE
         PPBg==
X-Gm-Message-State: AJIora919tg/8H8gp1nS4175qBipeI1RbNFV+lxlH5R3aqHRmBYg9mV1
        MbYospLV2Fk0Ruz/d9qy/Kzk2w==
X-Google-Smtp-Source: AGRyM1vrP4fMl5xqO1RnpN7iB0+xQmieg3i1s2EH5bpDyK5MEzUlgFWBRCAR7K8wHJxGL+selF7gqA==
X-Received: by 2002:a17:90b:2242:b0:1f0:6d85:e196 with SMTP id hk2-20020a17090b224200b001f06d85e196mr16405063pjb.3.1657895557596;
        Fri, 15 Jul 2022 07:32:37 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id x62-20020a628641000000b0052842527052sm3844497pfd.189.2022.07.15.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 07:32:37 -0700 (PDT)
Date:   Fri, 15 Jul 2022 14:32:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        shuah@kernel.org, maz@kernel.org, oliver.upton@linux.dev,
        shan.gavin@gmail.com
Subject: Re: [PATCH] KVM: selftests: Double check on the current CPU in
 rseq_test
Message-ID: <YtF6gVYgMhoiD0Pe@google.com>
References: <20220714080642.3376618-1-gshan@redhat.com>
 <cd5d029c-b396-45ef-917b-92e054659623@redhat.com>
 <YtA3s0VRj3x7vO7B@google.com>
 <be806f9c-861a-8da8-d42e-1d4271c3a326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be806f9c-861a-8da8-d42e-1d4271c3a326@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 15, 2022, Gavin Shan wrote:
> Hi Paolo and Sean,
> 
> On 7/15/22 1:35 AM, Sean Christopherson wrote:
> > On Thu, Jul 14, 2022, Paolo Bonzini wrote:
> Well, I don't think migration_worker() does correct thing, if I'm understanding
> correctly. The intention seems to force migration on 'main' thread by 'migration'
> thread?  If that is the case, I don't think the following function call has correct
> parameters.
> 
>     r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
> 
>     it should be something like:
> 
>     r = sched_setaffinity(getpid(), sizeof(allowed_mask), &allowed_mask);
> 
> If we're using sched_setaffinity(0, ...) in the 'migration' thread, the CPU
> affinity of 'main' thread won't be affected. It means 'main' thread can be
> migrated from one CPU to another at any time, even in the following point:
> 
>     int main(...)
>     {
>           :
>           /*
>            * migration can happen immediately after sched_getcpu(). If
>            * CPU affinity of 'main' thread is sticky to one particular
>            * CPU, which 'migration' thread supposes to do, then there
>            * should have no migration.
>            */
>           cpu = sched_getcpu();
>           rseq_cpu = READ_ONCE(__rseq.cpu_id);
>           :
>     }
> 
> So I think the correct fix is to have sched_setaffinity(getpid(), ...) ?
> Please refer to the manpage.
> 
>    https://man7.org/linux/man-pages/man2/sched_setaffinity.2.html
>    'If pid is zero, then the calling thread is used'

Oof, and more explicitly the rest of that sentence clarifies that the result of
getpid() will target the main thread (I assume "main" means thread group leader).

   Specifying pid as 0 will set the attribute for the calling thread, and passing
   the value returned from a call to getpid(2) will set the attribute for the main
   thread of the thread group.

I'm guessing my test worked (in that it reproduced the bug) by virtue of the
scheduler trying to colocate all threads in the process.

In my defense, the die.net copy of the manpages quite clearly uses "process"[1],
but that was fixed in the manpages in 2013[2]!?!!?  So I guess the takeaway is
to use only the official manpages.

Anyways, for the code, my preference would be to snapshot gettid() in main() before
spawning the migration worker.  Same result, but I would rather the test explicitly
target the thread doing rseq instead of relying on (a) getpid() targeting only the
main thread and (b) the main thread always being the rseq thread.  E.g. if for some
reason a future patch moves the rseq code to its own worker thread, then getpid()
would be incorrect.

Thanks for figuring this out!

[1] https://linux.die.net/man/2/sched_setaffinity
[2] 6a7fcf3cc ("sched_setaffinity.2: Clarify that these system calls affect a per-thread attribute")
