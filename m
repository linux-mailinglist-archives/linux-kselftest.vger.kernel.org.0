Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849033DA9D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhG2RQj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 13:16:39 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:40746 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG2RQj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 13:16:39 -0400
Received: by mail-pl1-f171.google.com with SMTP id c16so7735716plh.7;
        Thu, 29 Jul 2021 10:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2leTkK3AGQYYjwqRoctfwEk9wGT1sRMEE9aF6hkHLE=;
        b=k31WIGgXIGv05bDLepoEfpat1Ewk8vThFsfxkWs1BUSDgIe5n5hQ5h7vSDrWpRJsOt
         nCnEv7Egbq/470PW2I/uv/2VMNIWUPKTHfMrOOsYGDO0tTpDPYWsRipZRYglaya9j1W/
         UqT6vk2sRlPEhH88nkFuuQXNmo8uSYP+81okDpwORlCvb2S9Clah6pR8yw0yDuq8h1ej
         ODpmV8Bdt3zIoq8oN4EgUr74V0zM68szFhcosR8SWMPe1b0p9boMUS+M0iM7SkVtNzyo
         42KeGkCCDUm+LhzOSHjmVMYVdOAyD/clSAyqmiZwXeCfGo5NRRyhzjYCwho/oThNK94w
         yxeg==
X-Gm-Message-State: AOAM5303l2WcRdlvyjqRcnvCpk0R9gnq4cEjs+hf1iTPErmB+l/FzBBD
        FVfzlwKBuESMae+Ys4GQr58=
X-Google-Smtp-Source: ABdhPJzcMxws6gb6S0AeYLpk4D8TJO+4L0r0ZwoInfWoOkU/CMBZjWDMiMDJyR4zkrn927ZaLPhUQg==
X-Received: by 2002:a17:902:d916:b029:11e:3249:4a17 with SMTP id c22-20020a170902d916b029011e32494a17mr5682158plz.0.1627578994727;
        Thu, 29 Jul 2021 10:16:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:684a:6173:abee:6f13])
        by smtp.gmail.com with ESMTPSA id g9sm4271181pfr.133.2021.07.29.10.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 10:16:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] kunit: Add support for suite initialization and
 cleanup
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>
References: <20210729044125.7435-1-bvanassche@acm.org>
 <20210729044125.7435-3-bvanassche@acm.org> <YQJCyigNroTl8J/l@kroah.com>
 <8ab0ea44-760a-61df-0b9a-8b314ca9a0fe@acm.org>
 <733cb812-8696-45f4-356d-cfe5bd85eb9b@linuxfoundation.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bbe15cf5-229c-13b2-126e-e773c0ba18c2@acm.org>
Date:   Thu, 29 Jul 2021 10:16:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <733cb812-8696-45f4-356d-cfe5bd85eb9b@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/29/21 9:55 AM, Shuah Khan wrote:
> On 7/29/21 10:52 AM, Bart Van Assche wrote:
>> On 7/28/21 10:55 PM, Greg KH wrote:
>>> On Wed, Jul 28, 2021 at 09:41:24PM -0700, Bart Van Assche wrote:
>>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>> Cc: David Gow <davidgow@google.com>
>>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>>> Cc: kunit-dev@googlegroups.com
>>>> Cc: linux-kselftest@vger.kernel.org
>>>> Cc: Bodo Stroesser <bostroesser@gmail.com>
>>>> Cc: Martin K. Petersen <martin.petersen@oracle.com>
>>>> Cc: Yanko Kaneti <yaneti@declera.com>
>>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>>> ---
>>>
>>> I know I do not take patches without any changelog text.  Maybe other
>>> maintainers are more lax :(
>>
>> Almost every patch from me has an elaborate changelog. For this patch 
>> I chose not to add a changelog since I think that the subject is 
>> self-explanatory?
> 
> I don't take patches without change logs either. I can't say the subject
> tells me what you are doing.
> 
> Please add a change log.

I will add a changelog. But please note that this patch has been sent to 
Christoph as configfs maintainer.

Bart.
