Return-Path: <linux-kselftest+bounces-42671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEEDBB3B06
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 12:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB96B3B51F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 10:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573AC30CB5D;
	Thu,  2 Oct 2025 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy5Kc4OU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550130CB51;
	Thu,  2 Oct 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759402150; cv=none; b=XDNNWJuIn5kqXT6yuuuzommM5R4/RzpN2PKJn8xGEhJllWTKX+J0BNktJPwdqGvR3qImDVTj3MNE4t/Dji7DMtBXe6B3tTF0H6bxQRpqJa0S6JlrBZeG15qJomawzQZFIrEYmEh+9Rxnp93R0QYQ3BLhPsvW3lFz6VhZg+ZWVwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759402150; c=relaxed/simple;
	bh=vjJ1Rya9Mo3Jc56kDyT2su4XqfOWp9kP825cCI/KYwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecMlXoqb0QUYotTUzbxJCdjOVdbzvM6MKselS5YKyDl1ltGp5guYTdfTnSpxcaJ4zHNcVZRFKqB0CX1F/uu+lsgiEiu3NmqTl9or4eZtHMsW/E5gJJZOqyfpHjz+qvec1iyUUy3LfGSTwvZ5yG9hL0+B2R2MlmdVWTVjzjOlWP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy5Kc4OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECEEC4CEFB;
	Thu,  2 Oct 2025 10:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759402149;
	bh=vjJ1Rya9Mo3Jc56kDyT2su4XqfOWp9kP825cCI/KYwo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Iy5Kc4OUSDvCPkJdoLRn3Zn8ew4Ky+ieK5tlqzHnyqnNW+rU5wVUfseVVQ7qGvCvC
	 Up0Cm8Ie8vOye4incvQN1mvtCtjueoSQU/pNY8rU+A0SbzIHxcpQBkR4Z2Jxa9q8QJ
	 Fkyvzvvb9XY3y4ubdpzeZSQl0IP8Kww5ahGY/Gii3DfaQcobTPdk5fgwIx0vv5mKAY
	 lcdQhPslx92CQ20X6nAvhzKbMZqfvEflM3aIhlZDIOYt0w+wCWksXNrnoCnxNtvpOp
	 6sSu/15NXKKsGMcKhExDpLqIh1rfiY1I1ovBZnf1OPA4hQREuEUwghJ9VUoS6fUjM/
	 8BcW7bWFre3OQ==
Message-ID: <138fe27b-7ed1-4065-827c-01e6df483153@kernel.org>
Date: Thu, 2 Oct 2025 12:48:59 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] selftests: net: unify the Makefile formats
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, jv@jvosburgh.net,
 olteanv@gmail.com, jiri@resnulli.us, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, kuniyu@google.com,
 martineau@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 fw@strlen.de, antonio@openvpn.net, allison.henderson@oracle.com,
 petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, davem@davemloft.net
References: <20251002013034.3176961-1-kuba@kernel.org>
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
In-Reply-To: <20251002013034.3176961-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 02/10/2025 03:30, Jakub Kicinski wrote:
> We get a significant number of conflicts between net and net-next
> because of selftests Makefile changes. People tend to append new
> test cases at the end of the Makefile when there's no clear sort
> order. Sort all networking selftests Makefiles, use the following
> format:
> 
>  VAR_NAME := \
> 	 entry1 \
> 	 entry2 \
> 	 entry3 \
>  # end of VAR_NAME
> 
> Some Makefiles are already pretty close to this.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> I think we need to apply this during the merge window, otherwise
> the conflicts will be crazy.

Thank you for having sorted these files to reduce future conflicts
between net and net-next! (Hopefully this will not cause too much
troubles when backporting some patches to stable versions, but I guess
new tests will rarely be backported.)

(...)

> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index 4c7e51336ab2..e3a8dbdc71cd 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -4,13 +4,31 @@ top_srcdir = ../../../../..
>  
>  CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
>  
> -TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
> -	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
> -	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
> +TEST_PROGS := \
> +	mptcp_connect.sh \
> +	mptcp_connect_mmap.sh \
> +	mptcp_connect_sendfile.sh \
> +	mptcp_connect_checksum.sh \
> +	pm_netlink.sh \
> +	mptcp_join.sh \
> +	diag.sh \
> +	simult_flows.sh \
> +	mptcp_sockopt.sh \
> +	userspace_pm.sh \
> +# end of TEST_GEN_FILES

Strange, I think all other blocks are OK in this patch, except this one:
the order is the same as before (so not sorted by alphabetical order),
and the last line is not "# end of TEST_PROGS" as expected.

I'm sure this detail can be fixed when applying the patch, or with an
extra one if that's easier, instead of sending a v2 and delaying this
type of patch.

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

>  
> -TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
> +TEST_GEN_FILES := \
> +	mptcp_connect \
> +	mptcp_diag \
> +	mptcp_inq \
> +	mptcp_sockopt \
> +	pm_nl_ctl \
> +# end of TEST_GEN_FILES
>  
> -TEST_FILES := mptcp_lib.sh settings
> +TEST_FILES := \
> +	mptcp_lib.sh \
> +	settings \
> +# end of TEST_FILES
>  
>  TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


