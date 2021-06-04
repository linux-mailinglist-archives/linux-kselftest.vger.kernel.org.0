Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B386B39C289
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jun 2021 23:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFDVgu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Jun 2021 17:36:50 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38643 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFDVgt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Jun 2021 17:36:49 -0400
Received: by mail-ot1-f48.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so10455999otk.5
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jun 2021 14:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=janzFmwZwQn6MiazfcV23K2Rys/KSeJAT5SN2x0frTo=;
        b=bcQtEHquS30yyvQ1kaHKFd0tJs1enDS2ZJKgq5iUoQtEm6r0yiMZiw/9nmFtMJNiNZ
         stEiJqpVzujWqqEYCXu2byslnfJgFdzX7Xj6qMO1hXyOHrZDMV2BljucQcgOtDjpIJmv
         AFcNQ8o7aPfAkwgc/F3Db8ElR57G6hwgPtRWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=janzFmwZwQn6MiazfcV23K2Rys/KSeJAT5SN2x0frTo=;
        b=lSA3xNmVBHsYTwh1fUKr/kMhBUERHehPok+p4XHqA2o06OjeH7VyzSjfyuPkp4sXFe
         vAruszZkocYeg5zcwM6yO7Ladnw5l0uEj9zpDBQFZFX18cIpcv8KuvGlOcpoZ00m4jpu
         e3U6nO47kfkTA+ys5V1WsMrv6Fx8wjhHNBsFl2rC0BGssmAOO03UibxUM/C98R86UR1q
         L/RZABpzbOHXsNg73z/iWJCh0AVFvxev6LPip1PUyxREASsshuBM5ONU6zD+mo0mYBvt
         T2PAmQI1ul2311R0JQihi3q9vlFP34Yda04l/xEU5B4H2W0M0XGnR6JBWaZdjHsu4Suh
         7B6Q==
X-Gm-Message-State: AOAM532D5sirFa1QC8ECjRFyEQOiSU4OiUe9XGl+NttXLr7tXR0zWFad
        a8ANBa91VdO+YCQh+ZqfMJhPag==
X-Google-Smtp-Source: ABdhPJx8D1/TaC5pTiA1cnV7ygPBTV4NHHVAq024vEq925p4hG2T8oj2kwVnvQNCBXNvuAcH13uL8g==
X-Received: by 2002:a9d:4f18:: with SMTP id d24mr5147979otl.16.1622842442990;
        Fri, 04 Jun 2021 14:34:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l7sm714950otu.76.2021.06.04.14.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 14:34:02 -0700 (PDT)
Subject: Re: [PATCH] selftests/tls: Add {} to avoid static checker warning
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210527032718.3730773-1-keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1c391e24-15d1-9be4-c32f-4677912359f9@linuxfoundation.org>
Date:   Fri, 4 Jun 2021 15:34:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527032718.3730773-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/26/21 9:27 PM, Kees Cook wrote:
> This silences a static checker warning due to the unusual macro
> construction of EXPECT_*() by adding explicit {}s around the enclosing
> while loop.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 7f657d5bf507 ("selftests: tls: add selftests for TLS sockets")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   tools/testing/selftests/net/tls.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
> index 426d07875a48..7119f8eb823b 100644
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c
> @@ -418,8 +418,9 @@ TEST_F(tls, sendmsg_large)
>   		EXPECT_EQ(sendmsg(self->cfd, &msg, 0), send_len);
>   	}
>   
> -	while (recvs++ < sends)
> +	while (recvs++ < sends) {
>   		EXPECT_NE(recv(self->fd, mem, send_len, 0), -1);
> +	}
>   
>   	free(mem);
>   }
> 

Will pick this up for 5.14

thanks,
-- Shuah
