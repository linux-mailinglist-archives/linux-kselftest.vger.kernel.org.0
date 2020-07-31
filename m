Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE86D2349DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jul 2020 19:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbgGaRGA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jul 2020 13:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbgGaRF7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jul 2020 13:05:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27E3C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jul 2020 10:05:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j19so16341850pgm.11
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jul 2020 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=kO7tSmtMGzFWvAuVfMIeLezphj2gPAq2RvK7z1I/VfA=;
        b=ibiqzg2ZwZTyZLqAQ8FffJTr1JkjcIyb3SPv+w+O64xTjp3WuD524BKAzNBdD/tHv5
         U9jfVKIUL7YHeMAEmQucJ/PQJw9Xx54IpkzhuRsZOMLyqppunGjdQWPk3NcDB9km8Asa
         0CSEyzBTLtEVZWKuSoxdVrDBn4ZbtwvvCarvFfSxLtJeRrmwf0dzeE3SlQGpkwd3iHGm
         cvEnq/bEbDfgUA1giAwMzLtvdU+DWZW9RsoBqx5J49edJQWb7jpEQCg3WkW2Z02EJtoR
         tNO4fZ2wr/FaX1TmqcXWsuAsiCvlz1mP3t/UomVoq5eLIKnAueu2BXNOpHiXeY+xVCYP
         lzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kO7tSmtMGzFWvAuVfMIeLezphj2gPAq2RvK7z1I/VfA=;
        b=JGLS328kUp3eqGv8cXFqlby3jMXHMyr6EyOVnfvZACg9db+NsAfY+B2DingoZWgr+R
         z3NxuhnCfCgiUSkbTjloCieINFV7/+RbBpiBFTTdoqdo5WgvyNw1WQa1DdSHSbj+fCt+
         u2618MAafcifsTc3DNkxj16CXuZXNGUOITK83NBOaFwqwP+OkUgftzuG48+2savDXkaJ
         wlfp8+ypeapBJ3r5/L5mKnP8jy7GCRXu6JK2mow9RT1RylnwjL9fqIceTvrYaT1SukHo
         pmen8KJXnVXbwgnGdvv0OSiy5EvX/rZATCoFPzRTGp11DsSpdF4ibqaZ8MVlue3/Cldn
         9y0g==
X-Gm-Message-State: AOAM532KU+PtD3s8ykfu2gIebRde94C8VcDtn8UelONShP25Zqq6VhGs
        4Uud7u3mMCSsYVK7kxAf3s/5Qw==
X-Google-Smtp-Source: ABdhPJw+SlAdNRgxZUlASP8WDeEbVi66Ms8SKMgQwqsCPN2Y9NOLpy2nNiHSHNbp8rl7Vkvc+pEG7g==
X-Received: by 2002:a63:720b:: with SMTP id n11mr4487103pgc.137.1596215159205;
        Fri, 31 Jul 2020 10:05:59 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id lk16sm9028739pjb.13.2020.07.31.10.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 10:05:58 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     automated-testing@yoctoproject.org,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: CFP open for testing/fuzzing microconference at LPC
In-Reply-To: <CACT4Y+Z9wsS_m4humVcx-4CAbD2rvUxRHCVfgUYTWXVVzreXOA@mail.gmail.com>
References: <7heep067yt.fsf@baylibre.com> <CACT4Y+Z9wsS_m4humVcx-4CAbD2rvUxRHCVfgUYTWXVVzreXOA@mail.gmail.com>
Date:   Fri, 31 Jul 2020 10:05:57 -0700
Message-ID: <7h7duj398q.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"'Dmitry Vyukov' via syzkaller" <syzkaller@googlegroups.com> writes:

> On Fri, Jul 24, 2020 at 9:14 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Hello Linux testing enthusiasts,
>>
>> The CFP is open for the testing/fuzzing microconference[1] at Linux
>> plumbers conference.
>>
>> Please submit your ideas for discussion topics usin the LPC CFP tool:
>>
>>    https://www.linuxplumbersconf.org/event/7/abstracts/
>>
>> Click "Submit new Proposal" at the bottom of the page.
>>
>> There are some suggested topics in the MC announcement[1], but feel
>> free to submit ideas that are not on that list.
>>
>> And yes, LPC will be virtual this year as announced on the LPC blog:
>> https://www.linuxplumbersconf.org/blog/2020/linux-plumbers-conference-2020-goes-virtual/
>>
>> The tools and logistics are being actively worked on, so stay tuned to
>> the LPC blog for all the details.
>>
>> Thanks,
>>
>> Kevin
>>
>> [1] From: https://www.linuxplumbersconf.org/event/7/page/80-accepted-microconferences#tf-cr
>>
>> The Testing and Fuzzing microconference focuses on advancing the current
>> state of testing and validation of the Linux Kernel, with a focus on
>> encouraging and facilitating collaboration between testing projects.
>>
>> Suggested Topics:
>>
>>     Next steps for KernelCI (data formats, dashboards, etc)
>>     Structured data feeds for cross-project collaboration
>>     Integration with kernel.org tools (e.g. b4)
>>     Continued defragmentation of testing infrastructure
>>     Better sanitizers: KASAN improvements, KCSAN fallout, future plans.
>>     Better hardware testing, hardware sanitizers: how the USB fallout was handled, are there efforts to poke at something besides USB?
>>     Improving real-time testing: is there any testing for real time at all?
>>
>> MC leads
>>
>>     Sasha Levin <sashal@kernel.org>
>>     Kevin Hilman <khilman@kernel.org>
>
> Hi Kevin,
>
> What is the deadline? I almost prepared a proposal, just want to make
> sure I won't miss the deadline by a day :)

Aug 17th.

> I see some other MCs have "CFP Ends:", but not Testing MC:
> https://www.linuxplumbersconf.org/event/7/page/80-accepted-microconferences#tf-cr

Oops, I'll get that added to our entry.

> Also what are the options for duration? Can I ask for a particular
> duration in the proposal comments?

Yes, you can request a duration, but keep in mind the virtual nature of
the event.  

If you think it's useful, you can also propose follow-up/breakout with a
smaller group of interested parties for more detailed technical
discussion.  It's still a bit unclear how this is all going to work out
with it being virtual, but we'll be able to do smaller, targetted
sessions if needed as well.

Kevin

