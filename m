Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521924BC15E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 21:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiBRUr4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 15:47:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiBRUr4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 15:47:56 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731295C840
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:47:38 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id c14so5570478ilm.4
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=seyOzInEmBOK2khWWi7ynZA6kK6TQX/VzXUCVcuumxM=;
        b=h57t6hJJ+iEYbn79Z9qmlSbVkq4MXYHQjSwwS5th0KPxDULJSsHyP2k0Ht8wNUN5Cj
         piOGbntFjuFPkiiRwFDIYiF1O9Ngbuoxi+T2J0pZBnhzFew39rI1a0WyuqdwfP+Jmj0g
         Jc5oY+x2ZAZKocR07fnttJ0zybJ0owbUuIscQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=seyOzInEmBOK2khWWi7ynZA6kK6TQX/VzXUCVcuumxM=;
        b=m++zf4MBWYfNT00GS5z1Cqwzi6k3NTblpYCoALgxZbuJNLOwuCDst+2HYuAH8YMnqA
         aPy+7EpTi3KucGqnbznkHfBz3c/J57B36txRDNTWt7EzhQQJzIoID+n03ceeaU32VRp4
         Ll9QHWUR2AQZLjxgSciHUSX4qyZ4zn0KXwLj8kUHb4BtZmR4s2a7DQKEM1t5ORNS11q2
         1uJ8g81rp4jJ9vWoZ1Y22hMRXOqqoeCrTS4B1zPpZIUKC891CfrlT7tcMf4XGI0vhr8L
         oRcF0YVHFN7oaKjdlMa9LWVmE+TOoNLublNCNImpOsbPTceiovw3Zy3k1QUMvLgKYSFB
         Hv5A==
X-Gm-Message-State: AOAM532wl8iaPcnpw+FcD/M48qynNTddNwLlUAK16YZTvJWjIHbbWgME
        uShfqmlJKJxEDcL47uHF3B5mpw==
X-Google-Smtp-Source: ABdhPJw1cLFnbtXwffmJRQt5LlzZDtygc0zZaTvhXre36atdEMaiz3Hb85w6chacBei+XC4m5vVkVg==
X-Received: by 2002:a05:6e02:e0d:b0:2bf:5556:4c4a with SMTP id a13-20020a056e020e0d00b002bf55564c4amr6602003ilk.31.1645217257877;
        Fri, 18 Feb 2022 12:47:37 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id q5sm4479390ilu.64.2022.02.18.12.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 12:47:37 -0800 (PST)
Subject: Re: [PATCH] selftests/resctrl: Add missing SPDX license to Makefile
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216022826.2999382-1-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4e8297a0-f2a5-2bee-912e-005de2c03b50@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 13:47:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220216022826.2999382-1-tan.shaopeng@jp.fujitsu.com>
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

On 2/15/22 7:28 PM, Shaopeng Tan wrote:
> Add the missing SPDX(SPDX-License-Identifier) license header to
> tools/testing/selftests/resctrl/Makefile.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>   tools/testing/selftests/resctrl/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index de26638540ba..d661eb2df19b 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,3 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
>   CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
>   
>   TEST_GEN_PROGS := resctrl_tests
> 

This looks good to me. I will queue this up for Linux 5.18-rc1

thanks,
-- Shuah



