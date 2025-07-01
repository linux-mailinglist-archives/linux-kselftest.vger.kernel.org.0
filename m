Return-Path: <linux-kselftest+bounces-36156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BABAEF1F4
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 10:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D041A189B0DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 08:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB425BF00;
	Tue,  1 Jul 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuDEAy/B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9622259D;
	Tue,  1 Jul 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360201; cv=none; b=DPbLpv8aZrlgZ/G2m8Sgkq4yzk3ukWYrgHqAB4lnW2myX922ul/dVkVapg+b+IRDGOmNBjZRvY1i9361Ypb8PyfXCcwSogWM+q/zEtxj/oJ9tKYdfP4b/lp9Pae8z2V1gBbuIqdRV7oLKpOYdwaQac+8ExF2V/uCY9SjJSuEbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360201; c=relaxed/simple;
	bh=hGTbzFeiGRAeM/xA+LxhQGuTssE+brcCTfBWGQ03zYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quqT7udNfaM3zkWqZgEDRVBDjYD5V4ktpn8GYlRQlXLPP6K7Hky2hHZKDJDAANyM2dKTRB50saMD4UUsdczKZHLLBighqw/LNxLhwuErpggzJd8SvGR/ihN3ja2qKEUS3LBmvBjAIp+QGQHc4lRCaFTQz/pod4OtYAUhxqoha3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuDEAy/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16504C4CEEB;
	Tue,  1 Jul 2025 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751360200;
	bh=hGTbzFeiGRAeM/xA+LxhQGuTssE+brcCTfBWGQ03zYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SuDEAy/BcOF3bR4Z3Nw6y20gcqjY4x+/rNNLjYYHiBv5QIC2cSLEZZ24Ct5O49ul5
	 3BtF8t3wk63JfKvdlo7jRoU0lq0njvAYZ+1EELhx4wV+fTNndy1AJq6GfKAILJZoLv
	 CDLm6RrO0fzgii7I7d8E5uX8OHkplK7DAiHZEYvA7cTSTFwOPgQbm8nQoGXKjnlqpe
	 hUR6Wu1hfkWuV4m/+8YvPX/7o6ARANlOf7T5JDy+Dg7CttWG94Y/ZIANTxYdKYFD/g
	 fvw/+IGI/Jskf3rc5rSuq9HYNWE8xmo9TlT5mN65OHvczflGO22Zfe/8s2W3qNd5Dm
	 M1rH9nO9tBEjQ==
Message-ID: <0fd1cb1e-61ca-41ea-8fba-5b160e901b87@kernel.org>
Date: Tue, 1 Jul 2025 10:56:34 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/2] selftests: pp-bench: remove unneeded
 linux/version.h
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 kernel test robot <lkp@intel.com>
References: <20250627200501.1712389-1-almasrymina@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250627200501.1712389-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/06/2025 22.04, Mina Almasry wrote:
> linux/version.h was used by the out-of-tree version, but not needed in
> the upstream one anymore.
> 
> While I'm at it, sort the includes.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506271434.Gk0epC9H-lkp@intel.com/
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>   .../selftests/net/bench/page_pool/bench_page_pool_simple.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

