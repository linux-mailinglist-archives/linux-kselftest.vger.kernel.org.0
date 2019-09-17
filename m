Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2377BB5262
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfIQQFs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 12:05:48 -0400
Received: from foss.arm.com ([217.140.110.172]:58090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbfIQQFs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 12:05:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12E7315A2;
        Tue, 17 Sep 2019 09:05:48 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BB7E3F575;
        Tue, 17 Sep 2019 09:05:47 -0700 (PDT)
Date:   Tue, 17 Sep 2019 17:05:45 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
Subject: Re: [PATCH v6 02/11] kselftest: arm64:
 mangle_pstate_invalid_compat_toggle and common utils
Message-ID: <20190917160545.GL27757@arm.com>
References: <20190910123111.33478-1-cristian.marussi@arm.com>
 <20190910123111.33478-3-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910123111.33478-3-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 10, 2019 at 01:31:02pm +0100, Cristian Marussi wrote:
> Add some arm64/signal specific boilerplate and utility code to help
> further testcases' development.
> 
> Introduce also one simple testcase mangle_pstate_invalid_compat_toggle
> and some related helpers: it is a simple mangle testcase which messes
> with the ucontext_t from within the signal handler, trying to toggle
> PSTATE state bits to switch the system between 32bit/64bit execution
> state. Expects SIGSEGV on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v5 --> v6
> - fix commit msg
> - feat_names is char const *const
> - better supported options check and reporting
> - removed critical asserts to avoid issues with NDEBUG
> - more robust get_header
> - fix validation for ESR_CONTEXT size
> - add more explicit comment in GET_RESV_NEXT_HEAD() macro
> - refactored default_handler()
> - feats_ok() now public
> - call always test_results() no matter the outcome of test_run()

[...]

> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c

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
> +		} else {
> +			fprintf(stderr,
> +				"HWCAP_CPUID NOT available. Mark ALL feats UNSUPPORTED.\n");

Nit: this message isn't strictly correct now: SSBS may still be detected
even if HWCAP_CPUID isn't present.

For simplicity I suggest to drop this fprintf() (and the containing
else { }, which is otherwise empty).

The following code reports what features are supported in any case, so
the user will be able to see what was detected.


The rest looks reasonable to me now, so with the above nit fixed:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

[...]

Cheers
---Dave
