Return-Path: <linux-kselftest+bounces-9608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDD08BE82E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDC028BDBA
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA57168B18;
	Tue,  7 May 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPMTml4D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A31649D3;
	Tue,  7 May 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097613; cv=none; b=dwFMtPijXae57ICtZTg8olk66bgmnq7T2//8gbbqfQ0bvFRs/Zy0TJxp6icLlUax2e9jWfkVv8ANphG76NEqTeXBVHrA8Vfn0AkRFNuWvT/K1m86zgbSq50eWKDyYK0kZ09bnYUu5T0zVdTognKXK4ADvHRmzJEi4w+S1oySkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097613; c=relaxed/simple;
	bh=Y5R+jdVdl3nIfGghNCZCSFf/nI98te4Naa50ljeiVSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+LF0L/nxBk5JAu9MSIs6710l62jA6Eiv6ywupRMnsUP66wPSzbl8SYDaK9RGMry7EdUYWj7QfS/78ix7wbtZo+0YRbiLrbQBXeI0udC6hMlJUGzQG1IeIGSatfQHgucXUsu0uUVJDScIDQsVfdDqhJ7P5MvLizkD/zg6U4IrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPMTml4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C75DC2BBFC;
	Tue,  7 May 2024 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715097612;
	bh=Y5R+jdVdl3nIfGghNCZCSFf/nI98te4Naa50ljeiVSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aPMTml4DjnrDVFUNBl5j04oKV4dIwvB/tzzxYbC38/ichYh6n7YLzveS6DXtYUC2n
	 83dVR4PqyrRV8bs8RNpoeiaWH/gBG8P+LoU3xHv2a3AJozno5ojzh+CuERA5tn8Gwu
	 x45OIjtUjEEJjd90MtoZXjL6mAm2RiSrG/j89td6hPiGRhyYzbpKh18t67p5bbsqNj
	 wVl8QvuTnmBg7iro5kG+aY3yybCjRX7ClUYkCbM6Ykw9CEGdogEJNwT4jDEuIF7Cnd
	 XMtXOvshql9U1yF+NVuvz8lf/8WnkK385+pMadg8ZXPGMIs3ah9cQdleHhn65N7HDo
	 kCiir/lWdDBPg==
Message-ID: <e5629ad4-9652-4aa9-ba26-ee7d0df1d1ba@kernel.org>
Date: Tue, 7 May 2024 17:59:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Handle SIGINT when creating
 netns
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
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-1-e2bcbdf49857@kernel.org>
 <CAADnVQKWCVfUhQnoYBoEZaZbfiX8MROcj7Ct-nB4-axhZqMecw@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAADnVQKWCVfUhQnoYBoEZaZbfiX8MROcj7Ct-nB4-axhZqMecw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alexei,

Thank you for the review!

On 07/05/2024 16:43, Alexei Starovoitov wrote:
> On Tue, May 7, 2024 at 3:53 AM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
>>
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> It's necessary to delete netns during the MPTCP bpf tests interrupt,
>> otherwise the next tests run will fail due to unable to create netns.
>>
>> This patch adds a new SIGINT handle sig_int, and deletes NS_TEST in it.
>>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>> index 274d2e033e39..baf976a7a1dd 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>> @@ -64,11 +64,18 @@ struct mptcp_storage {
>>         char ca_name[TCP_CA_NAME_MAX];
>>  };
>>
>> +static void sig_int(int sig)
>> +{
>> +       signal(sig, SIG_IGN);
>> +       SYS_NOFAIL("ip netns del %s", NS_TEST);
>> +}
>> +
>>  static struct nstoken *create_netns(void)
>>  {
>>         SYS(fail, "ip netns add %s", NS_TEST);
>>         SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
>>
>> +       signal(SIGINT, sig_int);
>>         return open_netns(NS_TEST);
> 
> That's a drop in the bucket.
> ctrl-c of test_progs doesn't really work.
> Such clean up needs to be generic as part of network_helpers.c

It makes sense. I can drop this patch and ask Geliang to add a similar
'create_netns()' helper in network_helpers.c creating the netns, and
handling SIGINT. This helper will no longer be specific to MPTCP BPF
selftests then.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


