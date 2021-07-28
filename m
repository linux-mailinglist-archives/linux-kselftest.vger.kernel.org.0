Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC993D8AFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhG1JnO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 05:43:14 -0400
Received: from foss.arm.com ([217.140.110.172]:54056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhG1JnN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 05:43:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74E871FB;
        Wed, 28 Jul 2021 02:43:12 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E9743F73D;
        Wed, 28 Jul 2021 02:43:11 -0700 (PDT)
Date:   Wed, 28 Jul 2021 10:41:51 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/3] kselftest/arm64: Validate vector lengths are set
 in sve-probe-vls
Message-ID: <20210728094151.GB1724@arm.com>
References: <20210727180649.12943-1-broonie@kernel.org>
 <20210727180649.12943-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727180649.12943-3-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 27, 2021 at 07:06:48PM +0100, Mark Brown wrote:
> Currently sve-probe-vls does not verify that the vector lengths reported
> by the prctl() interface are actually what is reported by the architecture,
> use the rdvl_sve() helper to validate this.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
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
> index 76e138525d55..a6cd1bd6e515 100644
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

This test was originally a diagnostic tool, so the way VLs are probed
aims to be efficient, rather than being defensive against the kernel
doing weird stuff.

If the kernel returns a vl > than the one we tried to set, we'll end
up in an infinite loop because of the way the loop deliberately uses the
kernel's return value to skip unsupported VLs.  So, it might be better
to probe every single architecturally possible VL and sanity check
everything instead.

While taking this opportunity, a check that the resulting vl is <= the
requested VL might be good too.

Also, if the kernel rounds any given vl down to some vl_actual, then it
should also round every possible other_vl down to vl_actual, where
vl_actual <= other_vl < vl.  It's not OK for different vls to be rounded
down to different actual values that have nothing to do with each other.

Since this test is our example of how to do this probing, it would be
good to preserve the "efficient" version though, and check that the
probed set of vls matches what is obtained by exhaustive probing.
Using comments and well-chosen function names, we can hopefully steer
people to use the efficient version that trusts the kernel in their own
code.

> @@ -38,6 +39,10 @@ int main(int argc, char **argv)
>  
>  		vl &= PR_SVE_VL_LEN_MASK;
>  
> +		if (rdvl_sve() != vl)
> +			ksft_exit_fail_msg("Set VL %d, RDVL %d\n",
> +					   vl, rdvl_sve());
> +

If this fails, the VL vl wasn't "Set" at all.  I found this a bit
confusing from just looking at this hunk.

Can we write something like "PR_SVE_SET_VL reports VL %d, RDVL %d"?

[...]

Thinking about it, due to the way these tests do inline vector length
changes we should also be making sure that they are not built with SVE
code gen by default, since inline VL changes could cause bad things to
happen in that case.

This isn't a problem for now, but as time goes on the toolchain may
start to be configured to compile for SVE by default.

I'm not sure of the correct option for forcing SVE off against the
compiler default -- check with the tools folks.  If there isn't a
proper way to do this, it's a toolchain defect so we should flag it up,
but -mgeneral-regs-only might work for us even though it's a bit of a
sledgehammer.

Compiler options aside, I think we _probably_ get away with a
native-SVE libc, since if everything in libc is VL-agnostic then it
shouldn't care what VL we call in with.  If being paranoid, we could
always restore the VL before doing anything other then prctl() and
RVDL, but we should probably wait for something to break first.


If we wanted to be super-robust, we could make the business end of each
test a pure-asm binary and control them via ptrace.  But that's probably
too much pain for now, even if the test harness were reusable.

Cheers
---Dave
