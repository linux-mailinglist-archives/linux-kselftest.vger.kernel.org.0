Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D440CA71
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 18:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhIOQjJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 12:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOQjJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 12:39:09 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749FEC061574
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 09:37:50 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id j18so4208328ioj.8
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Nz/2E2PrP0EyYnOX/D4z45C7Q87NY/jFqlSGxgcBSw=;
        b=YSO6hITEUxm1tpML2V6mAcy4nBF4VlfDulFzHI7yUXXT+D8yXmEMaO/QWuQ2jt6dBb
         b+Qe0RolV7NB9SF6UYUMekD8oW5kOQcU6QuhwdBvmkRj4fBak1LvRkBl3zE9vmRSiXtd
         lRNThZk2FJYz2M5JZBpbvPUPd0Grnyg7cHOWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Nz/2E2PrP0EyYnOX/D4z45C7Q87NY/jFqlSGxgcBSw=;
        b=q3GGimR5Z5AYFwlPJikq7e5rcmVabnNYm0FpOczeN5BI+wGSJ/k3h90ndullJkYjrJ
         ulajl5aX5c4muWNp6ctD6Aw4ppZtzqOvY1vv4OsQxMynV7RsN6m8HPvK7IsL0vTmRivA
         /89vjVEhm6tE3QTYGE2ZhpyG2pzJawRgrXMn+VW/pjattbvb7l0BVtVyd2drh5WkQuPP
         zOp6gVXl3mAmYWjejQ4fx/7g3YnnPT9MaVWkouhCplkpiO7BOwwHCo/OCHyQ/K6YVg/e
         QWF69lNftkTNvJB7yD/VQqru7bmBUGZuXmeoT/VdNCQvQ+o7lcWipixh8oBeBckmzzlK
         rx3A==
X-Gm-Message-State: AOAM530UJ/+pTJkSI9I0yAozYrwObX8qFS9XdJ/tsa9KWiDSum91kxao
        regKbwjkG9Y7nK5AhZ935HbN1A==
X-Google-Smtp-Source: ABdhPJyVCrLvDDbQWbBJs3aeOai3WOMrD87VP+bTMx8uLA4Rk51h5yeIzK3nECkj12i49CJDKHtUeg==
X-Received: by 2002:a02:aa17:: with SMTP id r23mr796209jam.52.1631723869885;
        Wed, 15 Sep 2021 09:37:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x5sm211092ioa.35.2021.09.15.09.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:37:49 -0700 (PDT)
Subject: Re: [PATCH] selftests: be sure to make khdr before other targets
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210915134554.19581-1-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4f193721-39fd-bcb1-1e14-253c60ab4961@linuxfoundation.org>
Date:   Wed, 15 Sep 2021 10:37:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210915134554.19581-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/15/21 7:45 AM, Li Zhijian wrote:
> LKP/0Day reported some building errors about kvm, and errors message
> are not always same:
> - lib/x86_64/processor.c:1083:31: error: ‘KVM_CAP_NESTED_STATE’ undeclared
> (first use in this function); did you mean ‘KVM_CAP_PIT_STATE2’?
> - lib/test_util.c:189:30: error: ‘MAP_HUGE_16KB’ undeclared (first use
> in this function); did you mean ‘MAP_HUGE_16GB’?
> 
> Although kvm relies on the khdr, they still be built in parallel when -j
> is specified. In this case, it will cause compiling errors.
> 
> Here we mark target khdr as NOTPARALLEL to make it be always built
> first.
> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>   tools/testing/selftests/lib.mk | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 7ee911355328..5074b01f2a29 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -48,6 +48,7 @@ ARCH		?= $(SUBARCH)
>   # When local build is done, headers are installed in the default
>   # INSTALL_HDR_PATH usr/include.
>   .PHONY: khdr
> +.NOTPARALLEL:
>   khdr:
>   ifndef KSFT_KHDR_INSTALL_DONE
>   ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
> 

Thank you for the fix. Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/
fixes branch.

thanks,
-- Shuah
