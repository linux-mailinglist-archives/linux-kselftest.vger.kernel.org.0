Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6D767933
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 01:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjG1X6R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 19:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjG1X6G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 19:58:06 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F7E4488
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 16:58:04 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id ca18e2360f4ac-785ccd731a7so30621439f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690588683; x=1691193483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NL4Ty9W9yHiaPkbQYQx9g/5UV+hA0UjBEBi+RTH+aac=;
        b=TLFWx4KB3xYfeNfKl9Dpse1oeqCTIsG0pjd7uCDxQ9ChoNZCWhy4t9Wq+9DnEZ8MwZ
         A72Do0ODAl7gmh3FUPqUYPER1fSJ7EQ3M8iuUD0KLU9VVUkDD36ce5QcYnBBrxctNZC3
         g8ZlkDQSkvjl5/ruT9edVxvup2E+Lp1upJgHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690588683; x=1691193483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NL4Ty9W9yHiaPkbQYQx9g/5UV+hA0UjBEBi+RTH+aac=;
        b=dKnGTK6cPMIT7zWsHayWkJDq1JAyF+lRa7ZIMp0MtD+NXlQBxUtp0kTHF/H/ZNdktv
         UCE9YGCuEf06e6NJGwou01YZj4Zo2c8FVVYuEDcn/u4lkFTCpoi4zAjf+fLQ4iZRYzrj
         gA9AfOmkvroiBN9mVlfjXHyYLjXKrjddfxT32u7RRX9V8dc6gihPP81/rQ/crcZ84KwL
         WgyTZfGZi3j9RKASFaLIk7ycnytvuE9Jj6ZZohO3wJ18uWEZN6BJ+MPMoHxbSufU1BOw
         jYk14WTuYj2mjCiuybepoes/PxuVz5+CzY/xN0s1mySCOUaJKRavZcge0iUSpZ43uXZh
         Q5xA==
X-Gm-Message-State: ABy/qLaO1ylIfu8Bts6RcxX6uTnJuFi+iLMjREAYRUdREI+Upj91mbbj
        kA5T0Xul6VTW6haYXjhgIeZ3nw==
X-Google-Smtp-Source: APBJJlHvYkT8BAaTCuibmpj+HHz6hACB/FZeTMmKFhu/g1MnAcTnF5r/QR5/+SqsUYONOst+SMKxqA==
X-Received: by 2002:a05:6602:3d5:b0:780:d65c:d78f with SMTP id g21-20020a05660203d500b00780d65cd78fmr1545922iov.2.1690588683704;
        Fri, 28 Jul 2023 16:58:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cu5-20020a05663848c500b0042b16c005e9sm1411923jab.124.2023.07.28.16.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 16:58:03 -0700 (PDT)
Message-ID: <7b7b8acc-5db2-5e6a-e803-e054ec7e1ab0@linuxfoundation.org>
Date:   Fri, 28 Jul 2023 17:58:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] selftests:connector: Fix input argument error paths to
 skip
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, davem@davemloft.net,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230728225357.5040-1-skhan@linuxfoundation.org>
 <20230728162144.3db7dbac@kernel.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230728162144.3db7dbac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/28/23 17:21, Jakub Kicinski wrote:
> On Fri, 28 Jul 2023 16:53:57 -0600 Shuah Khan wrote:
>> Fix input argument parsing paths to skip from their error legs.
>> This fix helps to avoid false test failure reports without running
>> the test.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> netdev was not CCed on this or patch 3 of the previous series :S
> Which is a bit odd 'cause it was CCed on patches 1 and 2 🤷️

Odd. get_maintainers.pl didn't give me netdev. I added netdev
and others to the first patch from the bug report.

Would you like me to resend this with netdev on the cc?

thanks,
-- Shuah
