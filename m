Return-Path: <linux-kselftest+bounces-20977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D499B4E68
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25E51C2172E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA93A194AEB;
	Tue, 29 Oct 2024 15:47:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F831946BA;
	Tue, 29 Oct 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216845; cv=none; b=gpAhhMjybvx/4OLemReeu/9OpJgODdtFIHVTr9LPP6HfwtjRr2qmv3G7XsDQtzxCZ9A5J0w+pxMdFv82KyafL1ecrCSdwAByq2I21IkbMpKx1eZkZLUWJkmZpivx6/49DCoKerKRX2i1sztgqGHh9mRUlW53DsRvE0aN8QKwhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216845; c=relaxed/simple;
	bh=VZQryYaurtYA6T2JEui0TVybSCZS9HyFPWmE6LKbHBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbGA947rf64jMBCtHKFBO1qcpLWOWcbIatG9OWyfhs48WH1kGDTg137il25SN/vl2jmWb3IutPUwlC2ZYPuv2Do/ZSjxsVs6IKinl/e84Ez339TnZ005dc7tOgt/dIdksHxwuM3Q0OdohGpxcadu5hr5D5yFkxGVIyNPQgJCS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E631497;
	Tue, 29 Oct 2024 08:47:51 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D1E93F73B;
	Tue, 29 Oct 2024 08:47:20 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:47:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kselftest/arm64: Lower poll interval while waiting
 for fp-stress children
Message-ID: <ZyEDhuX3dDPxJ8a-@J2N7QTR9R3.cambridge.arm.com>
References: <20241029-arm64-fp-stress-interval-v1-0-db540abf6dd5@kernel.org>
 <20241029-arm64-fp-stress-interval-v1-2-db540abf6dd5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-arm64-fp-stress-interval-v1-2-db540abf6dd5@kernel.org>

Nit: the title says we lower the poll interval, while we actually raise
it. Maybe that'd be clearer as:

	kselftest/arm64: Raise poll timeout while waiting for fp-stress children

... or:

	kselftest/arm64: Poll less frequently while waiting for fp-stress children

That aside, this looks fine.

Mark.

On Tue, Oct 29, 2024 at 12:10:40AM +0000, Mark Brown wrote:
> While fp-stress is waiting for children to start it doesn't send any
> signals to them so there is no need for it to have as short an epoll()
> timeout as it does when the children are all running. We do still want to
> have some timeout so that we can log diagnostics about missing children but
> this can be relatively large. On emulated platforms the overhead of running
> the supervisor process is quite high, especially during the process of
> execing the test binaries.
> 
> Implement a longer epoll() timeout during the setup phase, using a 5s
> timeout while waiting for children and switching  to the signal raise
> interval when all the children are started and we start sending signals.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/fp-stress.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
> index c986c68fbcacdd295f4db57277075209193cb943..963e2d891ced72fb8d6eff4fdb5c7df0724b14f1 100644
> --- a/tools/testing/selftests/arm64/fp/fp-stress.c
> +++ b/tools/testing/selftests/arm64/fp/fp-stress.c
> @@ -453,6 +453,7 @@ int main(int argc, char **argv)
>  {
>  	int ret;
>  	int timeout = 10 * (1000 / SIGNAL_INTERVAL_MS);
> +	int poll_interval = 5000;
>  	int cpus, i, j, c;
>  	int sve_vl_count, sme_vl_count;
>  	bool all_children_started = false;
> @@ -588,7 +589,7 @@ int main(int argc, char **argv)
>  		 * especially useful in emulation where we will both
>  		 * be slow and likely to have a large set of VLs.
>  		 */
> -		ret = epoll_wait(epoll_fd, evs, tests, SIGNAL_INTERVAL_MS);
> +		ret = epoll_wait(epoll_fd, evs, tests, poll_interval);
>  		if (ret < 0) {
>  			if (errno == EINTR)
>  				continue;
> @@ -626,6 +627,7 @@ int main(int argc, char **argv)
>  			}
>  
>  			all_children_started = true;
> +			poll_interval = SIGNAL_INTERVAL_MS;
>  		}
>  
>  		if ((timeout % LOG_INTERVALS) == 0)
> 
> -- 
> 2.39.2
> 

