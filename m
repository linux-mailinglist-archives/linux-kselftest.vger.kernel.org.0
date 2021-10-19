Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD67433353
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 12:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhJSKRF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 06:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhJSKRF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 06:17:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CECF96137B;
        Tue, 19 Oct 2021 10:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634638492;
        bh=OIANuj+Kcg7Vpqy8Rqqrz4DatAxJeMHZ/63Izt1awsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+euh2idGz7qgBsQsL21EQXlj6TQR/4yfNuYnb+NfI02XA7KdW357YooQGdJ3m3KU
         ro+/Y1QC6uc90Zh+DcShf9vAWgHh7erU4QYegl9SXayG4F8pgs6oomu4/3fZReobGO
         OPQIaSwHTO7izO6neUw6CVGWs6X5gehsg32bFcvKDtDgJ8SdOkqDAkzHz1cyz4rzA5
         qU0ElebFxDtzyxJYe53Bi5X4Fn+Z2wfpz114Q/vE8i393QYLJNTO+CCnaVdkBfMwZl
         cCeW3S4jBqdVSPGZti0BruLtJFAXY3hzj6FqSIOsu4gwd1QJy48GHYD6dOweu23bea
         8O8TS2CIPNv+Q==
Date:   Tue, 19 Oct 2021 11:14:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 04/42] arm64/sve: Make access to FFR optional
Message-ID: <20211019101447.GA13251@willie-the-truck>
References: <20211018190858.2119209-1-broonie@kernel.org>
 <20211018190858.2119209-5-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018190858.2119209-5-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 18, 2021 at 08:08:20PM +0100, Mark Brown wrote:
> SME introduces streaming SVE mode in which FFR is not present and the
> instructions for accessing it UNDEF. In preparation for handling this
> update the low level SVE state access functions to take a flag specifying
> if FFR should be handled. When saving the register state we store a zero
> for FFR to guard against uninitialized data being read. No behaviour change
> should be introduced by this patch.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/fpsimd.h       |  6 +++---
>  arch/arm64/include/asm/fpsimdmacros.h | 20 ++++++++++++++------
>  arch/arm64/kernel/entry-fpsimd.S      | 17 +++++++++++------
>  arch/arm64/kernel/fpsimd.c            | 10 ++++++----
>  arch/arm64/kvm/hyp/fpsimd.S           |  6 ++++--
>  5 files changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index 917ecc301d1d..7f8a44a9a5e6 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -65,10 +65,10 @@ static inline void *sve_pffr(struct thread_struct *thread)
>  	return (char *)thread->sve_state + sve_ffr_offset(thread->sve_vl);
>  }
>  
> -extern void sve_save_state(void *state, u32 *pfpsr);
> +extern void sve_save_state(void *state, u32 *pfpsr, int save_ffr);
>  extern void sve_load_state(void const *state, u32 const *pfpsr,
> -			   unsigned long vq_minus_1);
> -extern void sve_flush_live(unsigned long vq_minus_1);
> +			   int restore_ffr, unsigned long vq_minus_1);
> +extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
>  extern unsigned int sve_get_vl(void);
>  extern void sve_set_vq(unsigned long vq_minus_1);
>  
> diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
> index 00a2c0b69c2b..84d8cb7b07fa 100644
> --- a/arch/arm64/include/asm/fpsimdmacros.h
> +++ b/arch/arm64/include/asm/fpsimdmacros.h
> @@ -217,28 +217,36 @@
>  .macro sve_flush_z
>   _for n, 0, 31, _sve_flush_z	\n
>  .endm
> -.macro sve_flush_p_ffr
> +.macro sve_flush_p
>   _for n, 0, 15, _sve_pfalse	\n
> +.endm
> +.macro sve_flush_ffr
>  		_sve_wrffr	0
>  .endm
>  
> -.macro sve_save nxbase, xpfpsr, nxtmp
> +.macro sve_save nxbase, xpfpsr, save_ffr, nxtmp
>   _for n, 0, 31,	_sve_str_v	\n, \nxbase, \n - 34
>   _for n, 0, 15,	_sve_str_p	\n, \nxbase, \n - 16
> +		cbz		\save_ffr, 921f
>  		_sve_rdffr	0
>  		_sve_str_p	0, \nxbase
>  		_sve_ldr_p	0, \nxbase, -16
> -
> +		b		922f
> +921:
> +		str		xzr, [x\nxbase, #0]	// Zero out FFR

You can drop the '#0' here.

> @@ -72,12 +74,15 @@ SYM_FUNC_END(sve_set_vq)
>   * VQ must already be configured by caller, any further updates of VQ
>   * will need to ensure that the register state remains valid.
>   *
> - * x0 = VQ - 1
> + * x0 = include FFR?
> + * x1 = VQ - 1
>   */
>  SYM_FUNC_START(sve_flush_live)
> -	cbz		x0, 1f	// A VQ-1 of 0 is 128 bits so no extra Z state
> +	cbz		x1, 1f	// A VQ-1 of 0 is 128 bits so no extra Z state
>  	sve_flush_z
> -1:	sve_flush_p_ffr
> +1:	cbz		x0, 2f
> +	sve_flush_p
> +2:	sve_flush_ffr
>  	ret

I'm confused by this -- x0 seems to control whether or not we flush the
predicate registers rather then ffr.

>  SYM_FUNC_END(sve_flush_live)
>  
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 0f6df1ece618..3d5d243c3f1c 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -289,7 +289,7 @@ static void task_fpsimd_load(void)
>  
>  	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE))
>  		sve_load_state(sve_pffr(&current->thread),
> -			       &current->thread.uw.fpsimd_state.fpsr,
> +			       &current->thread.uw.fpsimd_state.fpsr, true,
>  			       sve_vq_from_vl(current->thread.sve_vl) - 1);
>  	else
>  		fpsimd_load_state(&current->thread.uw.fpsimd_state);
> @@ -325,7 +325,7 @@ static void fpsimd_save(void)
>  
>  		sve_save_state((char *)last->sve_state +
>  					sve_ffr_offset(last->sve_vl),
> -			       &last->st->fpsr);
> +			       &last->st->fpsr, true);
>  	} else {
>  		fpsimd_save_state(last->st);
>  	}
> @@ -962,7 +962,7 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
>  		unsigned long vq_minus_one =
>  			sve_vq_from_vl(current->thread.sve_vl) - 1;
>  		sve_set_vq(vq_minus_one);
> -		sve_flush_live(vq_minus_one);
> +		sve_flush_live(true, vq_minus_one);

What does the pcs say about passing bools in registers? Can we guarantee
that false is a 64-bit zero?

Will
