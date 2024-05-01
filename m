Return-Path: <linux-kselftest+bounces-9193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183628B8948
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 13:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405DB1C210BF
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 11:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDF3745D6;
	Wed,  1 May 2024 11:35:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E964A98;
	Wed,  1 May 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563317; cv=none; b=KMdqh4RadnsJK81FdXebAUy4Q9HZyKUkr5FZYiV7bETB8O+6D4cvhoFJeEiKCs0SziD6WjpwSX3FVJ0bFLjKQFKb6+f9/OHNPCP3tZ7gwwv65oWKxqNGNvr79RYCOsxxjJc488Vtj+KNNxCWKuFE8Y9Zo2e4rJ/cc+X/1AtAgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563317; c=relaxed/simple;
	bh=wJy87bfpS7s04Gzynz66njZDUrj0KmFwHecK8KcHmF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG8hRjyphwkzGvnBnqZGnVE/+7L44wDINj7fNUS4smBuOnvNKicXiCwUK3otDUFXNxiqAP5flexkjR3G+YkZGRVFM8kg5Skhbi3SdftG0a+bM+jC0xKB8b6iHtUFnCrKttkeD1oBK2Zg1H9c4Q5ORu8NvhWYrlwy2ZEiyccKJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82CB42F4;
	Wed,  1 May 2024 04:35:41 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 347083F793;
	Wed,  1 May 2024 04:35:14 -0700 (PDT)
Date: Wed, 1 May 2024 12:35:08 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Dorine Tipo <dorine.a.tipo@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH] selftests:arm64: Test PR_SVE_VL_INHERIT after a double
 fork
Message-ID: <ZjIo7E/IBYlNvO8H@e133380.arm.com>
References: <20240429044012.5018-1-dorine.a.tipo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429044012.5018-1-dorine.a.tipo@gmail.com>

On Mon, Apr 29, 2024 at 04:40:12AM +0000, Dorine Tipo wrote:
> [PATCH] selftests:arm64: Test PR_SVE_VL_INHERIT after a double fork

Nit: Please follow the same commit message prefix convention as in the
existing code (e.g., try git log tools/testing/selftests/arm64/fp/ ).

[...]

> Add a new test, double_fork_test() to check the inheritance of the SVE
> vector length after a double fork.
> The `EXPECTED_TESTS` macro has been updated to account for this additional
> test.
> This patch addresses task 7 on the TODO list.
> 
> Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
> ---
>  tools/testing/selftests/arm64/fp/za-fork.c | 95 +++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/za-fork.c b/tools/testing/selftests/arm64/fp/za-fork.c
> index 587b94648222..35229e570dcf 100644
> --- a/tools/testing/selftests/arm64/fp/za-fork.c
> +++ b/tools/testing/selftests/arm64/fp/za-fork.c
> @@ -11,7 +11,7 @@
> 
>  #include "kselftest.h"
> 
> -#define EXPECTED_TESTS 1
> +#define EXPECTED_TESTS 2
> 
>  int fork_test(void);
>  int verify_fork(void);
> @@ -69,6 +69,97 @@ int fork_test_c(void)
> 	}

"git am" or "patch" report the patch as corrupted here, any idea why?

Fixing the whitespace here allows the patch to be applied, but it still
doesn't seem to build, so I think there are bigger problems here.

