Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF9157568C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 22:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiGNUrV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 16:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiGNUrV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 16:47:21 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D356D546
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 13:47:20 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id u6so2432483iop.5
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5yRvOTGRnegCHVbLMlYfoPtqBZjcDcdjxcIFgXJXUCY=;
        b=iJPwVMEVmlDdOGjIdwfPb3QcpmckWwU5zfZ+LxI/bNEFOG6/9CW3Jx6lK9kNMJWD7G
         80Lmohh26UHNK9omBR0hZuW0wp5QNpk5BqZio+4xjDDfneepPC5T2xVYg8jg5Cy5sPC6
         +rtTRlBCuYe/Bvx0Ff2Im9iXajwrm2vS9vkhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yRvOTGRnegCHVbLMlYfoPtqBZjcDcdjxcIFgXJXUCY=;
        b=2O/JFlaTY4YwIAq7aSRr7mfZIpiNThj+COWlXhqciJ8GiSFSi+plpMYoNepOUNk/cY
         dhg/OEq3CLr2hRkO1sqMb/GR6VQvJuowJJke3yYE+2FN+hYIrH/xrM9wCewBvgtmOtuW
         TsYDe+Lmu9RyUl8qJ/u1zS69gG1DTJe93Ckb//v5p9Yz5Xwx5mvBONCXKk8IKzfQ6BYC
         jZOhGTAKSVr6sT5JmyX5gE9EfnKUJSvK2gs/+B/uMPIcl3HuGDuBFM757ZufTysNxEwf
         mHTDYBHbCJl5oX1pv4caZ1TR/4MTsV9Wh5ONhKfSXeUVNEiEVHSfYLy7kiom6wrVcvFB
         sJcA==
X-Gm-Message-State: AJIora9kwRyjtyFHbtXIUmFELNkztlL3ddpjVGNCkjFdOVbku7aBy7kO
        K3pgxJQxJnnOZowNnzPoVVb5Jw==
X-Google-Smtp-Source: AGRyM1vjWGII0bZhPhJVaJRGo6OHgsPZnk4TMLd+wqVlwkc8jmrMUpSfm+11hdWAmeCQuRJvu1qklw==
X-Received: by 2002:a05:6638:164b:b0:33c:9b6f:457d with SMTP id a11-20020a056638164b00b0033c9b6f457dmr5928163jat.224.1657831639911;
        Thu, 14 Jul 2022 13:47:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e10-20020a921e0a000000b002d79f619517sm972694ile.26.2022.07.14.13.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 13:47:19 -0700 (PDT)
Subject: Re: [PATCH 0/9] selftests: timers: fixes and improvements
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        John Stultz <jstultz@google.com>,
        linux-renesas-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
 <CANDhNCp3KhGjXSrS4xmqrdPJfxStZOOn+FQxJEEoiXZ39CxDpg@mail.gmail.com>
 <dbe428f6-37fd-cba7-2947-e042585d3a42@linuxfoundation.org>
 <YtBj5NPGi5MUKuvP@shikoro>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <01cd5e24-7732-3a67-8171-3c99b620d617@linuxfoundation.org>
Date:   Thu, 14 Jul 2022 14:47:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YtBj5NPGi5MUKuvP@shikoro>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/14/22 12:43 PM, Wolfram Sang wrote:
> 
>> Wolfram, are you going to send v2 to address John's comment on
>> 8/9?
> 
> Yes, will do!
> 

All patches now applied to linux-kselftest next for 5.20-rc1

Picked up v1 1-7 and 9 and v2 8

thanks,
-- Shuah
