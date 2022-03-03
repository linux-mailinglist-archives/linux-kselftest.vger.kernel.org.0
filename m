Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493054CC5DE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 20:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiCCTSp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 14:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiCCTSo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 14:18:44 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAEBE0A0B
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 11:17:57 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id u2so4954060ioc.11
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 11:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dIqDQiM7oZs/BeAm16FgrVYsBf41PpL+82PUANl2efE=;
        b=VbzBMgxs6WZwlXJklAwiZKFWJ7clZ8uemIEDrZ9a+Slc24NctIzp0Lteo0SRTC/tNX
         kcbTfgilNPTu4GHlOJ1LPLRwpH8ZcgqZrUx3VS7TAhnOVPnmmuGIzwjJzuQcM1XuoxWM
         C9BN+I+ykFsAVp0Dz3uT6jaOtaC34e614vFaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dIqDQiM7oZs/BeAm16FgrVYsBf41PpL+82PUANl2efE=;
        b=WQwxj+DSWKxR5SRDVgzkBTHXdhtJUS0YUegAuuxsOB5c0CdP79QMBevJNPwwrm9AS/
         i9AHRvXu9ldXUkDvLpBI3VCXq2UXgfa+jx/oPGWUB/+d3ex5lrsux3FkxE2ES21WJJLu
         QblDydQuzqaIureOEoXeMIp759dMzKuh7xygdFCtnKBRwhayK5z7bvKpjD26ytNVZokn
         PP0CMdasbBKDdec1CSll7dQj0BB72RT54RQTqFG6rVYRAsSzVs9QRumPVplSzfPKnTx5
         lDqQGHJwNg9CpIO6vpH/92LTsaSwg5TABQjzxA4F7RUbUvt83CH5a3DmH5YMjPL3GdpV
         bITw==
X-Gm-Message-State: AOAM533/ErOa/EeDiKlVdQT47MXcNl+Wc/D8P3bqojY5mrVFWmBt+sHc
        EbnryrMv4bSF+cSv71qihmV+Ag==
X-Google-Smtp-Source: ABdhPJyMxq8kWRS3HIgVEN7K3EBss+x8+kqb5QDi+m7C3uCeZV0PLiOO9dFYs+bilk+WfhkIhG/MNQ==
X-Received: by 2002:a05:6638:2688:b0:314:e214:d996 with SMTP id o8-20020a056638268800b00314e214d996mr29676711jat.167.1646335077364;
        Thu, 03 Mar 2022 11:17:57 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g13-20020a5e8b0d000000b00641a04fc91esm2458362iok.19.2022.03.03.11.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 11:17:57 -0800 (PST)
Subject: Re: [PATCH 1/2] kselftest/vm: override TARGETS from arguments
To:     Chengming Zhou <zhouchengming@bytedance.com>,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220227055330.43087-1-zhouchengming@bytedance.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b29de093-72dd-1dc5-b591-2a75f49cdb2a@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 12:17:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220227055330.43087-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/26/22 10:53 PM, Chengming Zhou wrote:
> We can specify which testcases to build using TARGETS argument,
> for example: make -C tools/testing/selftests TARGETS=vm, cause
> the ordinary assignment of TARGETS in Makefile will be ignored.
> So we need to use override directive to change that.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>   tools/testing/selftests/vm/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 1607322a112c..0b330a5b1840 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -53,7 +53,7 @@ CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_progra
>   CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_64bit_program.c)
>   CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_program.c -no-pie)
>   
> -TARGETS := protection_keys
> +override TARGETS := protection_keys
>   BINARIES_32 := $(TARGETS:%=%_32)
>   BINARIES_64 := $(TARGETS:%=%_64)
>   
> 

Let's not override TARGETS - rename TARGETS in this file.
VM_TARGETS?

thanks,
-- Shuah
