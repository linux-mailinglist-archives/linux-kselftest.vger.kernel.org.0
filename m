Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECAA68164D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 17:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjA3Q0v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 11:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbjA3QZB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 11:25:01 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51A93B3C5
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 08:24:59 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id g16so5335174ilr.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 08:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ya3wnMwrvg6taBiNfREM8J274pCjXCVFQeiXqbJA7+g=;
        b=V02BEAtbrMg6bxiPKWtAttJPxQhFx6Ob0vV4NjPELuMRkspfmXOmhgTRTz0qCJ93cx
         cmuw6ghW6RciHIjfCR8RvBgBKKjJ9xzJjoleq3abf/0C1yW+8/qQG5OHPy6vNYxrKVm7
         duuXvUM/bMiqbpeRT6znfjcS5me3WYoN8MDSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya3wnMwrvg6taBiNfREM8J274pCjXCVFQeiXqbJA7+g=;
        b=P0z109ISaxwSky2Uei/xMXnasYOIJ/aBbLwX6/E3Lc2GAmHWohngleqmIpMoDQUHGt
         Xjvp9bpjWTcIsRIIYAccUsB7GMqgE0BHRQidn2OaR+xnS1fPjWTRAFIMMqMp9/1o/3op
         IzdjoLzI6lkAYkhVzDuazXQFY4P6KepgiXfmoBDdVGeRmZfnn6vJDQmjXjjcv60DAPtK
         /bl5G1VxaowOKucFxTC5MWWwS2jfOdvikqx0NFKUwz36twHdD/dxB+8Bw7WBmnCPML+M
         TNQvc/T7yw01hC94UULeap1GpBINBGlJlI6JmRDQ3lmr6ein6fFCGWeyaLJMFtc5qNHM
         Px3g==
X-Gm-Message-State: AFqh2kqS/R5EoJ8QIBy4PQz02EIIur2V1Dv06lCUyCrxbL7AQ8PKHoD/
        B2lnKm5dLLeeJdQxnHQ8dcdZUFZ0Aun51R/a
X-Google-Smtp-Source: AMrXdXvK65fGYKTVgnNrq5WOSzPoOU6X5vLkyU5Mt7/T3zvd6okTMkIKVIS8y5Z3ocuGCG6rdy1PFw==
X-Received: by 2002:a92:2a07:0:b0:30c:1dda:42dd with SMTP id r7-20020a922a07000000b0030c1dda42ddmr7224521ile.1.1675095898633;
        Mon, 30 Jan 2023 08:24:58 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b7-20020a05663805a700b003afc548c3cdsm415088jar.166.2023.01.30.08.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 08:24:58 -0800 (PST)
Message-ID: <b054e29d-1a24-de64-43af-9e44d8f16c3e@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 09:24:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 17/34] selftests: net: Fix incorrect kernel headers search
 path
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Networking <netdev@vger.kernel.org>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <20230127135755.79929-18-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230127135755.79929-18-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/27/23 06:57, Mathieu Desnoyers wrote:
> Use $(KHDR_INCLUDES) as lookup path for kernel headers. This prevents
> building against kernel headers from the build environment in scenarios
> where kernel headers are installed into a specific output directory
> (O=...).
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: <stable@vger.kernel.org>    [5.18+]
> ---
>   tools/testing/selftests/net/Makefile             | 2 +-
>   tools/testing/selftests/net/bpf/Makefile         | 2 +-
>   tools/testing/selftests/net/mptcp/Makefile       | 2 +-
>   tools/testing/selftests/net/openvswitch/Makefile | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 

Adding net maintainers:

Would you me to take this patch through kselftest tree? If you
decide to take this through yours:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
