Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1660750724D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiDSP6Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354094AbiDSP6Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 11:58:16 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B3B237C4
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 08:55:32 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r8so18575318oib.5
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8/le8KXETSx34GVaZzbTYz4RuO3FZ33ewlVPp4yPODs=;
        b=VvCMpocizhWdbwsHWWjmQm+alPJCsZjPAJ/7/6LNDiB6A2BIfvP8MnIX+AlLN5zCWQ
         UPKlTPnfOEiojap7T8h4Q8RfF7MjoxIa+y4HM6L6Cpw1SKUBNxpKBr8Ls4U7fVbiIEIh
         mBVWYybq+1Ea00BgLDR5qycV1JQsMKYpJWh4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8/le8KXETSx34GVaZzbTYz4RuO3FZ33ewlVPp4yPODs=;
        b=G6/7Mgikl2+eSVy2OLmqurdBoFapXp/6Gp+aNEx30grcV156bMqtrWhJPzjzsUq86E
         nLdtkHolbticDSPWx9a7PdkNnLMkT4j70e5kQnbX7HFHKxh4UzgLRF9ba0KzsDctJJ7m
         TBWNK3+NFntDvXmMi0nQyquTp3Z/ZYb4sq8FrhdGwZO3Z5Z0d/6pvkuewJu3E+x2Toj0
         E/aYZSzVmv8C0E9mQzMU13mmhAgQhRO7FAg2IqA74c65jUsMV5bPL+88Dy1HRzCCCgcI
         UcXehUs9jR8islZoh4I0hhHe0ySSy/GgEQHbCGJwYTLF6ah7lijI6p92QpAJlduCHmpB
         UHRw==
X-Gm-Message-State: AOAM530j1Nm+0cm75shLAQs9GldEmX01NKliNE/VhuCrxqBTJs1XrxG0
        RN+jm8NARt8B/U1JNnDAkPJLcw==
X-Google-Smtp-Source: ABdhPJzXqSXN+kGbIZS/42HLs8sHbwloBYDrxTEIguUExymTOoDdnaU6U0Wf3H67lBu4aQspJp5nzQ==
X-Received: by 2002:a05:6808:128c:b0:2da:3751:7639 with SMTP id a12-20020a056808128c00b002da37517639mr7779946oiw.294.1650383731978;
        Tue, 19 Apr 2022 08:55:31 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g8-20020acab608000000b002ecf38fb699sm5285821oif.38.2022.04.19.08.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 08:55:31 -0700 (PDT)
Subject: Re: [PATCH] kselftest/arm64: fix array_size.cocci warning
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220419032501.22790-1-guozhengkui@vivo.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a2e53307-5aa6-54c8-8bab-695f4e2e6cc7@linuxfoundation.org>
Date:   Tue, 19 Apr 2022 09:55:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220419032501.22790-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/18/22 9:24 PM, Guo Zhengkui wrote:
> Fix the following coccicheck warnings:
> tools/testing/selftests/arm64/mte/check_child_memory.c:110:25-26:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_child_memory.c:88:24-25:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_child_memory.c:90:20-21:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_child_memory.c:147:24-25:
> WARNING: Use ARRAY_SIZE
> 
> `ARRAY_SIZE` macro is defined in tools/testing/selftests/kselftest.h.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
