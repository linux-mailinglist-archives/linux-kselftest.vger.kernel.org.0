Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC6F64F87F
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Dec 2022 10:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiLQJke (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Dec 2022 04:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQJkc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Dec 2022 04:40:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F55CFAE6
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Dec 2022 01:40:31 -0800 (PST)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NZ17D4ZfHzqT8r;
        Sat, 17 Dec 2022 17:36:08 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 17:40:28 +0800
Subject: Re: [PATCH v3 06/21] arm64/sme: Manually encode ZT0 load and store
 instructions
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
 <20221111215026.813348-7-broonie@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <69d85a20-77d4-21b0-20bc-19146eb3e160@huawei.com>
Date:   Sat, 17 Dec 2022 17:40:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20221111215026.813348-7-broonie@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/11/12 5:50, Mark Brown wrote:
>  /*
>   * Zero the entire ZA array
>   *	ZERO ZA

Unrelated to this patch but the zero_za macro doesn't appear to have
any in kernel user.
