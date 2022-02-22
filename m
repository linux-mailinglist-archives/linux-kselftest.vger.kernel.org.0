Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9A4C0083
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Feb 2022 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiBVRzU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Feb 2022 12:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiBVRzT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Feb 2022 12:55:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7847117984
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Feb 2022 09:54:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0E04B80AD0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Feb 2022 17:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8629FC340E8;
        Tue, 22 Feb 2022 17:54:48 +0000 (UTC)
Date:   Tue, 22 Feb 2022 17:54:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v11 18/40] arm64/sme: Implement traps and syscall
 handling for SME
Message-ID: <YhUjZZGaTW4FAkvM@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-19-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-19-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:47PM +0000, Mark Brown wrote:
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

I'm not sure this is entirely correct about the PCS. The caller must
disable SM if the function it calls is not compatible. But it's fine for
the kernel to impose this at the ABI level.

> @@ -409,6 +415,21 @@ static void task_fpsimd_load(void)
>  			       restore_ffr);
>  	else
>  		fpsimd_load_state(&current->thread.uw.fpsimd_state);
> +
> +	/*
> +	 * If we didn't set up any SVE registers but we do have SME
> +	 * enabled for userspace then ensure the SVE registers are
> +	 * flushed since userspace can switch to streaming mode and
> +	 * view the register state without trapping.
> +	 */
> +	if (system_supports_sme() && test_thread_flag(TIF_SME) &&
> +	    !restore_sve_regs) {
> +		int sve_vq_minus_one;
> +
> +		sve_vq_minus_one = sve_vq_from_vl(task_get_sve_vl(current)) - 1;
> +		sve_set_vq(sve_vq_minus_one);
> +		sve_flush_live(true, sve_vq_minus_one);
> +	}

Shouldn't the SVE state be flushed by the hardware when switching to
streaming mode?

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
> +	 * that after a syscall we never have any SME register state
> +	 * to track, if this changes the KVM code will need updating.
> +	 */

By "we never have any SME register state to track" I understand that we
drop the ZA state as well which AFAICT is not the case.

> +	if (system_supports_sme() && test_thread_flag(TIF_SME)) {
> +		u64 svcr = read_sysreg_s(SYS_SVCR_EL0);
> +
> +		if (svcr & SYS_SVCR_EL0_SM_MASK)
> +			sme_smstop_sm();
> +
> +		if (!(svcr & SYS_SVCR_EL0_ZA_MASK)) {
> +			clear_thread_flag(TIF_SME);
> +			sme_user_disable();
> +		}
> +	}

-- 
Catalin
