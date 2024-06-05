Return-Path: <linux-kselftest+bounces-11251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7290C8FD0C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 16:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47863B23A19
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E135D17BC9;
	Wed,  5 Jun 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrnsKbt+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8A6FB0;
	Wed,  5 Jun 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596777; cv=none; b=V1jT3HnwDJ50oyh9P3myghYs+Vy7mY0GMBjVwujBQyP//TJF/IxzhYIT0BsikKvym3Pb/PNk9t3TeFQpCQPIWehBb+q9miKLGvbWmYb9aRHxofMujN1/pGWbsBTdD9g5BDLgp3VbkR1RTLFiqhrFXA/6k49rOWnW9/n6N0Aden0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596777; c=relaxed/simple;
	bh=ozvkOGgUaxgxta5ytOJ2UVPWZSX57s6TLs8ldu0HwZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+keQyTm2+TYerIlJK9WvtpawBYQNHkw4lSBWbsO/fDy5o5rl0niOwrAP1egzJLDiTqa50ynt/z9jyacoFdDXO7hXRd5pxvOnNdrO29F1kuuSfPLX05mJQTz3sY/ls/YCEBD3zlCUQNCymldbviLkskEhYEUvfmC7Zx8tG3RKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrnsKbt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A920C2BD11;
	Wed,  5 Jun 2024 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717596777;
	bh=ozvkOGgUaxgxta5ytOJ2UVPWZSX57s6TLs8ldu0HwZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UrnsKbt+4SxFIHs9D7s0CLZz9RiwVy9uaPxcmHYlp8AO7wBrkAnAsiSWkBqnR8rAr
	 ZFHnnMzUWLEpGNnoqLbWVMHsZwOE2VMqe8ujTBVCDjFCbuCE+HeL45a6qALbWxQd2U
	 CZ1yVJ4i9TkWCZlKp3z/5Op32xwZdUR0tYhxAJqPw5WdlyPTl9E4P2dX9VC1gss8cc
	 gk3xXKvbR4FU3Khm8+yZmSsX1rHlVVLCBk3gKH1O+ZiV3DsDhhRnq5iTDcxzafjKb8
	 d7/JDIa5zfAKyCvrM1fgwzje/2comJeg91ZR65SEOFYSLljurnqludiVTkQQf5LaLq
	 HsMx4QCGUDvEw==
Message-ID: <0f85551f-dd67-4d88-abc2-cdf80293a604@kernel.org>
Date: Wed, 5 Jun 2024 16:12:52 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 2/3] selftests: net: lib: avoid error removing empty
 netns name
Content-Language: en-GB
To: Petr Machata <petrm@nvidia.com>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Geliang Tang <geliang@kernel.org>
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
 <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-2-b3afadd368c9@kernel.org>
 <877cf38yg5.fsf@nvidia.com>
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
In-Reply-To: <877cf38yg5.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Petr,

Thank you for the review!

On 05/06/2024 12:38, Petr Machata wrote:
> 
> "Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:
> 
>> If there is an error to create the first netns with 'setup_ns()',
>> 'cleanup_ns()' will be called with an empty string as first parameter.
>>
>> The consequences is that 'cleanup_ns()' will try to delete an invalid
>> netns, and wait 20 seconds if the netns list is empty.
>>
>> Instead of just checking if the name is not empty, convert the string
>> separated by spaces to an array. Manipulating the array is cleaner, and
>> calling 'cleanup_ns()' with an empty array will be a no-op.
>>
>> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
>> Cc: stable@vger.kernel.org
>> Acked-by: Geliang Tang <geliang@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/lib.sh | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
>> index a422e10d3d3a..e2f51102d7e1 100644
>> --- a/tools/testing/selftests/net/lib.sh
>> +++ b/tools/testing/selftests/net/lib.sh
>> @@ -15,7 +15,7 @@ ksft_xfail=2
>>  ksft_skip=4
>>  
>>  # namespace list created by setup_ns
>> -NS_LIST=""
>> +NS_LIST=()
>>  
>>  ##############################################################################
>>  # Helpers
>> @@ -137,6 +137,7 @@ cleanup_ns()
>>  	fi
>>  
>>  	for ns in "$@"; do
>> +		[ -z "${ns}" ] && continue
> 
> I think this is now irrelevant though? Now cleanup_ns() will be called
> with no arguments for an empty NS list, so the loop does not even kick in.

If you don't mind, I think it is "safer" to keep it: some selftests are
using 'cleanup_ns()' directly, not via 'cleanup_all_ns()', e.g.
netns-name.sh, cmsg-*.sh, fib-*.sh, etc. which can call it with the
variables not set if 'setup_ns' failed during the init phase.

For the moment, all these selftests are calling 'cleanup_ns()' with
parameters added without double quotes: so it is fine. Until someone
changes that to please shellcheck, like we did on our side with MPTCP
selftests. So this line will be useful soon when we will publish the
rest of our patches to use 'lib.sh' [1] :)

Link:
https://lore.kernel.org/mptcp/5f4615c3-0621-43c5-ad25-55747a4350ce@kernel.org/T/
[1]

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


