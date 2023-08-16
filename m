Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F9277DD37
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjHPJXf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243314AbjHPJXG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 05:23:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B6426A9;
        Wed, 16 Aug 2023 02:22:41 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQjLQ50jqzrSDV;
        Wed, 16 Aug 2023 17:21:18 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:22:39 +0800
Message-ID: <a0ef07c7-91b0-94bd-240d-944a330fcabd@huawei.com>
Date:   Wed, 16 Aug 2023 17:22:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] selftests: bonding: remove redundant delete
 action of device link1_1
To:     Hangbin Liu <liuhangbin@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <j.vosburgh@gmail.com>, <andy@greyhouse.net>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230812084036.1834188-1-shaozhengchao@huawei.com>
 <ZNxorHjkyjktoj9m@Laptop-X1>
 <a363d616-eadb-2136-a445-f946c24cd66d@huawei.com>
 <ZNyJx1HtXaUzOkNA@Laptop-X1>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZNyJx1HtXaUzOkNA@Laptop-X1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/8/16 16:33, Hangbin Liu wrote:
> On Wed, Aug 16, 2023 at 03:55:30PM +0800, shaozhengchao wrote:
>>
>>
>> On 2023/8/16 14:11, Hangbin Liu wrote:
>>> On Sat, Aug 12, 2023 at 04:40:36PM +0800, Zhengchao Shao wrote:
>>>> When run command "ip netns delete client", device link1_1 has been
>>>> deleted. So, it is no need to delete link1_1 again. Remove it.
>>>
>> Hi Hangbin:
>>> What if the test exit because the cmd execute failed before setting
>>> link1_1 to netns client?
>>>
>>> Thanks
>>> Hangbin
>>>>
>> 	Your consideration is indeed possible.
>> "ip link del link1_1 >/dev/null 2>&1" maybe looks better?
> 
> I have not objects to this. On the other side, this only omit the error
> message. It doesn't fix anything.
> 
> Thanks
> Hangbin
	Yes, it will fix nothing, just clean up something.
I will add it later.

Also I run bond-break-lacpdu-tx.sh, it reports FAIL.
When the master is set up, the slave does not go up. It seems
that the mechanism has changed. But now I haven't had time
to analyze it in detail, maybe someone can do it.

Zhengchao Shao

