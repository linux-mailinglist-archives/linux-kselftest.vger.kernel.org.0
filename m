Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764E76EFCAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 23:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjDZV5P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 17:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjDZV5P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 17:57:15 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6E7C1;
        Wed, 26 Apr 2023 14:57:13 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-187af4a5437so5670684fac.0;
        Wed, 26 Apr 2023 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682546232; x=1685138232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oD7/aZPWXMbOzrPn/edlHT09GwXmGROZVgC42Y9X8mY=;
        b=s0j9q0vaVvkz/0qrS0+oL17U9BRIn04FmDMASAQKVBd8Cuk0XlrR73psEqHcGefCa3
         W6oYF8wcncBthEzIFtYkyTi3Lhfmmbdl96TtZy2C4YMk6BeyqTRsDGdZ7ANdJVkgj/EN
         i7iVJr6bqeVrxBUcNLJ4uOi7tyCc0EGfomWIGU4npdsRNIzKsAeIOR7rXRTEvXWDQgf+
         nD9lNeT06ns0lrdg94QX+kln/PzxEkIdmg7zYpzjKUam+oC8giEoJLcAvuJk0+THBnDm
         sWtzj+IGuCumsJ324sJ8uql2TlEglk8OGRr5v5V/WPfn/VYiQcVRyRHrJSZKrpPEAhGt
         8VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682546232; x=1685138232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oD7/aZPWXMbOzrPn/edlHT09GwXmGROZVgC42Y9X8mY=;
        b=eBxM85NVOAFuMFJFqwi7PlaHBWX83cKHzmkP1t+4qaZnejrlTU64rwJqpMz/wp/xIP
         s/6RYAs4Bc+fSSbwpF/sEtq/NpkOLMF1RnDGI29pk0FJbq2Zi0DUYjnTXIrc1fjWRr9s
         FnAYXYo22QZ4BxdbbMyB3QIO9LhELxFOZRoLygD1B6YHOwtUsRcDyefb4HVfDgzXVc+N
         FjCpx/k0XSfUUB1tQ5M7Ln9yUVMJDEDKZpZWIF5TM/P9Bc3JtdAjVVMkD4TuW9L9rJX7
         xnxqj+KudAe3I71Nq5a0sw5N9AmteQRPOrm+dzP30vWNrH+cqFZe9VTwdmXMQzyTM3bm
         +h6w==
X-Gm-Message-State: AAQBX9cuVuKEIy4uDuMlsNQvljOEVorswmgnIktvqqn967eKH2N9kpMC
        CPXLctZ5djKbAANsuCC+5TA=
X-Google-Smtp-Source: AKy350bZ11ByC/hX6kRdVTlnJMIeceQfdVAd0fnSJRcFtP6pheTgpqHuHv0sGlvuppBjTlEUpRa4qg==
X-Received: by 2002:a05:6871:72a:b0:18e:2e25:a68 with SMTP id f42-20020a056871072a00b0018e2e250a68mr11741443oap.15.1682546232383;
        Wed, 26 Apr 2023 14:57:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:d566:c174:e87d:7b51? ([2600:1700:2442:6db0:d566:c174:e87d:7b51])
        by smtp.gmail.com with ESMTPSA id n3-20020a056870e40300b00172ac40356csm7028594oag.50.2023.04.26.14.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 14:57:11 -0700 (PDT)
Message-ID: <bfb72bc1-747a-fbac-f253-b1c68a82536b@gmail.com>
Date:   Wed, 26 Apr 2023 16:57:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [KTAP V2 PATCH] ktap_v2: add test metadata
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
Cc:     davidgow@google.com, skhan@linuxfoundation.org,
        keescook@chromium.org, Tim.Bird@sony.com,
        brendanhiggins@google.com, corbet@lwn.net,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@lists.linux.dev, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420205734.1288498-1-rmoar@google.com>
 <ce5b723d-2395-8974-ba62-1ee519732218@gmail.com>
 <CA+GJov5nG3fXz9KX-DdkpJ2R98f1LD=rnURomzvUzHHsAODr8A@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CA+GJov5nG3fXz9KX-DdkpJ2R98f1LD=rnURomzvUzHHsAODr8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/26/23 11:18, Rae Moar wrote:
