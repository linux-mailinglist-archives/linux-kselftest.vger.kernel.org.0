Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E718407231
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Sep 2021 21:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhIJT6S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Sep 2021 15:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhIJT6R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Sep 2021 15:58:17 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837F6C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Sep 2021 12:57:06 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b10so3805872ioq.9
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Sep 2021 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tBrvKO9A/dPwPbpROFlIDW4gM0sK3mcNXTt1Pn9aYHY=;
        b=Wr4Gh3KIEFBM+ACEtKQQkB6ZOkXVsSDftDicx8567wKbGFHG5dCUuH68Dx+CuM8TK6
         gQ7djhp5EGDI/HV2+EvnV7cWz7JpEknCAap1HFt6xk8PkkNW9U41GiHMY9RrY2jHgCC4
         CKNW6+usqWdG2oQzFX3bYmPoBwgjJQdRUpxKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tBrvKO9A/dPwPbpROFlIDW4gM0sK3mcNXTt1Pn9aYHY=;
        b=RfLKleGtSvsM3n1S8K1NAJiWYMS9BgeIJaGBJGdFU492gujC6svvYC5eS3HUpGikbW
         xSJ48+TrVwDbC2RzakHGd2p5tXgq6LDwC7LsArUc4XL8tHM8POQ71Ud98PAupDP7mEBG
         OifsSMGsrjkzAWgLvmiZJmuUaOYMGXj7W9Xh/K0Kf7rwj+uISDxP7swbPed2XvRu/GxK
         s37Sn25Yfm2bbvVI7znFDKQfmauIiOVEBizlIViMjeJIp0uLsf3cs68fWsSTVROE0sCx
         xwsP17BEdrq2C46jeQUeksbuTDfkNqcnh6xzuVZLDbfnUBym4pfWZS0X5sJj/fkQN6Pm
         2pIw==
X-Gm-Message-State: AOAM530qYue0rE3ureAAW1EUXJADKUUJY8cBwvHN60eEXK/RJTwUHvVI
        5U5Plu/OhbCDH3T/3OX8PGziEQ==
X-Google-Smtp-Source: ABdhPJyP48qJEKgFnhFD8cbEzB1AQlheLGpbQaL1VD3/gyzpnzXEXw6tsqrQNdt45Z3xGwS0dvg2og==
X-Received: by 2002:a6b:3f02:: with SMTP id m2mr8297816ioa.136.1631303825973;
        Fri, 10 Sep 2021 12:57:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a17sm2999141ilp.75.2021.09.10.12.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 12:57:05 -0700 (PDT)
Subject: Re: After KUnit update for Linux 5.15-rc1 - unable to share VFAT
 filesystem via samba
To:     Arthur Marsh <arthur.marsh@internode.on.net>
Cc:     linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <6A72EAE4-A0F7-4CD2-89BB-36A8F4A7D321@internode.on.net>
 <f1d84102-6edf-271f-52f9-0d4bbc85c0c7@linuxfoundation.org>
 <C1ACE9E0-2EDF-4F55-A6F1-B9143F62514B@internode.on.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <843ce49e-4adf-c3c4-83e1-8fb114589cc6@linuxfoundation.org>
Date:   Fri, 10 Sep 2021 13:57:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <C1ACE9E0-2EDF-4F55-A6F1-B9143F62514B@internode.on.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/10/21 12:33 PM, Arthur Marsh wrote:
>> Can you send your config and dmesg? This will help determine if
>> KUNIT is enabled - it shouldn't be.
> 
> # CONFIG_KUNIT is not set
> 
> I am re-running the git-bisect without the " - - fs/fat" qualifier but it will take a few days.
> 

Can you run a quick test reverting the following one
at a time to isolate:

b0d4adaf3b3c4402d9c3b6186e02aa1e4f7985cd (this is the other one in
you bisect log)

c815f04ba94940fbc303a6ea9669e7da87f8e77d (This is the KUnit patch)
(This one shouldn't be in play without CONFIG_KUNIT)

thanks,
-- Shuah
