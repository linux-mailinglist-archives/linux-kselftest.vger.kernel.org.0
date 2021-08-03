Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729793DEAE4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Aug 2021 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhHCK15 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 06:27:57 -0400
Received: from foss.arm.com ([217.140.110.172]:46778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235383AbhHCK14 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 06:27:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7E4E106F;
        Tue,  3 Aug 2021 03:27:44 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CA293F40C;
        Tue,  3 Aug 2021 03:27:43 -0700 (PDT)
Date:   Tue, 3 Aug 2021 11:26:21 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/4] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210803102620.GF25258@arm.com>
References: <20210729173713.4534-1-broonie@kernel.org>
 <20210729173713.4534-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729173713.4534-4-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 29, 2021 at 06:37:12PM +0100, Mark Brown wrote:
> We provide interfaces for configuring the SVE vector length seen by
> processes using prctl and also via /proc for configuring the default
> values. Provide tests that exercise all these interfaces and verify that
> they take effect as expected, though at present no test fully enumerates
> all the possible vector lengths.
> 
> A subset of this is already tested via sve-probe-vls but the /proc
> interfaces are not currently covered at all.
> 
> In preparation for the forthcoming support for SME, the Scalable Matrix
> Extension, which has separately but similarly configured vector lengths
> which we expect to offer similar userspace interfaces for, all the actual
> files and prctls used are parameterised and we don't validate that the
> architectural minimum vector length is the minimum we see.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/.gitignore   |   1 +
>  tools/testing/selftests/arm64/fp/Makefile     |   3 +-
>  tools/testing/selftests/arm64/fp/vec-syscfg.c | 594 ++++++++++++++++++
>  3 files changed, 597 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/arm64/fp/vec-syscfg.c

[...]

> diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
> new file mode 100644
> index 000000000000..15fec1aaeec6
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c

[...]

> +static int stdio_read_integer(FILE *f, const char *what, int *val)
> +{
> +	int ret, n;
> +

n needs to be initialised to 0, since fscanf won't touch it if there is
a matching failure before it reaches the %n conversion.

With that,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

(One minor coment below, but that's just in relation to a possibly
future test.)

> +	ret = fscanf(f, "%d%*1[\n]%n", val, &n);
> +	if (ret < 1 || n < 1) {
> +		ksft_print_msg("%d %d %d\n", ret, n, *val);
> +		ksft_print_msg("failed to parse VL from %s\n", what);
> +		return -1;
> +	}
> +
> +	return 0;
> +}

[...]

> +/* If we didn't request it a new VL shouldn't affect the child */
> +static void prctl_set_for_child(struct vec_data *data)
> +{
> +	int ret, child_vl;
> +
> +	if (data->min_vl == data->max_vl) {
> +		ksft_test_result_skip("%s only one VL supported\n",
> +				      data->name);
> +		return;
> +	}
> +
> +	ret = prctl(data->prctl_set, data->min_vl | PR_SVE_VL_INHERIT);
> +	if (ret < 0) {
> +		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
> +				      data->name, data->min_vl,
> +				      errno, strerror(errno));
> +		return;
> +	}
> +
> +	/* The _INHERIT flag should be present when we read the VL */
> +	ret = prctl(data->prctl_get);
> +	if (ret == -1) {
> +		ksft_test_result_fail("%s prctl() read failed: %d (%s)\n",
> +				      data->name, errno, strerror(errno));
> +		return;
> +	}
> +	if (!(ret & PR_SVE_VL_INHERIT)) {
> +		ksft_test_result_fail("%s prctl() does not report _INHERIT\n",
> +				      data->name);
> +		return;
> +	}

It occurs to me that tt would make sense to test that the
PR_SVE_VL_INHERIT flag (or lack thereof) does the right thing for
further execs in the child.  If reposting, it could make sense to add
this as a TODO, but don't sweat it otherwise.

[...]

Cheers
---Dave
