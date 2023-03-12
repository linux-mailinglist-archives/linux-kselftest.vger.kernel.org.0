Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1736B6318
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Mar 2023 05:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjCLECt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Mar 2023 23:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLECs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Mar 2023 23:02:48 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA0F64A80;
        Sat, 11 Mar 2023 20:02:43 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id l18so10110327qtp.1;
        Sat, 11 Mar 2023 20:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678593762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wba+yD51iIFOZPslc2BeFzq95bbBzqKEEGWAuTUDf8=;
        b=fWTWdfJir9LYcuBpHMuucDEFA4ugCcouyt27nKsI4NEiZIQEyfC3KhhFGHzUWhAbaQ
         BY5cm06Nc1om1PZrSjDBItVpnL0gTwr8O6qiskpyebxtKYIxhiE0YNJvi5USgsssm5Hc
         8hkZd/m7GP6zWJUosM25Sg7v4skKEZV81w0VKLKENhu2Y3goijT41+gsnxbQulNd0Y3Y
         8+3mmpxvTdGZlhAimfXXNDxudiK1DXigI74VwfHXsuY6Pac8mULYnSgsKPqMel+qaURb
         LE1s8rVUe1DRlGSNc41asUSMeCTO+kfuiHLjsU1CbF0SK6nuSr5jOOkaa2LLV1V7YBg+
         8Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678593762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wba+yD51iIFOZPslc2BeFzq95bbBzqKEEGWAuTUDf8=;
        b=eoB2Efk7dtbQqlEjoO97pGZwmjtSJc7zAcvV7YgNJYuu+oDG9q3oYQDj/fOq6zWmgH
         wnjctPfo4aUeZ+z7jAi/orCxbBlI0WSnSJEYItt6DGl8oEpe1bGZyD3Z9voXTFV9VEhc
         YbI6CF61qC1tHsvoUJlZ5bCdisQjpL7NxfXVZklEhfMVGHlySPnR8ksM9UKo4TsbJjA8
         Jf+jN9c7tkXTm9L0ALpIQh3nbsMwRyMvcAn1Y9xeg+zPQiGWvs62bi1BXqgJnuDYb/jX
         yUhmZCyryciXj18gtUW9xDbz++lnQYKiFYFFWg1SexLt+9/iIjZPpbeg91JGMZgKhCY2
         NMQQ==
X-Gm-Message-State: AO0yUKU3oIcMUZwE2p98ty60E8iSPvfJc/bafzF54VMCCqDJ++gy7HbR
        2MHJq3uI055vx58cSj7+41w=
X-Google-Smtp-Source: AK7set/K4mWvA1HVy/8rLA938H6UTSvJSOzWAa6+L81qUiLFxhrQA9Lgh3sqKhyuarcyRaVGzjZLWw==
X-Received: by 2002:a05:622a:14c8:b0:3b9:e4cf:ce2d with SMTP id u8-20020a05622a14c800b003b9e4cfce2dmr12486539qtx.16.1678593762583;
        Sat, 11 Mar 2023 20:02:42 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:147a:a472:2165:1ae5? ([2600:1700:2442:6db0:147a:a472:2165:1ae5])
        by smtp.gmail.com with ESMTPSA id m6-20020aed27c6000000b003b62bc6cd1csm2976113qtg.82.2023.03.11.20.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 20:02:42 -0800 (PST)
Message-ID: <9742cba9-5e1f-5ab1-301d-123c0cc6c65c@gmail.com>
Date:   Sat, 11 Mar 2023 22:02:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [KTAP V2 PATCH] ktap_v2: add skip test result
Content-Language: en-US
To:     "Bird, Tim" <Tim.Bird@sony.com>, Rae Moar <rmoar@google.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>,
        "dlatypov@google.com" <dlatypov@google.com>,
        "kernelci@groups.io" <kernelci@groups.io>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230310222002.3633162-1-rmoar@google.com>
 <BYAPR13MB2503C590A2AE6FEF6BCAC529FDBB9@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <BYAPR13MB2503C590A2AE6FEF6BCAC529FDBB9@BYAPR13MB2503.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/11/23 11:36, Bird, Tim wrote:
> 
> 
>> -----Original Message-----
>> From: Rae Moar <rmoar@google.com>
>>
>> Add the test result "skip" to KTAP version 2 as an alternative way to
>> indicate a test was skipped.
>>
>> The current spec uses the "#SKIP" directive to indicate that a test was
>> skipped. However, the "#SKIP" directive is not always evident when quickly
>> skimming through KTAP results.
>>
>> The "skip" result would provide an alternative that could make it clearer
>> that a test has not successfully passed because it was skipped.
>>
> 
> Is there an implementation patch (RFC or otherwise) that accompanies
> this change in the spec?
> 
> Also, can you tell me which kselftest modules you expect to use this
> new 'skip' result, as opposed to the #SKIP directive?  Are there patches
> pending submission that already use this?

All test should eventually be changed to the 'skip' result from the #SKIP
directive.  You asked about kselftest, but I'll comment about kunit because
I used to know more about the kunit infrastructure.  I suspect the kunit
skip related wrapper could be modified to make this change for all kunit
tests.

> 
> Which in-tree and out-of-tree results parsers would be affected?
> 
> I know my Fuego kselftest results parser would be affected.

