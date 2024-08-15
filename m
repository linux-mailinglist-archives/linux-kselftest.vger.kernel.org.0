Return-Path: <linux-kselftest+bounces-15404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51826952EBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 15:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC818281BD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 13:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FCF19DFBB;
	Thu, 15 Aug 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNBLvtY+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02819DFA6;
	Thu, 15 Aug 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727038; cv=none; b=aHXwgbATypQnwLiq9MkqRsYa1Ad55M3sj83VU0ynABy8qM1u5zcXkiwysZiI7KNq+fw+INwCcKrI4ZSsuwFxzt5QpdkENOoinHW1r4f21aKLj+iQZ3523BsHUBWhm/R9+CBY2C/RmtWlgg42/de/vjLgyFbmITgc2JXBxodzgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727038; c=relaxed/simple;
	bh=yEDFxqo+NF6WMAkJcoYLgmvXG6sQYuYfVp3i9QXS9HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh6/627i3adSr5MUXQC0MEdLUdk5GidTjpP1RApVfDLb7rF8wargv8Uv5JhrQpgfjNGWn31THg3x4JJ2zV1R+WiACEH5pX7l7jEGwXspU7lH0xdaCt3IVXSb1DYhBDosvFtBPg7m9WxvYE6dYPOZq6JM8+u5lE5YSqx+lsJequ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNBLvtY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF954C4AF0A;
	Thu, 15 Aug 2024 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723727038;
	bh=yEDFxqo+NF6WMAkJcoYLgmvXG6sQYuYfVp3i9QXS9HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNBLvtY+ikrUFRzMe3U4cW60OaAz3dOt8PXL4Ky9gIPEdF1A3fRxzCSZpfOmFbSQM
	 CmlYJV9PvA6uEyQsRSEANhAVdvNjh7nkBFNe7nekXxAT/IzOAPjqaMl/HPDQKXCrDi
	 x4/fOhCzzqVE8dpasb29v7ybfsywum6vTUqcWCK3IYlr5nPLLKIWZb1zkt/OdWDGII
	 aUvLdcIj3zTXF+nLgwxo7XyVZcdJZCcir44gJLe0HvcNV6wD4ZAnSevgfZhpTrLdyJ
	 ADfSZ0qkPoQ6SdOTyO1v3heW8imXWw5DAYv8tLwZjKsRFSMLa2Vk/UYfgpqGuBwiVW
	 nXDnrXLKV3I4w==
Date: Thu, 15 Aug 2024 14:03:53 +0100
From: Simon Horman <horms@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v7 net-next 2/3] selftests: net: Add on/off checks for
 non-fixed features of interface
Message-ID: <20240815130353.GB632411@kernel.org>
References: <20240815105924.1389290-1-jain.abhinav177@gmail.com>
 <20240815105924.1389290-3-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815105924.1389290-3-jain.abhinav177@gmail.com>

On Thu, Aug 15, 2024 at 04:29:23PM +0530, Abhinav Jain wrote:
> Implement on/off testing for all non-fixed features via while loop.
> Save the initial state so that it can be restored after on/off checks.
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  tools/testing/selftests/net/netdevice.sh | 37 +++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
> index 0c32950fdd17..50f7b9d1163d 100755
> --- a/tools/testing/selftests/net/netdevice.sh
> +++ b/tools/testing/selftests/net/netdevice.sh
> @@ -124,7 +124,42 @@ kci_netdev_ethtool()
>  		return 1
>  	fi
>  	echo "PASS: $netdev: ethtool list features"
> -	#TODO for each non fixed features, try to turn them on/off
> +
> +	while read -r FEATURE VALUE FIXED; do
> +		[ "$FEATURE" != "Features" ] || continue # Skip "Features"
> +		[ "$FIXED" != "[fixed]" ] || continue # Skip fixed features
> +		feature="${FEATURE%:*}"
> +
> +		initial_state=$(ethtool -k "$netdev" | grep "$feature:" \
> +			| awk '{print $2}')

Hi Abhinav,

Isn't the value being read into $initial_state here already present in $VALUE?

> +		ethtool --offload "$netdev" "$feature" off
> +		if [ $? -eq 0 ]; then
> +			echo "PASS: $netdev: Turned off feature: $feature"
> +		else
> +			echo "FAIL: $netdev: Failed to turn off feature:" \
> +				"$feature"
> +		fi
> +
> +		ethtool --offload "$netdev" "$feature" on
> +		if [ $? -eq 0 ]; then
> +			echo "PASS: $netdev: Turned on feature: $feature"
> +		else
> +			echo "FAIL: $netdev: Failed to turn on feature:" \
> +				"$feature"
> +		fi
> +
> +		#restore the feature to its initial state
> +		ethtool --offload "$netdev" "$feature" "$initial_state"
> +		if [ $? -eq 0 ]; then
> +			echo "PASS: $netdev: Restore feature $feature" \
> +				"to initial state $initial_state"
> +		else
> +			echo "FAIL: $netdev: Failed to restore feature" \
> +				"$feature to default $initial_state"
> +		fi
> +
> +	done < "$TMP_ETHTOOL_FEATURES"
> +
>  	rm "$TMP_ETHTOOL_FEATURES"
>  
>  	kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
> -- 
> 2.34.1
> 
> 