> On Tue, Apr 25, 2023 at 4:55 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 4/20/23 15:57, Rae Moar wrote:
>>> Add specification for declaring test metadata to the KTAP v2 spec.
>>>
>>> The purpose of test metadata is to allow for the declaration of essential
>>> testing information in KTAP output. This information includes test
>>> names, test configuration info, test attributes, and test files.
>>>
>>> There have been similar ideas around the idea of test metadata such as test
>>> prefixes and test name lines. However, I propose this specification as an
>>> overall fix for these issues.
>>
>> This seems like a cleaner approach.
>>
>>>
>>> These test metadata lines are a form of diagnostic lines with the
>>> format: "# <metadata_type>: <data>". As a type of diagnostic line, test
>>> metadata lines are compliant with KTAP v1, which will help to not
>>> interfere too much with current parsers.
>>>
>>> Specifically the "# Subtest:" line is derived from the TAP 14 spec:
>>> https://testanything.org/tap-version-14-specification.html.
>>>
>>> The proposed location for test metadata is in the test header, between the
>>> version line and the test plan line. Note including diagnostic lines in
>>> the test header is a depature from KTAP v1.
>>>
>>> This location provides two main benefits:
>>>
>>> First, metadata will be printed prior to when subtests are run. Then if a
>>> test fails, test metadata can help discern which test is causing the issue
>>> and potentially why.
>>>
>>> Second, this location ensures that the lines will not be accidentally
>>> parsed as a subtest's diagnostic lines because the lines are bordered by
>>> the version line and plan line.
>>
>> I like that.
>>
>>>
>>> Here is an example of test metadata:
>>>
>>>  KTAP version 2
>>>  # Config: CONFIG_TEST=y
>>>  1..1
>>>      KTAP version 2
>>>      # Subtest: test_suite
>>>      # File: /sys/kernel/...
>>>      # Attributes: slow
>>>      # Other: example_test
>>>      1..2
>>>      ok 1 test_1
>>>      ok 2 test_2
>>>  ok 1 test_suite
>>>
>>> Here is a link to a version of the KUnit parser that is able to parse test
>>> metadata lines for KTAP version 2. Note this includes test metadata
>>> lines for the main level of KTAP.
>>>
>>> Link: https://kunit-review.googlesource.com/c/linux/+/5809
>>>
>>> Signed-off-by: Rae Moar <rmoar@google.com>
>>> ---
>>>
>>> Hi everyone,
>>>
>>> I would like to use this proposal similar to an RFC to gather ideas on the
>>> topic of test metadata. Let me know what you think.
>>>
>>> I am also interested in brainstorming a list of recognized metadata types.
>>> Providing recognized metadata types would be helpful in parsing and
>>> displaying test metadata in a useful way.
>>>
>>> Current ideas:
>>> - "# Subtest: <test_name>" to indicate test name (name must match
>>>   corresponding result line)
>>
>> I would prefer "Test" to "Subtest" because the type should be allowed for the
>> top level test, as well as for subtest levels.
> 
> Hi Frank!
> 
> Yes, I can see the reasoning to switch to "Test". Although this is a
> departure from current behavior, it would be clearer. I am happy to
> make this change.
> 
>>
>>> - "# Attributes: <attributes list>" to indicate test attributes (list
>>>   separated by commas)

Should the spec say that <attributes list> is test specific (and defined by
the test) and not defined in the ktap specification?

I think there is a balance between under specifying and over specifying
within the ktap specification.  But I think the specification should
be clear about what definition is left open to the test implementations.

My wishy washy thought for the general case is that the ktap specification
should leave as much as choice as possible to the test implementers,
but should provide as much detail as needed to provide general guidance
to parser implementers.

>>> - "# File: <file_path>" to indicate file used in testing

nit question: Should both relative paths and absolute paths be allowed
for <file_path>?  I think both have value in different contexts.

>>>
>>> Any other ideas?
>>
>> (Already used in an example above...)
>>
>> - "# Config: <config_option list> to indicate kernel configuration options
>>   (list separated by commas)
>>
>>     config_option format:
>>       Option XXX is enabled: CONFIG_XXX=y
>>       Option XXX is not enabled: CONFIG_XXX=n
>>       Option XXX is text: CONFIG_XXX="a text string"
>>
> 
> I like this addition of the "Config" metadata. I also like all of
> these format options, including the text string option. Although, I
> would be interested in adding "Option XXX is loadable as a module:
> CONFIG_XXX=m" to the format list.

Yes, definitely.  I thought I was blanking on an additional form
of a config option when I wrote that.

> 
>> Linux .config format is "#CONFIG_XXX is not set",
>> but this would be harder to parse in a list.
>>
>> A text config option also complicates parsing of a list.  Maybe there
>> should not be a list, instead have a separate "# Config:" line for
>> each config option.
> 
> I'm not sure how to deal with multiple config options. I am split
> between either using a list or multiple "Config" lines. I would be
> happy with either approach. Maybe a list would be slightly better,
> since it is slightly closer to the defined behavior for the attributes
> metadata line.

I slightly prefer the single option per line. :-)

> 
>>
>> I would like to bifurcate the name space of metadata types, to names
>> specified in the standard vs names not in the standard that can be
>> used on an experimental or for future use in existing tests.
>>
>> I can think of at least two ways to implement this:
>>
>> (1) types that are in the specification all begin with a specific prefix,
>> such as "ktap_" (bike shedding on naming welcomed), so the examples woudld be
>>
>>   # ktap_test:
>>   # ktap_attributes:
>>   # ktap_file:
>>   # ktap_config:
>>
>> (2) types that are _not_ in the specification all begin with a specific prefix,
>> such as "custom_" (bike shedding on naming welcomed).
>>
> 
> This is an interesting proposal. I like this idea of using a prefix. I
> would be happy to add this. I like "ktap_" and "custom_".

