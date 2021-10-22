Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CC443707E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Oct 2021 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhJVDh2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 23:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbhJVDh0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 23:37:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92916C061243
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 20:35:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f11so2412307pfc.12
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tq9TCe4y+2LqaSR/LbffoUfOqYJ6qwVCCAjmIO9uNDk=;
        b=itmmIgzvxM8wXh+qClv/FuIhUtp1Nm1143qNgs888P9h+1O1yy/7m6jy7pS2ZdYm7E
         RXz0Gt2o+piigjSht0ERLCqpV9wq4YY0eMFNgb4xVtenegaLjeipk6T+G4EsH1e2qD1x
         EYQwlw9vrtWJ/doggqlzwhSU0agNIWQCOM9B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tq9TCe4y+2LqaSR/LbffoUfOqYJ6qwVCCAjmIO9uNDk=;
        b=aEm1dG40ChdJTqmwLHesTTScZpCc1sbEWNk2WtsV02QTmRxVWaFbT8u56JqTDboSIX
         DmKWQGqRix7SNyHGjpn5c8UK7AN375m7/M0nmdJi2grKpkv/TyF0ErDK5uhMly/511Nb
         F4jyyiMdvXCzA7JNJTenDa0l/14tegDDM2IJXJV9RQXH1HB8uaH6uvZcbSMZiXROWnEm
         wNcsPmIbUz9r4Fhvh5d/IDK15/GCWRAvHRXB8tAkfmlYcEmzPk1Iui+bFk+BbWNAZ+HA
         KEmcbaPlRu/M1ZwqzAb0T2ljyawQZXNmrEQYcXLiqfes4ys0pNFq+QoANDWXe1BLUbdf
         dOzA==
X-Gm-Message-State: AOAM530q9elRH5mIbI3rvKi/hofBC6ReT9TDbScdHbE/sgRf+Y2q5L/b
        /GOhit8w0Hbd79SrxVRZjcbDSw==
X-Google-Smtp-Source: ABdhPJyxeuRxg63B7FyG23NoOKG14eUyr0a2vpGwzlC5uabse4lMnbVid3Jwws+S/HwS9oP844u1HA==
X-Received: by 2002:a62:7850:0:b0:44c:5b71:2506 with SMTP id t77-20020a627850000000b0044c5b712506mr9697381pfc.37.1634873709085;
        Thu, 21 Oct 2021 20:35:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4sm26011pjl.11.2021.10.21.20.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:35:08 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:35:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Jann Horn <jannh@google.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        amistry@google.com, Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, Michal Hocko <mhocko@suse.com>,
        deller@gmx.de, Qi Zheng <zhengqi.arch@bytedance.com>, me@tobin.cc,
        tycho@tycho.pizza, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        metze@samba.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-arch@vger.kernel.org,
        vgupta@kernel.org, "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, guoren@kernel.org,
        bcain@codeaurora.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, jonas@southpole.se,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>, hca@linux.ibm.com,
        ysato@users.sourceforge.jp, davem@davemloft.net, chris@zankel.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Make sure wchan works when it exists
Message-ID: <202110212033.D533BAF@keescook>
References: <20211008235504.2957528-1-keescook@chromium.org>
 <f4b83c21-4e73-45b6-ae3a-17659be512c0@www.fastmail.com>
 <202110211310.634B74A@keescook>
 <08669c29-a19e-44a8-a53e-acfa773d4680@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08669c29-a19e-44a8-a53e-acfa773d4680@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 21, 2021 at 05:39:38PM -0700, Andy Lutomirski wrote:
> 
> 
> On Thu, Oct 21, 2021, at 1:12 PM, Kees Cook wrote:
> > On Thu, Oct 21, 2021 at 01:03:33PM -0700, Andy Lutomirski wrote:
> >> 
> >> 
> >> On Fri, Oct 8, 2021, at 4:55 PM, Kees Cook wrote:
> >> > This makes sure that wchan contains a sensible symbol when a process is
> >> > blocked. Specifically this calls the sleep() syscall, and expects the
> >> > architecture to have called schedule() from a function that has "sleep"
> >> > somewhere in its name. For example, on the architectures I tested
> >> > (x86_64, arm64, arm, mips, and powerpc) this is "hrtimer_nanosleep":
> >> 
> >> Is this really better than admitting that the whole mechanism is nonsense and disabling it?
> >> 
> >> We could have a fixed string for each task state and call it a day.
> >
> > I consider this to be "future work". In earlier discussions it came up,
> > but there wasn't an obvious clean cost-free way to do this, so instead
> > we're just fixing the broken corner and keeping the mostly working rest
> > of it while cleaning up the weird edges. :)
> 
> True, but we have the caveat that wchan is currently broken, so in some sense we have an easier time killing it now as compared to later.  But if we don't have a fully-fleshed-out idea for how to kill it, then I'm fine with waiting.

It's not actually that broken. Only ORC was fully broken, so all the
other architectures (and non-ORC x86) have been fine. But given the
method of fixing ORC vs wchan, it turns out we could further clean up
the other architectures. But yes, no real plan to remove it, but the
current series fixes things pretty well. :)

-Kees

> 
> >
> > -- 
> > Kees Cook

-- 
Kees Cook
