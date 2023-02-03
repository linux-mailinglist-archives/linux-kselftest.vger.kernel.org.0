Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49364689F38
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 17:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjBCQ1z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 11:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjBCQ1y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 11:27:54 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46AAA6B98
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 08:27:43 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id m15so2255575ilh.9
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Feb 2023 08:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKR1Wdl7WNxwLolPEjOzG8wjWBYrr7iiPlWpSUy48RI=;
        b=b88CKLotwvVTUliNRNvkLwYHE/g71JhBaT7+PJU5rWg5p/uBZK8J+8VbT3uJlkjOQH
         5nXSc1U1NkSyUWuRRbXO0Il3BJZCZauicc+xUMPiqF7+LFTuq5Ms43ddv4tzyoPKQA1d
         SKwykdpB/ymS3nNcQgjZSiYiXv7JvPONGKA2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKR1Wdl7WNxwLolPEjOzG8wjWBYrr7iiPlWpSUy48RI=;
        b=0EEc7qYQLPmJ8emdQg4koDIUY2BudTGRaZIjE7lnw/GN+2R9zrd/DJvU/pq03Fe2E2
         Kk3lJVKwsbpgkPe+0EnSprQscRz6lDQrOEKXpfC35sUIiD9pVOcoY2HoC4R3h4KDQJKn
         w98I5yvCST8kN/iGTaaOSfcZ6rRHS9WyJiwGiLPzcO7pCcE0k7IbdvSV0PH26ZPxmhh5
         vkRIdWezvZByrRK6OUmy2dDXRB7lMWHtolaNQVxyvvl+FTkZVILKA8NAA+KZ8tvhdywH
         NL4BHusWlVvYopplNtPXfA0nKlRkZDEFyUzfbAXsvd/Y3Nei3mQCLe4kLPnDoEdbkPF8
         LgTQ==
X-Gm-Message-State: AO0yUKWZQF1bZoKJa8t2Q7AdMuTP2cuR4XW+gzJxwcX+k49/gHRBU8ZF
        Y1rwi1k10cvxXEakO1PQD8Gl4A==
X-Google-Smtp-Source: AK7set+wTtv42fUvIMilnudFpC9oQRcQf7/WbSZRvSBCLckSK/ikUG38j/3XQC34PhXHYIIy14idLA==
X-Received: by 2002:a05:6e02:1ba7:b0:310:b84b:c893 with SMTP id n7-20020a056e021ba700b00310b84bc893mr7865705ili.1.1675441662911;
        Fri, 03 Feb 2023 08:27:42 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f15-20020a056e0212af00b0030c2c6f5aa1sm886720ilr.70.2023.02.03.08.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 08:27:42 -0800 (PST)
Message-ID: <e18b57e3-f8f4-5c4c-c750-7ae53c5ae1e8@linuxfoundation.org>
Date:   Fri, 3 Feb 2023 09:27:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests: tpm2: remove redundant ord()
Content-Language: en-US
To:     Tzung-Bi Shih <tzungbi@kernel.org>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, jarkko@kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230203101430.901476-1-tzungbi@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230203101430.901476-1-tzungbi@kernel.org>
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

On 2/3/23 03:14, Tzung-Bi Shih wrote:
> When testing with FLAG_DEBUG enabled client, it emits the following
> error messages:
> 
> File "/root/tpm2/tpm2.py", line 347, in hex_dump
>      d = [format(ord(x), '02x') for x in d]
> File "/root/tpm2/tpm2.py", line 347, in <listcomp>
>      d = [format(ord(x), '02x') for x in d]
> TypeError: ord() expected string of length 1, but int found
> 
> The input of hex_dump() should be packed binary data.  Remove the
> ord().
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>   tools/testing/selftests/tpm2/tpm2.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
> index c7363c6764fc..bba8cb54548e 100644
> --- a/tools/testing/selftests/tpm2/tpm2.py
> +++ b/tools/testing/selftests/tpm2/tpm2.py
> @@ -344,7 +344,7 @@ def get_algorithm(name):
>   
>   
>   def hex_dump(d):
> -    d = [format(ord(x), '02x') for x in d]
> +    d = [format(x, '02x') for x in d]
>       d = [d[i: i + 16] for i in range(0, len(d), 16)]
>       d = [' '.join(x) for x in d]
>       d = os.linesep.join(d)

Thank you for the patch. It will appear shortly in linux-kselftest next
for Linux 6.3-rc1

thanks,
-- Shuah