>  }
> 
> +int double_fork_test(void)
> +{
> +	pid_t newpid, grandchild_pid, waiting;
> +	int ret, child_status, parent_result;
> +
> +	ret = prctl(PR_SVE_SET_VL, vl | PR_SVE_VL_INHERIT);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("Failed to set SVE VL %d\n", vl);

Thanks for the attempt, but this file doesn't look like the correct
place to add these tests.  This file is specific to testing SME (the
"ZA" register array is specific to SME). Looking at the history of the
TODO file, it looks like the entry you're looking at was related to the
tests in vec-syscfg.c.  That looks like a better place to test the API
behaviour of these prctl calls; most of the needed framework is already
there.

So, please consider adapting vec-syscfg.c to add the double-fork tests,
rather than trying to write this from scratch.

(See commit e96595c55d23 ("kselftest/arm64: Add a TODO list for floating
point tests") for history.)


If you haven't already done so, you should go and look at the following
to get a better idea of how these prctl calls are supposed to work:

Documentation/arch/arm64/sve.rst
Documentation/arch/arm64/sme.rst

The prctl(2) man page also documents the SVE prctls:

https://man7.org/linux/man-pages/man2/prctl.2.html .


[more comments below]

> +
> +	newpid = fork();
> +	if (newpid == 0) {
> +		/* In child */
> +		if (!verify_fork()) {
> +			ksft_print_msg("ZA state invalid in child\n");
> +			exit(0);
> +		}
> +
> +		grandchild_pid = fork();
> +		if (grandchild_pid == 0) {
> +			/* in grandchild */
> +			if (!verfy_fork()) {
> +				ksft_print_msg("ZA state invalid in grandchild\n");
> +				exit(0);
> +			}
> +
> +			ret = prctl(PR_SVE_GET_VL);
> +			if (ret & PR_SVE_VL_INHERIT) {
> +				ksft_print_msg("prctl() reports _INHERIT\n");
> +				return;
> +			}
> +			 ksft_print_msg("prctl() does not report _INHERIT\n");
> +
> +		} else if (grandchild_pid < 0) {
> +			ksft_print_msg("fork() failed in first child: %d\n", grandchild_pid);
> +			return 0;
> +		}
> +
> +		/*  Wait for the grandchild process to exit */
> +		waiting = waitpid(grandchild_pid, &child_status, 0);
> +		if (waiting < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			ksft_print_msg("waitpid() failed: %d\n", errno);
> +			return 0;
> +		}
> +		if (waiting != grandchild_pid) {
> +			ksft_print_msg("waitpid() returned wrong PID\n");
> +			return 0;
> +		}
> +
> +		if (!WIFEXITED(child_status)) {
> +			ksft_print_msg("grandchild did not exit\n");
> +			return 0;
> +		}
> +
> +		exit(1);
> +		}
> +	}
> +	if (newpid < 0) {
> +		ksft_print_msg("fork() failed: %d\n", newpid);
> +
> +		return 0;
> +	}
> +
> +	parent_result = verify_fork();
> +	if (!parent_result)
> +		ksft_print_msg("ZA state invalid in parent\n");
> +
> +	for (;;) {
> +		waiting = waitpid(newpid, &child_status, 0);
> +
> +		if (waiting < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			ksft_print_msg("waitpid() failed: %d\n", errno);
> +			return 0;
> +		}
> +		if (waiting != newpid) {
> +			ksft_print_msg("waitpid() returned wrong PID\n");
> +			return 0;
> +		}
> +
> +		if (!WIFEXITED(child_status)) {
> +			ksft_print_msg("child did not exit\n");
> +			return 0;
> +		}
> +
> +		return WEXITSTATUS(child_status) && parent_result;
> +	}
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int ret, i;
> @@ -86,11 +177,13 @@ int main(int argc, char **argv)
>  	ret = open("/proc/sys/abi/sme_default_vector_length", O_RDONLY, 0);
>  	if (ret >= 0) {
>  		ksft_test_result(fork_test(), "fork_test\n");
> +		ksft_test_result(double_fork_test(), "double_fork_test\n");
> 
>  	} else {
>  		ksft_print_msg("SME not supported\n");
>  		for (i = 0; i < EXPECTED_TESTS; i++) {
>  			ksft_test_result_skip("fork_test\n");
> +			ksft_test_result_skip("double_fork_test\n");

I'm not very familiar with the kselftest framework, but this looks
weird to me.

Why should we skip both tests twice when there are two tests?

(Looking at the history, I think this loop may have been left behind
from an old edit and perhaps shouldn't be there any more.  Comparing
with the way ksft_test_result_skip() is used in other tests may provide
a clue.  Maybe Mark Brown remembers...)


>  		}
>  	}

And finally... how are you running these tests?

Cheers
---Dave

