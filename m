Return-Path: <linux-kselftest+bounces-15877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67095A2C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 18:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86341F24941
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769A814F9DA;
	Wed, 21 Aug 2024 16:27:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B31509A0
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257672; cv=none; b=dYDDjfkAIjI5sAIFxDYi+Sz4vqERUbSHTr0bMxSnkI4fVpLT+ByJgNvBh+rqq2fL+8UINNVInScfug2FDKkh7aqlO9RyQTmV1wtItW/QKqTBxkjmJvNo+7c+YXnT3iguJT8o4nR3UmCUAy8jPU5T7MCR3esSGG1t4oHZKq5CYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257672; c=relaxed/simple;
	bh=yQRKieBqjfkkWnm6/eKEgzFqonZqWG2i8um2d311HZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbFE1DWXmIlMsIAZIGihlHqOtn9JuZCtT2MiTpXyndx/+pKTEt+C/trO4QkZTg6ZwfIzMGsDQwAeQ+GIAw6f6KTDYt5m2aH4z4kEGj88+RM1CqMOBzdlptJgZHgVL+X1B+e41hPLhGtGp5gxg1xLpdzBKK449o7M+nuXFA14wFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4A1339;
	Wed, 21 Aug 2024 09:28:15 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E161E3F66E;
	Wed, 21 Aug 2024 09:27:47 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:27:45 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2] kselftest/arm64: signal: fix/refactor SVE vector
 length enumeration
Message-ID: <20240821172745.4f23af27@donnerap.manchester.arm.com>
In-Reply-To: <20240819125721.2918606-1-andre.przywara@arm.com>
References: <20240819125721.2918606-1-andre.przywara@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 13:57:21 +0100
Andre Przywara <andre.przywara@arm.com> wrote:

Hi,

sorry, just realised I missed one include...

