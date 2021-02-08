Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F34B3143E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 00:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhBHXfS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 18:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhBHXfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 18:35:16 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96601C061793
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 15:34:27 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id m17so6364511ioy.4
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 15:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V7Ob39M3ldXlW/GI0Jg+VGMohhMLQXcOc9XaUahvpys=;
        b=C5viCxca4UjAdE93kvt0OcC3dUAaVccRiqZyAihDKopyqCRgFiqNbeSWb/YAgMFyqG
         3l477/lC1kuKWYo/FjXtzvzaDEHqSc1gCWcftkybq61C4K8+emNWFY5T16Qc6lgBdaTM
         MWYFz5+yqTBXJ+Ygjd1BCd46ck+x/ZYvRqRaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V7Ob39M3ldXlW/GI0Jg+VGMohhMLQXcOc9XaUahvpys=;
        b=QBzF95bdIVRk3XgonVg+KOn0oy2gAItQwd3JSSfI46A1f48us91PAhVNpnrfkARSk1
         3SJ1U0HC/uZAaqozbGyyvpnpE2RgiJlt0Qm1giAmSucDCdWG/lSBZWMyeYgdk5LwQxza
         pvI8qV5VTP/CRLsZo4CYzNyDkYwC2QF1OfLAnm+72M9dbLo+QBUqSm74d0nP9Ccl05pz
         oeycgxXI+NMqRcBdqGkAxPteeXhi31jvSAFOXTr5ij1kKG9Vm8RVWLKv6vTknl+pM/7Y
         CqU4ZdoFOgQJI+e7MXWDu5vnFLQVt+Ip4qKUa4+yL97l2VbSkYAoqjqp9yTXCL0UTDWc
         H3sw==
X-Gm-Message-State: AOAM5323l5bGC+uL5CnfSoSDkQQIrdD2Muxw76p8xKwBXue3hOk24vhU
        Fho5JRv+iXK89SUA+5o5RrK2wg==
X-Google-Smtp-Source: ABdhPJyDujO1fHiggWVRXAcgc6GBD/zoOQgp/rrkApaDJuyUftIAbAr/cdeBOXHbp6PfLAO4AHFJrg==
X-Received: by 2002:a02:9083:: with SMTP id x3mr16989646jaf.17.1612827267102;
        Mon, 08 Feb 2021 15:34:27 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o15sm9552363ilt.68.2021.02.08.15.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 15:34:26 -0800 (PST)
Subject: Re: [PATCH] selftests/x86/ldt_gdt: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1612683730-104353-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ba8e276a-7e80-9315-2f70-772aabe326db@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 16:34:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612683730-104353-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/7/21 12:42 AM, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./tools/testing/selftests/x86/ldt_gdt.c:610:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   tools/testing/selftests/x86/ldt_gdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/ldt_gdt.c b/tools/testing/selftests/x86/ldt_gdt.c
> index 1aef72d..3a29346 100644
> --- a/tools/testing/selftests/x86/ldt_gdt.c
> +++ b/tools/testing/selftests/x86/ldt_gdt.c
> @@ -607,7 +607,7 @@ static void do_multicpu_tests(void)
>   
>   		failures++;
>   		asm volatile ("mov %0, %%ss" : : "rm" (orig_ss));
> -	};
> +	}
>   
>   	ftx = 100;  /* Kill the thread. */
>   	syscall(SYS_futex, &ftx, FUTEX_WAKE, 0, NULL, NULL, 0);
> 

Thank you. Now applied to linux-kselftest next for 5.12-rc1

thanks,
-- Shuah
