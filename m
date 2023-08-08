Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F0477434E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjHHSA7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjHHSAe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 14:00:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309968938
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 09:27:47 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKtGV0CQHzVk0R;
        Tue,  8 Aug 2023 20:46:10 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 20:48:02 +0800
Message-ID: <974f65e3-239f-b487-30a5-dffd9bec39f8@huawei.com>
Date:   Tue, 8 Aug 2023 20:48:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/5] kselftest/arm64: add float-point feature to hwcap
 test
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <kristina.martsenko@arm.com>, <shuah@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230808061356.2215158-1-zengheng4@huawei.com>
 <29093701-3fd7-443b-b5c5-4333a6812c4f@sirena.org.uk>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <29093701-3fd7-443b-b5c5-4333a6812c4f@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


在 2023/8/8 20:25, Mark Brown 写道:
> On Tue, Aug 08, 2023 at 02:13:51PM +0800, Zeng Heng wrote:
>
>> +static void fp_sigill(void)
>> +{
>> +	/* FMOV	S0, #1 */
>> +	asm volatile(".inst 0x1e2e1000" : : : );
>> +}
>> +
> That should assemble even with the toolchain configured for v8.0 so
> there shouldn't be any need to hand encode here.  Otherwise
>
> Reviewed-by: Mark Brown <broonie@kernel.org>

I would update to assemble language in V2.

Zeng Heng

