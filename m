Return-Path: <linux-kselftest+bounces-41089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E8B50AEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA293B28CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24131E5219;
	Wed, 10 Sep 2025 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu52ySlx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723431D386;
	Wed, 10 Sep 2025 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470656; cv=none; b=hMJMkNTZcdcVDxRFTqPt/K8HpRjN3rLKaS3tK3+j6+xIgwjtmw9ciScQqk88mHYNviyzN2L/GyR4rul6M2rJVTpWbP2ENFoHQmksqSp12XtzwWR4u8fbyUH+1+5A5E7fwo8/XwZOFyBD5rTpeynPYP+buWTfu5lc4M6IkoHAiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470656; c=relaxed/simple;
	bh=O+kXOPriOGMHBz0rrVOFJlWQlUQvaqACDiqC83k1uTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4sSMtzRE6Y1wtXIMyh/Jly2SPHw6WNRTrFNk1125xp4XENkGBBvKwlyqNHeNdVKhk+h0bEvrey09Y5oXJLemH9pHkI+JOMEDOVDc84Y9GzdDeLLO/qb0YDhh4AHZNvkf0wAXOstD8Fw/N0hCVVIynugANHkkv1fNWM7hTm2SsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu52ySlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE4DC4CEF8;
	Wed, 10 Sep 2025 02:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757470656;
	bh=O+kXOPriOGMHBz0rrVOFJlWQlUQvaqACDiqC83k1uTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xu52ySlx4vdokIA/qwfaS8BkKO2Sa2771r9JHnM5eJ1fqdNE+b3B5qwZVB682gZIW
	 blg9fsgvXV/q8lSR+muOTcBb/6/D6xzLV5mw+j6wsLeKpUMKa5VQ3kbYbhVl15tLYL
	 KGL6OrhyJw3YMqv9GdZMlWqKOODmwXthT037WFCmrUriHSsZH5KjXcFLzPg5cBRkP0
	 yhUE7KSRov/YyZX1jDxD8iLDtWGV2HqZhldeNVkA03ddlJtinmabbgj5g7PWe45Gp2
	 dQM0heNefD/xerYhnZOQG15DZ4m1C13IzOnyJv2FQEr0kque+7xSmrbcIkYUlqd3Xk
	 G3S7BMTVo/9kQ==
Message-ID: <3a10e26e-5c15-4208-b79f-6fbf5011b8b6@kernel.org>
Date: Tue, 9 Sep 2025 20:17:34 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests: net: replace sleeps in fcnal-test
 with waits
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250908200949.270433-1-kuba@kernel.org>
 <20250909153346.4fa8c369@kernel.org>
 <263f7204-6f5b-4bbc-8c05-222cdb04fb15@kernel.org>
 <20250909170323.5b0dbcc0@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250909170323.5b0dbcc0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 6:03 PM, Jakub Kicinski wrote:
> On Tue, 9 Sep 2025 16:59:28 -0600 David Ahern wrote:
>>> This makes some ping tests fail.
>>>
>>> https://netdev-3.bots.linux.dev/vmksft-net/results/289602/129-fcnal-other-sh/stdout
>>> https://netdev-3.bots.linux.dev/vmksft-net/results/289602/128-fcnal-ipv6-sh/stdout
>>>
>>> I only tested with debug kernels, but the non-debug get upset.
>>> I'll resend just the wait_local_port_listen changes. If the change
>>> gets more complex it's probably good to separate them out in the first
>>> place.  
>>
>> That is surprising to me. I will take look tomorrow.
> 
> Thanks! FWIW I repro'd one with "pause on fail" enabled and trying 
> to ping manually also wasn't working. Something odd.

This fixes it:

diff --git a/tools/testing/selftests/net/fcnal-test.sh
b/tools/testing/selftests/net/fcnal-test.sh
index 69941520e8e5..a527e3556763 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -189,7 +189,7 @@ show_hint()
 kill_procs()
 {
        killall nettest ping ping6 >/dev/null 2>&1
-       sleep 1
+       slowwait 2 sh -c 'test -z "$(pgrep '"'^(nettest|ping|ping6)$'"')"'
 }

 set_ping_group()
@@ -424,6 +424,8 @@ create_ns()
        ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
        ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.forwarding=1
        ip netns exec ${ns} sysctl -qw net.ipv6.conf.default.forwarding=1
+       ip netns exec ${ns} sysctl -qw net.ipv6.conf.default.accept_dad=0
+       ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.accept_dad=0
 }

 # create veth pair to connect namespaces and apply addresses.

