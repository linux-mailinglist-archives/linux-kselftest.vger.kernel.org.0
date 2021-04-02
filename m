Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF84F352FC6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 21:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbhDBTbW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 15:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBTbU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 15:31:20 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BA4C0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 12:31:19 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k25so6278953iob.6
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ZsTSai2xloiVtA0UuM7lgfymSzT+xeULqDLkqQxO1Q=;
        b=R9W5aaLJd1+ic4GJqwXPY/w6fu7NdzXyyGcr1e1jlS3/rc7dGI0cpKLDCtaimfbzVZ
         zH2J+C/XtYlMRx0DF+OgPKZnK93OMeDc6P6Hv6ZNs60Ufu9mdhaTMl3ApzHXzre3oYbd
         3wdS6aSAZURN3IJvUTaC4Tu1lqCGU+SWOjmlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ZsTSai2xloiVtA0UuM7lgfymSzT+xeULqDLkqQxO1Q=;
        b=IcrNPYQQzureNw0dSEPogMzChnD1gVmYBWL5hLpr/s56VsivkZ502XfMUUefrbYjRz
         i2Fr+FYDcxzEjTDVncoF0OoorPlLjKNo70wF/sNZqBgfnw8/XOGBtOxOD6Ojxx87awrk
         5bYiYiPta8WsnzzxCSmr1vi2htS/8mq0RnQlDwuaMg7A58+D50A1VPzBplt+14VI5rgc
         43PxfFdf7mRIqhuXFPEyM71NGHYNHcqtNXYtA+cGrtyEBVeEvpkD4mM86LpzU8OthOTV
         KnOrE2xIVx+D/ceKfk8nOhBEdbfhMN/YkQYHxwgUwCk5tnUYVcegQAJTd8I31NbMeZxB
         RFJg==
X-Gm-Message-State: AOAM533Vfn4oMICTy3UvufFsL2WI6FRh5pBve+CkQFKCG+PlrgJxcKiJ
        xr201wJRi0CtoyiNfSTgqRvsDg==
X-Google-Smtp-Source: ABdhPJxPGiq3cJR5VwLcEF/cj9XqcAdvpdgho5uBhDIM//kUBXWbXaqAGlU3h861KxwBvDP7c7w32w==
X-Received: by 2002:a05:6602:280f:: with SMTP id d15mr11705250ioe.127.1617391878792;
        Fri, 02 Apr 2021 12:31:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t9sm2877122ilp.65.2021.04.02.12.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 12:31:18 -0700 (PDT)
Subject: Re: [PATCH] kunit: tool: make --kunitconfig accept dirs, add
 lib/kunit fragment
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210222225241.201145-1-dlatypov@google.com>
 <20210402093228.755260-1-brendanhiggins@google.com>
 <38510e93-843c-b0e0-5ad5-4953660de79b@linuxfoundation.org>
 <CAGS_qxqoXhZo6hV_1BsqrpXBJTuBhXERUnW75U6aCtS382aNjg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <97706798-cf13-a21f-fdbf-5cecd9f7d6d0@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 13:31:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAGS_qxqoXhZo6hV_1BsqrpXBJTuBhXERUnW75U6aCtS382aNjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/2/21 1:27 PM, Daniel Latypov wrote:
> On Fri, Apr 2, 2021 at 11:00 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 4/2/21 3:32 AM, Brendan Higgins wrote:
>>>> TL;DR
>>>> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit
>>>>
>>>> Per suggestion from Ted [1], we can reduce the amount of typing by
>>>> assuming a convention that these files are named '.kunitconfig'.
>>>>
>>>> In the case of [1], we now have
>>>> $ ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4
>>>>
>>>> Also add in such a fragment for kunit itself so we can give that as an
>>>> example more close to home (and thus less likely to be accidentally
>>>> broken).
>>>>
>>>> [1] https://lore.kernel.org/linux-ext4/YCNF4yP1dB97zzwD@mit.edu/
>>>>
>>>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
>>>
>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>
>>
>> Should this be captured in  documentation. Especially since this
>> is file is .* file.
>>
>> Do you want to include doc in this patch? Might be better that way.
> 
> It definitely should be documented, yes.
> The only real example hadn't landed yet when I sent this patch
> (fs/ext4/.kunitconfig was going in through the ext4 tree), but now
> it's in linus/master.
> 
> There's still some uncertainties about what best practices for this
> feature should be, i.e.
> * how granular should these be?
> * how should configs in parent dirs be handled? Should they be
> supersets of all the subdirs?
>      * E.g. should fs/.kunitconfig be a superset of
> fs/ext4/.kunitconfig and any other hypothetical subdir configs?
>      * Should we wait on saying "you should do this" until we have
> "import" statements/other mechanisms to make this less manual?
> * how should we handle non-UML tests, like the KASAN tests?
>    * ideally, kunit.py run will eventually support running tests on x86
> (using qemu)
> 
> If it's fine with you, I was hoping to come back and add a section to
> kunit/start.rst when we've had some of those questions more figured
> out.
> 

Sound good. I will apply this patch and you can document later.

thanks,
-- Shuah
