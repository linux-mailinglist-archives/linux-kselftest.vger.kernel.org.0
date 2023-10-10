Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0B87C03B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 20:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjJJSux (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 14:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjJJSuw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 14:50:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE193
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Oct 2023 11:50:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so10610531a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Oct 2023 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1696963849; x=1697568649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gwxmekZJHXGMm97urkxFALVTBAcR9EJxHGti0iGF1E=;
        b=WzNDpeJboKlSg4nbDM6Kn9X/FZd0Mw+iklHeoIBMQqrs52iNDf0NgUg7JHUCWN12ri
         TzbAEqyPEB+jSTyzlaeh/C6u+wWZs8lodJZNx+SF8uyRzwUJ3M6XotfZ+FCJwNWpBkSY
         SrxfTJeZjgXPQ3L7AUq6s4dRc2wPSwkNv2VWdqOT0JPhmmG65IHp51MT+4vZ/nbpMsx6
         2Ykf2OAHYss+EKV6XMouLqS9ldJxUypZi8NBy3bBmRtIp7MCQ3X8TzUueI2adkPKOaEK
         Z6Cbtsq7y50MrD2WDr3jxEIFV7uRiGSKAnMeSiRNw6qg4AgiIvA1Vizj/HZ9NNWqjKpb
         OpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963849; x=1697568649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gwxmekZJHXGMm97urkxFALVTBAcR9EJxHGti0iGF1E=;
        b=AKjxLcnOfndwx4jKNz4HZNatLa1RFxrqfH93j2K5xYeKRZ2W+FpTu7Jw5rBnOTFHlk
         xJBWzZoh1g+sQ5iEh6RIDDa9zJeHyruhXiD8iosGJWcc4ET4q2kks98zPwEg92WV64zH
         abJVtsP6JZyQxXjXRrZeIJGG6zMKwIkhqVTXt3GRKJbKUtw31F1aZDU/m7n8rDBDtPel
         Svi28+KEGjTkGaalMyU51d40VweyiscSGymS+vmWnpiWd7kE4nbqmHX6uhUnF0Dvwak6
         24Lz9dAju2TnXEn3YxyaDgGzcZYyEUfPwbJKHeY+1fmwR19jm4EpPsVBRM3lRSLcC0H9
         TZ/Q==
X-Gm-Message-State: AOJu0YwN5yWN7wj9MC6dp74pI0LqSmsiit2HVM41fxFkpM8bqBvW5Qtm
        SDEWW5bBip9nVtPA/HOaggTOJg==
X-Google-Smtp-Source: AGHT+IHrAowWJlFlabG6aYlY6Zdd0ztf2Dg4p0C675+6jMf7XUJ/dVtAnJOOBpOTMtL0KnCILEZUuw==
X-Received: by 2002:aa7:d996:0:b0:522:2d1b:5a38 with SMTP id u22-20020aa7d996000000b005222d1b5a38mr17428012eds.10.1696963848854;
        Tue, 10 Oct 2023 11:50:48 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id j17-20020aa7c411000000b0053635409213sm8044249edq.34.2023.10.10.11.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 11:50:48 -0700 (PDT)
Message-ID: <4bf848f2-94a6-d941-645b-42309def1900@blackwall.org>
Date:   Tue, 10 Oct 2023 21:50:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 00/11] Extend VXLAN driver to support FDB
 flushing
To:     Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc:     mlxsw@nvidia.com, idosch@nvidia.com, kuba@kernel.org,
        davem@davemloft.net, dsahern@kernel.org, roopa@nvidia.com,
        shuah@kernel.org, pabeni@redhat.com,
        bridge@lists.linux-foundation.org, linux-kselftest@vger.kernel.org
References: <20231009100618.2911374-1-amcohen@nvidia.com>
Content-Language: en-US
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/9/23 13:06, Amit Cohen wrote:
> The merge commit 92716869375b ("Merge branch 'br-flush-filtering'") added
> support for FDB flushing in bridge driver. Extend VXLAN driver to support
> FDB flushing also. Add support for filtering by fields which are relevant
> for VXLAN FDBs:
> * Source VNI
> * Nexthop ID
> * 'router' flag
> * Destination VNI
> * Destination Port
> * Destination IP
> 
> Without this set, flush for VXLAN device fails:
> $ bridge fdb flush dev vx10
> RTNETLINK answers: Operation not supported
> 
> With this set, such flush works with the relevant arguments, for example:
> $ bridge fdb flush dev vx10 vni 5000 dst 193.2.2.1
> < flush all vx10 entries with VNI 5000 and destination IP 193.2.2.1>
> 
> Some preparations are required, handle them before adding flushing support
> in VXLAN driver. See more details in commit messages.
> 
> Patch set overview:
> Patch #1 prepares flush policy to be used by VXLAN driver
> Patches #2-#3 are preparations in VXLAN driver
> Patch #4 adds an initial support for flushing in VXLAN driver
> Patches #5-#9 add support for filtering by several attributes
> Patch #10 adds a test for FDB flush with VXLAN
> Patch #11 extends the test to check FDB flush with bridge
> 
> Amit Cohen (11):
>    net: Handle bulk delete policy in bridge driver
>    vxlan: vxlan_core: Make vxlan_flush() more generic for future use
>    vxlan: vxlan_core: Do not skip default entry in vxlan_flush() by
>      default
>    vxlan: vxlan_core: Add support for FDB flush
>    vxlan: vxlan_core: Support FDB flushing by source VNI
>    vxlan: vxlan_core: Support FDB flushing by nexthop ID
>    vxlan: vxlan_core: Support FDB flushing by destination VNI
>    vxlan: vxlan_core: Support FDB flushing by destination port
>    vxlan: vxlan_core: Support FDB flushing by destination IP
>    selftests: Add test cases for FDB flush with VXLAN device
>    selftests: fdb_flush: Add test cases for FDB flush with bridge device
> 
>   drivers/net/vxlan/vxlan_core.c           | 207 +++++-
>   include/linux/netdevice.h                |   8 +-
>   net/bridge/br_fdb.c                      |  29 +-
>   net/bridge/br_private.h                  |   3 +-
>   net/core/rtnetlink.c                     |  27 +-
>   tools/testing/selftests/net/Makefile     |   1 +
>   tools/testing/selftests/net/fdb_flush.sh | 812 +++++++++++++++++++++++
>   7 files changed, 1049 insertions(+), 38 deletions(-)
>   create mode 100755 tools/testing/selftests/net/fdb_flush.sh
> 

Nice use of the flush api. :)
The set looks good to me. For the set:
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
