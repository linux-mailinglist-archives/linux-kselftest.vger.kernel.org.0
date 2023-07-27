Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB584765804
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 17:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjG0PuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 11:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjG0PuR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 11:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD214F5
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 08:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6739761EC0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 15:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4773C433C7;
        Thu, 27 Jul 2023 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690473014;
        bh=QbmwA8ZCbb79SnPyZtI//doQHzR6KgBBUGhYCCxM9vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHYDK2oH7qFasegLtgXFJ8mV/adivQKOUAbnCnrlyHEMIIKQqmfWIiTIwZuBWoAfC
         igGCCzxgsKWSQcRzL2IGYpbuZ0aHWxipVg62MGyUxJlGC8dI+GiZ9VRq5A4I3whmUQ
         cWe7VwmjPE+f1RJyc6Zkqsf2IyFBiiD8iio3aXqHcc2EaBJmZoZ21R3rnLYDZuv9gY
         f4Zi79LQJDS5+ZKoAB4EkAmqrY3lE536JS0p9kNsVY3HtdizmWSAn1Ht30BO2sbEn5
         wvxpPY/9SRn8P1+Tdm2JZa+Jb7JWUfKZRIMhfyShMGuyqcNVSe7d0ur1O0FKi1Twjo
         ikHuQkk8tUEPg==
Date:   Thu, 27 Jul 2023 16:50:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] kselftest/arm64: Exit streaming mode after collecting
 signal context
Message-ID: <20230727155009.GA20050@willie-the-truck>
References: <20230720-arm64-signal-memcpy-fix-v3-1-08aed2385d68@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720-arm64-signal-memcpy-fix-v3-1-08aed2385d68@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 20, 2023 at 07:42:09PM +0100, Mark Brown wrote:
> When we collect a signal context with one of the SME modes enabled we will
> have enabled that mode behind the compiler and libc's back so they may
> issue some instructions not valid in streaming mode, causing spurious
> failures.
> 
> For the code prior to issuing the BRK to trigger signal handling we need to
> stay in streaming mode if we were already there since that's a part of the
> signal context the caller is trying to collect. Unfortunately this code
> includes a memset() which is likely to be heavily optimised and is likely
> to use FP instructions incompatible with streaming mode. We can avoid this
> happening by open coding the memset(), inserting a volatile assembly
> statement to avoid the compiler recognising what's being done and doing
> something in optimisation. This code is not performance critical so the
> inefficiency should not be an issue.
> 
> After collecting the context we can simply exit streaming mode, avoiding
> these issues. Use a full SMSTOP for safety to prevent any issues appearing
> with ZA.
> 
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v3:
> - Open code OPTIMISER_HIDE_VAR() instead of the memory clobber.
> - Link to v2: https://lore.kernel.org/r/20230712-arm64-signal-memcpy-fix-v2-1-494f7025caf6@kernel.org
> 
> Changes in v2:
> - Rebase onto v6.5-rc1.
> - Link to v1: https://lore.kernel.org/r/20230628-arm64-signal-memcpy-fix-v1-1-db3e0300829e@kernel.org
> ---
>  .../selftests/arm64/signal/test_signals_utils.h    | 25 +++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
> index 222093f51b67..c7f5627171dd 100644
> --- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
> @@ -60,13 +60,25 @@ static __always_inline bool get_current_context(struct tdescr *td,
>  						size_t dest_sz)
>  {
>  	static volatile bool seen_already;
> +	int i;
> +	char *uc = (char *)dest_uc;
>  
>  	assert(td && dest_uc);
>  	/* it's a genuine invocation..reinit */
>  	seen_already = 0;
>  	td->live_uc_valid = 0;
>  	td->live_sz = dest_sz;
> -	memset(dest_uc, 0x00, td->live_sz);
> +
> +	/*
> +	 * This is a memset() but we don't want the compiler to
> +	 * optimise it into either instructions or a library call
> +	 * which might be incompatible with streaming mode.
> +	 */
> +	for (i = 0; i < td->live_sz; i++) {
> +		uc[i] = 0;
> +		__asm__ ("" : "=r" (uc[i]) : "0" (uc[i]));
> +	}

Looking more closely at this, I see that the bpf and kvm selftests are
able to include <linux/compiler.h> directly, so I don't see why we need
to open-code this here. I also spotted that we've *already* written our
own version of this as the 'curse()' macro in selftests/arm64/bti/compiler.h!

So I think we should either use linux/compiler.h or make our curse macro
usable to all the arm64 selftests.

What do you think?

Will
