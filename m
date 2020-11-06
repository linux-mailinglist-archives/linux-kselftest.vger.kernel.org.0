Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805232A8E03
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 05:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgKFEFD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 23:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFEFD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 23:05:03 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B85C0613CF;
        Thu,  5 Nov 2020 20:05:01 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id e21so2923644pgr.11;
        Thu, 05 Nov 2020 20:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tSjZkeVvKfttIleOvmEj75W/c02ILM34aNIYLdMmR/Y=;
        b=HCZfpCIqxx6QwtvwBSQvKZH2eEdeYO+ZfoOE2qobk6TAOkK+3dk5g6BgT0XidAtzji
         R8nXQdl0cL1SbbVPfvTZ/JJXkXPGXDA++j7LMjb2PaFkaHL1WusV/oV+hXyzjGUutX7G
         Usx3CPQzQKnzATRrR++FQZEayvZEZDP0E0RnkSjCOEK4BnizkoQMGPNe1sx19zrAbTUJ
         YJySSbpDcRrUXS4hIYi126u4g8q+gh+jafAqZ1aSHbrSWWnopi4G62go6QbjL/LFhNro
         UFiYjPYQh1oHegvYJxMJ0myJ4Uq7Tw+MPtncsaC4ZZloJvTuI31XGinUPt1wFtAt+Z4c
         l5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tSjZkeVvKfttIleOvmEj75W/c02ILM34aNIYLdMmR/Y=;
        b=t8V41YowS4AfwdhxHHjOqG2QUfbZpl0ddguxNzAau0Zuauys8xxsIVvDYaj6GP0jSg
         kGWeN8O0abtHAgtzsfR9+aHAkF8T994iO3CJM2k+t6QHCLFa0nrpLhWa8ZF5BSkoy1aY
         v8bSmq/w4EYbxtAvty/3uSpZyXEKbFKjYaW7RUQ1c3G0GA4eS+KbKOOriSZ2MJgIeTSw
         9B7fk7CAiQJMenXfmRuDiXX0SuUsbIp4EtIBCtdzzQQ8SvkiHt5/KBvaI8LB2wQAlQB8
         X8Mwtla0jpqXsceUkSdPMmRD/Gd54dzzrTtQT32YlG+16W38b/h5ZeIFespWeV1jHpRA
         iZ9w==
X-Gm-Message-State: AOAM533r12cocZWtr6daR1gNt+y3ehVD7vacynCwawMFdO3+NSPFmokz
        Pt2yNUw8ucn8E4p6K8eFWyM/55ZYu+qc14TY
X-Google-Smtp-Source: ABdhPJycakI4ERbODPpOJps13UtP6fCu+Eeq9f2IcF+3D5RRhtl2PDGal3+wuzCvW4YPvkPVjEcHzQ==
X-Received: by 2002:a17:90a:11:: with SMTP id 17mr320751pja.66.1604635501146;
        Thu, 05 Nov 2020 20:05:01 -0800 (PST)
Received: from [192.168.86.81] ([106.51.243.217])
        by smtp.gmail.com with ESMTPSA id 21sm117705pfw.105.2020.11.05.20.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 20:05:00 -0800 (PST)
Subject: Re: [PATCH v3] lib: Convert test_printf.c to KUnit
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        alexandre.belloni@bootlin.com, rdunlap@infradead.org,
        idryomov@gmail.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20201103111049.51916-1-98.arpi@gmail.com>
 <20201103113353.GC4077@smile.fi.intel.com>
 <20201103115223.GA268796@kroah.com> <20201103160728.GQ20201@alley>
 <57976ff4-7845-d721-ced1-1fe439000a9b@rasmusvillemoes.dk>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <b24a8200-b456-ecab-cc60-6f4ff10baa5d@gmail.com>
