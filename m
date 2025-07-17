Return-Path: <linux-kselftest+bounces-37512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA514B093C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 20:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4069B7AA63D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3142FE314;
	Thu, 17 Jul 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvpIbgXB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6EF881E;
	Thu, 17 Jul 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752775967; cv=none; b=cedaRblz+uNzt0svav9S3hpZdFRMoOQ9oniKFHOsIlCobEFVkJJXlfWJ8xrwNy1R5KnEl5yvdifcY4Ybd3kBww5wioP2nCfCOPm9Dg2Yb9xt2Ce6gnEguieooA6ZAdcK/rzLmO2qCrQpfe2tvtKyCl1eH19mAaJJ9u0aIU4dADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752775967; c=relaxed/simple;
	bh=Emv8TeVfMJh4jWDpIbQ0EaCEKtM4JheYqPtNZjTPtg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8kAWT8d9qbYcinYJkN0EjaxWMda2In0F6uR+QuJYrh0PvnFTXCtahBOX7TBfPBGzPeat3j78PWkkxt3MuVCvnBWJRlcZ9erO2+djf+OID/5XzeZikWL7Mcxi/lgRPPiODhl5RHOxXSxr4+QPczMUV8KlVSOPDVlbtu/gTdm3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvpIbgXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F59C4CEED;
	Thu, 17 Jul 2025 18:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752775966;
	bh=Emv8TeVfMJh4jWDpIbQ0EaCEKtM4JheYqPtNZjTPtg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvpIbgXB+tYANPiqnaHyTg1VSFMq5/CIym2xiFLQ/WWwWLsNPwflAMd6r8Xuho5Xs
	 8U8BvVOfqv9bLuEJWU8BE0+c8x17xu9ETU/huhtPSr7a+wk4PzzhM9mDe3yzFxKIYI
	 jHgniFwclab/BV0FQTzf4BhqGBJMsG0H/8N+MPJBEo4RDARX8BXG+0E5vwX98dqD+J
	 bw9lJylaH59Qdn6QN2//xXBeZTS9f6S9XVLriy7xEIt/o1/woFUeYdd1Xt57LFUamp
	 gQ9Opqtn5wevxhMFyWP77SpTHd5vL45vhZIt1/kYCmU13ZMQV906RSkhOqv3zUaSX4
	 QMKGDRtVnkU6Q==
Date: Thu, 17 Jul 2025 08:12:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v3] selftests/cgroup: fix cpu.max tests
Message-ID: <aHk9HHA2vMEGBiI4@slm.duckdns.org>
References: <20250703120325.2905314-1-shashank.mahadasyam@sony.com>
 <20250704110843.1022518-1-shashank.mahadasyam@sony.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250704110843.1022518-1-shashank.mahadasyam@sony.com>

On Fri, Jul 04, 2025 at 08:08:41PM +0900, Shashank Balaji wrote:
> Current cpu.max tests (both the normal one and the nested one) are broken.
> 
> They setup cpu.max with 1000 us quota and the default period (100,000 us).
> A cpu hog is run for a duration of 1s as per wall clock time. This corresponds
> to 10 periods, hence an expected usage of 10,000 us. We want the measured
> usage (as per cpu.stat) to be close to 10,000 us.
> 
> Previously, this approximate equality test was done by
> `!values_close(usage_usec, expected_usage_usec, 95)`: if the absolute
> difference between usage_usec and expected_usage_usec is greater than 95% of
> their sum, then we pass. And expected_usage_usec was set to 1,000,000 us.
> Mathematically, this translates to the following being true for pass:
> 
> 	|usage - expected_usage| > (usage + expected_usage)*0.95
> 
> 	If usage > expected_usage:
> 		usage - expected_usage > (usage + expected_usage)*0.95
> 		0.05*usage > 1.95*expected_usage
> 		usage > 39*expected_usage = 39s
> 
> 	If usage < expected_usage:
> 		expected_usage - usage > (usage + expected_usage)*0.95
> 		0.05*expected_usage > 1.95*usage
> 		usage < 0.0256*expected_usage = 25,600 us
> 
> Combined,
> 
> 	Pass if usage < 25,600 us or > 39 s,
> 
> which makes no sense given that all we need is for usage_usec to be close to
> 10,000 us.
> 
> Fix this by explicitly calcuating the expected usage duration based on the
> configured quota, default period, and the duration, and compare usage_usec
> and expected_usage_usec using values_close() with a 10% error margin.
> 
> Also, use snprintf to get the quota string to write to cpu.max instead of
> hardcoding the quota, ensuring a single source of truth.
> 
> Remove the check comparing user_usec and expected_usage_usec, since on running
> this test modified with printfs, it's seen that user_usec and usage_usec can
> regularly exceed the theoretical expected_usage_usec:
> 
> 	$ sudo ./test_cpu
> 	user: 10485, usage: 10485, expected: 10000
> 	ok 1 test_cpucg_max
> 	user: 11127, usage: 11127, expected: 10000
> 	ok 2 test_cpucg_max_nested
> 	$ sudo ./test_cpu
> 	user: 10286, usage: 10286, expected: 10000
> 	ok 1 test_cpucg_max
> 	user: 10404, usage: 11271, expected: 10000
> 	ok 2 test_cpucg_max_nested
> 
> Hence, a values_close() check of usage_usec and expected_usage_usec is
> sufficient.
> 
> Fixes: a79906570f9646ae17 ("cgroup: Add test_cpucg_max_nested() testcase")
> Fixes: 889ab8113ef1386c57 ("cgroup: Add test_cpucg_max() testcase")
> Acked-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

Applied to cgroup/for-6.17.

Thanks.

-- 
tejun

