Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0834369D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhJUR5r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 13:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhJUR5q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 13:57:46 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB017C061764
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 10:55:30 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id m20so2081753iol.4
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2LtkF/468p93Y4YoTGIHUn5Ubw3qEnn8ZhP9111mEls=;
        b=X/JmnOR/qbdUlbj2jQFETd5boe5ncFPn05fdeq4gJ5mtxo14/HKHAjG2nJUb/nLG3P
         irihOf2cNrOT93p2TbTfrGdyu9G2GFbmlfTMRYlo7oy2jU4MVqE4oS4ZJs6BkaU7G0ok
         UkjkEoI8Wi6Gjw6p3N8H0JUeDE+aCJ2cQch0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2LtkF/468p93Y4YoTGIHUn5Ubw3qEnn8ZhP9111mEls=;
        b=7xz3ioySL7Lj5DcfrXoqynKXj9lJNU7psX3Ey6Ij/nXWGdSapC976ULIibpjx1P+I0
         0VLtVBqfGy2GN6GREPNiFiDkHpL5hG87oSjucmxlsmtACVd4ij1/xSwlwoiIlKJhFhrV
         hjj6uyJ9SbWSsif02kYd2C7o2tDT8X6GnprJngvvckz8y8b9WloHlT0VtZp/zcTwKgqk
         8wpq2JtBT4UF1utrWY8swz/TdohLTd2Jtytxae9hUzAfk5QhOFTSxEsl0tGzBSn+w6X5
         I83DOOPwBQ6Txpan8NajzO2CQj7li2vJc/2AJtnfFwZK1ci4eMkVmNXicv5GBJHQ4vsv
         mBkg==
X-Gm-Message-State: AOAM531IMfXimSqfzJ9/sHfuvvhAY96Fc3SsS1q8UtCmjjLlxUZdxx3e
        NPBL6Q5B38Oc9j2Ib+9tqMkXWg==
X-Google-Smtp-Source: ABdhPJy+Wc9KJqoNlxn4zBV85qrxZqyAU6YUhnEumlEloTAcXF62H2S8Zf8JHrR/fQ1l/G0gb2qcDw==
X-Received: by 2002:a05:6602:2d81:: with SMTP id k1mr5077114iow.87.1634838930227;
        Thu, 21 Oct 2021 10:55:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c5sm3018346ilq.71.2021.10.21.10.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 10:55:29 -0700 (PDT)
Subject: Re: [PATCH] selftests: kvm: fix mismatched fclose() after popen()
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211021175335.22241-1-skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <407e0a02-f7c3-f429-6e7d-3a60a14e09fa@linuxfoundation.org>
Date:   Thu, 21 Oct 2021 11:55:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211021175335.22241-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/21/21 11:53 AM, Shuah Khan wrote:
> get_warnings_count() foes fclose() using File * returned from popen().

Oops should have been "does". Sending v2 with that change now.

> Fix it to call pclose() as it should.
> 
> tools/testing/selftests/kvm/x86_64/mmio_warning_test
> x86_64/mmio_warning_test.c: In function ‘get_warnings_count’:
> x86_64/mmio_warning_test.c:87:9: warning: ‘fclose’ called on pointer returned from a mismatched allocation function [-Wmismatched-dealloc]
>     87 |         fclose(f);
>        |         ^~~~~~~~~
> x86_64/mmio_warning_test.c:84:13: note: returned from ‘popen’
>     84 |         f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/testing/selftests/kvm/x86_64/mmio_warning_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> index 8039e1eff938..9f55ccd169a1 100644
> --- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> @@ -84,7 +84,7 @@ int get_warnings_count(void)
>   	f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
>   	if (fscanf(f, "%d", &warnings) < 1)
>   		warnings = 0;
> -	fclose(f);
> +	pclose(f);
>   
>   	return warnings;
>   }
> 

thanks,
-- Shuah
