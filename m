Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908E228CB3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 11:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgJMJzI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Oct 2020 05:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbgJMJzI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Oct 2020 05:55:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF1C0613D0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 02:55:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e23so13302400wme.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YKvSNZR9ptBFcO/UUrxR/7or/yI++iP0x0q1ZQ9abEs=;
        b=e67f5vWv4SyTTBTEAc0A4DjwfBj/qCC2NMYqNap0zrsSrh++RjL7CBlWcy79R6Dvx7
         oLkmyRmfA7dTIPOVyYizGts/ef0Q9mHcqm5TJiCzbyVTlnTpFTojo6gHmtYJtQ9TJ5C8
         KCQDUIw9lQTXo+i39SCWIoYhBI32fzZwGg3/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YKvSNZR9ptBFcO/UUrxR/7or/yI++iP0x0q1ZQ9abEs=;
        b=OkP+A8ZEQeQeObeUlIgH7KEQ8xOGXphwC3ebBi7OPUQWcTBkRCBeLnJan75/sb8llY
         g3VlbrAxx9/5VRrqZ8oGSitWDb5tEvARHUpYJoom8caRPlL6IVR6FUwpJEX14xC5mCly
         /bUxjVgy1a2WDvdoU3cqjyxA31zyav/9rbWwo/9Q9hdNprrUILJwltUIIYchsurdCrFu
         XbHrr1a4wIUxnG1zDO27zgHp/fcPHz4CIbGYkLORngmxEoGDAwLJavXXf1HMPTjs1LNc
         xBCHoYpMobGDda4ulvLcqev5U/7cZuOGCZ+jfIjlwZ6kgXRKVu3rFPYIquyRnBsUJ4j6
         3zzA==
X-Gm-Message-State: AOAM530QV4e3NGV/Z3DZMAUjsQ0NKAVVYlQleOMgQC2IMiErnF9p95hV
        3aNeatAm3OtCkSh3dTG54KF36ZeOw8bX6fchjS8=
X-Google-Smtp-Source: ABdhPJwNzHOzFBFSlEaLslgNSlVhrb2Hfm4ARc29+Fg45XaZhkHoBe0aLO3suD+2MxFxFgKOty4nLQ==
X-Received: by 2002:a1c:6643:: with SMTP id a64mr15174306wmc.142.1602582906104;
        Tue, 13 Oct 2020 02:55:06 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o194sm25490462wme.24.2020.10.13.02.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 02:55:05 -0700 (PDT)
Subject: Re: [PATCH] lib: Convert test_printf.c to KUnit
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        skhan@linuxfoundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200817043028.76502-1-98.arpi@gmail.com>
 <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
 <20200821113710.GA26290@alley> <20200821122849.GS1891694@smile.fi.intel.com>
 <20201012204625.GA56597@google.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <876cc862-56f1-7330-f988-0248bec2fbad@rasmusvillemoes.dk>
Date:   Tue, 13 Oct 2020 11:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012204625.GA56597@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/10/2020 22.46, Brendan Higgins wrote:
> On Fri, Aug 21, 2020 at 03:28:49PM +0300, Andy Shevchenko wrote:
>> On Fri, Aug 21, 2020 at 01:37:10PM +0200, Petr Mladek wrote:
>>> On Mon 2020-08-17 09:06:32, Rasmus Villemoes wrote:
>>>> On 17/08/2020 06.30, Arpitha Raghunandan wrote:
>>>>> Converts test lib/test_printf.c to KUnit.
>>>>> More information about KUnit can be found at
>>>>> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
>>>>> KUnit provides a common framework for unit tests in the kernel.
>>>>
>>>> So I can continue to build a kernel with some appropriate CONFIG set to
>>>> y, boot it under virt-me, run dmesg and see if I broke printf? That's
>>>> what I do now, and I don't want to have to start using some enterprisy
>>>> framework.
>>>
>>> I had the same concern. I have tried it.
> 
> Sorry you feel that way. Do you have any suggestions on how we can make
> it seem less enterprisy? Seems like there are people here who are not a
> fan of the output format, so of which we can fix here, some of which is
> part of KTAP[1].

I'm fine with machine-readable TAP, but I most defintely also want
human-readable, which means all the excessive and pointless lines need
to go away.

>> Which raises an obvious question: did the people who convert this test this
>> themselves? Looks like a janitor work in the area without understanding the
>> area good enough.
> 
> Looks to me like Arpitha ran it, but you are right, we don't have a lot
> of familiarity with this area; we were treating it as "janitor work" as
> you say.
> 
> Our intention was just to take some existing tests and as non-invasively
> as possible, get them to report using a common format, and maybe even
> get some of the tests to follow a common pattern.
> 
>> Probably I will NAK all those patches from now on, until it will be good commit
>> messages and cover of risen aspects, including reference to before and after
>> outcome for passed and failed test cases.
> 
> Fair enough, hopefully we can address these issues in the next revision.
> 
> One issue though, with the "before and after outcome" you are
> referencing; are you referring to the issue that Petr pointed out in how
> they are inconsistent:
> 
>    + original code: vsnprintf(buf, 6, "%pi4|%pI4", ...) wrote '127.0', expected '127-0'
>    + kunit code: vsnprintf(buf, 20, "%pi4|%pI4", ...) wrote '127.000.000.001|127', expected '127-000.000.001|127'  
> 
> (I think Rasmus addressed this.) Or are your referring to something
> else?

Yeah, that change is fine and expected, can we stop bringing that up.

It's all the explicit "memcmp() == 0 failed" gunk at least I am
concerned with. If you can get rid of that (basically, stop stringifying
the code, that's completely irrelevant) and just get the messages from
the test itself that explains what went wrong. I'm fine with
interspersing that with a few TAP-readable lines. But things like

 Expected memcmp(test_buffer, expect, written) == 0, but
                       memcmp(test_buffer, expect, written) == 1
                       0 == 0

are utterly useless. We're not _testing_ memcmp, we're _using_ it to
know if vsprintf() did as we expected. So just mechanically changing
"memcmp() == 0" into "SOME_MACRO(memcmp(), 0)" is never going to work,
at least when SOME_MACRO does the stringify and ends up producing the
above. But if you can end up producing

[   56.795433]     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:76
               vsnprintf(buf, 20, "%pi4|%pI4", ...) wrote
'127.000.000.001|127', expected '127-000.000.001|127'

that's fine; that's basically just prepending an EXPECTATION FAILED line
to the existing output.

So doing it properly would probably be either

- change the existing pr_warn()s to use some KUNIT macro that generates
whatever extra info is needed by TAP, in addition to the current
human-readable message, and/or
- just add a few lines of TAP-suitable FAIL/PASS lines here and there

but let me repeat that the control flow (early returns) in do_test()
cannot be modified.

Rasmus
