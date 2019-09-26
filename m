Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA87BF0B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbfIZLAR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 07:00:17 -0400
Received: from foss.arm.com ([217.140.110.172]:46014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfIZLAR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 07:00:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B267F1000;
        Thu, 26 Sep 2019 04:00:16 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE1763F67D;
        Thu, 26 Sep 2019 04:00:15 -0700 (PDT)
Subject: Re: [PATCH v6 02/11] kselftest: arm64:
 mangle_pstate_invalid_compat_toggle and common utils
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20190910123111.33478-1-cristian.marussi@arm.com>
 <20190910123111.33478-3-cristian.marussi@arm.com>
 <20190917160545.GL27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <799f7556-75a8-59bb-ec3d-624d2bc241e6@arm.com>
Date:   Thu, 26 Sep 2019 12:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917160545.GL27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/09/2019 17:05, Dave Martin wrote:
> On Tue, Sep 10, 2019 at 01:31:02pm +0100, Cristian Marussi wrote:
>> Add some arm64/signal specific boilerplate and utility code to help
>> further testcases' development.
>>
>> Introduce also one simple testcase mangle_pstate_invalid_compat_toggle
>> and some related helpers: it is a simple mangle testcase which messes
>> with the ucontext_t from within the signal handler, trying to toggle
>> PSTATE state bits to switch the system between 32bit/64bit execution
>> state. Expects SIGSEGV on test PASS.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> v5 --> v6
>> - fix commit msg
>> - feat_names is char const *const
>> - better supported options check and reporting
>> - removed critical asserts to avoid issues with NDEBUG
>> - more robust get_header
>> - fix validation for ESR_CONTEXT size
>> - add more explicit comment in GET_RESV_NEXT_HEAD() macro
>> - refactored default_handler()
>> - feats_ok() now public
>> - call always test_results() no matter the outcome of test_run()
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
> 
> [...]
> 
>> +static int test_init(struct tdescr *td)
>> +{
>> +	td->minsigstksz = getauxval(AT_MINSIGSTKSZ);
>> +	if (!td->minsigstksz)
>> +		td->minsigstksz = MINSIGSTKSZ;
>> +	fprintf(stderr, "Detected MINSTKSIGSZ:%d\n", td->minsigstksz);
>> +
>> +	if (td->feats_required) {
>> +		td->feats_supported = 0;
>> +		/*
>> +		 * Checking for CPU required features using both the
>> +		 * auxval and the arm64 MRS Emulation to read sysregs.
>> +		 */
>> +		if (getauxval(AT_HWCAP) & HWCAP_SSBS)
>> +			td->feats_supported |= FEAT_SSBS;
>> +		if (getauxval(AT_HWCAP) & HWCAP_CPUID) {
>> +			uint64_t val = 0;
>> +
>> +			/* Uses MRS emulation to check capability */
>> +			get_regval(SYS_ID_AA64MMFR1_EL1, val);
>> +			if (ID_AA64MMFR1_EL1_PAN_SUPPORTED(val))
>> +				td->feats_supported |= FEAT_PAN;
>> +			/* Uses MRS emulation to check capability */
>> +			get_regval(SYS_ID_AA64MMFR2_EL1, val);
>> +			if (ID_AA64MMFR2_EL1_UAO_SUPPORTED(val))
>> +				td->feats_supported |= FEAT_UAO;
>> +		} else {
>> +			fprintf(stderr,
>> +				"HWCAP_CPUID NOT available. Mark ALL feats UNSUPPORTED.\n");
> 
> Nit: this message isn't strictly correct now: SSBS may still be detected
> even if HWCAP_CPUID isn't present.
> 
> For simplicity I suggest to drop this fprintf() (and the containing
> else { }, which is otherwise empty).
> 
> The following code reports what features are supported in any case, so
> the user will be able to see what was detected.
> 
> 
> The rest looks reasonable to me now, so with the above nit fixed:
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thanks I'll do the above fixes in v7.

Cristian
> 
> [...]
> 
> Cheers
> ---Dave
> 

