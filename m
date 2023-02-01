Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B452A6815FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 17:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjA3QKC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 11:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbjA3QJr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 11:09:47 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1B329435
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 08:09:44 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id z2so4724753ilq.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 08:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXYq15h/4ZLKt2G+EcISWRsOuJcnsCtCjpXE9jEI0g0=;
        b=UKkMAa9qC4Ipig3mVDQot+yXFGt+6hEaJxCimgNHz6eagi4zJHZyZPmOUBpjMFFy6R
         dPuQnffYzWc183hPcO9okTAqAYY83zo7rkHspTVLRODT8IUZyBmhLQKEpMOxtE+DIS8T
         di6i7x12tVpGjnv1lnirQI2aw6ni9VPCpl58g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXYq15h/4ZLKt2G+EcISWRsOuJcnsCtCjpXE9jEI0g0=;
        b=XDjcGGimQJKOQzM87BgZQDkJJbjBk7WJ/CMOw3vweK8qg76WtDQ9CoSfQEFT8nvMfV
         1GNBfIyikfAKjfvC0FFazomX7vWl9PMCUMPrODfftlFm1HQSggoUnT3F4lqAU+gB9gmI
         B/77bae3vzuLSymG4Yf+JQmjCIdUjC7Dnw5ds4SvQnOF1xw7xxjd/lRQCVSeXCF+ILJM
         tv8iZ9LGYsSM63eSeUfAm0eDtw3Epk1GhobAlcfQe5gu48HCxa8J1tCrCyQKKwHBzeOR
         05gQbh8iWs2hf82bXw0jFfxiAF86rptuPOGy3UcsZqBa2lEI9eSlvyeywNp4IaIT7UG7
         ASkA==
X-Gm-Message-State: AO0yUKVVGqn6TLD2hrZkgI/tHwjDtzLRXq9kJNV+cbe6wStFAfN39ZBT
        TZTkBe/ofYG/KXPVuZUSK8Y5kg==
X-Google-Smtp-Source: AK7set960M1U7OO/hYkoK6uNDLExUM4bktt4d7W/dz44m7y9LrWUxJRXDTIBrG+FcMSGpZIjBUQq6w==
X-Received: by 2002:a92:c68e:0:b0:310:9a08:ac86 with SMTP id o14-20020a92c68e000000b003109a08ac86mr3688809ilg.2.1675094983780;
        Mon, 30 Jan 2023 08:09:43 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k7-20020a02c647000000b0038437cba721sm4859803jan.7.2023.01.30.08.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 08:09:43 -0800 (PST)
Message-ID: <d44aa330-5767-58e0-77af-c6541252040b@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 09:09:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/34] selftests: arm64: Fix incorrect kernel headers
 search path
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <20230127135755.79929-2-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230127135755.79929-2-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
>   tools/testing/selftests/arm64/fp/Makefile   | 2 +-
>   tools/testing/selftests/arm64/tags/Makefile | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

Adding arm maintainers.

Would you me to take this patch through kselftest tree? If you
decide to take this through yours:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

