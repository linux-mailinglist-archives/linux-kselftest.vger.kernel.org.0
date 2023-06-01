Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9815C718FAA
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 02:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFAApT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 20:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjFAApQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 20:45:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803C0184;
        Wed, 31 May 2023 17:45:14 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QWnQX2wlFzLqGq;
        Thu,  1 Jun 2023 08:42:12 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 08:45:11 +0800
Message-ID: <490a0ae4-510b-0a37-0c67-286ee5c804ba@huawei.com>
Date:   Thu, 1 Jun 2023 08:45:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] selftests/tc-testing: replace mq with invalid
 parent ID
To:     Pedro Tammela <pctammela@mojatatu.com>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <shuah@kernel.org>
CC:     <kuba@kernel.org>, <victor@mojatatu.com>,
        <peilin.ye@bytedance.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>
References: <20230531072511.6927-1-shaozhengchao@huawei.com>
 <4c5fc56d-3aac-643f-8d50-624a46db35e7@mojatatu.com>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <4c5fc56d-3aac-643f-8d50-624a46db35e7@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/5/31 21:52, Pedro Tammela wrote:
> On 31/05/2023 04:25, Zhengchao Shao wrote:
>> The test case shown in [1] triggers the kernel to access the null 
>> pointer.
>> Therefore, add related test cases to mq.
>> The test results are as follows:
>>
>> ./tdc.py -e 0531
>> 1..1
>> ok 1 0531 - Replace mq with invalid parent ID
>>
>> ./tdc.py -c mq
>> 1..8
>> ok 1 ce7d - Add mq Qdisc to multi-queue device (4 queues)
>> ok 2 2f82 - Add mq Qdisc to multi-queue device (256 queues)
>> ok 3 c525 - Add duplicate mq Qdisc
>> ok 4 128a - Delete nonexistent mq Qdisc
>> ok 5 03a9 - Delete mq Qdisc twice
>> ok 6 be0f - Add mq Qdisc to single-queue device
>> ok 7 1023 - Show mq class
>> ok 8 0531 - Replace mq with invalid parent ID
>>
>> [1] 
>> https://lore.kernel.org/all/20230527093747.3583502-1-shaozhengchao@huawei.com/
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   .../tc-testing/tc-tests/qdiscs/mq.json        | 25 ++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git 
>> a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json 
>> b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json
>> index 44fbfc6caec7..ddd4a48bfe65 100644
>> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json
>> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json
>> @@ -155,5 +155,28 @@
>>               "teardown": [
>>                   "echo \"1\" > /sys/bus/netdevsim/del_device"
>>               ]
>> -        }
>> +    },
>> +    {
>> +        "id": "0531",
>> +        "name": "Replace mq with invalid parent ID",
>> +        "category": [
>> +            "qdisc",
>> +            "mq"
>> +        ],
>> +        "plugins": {
>> +            "requires": "nsPlugin"
>> +        },
>> +        "setup": [
>> +            "echo \"1 1 16\" > /sys/bus/netdevsim/new_device",
>> +            "$TC qdisc add dev $ETH root handle ffff: mq"
>> +        ],
>> +        "cmdUnderTest": "$TC qdisc replace dev $ETH parent ffff:fff1 
>> handle ffff: mq",
>> +        "expExitCode": "2",
>> +        "verifyCmd": "$TC qdisc show dev $ETH",
>> +        "matchPattern": "qdisc fq_codel 0: parent ffff",
> 
> The default qdisc could be pfifo_fast or some other qdisc depending on 
> the config file
> Perhaps it's better to match against:
> "qdisc [a-zA-Z0-9_]+ 0: parent ffff"
> 
Hi Pedro:
	You are right here.I will send V2. Thank you.

Zhengchao Shao
	
>> +        "matchCount": "16",
>> +        "teardown": [
>> +            "echo \"1\" > /sys/bus/netdevsim/del_device"
>> +        ]
>> +    }
>>   ]
> 
