Return-Path: <linux-kselftest+bounces-48418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAA2CFF50D
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 19:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F2AE3439E8F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A336656A;
	Wed,  7 Jan 2026 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbhou5KA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8310F2;
	Wed,  7 Jan 2026 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804068; cv=none; b=S9dQZsHakHS69fTwFaGJfreSsgeSqqrA1C4DTkARXEDWwOa+FsQ3LWW/4IKKjrAqppKG1cbi514Zm2s3GZxsDyHmi4XbvGFQN2ANO5zW5Dlg72zcrIiaMpV4fgfBNcoFcKGmqREvN0VUO2ddm9Q3d0qdwvAShEHQYVMuvYwZlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804068; c=relaxed/simple;
	bh=Qz6Qqop0qFf7mBnylFBucLzsveOWJ8mTu7t3zWUscKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3WrVl8Fa27Tc6O8QnkTxf8Q8TrdjE6o98rCDmEJKGY4RiRjfTtLns0Yz6hDZOcvQxYF3+PWwmndyx8VrxZAIxewpU2boTzLeSkI8pb2q6A5CdMCLF9GObjEKeeD0+kOOFkHlAb4ZCaxMvEgYChJvKpEm8wOO9YCR1fYCI992bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbhou5KA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3F4C4CEF1;
	Wed,  7 Jan 2026 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767804067;
	bh=Qz6Qqop0qFf7mBnylFBucLzsveOWJ8mTu7t3zWUscKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dbhou5KAEsZutI3zbeeEbloh39Fmr3YXZCB+kci6gEifI3kjOVBXvgl1H40kZsvSD
	 YrSy5mXiffBvPmSOxWq6bivUTvAUJV0Jooy98xZMrteCJezRAip/WSnLMAFj2iu9SF
	 1rBK6nnd8OuAk/lLfLK5y5oKrh9eHKV6M8QCm0sHv7qXVvpTem/XK62258Vzf4oLib
	 DWrT+B+Gl/11LvgKll5DvisqeMI4Kseu6e5mfHoCvVTEzrIg3cLEaoX8+5LXvRmWYi
	 Efn9yRpy/SUIbmJLqYygyOeAPcuB2cXXBVnCNWtRUqR8yotUU5fX7VMvoVflkVkP5C
	 0SlMXgC/K/MRA==
Message-ID: <72d45fe9-c058-4944-b7a2-260b7259096f@kernel.org>
Date: Wed, 7 Jan 2026 09:41:05 -0700
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
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260107153841.5030-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/26 8:38 AM, Fernando Fernandez Mancera wrote:
> +icmpv6_to_vrf_based_local_address()
> +{
> +	local rc
> +	local lldummy
> +
> +	echo
> +	echo "ICMPv6 to VRF based local address"
> +
> +	setup
> +
> +	lldummy=$(get_linklocal dummy0)
> +
> +	if [ -z "$lldummy" ]; then
> +		echo "Failed to get link local address for dummy0"
> +		return 1
> +	fi
> +
> +	run_cmd "$NS_EXEC sysctl -w net.ipv6.conf.all.keep_addr_on_down=1"
> +
> +	# create VRF and setup
> +	run_cmd "$IP link add vrf0 type vrf table 10"
> +	run_cmd "$IP link set vrf0 up"
> +	run_cmd "$IP link set dummy0 master vrf0"

run_cmd "$IP -6 addr add ::1 dev vrf0 nodad"

makes the VRF device the loopback.

> +
> +	# route to reach 2001:db8::1/128 on VRF device and back to ::1
> +	run_cmd "$IP -6 route add 2001:db8:1::1/64 dev vrf0"
> +	run_cmd "$IP -6 route add ::1/128 dev vrf0 table 10"

and then this route add should not be needed. This is how fcnal-test.sh
works.

> +
> +	# ping6 to link local address
> +	run_cmd "$NS_EXEC ${ping6} -c 3 $lldummy%dummy0"
> +	log_test $? 0 "Ping to link local address on VRF context"
> +
> +	# ping6 to link local address from localhost (::1)
> +	run_cmd "$NS_EXEC ${ping6} -c 3 -I ::1 $lldummy%dummy0"

-I vrf0 should be needed for all VRF tests. I suspect your current
passing tests are because you have a single setup step and then run
non-VRF test followed by VRF test. Really you need to do the setup,
run_test, cleanup for each test.

> +	log_test $? 0 "Ping to link local address from ::1 on VRF context"
> +
> +	# ping6 to local address
> +	run_cmd "$NS_EXEC ${ping6} -c 3 2001:db8:1::1"
> +	log_test $? 0 "Ping to local address on VRF context"
> +
> +	# ping6 to local address from localhost (::1)
> +	run_cmd "$NS_EXEC ${ping6} -c 3 -I ::1 2001:db8:1::1"
> +	log_test $? 0 "Ping to local address from ::1 on VRF context"
> +}
> +


