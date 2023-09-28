Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A031B7B1C92
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 14:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjI1MgB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 08:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjI1MgA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 08:36:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E7B191
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 05:35:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-317c3ac7339so12317698f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695904556; x=1696509356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPk2ZzrID8Ruy/e6ubyOdQXDCXqUez+jUlvGZE9CHoc=;
        b=DI6SzCmC+ik1/3gGJtZaaEQEZeBEH2IzH7xEn3xfdfCkGFJnUqILygvEr79HM2pY6W
         n0ATXu30vKju6aYcfvas+ex9CBs/pyIN90PELqPIYlKxbx12rqdqFSJ2nJFM7aiHCNYX
         ld/UMYHGLcsR2veCA1tEFrzC1YBJyn/nxygpi/vmC3sAdVtyyzNwydlxlZdrd4JNdYXB
         uRapu+NpaTRv7Zu2FRiMV1Xwess9RIjl9oIGvWlsyWA32PJVa2ScA+KDlqjOd0wk8+Lc
         sswWC1nEhS0ZmnKdMj83SoMJRbMjdTnxC9rDg0BUB0forlhaNErN7d2+kuOvIteyFuVq
         qrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904556; x=1696509356;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPk2ZzrID8Ruy/e6ubyOdQXDCXqUez+jUlvGZE9CHoc=;
        b=xSu+nk8FbEPvlMptXXk2BrHQYkFQZf+aFqwQTz8qsaXQWtzaAIODJpPuBWhLCtuzbv
         rgMu3gruhtSbC4xvWEGsox9S/uPqkWwuZJ0KhSQ0nwFICVmv3yOb8uYLTWrxjw7o6YGc
         YB5XlQ9K7rK5909RjTLV5OTBMrWt+ox2g57BHHvy0K8zKvX6uYiqX39zuyY5zQTz8VBK
         HV+G2ud/W9JwO41ufNZZlKjnVhiUiKpBvWToJMx1l0aJ1fYWTyFaDXlI6krDLQ0ugQBc
         LURNXlbQONB6sJdnO0wjlCAOnLndhzFZ0f7FvJhxKSZxG8BkBMZcE+m1HY4Blxba0KFL
         OM8g==
X-Gm-Message-State: AOJu0Yx16RcRwekxKgJ+AdrVEBt8ANzylSJ+Ek5Y5IUk1LR3exb8byM1
        OJ74O40rheX2KnpMyOJ4fYMSpg==
X-Google-Smtp-Source: AGHT+IG+ptZJRlwen4reypsH0+PwYcAGCXwddHDZkmlJP4KAaSG4l2LCo5phyY7HK5it2f8kKzCUsw==
X-Received: by 2002:a05:6000:985:b0:320:9e7:d525 with SMTP id by5-20020a056000098500b0032009e7d525mr1391079wrb.46.1695904555860;
        Thu, 28 Sep 2023 05:35:55 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id iw7-20020a05600c54c700b003fc16ee2864sm18319287wmb.48.2023.09.28.05.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:35:55 -0700 (PDT)
Message-ID: <2c985516-88a3-9fee-dbd1-134aecd323e5@blackwall.org>
Date:   Thu, 28 Sep 2023 15:35:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] bridge: MTU auto tuning ignores IFLA_MTU on NEWLINK
Content-Language: en-US
From:   Nikolay Aleksandrov <razor@blackwall.org>
To:     Trent Lloyd <trent.lloyd@canonical.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230927075713.1253681-1-trent.lloyd@canonical.com>
 <3dccacd8-4249-87f8-690c-6083374dc9d1@blackwall.org>
In-Reply-To: <3dccacd8-4249-87f8-690c-6083374dc9d1@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/27/23 11:10, Nikolay Aleksandrov wrote:
> On 9/27/23 10:57, Trent Lloyd wrote:
>> Commit 804b854d374e ("net: bridge: disable bridge MTU auto tuning if it
>> was set manually") disabled auto-tuning of the bridge MTU when the MTU
>> was explicitly set by the user, however that would only happen when the
>> MTU was set after creation. This commit ensures auto-tuning is also
>> disabled when the MTU is set during bridge creation.
>>
>> Currently when the br_netdev_ops br_change_mtu function is called, the
>> flag BROPT_MTU_SET_BY_USER is set. However this function is only called
>> when the MTU is changed after interface creation and is not called if
>> the MTU is specified during creation with IFLA_MTU (br_dev_newlink).
>>
>> br_change_mtu also does not get called if the MTU is set to the same
>> value it currently has, which makes it difficult to work around this
>> issue (especially for the default MTU of 1500) as you have to first
>> change the MTU to some other value and then back to the desired value.
>>
> 
> Yep, I think I also described this in the commit message of my patch.
> 
>> Add new selftests to ensure the bridge MTU is handled correctly:
>>   - Bridge created with user-specified MTU (1500)
>>   - Bridge created with user-specified MTU (2000)
>>   - Bridge created without user-specified MTU
>>   - Bridge created with user-specified MTU set after creation (2000)
>>
>> Regression risk: Any workload which erroneously specified an MTU during
>> creation but accidentally relied upon auto-tuning to a different value
>> may be broken by this change.
>>
> 
> Hmm, you're right. There's a risk of regression. Also it acts 
> differently when set to 1500 as you've mentioned. I think they should 
> act the same, also bridge's fake rtable RTAX_MTU is not set.
> 
>> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2034099
>> Fixes: 804b854d374e ("net: bridge: disable bridge MTU auto tuning if 
>> it was set manually")
>> Signed-off-by: Trent Lloyd <trent.lloyd@canonical.com>
>> ---
> 

So I've been thinking about this and to elaborate - my concerns are two
first is inconsistency between setting MTU at create vs later when it's 
the default (i.e. this way disables auto-tuning, while later it doesn't)
and second is potential breakage as some network managers always set the 
mtu when creating devices. That would suddenly start disabling 
auto-tuning and that will surprise some people which expect it to work.

I think if you make them both act the same and leave out that case with 
a big comment why, this would be good for -net. To fully solve the 
problem without breaking anyone I think we should add control over the 
autotuning flag so it can be turned on/off by the users. That would be 
explicit and will work for all cases, but that is net-next material.

Thanks,
  Nik

