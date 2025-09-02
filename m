Return-Path: <linux-kselftest+bounces-40536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A12B3F994
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBD12C24C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571BA2E7646;
	Tue,  2 Sep 2025 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDoF4F1d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA1DDD2;
	Tue,  2 Sep 2025 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803830; cv=none; b=M244URbpIsd4U0o1t3X8kAaJAMRBNLRsGXbC52+hDkWFeXSidVBotghwitolzmvSjhjpl4BAmphqnOe5qiZt0JE3cYb1wnUuAw62Nx80PrYSSl/nnVakKewGC6kGS++uv5kZrrjFpr5Z0eJJtNdxYhQo3Gz3rbctKXqCqt85D1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803830; c=relaxed/simple;
	bh=XSGx5WcjG6DtHmHu+mXlygkptZCaYu11n470dQLZtrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9nUJuK8bmMJvRhPfFGMZwyKnrNDayazF/Qwocwlj/D3SMkUInVV+6nxj7pax9cUWsukL+iufAu0ogz0iv4NOUwI4pI47Drcj2H4tNUXNUR8m2jaPZfP/mVaeqnC+lgtNjMBDaufxnfKc6MeR+xSqx1cFr04dR1TpzTnnmFIcXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDoF4F1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783ACC4CEED;
	Tue,  2 Sep 2025 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756803829;
	bh=XSGx5WcjG6DtHmHu+mXlygkptZCaYu11n470dQLZtrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDoF4F1dlQJzNzeAOE+nPxgGph3Af8zNLZjnysoRvmJvJRZY7pHhSZNfABBhtFoEr
	 OeFRyv1qr/XSOUtz+ujVBH30cibIlbPXwGvIRiqNKhyOjQKpTDKO9WMr2E1ferofKp
	 LodSlw+81TM1NJhLGjMLb5CEO5v6tHSFBcEEAtGoyuzsnXEj2fX/a4AFdC/rszk6+p
	 ho3khiUqUy2X87s+qoejMRaHNEkGEICVrWmBauy3LqdLRAlP4pP1rbUhV/TE44cYk8
	 MKSUnRAgObq5D8OYj0ndGEl38SjjRrsN3XcdHPOcvMEEJLi0xs4vdF9zTUWlHsvJMg
	 Zh9Cj5r7FrPqg==
Date: Tue, 2 Sep 2025 10:03:45 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, ecree.xilinx@gmail.com,
	gal@nvidia.com, joe@dama.to, linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: rss_ctx: use Netlink
 for timed reconfig
Message-ID: <20250902090345.GV15473@horms.kernel.org>
References: <20250901173139.881070-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901173139.881070-1-kuba@kernel.org>

On Mon, Sep 01, 2025 at 10:31:38AM -0700, Jakub Kicinski wrote:
> The rss_ctx test has gotten pretty flaky after I increased
> the queue count in NIPA 2->3. Not 100% clear why. We get
> a lot of failures in the rss_ctx.test_hitless_key_update case.
> 
> Looking closer it appears that the failures are mostly due
> to startup costs. I measured the following timing for ethtool -X:
>  - python cmd(shell=True)  : 150-250msec
>  - python cmd(shell=False) :  50- 70msec
>  - timed in bash           :  45- 55msec
>  - YNL Netlink call        :   2-  4msec
>  - .set_rxfh callback      :   1-  2msec
> 
> The target in the test was set to 200msec. We were mostly measuring
> ethtool startup cost it seems. Switch to YNL since it's 100x faster.
> 
> Lower the pass criteria to 150msec, no real science behind this number
> but we removed some overhead, drivers which previously passed 200msec
> should easily pass 150msec now.
> 
> Separately we should probably follow up on defaulting to shell=False,
> when script doesn't explicitly ask for True, because the overhead
> is rather significant.
> 
> Switch from _rss_key_rand() to random.randbytes(), YNL takes a binary
> array rather than array of ints.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - increase the threshold to safer 150msec
>  - mention change away from _rss_key_rand()
> v1: https://lore.kernel.org/20250829220712.327920-1-kuba@kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>


