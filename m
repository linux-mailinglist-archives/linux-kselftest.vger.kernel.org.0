Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77C1E3F78
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2019 00:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbfJXWiS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Oct 2019 18:38:18 -0400
Received: from foss.arm.com ([217.140.110.172]:60508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbfJXWiR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Oct 2019 18:38:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 005F128;
        Thu, 24 Oct 2019 15:38:17 -0700 (PDT)
Received: from [10.37.9.28] (unknown [10.37.9.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EA7F3F718;
        Thu, 24 Oct 2019 15:38:15 -0700 (PDT)
Subject: Re: [PATCH v9 02/12] kselftest: arm64:
 mangle_pstate_invalid_compat_toggle and common utils
To:     cristian.marussi@arm.com, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     amit.kachhap@arm.com, andreyknvl@google.com, dave.martin@arm.com
References: <20191009120459.21805-1-cristian.marussi@arm.com>
 <20191009120459.21805-3-cristian.marussi@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <dde06d83-4c3b-0be4-db98-e740a1dd327e@arm.com>
Date:   Thu, 24 Oct 2019 23:41:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191009120459.21805-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Cristian,

On 10/09/2019 01:04 PM, Cristian Marussi wrote:
> Add some arm64/signal specific boilerplate and utility code to help
> further testcases' development.
> 
> Introduce also one simple testcase mangle_pstate_invalid_compat_toggle
> and some related helpers: it is a simple mangle testcase which messes
> with the ucontext_t from within the signal handler, trying to toggle
> PSTATE state bits to switch the system between 32bit/64bit execution
> state. Expects SIGSEGV on test PASS.
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

[...]

> +
> +#define get_regval(regname, out)			\
> +{							\
> +	asm volatile("mrs %0, " __stringify(regname)	\
> +	: "=r" (out)					\
> +	:						\
> +	: "memory");					\
> +}
> +
> +/* Regs encoding and masks naming copied in from sysreg.h */
> +#define SYS_ID_AA64MMFR1_EL1	S3_0_C0_C7_1	/* MRS Emulated */
> +#define SYS_ID_AA64MMFR2_EL1	S3_0_C0_C7_2	/* MRS Emulated */
> +#define ID_AA64MMFR1_PAN_SHIFT	20
> +#define ID_AA64MMFR2_UAO_SHIFT	4
> +
> +/* Local Helpers */
> +#define ID_AA64MMFR1_EL1_PAN_SUPPORTED(val) \
> +	(!!((val) & (0xfUL << ID_AA64MMFR1_PAN_SHIFT)))
> +#define ID_AA64MMFR2_EL1_UAO_SUPPORTED(val) \
> +	(!!((val) & (0xfUL << ID_AA64MMFR2_UAO_SHIFT)))
> +
> +/*
> + * Feature flags used in tdescr.feats_required to specify
> + * any feature by the test
> + */
> +enum {
> +	FSSBS_BIT,
> +	FPAN_BIT,
> +	FUAO_BIT,
> +	FMAX_END
> +};
> +
> +#define FEAT_SSBS		(1UL << FSSBS_BIT)
> +#define FEAT_PAN		(1UL << FPAN_BIT)
> +#define FEAT_UAO		(1UL << FUAO_BIT)
> +

[...]

> +static int test_init(struct tdescr *td)
> +{
> +	td->minsigstksz = getauxval(AT_MINSIGSTKSZ);
> +	if (!td->minsigstksz)
> +		td->minsigstksz = MINSIGSTKSZ;
> +	fprintf(stderr, "Detected MINSTKSIGSZ:%d\n", td->minsigstksz);
> +
> +	if (td->feats_required) {
> +		td->feats_supported = 0;
> +		/*
> +		 * Checking for CPU required features using both the
> +		 * auxval and the arm64 MRS Emulation to read sysregs.
> +		 */
> +		if (getauxval(AT_HWCAP) & HWCAP_SSBS)
> +			td->feats_supported |= FEAT_SSBS;
> +		if (getauxval(AT_HWCAP) & HWCAP_CPUID) {
> +			uint64_t val = 0;
> +
> +			/* Uses MRS emulation to check capability */
> +			get_regval(SYS_ID_AA64MMFR1_EL1, val);
> +			if (ID_AA64MMFR1_EL1_PAN_SUPPORTED(val))
> +				td->feats_supported |= FEAT_PAN;
> +			/* Uses MRS emulation to check capability */
> +			get_regval(SYS_ID_AA64MMFR2_EL1, val);
> +			if (ID_AA64MMFR2_EL1_UAO_SUPPORTED(val))
> +				td->feats_supported |= FEAT_UAO;

As discussed, these fields are never exposed to userspace via mrs. So
you may as well drop these features.

Cheers
Suzuki
