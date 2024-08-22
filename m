Return-Path: <linux-kselftest+bounces-16026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263695B13C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AB4B22B13
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69F17C7DF;
	Thu, 22 Aug 2024 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV1OBTU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E01C6B5;
	Thu, 22 Aug 2024 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318045; cv=none; b=TqdbAezVBoezdtye6TTAGcu+UlkaW3unrxwMutl/NXOP+Ky1BXkgNUvFWqAmJlyeUKqKcdyGVgpE84eU3QkWZwHI2sJX2vwRZ+5N5XYZncYJw50QsLmfzLOKWyn31Siiy37NsiqxN13BN3UzTN1td2YDoSko1OYAK0zwtlUKPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318045; c=relaxed/simple;
	bh=3pePhm2enxScNpWzI2H1OmyMtOOZNL1UYS5tRffuIWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgh3RRBmwWJUTY8Kd67ZITjx5jBwVu7vbC2pEwnzDQiClAxCoB9PMDdZhKl/XS3pWS8SbdXImshSXrwljFTPkoivND+nmMDFEuGph0lXJXGyTRSDa17eZDHLYIg3ollYAmhb6hFKNsG4rNdEFybZ3mF8lD3De3hCTfqX8syqWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV1OBTU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C71C4AF0C;
	Thu, 22 Aug 2024 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724318044;
	bh=3pePhm2enxScNpWzI2H1OmyMtOOZNL1UYS5tRffuIWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qV1OBTU79pM2Hpfxa6ebghJmrVPv1R3kKngrwaBlLdJXdsuJNcUBjck35GNRjfWdn
	 h5EeXt8+pIH99N80YPTdafro723rFXxaKkq66Aznh6XC0/xp+2qDEK1W1weN83H5U5
	 U68lM5a2NRyB+dp5QoV2mLcEVZ1ZHyKNqFxrZP5dLnS/aQb3FvKq3L96hfyqjYM6KC
	 CtjZZ7uGtH1cYc6GX2W/bp4bEhmbJspEQiVe8ZvVrT0mAuimVlKoWF1NHTnWBfL+Ic
	 skKTHEGqkjU7wfhi6sqDIsZdL7afBB+rZaYrgfgJRrNK8s/yl+a9x48LAaUl0FYbMN
	 Pr1JFRb+0cvLA==
Message-ID: <0201ab87-5f65-4287-bda2-d170a90ae458@kernel.org>
Date: Thu, 22 Aug 2024 11:13:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add mptcp subflow subtest
Content-Language: en-GB
To: Manu Bretelle <chantra@meta.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@meta.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 "sdf@fomichev.me" <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>
References: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org>
 <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org>
 <2136317a-3e95-4993-b2fc-1f3b2c28dbdc@linux.dev>
 <364C4C5B-27A0-4210-84E2-8CA9867E4127@meta.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <364C4C5B-27A0-4210-84E2-8CA9867E4127@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Manu,

On 21/08/2024 22:32, Manu Bretelle wrote:
> 
> 
>> On Aug 13, 2024, at 6:12 PM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>>>
>> On 8/5/24 2:52 AM, Matthieu Baerts (NGI0) wrote:
>>> +static int endpoint_init(char *flags)
>>> +{
>>> + SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
>>> + SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
>>> + SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
>>> + SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
>>> + SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
>>> + if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags)) {
>>> + printf("'ip mptcp' not supported, skip this test.\n");
>>> + test__skip();
>>
>> It is always a skip now in bpf CI:
>>
>> #171/3   mptcp/subflow:SKIP
>>
>> This test is a useful addition for the bpf CI selftest.
>>
>> It can't catch regression if it is always a skip in bpf CI though.
>>
>> iproute2 needs to be updated (cc: Daniel Xu and Manu, the outdated iproute2 is something that came up multiple times).
>>
>> Not sure when the iproute2 can be updated. In the mean time, your v3 is pretty close to getting pm_nl_ctl compiled. Is there other blocker on this?
> 
> I have updated runners to Ubuntu 24.04 which comes with:
> root@1fdd5d75581b:/actions-runner# ip --json -V
> ip utility, iproute2-6.1.0, libbpf 1.3.0
> root@1fdd5d75581b:/actions-runner# ip mptcp help
> Usage:  ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]
>                                       [ port NR ] [ FLAG-LIST ]
>         ip mptcp endpoint delete id ID [ ADDRESS ]
>         ip mptcp endpoint change [ id ID ] [ ADDRESS ] [ port NR ] CHANGE-OPT
>         ip mptcp endpoint show [ id ID ]
>         ip mptcp endpoint flush
>         ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]
>         ip mptcp limits show
>         ip mptcp monitor
> FLAG-LIST := [ FLAG-LIST ] FLAG
> FLAG  := [ signal | subflow | backup | fullmesh ]
> CHANGE-OPT := [ backup | nobackup | fullmesh | nofullmesh ]
> 
> Assuming I don’t need to revert back to old runners due to unrelated issue, you should now have `ip mptcp` available.

Great, thank you for this update, that will ease the inclusion of this
series!

(That's a shame Ubuntu 24.04 didn't come with IPRoute 6.8, same version
as their default kernel [1]... but that's not blocking us here)

[1] https://bugs.launchpad.net/ubuntu/+source/iproute2/+bug/2051672

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