> Currently a number of SVE/SME related tests have almost identical
> functions to enumerate all supported vector lengths. However over time
> the copy&pasted code has diverged, allowing some bugs to creep in:
> - fake_sigreturn_sme_change_vl reports a failure, not a SKIP if only
>   one vector length is supported (but the SVE version is fine)
> - fake_sigreturn_sme_change_vl tries to set the SVE vector length, not
>   the SME one (but the other SME tests are fine)
> - za_no_regs keeps iterating forever if only one vector length is
>   supported (but za_regs is correct)
> 
> Since those bugs seem to be mostly copy&paste ones, let's consolidate
> the enumeration loop into one shared function, and just call that from
> each test. That should fix the above bugs, and prevent similar issues
> from happening again.
> 
> Fixes: 4963aeb35a9e ("kselftest/arm64: signal: Add SME signal handling tests")
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
> 
> a small update, making the SME VL loop check more generic, and adding a
> comment about the reason we have that in the first place.
> 
> Cheers,
> Andre
> 
>  tools/testing/selftests/arm64/signal/Makefile |  2 +-
>  .../selftests/arm64/signal/sve_helpers.c      | 56 +++++++++++++++++++
>  .../selftests/arm64/signal/sve_helpers.h      | 21 +++++++
>  .../testcases/fake_sigreturn_sme_change_vl.c  | 31 +++-------
>  .../testcases/fake_sigreturn_sve_change_vl.c  | 30 ++--------
>  .../arm64/signal/testcases/ssve_regs.c        | 36 +++---------
>  .../arm64/signal/testcases/ssve_za_regs.c     | 36 +++---------
>  .../arm64/signal/testcases/sve_regs.c         | 32 +++--------
>  .../arm64/signal/testcases/za_no_regs.c       | 32 +++--------
>  .../arm64/signal/testcases/za_regs.c          | 36 +++---------
>  10 files changed, 131 insertions(+), 181 deletions(-)
>  create mode 100644 tools/testing/selftests/arm64/signal/sve_helpers.c
>  create mode 100644 tools/testing/selftests/arm64/signal/sve_helpers.h
> 
> diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
> index 37c8207b99cfc..1381039fb36f9 100644
> --- a/tools/testing/selftests/arm64/signal/Makefile
> +++ b/tools/testing/selftests/arm64/signal/Makefile
> @@ -23,7 +23,7 @@ $(TEST_GEN_PROGS): $(PROGS)
>  # Common test-unit targets to build common-layout test-cases executables
>  # Needs secondary expansion to properly include the testcase c-file in pre-reqs
>  COMMON_SOURCES := test_signals.c test_signals_utils.c testcases/testcases.c \
> -	signals.S
> +	signals.S sve_helpers.c
>  COMMON_HEADERS := test_signals.h test_signals_utils.h testcases/testcases.h
>  
>  .SECONDEXPANSION:
> diff --git a/tools/testing/selftests/arm64/signal/sve_helpers.c b/tools/testing/selftests/arm64/signal/sve_helpers.c
> new file mode 100644
> index 0000000000000..f57265354eaed
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/sve_helpers.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 ARM Limited
> + *
> + * Common helper functions for SVE and SME functionality.
> + */
> +
> +#include <stdbool.h>
> +#include <kselftest.h>
> +#include <asm/sigcontext.h>
> +#include <sys/prctl.h>
> +
> +unsigned int vls[SVE_VQ_MAX];
> +unsigned int nvls;
> +
> +int sve_fill_vls(bool use_sme, int min_vls)
> +{
> +	int vq, vl;
> +	int pr_set_vl = use_sme ? PR_SME_SET_VL : PR_SVE_SET_VL;
> +	int len_mask = use_sme ? PR_SME_VL_LEN_MASK : PR_SVE_VL_LEN_MASK;
> +
> +	/*
> +	 * Enumerate up to SVE_VQ_MAX vector lengths
> +	 */
> +	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
> +		vl = prctl(pr_set_vl, vq * 16);
> +		if (vl == -1)
> +			return KSFT_FAIL;
> +
> +		vl &= len_mask;
> +
> +		/*
> +		 * Unlike SVE, SME does not require the minimum vector length
> +		 * to be implemented, or the VLs to be consecutive, so any call
> +		 * to the prctl might return the single implemented VL, which
> +		 * might be larger than 16. So to avoid this loop never
> +		 * terminating,  bail out here when we find a higher VL than
> +		 * we asked for.
> +		 * See the ARM ARM, DDI 0487K.a, B1.4.2: I_QQRNR and I_NWYBP.
> +		 */
> +		if (vq < sve_vq_from_vl(vl))
> +			break;
> +
> +		/* Skip missing VLs */
> +		vq = sve_vq_from_vl(vl);
> +
> +		vls[nvls++] = vl;
> +	}
> +
> +	if (nvls < min_vls) {
> +		fprintf(stderr, "Only %d VL supported\n", nvls);
> +		return KSFT_SKIP;
> +	}
> +
> +	return KSFT_PASS;
> +}
> diff --git a/tools/testing/selftests/arm64/signal/sve_helpers.h b/tools/testing/selftests/arm64/signal/sve_helpers.h
> new file mode 100644
> index 0000000000000..50948ce471cc6
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/sve_helpers.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 ARM Limited
> + *
> + * Common helper functions for SVE and SME functionality.
> + */
> +
> +#ifndef __SVE_HELPERS_H__
> +#define __SVE_HELPERS_H__
> +
> +#include <stdbool.h>
> +
> +#define VLS_USE_SVE	false
> +#define VLS_USE_SME	true
> +
> +extern unsigned int vls[];
> +extern unsigned int nvls;
> +
> +int sve_fill_vls(bool use_sme, int min_vls);
> +
> +#endif
> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
> index ebd5815b54bba..bc10585062d57 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
> @@ -11,39 +11,22 @@
>  #include <sys/prctl.h>

We need an "#include <kselftest.h>" here.
Sorry, but that slipped through because the kselftest build throws quite
some warnings and errors for me (some of fixed with the other series).

Will send a v3 ASAP.

Cheers,
Andre.

>  
>  #include "test_signals_utils.h"
> +#include "sve_helpers.h"
>  #include "testcases.h"
>  

[ ... ]

