Return-Path: <linux-kselftest+bounces-21746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092FF9C3238
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 14:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B081F21386
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEAB1CA81;
	Sun, 10 Nov 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhmYxIYp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246515AF6;
	Sun, 10 Nov 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731246156; cv=none; b=fiGYm91QkK0RQJyxPDUYikIh+sm0B8OQXqr5DRD9zVbKmn+YXCRr3OqVyGfclWdK09Tms55wzK+typave82+5wlyEX3FWAOJh28g3E3LXCwQD2oyOb/XiRbc1TVCZzkTIwdTo6raq9ASkXP6MXUgSIpQy2eDfEoynWUPvx7vUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731246156; c=relaxed/simple;
	bh=vWh3xc9cy52fVyeE5+7/UQXjUVEjNZjJfHc25gWXRCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkSaFAEaR1hYcRoGgbqygHklbncyuGxs8xwDF4VmS3s6KYBijBxI2IRJsTyooiCEljCcOwBnpHQ7AYuY6wQHjo9NmFFw6+giACgnvSkk65f3NckbXypA0f1fUwfKSXqJbBZIP82uiKtXQCSCCIUFB13rS5PnxehMauYKtsWoF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhmYxIYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66806C4CECD;
	Sun, 10 Nov 2024 13:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731246155;
	bh=vWh3xc9cy52fVyeE5+7/UQXjUVEjNZjJfHc25gWXRCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhmYxIYpYLNDkOACqRb1jQqwJA1FOPIIT5/JHaHliGHy8mXFrJPAh6LaK+bDsMRht
	 P0lkauBuylNgpI9mVrVW9jkJr/E5djrOdSsrSLJusQIPXTJUveie0S5WClyxnq4Lcl
	 3gkf8Z1OuzVPCxIGZw6krQp6aVegtlvi32VJq3JZWbzqrYYo5or4iVOIx2T9ZcF+gB
	 4IE5zd1YxXBIqebEWWULJ3PrPNVcV4gyBvCH0w3UK4G9eS0Kwmck06WpBhpnBsJ+fw
	 oUkj6ziEiDZk6AkfV9lg+BQ/r+pcA3oDLMUzHQkWTFoR15h0SQuEdp0/hSBiHcTlp5
	 0ojdQp0zmsa8w==
Date: Sun, 10 Nov 2024 13:42:30 +0000
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] selftests: wireguard: load nf_conntrack if it's not
 present
Message-ID: <20241110134230.GR4507@kernel.org>
References: <20241107024418.3606-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107024418.3606-1-liuhangbin@gmail.com>

On Thu, Nov 07, 2024 at 02:44:18AM +0000, Hangbin Liu wrote:
> Some distros may not load nf_conntrack by default, which will cause
> subsequent nf_conntrack settings to fail. Let's load this module if it's
> not loaded by default.
> 
> Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/wireguard/netns.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
> index 405ff262ca93..508b391e8d9a 100755
> --- a/tools/testing/selftests/wireguard/netns.sh
> +++ b/tools/testing/selftests/wireguard/netns.sh
> @@ -66,6 +66,7 @@ cleanup() {
>  orig_message_cost="$(< /proc/sys/net/core/message_cost)"
>  trap cleanup EXIT
>  printf 0 > /proc/sys/net/core/message_cost
> +lsmod | grep -q nf_conntrack || modprobe nf_conntrack

Hi Hangbin,

As modprobe should be idempotent both for the case were nf_conntrack is
built-in (I'm unsure if that case can ever occur) and the module has
already been inserted, I think you simply use:

modprobe nf_conntrack

Of course, if nf_conntrack isn't available at all, then this will fail.
But that was the case with your patch too. And so I assume it is intended.

>  
>  ip netns del $netns0 2>/dev/null || true
>  ip netns del $netns1 2>/dev/null || true
> -- 
> 2.46.0
> 
> 

