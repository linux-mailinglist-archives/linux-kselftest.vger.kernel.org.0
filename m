Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4664077C694
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 06:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjHOEDj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 00:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjHOEBO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 00:01:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747813E
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 20:57:48 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPyB32DbLzrRxd;
        Tue, 15 Aug 2023 11:56:27 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 11:57:45 +0800
Message-ID: <89d94875-5267-a2aa-a2aa-38f4b10f0e7e@huawei.com>
Date:   Tue, 15 Aug 2023 11:57:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next 3/4] kselftest/arm64: add pmull feature to hwcap
 test
To:     Mark Brown <broonie@kernel.org>
CC:     <shuah@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>, <xiexiuqi@huawei.com>
References: <20230814021747.1784812-1-zengheng4@huawei.com>
 <20230814021747.1784812-4-zengheng4@huawei.com>
 <3864eda1-0d02-42a2-ae9c-0d1eb3195a19@sirena.org.uk>
Content-Language: en-US
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <3864eda1-0d02-42a2-ae9c-0d1eb3195a19@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


在 2023/8/15 0:38, Mark Brown 写道:
> On Mon, Aug 14, 2023 at 10:17:46AM +0800, Zeng Heng wrote:
>
>>   	asm volatile("mrs x0, S3_3_C2_C4_0" : : : "x0");
>> @@ -359,6 +365,13 @@ static const struct hwcap_data {
>>   		.cpuinfo = "rng",
>>   		.sigill_fn = rng_sigill,
>>   	},
>> +	{
>> +		.name = "PMULL",
>> +		.at_hwcap = AT_HWCAP,
>> +		.hwcap_bit = HWCAP_PMULL,
>> +		.cpuinfo = "pmull",
>> +		.sigill_fn = pmull_sigill,
>> +	},
> Please keep the table alphabatically sorted - the function is in the
> right place but this seems to have got reordered.

Oops, sorry for that. I would update v2 and resend with your reviewed 
tag soon.

Thanks for your review.


Zeng Heng

