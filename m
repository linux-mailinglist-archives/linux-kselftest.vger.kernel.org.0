Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D2C4B5BAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 22:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiBNVAD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 16:00:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiBNVAA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 16:00:00 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F961331A9
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 12:59:44 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q204so21464609iod.8
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 12:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=04Ox5ixc4MPOE8Kua318ZsUJMu3rT8ky9xRJXJOyxF0=;
        b=aA8xCND2MGx+5OMZd1UPNNR3bzouVZeF3Pp/V3gAI6Y6VO3YKteYVgspznUv2NetBF
         Tc+o47xNGteAJPsCxg6xm0s7PLkDEAwdTocbmUrOX9vXxnJLf0YnFX9foX4HCjROGp2r
         J+OtRald/QoJMCAX6q501eL6WJoD9BwpZGyWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=04Ox5ixc4MPOE8Kua318ZsUJMu3rT8ky9xRJXJOyxF0=;
        b=VwA2oolE5DQZcTAjU6aO0p7T1QjQ3yZLYOqC5xlyVQt+nVak/biIpVUA7LCtCzr0c0
         4+KeWFl5Wk0cESjqYUP7RTcTo8x6h5QmoWjylEJwiqo03hABZYOiVS2Pfod0I45GX+qs
         r1gke/CG0hWPyKtosyltDRkxUvP5HUjPGTHdrweMMLeMOf+eKdGAB+yPQPHFRyjv/sji
         5LPwBegQ4CENMje7OejEi5L2UBRHOhbulOiRGXI0oWerpnRis8vh7k58hzvm7555QemJ
         DTShWWZBo3SBAPunAmyUCWAKdmJ1tJbH//mivIojdHbZWexdXaTjr8ndz8Va7gCG8sSX
         RIiA==
X-Gm-Message-State: AOAM530greWW9QViMsHCGm+vWJIY1y/eiYTJErI1zPi7DNVFCtIpELDJ
        ajw3MKapxbdQHMLQrkStPslfbg==
X-Google-Smtp-Source: ABdhPJxOoTHzsjxeSWDebsZYfsiGHhSEEz60eKm+tUhCUtGJPeoRbM/EPLiEntjejkgFvCzl/lMIBQ==
X-Received: by 2002:a05:6638:190a:: with SMTP id p10mr477555jal.313.1644872383619;
        Mon, 14 Feb 2022 12:59:43 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id w10sm21193066iow.44.2022.02.14.12.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 12:59:43 -0800 (PST)
Subject: Re: [PATCH V2 1/2] selftests: x86: add validity check and allow field
 splitting
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Borislav Petkov <bp@suse.de>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        David.Laight@ACULAB.COM
Cc:     kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220214184109.3739179-1-usama.anjum@collabora.com>
 <20220214184109.3739179-2-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8f62537f-e191-1d60-530a-9eb9c31b0511@linuxfoundation.org>
Date:   Mon, 14 Feb 2022 13:59:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220214184109.3739179-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/14/22 11:41 AM, Muhammad Usama Anjum wrote:
> Add check to test if CC has a string. CC can have multiple sub-strings
> like "ccache gcc". Erorr pops up if it is treated as single string and
> double quotes are used around it. This can be fixed by removing the
> quotes and not treating CC as a single string.
> 
> Fixes: e9886ace222e ("selftests, x86: Rework x86 target architecture detection")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in V2:
> Update if condition to check if CC has a string
> ---
>   tools/testing/selftests/x86/check_cc.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/check_cc.sh b/tools/testing/selftests/x86/check_cc.sh
> index 3e2089c8cf549..8c669c0d662ee 100755
> --- a/tools/testing/selftests/x86/check_cc.sh
> +++ b/tools/testing/selftests/x86/check_cc.sh
> @@ -7,7 +7,7 @@ CC="$1"
>   TESTPROG="$2"
>   shift 2
>   
> -if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
> +if [ -n "$CC" ] && $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
>       echo 1
>   else
>       echo 0
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
