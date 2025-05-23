Return-Path: <linux-kselftest+bounces-33639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E29AC2196
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 12:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C813B197D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA3322A7E1;
	Fri, 23 May 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUwzx2Od"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E61A228CB2;
	Fri, 23 May 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997767; cv=none; b=Z+rG99eNDwTeJGpDoVjygRg5130rcXKBxBh9sWvOOau96yLr9lpV+CC6lu/vRT+i9blMNMeM0M7egHg3FCDv1lVxvbBY3+XMcvvNO5jRsU6keUnr8S4GNtQlgCcAdjwQMvJ7SLOuF1v6ny9CN+vuKD66PWFIIPTp8qYkn/7b9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997767; c=relaxed/simple;
	bh=+W5AZkpkT1z9om2iFCfAQAWhdUCBCkq/r/5xPLxeiR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmIiL66BxTH3Q3b0VkCivvcRz9byLS1yPHZ5PwFrOO47oul4ghYFTnjK+LyEYmMCfchBh1rDHNuLd7tE+4sPpO8t4OwAmkmkeHADolhHVEh/WMUBzLwo2LlEgZe+jB7ryEm8jHnq6zDdsN0CjJvPebFlquWYymuf169LpGykkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUwzx2Od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCFFC4CEE9;
	Fri, 23 May 2025 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747997767;
	bh=+W5AZkpkT1z9om2iFCfAQAWhdUCBCkq/r/5xPLxeiR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eUwzx2OdbdjY8vacCbp69fO35g6d/9g0Ylc4bEsfQNaHNCJoaR/6hGWUfY7zG+zUi
	 lBt2F1nVmJ7FPnjAuAqJslE7gyq1aXT6j4wLBZSGQMxPv8LXoOqKdJiEhw4kN1wDpY
	 FBvxWluP9/qcq+DITYQnkoYVsY3XgjdXbP/eI+p9yQdQeMi/8fK+Z5hNDRQUnom6XR
	 gKe/qemhz2GJpdKbUGGpNWV5IZTCCN44P+e7Wabvw1eth64fSTtDSTL6es8NgoSkRI
	 x/RFvVVNMoS0Hq+hVBAa+gbiHPEB+oAFUu+uFiNbc9FW6zbNcv4b0hKwwYiGYOXYka
	 tWTGfyYJceU4Q==
Message-ID: <c8455e63-4c25-4610-bfbf-f6547b3ac834@kernel.org>
Date: Fri, 23 May 2025 12:56:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] selftests: net: move wait_local_port_listen to
 lib.sh
Content-Language: en-GB, fr-BE
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20250523034433.1373-1-liuhangbin@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250523034433.1373-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hangbin,

On 23/05/2025 05:44, Hangbin Liu wrote:
> The function wait_local_port_listen() is the only function defined in
> net_helper.sh. Since some tests source both lib.sh and net_helper.sh,
> we can simplify the setup by moving wait_local_port_listen() to lib.sh.
> 
> With this change, net_helper.sh becomes redundant and can be removed.

Thank you for the modifications! I wanted to do the same at some points,
then I forgot :)

> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/Makefile          |  2 +-
>  tools/testing/selftests/net/busy_poll_test.sh |  2 +-
>  .../net/ipv6_route_update_soft_lockup.sh      |  1 -
>  tools/testing/selftests/net/lib.sh            | 21 ++++++++++++++++
>  tools/testing/selftests/net/mptcp/Makefile    |  2 +-
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  |  1 -
>  tools/testing/selftests/net/net_helper.sh     | 25 -------------------
>  tools/testing/selftests/net/pmtu.sh           |  1 -
>  tools/testing/selftests/net/udpgro.sh         |  2 +-
>  tools/testing/selftests/net/udpgro_bench.sh   |  2 +-
>  tools/testing/selftests/net/udpgro_frglist.sh |  2 +-
>  tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
>  12 files changed, 28 insertions(+), 35 deletions(-)
>  delete mode 100644 tools/testing/selftests/net/net_helper.sh

The changes in MPTCP and others look good to me, except that I think you
forgot to modify files in tools/testing/selftests/drivers/net as well:

> tools/testing/selftests/drivers/net/Makefile:            ../../net/net_helper.sh \
> tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh:source "${LIBDIR}"/../../../../net/net_helper.sh
> tools/testing/selftests/drivers/net/netdevsim/peer.sh:source ../../../net/net_helper.sh
pw-bot: cr

Note that the "netdev/check_selftest" NIPA check will not handle this
case where a shell script is removed. But that's OK, it can be ignored.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


