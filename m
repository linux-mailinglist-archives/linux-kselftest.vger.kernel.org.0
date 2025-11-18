Return-Path: <linux-kselftest+bounces-45845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB09C683B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 09:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7A4142A3F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081CA30F527;
	Tue, 18 Nov 2025 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poVeSJCZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA630B509;
	Tue, 18 Nov 2025 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455189; cv=none; b=qu3PlQf31rVDoYgF90G8vpL3fBOnQxnx03xbRYTCasEsT3UhI2uWMd/Ix2ilJl9KxJ+d2Q5KY19LnA+qT1uvp8bwStiEYTCO5WqVVyqbJOwuRP9caPqL3D9ERa8bOaOTdczYPZsk1c4mbxdJYR/rWU1yJrmqOPkM7xd39n8aC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455189; c=relaxed/simple;
	bh=UsiEEBm0oAP3CAsvZ2e+fKZt4abKErsjxcqdQzrr0nM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JkyyzW8s3tPuuECPJzrponnbqfDYN8H4Vb0kUYSkpSr15iNOiMwCvlYkDCGCBNnbLSQx1nB/AQ65rquyFeTD/W9U1JE8eTwH39Qx/WV21l/1AIKGD5uBCbxUgJCZ9hcNUgOWpvEt3ixQayPKPjpVNUJ5bW5TgU8mQXCLZuWlqSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poVeSJCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADE8C16AAE;
	Tue, 18 Nov 2025 08:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763455188;
	bh=UsiEEBm0oAP3CAsvZ2e+fKZt4abKErsjxcqdQzrr0nM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=poVeSJCZpdSDb9G5CgnJhU1G1lRfdeSWOLnP12zGil/haYT7uUnWqId8RomUSyJ6C
	 nlKJA86Trgflg11VjnAmPYYbHpO7lE/QE2pd1U1R3CIaoW+aTxoXEK1CdvyV7kxCL4
	 RmwidWVTGnnKfnvb1JXn+f+wBb2tR9Wxpt0W6tZpBty5lSpGb1sxAxAlwL1LbjhiQ8
	 aaAbszSnziNERMOUZcQi9qg9vWOx+NAPAfvFxPSCpQyXePyjoXcmitxd4XV1UetDMz
	 +cpbeOsCMVNf88VrDhSFNf28K5J8acsBu23gpPozXU9u6HwYVIWEn/Wtl81uiNxAQO
	 BRRVSUYiWvllw==
Message-ID: <236d10dc597fbf5bf58c64190f7c34347f07dccc.camel@kernel.org>
Subject: Re: [PATCH net 08/11] selftests: mptcp: join: endpoints: longer
 timeout
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau	
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan	
 <shuah@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 18 Nov 2025 16:39:40 +0800
In-Reply-To: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-8-806d3781c95f@kernel.org>
References: 
	<20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
	 <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-8-806d3781c95f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-11-18 at 08:20 +0100, Matthieu Baerts (NGI0) wrote:
> In rare cases, when the test environment is very slow, some endpoints
> tests can fail because some expected events have not been seen.
> 
> Because the tests are expecting a long on-going connection, and they
> are
> not waiting for the end of the transfer, it is fine to have a longer
> timeout, and even go over the default one. This connection will be
> killed at the end, after the verifications: increasing the timeout
> doesn't change anything, apart from avoiding it to end before the end
> of
> the verifications.
> 
> To play it safe, all endpoints tests not waiting for the end of the
> transfer are now having a longer timeout: 2 minutes.
> 
> The Fixes commit was making the connection longer, but still, the
> default timeout would have stopped it after 1 minute, which might not
> be
> enough in very slow environments.
> 
> Fixes: 6457595db987 ("selftests: mptcp: join: endpoints: longer
> transfer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This patch looks good to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 303abbca59fc..93d38ded5e4e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3941,7 +3941,7 @@ endpoint_tests()
>  		pm_nl_set_limits $ns1 2 2
>  		pm_nl_set_limits $ns2 2 2
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -		{ test_linkfail=128 speed=slow \
> +		{ timeout_test=120 test_linkfail=128 speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  
> @@ -3968,7 +3968,7 @@ endpoint_tests()
>  		pm_nl_set_limits $ns2 0 3
>  		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1
> flags subflow
>  		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2
> flags subflow
> -		{ test_linkfail=128 speed=5 \
> +		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  
> @@ -4046,7 +4046,7 @@ endpoint_tests()
>  		# broadcast IP: no packet for this address will be
> received on ns1
>  		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
>  		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
> -		{ test_linkfail=128 speed=5 \
> +		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  
> @@ -4119,7 +4119,7 @@ endpoint_tests()
>  		# broadcast IP: no packet for this address will be
> received on ns1
>  		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
>  		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
> -		{ test_linkfail=128 speed=20 \
> +		{ timeout_test=120 test_linkfail=128 speed=20 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  

