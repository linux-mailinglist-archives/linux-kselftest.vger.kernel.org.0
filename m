Return-Path: <linux-kselftest+bounces-9609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC178BE875
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E76B28F96
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225D16D30C;
	Tue,  7 May 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZOpIzSM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5D1649DA;
	Tue,  7 May 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097758; cv=none; b=VHm7OSHLOhcYJhANCCPpu2+3BkZR2RX0Fvm4kPqYYrx0U7OKQ/63zJWKcrP6WfFyXrS33dgKIKIK1xFlkkjVhr4jfe1uRzFr3Wgu30l1V0Hg8dQtcBIbebcPwXE3mSpURUL3pd8JOCSCNHqOpR2Q1fNPEAlVZJ5vW0BwInQSFjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097758; c=relaxed/simple;
	bh=nwWf43oku86e2innSvDOoVJQyhHvzwCs++ipm8hqsbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cap3nJvj0tB4MKj0yV+ahb7lfKeCMlK5bGNz6s5bJ2ISFihQER/tmvOUjDn6KFNvKeT0p866ctVdyRV4bH5ALAslvXXsXJsRNCY9CTWCy2R/mQJCgjt8i2/p2ty8r9dRUhrzAqxR5MyvU0OuvmvIpW5svhIAapjmuy294BdIeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZOpIzSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D7CC2BBFC;
	Tue,  7 May 2024 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715097757;
	bh=nwWf43oku86e2innSvDOoVJQyhHvzwCs++ipm8hqsbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sZOpIzSM6uihAF2+L2js+eSP8DbgFV0i6mLaYEUHTgRfN/62+qGPaT1y0xTx6V2cG
	 HskidmpdiJCdi1A86YO4RVapEBjOpipUHZouKD2B+1otTpNJKeFceJunbQEkh/R759
	 2JX4R9fnNWAzxsYrI8RZ+KgyXwW2JmdpDdEbhiOE08XYuDxPoQHAXyZCgEUCSFd/ml
	 q5Jx4x0aUjG0vgt2cwDif0WWV7dm/+uz7pN+z2STPSneRJmsHAA0KC+Bg57YkzmK0o
	 iTYLxrZVTGUcnXxY19/ZshZ5u8/sR+3Iv1Eo5qEFgD9PZQZCpw+2R79FMusTF9Mp18
	 1cFN7vogHdY4A==
Message-ID: <d28dec16-9029-42f5-b979-a0f11656a991@kernel.org>
Date: Tue, 7 May 2024 18:02:31 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Add RUN_MPTCP_TEST macro
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Geliang Tang <tanggeliang@kylinos.cn>
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-2-e2bcbdf49857@kernel.org>
 <CAADnVQJ5-APFxMeGsUDSWBsiAbhJGivs=fBUapgYEFNHgnEVeA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAADnVQJ5-APFxMeGsUDSWBsiAbhJGivs=fBUapgYEFNHgnEVeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alexei,

Thank you for the review!

On 07/05/2024 16:44, Alexei Starovoitov wrote:
> On Tue, May 7, 2024 at 3:53 AM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
>>
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> Each MPTCP subtest tests test__start_subtest(suffix), then invokes
>> test_suffix(). It makes sense to add a new macro RUN_MPTCP_TEST to
>> simpolify the code.
>>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>> index baf976a7a1dd..9d1b255bb654 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>> @@ -347,10 +347,14 @@ static void test_mptcpify(void)
>>         close(cgroup_fd);
>>  }
>>
>> +#define RUN_MPTCP_TEST(suffix)                                 \
>> +do {                                                           \
>> +       if (test__start_subtest(#suffix))                       \
>> +               test_##suffix();                                \
>> +} while (0)
> 
> Please no.
> Don't hide it behind macros.

I understand, I'm personally not a big fan of hiding code being a macro
too. This one saves only one line. Geliang added a few more tests in our
tree [1], for a total of 9, so that's only saving 9 lines.

Related to that, if you don't mind, Geliang also added another macro --
MPTCP_SCHED_TEST -- for tests that are currently only in our tree [2]
(not ready yet). We asked him to reduce the size of this macro to the
minimum. We accepted it because it removed quite a lot of similar code
with very small differences [3]. Do you think we should revert this
modification too?

[1]
https://github.com/multipath-tcp/mptcp_net-next/blob/4369d9cbd752e166961ac0db7f85886111606301/tools/testing/selftests/bpf/prog_tests/mptcp.c#L578-L595

[2]
https://github.com/multipath-tcp/mptcp_net-next/blob/4369d9cbd752e166961ac0db7f85886111606301/tools/testing/selftests/bpf/prog_tests/mptcp.c#L559-L576

[3]
https://lore.kernel.org/mptcp/cover.1713321357.git.tanggeliang@kylinos.cn/T/#m0b9c14f1cbae8653c6fd119f6b71d1797961d6ba

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


