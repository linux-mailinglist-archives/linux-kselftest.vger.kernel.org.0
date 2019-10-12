Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7AD4F68
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2019 13:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfJLLtA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Oct 2019 07:49:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33552 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfJLLrA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Oct 2019 07:47:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so14593413wrs.0;
        Sat, 12 Oct 2019 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A/YnKXpYyhVf2YL33PpcSTPezIXHMHn0TBKKKjDVPF8=;
        b=d2m3mIyCVTLTM58mhxK3dg0SJXvqHkVwJvmtRfH0GERKL3yADP5Lq/agDo8gHwW4DN
         gLPJo8mOkNB3ZQUiojx1GFw2DBQekFDOznABzlvCos8eLlcTaqch7dP9e+mqZkx+ppaX
         IWvpFMU1NghVgPfZAPJMPjoTv/Lmf39Zn1sBBBCkY2wuy+jeYUVArucc5Y5zcdYlKHM8
         dGT1xQDHODo4ifW3XXAl/rgAIEIv6hUR6gDZfg/hMiOpkiYbGL65D9XdvGOeUIctBcje
         Zo11hEbiKsuAHRd0DrdT4AF5j9aqu635OC65QVGMQ+InIxvBaQNvw7VVFPZAeFsc+0Zv
         j2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A/YnKXpYyhVf2YL33PpcSTPezIXHMHn0TBKKKjDVPF8=;
        b=fLIHUoc2HiYOWY7rs/nKr8sIrLYeLRIuhJidKrLiutKV+ZLxdTgbE0uRxNwQYfLydY
         IuJaH+tjAI3ijJfAudu18g2Eiv8QxRkWVXaUTZNKqzZRbZTM4KPhzx1ndRswOtfIUT0U
         K15JXcT/jkoNGeL+u/AwfhpNvncjHzoq3rb8irOgC/Vk/hEqGe6WPKHjlCeRsbz+mA49
         LXXou0nRUOif1n6dqcKQS89hqwZhrlHlZk4RtckBOrDpwa0z0pG1A0K5Vjck8emsJt5o
         T+q3j9Ph5IXdr3GdNmHe7qAbHC+xVpArS46P8rkCVoZbb81hGcNGNw/J4gMLRSyZEvTr
         mnWQ==
X-Gm-Message-State: APjAAAVUaAcNgBKLLbAqtkj6llTV96z+EQV6u7GDIPvUcbcn5K07T4jf
        uKRKQigPXOeJj4gm/A60b8UMTrBiSlU=
X-Google-Smtp-Source: APXvYqwJ/ZAgFehC5H5Wa0NK2NgsCKoOYOgV/uwldX3PLUAZ05PzvgIxfR8lzjOs20x6RcHfHSr5Pw==
X-Received: by 2002:adf:9b89:: with SMTP id d9mr16784734wrc.275.1570880816692;
        Sat, 12 Oct 2019 04:46:56 -0700 (PDT)
Received: from ?IPv6:2001:a61:3a5c:9a01:fb47:94a9:abbd:4835? ([2001:a61:3a5c:9a01:fb47:94a9:abbd:4835])
        by smtp.gmail.com with ESMTPSA id r10sm14318505wml.46.2019.10.12.04.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2019 04:46:55 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Aleksa Sarai <cyphar@cyphar.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] clone3: add CLONE3_CLEAR_SIGHAND
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <20191010133518.5420-1-christian.brauner@ubuntu.com>
 <CAHO5Pa3V7fDb_+U-v+LB+TeAU0vfJyUMs9mD4ZqUtbLpZcD4nA@mail.gmail.com>
 <20191011221208.5eglbazksfigliob@yavin.dot.cyphar.com>
 <CAKgNAkhgGhGi-hMJt3UxYYDuyOZLx7c-eucpD5V7js+hsyv2CQ@mail.gmail.com>
 <20191012074840.4to7lh4zbt4wup74@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <b3fce4a4-10a8-befe-a438-f16dfa0cdb6b@gmail.com>
Date:   Sat, 12 Oct 2019 13:46:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191012074840.4to7lh4zbt4wup74@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/12/19 9:48 AM, Christian Brauner wrote:
> On Sat, Oct 12, 2019 at 08:53:34AM +0200, Michael Kerrisk (man-pages) wrote:
>> Hello Aleksa,
>>
>> On Sat, 12 Oct 2019 at 00:12, Aleksa Sarai <cyphar@cyphar.com> wrote:
>>>
>>> On 2019-10-11, Michael Kerrisk <mtk.manpages@gmail.com> wrote:
>>>> Why CLONE3_CLEAR_SIGHAND rather than just CLONE_CLEAR_SIGHAND?
> 
> I don't care much how we name this apart from the "_CLEAR_SIGHAND"
> suffix. But see for a little rationale below.
> 
>>>
>>> There are no more flag bits left for the classic clone()/clone2() (the
>>> last one was used up by CLONE_PIDFD) -- thus this flag is clone3()-only.
>>
>> Yes, I understand that. But, I'm not sure that the "3" in the prefix
>> is necessary. "CLONE_" still seems better to me.
>>
>> Consider this: sometime in the near future we will probably have time
>> namespaces. The new flag for those namespaces will only be usable with
>> clone3(). It should NOT be called CLONE3_NEWTIME, but rather
>> CLONE_NEWTIME (or similar), because that same flag will presumably
>> also be used in other APIs such as unshare() and setns(). (Hmm -- I
> 
> There are some noteable differences though. CLONE_NEWTIME takes the
> CSIGNAL bit which is in the range of a 32bit integer and thus useable by
> unshare() too. The same does not hold for CLONE{3}_CLEAR_SIGHAND. You
> can't pass it to unshare(). unshare() also just deals with
> namespace-relevant stuff so CLONE{3}_CLEAR_SIGHAND doesn't make much
> sense there.

Sure, but going forward there's very likely to be more CLONE flags
for whatever reason, and some will be usable just in clone3()
while others will be more widely used (in other APIs such as
unshare() and setns()). Using two different prefixes for these
flags (CLONE_/CLONE3_) would be just confusing. AFAICS, the CLONE3_
prefix really provides no advantage, but does have the potential to
cause confusion down the track for the aforementioned reasons.
(Furthermore... Shudder! What if there's a clone4() one day. I
know you might say: "won't happen, we got things right this time",
but API history suggests that "right" now not infrequently becomes
"oops" later.) I do recommend CLONE_ for all the flags...

>> wonder if we are going to need a new unshare2() or some such...)
> 
> We still have one 32bit bit left (CLONE_DETACHED) which we can't reuse
> with clone()/clone2() but we can reuse with clone3(). We can simply
> earmark it for namespace-related stuff and thus still have one bit left
> for unshare() before we have to go for unshare2() (If we have to go
> there at all since I'm not sure how much more namespaces we can come up
> with.).

I'm sure there'll be more namespaces...

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
