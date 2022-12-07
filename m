Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D164645BD5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 15:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLGOBI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 09:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiLGOAa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 09:00:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BFB5C764
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 06:00:22 -0800 (PST)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRzMs4bWqzqSvX;
        Wed,  7 Dec 2022 21:56:09 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 22:00:18 +0800
Subject: Re: [PATCH v14 16/39] arm64/sme: Implement traps and syscall handling
 for SME
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        <kvmarm@lists.cs.columbia.edu>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>
References: <20220419112247.711548-1-broonie@kernel.org>
 <20220419112247.711548-17-broonie@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <e57552ea-37fb-07da-8560-e26bae8205cd@huawei.com>
Date:   Wed, 7 Dec 2022 22:00:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20220419112247.711548-17-broonie@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/4/19 19:22, Mark Brown wrote:

> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index c938603b3ba0..92c69e5ac269 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -158,11 +158,36 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  	syscall_trace_exit(regs);
>  }
>  
> -static inline void sve_user_discard(void)
> +/*
> + * As per the ABI exit SME streaming mode and clear the SVE state not
> + * shared with FPSIMD on syscall entry.
> + */
> +static inline void fp_user_discard(void)
>  {
> +	/*
> +	 * If SME is active then exit streaming mode.  If ZA is active
> +	 * then flush the SVE registers but leave userspace access to
> +	 * both SVE and SME enabled, otherwise disable SME for the
> +	 * task and fall through to disabling SVE too.  This means

It looks a bit confusing to me that in the current implementation, if
ZA is *not* active, we don't actually go to disable SME for the task
(which IMHO can be disabled as user-space is not actively using it now).

> +	 * that after a syscall we never have any streaming mode
> +	 * register state to track, if this changes the KVM code will
> +	 * need updating.
> +	 */
> +	if (system_supports_sme() && test_thread_flag(TIF_SME)) {
> +		u64 svcr = read_sysreg_s(SYS_SVCR_EL0);
> +
> +		if (svcr & SYS_SVCR_EL0_SM_MASK)
> +			sme_smstop_sm();

As per the SME syscall ABI

| On syscall PSTATE.SM will be cleared and the SVE registers will be
| handled as per the standard SVE ABI.

and the SVE syscall ABI

| On syscall, V0..V31 are preserved (as without SVE).  Thus, bits
| [127:0] of Z0..Z31 are preserved.  All other bits of Z0..Z31, and all
| of P0..P15 and FFR become zero on return from a syscall.

Can we infer from the documentation that V0-V31 should be preserved on
return from a syscall? But with sme_smstop_sm(), all implemented bits of
Z0-Z31 are set to zero by hardware. Is this intentional?

Please fix me up if I've mis-read things here.

> +	}
> +
>  	if (!system_supports_sve())
>  		return;
>  
> +	/*
> +	 * If SME is not active then disable SVE, the registers will
> +	 * be cleared when userspace next attempts to access them and
> +	 * we do not need to track the SVE register state until then.
> +	 */
>  	clear_thread_flag(TIF_SVE);
>  
>  	/*

Thanks,
Zenghui
