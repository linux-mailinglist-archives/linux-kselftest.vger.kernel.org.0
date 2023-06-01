Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42820719C3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 14:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjFAMfU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAMfU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 08:35:20 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C712C
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Jun 2023 05:35:18 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19f54a99cd5so467139fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Jun 2023 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1685622918; x=1688214918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ik2+mR4fS3dyHRfq9L02szHNt9KX9zHrkteyOimVbHk=;
        b=1qEcAN3a6Q/DauGVl1YiD2cIxaYLEGYr9XYtQbOXYzD/g+TLATcHGkiPS3+3H/nCnN
         Y2Cz8FxRakFmjtrscZ1KzRPn6OyOk8M7h2T6aGVNdB4qSdv28wjQxts6ebGKUr5QPXuu
         55R6et9K5tNWv02JScjeVdHejnzXOEb07KlJFoQfJhVOcUs8G8P7xvS1xxrNQtLzluij
         77lbm2qH0UvoWIM8yvlw6Q1Pfy+4GXakJkIISoz2W5h4kDYvsOEIupUXRr7N/FAVjLiJ
         5YoLwhsTu6zRiaXxas1BuuzSWduINBd3PxMyWfYl/qbchIoBvOZsW/ICzsk7krqWgKJ+
         JftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685622918; x=1688214918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ik2+mR4fS3dyHRfq9L02szHNt9KX9zHrkteyOimVbHk=;
        b=OItA6hVECn1BStiN8BFg6y3tYzLUDw1vjL8N/sQD5AP/5gLc549fvOU9OqvMnN/OKC
         HfuFo+rZn3gCgYWIV7lTymBzOfVh7qQJe/bdb2S3ux/owyIUg0RYVY/WV747/nbzgQj0
         PK2SVConTZYfh0+knADO2+zJxjIIGpEA4A5hinU2rP3FPjKLHloaWy5IOjM4nnLsuysk
         cQbhdjGGW1sniLJ6rJ/+CotrVoHCcEdz+f+vqTkDNJQpStUFS6Uc2gsOUyKF/jkfF49w
         Rb2Y1Xr53yt8XzOX+gjiHI8h4w/fuWCD+RLY8FBWh7GmwLX0etIea0GmhMkgVN1sYe0l
         Iilg==
X-Gm-Message-State: AC+VfDwhxN2JbYpUKGQcOysjbQDsJB5a1P1jbrg2t5QE1XSbSLHuBUky
        TXGGOxz5QHZQ0X+ItI2+x7aJ4K6IBh1ORH3Gh8w=
X-Google-Smtp-Source: ACHHUZ51uuvRKwSt89JYp1to9Rytyflm9R6jYGGkJumt07w2H7f+Op3aMTT9AL2BhIvf54/G2iWr6Q==
X-Received: by 2002:a05:6871:c10d:b0:196:87c5:8881 with SMTP id yq13-20020a056871c10d00b0019687c58881mr4225010oab.10.1685622917842;
        Thu, 01 Jun 2023 05:35:17 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:6aab:7933:6a5a:53d6? ([2804:14d:5c5e:44fb:6aab:7933:6a5a:53d6])
        by smtp.gmail.com with ESMTPSA id h43-20020a056870172b00b0019e9dd601c1sm1614690oae.55.2023.06.01.05.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 05:35:17 -0700 (PDT)
Message-ID: <4cea8b20-52dd-887e-88ce-f2af5ae95d74@mojatatu.com>
Date:   Thu, 1 Jun 2023 09:35:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next,v2] selftests/tc-testing: replace mq with invalid
 parent ID
Content-Language: en-US
To:     Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, shuah@kernel.org
Cc:     kuba@kernel.org, victor@mojatatu.com, peilin.ye@bytedance.com,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20230601012250.52738-1-shaozhengchao@huawei.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230601012250.52738-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 31/05/2023 22:22, Zhengchao Shao wrote:
> The test case shown in [1] triggers the kernel to access the null pointer.
> Therefore, add related test cases to mq.
> The test results are as follows:
> 
> ./tdc.py -e 0531
> 1..1
> ok 1 0531 - Replace mq with invalid parent ID
> 
> ./tdc.py -c mq
> 1..8
> ok 1 ce7d - Add mq Qdisc to multi-queue device (4 queues)
> ok 2 2f82 - Add mq Qdisc to multi-queue device (256 queues)
> ok 3 c525 - Add duplicate mq Qdisc
> ok 4 128a - Delete nonexistent mq Qdisc
> ok 5 03a9 - Delete mq Qdisc twice
> ok 6 be0f - Add mq Qdisc to single-queue device
> ok 7 1023 - Show mq class
> ok 8 0531 - Replace mq with invalid parent ID
> 
> [1] https://lore.kernel.org/all/20230527093747.3583502-1-shaozhengchao@huawei.com/
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

LGTM,

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
>   .../tc-testing/tc-tests/qdiscs/mq.json        | 25 ++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json
> index 44fbfc6caec7..e3d2de5c184f 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json
> @@ -155,5 +155,28 @@
>               "teardown": [
>                   "echo \"1\" > /sys/bus/netdevsim/del_device"
>               ]
> -        }
> +	},
> +	{
> +		"id": "0531",
> +		"name": "Replace mq with invalid parent ID",
> +		"category": [
> +			"qdisc",
> +			"mq"
> +		],
> +		"plugins": {
> +			"requires": "nsPlugin"
> +		},
> +		"setup": [
> +			"echo \"1 1 16\" > /sys/bus/netdevsim/new_device",
> +			"$TC qdisc add dev $ETH root handle ffff: mq"
> +		],
> +		"cmdUnderTest": "$TC qdisc replace dev $ETH parent ffff:fff1 handle ffff: mq",
> +		"expExitCode": "2",
> +		"verifyCmd": "$TC qdisc show dev $ETH",
> +		"matchPattern": "qdisc [a-zA-Z0-9_]+ 0: parent ffff",
> +		"matchCount": "16",
> +		"teardown": [
> +			"echo \"1\" > /sys/bus/netdevsim/del_device"
> +		]
> +	}
>   ]

