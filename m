Return-Path: <linux-kselftest+bounces-11991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279EC90955A
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 03:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B4F284898
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12821396;
	Sat, 15 Jun 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So3+g9Gh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA41C2E;
	Sat, 15 Jun 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416209; cv=none; b=imqBSjnyzft1NUswN2YtjhzZrvQf/p9iSpOEz1FSCUTQ4b3M9yNbd6K9FK3YsAzkwGfYb+qPbCWUJ0Fxc6MBIetqstn1/Sh5n+g9cTTFg6dGE/nIo6hZE5lcSaGHwFr94KvpdRfDvyEDMuzM+e8qWqKtIKuTjxfHcGIa5CM5P1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416209; c=relaxed/simple;
	bh=tFlDY76kDC9E0mU7n/GrN42HtoZ9U0s1OHQi9+QON7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVcnC4HbxD7gcp/PqXpSy0nm8g+s980cBgc04MHMlL4efMwv6fpIKrWg14Mb+JbQJLqY798mldwmdyV5F0oMGkv9qBrY47I+VTABYFQfaYV5PyQmNsltq1Kbm5rF5/FJSc+nxvcp1skCRlVVAWvbG06o8F/Nrt04S0o9CUtUDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So3+g9Gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B61C2BD10;
	Sat, 15 Jun 2024 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718416209;
	bh=tFlDY76kDC9E0mU7n/GrN42HtoZ9U0s1OHQi9+QON7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=So3+g9GhfAcH0wNdoUIsjXg9thhCFqBnhxcpBoXtVCpnT1Xz1KMaL5boepAW3NnET
	 pfHecvo8JwrDdMqZgmA8vSOzEoeVAxE0XYs30NrfIwKGAehSORksghJfJdELHApP2u
	 kZENaGskhQDnpeIjd1HRcXsWEauyLpINFgp9PXw9la5dtC0DR3xHKQJ4eiA7k9dbk7
	 xMqqzaD+zsVclacDIhI7U/h0IxAlUiv3BNZwbrKxOc33g/bfXDwV+mGGvO/FfBnfAG
	 euK0TvNrb3mrEpyqwPtaTO90l9TBW28kWLVOj6QDwIZl4AuKHsY47SWEOskqmjMSaj
	 Wgfi0CTf8Fviw==
Date: Fri, 14 Jun 2024 18:50:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v3] sefltests: net: Add on/off checks for network
 interface non fixed features
Message-ID: <20240614185007.36ef425a@kernel.org>
In-Reply-To: <20240614113240.41550-1-jain.abhinav177@gmail.com>
References: <20240614113240.41550-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 11:32:40 +0000 Abhinav Jain wrote:
> This patch addresses the TODO (add non fixed feature on/off check).
> I have tested it manually on my system after making changes as suggested
> in v1 and v2 linked below for reference.
> Patch now restores the features being tested to their initial state.

Can you separate the features on/off and auto-adding veth into two
commits/patches? Then send them as a series?

> diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
> index e3afcb424710..d937d39dda6a 100755
> --- a/tools/testing/selftests/net/netdevice.sh
> +++ b/tools/testing/selftests/net/netdevice.sh
> @@ -104,6 +104,20 @@ kci_netdev_ethtool()
>  {
>  	netdev=$1
>  
> +	#check if netdev is provided as an argument
> +	if [ -z "$netdev" ]; then
> +		echo "No network device provided, creating a veth pair"
> +		ip link add veth0 type veth peer name veth1
> +		netdev="veth0"
> +		veth_created=1
> +	else
> +		#check if the provided netdev exists
> +		if ! ip link show "$netdev" > /dev/null 2>&1; then
> +			echo "Network device $netdev does not exist."
> +			return 1
> +		fi
> +	fi

I don't think this will work, since the function won't get called at
all if there is no netdev. You need to do the auto-adding around the

while read netdev

loop.

To test locally you can use network namespaces, or build and boot a
network-less kernel using vng:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

