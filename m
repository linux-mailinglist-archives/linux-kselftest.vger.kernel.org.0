Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED573A2D8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFJN6w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 09:58:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56912 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFJN6w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 09:58:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id DF4261F42FC6
Subject: Re: [PATCH v2 0/1] lib: Convert UUID runtime test to KUnit
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     David Gow <davidgow@google.com>, Christoph Hellwig <hch@lst.de>,
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
 <63b2e441-f72d-6602-8680-defd96c21ac7@collabora.com>
 <YMIZGG/zGk0wv42V@smile.fi.intel.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <08ce2a85-43b6-1a79-e258-2a39c74e2689@collabora.com>
Date:   Thu, 10 Jun 2021 10:56:44 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMIZGG/zGk0wv42V@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Às 10:52 de 10/06/21, Andy Shevchenko escreveu:
> On Thu, Jun 10, 2021 at 10:08:30AM -0300, André Almeida wrote:
>> Às 09:39 de 10/06/21, Andy Shevchenko escreveu:
>>> On Thu, Jun 10, 2021 at 2:54 PM David Gow <davidgow@google.com> wrote:
>>>> On Thu, Jun 10, 2021 at 5:14 PM Andy Shevchenko
>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>> On Wed, Jun 09, 2021 at 08:37:29PM -0300, André Almeida wrote:
> 
> ...
> 
>>>>> It's not your fault but I think we need to defer this until KUnit gains support
>>>>> of the run statistics. My guts telling me if we allow more and more conversions
>>>>> like this the point will vanish and nobody will care.
>>>>
>>>> Did the test statistics patch we sent out before meet your expectations?
>>>> https://patchwork.kernel.org/project/linux-kselftest/patch/20201211072319.533803-1-davidgow@google.com/
>>>
>>> Let me look at it at some point.
>>>
>>>> If so, we can tidy it up and try to push it through straight away, we
>>>> were just waiting for a review from someone who wanted the feature.
>>>>
>>>>
>>>>> I like the code, but I can give my tag after KUnit prints some kind of this:
>>>>>
>>>>>  * This is how the current output looks like in success:
>>>>>
>>>>>    test_uuid: all 18 tests passed
>>>>>
>>>>>  * And when it fails:
>>>>>
>>>>>    test_uuid: failed 18 out of 18 tests
>>>>>
>>>>
>>>> There are some small restrictions on the exact format KUnit can use
>>>> for this if we want to continue to match the (K)TAP specification
>>>> which is being adopted by kselftest. The patch linked above should
>>>> give something formatted like:
>>>>
>>>> # test_uuid: (0 / 4) tests failed (0 / 12 test parameters)
>>>>
>>>> Would that work for you?
>>>
>>> Can you decode it for me, please?
>>>
>>> (Assuming that the above question arisen, perhaps some rephrasing is
>>> needed. The idea that user should have clear understanding on how many
>>> test cases were run and how many of them successfully finished or
>>> failed. According to this thread I have to see the cumulative number
>>> of 18 (either as one number or sum over test cases or how you call
>>> them, I see 4 here).
>>
>> In the original code, each `if(uuid/guid_parse/equal)` was considered as
>> a test, so there were 4 tests for the 3 correct inputs and 2 tests for
>> the 3 wrong inputs: 4 * 3 + 2 * 3 = 18 tests.
>>
>> In my patch, I've organized in a different way, with 4 test cases:
>>
>> - A test case for guid_parse and guid_equal for correct inputs
>> - A test case for uuid_parse and uuid_equal for correct inputs
>> - A test case for guid_parse for incorrect inputs
>> - A test case for uuid_parse for incorrect inputs
>>
>> So now we have 4 test cases, instead of the 6 test cases in the original
>> code, because I've united _parse and _equal in a single test case. Given
>> that each test has 3 parameters, this is why we see 12 test parameters
>> and that's why there's no "18 tests" around anymore.
> 
> I see, is it mentioned in the commit message? If no, please add this
> explanation.
> 
> Let's assume 12 now is the correct number, then the output can be somehow
> rephrased, but again, it's not in your patch anyway :-)
> 

Sure! I'll add this for v3 :)
