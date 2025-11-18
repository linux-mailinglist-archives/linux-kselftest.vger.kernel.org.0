Return-Path: <linux-kselftest+bounces-45846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 649AEC683C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 09:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F8D834D25A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D72FFFAD;
	Tue, 18 Nov 2025 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COibqzuy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B4243956;
	Tue, 18 Nov 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455274; cv=none; b=MQ4TdiiBexIFWMOks//XcKPKZVCben8p/udXy26tMC1UWPPUB3KCTQ3BsqPMBSqRN2S/0avgSm4zIVMpDaLOoVM3su1pu1BWZZ56Z+jTIwm8BIOkWXjWadzLqSB77gcMmXx21DbOnagE1NzSupGgH3Jsow2+nz4SNJjMVuaNESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455274; c=relaxed/simple;
	bh=yv+nMkP3sB5ZqxMQaDS8ZhHziPUR0FgjZj2OND8BSMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mjFOAEhsjwQxjUbjL/335/cp+Io1Juc7Hq56XySu3p7IH8fTOG3pGuWzn6ARH5SsJU5UnH1tDj1e5Vdx7NqBS1u3iyfZaeUeQSLaum1SkFf4qYaXcRZuFYyWdSj8vS8GIhcyH/KHQddl19Tc+En3ITMvQgdx0hGiNlqtYmshJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COibqzuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE18C116B1;
	Tue, 18 Nov 2025 08:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763455273;
	bh=yv+nMkP3sB5ZqxMQaDS8ZhHziPUR0FgjZj2OND8BSMg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=COibqzuyy819aIgqmsF/y/N1Kt4uknIAt07D82nbdzoI1I9Rou7/nXjjfG1xdAGp+
	 gjuCxfNIyt+WK+WuXmns9ZZKJKUumXcPYEb5eL4R1Rnz1ZCD0MpKfGuC3I6QhoGPlI
	 J7t2TcfY5t2Lkl/0GNrgdkV3w5tZfMFQRRj7i1xEutijdPMqsp8XI/arFfKVB5pvYv
	 FP/JIR1bHan0/OILd4MoMSFO9EqseiOAvbSnrAzY6WS0rI6CtH47tXXSQgwiPn+Ef0
	 O4ARTztvtinvRklkCdyhvhg4MtpB+XozhbFIJUvzETp/KXpycWP4G7eTB74He0AYSE
	 uFDmPheDrWT0g==
Message-ID: <d775d0b818bf0ae6165ffc3a2dbd5f54a84a85e6.camel@kernel.org>
Subject: Re: [PATCH net 09/11] selftests: mptcp: join: userspace: longer
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
Date: Tue, 18 Nov 2025 16:41:05 +0800
In-Reply-To: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-9-806d3781c95f@kernel.org>
References: 
	<20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
	 <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-9-806d3781c95f@kernel.org>
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
> In rare cases, when the test environment is very slow, some userspace
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
> To play it safe, all userspace tests not waiting for the end of the
> transfer are now having a longer timeout: 2 minutes.
> 
> The Fixes commit was making the connection longer, but still, the
> default timeout would have stopped it after 1 minute, which might not
> be
> enough in very slow environments.
> 
> Fixes: 290493078b96 ("selftests: mptcp: join: userspace: longer
> transfer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This patch looks good to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 93d38ded5e4e..74632beae2c6 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3804,7 +3804,7 @@ userspace_tests()
>  	   continue_if mptcp_lib_has_file
> '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns1
>  		pm_nl_set_limits $ns2 2 2
> -		{ test_linkfail=128 speed=5 \
> +		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  		wait_mpj $ns1
> @@ -3837,7 +3837,7 @@ userspace_tests()
>  	   continue_if mptcp_lib_has_file
> '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns2
>  		pm_nl_set_limits $ns1 0 1
> -		{ test_linkfail=128 speed=5 \
> +		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  		wait_mpj $ns2
> @@ -3865,7 +3865,7 @@ userspace_tests()
>  	   continue_if mptcp_lib_has_file
> '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns2
>  		pm_nl_set_limits $ns1 0 1
> -		{ test_linkfail=128 speed=5 \
> +		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  		wait_mpj $ns2
> @@ -3886,7 +3886,7 @@ userspace_tests()
>  	   continue_if mptcp_lib_has_file
> '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns2
>  		pm_nl_set_limits $ns1 0 1
> -		{ test_linkfail=128 speed=5 \
> +		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  		wait_mpj $ns2
> @@ -3910,7 +3910,7 @@ userspace_tests()
>  	   continue_if mptcp_lib_has_file
> '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns1
>  		pm_nl_set_limits $ns2 1 1
> -		{ test_linkfail=128 speed=5 \
> +		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  		wait_mpj $ns1

