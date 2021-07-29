Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F94A3DAB24
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 20:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhG2Smu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 14:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhG2Smu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 14:42:50 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98FCC0613C1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 11:42:46 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h1so8387936iol.9
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a2jcrKjKBS+gdl5PCdRBVKhfmtzJBVA/IHxSfmpMEXY=;
        b=fyxwFxZ5LuI1DPZNzJ8ri2+PsiwAu9rjoLFHe8n51OFhFA9qa/cP+WRLe4VevBtOQh
         3NvAsp65Q4og8vEaASAkhTnjrK2NSAkKw6IBZ5eMUMjGZ6gfwGUK/QoLZxAxehKK5ygJ
         WXnJK2UT2jvW0VIeXtdTfnFn3Rz7euZba+KSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a2jcrKjKBS+gdl5PCdRBVKhfmtzJBVA/IHxSfmpMEXY=;
        b=tkWSLGpC6p4w15zBWIrS+gkHNZaKR9hCsjSOdvzIHcsSkuzEUJXuOa2SfuHwVi1AVc
         vxrengJNA5AoUeMFZSMY6U0IOmewDnBwMHl8axKaawdxIUySojnRdOtdCin7tzyEdHT4
         sHkjkm/nYM4YpvA81jeZcigyUF+r2AMpyxOZ4gdWlY37N9AObm3Esc+Bm6lcga1ypXYT
         FYLjYtXz96ADNAr9l+a419R8kxN4seYdkfWHMP8kD4ynzHK2hg6DVSx3J+yImIql1I7Q
         Fis7sVN0OLquShUcZzsivt6BoqDoTcF6dJSBOzlRnM65+cqEEiWnmX/YFqfIeW1OfuCI
         gzoQ==
X-Gm-Message-State: AOAM532AUR+iXV9a++dDLSQoxoRCrltW6KQQxl3oivEd0hoZJTnDgaiQ
        yLsOgANUoQ8VFIMAMWhPO9uDHA==
X-Google-Smtp-Source: ABdhPJyt2mWOI75qeIcEBffn7Ap+3xLN2wsGakY2Lg/XfAtkeHTkM0kbkP3BrxiIdH5/JcC9nNGzLg==
X-Received: by 2002:a05:6638:204c:: with SMTP id t12mr5558854jaj.129.1627584165955;
        Thu, 29 Jul 2021 11:42:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z6sm2303243ilz.54.2021.07.29.11.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 11:42:45 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] kunit: Add support for suite initialization and
 cleanup
To:     Bart Van Assche <bvanassche@acm.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210729044125.7435-1-bvanassche@acm.org>
 <20210729044125.7435-3-bvanassche@acm.org> <YQJCyigNroTl8J/l@kroah.com>
 <8ab0ea44-760a-61df-0b9a-8b314ca9a0fe@acm.org>
 <733cb812-8696-45f4-356d-cfe5bd85eb9b@linuxfoundation.org>
 <bbe15cf5-229c-13b2-126e-e773c0ba18c2@acm.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <81edb935-aabd-bd05-c3d1-260903b3c726@linuxfoundation.org>
Date:   Thu, 29 Jul 2021 12:42:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bbe15cf5-229c-13b2-126e-e773c0ba18c2@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/29/21 11:16 AM, Bart Van Assche wrote:
> On 7/29/21 9:55 AM, Shuah Khan wrote:
>> On 7/29/21 10:52 AM, Bart Van Assche wrote:
>>> On 7/28/21 10:55 PM, Greg KH wrote:
>>>> On Wed, Jul 28, 2021 at 09:41:24PM -0700, Bart Van Assche wrote:
>>>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>>> Cc: David Gow <davidgow@google.com>
>>>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>>>> Cc: kunit-dev@googlegroups.com
>>>>> Cc: linux-kselftest@vger.kernel.org
>>>>> Cc: Bodo Stroesser <bostroesser@gmail.com>
>>>>> Cc: Martin K. Petersen <martin.petersen@oracle.com>
>>>>> Cc: Yanko Kaneti <yaneti@declera.com>
>>>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>>>> ---
>>>>
>>>> I know I do not take patches without any changelog text.  Maybe other
>>>> maintainers are more lax :(
>>>
>>> Almost every patch from me has an elaborate changelog. For this patch I chose not to add a changelog since I think that the subject is self-explanatory?
>>
>> I don't take patches without change logs either. I can't say the subject
>> tells me what you are doing.
>>
>> Please add a change log.
> 
> I will add a changelog. But please note that this patch has been sent to Christoph as configfs maintainer.
> 

Sure. This is a kunit patch - hence Kunit maintainers can comment on it.
Besides the comment is about missing change log which is rather basic
kernel dev 101.

Please take a look at Documentation/process/submitting-patches.rst
for information on commit logs.

thanks,
-- Shuah

