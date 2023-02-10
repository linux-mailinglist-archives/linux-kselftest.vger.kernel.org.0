Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18355691610
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 02:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjBJBKV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 20:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBJBKU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 20:10:20 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88E4485AC
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Feb 2023 17:10:19 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id w13so1633315ilv.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Feb 2023 17:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/rk3szIYpKAIRaNgREy62PBz6/2LxRSXh1DsRADJYU=;
        b=glWpLY4dwbYR6L+EuXgrM7xpnBQwcy4cG8tTl4Iu6S5oeAe9XEeTtFQedpEob1PVsf
         XDhBc6dcvKP5ITbMhU84oC9wLHu4u61U/5Mm5CDuiBGjg1ff+u7y+a6Wx+VivD/VPKcs
         9aWC7QzL9MdRG8WZGfGt+erauZpDeGAPE4C04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/rk3szIYpKAIRaNgREy62PBz6/2LxRSXh1DsRADJYU=;
        b=UEk3PVk7tdXT23p4tGzb2NiRrA8l5BECGXkDBPGVxQvymf/blgXQL4v4NUnYKec3Ek
         5K5CNsINkMQDhHN5hLzILepkw3oe9ke68wQSYvZVY9Kd1n+k6mWQYJCZJQWjjGG8cBIs
         1JAHOo1Azy0m9IKTQAks5TlQohbWnqvUbpoZEuSjnF3V/bR6jff5Oifr2I2D6XdZlI7g
         URAQy28TpZO4WqNizM52Ftqt7RzYXvq7N6PGy5dswQRwq5vpFD/HdpcOD3SK5tNvPTyn
         OrcmJe5tMaVZKke7507glDVajr2UM2Tb737oHB20+FJEq/G21/09d5ZcxBWGxWJJyP1S
         CHuA==
X-Gm-Message-State: AO0yUKWzzv/iWce7FkDGTtNTjeT1A0MLpoyilCpnG1yLJshhHldjRiWU
        S/QjimR3vJKvkgZcXh9qhquhtXk4QeWvv81Y
X-Google-Smtp-Source: AK7set/lwVwMrh2gIxWEj3tHiccsh9dwYjh13O3kYY/qcLOTXN81uOX17NqMOY+FJluKLmXrlqXPYA==
X-Received: by 2002:a05:6e02:1d95:b0:314:1579:be2c with SMTP id h21-20020a056e021d9500b003141579be2cmr872204ila.0.1675991419088;
        Thu, 09 Feb 2023 17:10:19 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o3-20020a02c6a3000000b0038a56594026sm887540jan.66.2023.02.09.17.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 17:10:18 -0800 (PST)
Message-ID: <ee7976ca-ea15-e13f-3ea0-1b89eb29e39e@linuxfoundation.org>
Date:   Thu, 9 Feb 2023 18:10:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] selftests: use printf instead of echo -ne
Content-Language: en-US
To:     Guenter Roeck <groeck@google.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Gautam <gautammenghani201@gmail.com>,
        David Laight <David.Laight@aculab.com>, kernel@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernelci@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20230209085536.1076662-1-guillaume.tucker@collabora.com>
 <CABXOdTdnntA=oU4==suO-DP-8S9zb0AhqtwekCRCbpOpku7MQg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABXOdTdnntA=oU4==suO-DP-8S9zb0AhqtwekCRCbpOpku7MQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/9/23 09:19, Guenter Roeck wrote:
> On Thu, Feb 9, 2023 at 12:55 AM Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>>
>> Rather than trying to guess which implementation of "echo" to run with
>> support for "-ne" options, use "printf" instead of "echo -ne".  It
>> handles escape characters as a standard feature and it is widespread
>> among modern shells.
>>
>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>> Suggested-by: David Laight <David.Laight@ACULAB.COM>
>> Fixes: 3297a4df805d ("kselftests: Enable the echo command to print newlines in Makefile")
>> Fixes: 79c16b1120fe ("selftests: find echo binary to use -ne options")
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> 
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> 

Thank you. Applied to linux-kselftest next for Linux 6.3-rc1.

thanks,
-- Shuah

