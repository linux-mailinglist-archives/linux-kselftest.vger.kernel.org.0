Return-Path: <linux-kselftest+bounces-22467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 316F29D6AE2
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 19:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41880161CF9
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387CF1836D9;
	Sat, 23 Nov 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCnO7BfO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705315FA7B;
	Sat, 23 Nov 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732387803; cv=none; b=HEiEv5HPdg7lLQ7+fwhpaEjbwCpnAqAd7LVNkG/c1hyuCesW2ArNVuh+YrEYwOfLDmkTH4jaNqueaCTI3gh5VKDxS/Zhpe3OKw99XsbZF1mXRQVOgZqCM4881pUUMO7q//X1tvlJ0PAK8Jy1rp61DRXtq43FBC4i+vzfyWqPkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732387803; c=relaxed/simple;
	bh=OwhwR+n+yhgT9lloxjV/vUMqUoACXZpfDDTeiITjGqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3wKH089VnIDGRcj8ZWJp1RNB2E8TllcNy/8drWcLMpvY1SLtHxSAuAd/fOlfD4YWQTXymTEU2oSb/jl1L/F2ByFVnCAhhGcpFCnTTeHGKb+WMgEKshionsZCfot/Hh28epUAUYfIlcalp4ScGZTOcDZ8RTKrJkkKNLxzv0svXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCnO7BfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6699FC4CECD;
	Sat, 23 Nov 2024 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732387802;
	bh=OwhwR+n+yhgT9lloxjV/vUMqUoACXZpfDDTeiITjGqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kCnO7BfO7wy2UoN198SlajcIXlkk/+Fg8/gtebAm+mNTtnGCj0KYEQkK0JzTfwn05
	 7eVatv1PH6AuSG/yio5WxdDbe5Z6cdI04Pg5td5y5fpuTVjUFqKn4pdHPuCbyIvXau
	 BxjteX/jJh3ZhkV7c8vvlRKHGw7jno2xW6iuzXsQ6zgJ+TeDnk0P0x4h1da1PnXCt8
	 gZ88eh73x8A/hXMItvqs7ntnTZFvXMAK1+x06ZRZ45XCYYmD9Z8TWljyCo19a7pwyd
	 h64Cg1bXJegjanS/qB8TWhXCS8tKh9mCCzey7pg1JdOSTlSYUgXQ8GmTPAN7ZEzLYU
	 vF8auJMpkMcQg==
Message-ID: <085799a3-8904-46c7-b4e2-3ea4210486a9@kernel.org>
Date: Sat, 23 Nov 2024 11:50:01 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 1/2] net/ipv6: delete temporary address if
 mngtmpaddr is removed or unmanaged
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sam Edwards <cfsworks@gmail.com>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Alex Henrie <alexhenrie24@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241120095108.199779-1-liuhangbin@gmail.com>
 <20241120095108.199779-2-liuhangbin@gmail.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241120095108.199779-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/20/24 2:51 AM, Hangbin Liu wrote:
> RFC8981 section 3.4 says that existing temporary addresses must have their
> lifetimes adjusted so that no temporary addresses should ever remain "valid"
> or "preferred" longer than the incoming SLAAC Prefix Information. This would
> strongly imply in Linux's case that if the "mngtmpaddr" address is deleted or
> un-flagged as such, its corresponding temporary addresses must be cleared out
> right away.
> 
> But now the temporary address is renewed even after ‘mngtmpaddr’ is removed
> or becomes unmanaged as manage_tempaddrs() set temporary addresses
> prefered/valid time to 0, and later in addrconf_verify_rtnl() all checkings
> failed to remove the addresses. Fix this by deleting the temporary address
> directly for these situations.
> 
> Fixes: 778964f2fdf0 ("ipv6/addrconf: fix timing bug in tempaddr regen")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/ipv6/addrconf.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



