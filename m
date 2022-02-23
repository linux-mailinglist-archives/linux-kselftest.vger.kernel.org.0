Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86FA4C1695
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiBWPXa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiBWPXY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:23:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B44931213
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 07:22:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3A5DB82036
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 15:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8B7C340E7;
        Wed, 23 Feb 2022 15:22:43 +0000 (UTC)
Date:   Wed, 23 Feb 2022 15:22:40 +0000
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
Subject: Re: [PATCH v11 22/40] arm64/sme: Implement ptrace support for
 streaming mode SVE registers
Message-ID: <YhZRQH+C4RzrSdn5@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-23-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-23-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:51PM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 2242c14a5a05..8b111b7f2006 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -645,14 +645,19 @@ static void __fpsimd_to_sve(void *sst, struct user_fpsimd_state const *fst,
>   */
>  static void fpsimd_to_sve(struct task_struct *task)
>  {
> -	unsigned int vq;
> +	unsigned int vq, vl;
>  	void *sst = task->thread.sve_state;
>  	struct user_fpsimd_state const *fst = &task->thread.uw.fpsimd_state;
>  
>  	if (!system_supports_sve())
>  		return;
>  
> -	vq = sve_vq_from_vl(task_get_sve_vl(task));
> +	if (thread_sm_enabled(&task->thread))
> +		vl = task_get_sme_vl(task);
> +	else
> +		vl = task_get_sve_vl(task);

I saw this construct in the signal patches as well. Can we have a
function/macro that checks the SM enabled and returns the proper vl?

Otherwise,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
