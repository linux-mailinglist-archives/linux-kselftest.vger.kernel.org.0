Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504ED64F86E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Dec 2022 10:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiLQJXd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Dec 2022 04:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLQJXc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Dec 2022 04:23:32 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621BB1E9
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Dec 2022 01:23:30 -0800 (PST)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NZ0qX17LQzJqPH;
        Sat, 17 Dec 2022 17:22:32 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 17:23:28 +0800
Subject: Re: [PATCH v3 12/21] arm64/sme: Implement ZT0 ptrace support
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
 <20221111215026.813348-13-broonie@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7f10fe8b-956d-19ea-f56b-bf2b20c75443@huawei.com>
Date:   Sat, 17 Dec 2022 17:23:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20221111215026.813348-13-broonie@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
> @@ -1474,6 +1520,14 @@ static const struct user_regset aarch64_regsets[] = {
>  		.regset_get = za_get,
>  		.set = za_set,
>  	},
> +	[REGSET_ZT] = { /* SME ZA */

nit: /* SME ZT */

> +		.core_note_type = NT_ARM_ZT,
> +		.n = 1,
> +		.size = ZT_SIG_REG_BYTES,
> +		.align = sizeof(u64),
> +		.regset_get = zt_get,
> +		.set = zt_set,
> +	},
>  #endif
>  #ifdef CONFIG_ARM64_PTR_AUTH
>  	[REGSET_PAC_MASK] = {

Zenghui
