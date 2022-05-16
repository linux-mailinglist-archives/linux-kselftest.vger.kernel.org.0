Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7B528F34
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 21:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiEPTxR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 15:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347901AbiEPTwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 15:52:24 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB044A36
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 12:48:04 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a10so17096490ioe.9
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jv0Y4sH5q/+cOZfXrfwTFO+h4KwTbyJ3ZtbRwi7S/Lw=;
        b=ew4Tb8MqwPRgVuYAPzp9N7lmT/ezFUb7lubqLPv59RNbYaQaoA5L8MiagwGWoqJS+m
         mJSCtEETbHjNrCvgJ3WxZXwSyGLzGP0KKuvPZ5QT89vJo9753DV3+XFIuNU2CrNgdlkq
         AGGAZK+plrK3X/ebH1vd4e3nGfSjYYXbUQz5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jv0Y4sH5q/+cOZfXrfwTFO+h4KwTbyJ3ZtbRwi7S/Lw=;
        b=fQGgYg0B5tM3vYMWWZ219niIkqPrF5+6b6/IvxzITYrB5Wiln7sVFs8BDInaz9EQSR
         6Xe7Hk44CAtNDfhY1QqbeNXPquBKV9iDpknypT/QplFLAJb1+gyuF7EyoitQLU3TYDO4
         DcjwIkMQnE4imd3QTctJGU0xRdLoQyB/7tt+Oo9zphBloOekP1Fv2llXXM9eq+bAfz0a
         OH9nF3S2RAfdyWpkm3/9EyTmrtf7zdbVgn9lkl5Zv/qnwi/4p5lNf5ct+st+nYyGMh7z
         xhQk8eFlt0eaR2GFhlD3KwRsNxBnKFCxHfncdMGZ2Dvr/F7uFbBqwjoPZCvbpXZ1/Ns5
         nGZg==
X-Gm-Message-State: AOAM532JWrt35A2p94oq0a1Rejy00UdCyvCa91GcbRLhH5j8cWxNt+j+
        FWgBkyk8/IP6mrbtIb+VyhdW6w==
X-Google-Smtp-Source: ABdhPJyAdniB3khueIn2Dh+Ov6csoMG5jsxnWQuJefh/OMfBiYSo9cbu73uQvNWHPrzQHmVDZjn2ww==
X-Received: by 2002:a05:6638:2191:b0:32b:b7af:1228 with SMTP id s17-20020a056638219100b0032bb7af1228mr10056071jaj.13.1652730482764;
        Mon, 16 May 2022 12:48:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p12-20020a056e02104c00b002cd7dc16ae4sm88740ilj.1.2022.05.16.12.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 12:48:02 -0700 (PDT)
Subject: Re: [PATCH] kselftests/ir : Improve readability of modprobe error
 message
To:     Gautam Menghani <gautammenghani201@gmail.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220513190721.16482-1-gautammenghani201@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a763b159-0072-b883-5e47-65f86bec66dd@linuxfoundation.org>
Date:   Mon, 16 May 2022 13:48:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220513190721.16482-1-gautammenghani201@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/13/22 1:07 PM, Gautam Menghani wrote:
> Improve the readability of error message which says module not found.
> The new behaviour is consistent with the modprobe command.
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>   tools/testing/selftests/ir/ir_loopback.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ir/ir_loopback.sh b/tools/testing/selftests/ir/ir_loopback.sh
> index b90dc9939f45..aff9299c9416 100755
> --- a/tools/testing/selftests/ir/ir_loopback.sh
> +++ b/tools/testing/selftests/ir/ir_loopback.sh
> @@ -10,7 +10,7 @@ if [ $UID != 0 ]; then
>   fi
>   
>   if ! /sbin/modprobe -q -n rc-loopback; then
> -        echo "ir_loopback: module rc-loopback is not found [SKIP]"
> +        echo "ir_loopback: module rc-loopback is not found in /lib/modules/`uname -r` [SKIP]"
>           exit $ksft_skip
>   fi
>   
> 

Applied to linux-kselftest next for 5.19-rc1

thanks,
-- Shuah
