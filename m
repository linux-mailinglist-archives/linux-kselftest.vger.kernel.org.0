Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E771B4AA4F8
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Feb 2022 01:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378709AbiBEASy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Feb 2022 19:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbiBEASy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Feb 2022 19:18:54 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E64DF8E3C5;
        Fri,  4 Feb 2022 16:18:50 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id h16so6653206qvk.10;
        Fri, 04 Feb 2022 16:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nmejbh1RBKre2hF7oC5hTBCKyTObSijs5IocDnVuKr4=;
        b=XCTKOxvx7O/V1P6TedFl6JylGVYJO3uoby6HysnF01b//98X1UpqzdcTZA97fd/qHU
         6wuT+EqFXuc0e3gS2IkFNdMb4gxZL5p7/4C5Gt4qDQ+WR2mG2BozRae8GYBgv4mGoqbt
         vKRXVSEk+yw6p3PiWHZJ6eCGL/eYiV9i7K9jv6CdT63QORSxTqMPmyb/jV35dlbxqN6u
         hUzTTZ4/Vtn7zSBPof/qQ/2qzLZhP5jk5rmF+U95DUNvGAA9XH7mMdUhaRj1DY0I9iX1
         T0bV971oWbaCC4XFbhZUsPQlHPXt+VPgPGeSjo0VDdgmld/ApgrIyzNjYebBZoErmF8+
         8r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nmejbh1RBKre2hF7oC5hTBCKyTObSijs5IocDnVuKr4=;
        b=US+f3+LrooxwY1gvCJwxZQkjucrLln1XJB2l74WgBCuo7nhEhBPCaXN6kTJbtzKm+J
         lgHiFyg4iEWhrD0FRsfsUpio0kkIjB8qHZcLUlFwr48HI0zbQqSHydJkJvStVIbxkZKO
         +WUIsA5E6dj9z+4Hhb1RH//oR4rgc7iTAdGPry3FQfI/BpSE5CSIn5MUfuq54y28oP75
         YWbucPXeBnTk6/uTY4+lpGdSmIpTmiQw+plVFTLuLSTJ6q7FLP5thxJADkBz361ZakZz
         o7vQ0wibi5zR9uJmoKwuWHJeZqtt8VECSa440c4IaAG/F9d1DjhTQRazNmr49n9nBoyS
         vlww==
X-Gm-Message-State: AOAM532tjMEgNyG5yi5DITJJnxZvwDNu2IdLixXqdBI58R6diQ3zRlxn
        ProvtCBetBVCSZ4Y/MgnKmE=
X-Google-Smtp-Source: ABdhPJzalLgvOfSb8O0zy4tqjkI9tepJHrRZAPvxQ1TXzVbI/y0jwGNlTAxekb2Xg6er1eguqRHY4Q==
X-Received: by 2002:ad4:5b85:: with SMTP id 5mr3820273qvp.1.1644020329113;
        Fri, 04 Feb 2022 16:18:49 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id u17sm1885032qki.12.2022.02.04.16.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 16:18:48 -0800 (PST)
Subject: Re: [PATCH 1/1] Documentation: dev-tools: clarify KTAP specification
 wording
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Daniel Latypov <dlatypov@google.com>, kernelci@groups.io,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220204203248.2981902-1-frowand.list@gmail.com>
 <CABVgOS=JUxV6PRUZvTQhisSP+p34+K9Z6yT7HkXu6qeqtak1tw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f4317040-df10-02cb-90bb-59f993de1e41@gmail.com>
