Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D93A454B67
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 17:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbhKQQyk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 11:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbhKQQyh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 11:54:37 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C66C061764
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 08:51:38 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e8so3432583ilu.9
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 08:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i+yHLDUdguQQnHcqTW5TD+px4clk8ceplaCTOsvxisg=;
        b=xRnC/Q5E7/Uaf+LjjPHxvac/DD3wd0pMFMHFQZgxsxz6bYTqY6QKv6w4cKo+aDIe5K
         3mDxQXRP+hmu5ZSpzwm8rOfT0vckLy2rEKjfC225XPUm5xK5KesRMubX0RJ2k/tbNdFJ
         5YohsEOQoTTW/kLTFPe/BiAs44Zw34c7lc5L545VgzkypB7sW1X6duTciCnS/rYTRY5N
         BTnRYkHUdmdFM4tMLuhSLw97z6wWStiiQIwXIg7d4pp6zmBAwypvhnrk/baInH7hWM7B
         bnr9TNu/14LBOZIHuuHI5cTNvDE2mRQYnlV216iRp7wIUm6g+HnuS1lCriPywlTlKhpS
         BPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i+yHLDUdguQQnHcqTW5TD+px4clk8ceplaCTOsvxisg=;
        b=CfSSwnyvRF3m6Na/badGtcCXIboy91bfeptS3ThSRfdYdhzu4KbHkNg9E7szlvsd7W
         7rIJmtUGC1yKys2YmTJBAtciQYrXTTgUsA5/zqvGxl+ClrpRB80zvQ1G575pAM3w64B1
         LClsHUbmg8F7s33C6Mwe8oCcuMW1ctEZ9vebQjsK5CkeLhPcPC5viP/keHehL/56zttI
         x71QrO1pl2BYoFYxbvkU5+qv/meuJMX3PC+Jttn8FAV43BD0NRXb1NivV5cWVP7Ybl7w
         3s6ptjC+iKc4xW1jKn6CSvPdi0/6sQ7CapH3SHgjp61vCVh9u3nLie8ma7CryGci7ldJ
         PUIA==
X-Gm-Message-State: AOAM531BsicLRqWOumSrq3LMqkTdud+t5Lf8MKF9FYww4lpZj5ZCfnYV
        1eAkLEki52p97BziQNVeGJngSA==
X-Google-Smtp-Source: ABdhPJzvp6H93nHQJmR08vdh8s/pw3ONIsTzxyzofUhgFnfybDmjPjkJVnxQsCBDBXQ1NwltH7fYag==
X-Received: by 2002:a05:6e02:1ca9:: with SMTP id x9mr11415303ill.273.1637167898149;
        Wed, 17 Nov 2021 08:51:38 -0800 (PST)
Received: from [192.168.1.173] (bras-base-kntaon1617w-grc-33-142-112-185-132.dsl.bell.ca. [142.112.185.132])
        by smtp.googlemail.com with ESMTPSA id p18sm274599iov.44.2021.11.17.08.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 08:51:37 -0800 (PST)
Message-ID: <d0c32c34-b0a4-ce1e-35d6-1894222e825a@mojatatu.com>
Date:   Wed, 17 Nov 2021 11:51:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 1/3] selftests/tc-testing: add exit code
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Davide Caratti <dcaratti@redhat.com>,
        Li Zhijian <zhijianx.li@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, lizhijian@cn.fujitsu.com,
        linux-kernel@vger.kernel.org, lkp@intel.com, philip.li@intel.com
References: <20211117054517.31847-1-zhijianx.li@intel.com>
 <YZTDcjv4ZPXv8Oaz@dcaratti.users.ipa.redhat.com>
 <20211117060535.1d47295a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <4ed23cd5-f4a1-aa70-183f-fbea407c19ee@mojatatu.com>
 <20211117084854.0d44d64b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
In-Reply-To: <20211117084854.0d44d64b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-11-17 11:48, Jakub Kicinski wrote:
> On Wed, 17 Nov 2021 11:41:18 -0500 Jamal Hadi Salim wrote:
>> Did you mean adding a maintainer for tdc or just generally point
>> who/what to involve when making changes? Typically the mailing list
>> should be sufficient. Outside the list, at the moment, any outstanding
>> issues on tdc are discussed/resolved in the monthly TC meetups (where
>> all the stake holders show up)...
> 
> I'm mostly interested in the code review and merging part.
> 
> Would be great to have a MAINTAINERS entry with a set of folks
> who can review patches, so that get_maintainers.pl can do its job.
> 
> At the very least to make sure netdev is CCed.

ACK.

cheers,
jamal

