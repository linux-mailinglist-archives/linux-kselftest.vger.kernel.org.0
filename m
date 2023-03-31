Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8466D2911
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 22:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjCaUBo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjCaUBR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 16:01:17 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1BB2442E;
        Fri, 31 Mar 2023 13:00:44 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r17-20020a05683002f100b006a131458abfso9886441ote.2;
        Fri, 31 Mar 2023 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680292843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkMDSjPTrbtCjW0uE+j6Es0X3yUk9ilSKHUgCJwF+4w=;
        b=qaZr/NCoJfpzqRYBgBIRacpSY7hwfD6YTuAQ6aHxyhmskkFttCmtxpx+Fbf9M7pLeB
         qQsuBuwKL83BrqY+Jt6ldS17ope1XeC02m/xsfWVpKiAEWpiSMGlksVaeAIkw4dnxJFI
         AJDdIqd0G2Fo2eW5sNJKc3JsQ/qGbT8F4jJaOIJRvjbJabK+vfmpkYOmUtqawnwzwyqi
         TMqZYl6GRpZx3deFARX7356zWTqjthXwLoXM+1YFzb4LGPnjcJq86AjwZf1SPIJcSf89
         CPCRKPYGWeL8dHzcxyyoUrXwAVBqPaeijo7oD3FUiahNvAlXMtMwKFWM9s0kTzi/djVP
         RPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkMDSjPTrbtCjW0uE+j6Es0X3yUk9ilSKHUgCJwF+4w=;
        b=Wbbx+axyGh5EmwPYVK++u9ffQ9AI7pBk/hg2EW8d7lRoe2YSuoJIjJ5lGyBGFe2K8G
         ZfhWhVaAFDIte2PTGZZ0P2LesO9aD+Pa6ebwPyozfQ8UnSz29bX57VZ0D51+iMb7NXrB
         5owTAzQcqDn9+5P0CBDHRedtVYwZFxgmP70pPmOACAYNCLhdaUcDv7fLxD0UoFzXLFiz
         51IH23N5ipUeNb2fhI+Qqz1VCLISqHBZ+qLW0tdYWMDKB6VQhrkaU0taWILi8rV6tnk6
         FTBC91GyyspwSF/5EwFkwbgomoTHKOIoICRjdtaLVSfNtyfWB2g6OUU0XmZjnlr42e+Z
         ehww==
X-Gm-Message-State: AO0yUKUQCiT9SyuxFBGrSDUVpi9NB28Im0m2m9yRA5gV4euhY84sz7OY
        o4EzvFRQwJhAyiSsvVQPfVs=
X-Google-Smtp-Source: AK7set85PaivLMXtDhCplaocU40d4asKIdhcngl8AebZLV5okcj6pm3VcAU7ewcdjaKu2fn0DaZBSg==
X-Received: by 2002:a05:6830:1211:b0:69f:9cec:1962 with SMTP id r17-20020a056830121100b0069f9cec1962mr13508058otp.20.1680292842839;
        Fri, 31 Mar 2023 13:00:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:71ba:9450:b500:725c? ([2600:1700:2442:6db0:71ba:9450:b500:725c])
        by smtp.gmail.com with ESMTPSA id e14-20020a9d6e0e000000b0069f951899e1sm1520318otr.24.2023.03.31.13.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 13:00:42 -0700 (PDT)
Message-ID: <c32a7ba2-679b-4249-865d-169d96fb92b4@gmail.com>
Date:   Fri, 31 Mar 2023 15:00:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [KTAP V2 PATCH] ktap_v2: add recognized test name line
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
Cc:     davidgow@google.com, skhan@linuxfoundation.org,
        keescook@chromium.org, Tim.Bird@sony.com,
        brendanhiggins@google.com, corbet@lwn.net,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@lists.linux.dev, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230316225915.494688-1-rmoar@google.com>
 <197889b6-5773-094c-8699-26843c6519fd@gmail.com>
 <CA+GJov7cYs4gjpTgKiRz=NmPR37jwsFjLoCFBnDq4yqk3jwjGg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CA+GJov7cYs4gjpTgKiRz=NmPR37jwsFjLoCFBnDq4yqk3jwjGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/29/23 13:34, Rae Moar wrote:
