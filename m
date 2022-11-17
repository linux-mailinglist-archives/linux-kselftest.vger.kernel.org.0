Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E90B62D9E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 12:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiKQLwp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 06:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbiKQLwh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 06:52:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D843959146
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 03:52:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F202F13D5;
        Thu, 17 Nov 2022 03:52:35 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.70.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 842E83F663;
        Thu, 17 Nov 2022 03:52:28 -0800 (PST)
Date:   Thu, 17 Nov 2022 11:52:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1] kselftest/arm64: Use preferred form for predicate
 load/stores
Message-ID: <Y3YgdloFYx3pQUO0@FVFF77S0Q05N>
References: <20221117114130.687261-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117114130.687261-1-broonie@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 17, 2022 at 11:41:30AM +0000, Mark Brown wrote:
> The preferred form of the str/ldr for predicate registers with an immediate
> of zero is to omit the zero, and the clang built in assembler rejects the
> zero immediate. Drop the immediate.

Rejecting that outright seems like a bug in clang, given there are legitimate
reasons to write code that way (e.g. using asm-offsets style definitions); has
that been reported so that it can be fixed?

Regardless, the patch itself looks fine, and I don't mean to block this as-is!

Thanks,
Mark.

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/abi/syscall-abi-asm.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
> index b523c21c2278..acd5e9f3bc0b 100644
> --- a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
> +++ b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
> @@ -153,7 +153,7 @@ do_syscall:
>  	// Only set a non-zero FFR, test patterns must be zero since the
>  	// syscall should clear it - this lets us handle FA64.
>  	ldr	x2, =ffr_in
> -	ldr	p0, [x2, #0]
> +	ldr	p0, [x2]
>  	ldr	x2, [x2, #0]
>  	cbz	x2, 2f
>  	wrffr	p0.b
> @@ -298,7 +298,7 @@ do_syscall:
>  	cbz	x2, 1f
>  	ldr	x2, =ffr_out
>  	rdffr	p0.b
> -	str	p0, [x2, #0]
> +	str	p0, [x2]
>  1:
>  
>  	// Restore callee saved registers x19-x30
> 
> base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
> -- 
> 2.30.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
