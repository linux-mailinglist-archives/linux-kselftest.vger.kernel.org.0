Return-Path: <linux-kselftest+bounces-11906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D7F908107
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 03:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA59C1F22622
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 01:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE631822ED;
	Fri, 14 Jun 2024 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZuRyDC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E420157A43;
	Fri, 14 Jun 2024 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329780; cv=none; b=LvaJYSEYCvzl8uhdyDsnchsZNYoZ6uwNkk2XL70/Y6P5woPwz1/hx4RdcdN0Bausy/ZvSzqDF/3jTlPadpk+YYB9CazKVO6ostrQgs5acZd6A9u4dHLcD7cpGryRXwnaz5obnSZKPzvG7UpJNWEbeh0n0+bLLzKkVQuKzsnY6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329780; c=relaxed/simple;
	bh=wF21a3UbyHjTYi79R6tU+R0QlOd02VCTZTRWQtWvJA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkh759iw0+yeFEnxW0FZ/DLnWtt7ZDPEompLfD2qpOPjec95BAI+vZiGNOzSPGCOw5iXjsLgf1+I35UVz4drN1JzESrTpnm//5k7OQA47DvfueIvFrzCTSqRx+YM/Ad5dsCN6R2UKynAWvSAI44N7mkUCyROjT0QwuSc5bKGdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZuRyDC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7803EC2BBFC;
	Fri, 14 Jun 2024 01:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718329780;
	bh=wF21a3UbyHjTYi79R6tU+R0QlOd02VCTZTRWQtWvJA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pZuRyDC4P9T+WD15psdYAt86/T2Uw9ftn8QYqxeCyxoVzI0SzQAWqg0nSvqePTT8q
	 S47JPXjOHH9P7wlbw/or3iVnsK/97Xj7pxX/OQigs2eSjY6g0uBD/e86k20hokoJIs
	 O4ZV+cra2FY2IvVOPubNh40VEg8wh4tXKpetQN6nzKf8tHwWDeZoQl/aztnC8G2EYP
	 MWrFw1rIHX7j6i6Hyn+BkKeMBI+5QVh0FHfSk+qGEWWAvne0MR3ox3TWMw4/q35tW3
	 0xcEBA7Ftfu/Nx+HuqnwEpy7Dd6pjxS1SpL8ke87gudyw9LwDISWJ8XCIxg+tk3QKj
	 Btm8dmHcw3zlw==
Date: Thu, 13 Jun 2024 18:49:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v2] sefltests: net: Add on/off checks for network
 interface non fixed features
Message-ID: <20240613184938.0cc8cc56@kernel.org>
In-Reply-To: <20240609132124.51683-1-jain.abhinav177@gmail.com>
References: <20240609132124.51683-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Jun 2024 13:21:24 +0000 Abhinav Jain wrote:
> This patch addresses the TODO (add non fixed feature on/off check).
> I have tested it manually on my system and made changes as suggested in v1

>  	echo "PASS: $netdev: ethtool list features"
> -	#TODO for each non fixed features, try to turn them on/off
> +
> +	while read -r FEATURE VALUE FIXED; do
> +		[ "$FEATURE" != "Features" ] || continue # Skip "Features" line
> +		[ "$FIXED" != "[fixed]" ] || continue # Skip fixed features
> +		feature = "${FEATURE%:*}"
> +
> +		ethtool --offload "$netdev" "$feature" off
> +		if [ $? -eq 0 ]; then
> +			echo "PASS: $netdev: Turned off feature: $feature"
> +		else
> +			echo "FAIL: $netdev: Failed to turn off feature: $feature"
> +		fi
> +
> +		ethtool --offload "$netdev" "$feature" on

You do off then on, so you assume the feature was on to begin with.
Not all features will be on. You gotta change the order based on
the initial state so that the feature goes back to what it was.

> +		if [ $? -eq 0 ]; then
> +			echo "PASS: $netdev: Turned on feature: $feature"
> +		else
> +			echo "FAIL: $netdev: Failed to turn on feature: $feature"
> +		fi
> +	done < "$TMP_ETHTOOL_FEATURES"

More importantly, tho, currently in our CI this test passes:

https://netdev.bots.linux.dev/contest.html?test=netdevice-sh

But it doesn't do anything:

https://netdev-3.bots.linux.dev/vmksft-net/results/638724/98-netdevice-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/638544/90-netdevice-sh/stdout

Because I'm guessing the VM does not have any interface to test.

Before we extend the test could you please make the test automatically
add a veth or netdevsim device if there is no testable device on the
system? Make sure you remove it before exiting.

You can look at tests in tools/testing/selftests/drivers/net/netdevsim
for inspiration and library scripts which can be reused.

