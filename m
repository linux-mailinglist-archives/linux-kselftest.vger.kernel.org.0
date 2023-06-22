Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA4873A654
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjFVQnO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 12:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjFVQnL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 12:43:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C431FEF;
        Thu, 22 Jun 2023 09:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FBB6618C1;
        Thu, 22 Jun 2023 16:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DA2C433C8;
        Thu, 22 Jun 2023 16:42:56 +0000 (UTC)
Date:   Thu, 22 Jun 2023 17:42:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64/signal: Restore TPIDR2 register rather than
 memory state
Message-ID: <ZJR6DvGofAvxSVYW@arm.com>
References: <20230621-arm64-fix-tpidr2-signal-restore-v2-0-c8e8fcc10302@kernel.org>
 <20230621-arm64-fix-tpidr2-signal-restore-v2-1-c8e8fcc10302@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621-arm64-fix-tpidr2-signal-restore-v2-1-c8e8fcc10302@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 22, 2023 at 02:39:45PM +0100, Mark Brown wrote:
> Currently when restoring the TPIDR2 signal context we set the new value
> from the signal frame in the thread data structure but not the register,
> following the pattern for the rest of the data we are restoring. This does
> not work in the case of TPIDR2, the register always has the value for the
> current task. This means that either we return to userspace and ignore the
> new value or we context switch and save the register value on top of the
> newly restored value.
> 
> Load the value from the signal context into the register instead.
> 
> Fixes: 39e54499280f ("arm64/signal: Include TPIDR2 in the signal context")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 2cfc810d0a5b..10b407672c42 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -398,7 +398,7 @@ static int restore_tpidr2_context(struct user_ctxs *user)
>  
>  	__get_user_error(tpidr2_el0, &user->tpidr2->tpidr2, err);
>  	if (!err)
> -		current->thread.tpidr2_el0 = tpidr2_el0;
> +		write_sysreg_s(tpidr2_el0, SYS_TPIDR2_EL0);

I guess the other way around may also be true - the libc sets tpidr2_el0
to something else and doesn't want the kernel to restore its original
value from sigcontext.

For tpidr_el0 we don't bother with sigcontext, not sure what the use for
tpidr2_el0 in signals is. If we assume the context saved is only
informative (like esr), we can simply ignore restoring it from the
signal stack.

I guess we need to ask Szabolcs what his preference is. The current code
is wrong either way since current->thread.tpidr2_el0 would be overridden
at thread switch.

-- 
Catalin