Date:   Fri, 4 Feb 2022 18:18:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABVgOS=JUxV6PRUZvTQhisSP+p34+K9Z6yT7HkXu6qeqtak1tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/4/22 5:13 PM, David Gow wrote:
> On Sat, Feb 5, 2022 at 4:32 AM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Clarify some confusing phrasing.
> 
> Thanks for this! A few comments below:
> 
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> One item that may result in bikeshedding is that I added the spec
>> version to the title line.
> 
> This is fine by me.
> 
>>
>>  Documentation/dev-tools/ktap.rst | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
>> index 878530cb9c27..3b7a26816930 100644
>> --- a/Documentation/dev-tools/ktap.rst
>> +++ b/Documentation/dev-tools/ktap.rst
>> @@ -1,8 +1,8 @@
>>  .. SPDX-License-Identifier: GPL-2.0
>>
>> -========================================
>> -The Kernel Test Anything Protocol (KTAP)
>> -========================================
>> +===================================================
>> +The Kernel Test Anything Protocol (KTAP), version 1
>> +===================================================
>>
>>  TAP, or the Test Anything Protocol is a format for specifying test results used
>>  by a number of projects. It's website and specification are found at this `link
>> @@ -186,7 +186,7 @@ starting with another KTAP version line and test plan, and end with the overall
>>  result. If one of the subtests fail, for example, the parent test should also
>>  fail.
>>
>> -Additionally, all result lines in a subtest should be indented. One level of
>> +Additionally, all lines in a subtest should be indented. One level of
> 
> The original reason for this is to accommodate "unknown" lines which
> were not generated by the test itself (e.g, a KASAN report or BUG or
> something). These are awkward, as sometimes they're a useful thing to
> have as part of the test result, and sometimes they're unrelated spam.
> (Additionally, I think kselftest will indent these, as it indents the
> full results in a separate pass afterwards, but KUnit won't, as the
> level of nesting is done during printing.)
> 
> Personally, I'd rather leave this as is, or perhaps call out "unknown"
> lines explicitly, e.g:
> Additionally, all lines in a subtest (except for 'unknown' lines)
> should be indented...

Only listing result lines as being indented is not consistent with
the "Example KTAP output" section.  The example shows:

   Version line           - indented
   Plan line              - indented
   Test case result lines - indented
   Diagnostic lines       - indented
   Unknown lines          - not shown in the example

So there seem to be at least 4 types of lines that are indented for a
nested test.

The TAP standard (I'll use version 14 for my examples) does not allow
unknown lines (TAP 14 calls them "Anything else").  It says "is
incorrect", and "When the `pragma +strict` is enabled, incorrect test
lines SHOULD result in the test set being a failure, ...".  TAP 14
calls for the opposite behavior if `pragma -strict` is set.

TAP 14 goes on to say "`Test::Harness` silently ignores incorrect lines,
but will become more stringent in the futures.

It seems to me that KTAP "Unknown lines" are fundamentally different
than TAP 14 "Anything else" lines.  Tests that generate KTAP output
may print their results to the system console (or log), in which
case kernel messages (or for the system log the messages may even
come from non-kernel sources) either directly triggered by a test or
from a task that is totally unrelated to the test may exist in the KTAP
data stream.  So I would agree that "Unknown lines" are not indented.
Even if the "Unknown line" is directly triggered by the test.

But I think the KTAP specification should say that "Diagnostic lines"
are emitted by the test (or the test harness), and thus must be
indented when related to a nested test.

And as you suggest, "Unknown lines" should be explicitly called out
as not being part of "lines in a subtest", thus do not need to be
indented.

Does that sound good?

> 
> Thoughts?
> 
>>  indentation is two spaces: "  ". The indentation should begin at the version
>>  line and should end before the parent test's result line.
>>
>> @@ -225,8 +225,8 @@ Major differences between TAP and KTAP
>>  --------------------------------------
>>
>>  Note the major differences between the TAP and KTAP specification:
>> -- yaml and json are not recommended in diagnostic messages
>> -- TODO directive not recognized
>> +- yaml and json are not recommended in KTAP diagnostic messages
>> +- TODO directive not recognized in KTAP
>>  - KTAP allows for an arbitrary number of tests to be nested
>>
> 
> Looks good here, cheers.
> 
> 
>>  The TAP14 specification does permit nested tests, but instead of using another
>> --
>> Frank Rowand <frank.rowand@sony.com>
>>

