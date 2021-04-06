Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22B1355DC6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Apr 2021 23:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbhDFVTU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Apr 2021 17:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbhDFVTU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Apr 2021 17:19:20 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A98C06174A
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Apr 2021 14:19:12 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e186so17062542iof.7
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Apr 2021 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t/Gx+NJDxxNQAlNTAP9DklegMCl81qD73OBwwEWu0F0=;
        b=Gqzq4ixtKE/AadMF+KHA+ZBNiLb/80N507ZBcwRHk0PaGK3Qik7UIjXaXHNMLrkYgC
         DmGxoK5mUqBAi8SghgSiFuH/DvqYq0P+CUXfkmgokMCd49T3ap0+QoIafGPvR3bvB6Uz
         teRoAONklLnsZEOmaf69pLY8vtZLr3t6FE78g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t/Gx+NJDxxNQAlNTAP9DklegMCl81qD73OBwwEWu0F0=;
        b=Um9GeRON4cf1DHz3qL2EAtSSHl8rCwS8m/mBhGJvqWJiKm2vjScMn2jaA+Cf8oiy79
         Q/XbX2VHOwTOv7TJoelrSiklpzOBmMP4wpLTPvWhqhsIziVQDmIZ0JbGEhPI5BrkM8zB
         CblQw1wKwAVbx/uv+WOfbuaAJ61GwHzU536ZkTSl7aCr60LtETkAiTQtDWO3wAuoq/eS
         nHbjrLO79J3JnVOGRo5+m9zakv9Pf7a6i6y4tJMyWWonvFzFLn6pKAUM+aWbbRhvoKL7
         Pu6b/PGBloG86iSHVXxYbP4ovVaHEC6PdPGUOBEnsfkp8OeskqCd2Zf0IhLvcSaO4vWu
         TjNQ==
X-Gm-Message-State: AOAM530RKG021QyqhA+ErDmUBxLofzp7GrNx9hgbUnqeFAiu8Wfsf0Nx
        g/L/bOy74dqIAL1Ks+0Tr4zqlg==
X-Google-Smtp-Source: ABdhPJzx++9dkI+upZNJ43iZ0to1iHcCFsNxPKPFqO0vLX7fU7AkSKB3iDqTr+UflBDLRBhFrK7ZlA==
X-Received: by 2002:a5e:8416:: with SMTP id h22mr25368407ioj.119.1617743951799;
        Tue, 06 Apr 2021 14:19:11 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x24sm14064352iob.28.2021.04.06.14.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 14:19:10 -0700 (PDT)
Subject: Re: [PATCH] kunit: fix -Wunused-function warning for
 __kunit_fail_current_test
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210406172901.1729216-1-dlatypov@google.com>
 <CAFd5g472E_Q-CoM2ONNONP_oeGZe0HGpNdqVhyRkKhP74b7h7A@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cc19e30b-469d-6551-1c27-d51003afe90e@linuxfoundation.org>
Date:   Tue, 6 Apr 2021 15:19:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g472E_Q-CoM2ONNONP_oeGZe0HGpNdqVhyRkKhP74b7h7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/6/21 2:50 PM, Brendan Higgins wrote:
> On Tue, Apr 6, 2021 at 10:29 AM Daniel Latypov <dlatypov@google.com> wrote:
>>
>> When CONFIG_KUNIT is not enabled, __kunit_fail_current_test() an empty
>> static function.
>>
>> But GCC complains about unused static functions, *unless* they're static inline.
>> So add inline to make GCC happy.
>>
>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
>> Fixes: 359a376081d4 ("kunit: support failure from dynamic analysis tools")
> 

Signed-off-by comes after Fixes. Also good to add Reported-by for 
Stephen acknowledging the reporter.

I will fix this up when I apply - for future reference.

> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 

thanks,
-- Shuah
