Return-Path: <linux-kselftest+bounces-30366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE9A812D4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB3F17DB4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CA822F38B;
	Tue,  8 Apr 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhcpETmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780762253FF;
	Tue,  8 Apr 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131008; cv=none; b=GtcmJaWRFTglKSXLxOyZkJLPuZgsWtAxiyB82yro2OBuE+pWaNxX/kZmNEvjgqmx+r0b/G5XP8UFN5W3ZsGuO0dYqBhpj0Q0+bABN/0Gu4ZIJ3fUpT1+ecXXbLzuB33i+W5l9c8+7+8010eQJqUOKYbGvFt6f4TV9H0yudOhy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131008; c=relaxed/simple;
	bh=SkkXv1Isbh+8m8UsVP/5c36fvKARvVhGd2CDzHT+Des=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzm6IhCCmm+n0hDcYpmjH0JWneXMiM5SeYrhoInHYWqlWnk4593irDExnKspTLn1h/4ZC6o6c1QkNpEuWathrKKC4a9mB5AIr5aHRzbjfo1HKEDjzs6UJjcwKF+fHXz2T4lSftuGXSWqHansHZqoDN87ukZMiDNjBi2UCxwPkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhcpETmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA98AC4CEE5;
	Tue,  8 Apr 2025 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744131006;
	bh=SkkXv1Isbh+8m8UsVP/5c36fvKARvVhGd2CDzHT+Des=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhcpETmYBn1Aoy8cbJphA+6Nncu3m56aBX9TidjNwaX7ukzrIbWAZYJtq4YdmiMoV
	 82rOb/+B+WDsJ/6i8weAemJaJhaUqCTOpNTgtCPhRFKM558VEHgqky0e9KZuxTGqZ8
	 qBFHk8k4S0U3VnexkZ6TowiOD7Fo2LhdoTb2w2B25gqhJ0wZKDbSpU/2J3piiJ9rNK
	 D3HqxtXgNn9ofJZ/dUUX3o3M/JlWO3a/LO4qXRjdGHnk8IXHzz7oNG1oZRz699RiYZ
	 xgKBhkwT1A+amCrRN9cI2B7ZG28+Ib9md6Sf08+HgMzcOwNoL8pvgmLEjwfmipsE2J
	 nIrGk61zwl1ZQ==
Date: Tue, 8 Apr 2025 17:50:02 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: mptcp: validate MPJoin HMacFailure
 counters
Message-ID: <20250408165002.GG395307@horms.kernel.org>
References: <20250407-net-mptcp-hmac-failure-mib-v1-0-3c9ecd0a3a50@kernel.org>
 <20250407-net-mptcp-hmac-failure-mib-v1-2-3c9ecd0a3a50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-net-mptcp-hmac-failure-mib-v1-2-3c9ecd0a3a50@kernel.org>

On Mon, Apr 07, 2025 at 08:26:33PM +0200, Matthieu Baerts (NGI0) wrote:
> The parent commit fixes an issue around these counters where one of them
> -- MPJoinAckHMacFailure -- was wrongly incremented in some cases.
> 
> This makes sure the counter is always 0. It should be incremented only
> in case of corruption, or a wrong implementation, which should not be
> the case in these selftests.
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


