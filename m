Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684153DA0A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 11:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhG2Jx6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 05:53:58 -0400
Received: from foss.arm.com ([217.140.110.172]:43760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235592AbhG2Jx5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 05:53:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEC7C6D;
        Thu, 29 Jul 2021 02:53:54 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D905D3F73D;
        Thu, 29 Jul 2021 02:53:53 -0700 (PDT)
Date:   Thu, 29 Jul 2021 10:52:33 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] kselftest/arm64: Validate vector lengths are set
 in sve-probe-vls
Message-ID: <20210729095232.GI1724@arm.com>
References: <20210728163318.51492-1-broonie@kernel.org>
 <20210728163318.51492-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728163318.51492-3-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 28, 2021 at 05:33:16PM +0100, Mark Brown wrote:
> Currently sve-probe-vls does not verify that the vector lengths reported
> by the prctl() interface are actually what is reported by the architecture,
> use the rdvl_sve() helper to validate this.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  tools/testing/selftests/arm64/fp/Makefile        | 2 +-
>  tools/testing/selftests/arm64/fp/sve-probe-vls.c | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
> index ed62e7003b96..fa3a0167db2d 100644
> --- a/tools/testing/selftests/arm64/fp/Makefile
> +++ b/tools/testing/selftests/arm64/fp/Makefile
> @@ -13,7 +13,7 @@ fpsimd-test: fpsimd-test.o
>  	$(CC) -nostdlib $^ -o $@
>  rdvl-sve: rdvl-sve.o rdvl.o
>  sve-ptrace: sve-ptrace.o sve-ptrace-asm.o
> -sve-probe-vls: sve-probe-vls.o
> +sve-probe-vls: sve-probe-vls.o rdvl.o
>  sve-test: sve-test.o
>  	$(CC) -nostdlib $^ -o $@
>  vlset: vlset.o
> diff --git a/tools/testing/selftests/arm64/fp/sve-probe-vls.c b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
> index 76e138525d55..a24eca7a4ecb 100644
> --- a/tools/testing/selftests/arm64/fp/sve-probe-vls.c
> +++ b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
> @@ -13,6 +13,7 @@
>  #include <asm/sigcontext.h>
>  
>  #include "../../kselftest.h"
> +#include "rdvl.h"
>  
>  int main(int argc, char **argv)
>  {
> @@ -38,6 +39,10 @@ int main(int argc, char **argv)
>  
>  		vl &= PR_SVE_VL_LEN_MASK;
>  
> +		if (rdvl_sve() != vl)
> +			ksft_exit_fail_msg("PR_SVE_SET_VL reports %d, RDVL %d\n",
> +					   vl, rdvl_sve());
> +
>  		if (!sve_vl_valid(vl))
>  			ksft_exit_fail_msg("VL %d invalid\n", vl);
>  		vq = sve_vq_from_vl(vl);
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
