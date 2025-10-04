Return-Path: <linux-kselftest+bounces-42752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09443BB8B61
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 10:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D494A19C001C
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 08:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A523183F;
	Sat,  4 Oct 2025 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgJ+ExF2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BFC1EA7FF;
	Sat,  4 Oct 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759567907; cv=none; b=ImGKD3Q/vNtESYH9af8+jdfrGYTtyxdsDboTdtbyENLg6RYfm8f8bz3Xc8C66bsHC2mGuOTKrZrrZ8yfjKGEfQWQWM31S/w7r/8UZN0xrX7/DaQtOPRtMMVs8L/WjvPoSOCYy3koEapVKRfEKrbHd4lOXV3r0qJk8l52Q01dSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759567907; c=relaxed/simple;
	bh=/IB8ujFWe6EWSDPEJq2XqSK0nAWZ0LrB0KZJrYSGi/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKfT0MdcwtnV6R6E3PA6rXX231a7PUsNfqzVktElHXG9eGYcKXPagqQ4iWHfIEqUOpgJGy1GGivei0fSuHD5L46ji8/40POKxvwvpv2LWdZBPphzOPmbXMLV2QcQ3gY2AQt0XFRhDGk+R+8vpdIfRGVCfNePJ1kWRPFcYp1zk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgJ+ExF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE98DC4CEF1;
	Sat,  4 Oct 2025 08:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759567906;
	bh=/IB8ujFWe6EWSDPEJq2XqSK0nAWZ0LrB0KZJrYSGi/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FgJ+ExF2Fvcgfnb8bgsANiVdaAauxX/DFvwDKucflo/ZyQDcBhmvZZRGOMQ25u3vG
	 48SH8I6Z/0GMFrOQ55Rbq5YOJGGuOAfupXoEQBuvjM6XpslL6WC1q/0VPb1Uzn0a0g
	 UMIXxnkesdOSVa0+dvpLNjrIfUIyiReYdHJcXLbmjQNUeUUr/e6cmV6HDdGwoDQnXo
	 3NQMK3PWCirg6AG6nk8Sa7ECe8WhvQvZiR/+5TVE2bHnWOI7L7cLsDPZpO3U2EsADt
	 r0ByAmxQBONbT/KL+urq4sU+ztZa2kWWLSMDdk8MR3MIv2oLR/ZOAAvlm0dFesWnuT
	 lyr2lq+WuO3lA==
Message-ID: <8b49ca48-ff6b-40ed-8322-e0c9791d1d17@kernel.org>
Date: Sat, 4 Oct 2025 10:51:36 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf] selftests/bpf: fix implicit-function-declaration
 errors
Content-Language: en-GB, fr-BE
To: Eduard Zingerman <eddyz87@gmail.com>, ihor.solodrai@linux.dev,
 alan.maguire@oracle.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20251003-bpf-sft-fix-build-err-6-18-v1-1-2a71170861ef@kernel.org>
 <d108d59be611a63c73303347d07fe0ba5f2b74b7.camel@gmail.com>
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
In-Reply-To: <d108d59be611a63c73303347d07fe0ba5f2b74b7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eduard,

On 04/10/2025 01:37, Eduard Zingerman wrote:
> On Fri, 2025-10-03 at 17:24 +0200, Matthieu Baerts (NGI0) wrote:
>> When trying to build the latest BPF selftests, with a debug kernel
>> config, Pahole 1.30 and CLang 20.1.8 (and GCC 15.2), I got these errors:
>>
>>   progs/dynptr_success.c:579:9: error: call to undeclared function 'bpf_dynptr_slice'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>     579 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 1);
>>         |                ^
>>   progs/dynptr_success.c:579:9: note: did you mean 'bpf_dynptr_size'?
>>   .virtme/build-debug-btf//tools/include/vmlinux.h:120280:14: note: 'bpf_dynptr_size' declared here
>>    120280 | extern __u32 bpf_dynptr_size(const struct bpf_dynptr *p) __weak __ksym;
>>           |              ^
>>   progs/dynptr_success.c:579:7: error: incompatible integer to pointer conversion assigning to '__u64 *' (aka 'unsigned long long *') from 'int' [-Wint-conversion]
>>     579 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 1);
>>         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   progs/dynptr_success.c:596:9: error: call to undeclared function 'bpf_dynptr_slice'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>     596 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 10);
>>         |                ^
>>   progs/dynptr_success.c:596:7: error: incompatible integer to pointer conversion assigning to 'char *' from 'int' [-Wint-conversion]
>>     596 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 10);
>>         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> I don't have these errors without the debug kernel config from
>> kernel/configs/debug.config. With the debug kernel, bpf_dynptr_slice()
>> is not declared in vmlinux.h. It is declared there without debug.config.
>>
>> The fix is similar to what is done in dynptr_fail.c which is also using
>> bpf_dynptr_slice(): bpf_kfuncs.h is now included.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
> 
> I can reproduce similar issue when including
> kernel/configs/debug.config with my regular dev config, but for
> different functions: bpf_rcu_read_{un,}lock().

Thank you for having checked! I also had issues with these functions on
my side, when testing on top of 'net'.

> However, this is not a way to fix this.
> Kfuncs are not supposed to just disappear from DWARF.

Indeed. But strange it was fine before. Or fine without debug.config.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


