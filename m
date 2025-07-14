Return-Path: <linux-kselftest+bounces-37274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F06B0476C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70C21A66B5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E752222B7;
	Mon, 14 Jul 2025 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9y/HdDp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633333DF;
	Mon, 14 Jul 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752517930; cv=none; b=c6cgkk5+oLhVAMlHac5oVbtcxecHuTVV693xHMpG9sAR6EtS13DZojTOjGIgKzFCeKoV2z06aYexVqe3STPKWUmm03mctBuiXvLSJfZ5Nn6jcBltdV3BE0bFPZPlVGjBFISiCMNGCH6x7/zCIXAkUtSYu3onnlWOrnRYeZhLaLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752517930; c=relaxed/simple;
	bh=ks3/3ROY4dohrzpsF7ZXAhp1+8huiSGIbd6VW6K4kAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgRy1wWFsfDHbPWqfE6KGRIYG9q3quOWZxobsrXOu09KHJe3aRHFhDtniTKcfhyzkKdih6UQ4u92dWu4FPiOiRfYKisGcKSov9S1IU1X/tB8Cg6x7rHQcfej8jikTEj9Ehq1E7jsVFKLsHHX6Cp0GYdGohpZ4Bmf1Gd+BvjID9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9y/HdDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11117C4CEED;
	Mon, 14 Jul 2025 18:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752517929;
	bh=ks3/3ROY4dohrzpsF7ZXAhp1+8huiSGIbd6VW6K4kAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9y/HdDpbvhJPnFdHi+/2I+2G/mazXV92f7zK0S0GJ5jJCyuYCphrBf362TLDf17Q
	 jBqO0fCNQVOr2d2ZiH04oi9F/nax1pS5Ow2MeqG9ue8sEOspZRepGBv6Q58FmvG/hR
	 ACUzIXn7pytNE1bBhkF+1nHLKwBguhd46zlOi/b6A4r2JiqN0CQsyjdsXK2T/D3uv/
	 r1vGpeBn4U3j7usVdFDw+bDz2KqL6v5akWLLmgtuCJJkJ8iNPUV0dvSNuvHJ8iS3/r
	 hBIbfreh7rsYvkXgEfREr/5kWOwcfgqNxbkEEIeTWaBGFP7o/hREFO7mlnfNaCLAvs
	 VO4MEw0M/Lkew==
Date: Mon, 14 Jul 2025 19:32:06 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: increase inter-packet timeout in
 udpgro.sh
Message-ID: <20250714183206.GT721198@horms.kernel.org>
References: <b0370c06ddb3235debf642c17de0284b2cd3c652.1752163107.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0370c06ddb3235debf642c17de0284b2cd3c652.1752163107.git.pabeni@redhat.com>

On Thu, Jul 10, 2025 at 06:04:50PM +0200, Paolo Abeni wrote:
> The mentioned test is not very stable when running on top of
> debug kernel build. Increase the inter-packet timeout to allow
> more slack in such environments.
> 
> Fixes: 3327a9c46352 ("selftests: add functionals test for UDP GRO")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

As I understand it, the motivation for this patch was to make
this test more resilient [1].

[1] [TEST] net/udpgro.sh is flaky on debug
    https://lore.kernel.org/netdev/20250710070907.33d11177@kernel.org/

My observation is that it has been used since the 10th.
And that there have been no failures since the 10th [2].

In slightly more detail. The last failure was now 4 days ago.
It occurred with net-next-2025-07-10--12-00 which did not include this patch.

[2] https://netdev.bots.linux.dev/contest.html?executor=vmksft-net-dbg&test=u`dpgro-sh&ld_cnt=200&pass=0

So while it might be prudent to wait a few more days.
So far this gets my thumbs up.

Reviewed-by: Simon Horman <horms@kernel.org>

