Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A823252454F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 08:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350084AbiELGB1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 02:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350077AbiELGBZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 02:01:25 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65E63526;
        Wed, 11 May 2022 23:01:24 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f4so4280292iov.2;
        Wed, 11 May 2022 23:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dWyTlHyyfHbgbcv0DMpMzKT3vKtsWnNY+EbcTyhIowU=;
        b=QC8rU/RuM9vXqK/ROj03DV9pCP3E+5LxBML4F307tISgrHBivPfyel0yMat1ihR6WK
         a/ZZIBMXWRZV4yXcULDm2NmULBfeqQMyPyqKtUQqLkZPCxWtXm9YCwP2GygtWo7pIaYN
         XVVEpziptK+BrtzcuVNvP2I6n7lAHcjD66VbsnpJk33CkAwNGgR8pIQyX9taqFUv72vP
         XiUBY4shk1LBrowDUvrQtnxWqssDCYreGU4qYrKWPcH2uMP7TbavYU222NgbLKG/kmOr
         IfkUUjBNHOJ4y/AIjXksjTdFyPbddzLTEsRk6mDvQvJbwp8tvC5efZUoyq/8R3LjkGld
         wvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dWyTlHyyfHbgbcv0DMpMzKT3vKtsWnNY+EbcTyhIowU=;
        b=nIzkQgPxCLvL79uKAgeg6AbI/XW3L5kZKO+Ve9a2dOAJzdhlilAzrVBsiSd7ODfwFz
         FOwBkFa+6tz756dFWy7uyQI0XwilTcNw0+zX7RMxJ3CLgywhMe6+M7X5/Pqk/AT9k0+X
         NQD2qJ8DhtxT8cD4kyI8yapW+maoXtIEmB9/fiXifzUfs8bxbPqeRPye+5EF5m1wNSGu
         8hoU9PBhDpmONCBQgz+c46gokBEF3HHVS1huP6nD/yfWbK19KPcIfeQinsFSC0d9Eu1P
         ZmUcR2j7L6J99Vg1PkY6Pkza28TQmkAFMQ/M2Qet9T91xav1oBXlOT1JWV/IIkRASsDy
         l0cw==
X-Gm-Message-State: AOAM530/fiWoFUZ0s5TzeJwqEIO1qYq7QroOGkBm6pZJmKhw4SBAuNxn
        P81umobcf1F4tf0y9B+cR8k=
X-Google-Smtp-Source: ABdhPJxHUPVVRo8CdXItz2eTbnQeIh/VzXheDLdTgs5VPNcA2TOypssIBDqGRkGc8xEOGbdybabOWw==
X-Received: by 2002:a6b:6117:0:b0:657:b471:a49f with SMTP id v23-20020a6b6117000000b00657b471a49fmr12857305iob.77.1652335284287;
        Wed, 11 May 2022 23:01:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:fdf4:a10e:cb39:9b64? ([2600:1700:2442:6db0:fdf4:a10e:cb39:9b64])
        by smtp.gmail.com with ESMTPSA id p19-20020a02b393000000b0032b3a781767sm1148074jan.43.2022.05.11.23.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 23:01:23 -0700 (PDT)
Message-ID: <5ca35c47-6145-4ec1-6c05-3c46f436cb4d@gmail.com>
Date:   Thu, 12 May 2022 01:01:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] KTAP spec v2: prefix to KTAP data
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/12/22 00:59, Frank Rowand wrote:
> In the middle of the "RFC - kernel test result specification (KTAP)" thread,
> started in August 2021, Tim Bird made a suggestion to allow a prefix to the
> KTAP data format:
> 
>> Just as a side note, in some Fuego tests, it was very useful to include an identifier
>> in thethe prefix nested tests.  The output looked like this:
>>
>> TAP version 13
>> 1..2
>> [batch_id 4] TAP version 13
>> [batch_id 4] 1..2
>> [batch_id 4] ok 1 - cyclictest with 1000 cycles
>> [batch_id 4] # problem setting CLOCK_REALTIME
>> [batch_id 4] not ok 2 - cyclictest with CLOCK_REALTIME
>> not ok 1 - check realtime
>> [batch_id 4] TAP version 13
>> [batch_id 4] 1..1
>> [batch_id 4] ok 1 - IOZone read/write 4k blocks
>> ok 2 - check I/O performance
>>
>> Can I propose that the prefix not be fixed by the spec, but that the spec indicates that
>> whatever the prefix is on the TAP version line, that prefix must be used with the output for
>> all lines from the test (with the exception of unknown lines)?
> 
> The thread was discussing many other items, but this is the one that I want
> to focus on in this new RFC thread.
> 
> Tim's original email was:
> 
>    https://lore.kernel.org/r/BYAPR13MB2503A4B79074D8ED5579345DFDCB9@BYAPR13MB2503.namprd13.prod.outlook.com
> 
> There was one reply to this that commented on Tim's suggestion (and also many
> other items in the thread) at:
> 
>    https://lore.kernel.org/r/202108301226.800F3D6D4@keescook
> 
>> Oh, interesting. This would also allow parallel (unique) test execution
>> to be parsable. That sounds workable. (Again, this needs LAVA patching
>> again...)
> 
> I found Tim's original suggestion to be useful, so I have come up with
> two possible ways to modify the KTAP specification to implement what Tim
> was thinking about.  I would not be surprised if someone else has a better
> suggestion than mine, but I will reply to this email with my two alternatives
> to start a discussion.  My alternatives are not in the form of patches, but
> if discussion leads to a good result then I will create a patch for review.
> 
> -Frank

================================================================================
Alternative 1
   - Add an optional <prefix string> to test output.
================================================================================
## <prefix string>

If the optional [<prefix string>] is present for any line of the KTAP formatted
output, then it must be present for all lines of the KTAP formatted output
(except for "Diagnostic lines", are allowed to not be prefixed with
<prefix string>, as described below).

The "Version lines" format is changed from:

   KTAP version 1

to:

   [<prefix string>] KTAP version 1

The "Plan lines" format is changed from:

   "1..N"

to:

   [<prefix string>] "1..N"

The "Test case result lines" format is changed from:

   <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]

to:

   [<prefix string>] <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]


   <prefix content is a constant string>

   All subsequent test lines are prefixed with the <prefix string>.

   Indentation for "Nested tests" follows <prefix string>.  The indentation
   does NOT precede <prefix string>.

   "Diagnostic lines" are prefixed with the <prefix string>.

   "Unknown lines" may optionally be prefixed with the <prefix string>, but
   are not required to be prefixed with the <prefix string>.  It is allowed
   for some "Unknown lines" to not be prefixed with the <prefix string>, even
   if one or more other "Unknown lines" are prefixed with the <prefix string>.


================================================================================
#### discussion notes:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PRO: minimally invasive to specification.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
CON:

KTAP does not include any mechanism to describe the value of <prefix string>
to test harnesses and test output processing programs.  The test output
processing programs must infer the value of <prefix string> by detecting
the <prefix string> in the "Version lines".

The detection of a "Version lines" might be a match of the regex:

   "^.*KTAP version 2$"

This risks falsely detecting a "Version lines", but the risk is small???

The impact of falsely detecting a "Version lines" may be large if the
beginning of test detection is a state machine that moves into a "detect
either Plan lines or Test case result lines" after falsely detecting a
"Version lines".  The impact may be small if the state maching instead
moves into a "detect Version lines, Plan lines, or Test case result lines".


================================================================================

