Return-Path: <linux-kselftest+bounces-15517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091D0954D51
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EA41F22287
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC91A1BCA16;
	Fri, 16 Aug 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQmk0QdZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2A13CF86;
	Fri, 16 Aug 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820929; cv=none; b=WWbDgojBF/eHT5DJ3cc5WSTC/v976HwBM2hqt1QXDmSP9bGQjCh5WVRr+pFDEkJd8ZAbaIEnrfz+JgLITHi7oO/LmYMLeFrZLyFww9cTV7fOWvic/NrF05aMWqUUge+TDosdXjLo9NQ5oiks1UiRlxyrBjt0sgKF6eEFYI5bbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820929; c=relaxed/simple;
	bh=TfVscs46M8rRfDc+JROIB9IprQGjq6JWIORqQJ2MwZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sclqVDDiL14RTtYsmKw46hic7APFlwDbHZzrJEbcmYgnlpj13pGK6cvlUFuHeW7+qyOfHOc/o6i3uE+JhaKDVCOqP0SsGfoH2U8OljqHBESgS53MtyPoMmCN2FTrNg/voKoeucMVx8QYBySL0EO/RKocuxqYkpE8PT0ZIlBL7Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQmk0QdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F1AC32782;
	Fri, 16 Aug 2024 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723820929;
	bh=TfVscs46M8rRfDc+JROIB9IprQGjq6JWIORqQJ2MwZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DQmk0QdZsAhog3nie0OpVxxnudcqU98mfbyatt+t0G5nkOebtrJrCj9Oixeccrf1G
	 Iel2HQE13XW5YJOJjoW6ICxNn32MC+AFppRFh7BLkBHBP0InOwtcwNoc3AX7jcjKYU
	 d8abRdhMq8kWzG4K1m3zlOIJhDrxKatSkSwqVljpt0erP96mTiIKQiVpzT+7K+mIou
	 GJgFt2jjOqdMBBtMzyeBQjzgQEtOxBExwXMV8TPayYj/xNXHPuKrHIJj8/QZklw8ry
	 e5yvLJt+PceeFxeHqo2Ghentef2qaP1k6CLGQ0XAIKu6+3TfjOs5VO7LU2PNgOLBLk
	 PC5GCXvrSSnzg==
Message-ID: <0f48b0d1-f8fd-4e2f-b773-15e6d5e4ae95@kernel.org>
Date: Fri, 16 Aug 2024 17:08:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v4] net: netconsole: selftests: Create a new
 netconsole selftest
Content-Language: en-GB
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, liuhangbin@gmail.com, petrm@nvidia.com,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 Willem de Bruijn <willemb@google.com>, David Wei <dw@davidwei.uk>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20240816132450.346744-1-leitao@debian.org>
 <cd9473bb-36d5-4b62-8523-f9112dc176f2@kernel.org>
 <Zr9nNnAsqpmPnQOx@gmail.com>
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
In-Reply-To: <Zr9nNnAsqpmPnQOx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2024 16:50, Breno Leitao wrote:
> On Fri, Aug 16, 2024 at 04:02:51PM +0200, Matthieu Baerts wrote:
>> Hi Breno,
>>
>> On 16/08/2024 15:24, Breno Leitao wrote:
>>> Adds a selftest that creates two virtual interfaces, assigns one to a
>>> new namespace, and assigns IP addresses to both.
>>>
>>> It listens on the destination interface using socat and configures a
>>> dynamic target on netconsole, pointing to the destination IP address.
>>>
>>> The test then checks if the message was received properly on the
>>> destination interface.
>>>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> ---
>>> Changelog:
>>>
>>> v4:
>>>  * Avoid sleeping in waiting for sockets and files (Matthieu Baerts)
>>>  * Some other improvements (Matthieu Baerts)
>>>  * Add configfs as a dependency (Jakub)
>>
>> Thank you for the new version!
>>
>> It looks good to me, but again, my review mainly focused on the
>> Bash-related stuff, not on the netconsole test itself.
>>
>> I just have one question below, but not blocking.
>>
>> (...)
>>
>>> diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
>>> new file mode 100755
>>> index 000000000000..5c3686af1fe8
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
>>> @@ -0,0 +1,249 @@
>>
>> (...)
>>
>>> +check_file_size() {
>>> +	local file="$1"
>>> +
>>> +	if [[ ! -f "$file" ]]; then
>>> +		# File might not exist yet
>>> +		return 1
>>> +	fi
>>> +
>>> +	# Get file size
>>> +	local size=$(stat -c %s "$file" 2>/dev/null)
>>> +	# Check if stat command succeeded
>>> +	if [[ $? -ne 0 ]]; then
>>> +		return 1
>>> +	fi
>>> +
>>> +	# Check if size is greater than zero
>>> +	if [[ "$size" -gt 0 ]]; then
>>> +		return 0  # file size > 0
>>> +	else
>>> +		return 1  # file size == 0
>>> +	fi
>>> +}
>>
>> (...)
>>
>>> +# Wait until socat saves the file to disk
>>> +busywait "${BUSYWAIT_TIMEOUT}" check_file_size "${OUTPUT_FILE}"
>>
>> It looks like your 'check_file_size' helper is a reimplementation of
>> 'test -s <FILE>', no? Can you not simply use:
> 
> Why would you like to do it in one line when you can write a 15-lines
> function that does exactly the same!? :-P

True :-P

> I will send a v5 with `test -x`, I will just wait for more reviews.

Thanks! Indeed, better to wait at least 24h between submissions.

(Also, I guess you meant to write `test -s`, not `-x`.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


