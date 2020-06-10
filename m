Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF38A1F58E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgFJQTE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jun 2020 12:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgFJQTD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jun 2020 12:19:03 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05597C03E96F
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jun 2020 09:19:03 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id 18so609732ooy.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jun 2020 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c4BI6qJGyzZVThLkKkzXe+RUQAfRoNQO65AznCnGs0c=;
        b=ZmEUvhL+feLEo/KIN1LNGrPEkcPqaPC1iYCkLfEY6E30tND56twEYrOrCx6RvkVQLS
         PZl9Utc3sXdl3MqKaChdt+uaOd/26i1I+Zcz/6TIF/y3s/Sgw6f1/stppapGsxYsyv0s
         QWNVFG+RjbkzzjzP2CgsL7vFA+2BwToBgP7zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c4BI6qJGyzZVThLkKkzXe+RUQAfRoNQO65AznCnGs0c=;
        b=hqzdANKG/J61gM1KwZ0KkkqhEmSmcX2UQ7AI0WZW2ymPK8N5P4pRQQt5bi12LwOoiV
         WS6yO8BeGaklWO1anammixXyt4oGNMuTxjrQbdvqHM8Sid0U2fvJKDtb5zltYwVHy4sG
         EEgoQ1Dx8nG2mbWf/S0MHHRlLyUmuIUxRrRD4PHvgKsIX1hV8LaXx1Brvs8oWoRSnBV6
         MTWNKKP4ru8+jz99LHgWVZalVcbOLXApsX+/BdGc9xEmJT8FJSHf7VOMCgDJk7Hddbs0
         o7hCZifXjtYWmVN3D8kJTy+H7C44W7P5ym6fNhuZOnRg4n8gslxs0snkwJpVX70NDnno
         RbhA==
X-Gm-Message-State: AOAM531oLQbSMQU51ze2m2YRuYKMTcswF8Gg6Bxc36N8t9jpUP7DTEz+
        u4Ld2d9rfxL8jVsbhKjK9Bc6ow==
X-Google-Smtp-Source: ABdhPJzkmrZoP749LWM5495c1Z2ZESXA5/2b9BwQ2lcVb97VBEK2JDC3CVDsKFJOhnrWqW4dExCOGA==
X-Received: by 2002:a4a:c501:: with SMTP id i1mr3105074ooq.65.1591805943124;
        Wed, 10 Jun 2020 09:19:03 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u62sm41305oib.47.2020.06.10.09.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 09:19:02 -0700 (PDT)
Subject: Re: [PATCH] kselftest: runner: fix TAP output for skipped tests
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200610154447.15826-1-pbonzini@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ac2c1eaa-acd7-7ac6-0666-6e6c0cbd546b@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 10:19:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610154447.15826-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/10/20 9:44 AM, Paolo Bonzini wrote:
> According to the TAP specification, a skipped test must be marked as "ok"
> and annotated with the SKIP directive, for example
> 
>     ok 23 # skip Insufficient flogiston pressure.
>     (https://testanything.org/tap-specification.html)
> 
> Fix the runner script to match this.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tools/testing/selftests/kselftest/runner.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 676b3a8b114d..f4815cbcd60f 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -77,7 +77,7 @@ run_one()
>   		echo "ok $test_num $TEST_HDR_MSG") ||
>   		(rc=$?;	\
>   		if [ $rc -eq $skip_rc ]; then	\
> -			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
> +			echo "ok $test_num $TEST_HDR_MSG # SKIP"
>   		elif [ $rc -eq $timeout_rc ]; then \
>   			echo "#"
>   			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
> 

Thanks. I will pull this in for Linux 5.8-rc2

thanks,
-- Shuah
