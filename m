Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8966764BC30
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 19:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiLMSiF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Dec 2022 13:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiLMSh7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Dec 2022 13:37:59 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C9CF6D
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Dec 2022 10:37:58 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id n63so2181570iod.7
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Dec 2022 10:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVw/Ub8n925hTRnFdUzvOTA/UBWQnS0OdDCK00ziL7s=;
        b=XrBbWdcrYPzuedqF0FgemXWCGtU7UrqvPAsmrbFXqGYJ28FAp6XGTo5oEn8x273sqU
         1n/9Yzgl1P7zdafD9gaHuWhGonKRYglyMefa//+e41c5/9SaL5CtXhV701foySxdl0f5
         yRDHeGzCpWk0jJ3+phN5yr8QuFGKRgubk9o+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVw/Ub8n925hTRnFdUzvOTA/UBWQnS0OdDCK00ziL7s=;
        b=mUTVNf/7NCO6NeHfsvt6cW2u58kXM5Eo4pXo/StmqSFzq5ayxtkZCj99mJXEJRYYpu
         CWkxambp13fDKH5frdrvXRxQ0NgyyA8ZDgJi9ekwQaQFHZcbaJcTuGncXvIAXhPhCj1B
         /NaOoZsXRdIm3sp4TqITKBgFntb73jABR8317E5qhpGAC9RXqqRNhtjVz5+ZHsWbtOqH
         0u7gTSiIRRptjL0Y7CAHIFGXyKhqUUO/IXJHRtp7eu1vkcMEIZg8w/+o+yMwHUXxTPJ7
         hpmE7k89N3eda0qaa1hjZfGpLsAkjNKXkslgBTNi+cdxbkwv59Ufpc/Lsg31bwv18A6q
         6eJQ==
X-Gm-Message-State: ANoB5pmQO+PzOupAXVyxek01v3crEIiUhh267clOOp6Zr3czqBE7Q1aX
        QibMe8b1P6JvcT8nQ1L4RmkkIw==
X-Google-Smtp-Source: AA0mqf7aJOMAxmp4CXqLPZfMIko49C01+d4Mm/IeX3PQ/xS4thygg7ozqQaxaFm0a2G0H35SvgIdew==
X-Received: by 2002:a6b:500e:0:b0:6e2:d3f7:3b60 with SMTP id e14-20020a6b500e000000b006e2d3f73b60mr2036775iob.2.1670956677330;
        Tue, 13 Dec 2022 10:37:57 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q18-20020a0566022f1200b006e2f42a30c2sm3596261iow.35.2022.12.13.10.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 10:37:56 -0800 (PST)
Message-ID: <2ee34e21-44bd-71e7-6da2-f4bea9a35452@linuxfoundation.org>
Date:   Tue, 13 Dec 2022 11:37:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] kselftest/alsa: Increase kselftest timeout
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221213183242.1908249-1-nfraprado@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221213183242.1908249-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/13/22 11:32, Nícolas F. R. A. Prado wrote:
> The default timeout for kselftests is 45 seconds, but pcm-test can take
> longer than that to run depending on the number of PCMs present on a
> device.
> 
> As a data point, running pcm-test on mt8192-asurada-spherion takes about
> 1m15s.
> 
> Set the timeout to 10 minutes, which should give enough slack to run the
> test even on devices with many PCMs.
> 

10 minutes is way too long.

> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>   tools/testing/selftests/alsa/settings | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 tools/testing/selftests/alsa/settings
> 
> diff --git a/tools/testing/selftests/alsa/settings b/tools/testing/selftests/alsa/settings
> new file mode 100644
> index 000000000000..a62d2fa1275c
> --- /dev/null
> +++ b/tools/testing/selftests/alsa/settings
> @@ -0,0 +1 @@
> +timeout=600

Adding timeouts like this especially 10 minutes will increase the time
it takes to run tests. We run the risk of people not wanting to run tests
anymore.

thanks,
-- Shuah


