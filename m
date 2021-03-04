Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A8A32DDA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Mar 2021 00:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhCDXMw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Mar 2021 18:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCDXMw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Mar 2021 18:12:52 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53518C061574
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Mar 2021 15:12:52 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 81so28017109iou.11
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Mar 2021 15:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jUZ+5Y+7BGWs1O3tEhBK3p++H+egFa6lEUy0QY+8uT8=;
        b=HY2mwd1osvc/DaX2rtfHhYRKTqVnOcYRJbAPCKfsQRUPoPPUqYk4cj4XE6b95BpZs6
         lF9go1uidmIq7lCROI0/FXexv8mPcscC+lEXWjdYoh8519eOh9cL8bNFE0o6SU6UEaf8
         RqGJByqk9sdw+YA+LMuZUIKx6c/yI1FgAiHps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUZ+5Y+7BGWs1O3tEhBK3p++H+egFa6lEUy0QY+8uT8=;
        b=PkpBqKDE3fmuyda8n5WlZxkjj4xUIxO1ZPpYr/1cv1whn7fvBOddvuNL5/YU4aHj/f
         m/PcmT96Kj/12GfJwNyXtdyzIJoqbkJamt+Kj3Zs2gMlc57oDV0sArUFzlFn8r296UQ7
         Q4oaf7qmzgQjTgQOxFNpk0tN55kiz33r8s/wW44O9GDSLEbBYX2Lqxksuxcar19Xm3mC
         p4eQ6Dy7IPzmB7XIXqAkReoDc5QXHeVqe5eh6qOPFzK5uhgk173xVLYxucPRsG00Kb8L
         pdt/61j63gAMdWKXhiR+stV+rVIFX/kLO9HaSJEbDz2Al/CEUEKWFd48up4VxcftDxDf
         rTMw==
X-Gm-Message-State: AOAM53102lbn0EHpp2DVYInxBAZ0rU7T5ESSBMB/YvU/wobBTrmtCyna
        Gh1xzr+uS7T7JZZ9DmE9jMMaCQ==
X-Google-Smtp-Source: ABdhPJzn7ToBpxp0AHbsI9AmRJo/8qncyfnDeoNc1LhN/lI2Txlbwjo0WqN4fwDDieKpUp2+NA8B3g==
X-Received: by 2002:a05:6602:737:: with SMTP id g23mr5701641iox.130.1614899571864;
        Thu, 04 Mar 2021 15:12:51 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q14sm395658ilv.63.2021.03.04.15.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 15:12:51 -0800 (PST)
Subject: Re: [PATCH v2] kunit: fix checkpatch warning
To:     Lucas Stankus <lucas.p.stankus@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210303020350.4sahuojkqnkcxquf@smtp.gmail.com>
 <CAFd5g47rjt7i7JXWsYarqX_dShHiqSg8StKb7KCqOye3=eyZDg@mail.gmail.com>
 <20210304043554.jysk6qms4h4hue4i@smtp.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d9f1007a-8de4-45e4-b662-846054d50390@linuxfoundation.org>
Date:   Thu, 4 Mar 2021 16:12:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304043554.jysk6qms4h4hue4i@smtp.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/3/21 9:35 PM, Lucas Stankus wrote:
> On Wed, Mar 03, 2021 at 12:56:05PM -0800, Brendan Higgins wrote:
>> Did you change anything other than fixing the Signed-off-by that Shuah
>> requested?
> 
> No, I only fixed the Signed-off-by warning.
> 
>> Generally when you make a small change after receiving a Reviewed-by
>> (especially one so small as here), you are supposed to include the
>> Reviewed-by with the other git commit message footers directly below
>> the "Signed-off-by". Please remember to do so in the future.
>>
>> Also, when you make a change to a patch and send out a subsequent
>> revision, it is best practice to make note explaining the changes you
>> made since the last revision in the "comment section" [1] of the
>> git-diff, right after the three dashes and before the change log as
>> you can see in this example [2] (note that everything after
>> "Signed-off-by: David Gow <davidgow@google.com>\n ---" and before
>> "tools/testing/kunit/configs/broken_on_uml.config | 2 ++" is discarded
>> by git am).
> 
> Sorry for the incovenience regarding best practices, I'll keep that
> noted for further contributions.
> 

Thank you both.

I will pick this up.

thanks,
-- Shuah
