Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D383A7100
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jun 2021 23:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhFNVKu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Jun 2021 17:10:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53030 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhFNVKt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Jun 2021 17:10:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 396061F42D9D
Subject: Re: [PATCH v3 1/1] lib: Convert UUID runtime test to KUnit
To:     Daniel Latypov <dlatypov@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        David Gow <davidgow@google.com>, tales.aparecida@gmail.com
References: <20210610163959.71634-1-andrealmeid@collabora.com>
 <20210610163959.71634-2-andrealmeid@collabora.com>
 <20210614064205.GA29220@lst.de>
 <CAGS_qxrj3S-OccPj3-7MOeR98+RASN5MGOAUXeMR9jSkSkiXXg@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <cae00514-4719-f3d7-7fcf-fffb874c9837@collabora.com>
Date:   Mon, 14 Jun 2021 18:08:37 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGS_qxrj3S-OccPj3-7MOeR98+RASN5MGOAUXeMR9jSkSkiXXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Às 13:55 de 14/06/21, Daniel Latypov escreveu:
> On Sun, Jun 13, 2021 at 11:42 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>>> +config UUID_KUNIT_TEST
>>> +     tristate "Unit test for UUID" if !KUNIT_ALL_TESTS
>>> +     depends on KUNIT
>>> +     default KUNIT_ALL_TESTS
>>> +     help
>>> +       This builds the UUID unit test.
>>
>> Does this first help line really add any value if we have this second
>> line:
>>
>>> +       Tests parsing functions for UUID/GUID strings.
>>
>> ?
>>
>>> +       If unsure, say N.
>>
>> Not specific to this case, but IMHO we can drop this line for all kunit
>> tests as it is completely obvious.
>>
>>> @@ -354,5 +353,6 @@ obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>>>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
>>>  obj-$(CONFIG_BITS_TEST) += test_bits.o
>>>  obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
>>> +obj-$(CONFIG_UUID_KUNIT_TEST) += test_uuid.o
>>
>> Another meta-comment on the kunit tests:  Wouldn't it make more sense
>> to name them all as CONFIG_KUNIT_TEST_FOO to allow for easier grepping?
> 
> But putting them in a "kunit namespace" by prefixing them as such
> would be misleading, IMO.
> The tests live adjacent to the code they test and are owned by the
> same maintainers, or at least that's the intent.
> 
> And if the goal is just to find configs, then I don't see much
> difference between "config.*KUNIT_TEST" and "config KUNIT_TEST.*"
> 
>>
>>> -struct test_uuid_data {
>>> +struct test_data {
>>>       const char *uuid;
>>>       guid_t le;
>>>       uuid_t be;
>>>  };
>>>
>>> -static const struct test_uuid_data test_uuid_test_data[] = {
>>> +static const struct test_data correct_data[] = {
>>
>> What is the reason for these renames?  Is this a pattern used for
>> other kunit tests?
> 
> No, this is not a pattern.
> The structs can be renamed back.
> 

The idea behind this renaming is to be more explicit about what this
data is about: correct UUIDs inputs.

>>
>>> +static void uuid_correct_le(struct kunit *test)
>>>  {
>>> +     guid_t le;
>>> +     const struct test_data *data = (const struct test_data *)(test->param_value);
>>
>> Overly long line.  But as far as I can tell there is no need for the
>> case that causes this mess anyway given that param_value is a
>> "const void *".
> 
> There is no need for the cast or the brace, yes.
> This is my fault.
> 
> The documentation has both since I had thought that would make how it
> works more clear:
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/usage.html#parameterized-testing
> I don't really understand my past thought process...
> 

Ok, I'll change my code to remove the cast and braces. I can also send a
patch to rework this part of documentation.

>>
>> Same for all the other instances of this.
>>
>>> +static void uuid_wrong_le(struct kunit *test)
>>>  {
>>>       guid_t le;
>>> +     const char **data = (const char **)(test->param_value);
>>
>> No need for the second pair of braces.  Same for various other instances.
