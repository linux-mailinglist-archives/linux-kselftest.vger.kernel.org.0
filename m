Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13847718410
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjEaOBK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 10:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbjEaOAC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 10:00:02 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13839658B
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 06:54:19 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6af89b0f3e5so5434977a34.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1685541131; x=1688133131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lD9yHN4o7nABUYbshkKJYWoU9/xk8/GjzSI6eVrwvKI=;
        b=45/6n5a+AamlFEIKYx9XkCknXsUA09v7bdosEmyI7NaP+AB27ZN58Bp/4iT37Mo1NV
         W+ykYMGFNpHQLohL67lnVpFskLTl/kV0Cykdhtb34x0raj0YC66Gp/zUoLovn/496uy+
         CSPiNdla8dDZlkUH1Z7XijS4inzDzK9L1Zur4UXaFuMOK1dN9uT5xQpKcqtwN0KZ/DMa
         NXv7NkAo4FkPuzNu+SHy5oGOc0lndCytnHrc57O7o+HZIgTJ5HA2dd/jTGll4OuRu3c+
         dMr2VmI9Cu4l0QJemtQLa6qC5QR1ZKAqhWaD2fp3YxWULXSHJEkBCQN64p/cGW2Mtawl
         d9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685541131; x=1688133131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lD9yHN4o7nABUYbshkKJYWoU9/xk8/GjzSI6eVrwvKI=;
        b=EVuqg1uebIEMIoBoWtBdwVxIp1g/bqvFTCxvKEYTbgBwHPc4l1nd5/je+lnm7plQqt
         PwRCinnbfM1OjAoYZcsC6iTT+3itE1Fz6bib/Ph30EhA5mHuB0fwHar+DE2jRGLPUQqq
         WVl5oiZEdG0XNJ/kfRkfnAP2BaU1kFpN/YGuwhZIVAqQI8ahP9kwhMmHdjJSw8TWwGOg
         Ych1lir7QQF9KcT19P4kBy5VVUktDFuYfImRU2oCQAggI3b6h2b2QQGZeAudB0BZ5nyF
         f6leIXjxhl5O36kKR5HrDKayZKeH0fnqgP3a9akW62fTzXgTa6nu/3SlkGQP++XsAruB
         530w==
X-Gm-Message-State: AC+VfDybgBV4p18c8wImOm5hdyT71sKUdOU9xNPptodBmWmW+RPJlgOr
        1VSrg67HzytOp4VrNaxf/v+u2g==
X-Google-Smtp-Source: ACHHUZ5erSbp5Lnx9Qyre+fxIuHdO30vh4/ovX6sgYyX0jLx6YphLtTrf2hEGB7yC8S2/FqgBW6klw==
X-Received: by 2002:a05:6830:18db:b0:6a5:f583:10b5 with SMTP id v27-20020a05683018db00b006a5f58310b5mr2134135ote.28.1685541131022;
        Wed, 31 May 2023 06:52:11 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:39ba:f195:c3d1:73e8? ([2804:14d:5c5e:44fb:39ba:f195:c3d1:73e8])
        by smtp.gmail.com with ESMTPSA id q5-20020a9d6545000000b006ac543c984esm483946otl.21.2023.05.31.06.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:52:10 -0700 (PDT)
Message-ID: <4c5fc56d-3aac-643f-8d50-624a46db35e7@mojatatu.com>
Date:   Wed, 31 May 2023 10:52:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next] selftests/tc-testing: replace mq with invalid
 parent ID
Content-Language: en-US
To:     Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, shuah@kernel.org
Cc:     kuba@kernel.org, victor@mojatatu.com, peilin.ye@bytedance.com,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20230531072511.6927-1-shaozhengchao@huawei.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230531072511.6927-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 31/05/2023 04:25, Zhengchao Shao wrote:
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
> ---
>   .../tc-testing/tc-tests/qdiscs/mq.json        | 25 ++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json
> index 44fbfc6caec7..ddd4a48bfe65 100644
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
> +		"matchPattern": "qdisc fq_codel 0: parent ffff",

The default qdisc could be pfifo_fast or some other qdisc depending on 
the config file
Perhaps it's better to match against:
"qdisc [a-zA-Z0-9_]+ 0: parent ffff"

> +		"matchCount": "16",
> +		"teardown": [
> +			"echo \"1\" > /sys/bus/netdevsim/del_device"
> +		]
> +	}
>   ]

