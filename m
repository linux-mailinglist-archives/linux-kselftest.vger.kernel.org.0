Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A516E139C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 19:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjDMRgT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 13:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDMRgS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 13:36:18 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCA09029
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 10:36:17 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-760a66d23f8so3775839f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681407377; x=1683999377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFINY4RTw+7W8DjDHYOy2bqEQEYeJUn2YNk4VJTRsKo=;
        b=DOMeT2Bj/mzse72vWHXjdBKuP8HHxpELmhCpTUjV1HAe7wZdOPUc3+ycg1y02imWAt
         gv8psuYQHD3bfjWXpjvM9xuOYK2uf30xb2BKt8FqMaB0iP+nNNa43Snew4LFxjTf+P+L
         MN1k3vjCLzSbfuMEGu7YFzcMNDjWgomK6FWjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681407377; x=1683999377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFINY4RTw+7W8DjDHYOy2bqEQEYeJUn2YNk4VJTRsKo=;
        b=jwoF1KHyQpYqOyuEhJCqq0gCUqsmQbvojv/rEtACGPXdNprO5KKvBsYLlaKGY2PoRy
         QLHw4wvQVI+NQQx3Wobb7dONAAplRg2L4u5fn7NIPt3rTjb61yuG8njD3MoW1qxfMWWq
         ouTZpTwNaaep8CZE/uFSwcl8nsBKcNFj79gLtzQ9pKmEHSvowovbNgL5XrRkZAoVWZ5K
         TX5uZx3lU2Nsj5QwzsweSez56DksUYqSULC07dXNeN18gXmNg+DNLzS7PQBfXqmjMs15
         Ur9gvt6pb8lOpGJpzmRoHmSL6nVM0fmoCv7t3qeuJKsHW6wwcVdyBTkrRpcqDW/vtMuF
         +qoQ==
X-Gm-Message-State: AAQBX9eE1aHCGeYBMmYSrsetB2mKDSw/+RoMDMSuW4gWSEldjUfP8+rA
        pE1qWHcCfXVHRFJFgymZqBLsovSKK2qT0EszxYA=
X-Google-Smtp-Source: AKy350b42hmwbmUL+5q9O1OSuTERp9tq0vDtj3RxpRhqQd1VR7LxLdH2b5ZxcINgTaHNNT4pY1fXiw==
X-Received: by 2002:a05:6e02:f04:b0:325:e639:76aa with SMTP id x4-20020a056e020f0400b00325e63976aamr1375285ilj.1.1681407376943;
        Thu, 13 Apr 2023 10:36:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y16-20020a05663824d000b0040619720af8sm621454jat.35.2023.04.13.10.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 10:36:16 -0700 (PDT)
Message-ID: <bc4ffec9-293d-0b8e-d92c-27cdb81fb83c@linuxfoundation.org>
Date:   Thu, 13 Apr 2023 11:36:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: resctrl selftest patches
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <eaf96617-2f3e-b573-8990-6e9e6b0cb6fd@intel.com>
 <71b769fd-6cde-0ccc-ca41-c94d4737b596@linuxfoundation.org>
 <168d8f63-3d42-96e4-e8b1-89f92fb8cf36@intel.com>
 <753f0eae-527d-c909-2b6e-8c59b788d4e2@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <753f0eae-527d-c909-2b6e-8c59b788d4e2@intel.com>
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

On 4/13/23 09:53, Reinette Chatre wrote:
il):
>>
>> [PATCH v8 0/6] Some improvements of resctrl selftest
>> https://lore.kernel.org/lkml/20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com/
> 
> Shaopeng just sent a v9 with the only change being that it is rebased
> on top of kselftest's next branch. This leaves you with no merge conflicts to
> deal with:
> https://lore.kernel.org/lkml/20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com/
> 
> Discussion surrounding this work completed a few months ago (it was ready before the
> resctrl selftest series you merged this week and a couple of the patches also carry
> your "Reviewed-by:"). I believe that it it ready for inclusion. Could you please
> consider including this work in the kselftest repo?
> 
>>
>> [PATCH] selftests/resctrl: Use correct exit code when tests fail
>> https://lore.kernel.org/lkml/20230309145757.2280518-1-peternewman@google.com/
> 
> This patch is also ready for inclusion and continues to apply cleanly.
> 
> Thank you very much
> 

All 7 patches are now in linux-kselftest next for Linux 6.4-rc1

thanks,
-- Shuah

