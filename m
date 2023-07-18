Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FAB757171
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 03:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGRBoO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 21:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjGRBoN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 21:44:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25360E55;
        Mon, 17 Jul 2023 18:44:08 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R4hWP408BzLnp5;
        Tue, 18 Jul 2023 09:41:37 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 09:44:03 +0800
Message-ID: <6a643bc1-ca7f-a529-ec3c-c9a770b28f3b@huawei.com>
Date:   Tue, 18 Jul 2023 09:43:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net 1/3] selftests: tc: set timeout to 15 minutes
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Blakey <paulb@mellanox.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        <mptcp@lists.linux.dev>
CC:     Pedro Tammela <pctammela@mojatatu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <stable@vger.kernel.org>
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
 <20230713-tc-selftests-lkft-v1-1-1eb4fd3a96e7@tessares.net>
 <bf7f8867-6b14-dd53-a6e4-2addee4a5ad8@huawei.com>
 <3a47f676-d661-0b7a-701b-c4cafdc25394@tessares.net>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <3a47f676-d661-0b7a-701b-c4cafdc25394@tessares.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/7/17 16:32, Matthieu Baerts wrote:
> Hi Zhengchao Shao,
> 
> On 14/07/2023 04:25, shaozhengchao wrote:
>>
>>
>> On 2023/7/14 5:16, Matthieu Baerts wrote:
>>> When looking for something else in LKFT reports [1], I noticed that the
>>> TC selftest ended with a timeout error:
>>>
>>>     not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
>>>
>>> The timeout had been introduced 3 years ago, see the Fixes commit below.
>>>
>>> This timeout is only in place when executing the selftests via the
>>> kselftests runner scripts. I guess this is not what most TC devs are
>>> using and nobody noticed the issue before.
>>>
>>> The new timeout is set to 15 minutes as suggested by Pedro [2]. It looks
>>> like it is plenty more time than what it takes in "normal" conditions.
>>>
>>> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
>>> timeout per test")
>>> Cc: stable@vger.kernel.org
>>> Link:
>>> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log [1]
>>> Link:
>>> https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [2]
>>> Suggested-by: Pedro Tammela <pctammela@mojatatu.com>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> ---
>>>    tools/testing/selftests/tc-testing/settings | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/testing/selftests/tc-testing/settings
>>> b/tools/testing/selftests/tc-testing/settings
>>> new file mode 100644
>>> index 000000000000..e2206265f67c
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/tc-testing/settings
>>> @@ -0,0 +1 @@
>>> +timeout=900
>>>
>> I remember last year when I tested all the tdc cases（qdisc + filter +
>> action + infra） in my vm machine, it took me nearly 20 minutes.
>> So I think it should be more than 1200 seconds if all cases need to be
>> tested.
> 
> Thank you for your feedback!
> 
Hi Matthieu:
> Be careful that here, it is the timeout to run "tdc.sh" only which is
> currently limited to:
> 
>    ./tdc.py -c actions --nobuildebpf
>    ./tdc.py -c qdisc
> 
> (not "filter", nor "infra" then)
> 
> I guess for this, 15 minutes is more than enough, no?
> 
15 minutes is enough for qdisc and actions. Thanks.

> At least on my side, I ran it in a i386 VM without KVM and it took less
> than 3 minutes [1].
> 
> Cheers,
> Matt
> 
> [1]
> https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/tests/2SWHb7PJfqkUX1m8rLu3GXbsHE0/logs?format=html


Reviewed-by: Zhengchao Shao <shaozhengchao@huawei.com>
