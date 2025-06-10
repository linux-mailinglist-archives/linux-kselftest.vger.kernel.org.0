Return-Path: <linux-kselftest+bounces-34549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1812AAD30CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 10:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EF21890D67
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15FC27FB35;
	Tue, 10 Jun 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6KgEd9T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F731D555;
	Tue, 10 Jun 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545248; cv=none; b=KimmL3m29mqlMcYwyIu4p1YdwmYoVO5neF9ezpCDtirdcFxdLgQvSarMhKv5eZAONp38sX4yYSaziOJPmEKdtCJmW53M2/dO52mKcnv4d5u+2k90W3QLlehnTpwhgf/Efeo262leu6OA5McXfzv1JQrh9RvyyvYwFebjiviZCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545248; c=relaxed/simple;
	bh=Y50Vux8Ns1rqU86PUK5P/sKJBcsZtMsgtFKACv85TOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9jhhdmrKLUKroA7zSirbsjG/60IcmDp5Hdxnb+wFo0ypHUQs14q1NWXBjL5oI6eTmfqw1Ag8zMjlCZy3RQydaFz574z8q+ROBA1op7l4o1QhuyziDQ/LePzAB/VUsIQyQ8BgeGshx9lTL5bRVu0wPDL5R5rND2iBEBNwlZTcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6KgEd9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444DEC4CEEF;
	Tue, 10 Jun 2025 08:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749545248;
	bh=Y50Vux8Ns1rqU86PUK5P/sKJBcsZtMsgtFKACv85TOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R6KgEd9TuIIM6jtaW6vB04AOhRNwacwTbafUZd6XccTWrEEZ8ao+LGqifxocf/sHd
	 hkdr+IPGCBGnzFhB9JGNnsAtqcZZKAHFxxSg685RnuIry9+8yukrYckFl0aAV5RUkz
	 8xfb8oLQy1FBLCD9Z69w0cOMYKx1IP83zMe+/PXccTxJxTWwxwCHlpGilbnkdw7n1x
	 QukYvEpmMP6+wqh4UftCOiAlHIsFEh2KKuRu3kJYpsBSYSFXWsBhMpjMCFGWjh7EDS
	 P1Cck5holGtKWY2hjnSiMaEztq4hTmvwkQDAABwEBgRoEP8cVwWHCfSUEQCNuqIiMP
	 bD9JviSLPTEIA==
Message-ID: <6e7ace09-581a-4c36-a9d6-f16b734f5335@kernel.org>
Date: Tue, 10 Jun 2025 10:47:23 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] selftests/net: packetdrill: more xfail changes
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>, willemb@google.com
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, davem@davemloft.net
References: <20250610000001.1970934-1-kuba@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250610000001.1970934-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 10/06/2025 02:00, Jakub Kicinski wrote:
> Most of the packetdrill tests have not flaked once last week.
> Add the few which did to the XFAIL list.

Thank you for monitoring these tests!

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: willemb@google.com
> CC: matttbe@kernel.org
> CC: linux-kselftest@vger.kernel.org
> 
> Every time I sit down to add more I plan to just XFAIL all of packetdrill
> on slow machines, but then I convince myself otherwise. One last time?

:)

Did some of these packetdrill tests fail only when using a debug kernel?
But yes, I guess we can always say: "maybe one day that will pay off" :)

As long as it is manageable!

> ---
>  tools/testing/selftests/net/packetdrill/ksft_runner.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
> index ef8b25a606d8..c5b01e1bd4c7 100755
> --- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
> +++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
> @@ -39,11 +39,15 @@ if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
>  	# xfail tests that are known flaky with dbg config, not fixable.
>  	# still run them for coverage (and expect 100% pass without dbg).
>  	declare -ar xfail_list=(
> +		"tcp_blocking_blocking-connect.pkt"
> +		"tcp_blocking_blocking-read.pkt"

Please note that these two tests have "--tolerance_usecs=10000" in their
script. This is overridden by the command line option added above when
KSFT_MACHINE_SLOW is defined: "--tolerance_usecs=14000". But maybe for
these two tests, the tolerance should be even higher than 14000 when
using a debug kernel?

But maybe still better to add them to the XFAIL list and keep the code
as it is.

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

>  		"tcp_eor_no-coalesce-retrans.pkt"
>  		"tcp_fast_recovery_prr-ss.*.pkt"
> +		"tcp_sack_sack-route-refresh-ip-tos.pkt"
>  		"tcp_slow_start_slow-start-after-win-update.pkt"
>  		"tcp_timestamping.*.pkt"
>  		"tcp_user_timeout_user-timeout-probe.pkt"
> +		"tcp_zerocopy_cl.*.pkt"
>  		"tcp_zerocopy_epoll_.*.pkt"
>  		"tcp_tcp_info_tcp-info-.*-limited.pkt"
>  	)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


