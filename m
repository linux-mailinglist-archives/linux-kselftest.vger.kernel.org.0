Return-Path: <linux-kselftest+bounces-13458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EFF92D0B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 13:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E361C21D49
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA018FDD7;
	Wed, 10 Jul 2024 11:31:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87325757;
	Wed, 10 Jul 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611085; cv=none; b=szNjF84d+287gW04EvVcE1BCB4/PbwAkSews4Wc2CzYiVvWpFrGoBB+qj3OFKuqzPj4y7xrGcsVj3xmQMHJfAYz3Hl0v4a1rAfdq+wjFTR0Kl8fH/M9kmYnnX+E1pdqodl3gyHSLk/1gvb6v9l6UFJDMXsG4RbNIbj9D5KQrtNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611085; c=relaxed/simple;
	bh=iud5V400U/4DVUMX/ecCQPH0l2Tpll+t3Kkg2R/9jS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0VwW8Ige3bc5vC5qNy2DVWjSazCsKeBO5Sv0IUvm7xLTt7Ras/bj7ehkdKlRHcMHFh55J2wjbkDzlTjzRm6x0n/+2heX6SbVYqnrTJbbHxMxUHMpYxZhrSr3HiFP0u4efAuiQu6U2MyHB8JuHIeq1Lv9gy/GiRdY/d+emcRoug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8B0C32781;
	Wed, 10 Jul 2024 11:31:23 +0000 (UTC)
Date: Wed, 10 Jul 2024 12:31:21 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>, kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] selftests: arm64: tags_test: conform test to TAP
 output
Message-ID: <Zo5xCW9GJqFeTZUi@arm.com>
References: <20240602132502.4186771-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602132502.4186771-1-usama.anjum@collabora.com>

On Sun, Jun 02, 2024 at 06:24:59PM +0500, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/arm64/tags/tags_test.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
> index 955f87c1170d7..8ae26e496c89c 100644
> --- a/tools/testing/selftests/arm64/tags/tags_test.c
> +++ b/tools/testing/selftests/arm64/tags/tags_test.c
> @@ -17,19 +17,21 @@ int main(void)
>  	static int tbi_enabled = 0;
>  	unsigned long tag = 0;
>  	struct utsname *ptr;
> -	int err;
> +
> +	ksft_print_header();
> +	ksft_set_plan(1);
>  
>  	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
>  		tbi_enabled = 1;
>  	ptr = (struct utsname *)malloc(sizeof(*ptr));
>  	if (!ptr)
> -		ksft_exit_fail_msg("Failed to allocate utsname buffer\n");
> +		ksft_exit_fail_perror("Failed to allocate utsname buffer");
>  
>  	if (tbi_enabled)
>  		tag = 0x42;
>  	ptr = (struct utsname *)SET_TAG(ptr, tag);
> -	err = uname(ptr);
> +	ksft_test_result(!uname(ptr), "Syscall successful with tagged address\n");
>  	free(ptr);
>  
> -	return err;
> +	ksft_finished();
>  }

Sorry, these patches slipped through the cracks. We seem to be pretty
inconsistent with using ksft_exit_fail_perror() and ksft_finished(). Is
there some plan to update the rest or is it only this location that you
came across?

Adding Mark Brown as well to this thread, he's been contributing quite a
lot recently to the arm64 kselftests.

-- 
Catalin

