Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CAB49B2F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 12:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346841AbiAYLcQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 06:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348505AbiAYLaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 06:30:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D141C06173B
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 03:28:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D15AB81750
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 11:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A71DC340E0;
        Tue, 25 Jan 2022 11:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643110078;
        bh=Q68WXWQo/G/FBfWyq7Po5CEYFn6zJ7OrB4fXlhlwx7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iH/Kupio/1bkkpw+fCbnfcyWsSBzuiUDK2iXYlbAleQfXlIkEp+UQD25tTdy7+Mpz
         ISUJwFigDIjXuIeVbCxrl1QpkcvIKIg7h5cuwxNOww1s3zpg/r4OAXmbyiklbd9woA
         IJpxum2mYsX2Dt85B6qjG9R3W02MIOCq5L1aqm0kxHq3wViqYB4JtNMsmfQkI5P3zx
         IdeKQ6CHMAi2zhZxjjzz0ZgNvY9WSxA7ukA5jbxw1bu4S5kbIM2i9M1KpawUO1o4Ts
         6nIbOU2qhsfTC19MpGghvGFzncAoq5YLn1k4MxsJIxeeLxC6B7HDtw4348MljbtO6/
         SgcIUrapDzlUA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nCJzQ-002t72-B6; Tue, 25 Jan 2022 11:27:56 +0000
Date:   Tue, 25 Jan 2022 11:27:55 +0000
Message-ID: <87y2346on8.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v8 25/38] KVM: arm64: Trap SME usage in guest
In-Reply-To: <20220125001114.193425-26-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
        <20220125001114.193425-26-broonie@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, skhan@linuxfoundation.org, shuah@kernel.org, alan.hayward@arm.com, luis.machado@arm.com, Salil.Akerkar@arm.com, Basant.KumarDwivedi@arm.com, szabolcs.nagy@arm.com, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 25 Jan 2022 00:11:01 +0000,
Mark Brown <broonie@kernel.org> wrote:
> 
> SME defines two new traps which need to be enabled for guests to ensure
> that they can't use SME, one for the main SME operations which mirrors the
> traps for SVE and another for access to TPIDR2 in SCTLR_EL2.
> 
> For VHE manage SMEN along with ZEN in activate_traps() and the FP state
> management callbacks.
> 
> For nVHE the value to be used for CPTR_EL2 in the guest is stored in
> vcpu->arch.cptr_el2, set TSM there during initialisation. It will be
> cleared in __deactivate_traps_common() by virtue of not being set in
> CPTR_EL2_DEFAULT.
> 
> For both VHE and nVHE cases handle SCTLR_EL2.EnTPIDR2 in the shared
> __active_traps_common() and __deactivate_traps_common(), there is no
> existing dynamic management of SCTLR_EL2.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kvm/hyp/nvhe/switch.c | 30 ++++++++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/vhe/switch.c  | 10 +++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 6410d21d8695..184bf6bd79b9 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -47,10 +47,25 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
>  		val |= CPTR_EL2_TFP | CPTR_EL2_TZ;
>  		__activate_traps_fpsimd32(vcpu);
>  	}
> +	if (IS_ENABLED(CONFIG_ARM64_SME) && cpus_have_final_cap(ARM64_SME))

Please drop the IS_ENABLED(). We purposely avoid conditional
compilation in KVM in order to avoid bitrot, and the amount of code
you save isn't significant. Having a static key is more than enough to
avoid runtime costs.

> +		val |= CPTR_EL2_TSM;
>  
>  	write_sysreg(val, cptr_el2);
>  	write_sysreg(__this_cpu_read(kvm_hyp_vector), vbar_el2);
>  
> +	if (IS_ENABLED(CONFIG_ARM64_SME) && cpus_have_final_cap(ARM64_SME) &&
> +	    cpus_have_final_cap(ARM64_HAS_FGT)) {
> +		val = read_sysreg_s(SYS_HFGRTR_EL2);
> +		val &= ~(HFGxTR_EL2_nTPIDR_EL0_MASK |
> +			 HFGxTR_EL2_nSMPRI_EL1_MASK);
> +		write_sysreg_s(val, SYS_HFGRTR_EL2);
> +
> +		val = read_sysreg_s(SYS_HFGWTR_EL2);
> +		val &= ~(HFGxTR_EL2_nTPIDR_EL0_MASK |
> +			 HFGxTR_EL2_nSMPRI_EL1_MASK);
> +		write_sysreg_s(val, SYS_HFGWTR_EL2);
> +	}

If the CPUs do not have FGT, what provides the equivalent trapping?
If FGT is mandatory when SME exists, then you should simplify the
condition.

	M.

-- 
Without deviation from the norm, progress is not possible.
