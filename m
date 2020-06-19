Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97478201C44
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 22:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbgFSUTt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 16:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgFSUTt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 16:19:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D0C06174E;
        Fri, 19 Jun 2020 13:19:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j68so6839733qkb.10;
        Fri, 19 Jun 2020 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=en0bd9Z1UOgbNwil/O5E9MONyVUtQwSCd/V2jBgui+8=;
        b=f0p4HJd2r/N4xv4vE4skYM7sxiImjJrj0X+JzFnB7xYR8O56fjwU8+wWmpiZ5XUwn8
         tp3FRIW4rULkMVsECLzDSBZ2xlVfvhj4sYnjXkwUK7XXj1qKdC46/63riCHjM98GUE9t
         6Os1mRIeA2ZW8wEeZ7z7vaU90BY5gERuWllNyVR8jkSskyvg4McG001VCfdRTSIIgoHZ
         eL8BPcp4vTqmyZB30TrZcGBGYf6IyzKxiiL1COUOOtLX7bVluhGWEWoviXnhZW8PHEF4
         Mp+fNdyByS9CE8vGU/yQtc5hnTObyOuI73958nnv/lr+UmOEFtdF0yXzxzaqgwGaOMuq
         HZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=en0bd9Z1UOgbNwil/O5E9MONyVUtQwSCd/V2jBgui+8=;
        b=kgaxcCTee7MtzlsRtXQqyuW7TMiXqFMUuhpzL2sqXMoj7NRcBgdeVUk9rtcvpqCygO
         p6L8+l0rMbPdbxNGRYwxrFM1K+GX+zTEuRBpMf+QcV3JCDz+DfCQS0ax0/5/PTiz0xXR
         VZ1pqsK6hHF7b07wff2hHI2vkiFsiJUmU3Q7+00XBCp44YJrM826uWFsoIZDjyglFFEv
         EzkCA6UJWpUpvNjwwqpWHdfC+N0dhLpjRq8WtztxNDiY0sqwIoGo/VuCrFfuZxZafPFk
         lXtGNhZnVbwIbA6916+faOZ99JO7JGOOdT7RgZn5Seq1vX3dbRrFm1G9XYVxBtmhAl5a
         7zfA==
X-Gm-Message-State: AOAM531pTG9HRO6W979hBYpsw7jwoawtxyc8DvC7Xvp2tr6OKLvQjf3G
        xJuVURuPpZsKM6gwBT7S6F8=
X-Google-Smtp-Source: ABdhPJxuAUJkRoWiExKH7+YTulQfaa4Qn4Q+3e9EQwZC/3GG5D7JG1eAPc7JRaE/NVzyNGDKVa2Bow==
X-Received: by 2002:a37:a08:: with SMTP id 8mr5481210qkk.388.1592597988125;
        Fri, 19 Jun 2020 13:19:48 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id l2sm7265729qth.47.2020.06.19.13.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 13:19:47 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200616204817.GA212825@google.com>
 <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006161703.B2E51605@keescook>
 <CY4PR13MB1175DCC4066FC0839A6B2E84FD9A0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006162032.9BF6F8F4E@keescook>
 <CABVgOSn48gw3pMSCccmF8FK=3UPF+Spe47AiDQcMiXkk3k4yqQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <0408a492-7d95-d34c-443c-11a2d05abd37@gmail.com>
Date:   Fri, 19 Jun 2020 15:19:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CABVgOSn48gw3pMSCccmF8FK=3UPF+Spe47AiDQcMiXkk3k4yqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-06-16 23:05, David Gow wrote:
> On Wed, Jun 17, 2020 at 11:36 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Wed, Jun 17, 2020 at 02:30:45AM +0000, Bird, Tim wrote:
>>> Agreed.  You only need machine-parsable data if you expect the CI
>>> system to do something more with the data than just present it.
>>> What that would be, that would be common for all tests (or at least
>>> many test), is unclear.  Maybe there are patterns in the diagnostic
>>> data that could lead to higher-level analysis, or even automated
>>> fixes, that don't become apparent if the data is unstructured.  But
>>> it's hard to know until you have lots of data.  I think just getting
>>> the other things consistent is a good priority right now.
>>
>> Yeah. I think the main place for this is performance analysis, but I
>> think that's a separate system entirely. TAP is really strictly yes/no,
>> where as performance analysis a whole other thing. The only other thing
>> I can think of is some kind of feature analysis, but that would be built
>> out of the standard yes/no output. i.e. if I create a test that checks
>> for specific security mitigation features (*cough*LKDTM*cough*), having
>> a dashboard that shows features down one axis and architectures and/or
>> kernel versions on other axes, then I get a pretty picture. But it's
>> still being built out of the yes/no info.
>>
>> *shrug*
>>
>> I think diagnostic should be expressly non-machine-oriented.
> 
> So from the KUnit side, we sort-of have three kinds of diagnostic lines:
> - Lines printed directly from tests (typically using kunit_info() or
> similar functions): as I understand it, these are basically the
> equivalent of what kselftest typically uses diagnostics for --
> test-specific, human-readable messages. I don't think we need/want to
> parse these much.


> - Kernel messages during test execution. If we get the results from
> scraping the kernel log (which is still the default for KUnit, though
> there is also a debugfs info), other kernel logs can be interleaved
> with the results. Sometimes these are irrelevant things happening on
> another thread, sometimes they're something directly related to the
> test which we'd like to capture (KASAN errors, for instance). I don't
> think we want these to be machine oriented, but we may want to be able
> to filter them out.

This is an important conceptual difference between testing a user
space program (which is the environment that TAP initially was
created for) and testing kernel code.  This difference should be
addressed in the KTAP standard.  As noted above, a kernel test
case may call into other kernel code, where the other kernel code
generates messages that get into the test output.

One issue with the kernel issues is that they may be warnings or
errors, and to anyone other than the test creator it is probably
hard to determine whether the warnings and errors are reporting
bugs or whether they are expected results triggered by the test.

I created a solution to report what error(s) were expected for a
test, and a tool to validate whether the error(s) occurred or not.
This is currently in the devicetree unittests, but the exact
implementation should be discussed in the KUnit context, and it
should be included in the KTAP spec.

I can describe the current implementation and start a discussion
of any issues in this thread or I can start a new thread.  Whichever
seems appropriate to everyone.

-Frank


> - Expectation failures: as Brendan mentioned, KUnit will print some
> diagnostic messages for individual assertion/expectation failures,
> including the expected and actual values. We'd ideally like to be able
> to identify and parse these, but keeping them human-readable is
> definitely also a goal.
> 
> Now, to be honest, I doubt that the distinction here would be of much
> use to kselftest, but it could be nice to not go out of our way to
> make parsing some diagnostic lines possible. That being said,
> personally I'm all for avoiding the yaml for diagnostic messages stuff
> and sticking to something simple and line-based, possibly
> standardising a the format of a few common diagnostic measurements
> (e.g., assertions/expected values/etc) in a way that's both
> human-readable and parsable if possible.
> 
> I agree that there's a lot of analysis that is possible with just the
> yes/no data. There's probably some fancy correlation one could do even
> with unstructured diagnostic logs, so I don't think overstructuring
> things is a necessity by any means. Where we have different tests
> doing similar sorts of things, though, consistency in message
> formatting could help even if things are not explicitly parsed.
> Ensuring that helper functions that log and the like are spitting
> things out in the same format is probably a good starting step down
> that path.
> 
> Cheers,
> -- David
> 

