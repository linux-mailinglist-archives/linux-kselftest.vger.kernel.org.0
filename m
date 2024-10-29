Return-Path: <linux-kselftest+bounces-20974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0D89B4E50
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EFB28296C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C74194C61;
	Tue, 29 Oct 2024 15:43:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E24192D91;
	Tue, 29 Oct 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216625; cv=none; b=LUHOC1F14Bn4b2udLeIFTEKdrgWPSu3roJI8PSFTvCAtCbobl8ZES3reDUUhQwqRjuwfCL2fS8Mb8AeH0pyW0lW7yr8P2jSSZ9P34P3UgmofmNc/Zbq7noYMC8lGGMxcB1esny9uE7zVW0x1SJDeQYadfwZVTcJSEkCkx216Yn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216625; c=relaxed/simple;
	bh=Vm7aoA5pnFaMAKC3ESPROQTMibusFmYq0cqGc4TgUgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmXViduGDP464hPi6uTiVfsDn85EZ3Oj/jRdUw11/81wM9P6mYBWK/hK/lLTg39R+B8QxrDPVwwdd8a2CPEKf/Pi92XjI8Ux548jtCS1xVjW5MWJLnA30NjE9ndDgIblfujBcksddSZKHvGYYOlIGcvbl9IQ30jHRL4VsUePjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EABE1497;
	Tue, 29 Oct 2024 08:44:10 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F27CF3F73B;
	Tue, 29 Oct 2024 08:43:39 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:43:37 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kselftest/arm64: Increase frequency of signal
 delivery in fp-stress
Message-ID: <ZyECqagB1tGdE4uz@J2N7QTR9R3.cambridge.arm.com>
References: <20241029-arm64-fp-stress-interval-v1-0-db540abf6dd5@kernel.org>
 <20241029-arm64-fp-stress-interval-v1-1-db540abf6dd5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-arm64-fp-stress-interval-v1-1-db540abf6dd5@kernel.org>

Hi Mark,

On Tue, Oct 29, 2024 at 12:10:39AM +0000, Mark Brown wrote:
> Currently we only deliver signals to the processes being tested about
> once a second, meaning that the signal code paths are subject to
> relatively little stress. Increase this frequency substantially to
> 25ms intervals, along with some minor refactoring to make this more
> readily tuneable and maintain the 1s logging interval. This interval
> was chosen based on some experimentation with emulated platforms to
> avoid causing so much extra load that the test starts to run into the
> 45s limit for selftests or generally completely disconnect the timeout
> numbers from the

Looks like the end of the sentence got deleted?

On those emulated platforms (FVP?), does this change trigger the faukure
more often?

I gave this a quick test, and with this change, running fp-stress on a
defconfig kernel running on 1 CPU triggers the "Bad SVCR: 0" splat in
35/100 runs. Hacking that down to 5ms brings that to 89/100 runs. So
even if we have to keep this high for an emulated platform, it'd
probably be worth being able to override that as a parameter?

Otherwise, maybe it's worth increasing the timeout for the fp-stress
test specifically? The docs at:

  https://docs.kernel.org/dev-tools/kselftest.html#timeout-for-selftests

... imply that is possible, but don't say exactly how, and it seems
legitimate for a stress test.

> We could increase this if we moved the signal generation out of the main
> supervisor thread, though we should also consider that he percentage of
> time that we spend interacting with the floating point state is also a
> consideration.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/fp-stress.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
> index faac24bdefeb9436e2daf20b7250d0ae25ca23a7..c986c68fbcacdd295f4db57277075209193cb943 100644
> --- a/tools/testing/selftests/arm64/fp/fp-stress.c
> +++ b/tools/testing/selftests/arm64/fp/fp-stress.c
> @@ -28,6 +28,9 @@
>  
>  #define MAX_VLS 16
>  
> +#define SIGNAL_INTERVAL_MS 25
> +#define LOG_INTERVALS (1000 / SIGNAL_INTERVAL_MS)

Running this, I see that by default test logs:

	# Will run for 400s

... for a timeout that's actually ~10s, due to the following, which isn't in
the diff:

	if (timeout > 0)
		ksft_print_msg("Will run for %ds\n", timeout);

... so that probably wants an update to either convert to seconds or be in
terms of signals, and likewise for the "timeout remaining" message below.

Otherwise, this looks good to me.

Mark.

> +
>  struct child_data {
>  	char *name, *output;
>  	pid_t pid;
> @@ -449,7 +452,7 @@ static const struct option options[] = {
>  int main(int argc, char **argv)
>  {
>  	int ret;
> -	int timeout = 10;
> +	int timeout = 10 * (1000 / SIGNAL_INTERVAL_MS);
>  	int cpus, i, j, c;
>  	int sve_vl_count, sme_vl_count;
>  	bool all_children_started = false;
> @@ -578,14 +581,14 @@ int main(int argc, char **argv)
>  			break;
>  
>  		/*
> -		 * Timeout is counted in seconds with no output, the
> -		 * tests print during startup then are silent when
> -		 * running so this should ensure they all ran enough
> -		 * to install the signal handler, this is especially
> -		 * useful in emulation where we will both be slow and
> -		 * likely to have a large set of VLs.
> +		 * Timeout is counted in poll intervals with no
> +		 * output, the tests print during startup then are
> +		 * silent when running so this should ensure they all
> +		 * ran enough to install the signal handler, this is
> +		 * especially useful in emulation where we will both
> +		 * be slow and likely to have a large set of VLs.
>  		 */
> -		ret = epoll_wait(epoll_fd, evs, tests, 1000);
> +		ret = epoll_wait(epoll_fd, evs, tests, SIGNAL_INTERVAL_MS);
>  		if (ret < 0) {
>  			if (errno == EINTR)
>  				continue;
> @@ -625,8 +628,9 @@ int main(int argc, char **argv)
>  			all_children_started = true;
>  		}
>  
> -		ksft_print_msg("Sending signals, timeout remaining: %d\n",
> -			       timeout);
> +		if ((timeout % LOG_INTERVALS) == 0)
> +			ksft_print_msg("Sending signals, timeout remaining: %d\n",
> +				       timeout);
>  
>  		for (i = 0; i < num_children; i++)
>  			child_tickle(&children[i]);
> 
> -- 
> 2.39.2
> 

