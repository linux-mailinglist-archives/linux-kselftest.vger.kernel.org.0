Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5BF428D31
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 14:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhJKMkV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 08:40:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3961 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbhJKMkU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 08:40:20 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HSdXs5TRbz689n8;
        Mon, 11 Oct 2021 20:34:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 14:38:18 +0200
Received: from localhost (10.52.122.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 13:38:17 +0100
Date:   Mon, 11 Oct 2021 13:37:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Alan Hayward" <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        "Salil Akerkar" <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 24/38] arm64/sme: Implement traps and syscall
 handling for SME
Message-ID: <20211011133759.000042c4@Huawei.com>
In-Reply-To: <20210930181144.10029-25-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
        <20210930181144.10029-25-broonie@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.204]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 30 Sep 2021 19:11:30 +0100
Mark Brown <broonie@kernel.org> wrote:

> By default all SME operations in userspace will trap.  When this happens
> we allocate storage space for the SME register state, set up the SVE
> registers and disable traps.  We do not need to initialize ZA since the
> architecture guarantees that it will be zeroed when enabled and when we
> trap ZA is disabled.
> 
> On syscall we exit streaming mode if we were previously in it and ensure
> that all but the lower 128 bits of the registers are zeroed while
> preserving the state of ZA. This follows the aarch64 PCS for SME, ZA
> state is preserved over a function call and streaming mode is exited.
> Since the traps for SME do not distinguish between streaming mode SVE
> and ZA usage if ZA is in use rather than reenabling traps we instead
> zero the parts of the SVE registers not shared with FPSIMD and leave SME
> enabled, this simplifies handling SME traps. If ZA is not in use then we
> reenable SME traps and fall through to normal handling of SVE.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
...  continuing the trivial theme of my review today...


>  
>  	/*
>  	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
> -	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
> -	 * happens if a context switch or kernel_neon_begin() or context
> -	 * modification (sigreturn, ptrace) intervenes.
> -	 * So, ensure that CPACR_EL1 is already correct for the fast-path case.
> +	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which
> +	 * only happens if a context switch or kernel_neon_begin() or

Why the rewrap here?

> +	 * context modification (sigreturn, ptrace) intervenes.  So,
> +	 * ensure that CPACR_EL1 is already correct for the fast-path
> +	 * case.
>  	 */
>  	sve_user_disable();
>  }
>  
>  void do_el0_svc(struct pt_regs *regs)
>  {
> -	sve_user_discard();
> +	fp_user_discard();
>  	el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
>  }
>  

