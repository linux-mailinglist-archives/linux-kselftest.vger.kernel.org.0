Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6D13F3955
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 09:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhHUHf6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Aug 2021 03:35:58 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:37567 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhHUHf6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Aug 2021 03:35:58 -0400
Received: by mail-lf1-f51.google.com with SMTP id k5so25553150lfu.4;
        Sat, 21 Aug 2021 00:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vdHlO3IeLiJjFFMfG6tQBlWyGHv5/0nFaPMZOieo2Bg=;
        b=ZILHN8DBXzoAmV2qHEntuuWX6ysQSqe8P3Ti/LxSOc3pNWQ+FPpgL7Z0RkZh22NNlc
         nIlqZoXHSZVLi4sHH5bh1Dgf1AKQlYeobj7F1qPaYNEKsWiPA9rkFVPdmkmWYtc2gG2t
         WufaNgM5HUVj44moiAfmQaK2vR6K/iul0pgFDfIl/UNFvXNXw2D040TpwNZRc2k4MM5+
         zIPdxoU11+HSSMidD2QOazghI3mM9kH6ii8/otkqck320leF62LAoiCxPRsjAfYe4qpz
         +PBKJWwTPhsZkTPAwO5O8g6aPcOxQBOf1/eYTnrxPugT8/taj2YlZ73Pmeb3DfO76rcm
         3gxA==
X-Gm-Message-State: AOAM530+J7ZZuxMSuu+P3WVbhyTtV7+YzQ6H9wXVu00CC5xI6L4dbiWA
        j8lafMqOqzrGgt3HMR6h6Vc=
X-Google-Smtp-Source: ABdhPJyuB/PY35kDip9ACjk8D40JWPwyW94eK4gjhZVKbrL7BCz34zBXdXoaCDPvkZrs3z2IVk7nfA==
X-Received: by 2002:a19:dc5e:: with SMTP id f30mr17990075lfj.318.1629531318070;
        Sat, 21 Aug 2021 00:35:18 -0700 (PDT)
Received: from [192.168.1.109] ([213.87.152.233])
        by smtp.gmail.com with ESMTPSA id d24sm730743ljj.8.2021.08.21.00.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 00:35:17 -0700 (PDT)
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
To:     Joe Perches <joe@perches.com>, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
References: <20210818154646.925351-1-efremov@linux.com>
 <20210818154646.925351-2-efremov@linux.com>
 <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
 <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
 <23c8ebaa0921d5597df9fc1d6cbbcc4f354f80c5.camel@perches.com>
 <c31b2007-26a9-34e0-8c9a-8e11a00ce69f@linux.com>
 <ac2587d3d4b7ce87e8922380e36d7864bfb54262.camel@perches.com>
 <7eda27d1-9e9f-dfd6-3a54-6c592a797ea5@linux.com>
 <4bf2c7360206025731928fa1c8ad95faa9e65ab8.camel@perches.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <17ee07ea-d768-0099-cad7-43b5b5c75560@linux.com>
Date:   Sat, 21 Aug 2021 10:35:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4bf2c7360206025731928fa1c8ad95faa9e65ab8.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/21/21 10:12 AM, Joe Perches wrote:
> On Sat, 2021-08-21 at 09:47 +0300, Denis Efremov wrote:
>>
>> On 8/20/21 1:17 AM, Joe Perches wrote:
>>>
>>> And I'm not sure if this particular ERROR is that useful overall.
>>
>> I find it useful to check commit-id and that it matches a title.
>> It's easy to make a typo in commit-id and get an invalid one.
> 
> That's true, but I meant requiring the sha1 hash to contain both
> the word "commit" and use ("title").
> 
> Looking at checkpatch's errors produced by this GIT_COMMIT_ID
> test makes the required form seem a bit too inflexible to me.
> 
> For instance: a sha1 hash may be repeated in a commit message where
> the first instance has the correct form but the second use is just
> the hash and the warning is still produced.
> 

I agree with you. There is also another example with list of commits:
 - commit <id-1> ("Title1")
 - commit <id-2> ("Title2")
...

I see no reason in writing "commit" on each line.

