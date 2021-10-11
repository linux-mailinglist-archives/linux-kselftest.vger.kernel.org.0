Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FF64289D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhJKJmV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 05:42:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3955 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbhJKJmU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 05:42:20 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HSYc71Y7Zz67Zw0;
        Mon, 11 Oct 2021 17:37:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 11 Oct 2021 11:40:18 +0200
Received: from localhost (10.52.122.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 10:40:17 +0100
Date:   Mon, 11 Oct 2021 10:39:59 +0100
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
Subject: Re: [PATCH v1 01/38] arm64/fp: Reindent fpsimd_save()
Message-ID: <20211011103959.00003d8a@Huawei.com>
In-Reply-To: <20210930181144.10029-2-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
        <20210930181144.10029-2-broonie@kernel.org>
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

On Thu, 30 Sep 2021 19:11:07 +0100
Mark Brown <broonie@kernel.org> wrote:

> Currently all the active code in fpsimd_save() is inside a check for
> TIF_FOREIGN_FPSTATE. Reduce the indentation level by changing to return
> from the function if TIF_FOREIGN_FPSTATE is set.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
Hi Mark

Trivial formatting thing inline, but otherwise this is clearly a noop
refactor as expected.

> ---
>  arch/arm64/kernel/fpsimd.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index ff4962750b3d..995f8801602b 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -308,24 +308,26 @@ static void fpsimd_save(void)
>  	WARN_ON(!system_supports_fpsimd());
>  	WARN_ON(!have_cpu_fpsimd_context());
>  
> -	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
> -		if (IS_ENABLED(CONFIG_ARM64_SVE) &&
> -		    test_thread_flag(TIF_SVE)) {
> -			if (WARN_ON(sve_get_vl() != last->sve_vl)) {
> -				/*
> -				 * Can't save the user regs, so current would
> -				 * re-enter user with corrupt state.
> -				 * There's no way to recover, so kill it:
> -				 */
> -				force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
> -				return;
> -			}
> -
> -			sve_save_state((char *)last->sve_state +
> -						sve_ffr_offset(last->sve_vl),
> -				       &last->st->fpsr);
> -		} else
> -			fpsimd_save_state(last->st);
> +	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
> +		return;
> +
> +	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
> +	    test_thread_flag(TIF_SVE)) {

Trivial, but - the above now fits nicely on oneline under 80 chars.

Looks like you have another instance of this in patch 21 in roughly the same place.

Then you drop at least some of this code later. hohum, maybe not worth tidying up.


> +		if (WARN_ON(sve_get_vl() != last->sve_vl)) {
> +			/*
> +			 * Can't save the user regs, so current would
> +			 * re-enter user with corrupt state.
> +			 * There's no way to recover, so kill it:
> +			 */
> +			force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
> +			return;
> +		}
> +
> +		sve_save_state((char *)last->sve_state +
> +					sve_ffr_offset(last->sve_vl),
> +			       &last->st->fpsr);
> +	} else {
> +		fpsimd_save_state(last->st);
>  	}
>  }
>  