Those prefixes look good to me.

-Frank

> 
> Thanks!
> -Rae
> 
>>>
>>> Note this proposal replaces two of my previous proposals: "ktap_v2: add
>>> recognized test name line" and "ktap_v2: allow prefix to KTAP lines."
>>>
>>> Thanks!
>>> -Rae
>>>
>>> Note: this patch is based on Frank's ktap_spec_version_2 branch.
>>>
>>>  Documentation/dev-tools/ktap.rst | 51 ++++++++++++++++++++++++++++++--
>>>  1 file changed, 48 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
>>> index ff77f4aaa6ef..a2d0a196c115 100644
>>> --- a/Documentation/dev-tools/ktap.rst
>>> +++ b/Documentation/dev-tools/ktap.rst
>>> @@ -17,7 +17,9 @@ KTAP test results describe a series of tests (which may be nested: i.e., test
>>>  can have subtests), each of which can contain both diagnostic data -- e.g., log
>>>  lines -- and a final result. The test structure and results are
>>>  machine-readable, whereas the diagnostic data is unstructured and is there to
>>> -aid human debugging.
>>> +aid human debugging. One exception to this is test metadata lines - a type
>>> +of diagnostic lines. Test metadata is located between the version line and
>>> +plan line of a test and can be machine-readable.
>>>
>>>  KTAP output is built from four different types of lines:
>>>  - Version lines
>>> @@ -28,8 +30,7 @@ KTAP output is built from four different types of lines:
>>>  In general, valid KTAP output should also form valid TAP output, but some
>>>  information, in particular nested test results, may be lost. Also note that
>>>  there is a stagnant draft specification for TAP14, KTAP diverges from this in
>>> -a couple of places (notably the "Subtest" header), which are described where
>>> -relevant later in this document.
>>> +a couple of places, which are described where relevant later in this document.
>>>
>>>  Version lines
>>>  -------------
>>> @@ -166,6 +167,45 @@ even if they do not start with a "#": this is to capture any other useful
>>>  kernel output which may help debug the test. It is nevertheless recommended
>>>  that tests always prefix any diagnostic output they have with a "#" character.
>>>
>>> +Test metadata lines
>>> +-------------------
>>> +
>>> +Test metadata lines are a type of diagnostic lines used to the declare the
>>> +name of a test and other helpful testing information in the test header.
>>> +These lines are often helpful for parsing and for providing context during
>>> +crashes.
>>> +
>>> +Test metadata lines must follow the format: "# <metadata_type>: <data>".
>>> +These lines must be located between the version line and the plan line
>>> +within a test header.
>>> +
>>> +There are a few currently recognized metadata types:
>>> +- "# Subtest: <test_name>" to indicate test name (name must match
>>> +  corresponding result line)
>>> +- "# Attributes: <attributes list>" to indicate test attributes (list
>>> +  separated by commas)
>>> +- "# File: <file_path>" to indicate file used in testing
>>> +
>>> +As a rule, the "# Subtest:" line is generally first to declare the test
>>> +name. Note that metadata lines do not necessarily need to use a
>>> +recognized metadata type.
>>> +
>>> +An example of using metadata lines:
>>> +
>>> +::
>>> +
>>> +        KTAP version 2
>>> +        1..1
>>> +        # File: /sys/kernel/...
>>> +          KTAP version 2
>>> +          # Subtest: example
>>> +          # Attributes: slow, example_test
>>> +          1..1
>>> +          ok 1 test_1
>>> +        # example passed
>>> +        ok 1 example
>>> +
>>> +
>>>  Unknown lines
>>>  -------------
>>>
>>> @@ -206,6 +246,7 @@ An example of a test with two nested subtests:
>>>       KTAP version 2
>>>       1..1
>>>         KTAP version 2
>>> +       # Subtest: example
>>>         1..2
>>>         ok 1 test_1
>>>         not ok 2 test_2
>>> @@ -219,6 +260,7 @@ An example format with multiple levels of nested testing:
>>>       KTAP version 2
>>>       1..2
>>>         KTAP version 2
>>> +       # Subtest: example_test_1
>>>         1..2
>>>           KTAP version 2
>>>           1..2
>>> @@ -254,6 +296,7 @@ Example KTAP output
>>>       KTAP version 2
>>>       1..1
>>>         KTAP version 2
>>> +       # Subtest: main_test
>>>         1..3
>>>           KTAP version 2
>>>           1..1
>>> @@ -261,11 +304,13 @@ Example KTAP output
>>>           ok 1 test_1
>>>         ok 1 example_test_1
>>>           KTAP version 2
>>> +            # Attributes: slow
>>>           1..2
>>>           ok 1 test_1 # SKIP test_1 skipped
>>>           ok 2 test_2
>>>         ok 2 example_test_2
>>>           KTAP version 2
>>> +         # Subtest: example_test_3
>>>           1..3
>>>           ok 1 test_1
>>>           # test_2: FAIL
>>>
>>> base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
>>

