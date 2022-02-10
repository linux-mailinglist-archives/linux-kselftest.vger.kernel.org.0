Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BAC4B173B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 21:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbiBJUwH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 15:52:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344321AbiBJUwG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 15:52:06 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8B410AA
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 12:52:05 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 9so9023955iou.2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 12:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZDmTcXbfCgXu5awEkEkH5h6M1B7QYIk5NA43T9cuepo=;
        b=gxHVZlPIYOHcQPLsLrfHJVOy+4sm5LiddBbY884K3dpEMzZVGPqLXx8cPls3wtGXE3
         T4KPGCLxJG7ZefY+MDFO2FYShWKMsTqbUUKXkOogoNUCmMBOcim8TauHAL1cEN/Di1sa
         E9Sp2Rz/bXncSrKDa1xsmtUGNe1p21Z1AAHiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZDmTcXbfCgXu5awEkEkH5h6M1B7QYIk5NA43T9cuepo=;
        b=HbtssW7fH6kVhXCTJEwl8QinoPFC0NNv0dltbK5kLpQyTN/jFrhZ4LWwOWhq7OdAAs
         TC8mUdknYTk9cPuIWAeu02UCssDWy2/foIcabE6FoPcXTPz+LCH6JzsZ32VsP3ztUF4S
         QqQaFLhkSjsjJ81U9ZqXsKG8+Fv1vKUXa2zT/rS7UdFUHFwWgmxbvruPWf1rbjzeDBMh
         DHa2CVKP7CwGZb0W0h1s1itu4706oH8nZCwtgQsN0VM1PoyEH9UoU7STrpAFIOsNOXyR
         bDMzQzDrWxHX7vISFjRAFYKGvHdBl5X4ITsfz/oxNT9drVXVSHCX460541EuNRNbZTVM
         V1VA==
X-Gm-Message-State: AOAM530hmxhvL7hfep/clEmSLrOkTLeV6XvgI1ZgLSFuf9vXRk5IInjD
        89nkjKvexvkPef2oVJySRrqDcQ==
X-Google-Smtp-Source: ABdhPJzrz7xQPZCYP3BEuJcYIkGZ8gXDQZXXiBB6HqpqMPptfSV1nxX3Wnr697ep6+rpXCCFXzHaCQ==
X-Received: by 2002:a02:b0c3:: with SMTP id w3mr4709002jah.37.1644526325191;
        Thu, 10 Feb 2022 12:52:05 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l6sm7179414ilt.16.2022.02.10.12.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 12:52:04 -0800 (PST)
Subject: Re: [PATCH 2/2] selftests: sgx: Treat CC as one argument
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>
References: <20220210190642.1477814-1-usama.anjum@collabora.com>
 <20220210190642.1477814-3-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2e40809b-fb03-24cb-d68c-c89b464be39b@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 13:52:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220210190642.1477814-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/10/22 12:06 PM, Muhammad Usama Anjum wrote:
> CC can have multiple sub-strings like "ccache gcc". For check_cc.sh,
> CC needs to be treated like one argument. Put double quotes around it to
> make CC one string and hence one argument.
> 
> Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/sgx/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
> index 2956584e1e37f..75af864e07b65 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -4,7 +4,7 @@ include ../lib.mk
>   
>   .PHONY: all clean
>   
> -CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh $(CC) \
> +CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh "$(CC)" \
>   			    ../x86/trivial_64bit_program.c)
>   
>   ifndef OBJCOPY
> 

The intent is testing if $CC is set. Does this change work when
$CC is not set?

thanks,
-- Shuah
