Return-Path: <linux-kselftest+bounces-36418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E456AF70BC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 12:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292307BABE9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03BB2E4268;
	Thu,  3 Jul 2025 10:39:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BF2E425D;
	Thu,  3 Jul 2025 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539158; cv=none; b=AAF4aL0ehOzc9k49G12YzhHrmNWHR3/PkmyYdkuIzKGxh2bko5A5atokcJVwmzPRICUsN+KHMIqs5lbC1vNYO9I6FUTun6zsVnvkDzxT1u+UgwYNSh2DIESUtAK0K7nT3+9MYZpX+fJXQP1LH+KLKGT5xT3CqKkcjnWB+2RCfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539158; c=relaxed/simple;
	bh=1jefsmd4zg8EBH2ldyWTkAdUFdgVGaXykUlpYA+/LiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7wQ8HEKUK1WEnPzj6rNUpR435uvvf0a+VYVQaTMAMNZf1ZZ6Hp60lZAw5PmNJbP3JOk5USmaRmKkHTP049m/oMEIj0g+acbs9INmY0USN8LdcNI59dxrKpdDI9Znl57uoGcjj60V0qb2EfWk8HYQAVlzCjMBYIVvpI8FRYXgp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7234BC4CEF1;
	Thu,  3 Jul 2025 10:39:16 +0000 (UTC)
Date: Thu, 3 Jul 2025 11:39:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/4] kselftest/arm64: Add a test for vfork() with GCS
Message-ID: <aGZd0vdu8PpLKfX1@arm.com>
References: <20250610-arm64-gcs-vfork-exit-v2-0-929443dfcf82@kernel.org>
 <20250610-arm64-gcs-vfork-exit-v2-3-929443dfcf82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-arm64-gcs-vfork-exit-v2-3-929443dfcf82@kernel.org>

On Tue, Jun 10, 2025 at 01:29:46PM +0100, Mark Brown wrote:
> diff --git a/tools/testing/selftests/arm64/gcs/basic-gcs.c b/tools/testing/selftests/arm64/gcs/basic-gcs.c
> index 3fb9742342a3..96ea51cf7163 100644
> --- a/tools/testing/selftests/arm64/gcs/basic-gcs.c
> +++ b/tools/testing/selftests/arm64/gcs/basic-gcs.c
> @@ -298,6 +298,68 @@ static bool test_fork(void)
>  	return pass;
>  }
>  
> +/* A vfork()ed process can run and exit */
> +static bool test_vfork(void)
> +{
> +	unsigned long child_mode;
> +	int ret, status;
> +	pid_t pid;
> +	bool pass = true;
> +
> +	pid = vfork();
> +	if (pid == -1) {
> +		ksft_print_msg("vfork() failed: %d\n", errno);
> +		pass = false;
> +		goto out;
> +	}
> +	if (pid == 0) {
> +		/* In child, make sure we can call a function, read
> +		 * the GCS pointer and status and then exit */

Nit: coding style for multi-line comment. I guess we follow the kernel
style.

> +		valid_gcs_function();
> +		get_gcspr();
> +
> +		ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
> +				  &child_mode, 0, 0, 0);
> +		if (ret == 0 && !(child_mode & PR_SHADOW_STACK_ENABLE)) {
> +			ksft_print_msg("GCS not enabled in child\n");
> +			ret = -EINVAL;

Does it make sense in user-space to pass negative values to exit()? I
thought it should be between 0 and 255.

> +		}
> +
> +		exit(ret);

Should this be _exit() instead? IIRC exit() does some clean-ups which
are not safe in the vfork'ed child.

> +	}
> +
> +	/*
> +	 * In parent, check we can still do function calls then block
> +	 * for the child.
> +	 */

The comment "block for the child" doesn't make sense in this context.
vfork() already blocks the parent until exec() or _exit(). But I can see
why you wanted waitpid() to retrieve the return status.

> +	valid_gcs_function();
> +
> +	ksft_print_msg("Waiting for child %d\n", pid);
> +
> +	ret = waitpid(pid, &status, 0);
> +	if (ret == -1) {
> +		ksft_print_msg("Failed to wait for child: %d\n",
> +			       errno);
> +		return false;
> +	}
> +
> +	if (!WIFEXITED(status)) {
> +		ksft_print_msg("Child exited due to signal %d\n",
> +			       WTERMSIG(status));
> +		pass = false;
> +	} else {
> +		if (WEXITSTATUS(status)) {

Nit: } else if {

> +			ksft_print_msg("Child exited with status %d\n",
> +				       WEXITSTATUS(status));
> +			pass = false;
> +		}
> +	}
> +
> +out:
> +
> +	return pass;
> +}
> +
>  typedef bool (*gcs_test)(void);
>  
>  static struct {
> @@ -314,6 +376,7 @@ static struct {
>  	{ "enable_invalid", enable_invalid, true },
>  	{ "map_guarded_stack", map_guarded_stack },
>  	{ "fork", test_fork },
> +	{ "vfork", test_vfork },
>  };
>  
>  int main(void)

Other than the above, feel free add

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thomas, do you want to merge this via your tree? Thanks.

-- 
Catalin

