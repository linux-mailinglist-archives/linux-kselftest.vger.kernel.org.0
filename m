Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5F550C539
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Apr 2022 01:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiDVXcP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 19:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiDVXbw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 19:31:52 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71D41D92D4;
        Fri, 22 Apr 2022 16:10:41 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id x20so7157097qvl.10;
        Fri, 22 Apr 2022 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aoICAI9/Bl4AX+BWm7cH1yLO17nxdNcynLM1mxiKj24=;
        b=FDMCQ91VyoUpXjChH8PCm1ByG5YeMcRbD3Nq3XS/A7yJu3gI6Pjb/925KdVtmuV+uT
         ryXDUcNHBrqOE1RmhgvJ1CjVa3kg/yNTHPC518BX1ez4zbiNT484v9Q5AkrDGgXGOG6i
         hnenZW0yGZnydsTrRtr1ilzpdhsvfFNjMTDDROs75BxuSLuFwbxtujIUa0bjIibgOo3Z
         p+xZZhduHmsoGqZIrggSpRhUXE/GeQJhMMFJD0X7E69siGiG2a3UqD3kQ4T3EdQxakFe
         Y7eVcJnrRpNvz8n3epO3/WgE+ftfVGLrdtqijBWF7mEkls8AJSBf4J8Tvp7su26XGYuR
         EGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aoICAI9/Bl4AX+BWm7cH1yLO17nxdNcynLM1mxiKj24=;
        b=JPFHSG8g/jKrIHlRUKsBjpm2+fF2SSl2yf8RwwlaBABD7YUHF+Op5Pcim5arvn9kAA
         BsLw05dEijpgJp0xSCpAAG4vaxj460m78ueP1iUkmr/shG/p8rMq3r8XAd1ruUxBRIwf
         cSB2aSLNancy9V1u0h2BVHdqaXo3R5KNN54vSqCg74NTSgy/mQDrRj4TOEYamde75b7g
         +BAawtJEZpuxIUrrydhL9PHRE6cms5j/ViZlW2dr7r8L7WmQwYwY1Icb9fjC99KRSPDK
         UerQHq+Nbz9vv0zyZD3eQlKvDgLxxH4zVpHRInujYbDMpKBQRpq8WkACoKW+DLriI6/J
         OeDg==
X-Gm-Message-State: AOAM531WfIvjz8c8mJ64qwa4DPINiJg9OIbqqU1Kh3vEi4T0K2dBxcCw
        DC1nnnxhgZumJH2VNpavxok=
X-Google-Smtp-Source: ABdhPJzav8sT9TWnhNXns8IrZa1IG5AZwcniTTDuvasNMCEKJoV1Mgl8DxW8at2ghxApi6HIy3n1YQ==
X-Received: by 2002:a05:6214:248c:b0:441:2a61:659d with SMTP id gi12-20020a056214248c00b004412a61659dmr5548580qvb.59.1650669041020;
        Fri, 22 Apr 2022 16:10:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:98a4:ff1d:3bb2:5350? ([2600:1700:2442:6db0:98a4:ff1d:3bb2:5350])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b0067d47fb5aa4sm1495672qko.63.2022.04.22.16.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 16:10:40 -0700 (PDT)
Message-ID: <95dcdcd3-fb48-6e5c-3262-7aacaac71e78@gmail.com>
Date:   Fri, 22 Apr 2022 18:10:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 2/2] Documentation: dev-tools: use literal block
 instead of code-block
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
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
References: <20220316202622.324866-1-frowand.list@gmail.com>
 <20220316202622.324866-3-frowand.list@gmail.com>
 <CABVgOSngfB41BVoEvQ1JX+2oFvS7Mik58VfPm9pydmiC_GSD6Q@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CABVgOSngfB41BVoEvQ1JX+2oFvS7Mik58VfPm9pydmiC_GSD6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jon,

On 3/17/22 03:43, David Gow wrote:
> On Thu, Mar 17, 2022 at 4:26 AM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> KTAP Specification: Change code-block directives to straightforward
>> literal blocks since the blocks do not contain code.
>>
>> Suggested-by: Jonathan Corbet <corbet@lwn.net>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
> 
> This looks good to me.
> 
> I'd personally rather push this through independently of the KTAP 2.0
> spec updates, as it's really just a minor formatting change to the
> spec, and it has no impact on the actual KTAP format.
> 
> So, if we can accept this independently, that'd be swell.
> 
> Reviewed-by: David Gow <davidgow@google.com>

I got distracted with other tasks, just now returning to this.

There has been no other comment in the last month, so I think it
is fair to go ahead and ask you to pull this patch.

Can you pull just this patch (patch 2/2) or would you prefer that
I do a version 2 which does not contain patch 1/2?

-Frank

> 
> Cheers,
> -- David
> 
> 
>>  Documentation/dev-tools/ktap.rst | 18 ++++++++----------
>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
>> index 37b5dc61bfb8..b9a57ceddd4f 100644
>> --- a/Documentation/dev-tools/ktap.rst
>> +++ b/Documentation/dev-tools/ktap.rst
>> @@ -115,34 +115,32 @@ The diagnostic data field is optional, and results which have neither a
>>  directive nor any diagnostic data do not need to include the "#" field
>>  separator.
>>
>> -Example result lines include:
>> -
>> -.. code-block:: none
>> +Example result lines include::
>>
>>         ok 1 test_case_name
>>
>>  The test "test_case_name" passed.
>>
>> -.. code-block:: none
>> +::
>>
>>         not ok 1 test_case_name
>>
>>  The test "test_case_name" failed.
>>
>> -.. code-block:: none
>> +::
>>
>>         ok 1 test # SKIP necessary dependency unavailable
>>
>>  The test "test" was SKIPPED with the diagnostic message "necessary dependency
>>  unavailable".
>>
>> -.. code-block:: none
>> +::
>>
>>         not ok 1 test # TIMEOUT 30 seconds
>>
>>  The test "test" timed out, with diagnostic data "30 seconds".
>>
>> -.. code-block:: none
>> +::
>>
>>         ok 5 check return code # rcode=0
>>
>> @@ -202,7 +200,7 @@ allowed to be either indented or not indented.
>>
>>  An example of a test with two nested subtests:
>>
>> -.. code-block:: none
>> +::
>>
>>         KTAP version 1
>>         1..1
>> @@ -215,7 +213,7 @@ An example of a test with two nested subtests:
>>
>>  An example format with multiple levels of nested testing:
>>
>> -.. code-block:: none
>> +::
>>
>>         KTAP version 1
>>         1..2
>> @@ -250,7 +248,7 @@ nested version line, uses a line of the form
>>
>>  Example KTAP output
>>  --------------------
>> -.. code-block:: none
>> +::
>>
>>         KTAP version 1
>>         1..1
>> --
>> Frank Rowand <frank.rowand@sony.com>
>>

