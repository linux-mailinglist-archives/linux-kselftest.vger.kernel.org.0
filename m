Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7594BC134
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 21:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbiBRUbd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 15:31:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiBRUbc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 15:31:32 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D91927DF0F
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:31:15 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id e79so8929742iof.13
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MD0+yom/goJw86HmBFQYbieNADbWQVLI9oz2PsE5hQw=;
        b=iSJ9BtKpkks5QWg/HyNH/d0nwba3DUPdbpYseZadQJYR+WbLw9W5GdAVq3LlwQ8YC1
         p3i/MF1om6JjWl5MKfpj5UlYKu8d2Kwh8fApeMSIx6zBK6tqCzm8vWzoH8RygxQcai4e
         3tQcsqBYEEeXiEwQpiKfCOd79bZLCWZ49uGpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MD0+yom/goJw86HmBFQYbieNADbWQVLI9oz2PsE5hQw=;
        b=N8bPqrd/kdR/WaDuehLBoHIH5oI4qr5+KzwDSmA24MLwBhpXeTdoWToT1iK+VWwrM7
         AoEFS/5hGTDAXTAQ5XxEJ2UX7V/DxiLCrOU4WK/XO4pIhD+0ZyVGkjMOegO+Gjcv6IEO
         vVwh7rndTnLdp6oqsu59VNDj+6MBM2Y/HGP0Eu10JAa+Gd8uCOXdTWqtd1q10OgBGll/
         b+rkNrGh5stc2iQcOogRJ2BJ/dMVG98HKil5avsXn6x8d2JAzU6P4mXFwVJ61aK13pSH
         2wLNAhOOC/oNXXd0aBP03eIBFir0WvvBARZwutO3nCOp2sDlvDpKUTairOl/rtFBFd52
         DwIg==
X-Gm-Message-State: AOAM533ju4vHeclFCxOQ1HogbIHi+Swf4zGcWSIYKmz/by0oxsM4vPci
        TZ6qz1rGLlxWwDpUEowzgOfHSA==
X-Google-Smtp-Source: ABdhPJzLumz6MWKjuTVGJYhGl9ZdR+pklktFrXSS/2eGSiG2/cVCh29UhIOrpEo/dbB1fCMmWwDZpA==
X-Received: by 2002:a02:6d6c:0:b0:30d:bfb2:84c with SMTP id e44-20020a026d6c000000b0030dbfb2084cmr6388052jaf.205.1645216274576;
        Fri, 18 Feb 2022 12:31:14 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id r7sm2055356ilc.24.2022.02.18.12.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 12:31:14 -0800 (PST)
Subject: Re: [PATCH v3 3/5] selftests/resctrl: Update README about using
 kselftest framework to build/run resctrl_tests
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
 <20220216022641.2998318-4-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e1e65afc-4842-29f9-679a-aa10b5cf72b3@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 13:31:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220216022641.2998318-4-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/15/22 7:26 PM, Shaopeng Tan wrote:
> In this patch series, I make restrl_tests build/run using kselftest
> framework, but some users do not known how to build/run resctrl_tests
> using kseltest framework.
> 
> Add manual of how to make resctrl_tests build/run
> using kselftest framework into README.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>   tools/testing/selftests/resctrl/README | 34 ++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
> index 3d2bbd4fa3aa..a0dd459049b7 100644
> --- a/tools/testing/selftests/resctrl/README
> +++ b/tools/testing/selftests/resctrl/README
> @@ -12,9 +12,43 @@ Allocation test on Intel RDT hardware. More tests will be added in the future.
>   And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
>   as well.
>   
> +resctrl_tests can be run with or without kselftest framework.
> +
> +USE KSELFTEST FRAMEWORK
> +-----------------------
> +
> +BUILD
> +-----
> +
> +Execute the following command in top level directory of the kernel source.
> +
> +Build resctrl:
> + $ make -C tools/testing/selftests TARGETS=resctrl
> +
> +Build all self tests:
> + $ make -C tools/testing/selftests
> +
> +RUN
> +---
> +
> +Run resctrl:
> + $ make -C tools/testing/selftests TARGETS=resctrl run_tests
> +

==================================
> +Run all self tests:
> + $ make -C tools/testing/selftests run_tests
> +

Remove the above
This part is relevant to this test. This is already documented in kselftest
doc.
==================================

> +Using kselftest framework, the ./resctrl_tests will be run without any parameters.
> +
> +More details about kselftest framework as follow.
> +Documentation/dev-tools/kselftest.rst
> +
> +NOT USE KSELFTEST FRAMEWORK
> +---------------------------
> +
>   BUILD
>   -----
>   
> +Execute the following command in this directory(tools/testing/selftests/resctrl/).
>   Run "make" to build executable file "resctrl_tests".
>   
>   RUN
> 

Add information how long it takes to run this test in here.

thanks,
-- Shuah