It is inevitable that all parsers that process KTAP V1 will be affected
by KTAP v2.  It would be desirable for the changes made in V2 allow
the updated parsers to process both V1 compliant data and V2 compliant
data.  After allowing plenty of time for V1 compliant data to disappear,
the V3 Specification could possible obsolete some V1 constructs.  I do
not expect a V3 Specification to appear anytime in the forseeable
future, given the slow pace of creating V2.

> 
> While I recognize the slight improvement in human readability, this 
> will cause a fair amount of churn.  And it takes us out of TAP compliance.
> Can you quantify the churn a bit?

I would say that KTAP V1 is already out of TAP compliance.  And there were
test implementations that moved to use some of the never completed TAP
version 14 format, thus being out of compliance with TAP.

-Frank

> 
>  -- Tim
> 
>> Before:
>>
>>  KTAP version 1
>>  1..1
>>    KTAP version 1
>>    1..2
>>    ok 1 case_1
>>    ok 2 case_2 #SKIP
>>  ok 1 suite
>>
>> After:
>>
>>  KTAP version 2
>>  1..1
>>    KTAP version 2
>>    1..2
>>    ok 1 case_1
>>    skip 2 case_2
>>  ok 1 suite
>>
>> Here is a link to a version of the KUnit parser that is able to parse
>> the skip test result for KTAP version 2. Note this parser is still able
>> to parse the "#SKIP" directive.
>>
>> Link: https://kunit-review.googlesource.com/c/linux/+/5689
>>
>> Signed-off-by: Rae Moar <rmoar@google.com>
>> ---
>>
>> Note: this patch is based on Frank's ktap_spec_version_2 branch.
>>
>>  Documentation/dev-tools/ktap.rst | 27 ++++++++++++++++++---------
>>  1 file changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
>> index ff77f4aaa6ef..f48aa00db8f0 100644
>> --- a/Documentation/dev-tools/ktap.rst
>> +++ b/Documentation/dev-tools/ktap.rst
>> @@ -74,7 +74,8 @@ They are required and must have the format:
>>  	<result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
>>
>>  The result can be either "ok", which indicates the test case passed,
>> -or "not ok", which indicates that the test case failed.
>> +"not ok", which indicates that the test case failed, or "skip", which indicates
>> +the test case did not run.
>>
>>  <number> represents the number of the test being performed. The first test must
>>  have the number 1 and the number then must increase by 1 for each additional
>> @@ -91,12 +92,13 @@ A directive is a keyword that indicates a different outcome for a test other
>>  than passed and failed. The directive is optional, and consists of a single
>>  keyword preceding the diagnostic data. In the event that a parser encounters
>>  a directive it doesn't support, it should fall back to the "ok" / "not ok"
>> -result.
>> +/ "skip" result.
>>
>>  Currently accepted directives are:
>>
>> -- "SKIP", which indicates a test was skipped (note the result of the test case
>> -  result line can be either "ok" or "not ok" if the SKIP directive is used)
>> +- "SKIP", which indicates a test was skipped (note this is an alternative to
>> +  the "skip" result type and if the SKIP directive is used, the
>> +  result can be any type - "ok", "not ok", or "skip")
>>  - "TODO", which indicates that a test is not expected to pass at the moment,
>>    e.g. because the feature it is testing is known to be broken. While this
>>    directive is inherited from TAP, its use in the kernel is discouraged.
>> @@ -110,7 +112,7 @@ Currently accepted directives are:
>>
>>  The diagnostic data is a plain-text field which contains any additional details
>>  about why this result was produced. This is typically an error message for ERROR
>> -or failed tests, or a description of missing dependencies for a SKIP result.
>> +or failed tests, or a description of missing dependencies for a skipped test.
>>
>>  The diagnostic data field is optional, and results which have neither a
>>  directive nor any diagnostic data do not need to include the "#" field
>> @@ -130,11 +132,18 @@ The test "test_case_name" failed.
>>
>>  ::
>>
>> -	ok 1 test # SKIP necessary dependency unavailable
>> +	skip 1 test # necessary dependency unavailable
>>
>> -The test "test" was SKIPPED with the diagnostic message "necessary dependency
>> +The test "test" was skipped with the diagnostic message "necessary dependency
>>  unavailable".
>>
>> +::
>> +
>> +	ok 1 test_2 # SKIP this test should not run
>> +
>> +The test "test_2" was skipped with the diagnostic message "this test
>> +should not run".
>> +
>>  ::
>>
>>  	not ok 1 test # TIMEOUT 30 seconds
>> @@ -225,7 +234,7 @@ An example format with multiple levels of nested testing:
>>  	    not ok 1 test_1
>>  	    ok 2 test_2
>>  	  not ok 1 test_3
>> -	  ok 2 test_4 # SKIP
>> +	  skip 2 test_4
>>  	not ok 1 example_test_1
>>  	ok 2 example_test_2
>>
>> @@ -262,7 +271,7 @@ Example KTAP output
>>  	  ok 1 example_test_1
>>  	    KTAP version 2
>>  	    1..2
>> -	    ok 1 test_1 # SKIP test_1 skipped
>> +	    skip 1 test_1 # test_1 skipped
>>  	    ok 2 test_2
>>  	  ok 2 example_test_2
>>  	    KTAP version 2
>>
>> base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
>> --
>> 2.40.0.rc1.284.g88254d51c5-goog
> 

