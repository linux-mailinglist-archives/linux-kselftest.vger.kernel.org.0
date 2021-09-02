Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A56B3FF55A
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346638AbhIBVJO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 17:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346697AbhIBVJH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 17:09:07 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5EFC061760
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Sep 2021 14:08:08 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f6so4358860iox.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Sep 2021 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QNlvKyocSbzCvO9CW/S4ozdKVMf5jmvLtYdfRVLUT7M=;
        b=HVStBy/xTTuVL0VzYJJW66/jAWAr/V7lfgEHeKg6iwJ02uaEz6Dc8TIqj9Kq/I0sSJ
         3itc1L722n6PfmlUXy+vMKnGA0weFwpA5jvORhsCJzNFjsQGSnP+pqzL0lqxvepcLH8J
         oFCQPo9L2ibV8EesfKMiiBkVrBA45JJjpG6K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QNlvKyocSbzCvO9CW/S4ozdKVMf5jmvLtYdfRVLUT7M=;
        b=KwgCxYx9K1LyOL77Eu+vWNl10EHZayFxvoj3WnWD9xyo3elvda3bUF68NT2RvC/GVO
         ho/Eddl67Xf+V/dnWmaOQkBCQ5jbc4Qof9xPxtwchkoj5p2+44olJQwKcQohtj1XDyn3
         VUywe+mC0Ks9cQdb6a7dI31b1bLfF3fWQuWOTyvG3VaWV0AcMJ9eJRjELZgJoO51VD/7
         kMYgkAyBJ2sqkIjLXa94mHGAq86R/0bNe5XCysf79ejqm43ru0CSMdTLhBQGRRez0bnR
         Auwj25A1KOH7TdtVBo0i0efdy5p1gUiOYzijQmCgGkAARME0B7+48pQhEccvITH0BO7J
         7DFg==
X-Gm-Message-State: AOAM533zfdUI8N17V59cyBZC88Y15hkFCVl1RP6JPOK2zriQ+aV/yRpd
        eCOorzKi2aLmR+hPRz0egmj83Q==
X-Google-Smtp-Source: ABdhPJwiMeCAqGbdJpdasKrAHyVZ+PwegE7nTHtqLYwVSFDWz29O+UKflzZ0URqfHKgBLoRUOmd1gA==
X-Received: by 2002:a05:6638:1646:: with SMTP id a6mr215464jat.27.1630616887436;
        Thu, 02 Sep 2021 14:08:07 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c11sm1469438ilo.57.2021.09.02.14.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 14:08:06 -0700 (PDT)
Subject: Re: [PATCH] selftests/gpio: Fix gpio compiling error
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, bamv2005@gmail.com,
        shuah@kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210902084635.103622-1-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <22f8bef6-a399-8579-b73a-5c6b96dd6145@linuxfoundation.org>
Date:   Thu, 2 Sep 2021 15:08:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210902084635.103622-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/2/21 2:46 AM, Li Zhijian wrote:

I like to see the reason for this compile error followed by how
it is fixed.

> [root@iaas-rpma gpio]# make
> gcc     gpio-mockup-cdev.c  -o /home/lizhijian/linux/tools/testing/selftests/gpio/gpio-mockup-cdev
> gpio-mockup-cdev.c: In function ‘request_line_v2’:
> gpio-mockup-cdev.c:24:30: error: storage size of ‘req’ isn’t known
>     24 |  struct gpio_v2_line_request req;
>        |                              ^~~
> gpio-mockup-cdev.c:32:14: error: ‘GPIO_V2_LINE_FLAG_OUTPUT’ undeclared (first use in this function); did you mean ‘GPIOLINE_FLAG_IS_OUT’?
>     32 |  if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
>        |              ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Search headers from linux tree like others, such as sched


> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>   tools/testing/selftests/gpio/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
> index 39f2bbe8dd3d..42ea7d2aa844 100644
> --- a/tools/testing/selftests/gpio/Makefile
> +++ b/tools/testing/selftests/gpio/Makefile
> @@ -3,5 +3,6 @@
>   TEST_PROGS := gpio-mockup.sh
>   TEST_FILES := gpio-mockup-sysfs.sh
>   TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev
> +CFLAGS += -I../../../../usr/include
>   
>   include ../lib.mk
> 

thanks,
-- Shuah
