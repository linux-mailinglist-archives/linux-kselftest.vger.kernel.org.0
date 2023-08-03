Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8963176E8B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 14:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjHCMpU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 08:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjHCMpT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 08:45:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971C73588
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 05:45:17 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RGpSW5c58z1K9RV;
        Thu,  3 Aug 2023 20:44:11 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 20:45:14 +0800
Message-ID: <8a78b634-1097-a2a7-985e-3a07d52a271f@huawei.com>
Date:   Thu, 3 Aug 2023 20:45:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] kselftest/arm64: add RCpc load-acquire to the tested
 hwcaps
To:     Mark Brown <broonie@kernel.org>
CC:     <will@kernel.org>, <shuah@kernel.org>, <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>, <xiexiuqi@huawei.com>
References: <20230803070231.3962475-1-zengheng4@huawei.com>
 <54792955-9bd1-417f-8000-8e95f06a76d3@sirena.org.uk>
Content-Language: en-US
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <54792955-9bd1-417f-8000-8e95f06a76d3@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


在 2023/8/3 19:36, Mark Brown 写道:
> On Thu, Aug 03, 2023 at 03:02:31PM +0800, Zeng Heng wrote:
>
>> @@ -364,6 +376,20 @@ static const struct hwcap_data {
>>   		.hwcap_bit = HWCAP2_SVE_EBF16,
>>   		.cpuinfo = "sveebf16",
>>   	},
>> +	{
>> +		.name = "RCpc load-acquire",
>> +		.at_hwcap = AT_HWCAP,
>> +		.hwcap_bit = HWCAP_LRCPC,
>> +		.cpuinfo = "lrcpc",
>> +		.sigill_fn = lrcpc_sigill,
>> +	},
> The table is roughly ordered by feature name, it'd be good to keep it
> that way (apart from anything else it minimises merge conflicts).  It'd
> also be good to follow the existing style and use the FEAT_ name for the
> feature as the display name, if there isn't one then at least something
> similarly all caps like the name of the ID register field?

Thanks for review,  and v2 would be sent later.


Zeng Heng

