Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822C83F900F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 23:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbhHZVOk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 17:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243650AbhHZVOk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 17:14:40 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4F7C0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 14:13:52 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s16so4723675ilo.9
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YnNHkI0gHMxJbA+95byWCLpuUzCuKxcTdcXyfiGVjUM=;
        b=e0vW1Xx1Is2NIpawZnNrC08LPD6fxUsKtJcyEjVpb2WVMF/GNz2YgUvjaW641LK2Jd
         3KSdxWgmNGuAR2NxBh/xbs+c3JVxHRK91pLvahGhQQjEx9sDeKs4+4UuZ4nABz2Z+RTQ
         5j1fqYj0DBJz9zI+xOZHBX5k2uh4UgYWSke/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YnNHkI0gHMxJbA+95byWCLpuUzCuKxcTdcXyfiGVjUM=;
        b=Qrxdx96sndmgz8hF1ua7Tktw2107mX1hh7GJvZDYsTuIMMU48RkG/cnvHyV1z+qieQ
         rO/u5kTRAk+Kwbz2RIEv2FjkQAUX7EmHsQqyPN2PdRkzNyEXQX0bmAViFLvTk1kSZVoZ
         weIpjSiU8G1gcZ3XrO13E3ukHBQWOTJ7M4xIz5c5aiZ6rmnIUnGTPm1MEDetbXnBTja0
         o9q95yfnmUAuS4UcB2GBxbw6MEBEtcktdoJ29SO2W9PNpmD7Uqv3Wv+j+RAnu9kKA1y4
         UZ/DkXadLBbUeOXk7D0qjpLCLEC8h2rMRjSMFFThSTzEz0JiVdaMLmem09pd0j3FL69e
         b3pg==
X-Gm-Message-State: AOAM532JhCMluvFcDmQhvLUig8FcHeCS9bRA7hzG005evLqnwyT0Vjzf
        5nmTPGO2MgeEQUsOrPEaLP2obQ==
X-Google-Smtp-Source: ABdhPJz5oXSrZWxoTTWZQvMf5h7OZQw2WyM2uqVRfptjmUsM1ETSh/FCcRmm+2MkK8kmJvjwtQ1w0A==
X-Received: by 2002:a92:c60b:: with SMTP id p11mr4013224ilm.65.1630012431656;
        Thu, 26 Aug 2021 14:13:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y11sm2133002iol.49.2021.08.26.14.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 14:13:51 -0700 (PDT)
Subject: Re: [PATCH] selftests: safesetid: Fix spelling mistake "cant" ->
 "can't"
To:     Colin King <colin.king@canonical.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210826121445.13062-1-colin.king@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a7e0507d-7e16-6e40-41eb-66141c1359ca@linuxfoundation.org>
Date:   Thu, 26 Aug 2021 15:13:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210826121445.13062-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/26/21 6:14 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   tools/testing/selftests/safesetid/safesetid-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
> index 0c4d50644c13..4b809c93ba36 100644
> --- a/tools/testing/selftests/safesetid/safesetid-test.c
> +++ b/tools/testing/selftests/safesetid/safesetid-test.c
> @@ -152,7 +152,7 @@ static void write_policies(void)
>   
>   	fd = open(add_whitelist_policy_file, O_WRONLY);
>   	if (fd < 0)
> -		die("cant open add_whitelist_policy file\n");
> +		die("can't open add_whitelist_policy file\n");
>   	written = write(fd, policy_str, strlen(policy_str));
>   	if (written != strlen(policy_str)) {
>   		if (written >= 0) {
> 

Thanks. Queuing this up for Linux 5.15-rc1.

thanks,
-- Shuah
