Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A25D3A2C82
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 15:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFJNKg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 09:10:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56304 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhFJNKg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 09:10:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 69D2C1F43DF6
Subject: Re: [PATCH v2 0/1] lib: Convert UUID runtime test to KUnit
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Gow <davidgow@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        Daniel Latypov <dlatypov@google.com>, tales.aparecida@gmail.com
References: <20210609233730.164082-1-andrealmeid@collabora.com>
 <YMHX1mKuqoRCiHAF@smile.fi.intel.com>
 <CABVgOS=5xkYKD18YfU++u8snpUnL2s=V6bK1e4qc_jTmAuazkw@mail.gmail.com>
 <CAHp75VdRaztt6gPUuznCa_5yBRNF3WFYq78Tq-ozh=DBA5-FEQ@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <63b2e441-f72d-6602-8680-defd96c21ac7@collabora.com>
Date:   Thu, 10 Jun 2021 10:08:30 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdRaztt6gPUuznCa_5yBRNF3WFYq78Tq-ozh=DBA5-FEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Às 09:39 de 10/06/21, Andy Shevchenko escreveu:
> On Thu, Jun 10, 2021 at 2:54 PM David Gow <davidgow@google.com> wrote:
>> On Thu, Jun 10, 2021 at 5:14 PM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>> On Wed, Jun 09, 2021 at 08:37:29PM -0300, André Almeida wrote:
> 
> ...
> 
>> Note that this output is from the kunit_tool script, which parses the
>> test output.
>> It does include a summary line:
>> [04:41:01] Testing complete. 4 tests run. 0 failed. 0 crashed.
> 
>> Note that this does only count the number of "tests" run --- the
>> individual UUIDs are parameters to the same test, so aren't counted
>> independently by the wrapper at the moment.
>>
>> That being said, the raw output looks like this (all tests passed):
>> TAP version 14
>> 1..1
>>    # Subtest: uuid
>>    1..4
>>    # uuid_correct_be: ok 1 - c33f4995-3701-450e-9fbf-206a2e98e576
>>    # uuid_correct_be: ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
>>    # uuid_correct_be: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
>>    ok 1 - uuid_correct_be
>>    # uuid_correct_le: ok 1 - c33f4995-3701-450e-9fbf-206a2e98e576
>>    # uuid_correct_le: ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
>>    # uuid_correct_le: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
>>    ok 2 - uuid_correct_le
>>    # uuid_wrong_be: ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
>>    # uuid_wrong_be: ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
>>    # uuid_wrong_be: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
>>    ok 3 - uuid_wrong_be
>>    # uuid_wrong_le: ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
>>    # uuid_wrong_le: ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
>>    # uuid_wrong_le: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
>>    ok 4 - uuid_wrong_le
>> ok 1 - uuid
>>
>> A test which failed could look like this:
>>     # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
>>    Expected guid_parse(data->uuid, &le) == 0, but
>>        guid_parse(data->uuid, &le) == -22
>>
>> failed to parse 'c33f499x5-3701-450e-9fbf-206a2e98e576'
>>    # uuid_correct_le: not ok 1 - c33f499x5-3701-450e-9fbf-206a2e98e576
>>    # uuid_correct_le: ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
>>    # uuid_correct_le: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
>>    not ok 2 - uuid_correct_le
>>
>>>
>>> Thanks!
>>>
>>> It's not your fault but I think we need to defer this until KUnit gains support
>>> of the run statistics. My guts telling me if we allow more and more conversions
>>> like this the point will vanish and nobody will care.
>>
>> Did the test statistics patch we sent out before meet your expectations?
>> https://patchwork.kernel.org/project/linux-kselftest/patch/20201211072319.533803-1-davidgow@google.com/
> 
> Let me look at it at some point.
> 
>> If so, we can tidy it up and try to push it through straight away, we
>> were just waiting for a review from someone who wanted the feature.
>>
>>
>>> I like the code, but I can give my tag after KUnit prints some kind of this:
>>>
>>>  * This is how the current output looks like in success:
>>>
>>>    test_uuid: all 18 tests passed
>>>
>>>  * And when it fails:
>>>
>>>    test_uuid: failed 18 out of 18 tests
>>>
>>
>> There are some small restrictions on the exact format KUnit can use
>> for this if we want to continue to match the (K)TAP specification
>> which is being adopted by kselftest. The patch linked above should
>> give something formatted like:
>>
>> # test_uuid: (0 / 4) tests failed (0 / 12 test parameters)
>>
>> Would that work for you?
> 
> Can you decode it for me, please?
> 
> (Assuming that the above question arisen, perhaps some rephrasing is
> needed. The idea that user should have clear understanding on how many
> test cases were run and how many of them successfully finished or
> failed. According to this thread I have to see the cumulative number
> of 18 (either as one number or sum over test cases or how you call
> them, I see 4 here).
> 
> 

In the original code, each `if(uuid/guid_parse/equal)` was considered as
a test, so there were 4 tests for the 3 correct inputs and 2 tests for
the 3 wrong inputs: 4 * 3 + 2 * 3 = 18 tests.

In my patch, I've organized in a different way, with 4 test cases:

- A test case for guid_parse and guid_equal for correct inputs
- A test case for uuid_parse and uuid_equal for correct inputs
- A test case for guid_parse for incorrect inputs
- A test case for uuid_parse for incorrect inputs

So now we have 4 test cases, instead of the 6 test cases in the original
code, because I've united _parse and _equal in a single test case. Given
that each test has 3 parameters, this is why we see 12 test parameters
and that's why there's no "18 tests" around anymore.
