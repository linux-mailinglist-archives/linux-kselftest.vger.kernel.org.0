Return-Path: <linux-kselftest+bounces-46808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABE5C97D1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 15:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A037F3A3653
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CBC31578E;
	Mon,  1 Dec 2025 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF6nRt7Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC1311C05;
	Mon,  1 Dec 2025 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598785; cv=none; b=fNHKD1Nsud2RrSK/VUp5MQL3L5pbhvpg5cPdqkCzug0H2LKYxHUciLl4ztLD23UFBHahXUbiGMAV1SWMNtBBmfh2Ljiixmkeym8RF37Ix+0vMUhRhuk/ephgOV8qiO/OgCQluiFtEUu32/Glyr+VaB5BiKCKqNF2AHNNpAIfRHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598785; c=relaxed/simple;
	bh=CdVnOG+TPZOo7rgy6OxDnhs0rc15k6LGBWxJ00eufvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9aFwgivvHWE8Lh8b97pNeX47x8zZtpitzzA4A07TlcG7Wr/LcwEJOHth11h26qR4cgb0fatyVJwZ7z64Keei6VpgauPO9HlbyDNSp8BIUBo8y1/SrLS6tSHaaZq2VQfCrOUihWp7y6XoQAS6LxY8qVSUCuipWh04/sQzNQ3lnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF6nRt7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94300C4CEF1;
	Mon,  1 Dec 2025 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764598785;
	bh=CdVnOG+TPZOo7rgy6OxDnhs0rc15k6LGBWxJ00eufvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SF6nRt7QQZgjpVcUpwjW6vRPhHFLS1Xttv9RzecDetxlSOXMf8Cm6mmqKbN5xKtSq
	 pqsb0SVKFKnC9UTiyn4gHoReIsBByKowUs6wK6BXjMbMWPFjdb5Ws/X1eos9HRS0Hj
	 00qWYMIRiE/B62TE+OTfKS/NI6ZYLSTszhdps0hQb1quZmzdf//oJ9dSLLwMBAjM+4
	 Cxp7Yju9LuiduTsCwii2BoHjQnGxnhooRmRlZaqOqcsJ3wh+CZkjjMAVUj5OWdvfSn
	 QDyQuriQRxcl0FYGYmg14CInkWkthUBDvrHkfIbcPjcufqhacxRMQSXN4LyAzFftXB
	 wYs/3tP4pO+BA==
Date: Mon, 1 Dec 2025 14:19:40 +0000
From: Simon Horman <horms@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC/RFT net-next v2 3/5] selftests: no_forwarding: test
 VLAN uppers on VLAN aware bridged ports
Message-ID: <aS2j_BsYHJ3MT41o@horms.kernel.org>
References: <20251201102817.301552-1-jonas.gorski@gmail.com>
 <20251201102817.301552-4-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201102817.301552-4-jonas.gorski@gmail.com>

On Mon, Dec 01, 2025 at 11:28:15AM +0100, Jonas Gorski wrote:
> Add a test (mainly for switchdev implementors) to test that multiple
> VLAN uppers on a VLAN aware bridge for the same VLAN do not enable
> forwarding of that VLAN between those ports.
> 
> Since we are testing VLAN uppers, skip checking untagged traffic in
> those cases.
> 
> Disallowing VLAN uppers on bridge ports is a valid choice for switchdev
> drivers, so test if we can create them first and skip the tests if not.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
> v1 -> v2:
> * new patch
> 
>  .../selftests/net/forwarding/no_forwarding.sh | 89 ++++++++++++++-----
>  1 file changed, 67 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
> index 694ece9ba3a7..c8adf04e1328 100755
> --- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
> +++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
> @@ -1,7 +1,7 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> -ALL_TESTS="standalone two_bridges one_bridge_two_pvids"
> +ALL_TESTS="standalone two_bridges one_bridge_two_pvids bridge_aware_vlan_uppers"
>  NUM_NETIFS=4
>  
>  source lib.sh
> @@ -90,6 +90,7 @@ check_rcv()
>  run_test()
>  {
>  	local test_name="$1"
> +	local swp_uppers=${2:0}

Hi Jonas,

Should this be as follows?

	local swp_uppers=${2:-0}


I.e. default to 0 if $2 is not set,
     rather than take a substring of $2 at index 0 (which is all of $2)

Flagged by Claude Code with review-prompts.

https://netdev-ai.bots.linux.dev/ai-review.html?id=3d47057e-e740-4b66-9d60-9ec2a7ee92a1#patch-2


>  	local smac=$(mac_get $h1)
>  	local dmac=$(mac_get $h2)
>  	local h1_ipv6_lladdr=$(ipv6_lladdr_get $h1)

...

> +bridge_aware_vlan_uppers()
> +{

...

> +	run_test "Switch ports in VLAN-aware bridge with VLAN uppers" 2
> +
> +	ip link del br0
> +}
> +

...

