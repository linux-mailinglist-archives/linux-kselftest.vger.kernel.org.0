Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5DB76232E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 22:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGYUUG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 16:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGYUUF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 16:20:05 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4276C1BE2;
        Tue, 25 Jul 2023 13:20:04 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so6560501276.3;
        Tue, 25 Jul 2023 13:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690316403; x=1690921203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JplYEBO71eE2jWz0LBGOQOzxtjuDy5Pj6xly4aLbp8o=;
        b=H09+KHs9AN3LWmXS6SPrW4PqJzV40N+orlppWvBqAiSUAsN3OCzQqNvk4oHI342SlA
         g86MgYnYgIKaIukvul2s9uolMA4Wg5FCLaBwOSnqzZFhU1vZJEFJEuZM3ulsIikf1Ukl
         H/0l1STde/VwcUpuyK/FV5lSUse9uQSTpy59ge6p+LV2HSwgkASve5UxiZUd02QC+Wko
         3jzR54YCLrGKk8MCNKh4j1fp/3KKNd2kSBxD3KGhrO9wxZuPJ02oZ35txH8IEXqwgjI9
         jel5IkcDismkgxJxOCokPp/T6anhKyc86mh7GkKjDu842h4l1ZmgwtEi42L2ldTHLR//
         p3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316403; x=1690921203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JplYEBO71eE2jWz0LBGOQOzxtjuDy5Pj6xly4aLbp8o=;
        b=K55FeCrYAamylFHadIkjf7ud77esL4cwm/mSDMSGLdOWjzXh8J7aEEVPnRKOUMnD2i
         QmwnoIwo04TMTnkMGCe06PhFiKn06wSlhiC+01v3gvMH0JIuQ04UXV2mn7ky0f9Y0ecN
         Pdaf5BPeRK7HgJOSLxhXUqvi55J9x7B3feMzzKRCKubr10ztpCiVy9TWn4Vv/4B7fShl
         pdwiICZAXmfjcgRDo4ARCU+3hDtOAsoXralfkbZ2v0dqKVHvENU5zW92MyUy1Mj5/E26
         cT4zywBmWIlVaEJQLMxXhXAYm44XpKdSyW4LfA9g282RMU33Th5aSV7J7hqy16DoRWik
         rtKw==
X-Gm-Message-State: ABy/qLbzqMQg+D4U7keIkWeN/xK1gcpHFujhxb12TA/TO14bn3Wfij18
        UXMMQ9wAEgunMMsN3aBLbTlCwFtah3M=
X-Google-Smtp-Source: APBJJlHAzkLPRR+D+g6g9SGSb/9OeFtEgu+KQqwuBmcYCg21b/sad8a+CK4BWrGPiFr7fXtaQ5YBng==
X-Received: by 2002:a25:4217:0:b0:d19:86a8:24c6 with SMTP id p23-20020a254217000000b00d1986a824c6mr51337yba.42.1690316403322;
        Tue, 25 Jul 2023 13:20:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:3122:9f86:908c:8eb3? ([2600:1700:2442:6db0:3122:9f86:908c:8eb3])
        by smtp.gmail.com with ESMTPSA id q16-20020a5b0350000000b00bcf788d09e3sm3042194ybp.34.2023.07.25.13.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:20:02 -0700 (PDT)
Message-ID: <a825567e-ff51-fdae-0e58-eb9365ecc6b5@gmail.com>
Date:   Tue, 25 Jul 2023 15:20:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [KTAP V2 PATCH] ktap_v2: add test metadata
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>, davidgow@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     corbet@lwn.net, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@lists.linux.dev,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420205734.1288498-1-rmoar@google.com>
 <CA+GJov6w2GvD8th0t9RW=K1ntHk4dQRuYa4hoDHcmzBDK5YriA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CA+GJov6w2GvD8th0t9RW=K1ntHk4dQRuYa4hoDHcmzBDK5YriA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/20/23 16:31, Rae Moar wrote:
