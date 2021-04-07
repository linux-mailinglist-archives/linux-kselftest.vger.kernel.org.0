Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39333577E7
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 00:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhDGWqX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 18:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDGWqV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 18:46:21 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A66C061761
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Apr 2021 15:46:11 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id m13so137822oiw.13
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Apr 2021 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8LyLxGSQQphLnjeYLlddmkfUqatoN6oCK+jULyo25+I=;
        b=cqNnST/xDb7Jic5n81TJ7veTJqiuUrZpTxheT/XoPbOwWZAWAjb1oTobsghTVqVYzH
         jH4ArgLVqUlkx1eM3HFmCMa3oaWi3qy2Dj8y14jAaBjIRmvTtckS90N28Gb/fLAKfbO8
         w/WeHFa6qM/gbYgSvy+cuSc1/dnutMwN2/J+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8LyLxGSQQphLnjeYLlddmkfUqatoN6oCK+jULyo25+I=;
        b=PqOvB2D38TjlvfmKSWq6UkZbnD6nRHVtHK+O0uKbZmpt35H2CO18IDEckMC+pgRDpJ
         ErfYMvo6SJhiAyDaDUhq4h9Z2h63o/5+zXZ51+2YTuGEGPDGDZIOWaSCLkUHCnsy1aOd
         GNv/nzHMfAd5zo0QzyvNdEydNFjojKkJVLpyo78uz49iAY4qcwTYFbf/rL5WO/sxcnHo
         vP54MAZikJOR3knaYERyLOtMjlWhgjGV/QlRrvLzi044NlkEOytjzsbhHBDe2m3wFSxh
         RWkE6OUzZxiYZw7KxaiVA/JERFMMdfRCH6rp6hR3aVO8IoTtx7pVDBVwtqLFLLabUXt0
         MtkA==
X-Gm-Message-State: AOAM530LTBPpzpbZ/7Ws5tCXtzRxcXKZ2z3nqC/lYwqo7MGEADZdE6/G
        tTr6xZkQS2YP6ZWKF6KQkdKh6g==
X-Google-Smtp-Source: ABdhPJymyx49DOIBzLpDgXw+PDyza1nyktZGIAn1HVJ78ILT8bElG0nl9n8yik3+1y2UBR6iMashug==
X-Received: by 2002:aca:4e55:: with SMTP id c82mr3860158oib.43.1617835570974;
        Wed, 07 Apr 2021 15:46:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s21sm4988229oos.5.2021.04.07.15.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 15:46:10 -0700 (PDT)
Subject: Re: [PATCH] Documentation: kunit: add tips for using
 current->kunit_test
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210406225100.1883967-1-dlatypov@google.com>
 <CAFd5g47EE3J5V9ofZ4r3H+3+16u41-yqa+uwFYVgpVCg4CKOwg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1b7d8261-b501-c118-3bed-9b80983218cb@linuxfoundation.org>
Date:   Wed, 7 Apr 2021 16:46:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47EE3J5V9ofZ4r3H+3+16u41-yqa+uwFYVgpVCg4CKOwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/7/21 2:07 PM, Brendan Higgins wrote:
> On Tue, Apr 6, 2021 at 3:51 PM Daniel Latypov <dlatypov@google.com> wrote:
>>
>> As of commit 359a376081d4 ("kunit: support failure from dynamic analysis
>> tools"), we can use current->kunit_test to find the current kunit test.
>>
>> Mention this in tips.rst and give an example of how this can be used in
>> conjunction with `test->priv` to pass around state and specifically
>> implement something like mocking.
>> There's a lot more we could go into on that topic, but given that
>> example is already longer than every other "tip" on this page, we just
>> point to the API docs and leave filling in the blanks as an exercise to
>> the reader.
>>
>> Also give an example of kunit_fail_current_test().
>>
>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 

Thank you. Applied to linux-kseftest kunit branch for 5.13-rc1

thanks,
-- Shuah
