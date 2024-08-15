Return-Path: <linux-kselftest+bounces-15451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC6B953C3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 22:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FBB6B218F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 20:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D314A60E;
	Thu, 15 Aug 2024 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKA0HAjR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767838DC7;
	Thu, 15 Aug 2024 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755434; cv=none; b=KvDwKwSHfeRL1EM51Xs/rUtzA83pptjQ4S65vQHjNM/tgY6wIl9dPdzWRdPZhhVKRboQP4Gy6FA3Tttj101eKN5VlJIJWQNOJKcYeHXDSs0Tu2ZR7HMcznTpy8ve2q/f3bmPehZR5oZ+mWeXlK/Sa+7auRuAyOrJNunKjdSrPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755434; c=relaxed/simple;
	bh=CxitJOj2UwXlQodEuBRLka5dunS/7Sxix03eKG+L21o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHytUloZD7pcjf+cESwiiPJwHoBAY5Fm1c4h8X/uZBEluAUu+hh4o9lPHGPMVtBLmLatQL5X69vP8pG3NPVje3Hb0sUit390Z9c0IR4TjVjeYsAD+kO+TlA9palfMatA9KBKUBVsRhKLSiv7W2FYwCuCfMVm4aBS64e/LfsVneQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKA0HAjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075CCC32786;
	Thu, 15 Aug 2024 20:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723755433;
	bh=CxitJOj2UwXlQodEuBRLka5dunS/7Sxix03eKG+L21o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RKA0HAjRh3hX4HjnFxTF2jUx1BraLgD2kxzb4l1WxIWIq2l0ix1SAVfnBC9oHr2r0
	 OySC4WXcD4+t9pSxbN6Fez9YAkdgy4uLTN6qTcIZtPWI4Au9eGnfAt2H8enBABdzU2
	 fSouvgGSLnq1N529JZp77gtn3e0Sigc7KlX5xWSO5ElCB8BdxRBm2/fxUvtLX4jBpl
	 JINZtYgoITjl/hzYCdzhO1XFxz24Y0PHzj8wnnwFrIpWj9piZ1cpVub9ar0lBVZKY1
	 C9fQ0GMEZ3rlzeHFxDfwKdGu0CjmbgqDSr6w5r2blSuy33cDjxHZmYQ50XTpipgwZ2
	 miMcXGxH9xBsg==
Message-ID: <d9adb89e-6764-45d2-97b7-892b37c2b71c@kernel.org>
Date: Thu, 15 Aug 2024 22:57:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add mptcp subflow subtest
Content-Language: en-GB
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>,
 Manu Bretelle <chantra@meta.com>
References: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org>
 <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org>
 <2136317a-3e95-4993-b2fc-1f3b2c28dbdc@linux.dev>
 <8a2ff1bd-52dc-421d-87b7-fc2f56e81da2@kernel.org>
 <716cbd56-4a44-4451-a6f3-5bacef3e0729@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <716cbd56-4a44-4451-a6f3-5bacef3e0729@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Martin,

Thank you for your reply!