> On Thu, Apr 20, 2023 at 4:57 PM Rae Moar <rmoar@google.com> wrote:
>>
>> Add specification for declaring test metadata to the KTAP v2 spec.
>>
>> The purpose of test metadata is to allow for the declaration of essential
>> testing information in KTAP output. This information includes test
>> names, test configuration info, test attributes, and test files.
>>
>> There have been similar ideas around the idea of test metadata such as test
>> prefixes and test name lines. However, I propose this specification as an
>> overall fix for these issues.
>>
>> These test metadata lines are a form of diagnostic lines with the
>> format: "# <metadata_type>: <data>". As a type of diagnostic line, test
>> metadata lines are compliant with KTAP v1, which will help to not
>> interfere too much with current parsers.
>>
>> Specifically the "# Subtest:" line is derived from the TAP 14 spec:
>> https://testanything.org/tap-version-14-specification.html.
>>
>> The proposed location for test metadata is in the test header, between the
>> version line and the test plan line. Note including diagnostic lines in
>> the test header is a depature from KTAP v1.
>>
>> This location provides two main benefits:
>>
>> First, metadata will be printed prior to when subtests are run. Then if a
>> test fails, test metadata can help discern which test is causing the issue
>> and potentially why.
>>
>> Second, this location ensures that the lines will not be accidentally
>> parsed as a subtest's diagnostic lines because the lines are bordered by
>> the version line and plan line.
>>
>> Here is an example of test metadata:
>>
>>  KTAP version 2
>>  # Config: CONFIG_TEST=y
>>  1..1
>>      KTAP version 2
>>      # Subtest: test_suite
>>      # File: /sys/kernel/...
>>      # Attributes: slow
>>      # Other: example_test
>>      1..2
>>      ok 1 test_1
>>      ok 2 test_2
>>  ok 1 test_suite
> 
> Hi everyone!
> 
> I have been doing some more thinking on KTAP Metadata as I have been
> working on the KUnit Test Attributes patch set
> (https://lore.kernel.org/all/20230719222338.259684-1-rmoar@google.com/).
> Two additional ideas have come up in the discussion:
> 
> 1) I wonder if it would be easier to separate "ktap_attributes" into
> individual attributes.
> 
> The two proposed KUnit attributes currently are speed and module name.
> I think it would be easier for parsing and reading if these attributes
> had corresponding "ktap_speed" and "ktap_module" categories. Then, in
> the future if there are too many attributes to print on separate lines
> they could be grouped into a "ktap_attributes" category later.

I am fine with the above.  This basically removes the special case of
"attribute", and what we have been calling attributes are now metadata,
just like any other metadata.

> 
> 2) I wonder if we can shift the concept of KTAP metadata to all tests
> rather than just suites.
> 
> I think it would be very valuable to have a KTAP metadata format that
> is flexible to work for both suites and test cases. To transition this
> to test cases, I propose we would use the same format we have been
> discussing but just printed just before the test result line (David
> Gow originally came up with this idea). This would look something like
> this:
> 
> KTAP version 2
> # ktap_config: CONFIG_TEST=y
> 1..1
>     KTAP version 2
>     # ktap_test: test_suite
>     # ktap_module: example
>     1..2
>     ok 1 test_1
>     # ktap_test: test_2
>     # ktap_speed: slow
>     # test initializing   // diagnostic data
>     ok 2 test_2
> ok 1 test_suite

That is the way I would expect metadata to exist.  I think I had implicitly
expected test metadata and suite metadata to be of the same format.

It seems to me that "suite" is more a kunit concept than a KTAP concept.
The kunit suite naturally maps into the top level KTAP test, but I don't
think that KTAP should use the term "suite".

> 
> I don't love using the "ktap_test: test_2" line since the test name is
> repeated. However, I like that this mirrors the same format used for a
> suite and I currently think it is the best way to define the start of
> the metadata header.
> 
> The test name line could actually be useful by providing context for
> any test diagnostic data printed below or if the test crashes while
> running.
> 
> What do people think of these ideas?

Sounds good to me.

-Frank

> 
> Thanks!
> -Rae
> 
>>
>> Here is a link to a version of the KUnit parser that is able to parse test
>> metadata lines for KTAP version 2. Note this includes test metadata
>> lines for the main level of KTAP.
>>
>> Link: https://kunit-review.googlesource.com/c/linux/+/5809
>>
>> Signed-off-by: Rae Moar <rmoar@google.com>
>> ---
>>
>> Hi everyone,
>>
>> I would like to use this proposal similar to an RFC to gather ideas on the
>> topic of test metadata. Let me know what you think.
>>
>> I am also interested in brainstorming a list of recognized metadata types.
>> Providing recognized metadata types would be helpful in parsing and
>> displaying test metadata in a useful way.
>>
>> Current ideas:
>> - "# Subtest: <test_name>" to indicate test name (name must match
>>   corresponding result line)
>> - "# Attributes: <attributes list>" to indicate test attributes (list
>>   separated by commas)
>> - "# File: <file_path>" to indicate file used in testing
>>
>> Any other ideas?
>>
>> Note this proposal replaces two of my previous proposals: "ktap_v2: add
>> recognized test name line" and "ktap_v2: allow prefix to KTAP lines."
>>
>> Thanks!
>> -Rae
>>
>> Note: this patch is based on Frank's ktap_spec_version_2 branch.

