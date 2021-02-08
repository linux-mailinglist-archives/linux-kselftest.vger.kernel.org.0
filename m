Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB363143D5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 00:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBHXeg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 18:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBHXeg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 18:34:36 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6EEC061786
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 15:33:56 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id j5so16847458iog.11
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 15:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1RkSumXgFbifK19xnhA0y1wci8RIXXXC9d0wD+ipx2w=;
        b=FUXmQ0qqVlsaaPulIH4efsX6a3pBJHY43UofmlXJqk+zN/AJ65fw5J74k5PeQBThtn
         mJ+mLylL5do4fotCZjq39arwX6unhjNoaX8WQhWBUxs1CeK1mFmHgCO+v2WMIdvJqlzm
         wZArCWF+/9NzU1KcEPqdDykoGdzpIK7rPBxSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1RkSumXgFbifK19xnhA0y1wci8RIXXXC9d0wD+ipx2w=;
        b=ELVS6eS3F4gzl83BfhKU3DZ52dJCCKKQqr7ZNn9nCj3UKCAdKPPH4SNewAcNRBwhjG
         kWiRUDlZug3L2b01cLfHoVbVBVRwhZ7QN1SnVlYXTAQdderkuHVFrNITL1s4ZqWGKSfo
         l0XS87nlLIqsDPuqXRFJB2M7kQitqgGFG4CP9lk9OmZw9sPn4Y61aGsuSqjt9L/USJug
         ARkR3mttP76CW8dKPLkElUooYKab6pTZVhLx57q4raj1dUjgb/ElmSnf/unv1YYIEnDa
         1uxdCTi1df0z4ZmEkh7TKEyM/KNgT1Tob7KXpJKynCyQ9HAL7YclOALhIlgxh164WSFM
         9TbA==
X-Gm-Message-State: AOAM533W4Q38vfSaNuulFI9rgpjHEXTNC9upAm8ZwvjhuzUbj7ZjzfII
        PL5R3isXUDfL9OQK1ZHrQVKIGQ==
X-Google-Smtp-Source: ABdhPJxYsZIxSz+PeWuzU/mVsPeSqy6iv+ztT3NWWkfx3daXYsL544wTQNJTwgP0skkBQHewIEdLiQ==
X-Received: by 2002:a02:cd37:: with SMTP id h23mr19658663jaq.29.1612827235572;
        Mon, 08 Feb 2021 15:33:55 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f15sm9510502ilj.23.2021.02.08.15.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 15:33:54 -0800 (PST)
Subject: Re: [PATCH] selftests/ipc: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>, shuah@kernel.org
Cc:     tyhicks@linux.microsoft.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1612779840-77555-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <75573614-2915-54fd-9da1-9d979feaae96@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 16:33:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612779840-77555-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/8/21 3:24 AM, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./tools/testing/selftests/ipc/msgque.c:72:3-4: Unneeded semicolon
> ./tools/testing/selftests/ipc/msgque.c:183:2-3: Unneeded semicolon
> ./tools/testing/selftests/ipc/msgque.c:191:2-3: Unneeded semicolon
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   tools/testing/selftests/ipc/msgque.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
> index 5ec4d9e..656c43c 100644
> --- a/tools/testing/selftests/ipc/msgque.c
> +++ b/tools/testing/selftests/ipc/msgque.c
> @@ -69,7 +69,7 @@ int restore_queue(struct msgque_data *msgque)
>   			printf("msgsnd failed (%m)\n");
>   			ret = -errno;
>   			goto destroy;
> -		};
> +		}
>   	}
>   	return 0;
>   
> @@ -180,7 +180,7 @@ int fill_msgque(struct msgque_data *msgque)
>   				IPC_NOWAIT) != 0) {
>   		printf("First message send failed (%m)\n");
>   		return -errno;
> -	};
> +	}
>   
>   	msgbuf.mtype = ANOTHER_MSG_TYPE;
>   	memcpy(msgbuf.mtext, ANOTHER_TEST_STRING, sizeof(ANOTHER_TEST_STRING));
> @@ -188,7 +188,7 @@ int fill_msgque(struct msgque_data *msgque)
>   				IPC_NOWAIT) != 0) {
>   		printf("Second message send failed (%m)\n");
>   		return -errno;
> -	};
> +	}
>   	return 0;
>   }
>   
> 

Thank you. Now applied to linux-kselftest next for 5.12-rc1

thanks,
-- Shuah
