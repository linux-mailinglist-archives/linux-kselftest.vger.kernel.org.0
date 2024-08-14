Return-Path: <linux-kselftest+bounces-15354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23699525D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F301C2212B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 22:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D8214B943;
	Wed, 14 Aug 2024 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wjh/wcFn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4FE60275;
	Wed, 14 Aug 2024 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723675046; cv=none; b=MrTLLRe3zE5kW/ibqhfWt1E7rw1+SQiv43KcVH3fxf+qly/hJA0UVofsmXrywU3Vz1D+BugsNmXw5FKRui0/Dt88k/eaBuA3EIwkHa8auuj/FX5avuANnlSKjzLjkBCRGxb7IaZnPpKK8yLkMV+DAChHF/pTUMehB2NGSX2woYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723675046; c=relaxed/simple;
	bh=RyBEIF+WkRp3KbGMySEBlxB8nRiemo7+pvynatFUUJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0mDOIFC8CWdHm1l/vAEtWJsvyup1xYTyZFDNpu955QA0n8uySVxan56CftaO2SPMkHomn3QN0xTz3PQs+Hpx6HcKLw7rPIkG09PBjjZxsqeimBqx/G6T9kjikIczWK7/HfSV/YoT9U00emF28EPJTURgw5AtI1jNBdeHDQT64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wjh/wcFn; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <716cbd56-4a44-4451-a6f3-5bacef3e0729@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723675041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f86mRHsZH4bwWIAKgadOnwJ3hSEJ46GTw8tBGGkcal4=;
	b=wjh/wcFn6Y9Kool1UBy57C1o4V+xz4OEDXKBw49EfwGjgiKzLJHtcZ2LbVGODU0go8Y9A6
	R8NCLaZcadw/Zs8GZ87RXu+LR6tLJdaoiQ9twKqFnRxCL2sa+WFv1ka0+UhCdC7oKy2BMj
	96ePr6rzwxMShYVcnAykZCHgYxt2Lzs=
