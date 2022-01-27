Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4736C49EEA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 00:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiA0XMp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 18:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241228AbiA0XMm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 18:12:42 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76107C061714
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 15:12:42 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n17so5652822iod.4
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 15:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=918jrcgUxCmMB4m6j6zD1BiHXUVRw1xmSUCNvAW/T6A=;
        b=ORVUIOQy3M2i5QGsBDch0ugfsE1XTZsriSxre3J0UdyjrRcoBD67K/aSAzmtDoGQXT
         WLBvCYiG2NOWITuRevQbI47fyuwUY0xjlicb8pWRejT42XM90FPodc7JzMD1HVbIShkK
         tgk/g+0uUmIBFP4+sbPXm9ixdhakSm7ZO68sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=918jrcgUxCmMB4m6j6zD1BiHXUVRw1xmSUCNvAW/T6A=;
        b=Y8zkOAI4FYFe52Cvud2n7L7wwOaGzH0UAknFONhgEthDUP0H5RMH8gKr+KvgEIDIrL
         +TJgORQYRx+JtQDI7WSfWvNIacmJg6zNHBBYTap9Ae65BPofT4VMC+i804caoWKAtEV+
         DlHo1j2T4Oe8pqark6Gwx7h63JgLsk7s73fz0z0uiziUvITO/lqLjzdH758i5q9sBkMA
         5ACYGMPZWcj0vriwDj6/LuLo7eLUyrCsKx8dinlbLNLzxuzM6NzZ+WGGbQiRbl2KTRon
         v/DfkMzHgTW6htM9NlGrOdX6tkVAC3TCEe4Dr2o9QnG+trrMbM+W+tZ3D7O+9DL1nt/b
         8olA==
X-Gm-Message-State: AOAM533/BD/mEtgFNGw2e2M9T/ff7FcrDI1IAbbD+Lui46uk7YLBLOFa
        E2lL4xUxw/agl46Q+iizPS6wow==
X-Google-Smtp-Source: ABdhPJz0I8NyrzM/8XTUjRuHFl5a8Tn4Gq5A/jq2aVn+65DCpXVYK7QEYWrS9Lt98EFDhTL9CSln1g==
X-Received: by 2002:a05:6638:e90:: with SMTP id p16mr3305459jas.234.1643325161827;
        Thu, 27 Jan 2022 15:12:41 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id p5sm12109346iof.50.2022.01.27.15.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:12:41 -0800 (PST)
Subject: Re: [PATCH 4/5] selftests: openat2: Add missing dependency in
 Makefile
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
 <20220126102723.23300-5-cristian.marussi@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c5d165af-6f89-f94b-f6da-d0b231c72929@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 16:12:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126102723.23300-5-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/26/22 3:27 AM, Cristian Marussi wrote:
> Add a dependency on header helpers.h to the main target; while at that add
> to helpers.h also a missing include for bool types.
> 
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   tools/testing/selftests/openat2/Makefile  | 2 +-
>   tools/testing/selftests/openat2/helpers.h | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
> index 4b93b1417b86..843ba56d8e49 100644
> --- a/tools/testing/selftests/openat2/Makefile
> +++ b/tools/testing/selftests/openat2/Makefile
> @@ -5,4 +5,4 @@ TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
>   
>   include ../lib.mk
>   
> -$(TEST_GEN_PROGS): helpers.c
> +$(TEST_GEN_PROGS): helpers.c helpers.h
> diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
> index ad5d0ba5b6ce..7056340b9339 100644
> --- a/tools/testing/selftests/openat2/helpers.h
> +++ b/tools/testing/selftests/openat2/helpers.h
> @@ -9,6 +9,7 @@
>   
>   #define _GNU_SOURCE
>   #include <stdint.h>
> +#include <stdbool.h>
>   #include <errno.h>
>   #include <linux/types.h>
>   #include "../kselftest.h"
> 

Thanks for the patch. Will apply for linux-kselftest fixes branch for rc3

thanks,
-- Shuah
