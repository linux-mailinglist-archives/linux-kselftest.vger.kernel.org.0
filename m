Return-Path: <linux-kselftest+bounces-32865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D3DAB3CF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 18:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA8F18955BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E6024679B;
	Mon, 12 May 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERDx+8Bh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607178F43;
	Mon, 12 May 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065904; cv=none; b=UxC7849j0C34QbLbWNHpbjioWkbqmGxkWFZsWRmG8IUZlXS03ucpYsxItk/i8GgrCyzOGXumqABu6G7uvdPIa4il1z7Tr2QZhC4CShvtj9vcKhCQqoY5AD6q11e2j/dlybxJiNM1xdEtkFdzBmsJwQS20c8Bxw5SAznpPIYqPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065904; c=relaxed/simple;
	bh=1pwDJ0TsUrJ7i5wx/D/54PdIN0DS6dloMGFNVTqGk/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjRhkTeG6p8SDH1r5ypMX++/GMa7AO1c2poCQ8huRkm0JFnpy9HYMpzZDvGwIi4qJ2S3NMWk+SVC+X33LK0qBuCmX/huwKz2bMO/F0FJjHHVHciqHp8igVWYd9R9+/YTys8eqiLFQFzJuO/+RxmHAfYQ7sDDfZkH/673NpUbsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERDx+8Bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2246C4CEE7;
	Mon, 12 May 2025 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747065904;
	bh=1pwDJ0TsUrJ7i5wx/D/54PdIN0DS6dloMGFNVTqGk/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERDx+8Bh8EyBLNJFoNikOfiMX5UYwe9q1g7FuZVRJpNdrdiGEIALqd8yViVlqhEzr
	 aR66tZiDui/Ne+2aOFAx5Glqbw2RFPk386x6fEdv1413t9NcfFfpnIbB7tv4Ki/kEE
	 3Nrk0mCM4uxdvS+c7PM2BvGxPBoJ0Qv2SZ5JKNhCIJuGbKE4vkZxUJS9Q30P6PHJWc
	 QRjNIyKxD97tEJgjB0/loyXhVnM/jyjs9j68Cz6BRGDjOTZxV0M6/h+P8eUxmtWROh
	 LUrEWYPJIY1eH/vKUf/MrVmM1hmVJU00jl/N3aLdwLB8vu/l3vCQ3cB8DnuKiSzZhB
	 wNbWK5do1CpHw==
Date: Mon, 12 May 2025 17:04:58 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCHv2 net-next 3/6] selftests: net: use setup_ns for bareudp
 testing
Message-ID: <20250512160458.GQ3339421@horms.kernel.org>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
 <20250508081910.84216-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508081910.84216-4-liuhangbin@gmail.com>

On Thu, May 08, 2025 at 08:19:07AM +0000, Hangbin Liu wrote:
> Switch bareudp testing to use setup_ns, which sets up rp_filter by default.
> This allows us to remove the manual rp_filter configuration from the script.
> 
> Additionally, since setup_ns handles namespace naming and cleanup, we no
> longer need a separate cleanup function. We also move the trap setup earlier
> in the script, before the test setup begins.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


