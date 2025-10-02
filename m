Return-Path: <linux-kselftest+bounces-42669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4EFBB3A9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 12:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DD118935E0
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF16030ACFA;
	Thu,  2 Oct 2025 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRUM9uDv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EEF309F1A;
	Thu,  2 Oct 2025 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401496; cv=none; b=nQ6dGAqrbgQnJvWcsBJj/Hc2noNYpi2CuiRkaf/Alomvktcl1eZ1nkKFuxcfCiGxsagQSQys20YH5b2LEeNcar5VOFTok/h7ZlZzDEKnmcwuLWJGJBN1cYHaoitqgjyBau2dMOZbwIhj4jD8Dsr7xcqlzUXkTcgv9YzqSHGd//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401496; c=relaxed/simple;
	bh=KeI5d3+2YnPmPIXcc3sgPV7o/PR5eznfYdX4qgEWfpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=afqxysMJMnFRjhyKs7qhvHvJRIC1Q5GOb0F2jy2wKdCmtC+o0A/qgf01IBWLc9egTLlP3K0X7oKKJ9qmQnfgXcl3evMTIBiW24ay/w7CAGRa7FF8mp0QY/dmRvFOnVG9reZL0ZtmKSTEY0Q5pcQ7peLjzFt3RKQXjwBqn1ZykQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRUM9uDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D87C4CEFB;
	Thu,  2 Oct 2025 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759401496;
	bh=KeI5d3+2YnPmPIXcc3sgPV7o/PR5eznfYdX4qgEWfpY=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=oRUM9uDvMl0lwASI/FMj2EeOhvffB6fLjwXw+MNDQSQRzEayz/lFKHXmnmBsbN9oY
	 vBk+cEyb9pBLsF0Xb/b1xqFaBxd7DKUU6OliEGHBh/3/QDhvC+6bIM6D+g/HVYhQj5
	 OrjI1ELyOM55Ae6nRil9vsqzyKadrrILO7NBIxdQ7I8jbMO/BXkw/NtV7PYyZURD7C
	 O0+Ayal7iWjcGCGaUh4E7eT9nI3QKSmi01mVSnLjyroHA2BmPnO8t7F0GrDiruuWB/
	 3YPPj4eD6/3+IlUv+vhidowQmsknNyBb8midDZ42hjRSXVcK++FKOAfVp0F5s4oFSx
	 fKIzYJd8PLzwg==
Message-ID: <c9120afa-7054-4e76-9727-1cac3f027a90@kernel.org>
Date: Thu, 2 Oct 2025 12:38:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] selftests: net: sort configs
Content-Language: en-GB, fr-BE
To: Phil Sutter <phil@nwl.cc>, Jakub Kicinski <kuba@kernel.org>
References: <20251002015245.3209033-1-kuba@kernel.org>
 <aN5PYtHSdp4XIWtO@orbyte.nwl.cc>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jv@jvosburgh.net, shuah@kernel.org, kuniyu@google.com, martineau@kernel.org,
 geliang@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
 antonio@openvpn.net, sd@queasysnail.net, razor@blackwall.org,
 idosch@nvidia.com, yongwang@nvidia.com, jiri@resnulli.us,
 danishanwar@ti.com, linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <aN5PYtHSdp4XIWtO@orbyte.nwl.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Phil, Jakub,

On 02/10/2025 12:09, Phil Sutter wrote:
> Hi,
> 
> On Wed, Oct 01, 2025 at 06:52:45PM -0700, Jakub Kicinski wrote:
>> Sort config files for networking selftests. This should help us
>> avoid merge conflicts between net and net-next. patchwork check
>> will be added to prevent new issues.
> 
> The patch does not apply to my net/main (at daa26ea63c6) for unclear
> reasons,

Same for me, but I can apply it on top of net-next.

> though I verified that it does neither add nor remove lines by:
> 
> diff -u \
>   <(sed -n 's/^-\(CONFIG_.*\)/\1/p' /tmp/sort.patch | sort) \
>   <(sed -n 's/^+\(CONFIG_.*\)/\1/p' /tmp/sort.patch | sort)

Thanks for having checked this!

>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Acked-by: Phil Sutter <phil@nwl.cc>

Thank you for having sorted these files to reduce future conflicts
between net and net-next! (Hopefully this will not cause too much
troubles when backporting some patches to stable versions, but I guess
this should be rare here with these config files.)

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


