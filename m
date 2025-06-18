Return-Path: <linux-kselftest+bounces-35320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F154EADF5B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 20:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE10176C00
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 18:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFA62F49FD;
	Wed, 18 Jun 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYNieJI0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA12F3C37;
	Wed, 18 Jun 2025 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270833; cv=none; b=XmZRPnK7RV4HlVWYNzxzBqJ8CLdfMPDigtOJA/AIDfkOMx/WNM+NumqmIMrMD3KZLAgc89N/kBaIr8qPe4Nn5Ez18lmZ9mXq7HDiEA+azCD5bvbxR/C2ov6IDV0C9edVdm1WqhNPs69dh1lDFsqUmW+EMX4+g1dqxNrwjqxhTgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270833; c=relaxed/simple;
	bh=MquSU51CJRO5h2hv2a+qZzy/C8JEK1lqvy35Ue6Ln+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7WxtBXu/a6M+cpdInRuBUfMsvU8/lpueixCls4ICzVaSMM0E0HiVFzBWxYtMl2YY0SiMce4sOwSvsUHyNWohR0wv7O8H+r5esu+W6n6uNi43DezKGMQJAHKHGdvoBg/4Drx77xPjEHIYc3w2zXfklpef252ttxH2eswrTqgC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYNieJI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C38C4CEE7;
	Wed, 18 Jun 2025 18:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750270833;
	bh=MquSU51CJRO5h2hv2a+qZzy/C8JEK1lqvy35Ue6Ln+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYNieJI0togvx7EzqHXIVxVkFPVSKw89FVbRpaEDvwh5zGdHtGd/0K/R+WMcv4Oj0
	 2RUSbFes4ifB7vgV3o/6ZcE8yUeYWX4sAe9ptEQDd4lr3fhs4cvNz6PKx/sPrkDByV
	 eBVgQNAUxecWI1eiMzN/db3UkMEi0slLrvpAIUOmdqoTzkyeCR3ngtS3UcYo9+3sPY
	 zeiPvIQg2D5anT0iF0q6DB+M++1z2n7fmSVgN8Rf8wJRXNWa9q4+vo7LHhDAkbBGru
	 vkWclCoNsK6vTG4Ns+M0ol0B8Fh0H+doZq/kwQr62d1sVr4zlTC0J6oz+Li2bSldgq
	 //Mbhnfi89MEg==
Date: Wed, 18 Jun 2025 19:20:29 +0100
From: Simon Horman <horms@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftest: add selftest for anycast notifications
Message-ID: <20250618182029.GV1699@horms.kernel.org>
References: <20250618104025.3463656-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618104025.3463656-1-yuyanghuang@google.com>

On Wed, Jun 18, 2025 at 07:40:25PM +0900, Yuyang Huang wrote:
> This commit adds a new kernel selftest to verify RTNLGRP_IPV6_ACADDR
> notifications. The test works by adding/removing a dummy interface,
> enabling packet forwarding, and then confirming that user space can
> correctly receive anycast notifications.
> 
> The test relies on the iproute2 version to be 6.13+.
> 
> Tested by the following command:
> $ vng -v --user root --cpus 16 -- \
> make -C tools/testing/selftests TARGETS=net
> TEST_PROGS=rtnetlink_notification.sh \
> TEST_GEN_PROGS="" run_tests
> 
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---
>  .../selftests/net/rtnetlink_notification.sh   | 52 +++++++++++++++++--
>  1 file changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink_notification.sh b/tools/testing/selftests/net/rtnetlink_notification.sh

...

> @@ -18,12 +20,11 @@ kci_test_mcast_addr_notification()
>  	local tmpfile
>  	local monitor_pid
>  	local match_result
> -	local test_dev="test-dummy1"
>  
>  	tmpfile=$(mktemp)
>  	defer rm "$tmpfile"
>  
> -	ip monitor maddr > $tmpfile &
> +	ip monitor maddr > "$tmpfile" &
>  	monitor_pid=$!
>  	defer kill_process "$monitor_pid"
>  
> @@ -32,7 +33,7 @@ kci_test_mcast_addr_notification()
>  	if [ ! -e "/proc/$monitor_pid" ]; then
>  		RET=$ksft_skip
>  		log_test "mcast addr notification: iproute2 too old"
> -		return $RET
> +		return "$RET"
>  	fi
>  
>  	ip link add name "$test_dev" type dummy

> @@ -53,7 +54,48 @@ kci_test_mcast_addr_notification()
>  		RET=$ksft_fail
>  	fi
>  	log_test "mcast addr notification: Expected 4 matches, got $match_result"
> -	return $RET
> +	return "$RET"
> +}

...

> @@ -67,4 +109,4 @@ require_command ip
>  
>  tests_run
>  
> -exit $EXIT_STATUS
> +exit "$EXIT_STATUS"

Hi,

While I like the changes above (that I haven't trimmed-out)
these seem to be clean-ups that aren't strictly related
to the subject of this patch. IOW, they don't belong in this patch
(but could be a separate patch).

-- 
pw-bot: changes-requested

