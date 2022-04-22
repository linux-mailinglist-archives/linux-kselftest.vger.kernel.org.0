Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D16850C52F
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Apr 2022 01:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiDVXiu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 19:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiDVXij (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 19:38:39 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71902E6459;
        Fri, 22 Apr 2022 16:25:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id kd22so2312191qvb.4;
        Fri, 22 Apr 2022 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rcdaBhhud9SyNHNY0AAhVKpiP7gID+EH0S68KRDmsGo=;
        b=cl1daFNRCD3e5ffgQ725R7amEwpyE1xVdZ5NGUozsQbs4DgYzyYZwr9MPIuNqNkZ+t
         kFS9d5mX2ptu1vW0KM/xExO22N1uvYB6ISW5Gf2O4FPY4qOYhIjr87geUoaxd0nUifM/
         +8/XYg6gGAlhph7wlWJSXFZX+vE0dTTXAz63XW0UYkRpwPRABlWD43ZafITFmKHyLrva
         k0SBpjCDVuZG5HlTU6E9NgbNG6KVOSys0P1PX8oVhPi5L5dbWztVKRB47JM0/4+gJsmG
         ZrkJLacRQTPvHvLxW6HXLeQVqn7FuSUofP0ZCFDV7yXGf6oWiCmuKc4N1yMKKOdxKxcv
         4voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rcdaBhhud9SyNHNY0AAhVKpiP7gID+EH0S68KRDmsGo=;
        b=1x3KVJwOHUG5ZjyLNvfYOSnp27Toko553FBS3zEOsxGVB0DK5HrHSHp4klVdjfbSea
         GO4MHvS54xRoX7yu1D3D7h5wi1Crb1XYQXb08rRzC5TZ+DF4L0NYUZqk5PQ232fUtO94
         99FupADYQ14NC4wrRt6odffbArd81GPVdrkunSRSjUBF+BU14W0jOf0OQrHyQz2l2pSl
         qE+Igbce2qNXpgL0itfJEyYZpL0hXs+od5KRhNkVTbnpDYhiFJuPj2ix/qfYnmeG9GzA
         bLq06K9tRIeRW57HgK2t2s3r3amd2YwSd8v9lH3nwu/e1DDKOuMovzsxuJMn0s4JHK7X
         9/Lw==
X-Gm-Message-State: AOAM5335thhUSXFNjgZLofYUDj8t5oiLyPe9oQ6MNYXvlZXmQG/iKq++
        SANAYB+ptJaQCPSkFPAF3Jc=
X-Google-Smtp-Source: ABdhPJyEDybsNUkFpLBFTngPCki9AUC4GVSw/pvF00/UmfGceNLNQSnWZzheejDGBi+Vp98KSZtzPw==
X-Received: by 2002:a05:6214:518d:b0:454:6ea7:a179 with SMTP id kl13-20020a056214518d00b004546ea7a179mr2838176qvb.121.1650669950640;
        Fri, 22 Apr 2022 16:25:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:98a4:ff1d:3bb2:5350? ([2600:1700:2442:6db0:98a4:ff1d:3bb2:5350])
        by smtp.gmail.com with ESMTPSA id m9-20020a05622a118900b002f1fc51135dsm2104515qtk.57.2022.04.22.16.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 16:25:50 -0700 (PDT)
Message-ID: <ee73ec15-db6c-e0bb-ddb1-012499d08b11@gmail.com>
Date:   Fri, 22 Apr 2022 18:25:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 1/2] Documentation: dev-tools: KTAP spec change
 version to 2-rc
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
 <20220316202622.324866-2-frowand.list@gmail.com>
 <CABVgOSm_rQcBhbC5C7Z7_+zEheCjkjHCmzKHyx7b5bYLESvA0A@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CABVgOSm_rQcBhbC5C7Z7_+zEheCjkjHCmzKHyx7b5bYLESvA0A@mail.gmail.com>
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

On 3/17/22 03:43, David Gow wrote:
> On Thu, Mar 17, 2022 at 4:26 AM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Prepare KTAP Specification for the process of creating Version 2.
>> The version will remain 2-rc until the final commit to complete
>> Version 2.
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
> 
> This seems okay to me, though I'd generally rather this stay in a
> branch rather than hitting torvalds/master while there aren't any
> substantive changes to the actual spec. (Basically, let's not rush
> naming this "2-rc" for 5.18 if there aren't any other changes: a 2-rc
> which is practically the same as 1 is probably going to be more
> confusing than helpful if it sticks around for a whole kernel release.

Sounds good.  In my reply (a few minutes ago) to your other email, I offer
to host a branch.  The branch approach sounds good to me.

> 
> (Also, when would we want to update the various mentions of "KTAP
> version 1" in the document to "KTAP version 2" or "KTAP version 2-rc"?
> Now, when 2 is released, at the first breaking change to that example,
> etc?)

There are only a few references to version 1.  I can create a patch to change
them to version 2 (other than the version of the document itself).

If we are working on a branch, it should not make a big difference when the
internal uses of "version 1" are changed to "version 2".  If I do it right
away then it won't get overlooked.

-Frank

> 
> Cheers,
> -- David
> 
>>  Documentation/dev-tools/ktap.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
>> index 5ee735c6687f..37b5dc61bfb8 100644
>> --- a/Documentation/dev-tools/ktap.rst
>> +++ b/Documentation/dev-tools/ktap.rst
>> @@ -1,7 +1,7 @@
>>  .. SPDX-License-Identifier: GPL-2.0
>>
>>  ===================================================
>> -The Kernel Test Anything Protocol (KTAP), version 1
>> +The Kernel Test Anything Protocol (KTAP), version 2-rc
>>  ===================================================
> 
> Nit: Sphinx complains that we now need more '=' signs:
> 
> Documentation/dev-tools/ktap.rst:3: WARNING: Title overline too short.
> ===================================================
> 
> 
> The Kernel Test Anything Protocol (KTAP), version 2-rc
> ===================================================
> 
>>
>>  TAP, or the Test Anything Protocol is a format for specifying test results used
>> --
>> Frank Rowand <frank.rowand@sony.com>
>>

