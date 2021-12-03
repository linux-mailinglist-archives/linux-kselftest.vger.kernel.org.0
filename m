Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7830467D5F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 19:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359833AbhLCSiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 13:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358978AbhLCSiX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 13:38:23 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5189BC061751
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 10:34:59 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e128so4934602iof.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 10:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dvb4sebfbgF5tG7jNm/fwyVvE8C324Y2j6ohBL2yz/g=;
        b=AYvBrz6T9TLZMoIC9kskY1SI7yufrV/ryoGHXv440jZSnPh9Et0mg3C1O5GU8l3OXq
         Pwy8zESuOHjP9NdlIDKrtYk1lLpHUXaPdxChJZ40GWN5O/Yz1rOynaTkSrswJEoOuG8W
         rZJgo0ys6O7cyy0NXBGQEjPn4Ui3v3qZ/wg7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dvb4sebfbgF5tG7jNm/fwyVvE8C324Y2j6ohBL2yz/g=;
        b=c+x4TYxsQHgJWDw26t47orwFrIw3yrXfM3BWz7KBrIxC2ff61MkyhcWRyD/jacydBr
         XvZSTXys5siqer8JxKmNAZ2jYrnYjJBMfOct0BN/UMY4s3pfyAbNLGs/bOUeMAqHevRC
         MMOoOdPvkc7PTt1eyc77H7905zUAsdEqxtVScDHx9b/iXNgACNUWH4liLe7RLvzZykzr
         YymADyx2DYq/62ph16/i4+d1qOy/3JYqPQ4DTW7xWJDXzj4rMv0LbuS0AARUbQu77WME
         xmOmwIrGC4ZBUXiBFMS3YCzIktak10C8JfmzrRLAMCbwDANp44++UQltjYYGkQ+VFi3E
         D9ig==
X-Gm-Message-State: AOAM531pBv6+ihIzhxhBW6zXTXymVBLybbdRSQ3WhjdgPCXGfHkVWweC
        DhYUm1ZMqM3Z8clFDga+CUo1ew==
X-Google-Smtp-Source: ABdhPJxGTNb85pzcqMlNpqWNolTOrnkarUma79HNUyQhS0ohb1umtNL2ovXsv7ZwEJYoOeA40LrEoQ==
X-Received: by 2002:a02:ab8f:: with SMTP id t15mr27279823jan.147.1638556498668;
        Fri, 03 Dec 2021 10:34:58 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 11sm2153989ilq.23.2021.12.03.10.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:34:58 -0800 (PST)
Subject: Re: [PATCH] tests: remove unneeded conversion to bool
To:     davidcomponentone@gmail.com, shuah@kernel.org
Cc:     christian.brauner@ubuntu.com, ptikhomirov@virtuozzo.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <f1fe5f6b00e62a6f70c47f1d8b4c41d5d7d03d7d.1637736469.git.yang.guang5@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bc39340a-8daf-fbe2-1450-2f074608c08b@linuxfoundation.org>
Date:   Fri, 3 Dec 2021 11:34:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f1fe5f6b00e62a6f70c47f1d8b4c41d5d7d03d7d.1637736469.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/24/21 5:58 PM, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> The coccinelle report
> ./tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c:225:18-23:
> WARNING: conversion to bool not needed here
> Relational and logical operators evaluate to bool,
> explicit conversion is overly verbose and unneeded.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>   .../selftests/move_mount_set_group/move_mount_set_group_test.c  | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> index 860198f83a53..80ff0b692486 100644
> --- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> +++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> @@ -222,7 +222,7 @@ static int move_mount_set_group_supported(void)
>   		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
>   	umount2("/tmp", MNT_DETACH);
>   
> -	return ret < 0 ? false : true;
> +	return ret >= 0;
>   }
>   
>   FIXTURE(move_mount_set_group) {
> 

In this case it would be better to change the return type for
move_mount_set_group_supported() to bool

thanks,
-- Shuah
