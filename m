Return-Path: <linux-kselftest+bounces-48528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB591D04436
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1D9D30F427C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36DC3358DE;
	Thu,  8 Jan 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRhkLWGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750B331A5D;
	Thu,  8 Jan 2026 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885652; cv=none; b=i5Eu9d++2cQ41N19FOHxg9XDhtx8+hhOaM9XKWzg+5HQmv+/KNnYP9qEVWErtmnuFQaB8DMxMmsfJfiwJ/5/qIUlBMYztkR8hZM1cQ/0OxiSZDctor9xVG2KE0zijf4nx467kfPdqYVBQrknJ2NeU35xXio1HQ3WwxWtZZvfPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885652; c=relaxed/simple;
	bh=kj9/L1h9QFZS6wMHhPgh4NTq4aVPlZfDQzmk8AYQgVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWLeOdpxYRzBEkY0fTSeK3xCsnsYNvV/Xxco2Zwh4nizKt15iMeSNqkuxpxpLNyZ8GgdcmhUKWXXG7fw01WTIPyCMYJGXR1ZuTEMZh+D66nwnoTaMTxivrdhMuX033/6UQofawY7lBSz1xf1kD5C/FbaKtpvn6UQjA6T+v8fx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRhkLWGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8BEC116C6;
	Thu,  8 Jan 2026 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767885650;
	bh=kj9/L1h9QFZS6wMHhPgh4NTq4aVPlZfDQzmk8AYQgVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aRhkLWGiPKtpyO6PuD4gE7esDHAwgPu0Ne8Ork+0d/SVkDOV7tcU2iy14cG+5LFs/
	 dVeVJq5SQcpsE46hTLhIOvT1gu42nmVyS2fpeKE8ZzipfI0GAxYV2eq4AmgG0ds9T7
	 +cVhwNYuYaSW2ptAy/ZiwL4RWPkLGGWDzB8bCj5ENKEgsd2dQ6egn0eVf6shLnv82m
	 XLXN3so119rbtHrcqAB2hwPiS9258GSk8rABWGGCPGXjExADK35Attf/+wHJRQAA8R
	 6vycGveZdz9oF46zK0hgQCV6BKjEHEzC9zAEkuXkvT/O/uRRAz74apze2AFtl5qkXV
	 2lriJkzOZyVRA==
Message-ID: <604c7b1d-f366-4faa-9abd-bae8ae73b561@kernel.org>
Date: Thu, 8 Jan 2026 08:20:48 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next v2] selftests: ipv6_icmp: add tests for
 ICMPv6 handling
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260107153841.5030-1-fmancera@suse.de>
 <20260107153841.5030-2-fmancera@suse.de>
 <72d45fe9-c058-4944-b7a2-260b7259096f@kernel.org>
 <1660abed-e6ad-4657-8736-599ab9114f68@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <1660abed-e6ad-4657-8736-599ab9114f68@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/8/26 4:24 AM, Fernando Fernandez Mancera wrote:
> On 1/7/26 5:41 PM, David Ahern wrote:
>> On 1/7/26 8:38 AM, Fernando Fernandez Mancera wrote:
>>> +icmpv6_to_vrf_based_local_address()
>>> +{
>>> +    local rc
>>> +    local lldummy
>>> +
>>> +    echo
>>> +    echo "ICMPv6 to VRF based local address"
>>> +
>>> +    setup
>>> +
>>> +    lldummy=$(get_linklocal dummy0)
>>> +
>>> +    if [ -z "$lldummy" ]; then
>>> +        echo "Failed to get link local address for dummy0"
>>> +        return 1
>>> +    fi
>>> +
>>> +    run_cmd "$NS_EXEC sysctl -w net.ipv6.conf.all.keep_addr_on_down=1"
>>> +
>>> +    # create VRF and setup
>>> +    run_cmd "$IP link add vrf0 type vrf table 10"
>>> +    run_cmd "$IP link set vrf0 up"
>>> +    run_cmd "$IP link set dummy0 master vrf0"
>>
>> run_cmd "$IP -6 addr add ::1 dev vrf0 nodad"
>>
>> makes the VRF device the loopback.
>>
>>> +
>>> +    # route to reach 2001:db8::1/128 on VRF device and back to ::1
>>> +    run_cmd "$IP -6 route add 2001:db8:1::1/64 dev vrf0"
>>> +    run_cmd "$IP -6 route add ::1/128 dev vrf0 table 10"
>>
>> and then this route add should not be needed. This is how fcnal-test.sh
>> works.
>>
> 
> Oh neat! Thanks.
> 
>>> +
>>> +    # ping6 to link local address
>>> +    run_cmd "$NS_EXEC ${ping6} -c 3 $lldummy%dummy0"
>>> +    log_test $? 0 "Ping to link local address on VRF context"
>>> +
>>> +    # ping6 to link local address from localhost (::1)
>>> +    run_cmd "$NS_EXEC ${ping6} -c 3 -I ::1 $lldummy%dummy0"
>>
>> -I vrf0 should be needed for all VRF tests. I suspect your current
>> passing tests are because you have a single setup step and then run
>> non-VRF test followed by VRF test. Really you need to do the setup,
>> run_test, cleanup for each test.
>>
> 
> You are right here about the cleanup, although the tests are passing
> even if the cleanup is properly done or if `-t
> icmpv6_to_vrf_based_local_address`. I don't see why they should not pass.

Without ::1 on the vrf device there is no valid address. ie., ::1 is in
the default vrf and dummy0 is in the VRF so it should not be allowed.
Something is off.
> 
> I am changing them to use `-I vrf0` because it makes more sense.

I should have asked yesterday: how do these tests differ from what is
done in fcnal-test.sh - ipv4_ping and ipv6_ping? Those tests cover
loopback, linklocal address and global address combined with vrf and no vrf.



