Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1651677CE4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbjHOOka (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjHOOkA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 10:40:00 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8B61BF5
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 07:39:41 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3496e3e02f3so4812015ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692110381; x=1692715181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHs9XntY1I2gUFMtECHDPXmV4mkAYUMAUnSNRriyHns=;
        b=akm21EaglRKpNocwVY5xgns55AtWZ8DjowsCtxlA3MoCgodwdnujLVEO6xsVrXdDmg
         ucWbcCxRmWd+AIJO1XI/HJyvN4XdTbxNbrz8T7McewyN4xvBbUxiMpaihL5m4fqOxL57
         FYehi50lpdD069vVlHjQPNUT7Me2rxp0h675U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110381; x=1692715181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHs9XntY1I2gUFMtECHDPXmV4mkAYUMAUnSNRriyHns=;
        b=M/5l8TccmkP2RkFCjeZHvk7diWUn539QewxtwFiTzJUHFDV8fQjR00VPW59DwJH6E7
         /KxCZZdTAoS0hDsoF751hQIL3R5/c7C502yvPLQgQ2V4QNaXepOmIrAzEc8YU3UYGXAK
         A/Zz+ciHpX0kZJ54WQDoaFurTXVsSWmugdJw+xEezfy8NKLdEHh/9iofIfbM7C6gmLsd
         iAuU7EmcJ+Tb+OfGq6IZEpqAzapo/PYE6ONsyKdNVlDqpr9Tw8so+fDnVxQbyF7To6s3
         VLcKhov2D3D0NjdJjQzs3MDFs8z/fwdDZ+YCBOu8FWx9ZS+yJxz/wEu86kI3R3HmEjnH
         A7Rg==
X-Gm-Message-State: AOJu0Yxc65Y+GFZNTJadQbEBCsv8spVQn+Kv4kotgcP7CK57jJr1nSz/
        FYm8QUvTS47PxxQJXa9OdwXY4w==
X-Google-Smtp-Source: AGHT+IHLow/f6Byq4z7EdKwrqz20Gz1Ah+InyaYGMkXzVOtkQOZmmpdKLM7c3gT1eaDrUhW8l+tr9Q==
X-Received: by 2002:a92:60a:0:b0:345:a3d0:f0d4 with SMTP id x10-20020a92060a000000b00345a3d0f0d4mr15380996ilg.3.1692110380751;
        Tue, 15 Aug 2023 07:39:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t24-20020a02c498000000b0042b52dc77e3sm3591434jam.158.2023.08.15.07.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 07:39:40 -0700 (PDT)
Message-ID: <29590d7b-40fd-0426-75c6-36667e344f6c@linuxfoundation.org>
Date:   Tue, 15 Aug 2023 08:39:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] nolibc changes for 6.6-rc1
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20230806172245.GA26239@1wt.eu>
 <3efa3710-4e8b-d187-a24d-ff85858e37fe@linuxfoundation.org>
 <20230815143540.GA15075@1wt.eu>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230815143540.GA15075@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/23 08:35, Willy Tarreau wrote:
> On Tue, Aug 15, 2023 at 08:25:51AM -0600, Shuah Khan wrote:
>>> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
>>>
>>>     Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1
>>>
>>> for you to fetch changes up to d98c1e27e46e47a3ae67e1d048f153598ba82611:
>>>
>>>     tools/nolibc: stackprotector.h: make __stack_chk_init static (2023-08-06 18:44:47 +0200)
>>>
>>
>> Hi Willy,
>>
>> I am sorry for the delay on this. I was traveling last week
>> and getting back to digging myself out of emails.
> 
> No problem, thanks for getting back :-)
> 
>> I am having trouble pulling this request though:
>>
>> git request-pull https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1
>>
>> gives me the following error
>>
>> fatal: Not a valid revision: git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/
>>
>> I don't see a tag at https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
> 
> Ah sorry for the misunderstanding, that's the branch name, I'll set a
> tag then.
> 

No worries. Could you also share the test you run? I will pull
you request and run tests.

thanks,
-- Shuah




