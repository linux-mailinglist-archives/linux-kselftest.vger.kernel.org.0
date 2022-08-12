Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172045912E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiHLPaE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Aug 2022 11:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbiHLPaD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Aug 2022 11:30:03 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB3D7C77E
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Aug 2022 08:29:59 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M47045hnZzMqDVK;
        Fri, 12 Aug 2022 17:29:56 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4M47041ZGnzlrKd0;
        Fri, 12 Aug 2022 17:29:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660318196;
        bh=os1y2RaZXpvAPI4x/Kt6ufZlR7Y3TXa/5EBs1HgStPQ=;
        h=Date:From:To:Cc:References:Subject:In-Reply-To:From;
        b=NjjQHOj4WEACVa+xDGjILXnFy5XnjPmlCEtyh2SaOS2Lled9uOoY+Cgv2IWI6Kv2G
         eQEgBhSQe7WKHruYwnS/X77IzbcZYHD8tmLasVjBJtE7KLZGUP4srfc+zLJ6gGCdA7
         BKQ3nDXlPorpPTJHUivrmF8vV8ovr241v/5Y/5CU=
Message-ID: <c0c65ade-1d2a-5466-2c12-8e016904817f@digikod.net>
Date:   Fri, 12 Aug 2022 17:29:55 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
 <f1fc4e6e-e2a6-3ec7-2d3b-215111a4b9ae@digikod.net>
 <76a2ac43-6e3d-0b62-7c8c-eec5f247f8f8@collabora.com>
 <3de9a64e-6f27-8f76-9626-6ee082d382ea@digikod.net>
Subject: Re: [PATCH] selftests/landlock: fix broken include of
 linux/landlock.h
In-Reply-To: <3de9a64e-6f27-8f76-9626-6ee082d382ea@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah, do you plan to send a pull request before merge window closes?

On 05/08/2022 19:16, Mickaël Salaün wrote:
> 
> On 04/08/2022 21:38, Guillaume Tucker wrote:
>> On 04/08/2022 12:36, Mickaël Salaün wrote:
>>>
>>> On 03/08/2022 22:13, Guillaume Tucker wrote:
>>>> Revert part of the earlier changes to fix the kselftest build when
>>>> using a sub-directory from the top of the tree as this broke the
>>>> landlock test build as a side-effect when building with "make -C
>>>> tools/testing/selftests/landlock".
>>>>
>>>> Reported-by: Mickaël Salaün <mic@digikod.net>
>>>> Fixes: a917dd94b832 ("selftests/landlock: drop deprecated headers dependency")
>>>> Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
>>>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>>>> ---
>>>>     tools/testing/selftests/landlock/Makefile | 7 +++++--
>>>>     1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
>>>> index a6959df28eb0..02868ac3bc71 100644
>>>> --- a/tools/testing/selftests/landlock/Makefile
>>>> +++ b/tools/testing/selftests/landlock/Makefile
>>>> @@ -9,10 +9,13 @@ TEST_GEN_PROGS := $(src_test:.c=)
>>>>     TEST_GEN_PROGS_EXTENDED := true
>>>>       OVERRIDE_TARGETS := 1
>>>> +top_srcdir := ../../../..
>>>
>>> Not sure it changes much, but most other selftests Makefiles use "top_srcdir = ../../../.." (without ":="). Why this change?
>>
>> I didn't simply apply your diff but edited the file by hand to
>> test various combinations and see what side effects it might
>> have.  So when I added top_srcdir I typed it by hand and used :=
>> as a reflex since it's the standard way of assigning variables.
>> Using = instead only makes a difference when the r-value has
>> something dynamic as it will be re-evaluated every time it's
>> used.  So for constant values, I guess it's more of a question of
>> coding style and conventions.  Maybe all the top_srcdir variables
>> should be changed to := but that's unnecessary churn...  Either
>> way, it's benign.
>>
>> Shuah, feel free to change this back to = in this particular case
>> if it's more consistent with other Makefiles.  Consistency is
>> often better than arbitrary rules.  Or conversely, change to :=
>> for the khdr_dir definition...  Entirely up to you I think.
> 
> Looks good to me, thanks! Shuah, feel free to add
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> 
>>
>> Thanks,
>> Guillaume
>>
>>>>     include ../lib.mk
>>>>     +khdr_dir = $(top_srcdir)/usr/include
>>>> +
>>>>     $(OUTPUT)/true: true.c
>>>>         $(LINK.c) $< $(LDLIBS) -o $@ -static
>>>>     -$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
>>>> -    $(LINK.c) $< $(LDLIBS) -o $@ -lcap
>>>> +$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
>>>> +    $(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
>>
