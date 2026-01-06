Return-Path: <linux-kselftest+bounces-48335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3830CF9E8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 19:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D640C32673D5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E22033FE2A;
	Tue,  6 Jan 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDzuaGP3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517833DED6;
	Tue,  6 Jan 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721046; cv=none; b=NGhc24VxspF7giuQJmH2YbMBVGaW35TgnSIQsMOiT8BP117bpNeJYdbVCgnF3YAcMqy/e61OYm422xYWU/44rCYLfuHohmGuMr7VreZJpqfx5KEZnsQw3LlZdAhJMt1NL0PdTN2tkCCQnU1Azw6IsPenzpaYeEOEhHYOqYbs/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721046; c=relaxed/simple;
	bh=6L1NGsoqeyNV1FiPbWbfXPTcb2cf8tJ1SfoR7IzsV6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoYiv0jnDBq4Q/XGk2crBdTZCUXV5Ws9A8kxD9xlbVPud6Rm1y4ltVlnfNTnpkwT0Cm0TSL6rkQsthrUww4NEIF4sb3GfgKqEcif7cQ5n3R26gzAR5nM8jnjWThNDk42J7fNf9qBE0UWTG6UIHSyKXpXLs/EYZlI7BPQcFsfabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDzuaGP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FEAC16AAE;
	Tue,  6 Jan 2026 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767721046;
	bh=6L1NGsoqeyNV1FiPbWbfXPTcb2cf8tJ1SfoR7IzsV6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kDzuaGP3f9OKEHCj1fXaVYTpGBXzJ/o5RavSNkBEGzB3Eanl9GUe2vyRVRbdQgzf0
	 y6cd4pjA9XFkDPvduSabuPMrSP4gVkXDg9zjQXi7twPEWTmam+SS4oRaqNI/zINmgf
	 obfj5gl+EiLbMymgGAMeGnZzSn9hwW+jTCNluyEAw9MUVF0Qjvu++DSd64OTHoq5to
	 YoSkOLFUeYfJYeIAFIfKbCiC/OON2/FXK4wcZ8vf2z7ha69J72Z+bnGyFg+IXo8yA3
	 P+QP8ddJYl6k1r+PWgEOafjCmFsAJ4Lez9T35OL65ACvzMkPYWUNsK4N4BAhXZdtAU
	 76J3ASueB25rQ==
Message-ID: <08eb450b-e644-4968-b83e-54364c449a5b@kernel.org>
Date: Tue, 6 Jan 2026 10:37:25 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ipv6: preserve insertion order for same-scope
 addresses
Content-Language: en-US
To: Yumei Huang <yuhuang@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: sbrivio@redhat.com, david@gibson.dropbear.id.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 justin.iurman@uliege.be, shuah@kernel.org
References: <20260104032357.38555-1-yuhuang@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260104032357.38555-1-yuhuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/26 8:23 PM, Yumei Huang wrote:
> IPv6 addresses with the same scope are returned in reverse insertion
> order, unlike IPv4. For example, when adding a -> b -> c, the list is
> reported as c -> b -> a, while IPv4 preserves the original order.
> 
> This behavior causes:
> 
> a. When using `ip -6 a save` and `ip -6 a restore`, addresses are restored
>    in the opposite order from which they were saved. See example below
>    showing addresses added as 1::1, 1::2, 1::3 but displayed and saved
>    in reverse order.
> 
>    # ip -6 a a 1::1 dev x
>    # ip -6 a a 1::2 dev x
>    # ip -6 a a 1::3 dev x
>    # ip -6 a s dev x
>    2: x: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
>        inet6 1::3/128 scope global tentative
>        valid_lft forever preferred_lft forever
>        inet6 1::2/128 scope global tentative
>        valid_lft forever preferred_lft forever
>        inet6 1::1/128 scope global tentative
>        valid_lft forever preferred_lft forever
>    # ip -6 a save > dump
>    # ip -6 a d 1::1 dev x
>    # ip -6 a d 1::2 dev x
>    # ip -6 a d 1::3 dev x
>    # ip a d ::1 dev lo
>    # ip a restore < dump
>    # ip -6 a s dev x
>    2: x: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
>        inet6 1::1/128 scope global tentative
>        valid_lft forever preferred_lft forever
>        inet6 1::2/128 scope global tentative
>        valid_lft forever preferred_lft forever
>        inet6 1::3/128 scope global tentative
>        valid_lft forever preferred_lft forever
>    # ip a showdump < dump
>     if1:
>         inet6 ::1/128 scope host proto kernel_lo
>         valid_lft forever preferred_lft forever
>     if2:
>         inet6 1::3/128 scope global tentative
>         valid_lft forever preferred_lft forever
>     if2:
>         inet6 1::2/128 scope global tentative
>         valid_lft forever preferred_lft forever
>     if2:
>         inet6 1::1/128 scope global tentative
>         valid_lft forever preferred_lft forever
> 
> b. Addresses in pasta to appear in reversed order compared to host
>    addresses.
> 
> The ipv6 addresses were added in reverse order by commit e55ffac60117
> ("[IPV6]: order addresses by scope"), then it was changed by commit
> 502a2ffd7376 ("ipv6: convert idev_list to list macros"), and restored by
> commit b54c9b98bbfb ("ipv6: Preserve pervious behavior in
> ipv6_link_dev_addr()."). However, this reverse ordering within the same
> scope causes inconsistency with IPv4 and the issues described above.
> 
> This patch aligns IPv6 address ordering with IPv4 for consistency
> by changing the comparison from >= to > when inserting addresses
> into the address list. Also updates the ioam6 selftest to reflect
> the new address ordering behavior. Combine these two changes into
> one patch for bisectability.
> 
> Fixes: e55ffac60117 ("[IPV6]: order addresses by scope")
> Link: https://bugs.passt.top/show_bug.cgi?id=175
> Suggested-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Yumei Huang <yuhuang@redhat.com>
> ---
>  net/ipv6/addrconf.c                  | 2 +-
>  tools/testing/selftests/net/ioam6.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
>

I am ok with the change, but I will not be surprised if someone
complains about a change in behavior.

Reviewed-by: David Ahern <dsahern@kernel.org>


