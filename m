Return-Path: <linux-kselftest+bounces-11429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE6E900BB0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D351F234E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7333319CCFD;
	Fri,  7 Jun 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/0vXxb+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43582225AE;
	Fri,  7 Jun 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717783292; cv=none; b=DEhmQesmdS4OmkEM0Uxtv9NMAUqXblhM8NbkB8KV68PVKwB0wfCqvhaoACX9nyTl5+0rTAi6PWtMfMoVytifrfuLIC68qz2YihuW3DtARWCUIe6e1oMeYojFd+yRXfkXJXyLrZzEEXWJPEfWiuxJk9maD+TFjpMT8ss3hyvH8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717783292; c=relaxed/simple;
	bh=Q2240HndQG7pznYsjZBV4QwZL2FAj/M/TuJieHCfvUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tceBFnXixIYwLyhWL8dt0q11HK3NchqjtvpOjUg86FMLfBN6USDGEBIXpFK+UhdezFas2Svfd2RC82mhAXtPGrDPZaq6E0Cq9z+0tmOuJCRITJlexD2ate1EOcf4td2PvQUIYuIqgcO59hVZ7U0wk7oV/dePOsZTkW2Or/k8bro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/0vXxb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD14CC32781;
	Fri,  7 Jun 2024 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717783291;
	bh=Q2240HndQG7pznYsjZBV4QwZL2FAj/M/TuJieHCfvUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/0vXxb+M4XcEfHxBu3m2ci+zkFX2M5+X6/atldRHqARKOdNrYNSkhGSDwpINX+t9
	 tjqPBTMc1yHosbqcrP/HWutJavOJynDoUWo0fENnC6gefZ2iD51v4AmIXqReO8T6U5
	 BfD0VNR075n8mehObEVAkwxTaaD4S9ydHMuMPlO1x3qkWA6pMlCFhVdK7IMM/MXnCf
	 z6qzlWBayW7xInxMU98i5fjbZHP8uSfNfqsk8loJioNToUD8rOIlaDuPutJ1vKJw1S
	 r8VgGaGJ/4AKTAhkwzA2fpiaQpl0adJqyJHdxO3Y/A0iMOdbypObREJJN8mD4Uh2wu
	 mzb/waktMHUGg==
Date: Fri, 7 Jun 2024 19:01:27 +0100
From: Simon Horman <horms@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] selftests: net: Add on/off checks for network interface
 non fixed features
Message-ID: <20240607180127.GG27689@kernel.org>
References: <20240606212714.27472-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606212714.27472-1-jain.abhinav177@gmail.com>

On Thu, Jun 06, 2024 at 09:27:14PM +0000, Abhinav Jain wrote:
> This patch addresses the present TODO in the file.
> I have tested it manually on my system and added relevant filtering to
> ensure that the correct feature list is being checked.
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  tools/testing/selftests/net/netdevice.sh | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
> index e3afcb424710..cbe2573c3827 100755
> --- a/tools/testing/selftests/net/netdevice.sh
> +++ b/tools/testing/selftests/net/netdevice.sh
> @@ -117,14 +117,31 @@ kci_netdev_ethtool()
>  		return 1
>  	fi
>  
> -	ethtool -k "$netdev" > "$TMP_ETHTOOL_FEATURES"
> +	ethtool -k "$netdev" | tail -n +2 > "$TMP_ETHTOOL_FEATURES"
>  	if [ $? -ne 0 ];then

Hi Abhinav,

I suspect this will now only report a failure if tail fails,
but ignore ethtool failures.

>  		echo "FAIL: $netdev: ethtool list features"
>  		rm "$TMP_ETHTOOL_FEATURES"
>  		return 1
>  	fi
>  	echo "PASS: $netdev: ethtool list features"
> -	#TODO for each non fixed features, try to turn them on/off
> +
> +	for feature in $(grep -v fixed "$TMP_ETHTOOL_FEATURES" | \
> +		awk '{print $1}' | sed 's/://'); do

Shellcheck warns that the above reads words rather than lines,
and recommends using read instead.

I think that is ok, because the construction reduces lines to single words.
But it does seem a bit awkward to call grep, awk and sed for this.

I wonder if the following construction nicer:

while read -r FEATURE VALUE FIXED; do
	[ "$FEAT" != "Features" ] || continue # Skip "Features" line
	[ "$FIXED" != "[fixed]" ] || continue # Skip fixed features
	feature="${FEATURE%:*}"
	...
done < "$TMP_ETHTOOL_FEATURES"


> +		ethtool --offload "$netdev" "$feature" off
> +		if [ $? -eq 0 ]; then
> +			echo "PASS: $netdev: Turned off feature: $feature"
> +		else
> +			echo "FAIL: $netdev: Failed to turn off feature: $feature"
> +		fi
> +
> +		ethtool --offload "$netdev" "$feature" on
> +		if [ $? -eq 0 ]; then
> +			echo "PASS: $netdev: Turned on feature: $feature"
> +		else
> +			echo "FAIL: $netdev: Failed to turn on feature: $feature"
> +		fi
> +	done
> +
>  	rm "$TMP_ETHTOOL_FEATURES"
>  
>  	kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
> -- 
> 2.34.1
> 
> 

