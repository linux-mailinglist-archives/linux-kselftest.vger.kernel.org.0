Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A030E4C1654
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbiBWPRY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241095AbiBWPRX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:17:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7DDAE58
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 07:16:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA3761766
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 15:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53D4C340EB;
        Wed, 23 Feb 2022 15:16:50 +0000 (UTC)
Date:   Wed, 23 Feb 2022 15:16:46 +0000
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
Subject: Re: [PATCH v11 20/40] arm64/sme: Implement streaming SVE signal
 handling
Message-ID: <YhZP3gMmAc6mbFTd@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-21-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-21-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:49PM +0000, Mark Brown wrote:
> When in streaming mode we have the same set of SVE registers as we do in
> regular SVE mode with the exception of FFR and the use of the SME vector
> length. Provide signal handling for these registers by taking one of the
> reserved words in the SVE signal context as a flags field and defining a
> flag with a flag which is set for streaming mode. When the flag is set the

Too many "flag" words.

> @@ -593,11 +613,16 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
>  	if (system_supports_sve()) {
>  		unsigned int vq = 0;
>  
> -		if (add_all || test_thread_flag(TIF_SVE)) {
> -			int vl = sve_max_vl();
> +		if (add_all || test_thread_flag(TIF_SVE) ||
> +		    thread_sm_enabled(&current->thread)) {
> +			int vl = max(sve_max_vl(), sme_max_vl());
>  
> -			if (!add_all)
> -				vl = task_get_sve_vl(current);
> +			if (!add_all) {
> +				if (thread_sm_enabled(&current->thread))
> +					vl = task_get_sme_vl(current);
> +				else
> +					vl = task_get_sve_vl(current);
> +			}
>  
>  			vq = sve_vq_from_vl(vl);

Nitpick: this looks a bit too complicated, maybe split it in three
separate if/else blocks.

Either way,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
