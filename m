Return-Path: <linux-kselftest+bounces-2143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4300C816E05
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 13:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E530C283ECF
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742BC7D614;
	Mon, 18 Dec 2023 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjTamBvt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C243A262;
	Mon, 18 Dec 2023 12:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5B0C433C8;
	Mon, 18 Dec 2023 12:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903149;
	bh=VI1TrtlceuEBz2etHmTIzW5gF+DnQL9zxLaBcO6AK8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HjTamBvtbaoB+TEYe7ZAb2sCf8F8tlzBS3MiEBWx/ftoN3KkP5xS8696avO9+L6SB
	 iOW+r1aWk8GAHPIW0FqE57qdtLfesRg1FPXi8LLmnPGECLer7jxJmvM+F8/MYsW2nA
	 oChSp70N5TrxwXIAJ1PLCMy6vCABcND1uk8MZuq8PTuGfuNo5/FnanpIgh1J700qil
	 j5KlfS6OL39/fM8m631TOPI18ST8MNsDPzAp9f+rYgrj4NcEkhLnao8hR5cnJEnUSN
	 lb7xN+gxShV5DgDmosDUPNv3B0J5eoqO5LhknfU54Z0YtUzhCj8Ookt57e3IlVpK4+
	 jHJm9LE+3XPeQ==
Message-ID: <dc691a01-5b70-448c-bed3-fcd6819c4bc5@kernel.org>
Date: Mon, 18 Dec 2023 14:39:03 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 02/10] selftests: forwarding: ethtool_mm: fall
 back to aggregate if device does not report pMAC stats
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
 p-varis@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20231215132048.43727-1-rogerq@kernel.org>
 <20231215132048.43727-3-rogerq@kernel.org>
 <20231215172710.v6gtreijeqzocmv4@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231215172710.v6gtreijeqzocmv4@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/12/2023 19:27, Vladimir Oltean wrote:
> On Fri, Dec 15, 2023 at 03:20:40PM +0200, Roger Quadros wrote:
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 8f6ca458af9a..763c262a3453 100755
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -146,6 +146,15 @@ check_ethtool_mm_support()
>>  	fi
>>  }
>>  
>> +check_ethtool_pmac_std_stats_support()
>> +{
>> +	local dev=$1; shift
>> +	local grp=$1; shift
>> +
>> +	[ 0 -ne $(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null \
>> +		| jq '.[]."$grp" | length') ]
> 
> This is broken. $grp inside single quotes will search for the plain-text
> "$grp" string, not for the $grp bash variable. Use ".[].\"$grp\" | length".
> 

Thanks for catching this. Will fix in next spin.

> $ ./ethtool_mm.sh eno0 swp0
> eno0 does not report pMAC statistics, falling back to aggregate
> swp0 does not report pMAC statistics, falling back to aggregate
> $ ethtool -S swp0 --all-groups --src pmac
> Standard stats for swp0:
> eth-phy-SymbolErrorDuringCarrier: 0
> eth-mac-FramesTransmittedOK: 90017
> eth-mac-FramesReceivedOK: 90033
> eth-mac-FrameCheckSequenceErrors: 0
> eth-mac-AlignmentErrors: 0
> eth-mac-OctetsTransmittedOK: 9181138
> eth-mac-OctetsReceivedOK: 9182112
> eth-mac-MulticastFramesXmittedOK: 17
> eth-mac-BroadcastFramesXmittedOK: 90000
> eth-mac-MulticastFramesReceivedOK: 33
> eth-mac-BroadcastFramesReceivedOK: 90000
> eth-mac-FrameTooLongErrors: 0
> eth-ctrl-MACControlFramesReceived: 0
> rmon-etherStatsUndersizePkts: 0
> rmon-etherStatsOversizePkts: 0
> rmon-etherStatsFragments: 0
> rmon-etherStatsJabbers: 0
> rx-rmon-etherStatsPkts64to64Octets: 33
> rx-rmon-etherStatsPkts65to127Octets: 90000
> rx-rmon-etherStatsPkts128to255Octets: 0
> rx-rmon-etherStatsPkts256to511Octets: 0
> rx-rmon-etherStatsPkts512to1023Octets: 0
> rx-rmon-etherStatsPkts1024to1526Octets: 0
> rx-rmon-etherStatsPkts1527to65535Octets: 0
> tx-rmon-etherStatsPkts64to64Octets: 12
> tx-rmon-etherStatsPkts65to127Octets: 90005
> tx-rmon-etherStatsPkts128to255Octets: 0
> tx-rmon-etherStatsPkts256to511Octets: 0
> tx-rmon-etherStatsPkts512to1023Octets: 0
> tx-rmon-etherStatsPkts1024to1526Octets: 0
> tx-rmon-etherStatsPkts1527to65535Octets: 0
> 
>> +}
>> +
>>  check_locked_port_support()
>>  {
>>  	if ! bridge -d link show | grep -q " locked"; then
>> -- 
>> 2.34.1
>>

-- 
cheers,
-roger