> On Sun, Mar 26, 2023 at 10:41 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 3/16/23 17:59, Rae Moar wrote:
>>> Add recognition of the test name line ("# Subtest: <name>") to the KTAP v2
>>> spec.
>>>
>>> The purpose of this line is to declare the name of a test before its
>>> results. This functionality is especially useful when trying to parse test
>>> results incrementally and when interpretting results after a crash.
>>>
>>> This line is already compliant with KTAP v1 as it is interpretted as a
>>> diagnostic line by parsers. Additionally, the line is currently used by
>>> KUnit tests and was derived from the TAP 14 spec:
>>> https://testanything.org/tap-version-14-specification.html.
>>
>> It is convenient that "# Subtest: <name>" is compatible with v1, but I think
>> that there is a negative that overrides the convenience.
>>
>> The "# Subtest: <name>" syntax means that we need to restrict the format of
>> diagnostic lines, such that "#Subtest:" is an illegal diagnostic, at least
>> for the line immediately following the Version line.
>>
> 
> Hi Frank,
> 
> Yes, I see what you are saying here. It would be inconvenient for
> parsers to make an exception to the method of parsing diagnostic
> lines.
> 
>> I think it would be cleaner to modify the Version line syntax to be:
>>
>>   KTAP version 2 [# <subtest_name>]
>>
> 
> I like that this idea wouldn't introduce a new line, which is
> invaluable. However, I would suspect this alternative may break more
> parsers than the first proposal, as current parsers may search for the
> full version line to find KTAP results (I know at least KUnit does
> this). Therefore I slightly prefer the original proposal. Curious what
> others prefer?

If the parser searches the full version line, it will already fail to accept
"KTAP version 2", because it is looking for "KTAP version 1" only.  When the
parser gets updated to find "KTAP version 2", it should be not too difficult
to add "[# <subtest_name>]" to be valid data.

-Frank

> 
> Overall, I advocate that KTAP should allow a way to define the name of
> the test prior to the results based on the reasons discussed above and
> by Daniel and Frank. So if this is the preferred method I would
> understand.
> 
>> I notice that the KTAP Specification version 1 fails to specify the
>> Version line syntax.  So the Specification would be updated from:
>>
>>   All KTAP-formatted results begin with a "version line" which specifies which
>>   version of the (K)TAP standard the result is compliant with.
>>
>>   For example:
>>   - "KTAP version 1"
>>   - "TAP version 13"
>>   - "TAP version 14"
>>
>> to:
>>
>>   The Version line is required and must have the format:
>>
>>   .. code-block:: none
>>
>>         KTAP version 2 [# <subtest_name>]
>>
> 
> I like this added specificity. Would be happy to see specific version
> line syntax added to the spec.
> 
> Thanks!
> 
> Rae
> 
>>   All KTAP-formatted results begin with a "version line" which specifies which
>>   version of the (K)TAP standard the result is compliant with.
>>
>>   For example:
>>   - "KTAP version 2"
>>   - "TAP version 13"
>>   - "TAP version 14"
>>
>>>
>>> Recognition of this line would create an accepted way for different test
>>> frameworks to declare the name of a test before its results.
>>>
>>> The proposed location for this line is between the version line and the
>>> test plan line. This location ensures that the line would not be
>>> accidentally parsed as a subtest's diagnostic lines. Note this proposed
>>> location would be a slight differentiation from KTAP v1.
>>>
>>> Example of test name line:
>>>
>>>  KTAP version 2
>>>  # Subtest: main_test
>>>  1..1
>>>    KTAP version 2
>>>    # Subtest: sub_test
>>>    1..2
>>>    ok 1 test_1
>>>    ok 2 test_2
>>>  ok 1 sub_test
>>>
>>> Here is a link to a version of the KUnit parser that is able to parse the
>>> test name line for KTAP version 2. Note this includes a test name line for
>>> the main level of KTAP.
>>>
>>> Link: https://kunit-review.googlesource.com/c/linux/+/5709
>>>
>>> Signed-off-by: Rae Moar <rmoar@google.com>
>>> ---
>>>
>>> This is a RFC. I would like to know what people think and use this as a
>>> platform for discussion on KTAP v2.
>>>
>>> Note: this patch is based on Frank's ktap_spec_version_2 branch.
>>>
>>>  Documentation/dev-tools/ktap.rst | 19 ++++++++++++++-----
>>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
>>> index ff77f4aaa6ef..9c7ed66d9f77 100644
>>> --- a/Documentation/dev-tools/ktap.rst
>>> +++ b/Documentation/dev-tools/ktap.rst
>>> @@ -28,8 +28,7 @@ KTAP output is built from four different types of lines:
>>>  In general, valid KTAP output should also form valid TAP output, but some
>>>  information, in particular nested test results, may be lost. Also note that
>>>  there is a stagnant draft specification for TAP14, KTAP diverges from this in
>>> -a couple of places (notably the "Subtest" header), which are described where
>>> -relevant later in this document.
>>> +a couple of places, which are described where relevant later in this document.
>>>
>>>  Version lines
>>>  -------------
>>> @@ -44,8 +43,8 @@ For example:
>>>  - "TAP version 14"
>>>
>>>  Note that, in KTAP, subtests also begin with a version line, which denotes the
>>
>>> -start of the nested test results. This differs from TAP14, which uses a
>>> -separate "Subtest" line.
>>
>> ^^^^ This is an error in the KTAP Specification version 1.  TAP14 allows the case
>> of "Bare Subtests", which would be the equivalent of the KTAP v1 method.
>>
>>> +start of the nested test results. This differs from TAP14, which uses only a
>>> +"Subtest" line.
>>>
>>>  While, going forward, "KTAP version 2" should be used by compliant tests, it
>>>  is expected that most parsers and other tooling will accept the other versions
>>> @@ -166,6 +165,12 @@ even if they do not start with a "#": this is to capture any other useful
>>>  kernel output which may help debug the test. It is nevertheless recommended
>>>  that tests always prefix any diagnostic output they have with a "#" character.
>>>
>>> +One recognized diagnostic line is the "# Subtest: <name>" line. This line
>>> +is used to declare the name of a test before subtest results are printed. This
>>> +is helpful for parsing and for providing context during crashes. As a rule,
>>> +this line is placed after the version line and before the plan line. Note
>>> +this line can be used for the main test, as well as subtests.
>>> +
>>>  Unknown lines
>>>  -------------
>>>
>>> @@ -206,6 +211,7 @@ An example of a test with two nested subtests:
>>>       KTAP version 2
>>>       1..1
>>>         KTAP version 2
>>> +       # Subtest: example
>>>         1..2
>>>         ok 1 test_1
>>>         not ok 2 test_2
>>> @@ -219,6 +225,7 @@ An example format with multiple levels of nested testing:
>>>       KTAP version 2
>>>       1..2
>>>         KTAP version 2
>>> +       # Subtest: example_test_1
>>>         1..2
>>>           KTAP version 2
>>>           1..2
>>> @@ -245,7 +252,7 @@ allows an arbitrary number of tests to be nested     no         yes
>>>
>>>  The TAP14 specification does permit nested tests, but instead of using another
>>>  nested version line, uses a line of the form
>>> -"Subtest: <name>" where <name> is the name of the parent test.
>>> +"Subtest: <name>" where <name> is the name of the parent test as discussed above.
>>>
>>>  Example KTAP output
>>>  --------------------
>>> @@ -254,6 +261,7 @@ Example KTAP output
>>>       KTAP version 2
>>>       1..1
>>>         KTAP version 2
>>> +       # Subtest: main_test
>>>         1..3
>>>           KTAP version 2
>>>           1..1
>>> @@ -266,6 +274,7 @@ Example KTAP output
>>>           ok 2 test_2
>>>         ok 2 example_test_2
>>>           KTAP version 2
>>> +             # Subtest: example_test_3
>>>           1..3
>>>           ok 1 test_1
>>>           # test_2: FAIL
>>>
>>> base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/197889b6-5773-094c-8699-26843c6519fd%40gmail.com.