On 15/08/2024 00:37, Martin KaFai Lau wrote:
> On 8/14/24 3:04 AM, Matthieu Baerts wrote:
>> Hi Martin,
>>
>> Thank you for your reply!
>>
>> On 14/08/2024 03:12, Martin KaFai Lau wrote:
>>> On 8/5/24 2:52 AM, Matthieu Baerts (NGI0) wrote:
>>>> +static int endpoint_init(char *flags)
>>>> +{
>>>> +    SYS(fail, "ip -net %s link add veth1 type veth peer name veth2",
>>>> NS_TEST);
>>>> +    SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
>>>> +    SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
>>>> +    SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
>>>> +    SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
>>>> +    if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST,
>>>> ADDR_2, flags)) {
>>>> +        printf("'ip mptcp' not supported, skip this test.\n");
>>>> +        test__skip();
>>>
>>> It is always a skip now in bpf CI:
>>>
>>> #171/3   mptcp/subflow:SKIP
>>>
>>> This test is a useful addition for the bpf CI selftest.
>>>
>>> It can't catch regression if it is always a skip in bpf CI though.
>>
>> Indeed, for the moment, this test is skipped in bpf CI.
>>
>> The MPTCP CI checks the MPTCP BPF selftests that are on top of net and
>> net-next at least once a day. It is always running with the last stable
>> version of iproute2, so this test is not skipped:
>>
>>     #169/3   mptcp/subflow:OK
>>
>> https://github.com/multipath-tcp/mptcp_net-next/actions/
>> runs/10384566794/job/28751869426#step:7:11080
>>
>>> iproute2 needs to be updated (cc: Daniel Xu and Manu, the outdated
>>> iproute2 is something that came up multiple times).
>>>
>>> Not sure when the iproute2 can be updated. In the mean time, your v3 is
>>> pretty close to getting pm_nl_ctl compiled. Is there other blocker on
>>> this?
>>
>> I will try to find some time to check the modifications I suggested in
>> the v3, but I don't know how long it will take to have them ready, as
>> they might require some adaptations of the CI side as well, I need to
>> check. On the other hand, I understood adding a duplicated version of
>> the mptcp.h UAPI header is not an option either.
>>
>> So not to block this (already old) series, I thought it would help to
>> first focus on this version using 'ip mptcp', while I'm looking at the
>> selftests modifications. If these modifications are successful, I can
>> always resend the patch 2/3 from the v3 later, and using 'pm_nl_ctl'
>> instead of 'ip mptcp', to be able to work with IPRoute2 5.5.
>>
>> Do you think that could work like that?
> 
> If there is CI started covering it, staying with the 'ip mptcp' is fine.
> 
> The bpf CI has to start testing it asap also. The iproute2 package will
> need to be updated on the bpf CI side. I think this has to be done
> regardless.
> 
> It will be useful to avoid the uapi header dup on its own. The last one
> you have seems pretty close.

Thank you. Yes I will try to find time to look at that.

>>>> +        goto fail;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +fail:
>>>> +    return -1;
>>>> +}
>>>> +
>>>> +static int _ss_search(char *src, char *dst, char *port, char *keyword)
>>>> +{
>>>> +    return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d
>>>> | grep -q '%s'",
>>>> +              NS_TEST, src, dst, port, PORT_1, keyword);
>>>> +}
>>>> +
>>>> +static int ss_search(char *src, char *keyword)
>>>> +{
>>>> +    return _ss_search(src, ADDR_1, "dport", keyword);
>>>> +}
>>>> +
>>>> +static void run_subflow(char *new)
>>>> +{
>>>> +    int server_fd, client_fd, err;
>>>> +    char cc[TCP_CA_NAME_MAX];
>>>> +    socklen_t len = sizeof(cc);
>>>> +
>>>> +    server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
>>>> +    if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
>>>> +        return;
>>>> +
>>>> +    client_fd = connect_to_fd(server_fd, 0);
>>>> +    if (!ASSERT_GE(client_fd, 0, "connect to fd"))
>>>> +        goto fail;
>>>> +
>>>> +    err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
>>>> +    if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
>>>> +        goto fail;
>>>> +
>>>> +    send_byte(client_fd);
>>>> +
>>>> +    ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search
>>>> fwmark:0x1");
>>>> +    ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search
>>>> fwmark:0x2");
>>>> +    ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
>>>> +    ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
>>>
>>> Is there a getsockopt way instead of ss + grep?
>>
>> No there isn't: from the userspace, the app communicates with the MPTCP
>> socket, which can have multiple paths (subflows, a TCP socket). To keep
>> the compatibility with TCP, [gs]etsockopt() will look at/modify the
>> whole MPTCP connection. For example, in some cases, a setsockopt() will
>> propagate the option to all the subflows. Depending on the option, the
>> modification might only apply to the first subflow, or to the
>> user-facing socket.
>>
>> For advanced users who want to have different options set to the
>> different subflows of an MPTCP connection, they can use BPF: that's what
>> is being validated here. In other words, doing a 'getsockopt()' from the
>> userspace program here will not show all the different marks and TCP CC
>> that can be set per subflow with BPF. We can see that in the test: a
>> getsockopt() is done on the MPTCP socket to retrieve the default TCP CC
>> ('cc' which is certainly 'cubic'), but we expect to find another one
>> ('new' which is 'reno'), set by the BPF program from patch 1/2. I guess
>> we could use bpf to do a getsockopt() per subflow, but that's seems a
>> bit cheated to have the BPF test program setting something and checking
>> if it is set. Here, it is an external way. Because it is done from a
> 
> I think the result is valid by having a bpf prog to inspect the value of
> a sock. Inspecting socket is an existing use case. There are many
> existing bpf tests covering this inspection use case to ensure the
> result is legit. A separate cgroup/getsockopt program should help here
> (more on this below).

I didn't consider a separate program. Indeed, should work.

>> dedicated netns, it sounds OK to do that, no?
> 
> Thanks for the explanation. I was hoping there is a way to get to the
> underlying subflow fd. It seems impossible.
> 
> In the netns does help here. It is not only about the ss iterating a lot
> of connections or not. My preference is not depending on external tool/
> shell-ing if possible, e.g. to avoid the package update discussion like
> the iproute2 here. The uapi from the testing kernel is always up-to-
> date. ss is another binary but arguably in the same iproute2 package.
> There is now another extra "grep" and pipe here. We had been bitten by
> different shell behaviors and some arch has different shells ...etc.

OK, I thought it was fine to use 'ss | grep' because it is used in other
BPF selftests: test_tc_tunnel.sh & test_xdp_features.sh.

> I think it is ok to take this set as is if you (and Gelang?) are ok to
> followup a "cgroup/getsockopt" way to inspect the subflow as the very
> next patch to the mptcp selftest. It seems inspecting subflow will be a
> common test going forward for mptcp, so it will be beneficial to have a
> "cgroup/getsockopt" way to inspect the subflow directly.
> 
> Take a look at a recent example [0]. The mptcp test is under a cgroup
> already and has the cgroup setup. An extra "cgroup/getsockopt" prog
> should be enough. That prog can walk the msk->conn_list and use
> bpf_rdonly_cast (or the bpf_core_cast macro in libbpf) to cast a pointer
> to tcp_sock for readonly. It will allow to inspect all the fields in a
> tcp_sock.

It looks interesting to be able to inspect all the fields in a tcp_sock!
I will check with Geliang what can be done.

> Something needs to a fix in patch 2(replied separately), so a re-spin is
> needed.

Thank you. Will do in the next version!

> pw-bot: cr
> 
> [0]: https://lore.kernel.org/all/20240808150558.1035626-3-
> alan.maguire@oracle.com/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