Date:   Fri, 6 Nov 2020 09:34:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <57976ff4-7845-d721-ced1-1fe439000a9b@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/11/20 1:48 pm, Rasmus Villemoes wrote:
> On 03/11/2020 17.11, Petr Mladek wrote:
>> On Tue 2020-11-03 12:52:23, Greg KH wrote:
>>> On Tue, Nov 03, 2020 at 01:33:53PM +0200, Andy Shevchenko wrote:
>>>> On Tue, Nov 03, 2020 at 04:40:49PM +0530, Arpitha Raghunandan wrote:
>>>>> Convert test lib/test_printf.c to KUnit. More information about
>>>>> KUnit can be found at:
>>>>> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
>>>>> KUnit provides a common framework for unit tests in the kernel.
>>>>> KUnit and kselftest are standardizing around KTAP, converting this
>>>>> test to KUnit makes this test output in KTAP which we are trying to
>>>>> make the standard test result format for the kernel. More about
>>>>> the KTAP format can be found at:
>>>>> https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/.
>>>>> I ran both the original and converted tests as is to produce the
>>>>> output for success of the test in the two cases. I also ran these
>>>>> tests with a small modification to show the difference in the output
>>>>> for failure of the test in both cases. The modification I made is:
>>>>> - test("127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
>>>>> + test("127-000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
>>>>>
>>>>> Original test success:
>>>>> [    0.540860] test_printf: loaded.
>>>>> [    0.540863] test_printf: random seed = 0x5c46c33837bc0619
>>>>> [    0.541022] test_printf: all 388 tests passed
>>>>>
>>>>> Original test failure:
>>>>> [    0.537980] test_printf: loaded.
>>>>> [    0.537983] test_printf: random seed = 0x1bc1efd881954afb
>>>>> [    0.538029] test_printf: vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>>>>> [    0.538030] test_printf: kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>>>>> [    0.538124] test_printf: failed 2 out of 388 tests
>>>>> [    0.538125] test_printf: random seed used was 0x1bc1efd881954afb
>>>>>
>>>>> Converted test success:
>>>>>     # Subtest: printf
>>>>>     1..25
>>>>>     ok 1 - test_basic
>>>>>     ok 2 - test_number
>>>>>     ok 3 - test_string
>>>>>     ok 4 - plain
>>>>>     ok 5 - null_pointer
>>>>>     ok 6 - error_pointer
>>>>>     ok 7 - invalid_pointer
>>>>>     ok 8 - symbol_ptr
>>>>>     ok 9 - kernel_ptr
>>>>>     ok 10 - struct_resource
>>>>>     ok 11 - addr
>>>>>     ok 12 - escaped_str
>>>>>     ok 13 - hex_string
>>>>>     ok 14 - mac
>>>>>     ok 15 - ip
>>>>>     ok 16 - uuid
>>>>>     ok 17 - dentry
>>>>>     ok 18 - struct_va_format
>>>>>     ok 19 - time_and_date
>>>>>     ok 20 - struct_clk
>>>>>     ok 21 - bitmap
>>>>>     ok 22 - netdev_features
>>>>>     ok 23 - flags
>>>>>     ok 24 - errptr
>>>>>     ok 25 - fwnode_pointer
>>>>> ok 1 - printf
>>>>>
>>>>> Converted test failure:
>>>>>     # Subtest: printf
>>>>>     1..25
>>>>>     ok 1 - test_basic
>>>>>     ok 2 - test_number
>>>>>     ok 3 - test_string
>>>>>     ok 4 - plain
>>>>>     ok 5 - null_pointer
>>>>>     ok 6 - error_pointer
>>>>>     ok 7 - invalid_pointer
>>>>>     ok 8 - symbol_ptr
>>>>>     ok 9 - kernel_ptr
>>>>>     ok 10 - struct_resource
>>>>>     ok 11 - addr
>>>>>     ok 12 - escaped_str
>>>>>     ok 13 - hex_string
>>>>>     ok 14 - mac
>>>>>     # ip: EXPECTATION FAILED at lib/printf_kunit.c:82
>>>>> vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>>>>>     # ip: EXPECTATION FAILED at lib/printf_kunit.c:124
>>>>> kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>>>>>     not ok 15 - ip
>>>>>     ok 16 - uuid
>>>>>     ok 17 - dentry
>>>>>     ok 18 - struct_va_format
>>>>>     ok 19 - time_and_date
>>>>>     ok 20 - struct_clk
>>>>>     ok 21 - bitmap
>>>>>     ok 22 - netdev_features
>>>>>     ok 23 - flags
>>>>>     ok 24 - errptr
>>>>>     ok 25 - fwnode_pointer
>>>>> not ok 1 - printf
>>>>
>>>> Better, indeed.
>>>>
>>>> But can be this improved to have a cumulative statistics, like showing only
>>>> number of total, succeeded, failed with details of the latter ones?
>>>
>>> Is that the proper test output format?  We have a standard...
> 
> Actually more like xkcd#927.
> 
>>
>> What is the standard, please?
>>
>> The original module produced:
>>
>> [   48.577739] test_printf: loaded.
>> [   48.578046] test_printf: all 388 tests passed
>>
>> It comes from KSTM_MODULE_LOADERS() macro that has been created
>> by the commit eebf4dd452377921e3a26 ("kselftest: Add test module
>> framework header"). 
> 
> That's a bit of a simplification. That code was clearly lifted directly
> from the original test_printf.c code
> (707cc7280f452a162c52bc240eae62568b9753c2). test_bitmap.c cloned
> test_printf.c (including a "Test cases for printf facility" comment...).
> Later both were converted to use the KSTM header.
> 
> As the one coming up with that originally, I certainly endorse its use
> as a standard way of producing a final, free-form, summary, and I prefer
> to keep that total tally (i.e. 388) being printed for the reasons I've
> previously stated. [*]
> 
> That said, I have absolutely nothing against _also_ producing
> machine-parsable TAP output. And the above looks to be a good compromise
> between spitting out one TAP line for each of the 388 test cases (or
> checks, or atoms, whatever the indiviual parts are to be called) and
> treating all of test_printf.c as one single PASS/FAIL test.
> 
> [*] If I add some test cases to the time_and_date and run the kernel
> under virtme, I want to see 388 becoming something else, so that I know
> that I actually ran the code I just added and not some stale vmlinux -
> maybe I only did "make lib/test_printf.o" and didn't recreate vmlinux,
> maybe I did "make vmlinux" but failed to notice the build was broken. BTDT.
> 
> And those summary lines are even more important to keep given my
> "deterministic random testing" series - the seed used _must_ be reported
> (preferably also in the "all good" case, but certainly in the "some
> failed" case).
> 
> Arpitha, thank you for taking that series into account. Is there some
> way to keep the print of the total number of "atoms" as well as the
> reporting of the random seed? Or should the "deterministic random
> testing" be done in the context of KUNIT rather than KSTM? I'm really
> not sure why we have both nor which one one is supposed to write
> against. But I would prefer that the framework, whichever one, provides
> a means to get a deterministic sequence of random numbers, so that I
> won't have to eventually copy-paste the boilerplate to test_sort.c and
> test_list_sort.c - it's also much nicer if all test modules have a
> somewhat consistent interface in terms of the module parameters they accept.
> 
> Rasmus
> 

The total number of "atoms" can be printed by maintaining a static variable
total_count that can be incremented as is in the original test_printf test.
But, the reporting of the random seed currently is done in kselftest and so
will not show up with KUnit. I am not really sure which is better in this case.

Thanks!