Date: Wed, 14 Aug 2024 15:37:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add mptcp subflow subtest
To: Matthieu Baerts <matttbe@kernel.org>
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <8a2ff1bd-52dc-421d-87b7-fc2f56e81da2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/14/24 3:04 AM, Matthieu Baerts wrote:
> Hi Martin,
> 
> Thank you for your reply!
> 
> On 14/08/2024 03:12, Martin KaFai Lau wrote:
>> On 8/5/24 2:52 AM, Matthieu Baerts (NGI0) wrote:
>>> +static int endpoint_init(char *flags)
>>> +{
>>> +    SYS(fail, "ip -net %s link add veth1 type veth peer name veth2",
>>> NS_TEST);
>>> +    SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
>>> +    SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
>>> +    SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
>>> +    SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
>>> +    if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST,
>>> ADDR_2, flags)) {
>>> +        printf("'ip mptcp' not supported, skip this test.\n");
>>> +        test__skip();
>>
>> It is always a skip now in bpf CI:
>>
>> #171/3   mptcp/subflow:SKIP
>>
>> This test is a useful addition for the bpf CI selftest.
>>
>> It can't catch regression if it is always a skip in bpf CI though.
> 
> Indeed, for the moment, this test is skipped in bpf CI.
> 
> The MPTCP CI checks the MPTCP BPF selftests that are on top of net and
> net-next at least once a day. It is always running with the last stable
> version of iproute2, so this test is not skipped:
> 
>     #169/3   mptcp/subflow:OK
> 
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/10384566794/job/28751869426#step:7:11080
> 
>> iproute2 needs to be updated (cc: Daniel Xu and Manu, the outdated
>> iproute2 is something that came up multiple times).
>>
>> Not sure when the iproute2 can be updated. In the mean time, your v3 is
>> pretty close to getting pm_nl_ctl compiled. Is there other blocker on this?
> 
> I will try to find some time to check the modifications I suggested in
> the v3, but I don't know how long it will take to have them ready, as
> they might require some adaptations of the CI side as well, I need to
> check. On the other hand, I understood adding a duplicated version of
> the mptcp.h UAPI header is not an option either.
> 
> So not to block this (already old) series, I thought it would help to
> first focus on this version using 'ip mptcp', while I'm looking at the
> selftests modifications. If these modifications are successful, I can
> always resend the patch 2/3 from the v3 later, and using 'pm_nl_ctl'
> instead of 'ip mptcp', to be able to work with IPRoute2 5.5.
> 
> Do you think that could work like that?

If there is CI started covering it, staying with the 'ip mptcp' is fine.

The bpf CI has to start testing it asap also. The iproute2 package will need to 
be updated on the bpf CI side. I think this has to be done regardless.

It will be useful to avoid the uapi header dup on its own. The last one you have 
seems pretty close.

> 
>>> +        goto fail;
>>> +    }
>>> +
>>> +    return 0;
>>> +fail:
>>> +    return -1;
>>> +}
>>> +
>>> +static int _ss_search(char *src, char *dst, char *port, char *keyword)
>>> +{
>>> +    return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d
>>> | grep -q '%s'",
>>> +              NS_TEST, src, dst, port, PORT_1, keyword);
>>> +}
>>> +
>>> +static int ss_search(char *src, char *keyword)
>>> +{
>>> +    return _ss_search(src, ADDR_1, "dport", keyword);
>>> +}
>>> +
>>> +static void run_subflow(char *new)
>>> +{
>>> +    int server_fd, client_fd, err;
>>> +    char cc[TCP_CA_NAME_MAX];
>>> +    socklen_t len = sizeof(cc);
>>> +
>>> +    server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
>>> +    if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
>>> +        return;
>>> +
>>> +    client_fd = connect_to_fd(server_fd, 0);
>>> +    if (!ASSERT_GE(client_fd, 0, "connect to fd"))
>>> +        goto fail;
>>> +
>>> +    err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
>>> +    if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
>>> +        goto fail;
>>> +
>>> +    send_byte(client_fd);
>>> +
>>> +    ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
>>> +    ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
>>> +    ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
>>> +    ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
>>
>> Is there a getsockopt way instead of ss + grep?
> 
> No there isn't: from the userspace, the app communicates with the MPTCP
> socket, which can have multiple paths (subflows, a TCP socket). To keep
> the compatibility with TCP, [gs]etsockopt() will look at/modify the
> whole MPTCP connection. For example, in some cases, a setsockopt() will
> propagate the option to all the subflows. Depending on the option, the
> modification might only apply to the first subflow, or to the
> user-facing socket.
> 
> For advanced users who want to have different options set to the
> different subflows of an MPTCP connection, they can use BPF: that's what
> is being validated here. In other words, doing a 'getsockopt()' from the
> userspace program here will not show all the different marks and TCP CC
> that can be set per subflow with BPF. We can see that in the test: a
> getsockopt() is done on the MPTCP socket to retrieve the default TCP CC
> ('cc' which is certainly 'cubic'), but we expect to find another one
> ('new' which is 'reno'), set by the BPF program from patch 1/2. I guess
> we could use bpf to do a getsockopt() per subflow, but that's seems a
> bit cheated to have the BPF test program setting something and checking
> if it is set. Here, it is an external way. Because it is done from a

I think the result is valid by having a bpf prog to inspect the value of a sock. 
Inspecting socket is an existing use case. There are many existing bpf tests 
covering this inspection use case to ensure the result is legit. A separate 
cgroup/getsockopt program should help here (more on this below).

> dedicated netns, it sounds OK to do that, no?

Thanks for the explanation. I was hoping there is a way to get to the underlying 
subflow fd. It seems impossible.

In the netns does help here. It is not only about the ss iterating a lot of 
connections or not. My preference is not depending on external tool/shell-ing if 
possible, e.g. to avoid the package update discussion like the iproute2 here. 
The uapi from the testing kernel is always up-to-date. ss is another binary but 
arguably in the same iproute2 package. There is now another extra "grep" and 
pipe here. We had been bitten by different shell behaviors and some arch has 
different shells ...etc.

I think it is ok to take this set as is if you (and Gelang?) are ok to followup 
a "cgroup/getsockopt" way to inspect the subflow as the very next patch to the 
mptcp selftest. It seems inspecting subflow will be a common test going forward 
for mptcp, so it will be beneficial to have a "cgroup/getsockopt" way to inspect 
the subflow directly.

Take a look at a recent example [0]. The mptcp test is under a cgroup already 
and has the cgroup setup. An extra "cgroup/getsockopt" prog should be enough. 
That prog can walk the msk->conn_list and use bpf_rdonly_cast (or the 
bpf_core_cast macro in libbpf) to cast a pointer to tcp_sock for readonly. It 
will allow to inspect all the fields in a tcp_sock.

Something needs to a fix in patch 2(replied separately), so a re-spin is needed.

pw-bot: cr

[0]: https://lore.kernel.org/all/20240808150558.1035626-3-alan.maguire@oracle.com/



