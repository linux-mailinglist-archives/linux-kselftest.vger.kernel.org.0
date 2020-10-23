Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4CE296D52
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462686AbgJWLGM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 07:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462680AbgJWLGM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 07:06:12 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E602FC0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 04:06:11 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so1814224eji.4
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sa/Nn3ofOc6VafcCvPSadCW8GlnmiSqdzkE6Af70Ogk=;
        b=YLru0Rw5qj+XYTVYL91y0RrrKzL0fGi2PV3nF3dBaQpU/q90mxcZBX2Kpt2aXElkW+
         +GJGhNJ7VoiAyEk0fVCrpJc8R0FGGQ5mMgYW+8NZZ2SzNJq0CYTMDHY/izVpTGHtqV1P
         DHsC2X5jlvWp4wsSA/i4okDx5R2MPsrfRHeR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sa/Nn3ofOc6VafcCvPSadCW8GlnmiSqdzkE6Af70Ogk=;
        b=BMLPbB+6XEG7x9xGn6nVivqD6yBD1sMfIsZw6cRj3rVG23Yh3amEyRVl1FAQTleox3
         oA7D1SADduMWnsZflvBkcX8mc/kGg7yNznF4CxjDH1u8J16bFZBTrzbwyKVKsIbDVi09
         s0GVT1jdJhmLGCN2Kt4YbYJ8i58LQghVhFQEHS23Dld02zD/aP8scACkkYde+1NSkdGK
         eLvwD4KMV209lAdOQFRkzYGpf9QI/4PaNgdsWDgoB+MXI7rs9dngDVolZft+wwUdft+p
         dPUzqlAOiqMjSNNufN8hPXMozc+Tp9why+QT/ZshoKnx7/Pq4tf2khp3LJIvLAIr7Upk
         vaxA==
X-Gm-Message-State: AOAM532DmxEnEQhEpXwziaFk2SpS/4a4zM97aqk9mnGnC1cG2Y1YFTqT
        SZoy1hxh+dH4vanEvRpGNvEXmw==
X-Google-Smtp-Source: ABdhPJw2fLLCK3gQbucoPr+cIfCcmX4tucFnbhPVvHDL5QD4i4LYyaC1LBo71kMyZyY1A8CSrMTmVA==
X-Received: by 2002:a17:906:6d04:: with SMTP id m4mr1520328ejr.68.1603451170550;
        Fri, 23 Oct 2020 04:06:10 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f7sm645773ejz.23.2020.10.23.04.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 04:06:09 -0700 (PDT)
Subject: Re: [PATCH v2] lib: Convert test_printf.c to KUnit
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        idryomov@gmail.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20201022151349.47436-1-98.arpi@gmail.com>
 <20201022191606.GQ4077@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0ab618c7-8c5c-00ae-8e08-0c1b99f3bf5c@rasmusvillemoes.dk>
Date:   Fri, 23 Oct 2020 13:06:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201022191606.GQ4077@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 22/10/2020 21.16, Andy Shevchenko wrote:
> On Thu, Oct 22, 2020 at 08:43:49PM +0530, Arpitha Raghunandan wrote:
>> Convert test lib/test_printf.c to KUnit. More information about
>> KUnit can be found at:
>> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
>> KUnit provides a common framework for unit tests in the kernel.
>> KUnit and kselftest are standardizing around KTAP, converting this
>> test to KUnit makes this test output in KTAP which we are trying to
>> make the standard test result format for the kernel. More about
>> the KTAP format can be found at:
>> https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/.
>> I ran both the original and converted tests as is to produce the
>> output for success of the test in the two cases. I also ran these
>> tests with a small modification to show the difference in the output
>> for failure of the test in both cases. The modification I made is:
>> - test("127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
>> + test("127-000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
>>
>> Original test success:
>> [    0.591262] test_printf: loaded.
>> [    0.591409] test_printf: all 388 tests passed
>>
>> Original test failure:
>> [    0.619345] test_printf: loaded.
>> [    0.619394] test_printf: vsnprintf(buf, 256, "%piS|%pIS", ...)
>> wrote '127.000.000.001|127.0.0.1', expected
>> '127-000.000.001|127.0.0.1'
>> [    0.619395] test_printf: vsnprintf(buf, 25, "%piS|%pIS", ...) wrote
>> '127.000.000.001|127.0.0.', expected '127-000.000.001|127.0.0.'
>> [    0.619396] test_printf: kvasprintf(..., "%piS|%pIS", ...) returned
>> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>> [    0.619495] test_printf: failed 3 out of 388 tests
>>
>> Converted test success:
>>     # Subtest: printf-kunit-test
>>     1..1
>>     ok 1 - selftest
>> ok 1 - printf-kunit-test
>>
>> Converted test failure:
>>     # Subtest: printf-kunit-test
>>     1..1
>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
>> vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote
>> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
>> vsnprintf(buf, 5, "%pi4|%pI4", ...) wrote '127.', expected '127-'
>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:118
>> kvasprintf(..., "%pi4|%pI4", ...) returned
>> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>>     not ok 1 - selftest
>> not ok 1 - printf-kunit-test
> 
> Not bad. Rasmus, what do you think?

Much better, but that '1..1' and reporting the entire test suite as 1
single (failing or passing) test is (also) a regression. Look at the
original

>> [    0.591409] test_printf: all 388 tests passed

or

>> [    0.619495] test_printf: failed 3 out of 388 tests

That's far more informative, and I'd prefer if the summary information
(whether in the all-good case or some-failing) included something like
this. In particular, I have at some point spotted that I failed to
properly hook up a new test case (or perhaps failed to re-compile, or
somehow still ran the old kernel binary, don't remember which it was) by
noticing that the total number of tests hadn't increased. The new output
would not help catch such PEBKACs.

Rasmus
