Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBDD4F6C09
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 23:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiDFVEi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Apr 2022 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbiDFVDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Apr 2022 17:03:45 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903941EE9FB
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Apr 2022 12:35:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r8so3481920oib.5
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Apr 2022 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QVhp+oyIa/ZllpX8afFD131iOJTpV5esF+kDy6nIUFY=;
        b=HgxbkHUhuJvQIkFDYaw/Dp2LQE2zRcf1CkgHx1kUrq0xvW/V/GEu7+AjF8VCb8IGOP
         nitc6UvlE6MaW9iwZ1qvYWipMLuuxAA3wMBe/Dmitmz4ZPCFlTWrqOY8g7IVkDN7fs/u
         lqW3P2lqjbzxYE8Nd+h/VX85rry5jYlkSiw1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QVhp+oyIa/ZllpX8afFD131iOJTpV5esF+kDy6nIUFY=;
        b=bEcV8f1CJGcjNksXuxicTBlsP4mMt158uRewLCobaPfIUM0syDhFg4d9fiEn0U41Wb
         QzPgjNc7VmYkS2h0jSuUTHGqeqNbSiMTQLzSxFVntHKfYc4X0eEVoclEozU512rwZUSU
         2bT4GqZckql7VUQ9MvayRgWDSGj78YOx79R33qj6/kLqJsOTfzp+zslNBBvzI1iLOoGy
         QAbYk35DpUYhQo6CWjMpBcIcWRoX2smjbKYJQRmwNC5EmNX6ltUEYIbHb+9EsQu0MrFv
         3BqM7p4mnn1xq9iIi/HI+RJx+ntzHnFOTv5l90oFDVSNXr5qpipCGNtZoBrERF5pPvLe
         cELw==
X-Gm-Message-State: AOAM533Nrhkuw8Pi/j1bmkoq/vazDtKgDchM/8zCLQpirtKMglX8NMi1
        cXpinyZLPKZftZ/9sTrEKJMfIQ==
X-Google-Smtp-Source: ABdhPJzm/gKiGpEr+gwntVR94hfCF6tfBlp1C8ybj2Wd8yVQtgbSoJw+PS/dD3rllmcpuI0r0eDpfw==
X-Received: by 2002:a05:6808:613:b0:2ec:f542:4a7b with SMTP id y19-20020a056808061300b002ecf5424a7bmr4301008oih.76.1649273726860;
        Wed, 06 Apr 2022 12:35:26 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o19-20020a056870969300b000dea1b17aacsm2536208oaq.36.2022.04.06.12.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 12:35:26 -0700 (PDT)
Subject: Re: [PATCH v2] selftest/vm clarify error statement in gup_test
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, shuah@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220405214809.3351223-1-sidhartha.kumar@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c0ba950a-9210-1a73-dc6b-6655fcda9878@linuxfoundation.org>
Date:   Wed, 6 Apr 2022 13:35:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220405214809.3351223-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/5/22 3:48 PM, Sidhartha Kumar wrote:
> Print three possible reasons /sys/kernel/debug/gup_test
> cannot be opened to help users of this test diagnose
> failures.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
> v2:
> - Add support for skipping the test due to unmet dependencies.
> - Use errno to print a more specific message.
> - Add check for root privileges.
> - dropped CC to stable.
>   tools/testing/selftests/vm/gup_test.c     | 22 +++++++++++++--
>   tools/testing/selftests/vm/run_vmtests.sh | 33 ++++++++++++++++-------
>   2 files changed, 44 insertions(+), 11 deletions(-)
> 

Thank you for fixing the reporting and adding tests for dependencies
and skip conditions.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
