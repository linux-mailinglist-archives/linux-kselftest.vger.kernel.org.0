Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E51628CAA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgJMIxf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Oct 2020 04:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgJMIxe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Oct 2020 04:53:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EA2C0613D0;
        Tue, 13 Oct 2020 01:53:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c6so10312712plr.9;
        Tue, 13 Oct 2020 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LTR2IgYIK7xAE4oUdad2TPARaho3YwkIIRd1YoCTDVM=;
        b=M3Q3PwnXWnIwDY2TCh2iHM0A7Z2qWtd6gCLk9NA/7EpCajIEyAa1GGhCoxnVgEqjUq
         kNt69WifcadORjeHHrH4NiVFKK83XrW9w4uSnCT3AwoFEYQNJLKQ0Ug9BZbjW5rDrckb
         Lp9NC+XvqYlyRYEDQQ18i4yJCkS9ufgUugBF5ucz3Glr32wy4yQki7X4VYzqtNIHlzG8
         36HgX1HnEo+7tmZ9AyCKI3U/nv7aTa7jezeWzJShZeoz/nXxfjud/1gTuRqDOaTzXNU9
         rXSDvuSv2f0BulH+josCwUUyFpj58IW/KgBOvbxOQnlQNGpykrWnYU9mnKZ2h4xJUxN1
         XvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LTR2IgYIK7xAE4oUdad2TPARaho3YwkIIRd1YoCTDVM=;
        b=ZPLlX774egU4onQrT/TJkLvyP0W4OTNU9nBqSakpPz0NVHrBwf8c5mBKjIBTisdPhT
         4j50xP8It9a+/l3CLsu6cqVt7i0H7kD7QwUWJxPt+7vNHE0Hnbd2NR+5ZObPDrz0xjYX
         5DgKobzz/Vj8xQ8dOfgcYWgxHaffX/fz7bZzrsTtZguVCI1bRV8waGDy7/U2xVEnYLPl
         Uvc94fLbTjs4EZLFSMvQPbq5txcpMrOGkrD7GLmTigUnNEfxikRN+OzztD14wDCwig3b
         rZ4u+EpOuytjPnIEnZtDSSXqZxgJwhogXAvwcI62IuepsXRcsrHLbOK3NfFgpkEt8KwM
         v03w==
X-Gm-Message-State: AOAM531yPf+yfKiKKc7vsiECq49mjUm1HV9GmoYHa5hNG6uGgSQa5vVn
        qygM3oQh8yuKWI3T7Tk0wesa1GQveicB8mpFRRY=
X-Google-Smtp-Source: ABdhPJwfveAnvFxUuaP0Hm+IJS4rem56R3OLYskHyZskJpRTolMNEa7Xa7wqY/DEeNAriP4rdx4PTQ==
X-Received: by 2002:a17:902:9a87:b029:d2:1ec0:4373 with SMTP id w7-20020a1709029a87b02900d21ec04373mr26893765plp.40.1602579214036;
        Tue, 13 Oct 2020 01:53:34 -0700 (PDT)
Received: from [192.168.86.81] ([106.51.240.187])
        by smtp.gmail.com with ESMTPSA id u18sm22943727pgk.18.2020.10.13.01.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 01:53:33 -0700 (PDT)
Subject: Re: [PATCH] lib: Convert test_printf.c to KUnit
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        skhan@linuxfoundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200817043028.76502-1-98.arpi@gmail.com>
 <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
 <20200821113710.GA26290@alley> <20200821122849.GS1891694@smile.fi.intel.com>
 <20201012204625.GA56597@google.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <41038b5a-5821-a27b-ff6e-fb9f0054940b@gmail.com>
Date:   Tue, 13 Oct 2020 14:23:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012204625.GA56597@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/10/20 2:16 am, Brendan Higgins wrote:
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
> 
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
> 
>> Brendan, I guess the ball now on your side to prove this is good activity.
> 
> And I see that we are off to a great start! :-)
> 
> In all seriousness, I am really sorry about this. I kind of bungled this
> up trying to go after too many of these conversions at once.
> 
> Arpitha, can you get this follow up patch out?
> 

Yes, I will work on this.

> [1] https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/
> 

