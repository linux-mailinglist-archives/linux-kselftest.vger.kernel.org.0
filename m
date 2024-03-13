Return-Path: <linux-kselftest+bounces-6307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9587B552
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 00:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3013B21332
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 23:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62055D734;
	Wed, 13 Mar 2024 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B950LDTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA45B20F
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Mar 2024 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373482; cv=none; b=qfT5usPUNMbym1/qyogV/m/emRGVkd2xWDLsI6eEwg46JRYQOTttGThKYlN/4GPV2PdN25pKhjraefywBgnaVALmY0TcQii7w7em8RtG1tBrqp7647nQvtiJDCpy7cvaXVroRlk+RuZLmF05jWN9O2xpVNm2sg9uCRTe1092a/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373482; c=relaxed/simple;
	bh=HD34+N4HmuIBIUoDyYFlYqEAmxFkbtPrHj9GtqwLe3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6gISgvis4QOZ28OtMJH828nVKMOSJhHDw7K1mavPA6cdofxRdWNi3Fek92VRuQX9ZnpVO77m+p49oSSnLbYGtqey+yfhuSrTYhOcEA7OUNRhko/OkTGl1FZtVJ9NqueyHWQw5tqXw4BJyRRR4pErGIBR8fJQmFC+USP7WaJHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B950LDTc; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6da9dc9d-fad6-40f9-91d3-602f87397b47@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710373478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJIpyrb3PHRzKDP68+qCFyuGvH3roDNGt7412UBHY+c=;
	b=B950LDTcgmmMuFK+GObDC0V29wtU0hoZPvbSOzgc1CLMnMcuZI0MtoxwnRDTGQOceS59vj
	m2vD6+U7GGcXlqWM2fGP/KO6+0CZ+fPc0Cbarc2NDzp12oEaYhS5BzWDMde/d3nDqWvwEC
	Hf8PpacFp90wzyjcTD5hzNB4t9xNrj0=
Date: Wed, 13 Mar 2024 16:44:30 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tools/testing/selftests/bpf/test_tc_tunnel.sh: Prevent
 client connect before server bind
Content-Language: en-US
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Cc: Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20240229140000.175274-1-alessandro.carminati@gmail.com>
 <fe323c90-bda3-4837-8daa-372073014446@linux.dev>
 <CAPp5cGR2gFtMh3jWHuFHXdHvLdq85j5qcMPh4EoiOv+JA_HYTw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAPp5cGR2gFtMh3jWHuFHXdHvLdq85j5qcMPh4EoiOv+JA_HYTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/10/24 1:45 AM, Alessandro Carminati wrote:
> Hi Martin,
> Thanks for the review.
> 
> Il giorno ven 8 mar 2024 alle ore 02:03 Martin KaFai Lau
> <martin.lau@linux.dev> ha scritto:
>>
>> On 2/29/24 6:00 AM, Alessandro Carminati (Red Hat) wrote:
>>> In some systems, the netcat server can incur in delay to start listening.
>>> When this happens, the test can randomly fail in various points.
>>> This is an example error message:
>>>      # ip gre none gso
>>>      # encap 192.168.1.1 to 192.168.1.2, type gre, mac none len 2000
>>>      # test basic connectivity
>>>      # Ncat: Connection refused.
>>
>> This explained what is the issue. Please also explain how the patch solves it.
>>
> The issue, as stated, depends on a race condition between the netcat client
> and server. The test author addressed this problem using a sleep, which I
> removed in this patch. To easily solve the issue, one could simply increase
> the sleep duration. However, this patch opts to tackle the problem by
> querying the /proc directory and verifying TCP binds at the specified port
> before letting the client connect.

Please include this in the commit message.

>>>
>>> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
>>> ---
>>>    tools/testing/selftests/bpf/test_tc_tunnel.sh | 19 ++++++++++++++++++-
>>>    1 file changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
>>> index 910044f08908..01c0f4b1a8c2 100755
>>> --- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
>>> +++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
>>> @@ -72,7 +72,6 @@ cleanup() {
>>>    server_listen() {
>>>        ip netns exec "${ns2}" nc "${netcat_opt}" -l "${port}" > "${outfile}" &
>>>        server_pid=$!
>>> -     sleep 0.2
>>>    }
>>>
>>>    client_connect() {
>>> @@ -93,6 +92,22 @@ verify_data() {
>>>        fi
>>>    }
>>>
>>> +wait_for_port() {
>>> +     local digits=8
>>> +     local port2check=$(printf ":%04X" $1)
>>> +     local prot=$([ "$2" == "-6" ] && echo 6 && digits=32)
>>> +
>>> +     for i in $(seq 20); do
>>> +             if ip netns exec "${ns2}" cat /proc/net/tcp${prot} | \
>>> +                     sed -r 's/^[ \t]+[0-9]+: ([0-9A-F]{'${digits}'}:[0-9A-F]{4}) .*$/\1/' | \
>>> +                     grep -q "${port2check}"; then
>>
>> The idea is to check if there is socket listening on port 8888?
>>
>> May be something simpler like "ss -OHtl src :$1" instead?
> Indeed, the aim is to ensure that the server is bound before the
> client attempts to
> connect by checking if socket is listening, and yes using 'ss' would be shorter.
> However, I chose not to use 'ss' or 'netstat' to avoid adding new dependencies,
> considering they are already many.

ss should be in the same iproute package that "(ip) netns..." lives in also. The 
above changes added sed and grep.

Regardless, this external dependency will be all gone once moved to the 
selftests/test_progs. The check-and-wait will be gone by creating a listen fd 
instead of using "nc -l...". A simpler change such that people doing the future 
test_progs migration will have an easier time.

>> The check-and-wait fix in this patch is fine to get your test environment going.
>>
>> Eventually, it will be good to see the test_tc_tunnel.sh test moved to
>> test_progs. The test_tc_tunnel.sh is not run by bpf CI and issue like this got
>> unnoticed. Some other "*.sh" tests have already been moved to test_progs.
.>>
>>
> Regards
> Alessandro


