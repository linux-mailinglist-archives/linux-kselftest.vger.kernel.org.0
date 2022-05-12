Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054A7524552
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 08:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350077AbiELGCQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 02:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbiELGCP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 02:02:15 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BB566208;
        Wed, 11 May 2022 23:02:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f4so4282082iov.2;
        Wed, 11 May 2022 23:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XF/xFPtLmhC4ZgohYR62Nv8OLeVFzEOKNGwxgGsfdL8=;
        b=YBd3ZIb1+jo23ypuHUppLf4wj5jZxNXzmo93O9MtoVI7vfDLlfJhIh+HGz78IxfHS6
         YKcD1+1bt7PfBOSIum2q0bGEm0UMULPNdEqkV/4R45z3tGbqzfDCs/4UV9qhQk0AgSdQ
         hmmgE4cwggI8WBXURuFFTxK+LQrm7kPJFYlvbWXHrIK4ECZ/E3Hp0UkHt98gU9BGC/bd
         1Lt8qAbhmXY7A72ALbB9SYIo50YU0ahhNr8PCS9p4AsmWWjVoDz8DToNVhIFA0lkQ38c
         cwuz2NZmjO2bgL5xx4XH1f50L+jSMt9VRA1cnYN3zRM9kGTEbpHWgc84jjj5OJ85U/ZD
         micQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XF/xFPtLmhC4ZgohYR62Nv8OLeVFzEOKNGwxgGsfdL8=;
        b=Kph7Zh6SM/mk4s38ktCa02oFS3IZfRJU8rY02EdJZ5Ko1/XUyyJbf4dW1O7yTmVHU0
         ntC6jXnBI5pk7IwTPDcnowQ5hMEwA93D/XrHZfgD8Ng54qwS41xx5xv/tlpZ1TBg2TYK
         AMQPaq1RU/khV+xHCPWB8XWekDqtYq8/Z6BVDZgFXmQcYpUk0ltbfxWaBJKmZwZvZuB0
         FzKLBvCOxQZAOPU6Hsb62AMwwBXbNaL8C0tKhGqVuXVnuQW/9pG2rOYCEcCywMtfA1oJ
         kLy2sJeMvwOciXRIZ8mOUpR7XzmabDqOhfznW3CRmH+eV2yVGiWrRjT/dWwDJWSIRHjm
         JaaQ==
X-Gm-Message-State: AOAM533irUAd/BUx3TmtbuwG4bemXR3fqV8HKPatQriJYIqU81xBqajv
        2tR0XT5SnwzY048xN0lBeKw=
X-Google-Smtp-Source: ABdhPJwYp1zTu4Y0ygbGlCVlf7igw2pMEJCGyZlXuTWZffrmszeMkZlVNgn+J3dXbNh6l5bAlYN+GQ==
X-Received: by 2002:a05:6638:d4b:b0:32b:ece6:a56f with SMTP id d11-20020a0566380d4b00b0032bece6a56fmr10734448jak.315.1652335334066;
        Wed, 11 May 2022 23:02:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:fdf4:a10e:cb39:9b64? ([2600:1700:2442:6db0:fdf4:a10e:cb39:9b64])
        by smtp.gmail.com with ESMTPSA id x11-20020a92dc4b000000b002cde6e352d4sm1175261ilq.30.2022.05.11.23.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 23:02:13 -0700 (PDT)
Message-ID: <1c89133e-7bd2-862a-bd57-7fefdffb77ae@gmail.com>
Date:   Thu, 12 May 2022 01:02:11 -0500
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
Alternative 2
   - Add an optional <prefix string> to test output.
   - Add "Configuration info lines", which are used to provide information
     about the KTAP format to programs that interpret the KTAP data.  The
     only type of "Configuration info lines" proposed provides the value
     of <prefix string> for programs that process the KTAP output.
   - Further types of "Configuration info lines" could be added.

Alternative 2b
   - Add an optional <prefix string> to test output.
   - Add a <prefix string> definition line of the form:
        ok 0 <prefix string>
     This line is essentially a phony "Test case result lines" for test 0.

================================================================================
## Configuration info lines

Occur in zero or more test case result lines, where <number> is 0 (zero),
following the "Plan line", before any other "Test case result" line.

   If there is no "Plan line" at the beginning of the test, then the
   "Configuration info lines" follow the "Version line", before any
   other "Test case result" line.

format:

   ok 0 <description> # [<directive>] [<diagnostic data>]]

<result> must be "ok".

The type of each "Configuration info line" is defined by the value
of <description>.

Each value of <description> used for a "Configuration info line" must be
listed in the specification.

Whether # <directive> is optional or required is defined for each type of
"Configuration info line".

#### Should '[<diagnostic data>]' be included in the format?


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# [output] prefix

ok 0 output_prefix #<prefix string>

   <prefix content is a constant string>
   Note: there is no space between "#" and "<prefix string>".  If there is one
   or more spaces after the "#", then there are part of the <prefix string>

   ## <diagnostic data> must not exist unless there is a way to determine the
   ## end of <prefix string>.
   ##
   ## Adding a way to determine the end of <prefix string> adds much complexity
   ## to the consumers of ktap output.  For example, if the format was:
   ##
   ##   ok 0 output_prefix #<prefix string>[#<diagnostic data>]
   ##
   ## then it is not possible for <prefix string> to contain '#', unless
   ## a method to escape '#' is provided.  E.G.:
   ##
   ##   ok 0 output_prefix #XXX test result \#\#\##<diagnostic data>
   ##
   ## would result in <prefix string> value of 'XXX test result ###'
   ##
   ## My recomendation: do not allow <diagnostic data> in output_prefix format.

   All subsequent test lines are prefixed with the <prefix string>.

   Indentation for "Nested tests" follows <prefix string>.  The indentation
   does NOT precede <prefix string>.

   "Diagnostic lines" are prefixed with the <prefix string>.

   "Unknown lines" may optionally be prefixed with the <prefix string>, but
   are not required to be prefixed with the <prefix string>.  It is allowed
   for some "Unknown lines" to not be prefixed with the <prefix string>, even
   if one or more other "Unknown lines" are prefixed with the <prefix string>.

   #### Does prefixing begin immediately (even for a subsequent "Configuration
   #### info line" or does it begin with the test 1 "Test case result line"
   #### line?
   ####
   ####    This question might be simplified if the output_prefix line is
   ####    required to be the last "Configuration info line".  (Or maybe even if
   ####    required to be the first "Configuration info line".


================================================================================
#### discussion notes:

PRO:
   Test output processing programs can detect the value of <prefix string>
   more deterministically than Alternative 1.

CON:
   More complex than Alternative 1.  (But alternative 2b is less complex than
   Alternative 2.)

================================================================================

